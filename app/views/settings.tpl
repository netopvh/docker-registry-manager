{{template "base/base.html" .}}
{{define "body"}}
<div class="right-content-container">
  <div class="header">
    <ol class="breadcrumb">
      <li>
        <a href="/">Home</a>
      </li>
      <li class="active">Settings</li>
    </ol>
  </div>
  <div class="row">
    <div class="col-md-12">
      <h1>About</h1>
    </div>
  </div>
  <div class="content-block white-bg">
    <div class="pull-right">
      <a href="https://github.com/snagles/docker-registry-manager"><img src="https://img.shields.io/github/stars/snagles/docker-registry-manager.svg?style=social&amp;label=Star" alt="GitHub stars"/></a>
      <a href="https://github.com/snagles/docker-registry-manager/issues"><img src="https://img.shields.io/github/issues-raw/snagles/docker-registry-manager.svg" alt="GitHub issues"/></a>
      <a href="https://raw.githubusercontent.com/snagles/docker-registry-manager/master/LICENSE"><img src="https://img.shields.io/github/license/mashape/apistatus.svg" alt="license"></a>
    </div>
    <div class="row">
      <table class="table table-striped table-bordered">
        <thead>
          <tr>
            <th>Service</th>
            <th>Master</th>
            <th>Develop</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Status</td>
            <td>
              <a href="https://github.com/snagles/docker-registry-manager/tree/master"><img src="https://travis-ci.org/snagles/docker-registry-manager.svg?branch=master" alt="Build Status" /></a>
            </td>
            <td>
              <a href="https://github.com/snagles/docker-registry-manager/tree/develop"><img src="https://travis-ci.org/snagles/docker-registry-manager.svg?branch=develop" alt="Build Status" /></a>
            </td>
          </tr>
          <tr>
            <td>Coverage</td>
            <td>
              <a href="https://codecov.io/gh/snagles/docker-registry-manager">
              <img src="https://codecov.io/gh/snagles/docker-registry-manager/branch/master/graph/badge.svg" alt="Coverage Status"></a>
            </td>
            <td>
              <a href="https://codecov.io/gh/snagles/docker-registry-manager">
              <img src="https://codecov.io/gh/snagles/docker-registry-manager/branch/develop/graph/badge.svg" alt="Coverage Status"></a>
            </td>
          </tr>
          <tr>
            <td>Documentation</td>
            <td>
              <a href="https://godoc.org/github.com/snagles/docker-registry-manager">
              <img src="https://godoc.org/github.com/snagles/docker-registry-manager?status.svg" alt="GoDoc"></a>
            </td>
            <td>
              <a href="https://godoc.org/github.com/snagles/docker-registry-manager">
              <img src="https://godoc.org/github.com/snagles/docker-registry-manager?status.svg" alt="GoDoc"></a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <h1>Statistics</h1>
    </div>
  </div>
  <div class="content-block white-bg">
    <div class="row">
      <ul class="nav nav-tabs" role="tablist" style="margin-bottom:20px;">
        <li role="presentation" class="active">
          <a href="#stats" aria-controls="overview" role="tab" data-toggle="tab">Requests</a>
        </li>
      </ul>
      <div role="tabpanel" class="tab-pane" id="stats">
        <table id="stats-datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
          <thead>
            <tr>
              <th>Method</th>
              <th>Request URL</th>
              <th>Average Time</th>
              <th>Max Time</th>
              <th>Min Time</th>
              <th>Total Time</th>
              <th>Request Count</th>
            </tr>
          </thead>
          <tbody></tbody>
          <tfoot>
            <tr>
              <th>Method</th>
              <th>Request URL</th>
              <th>Average Time</th>
              <th>Max Time</th>
              <th>Min Time</th>
              <th>Total Time</th>
              <th>Request Count</th>
            </tr>
          </tfoot>
        </table>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <h1>Logs</h1>
    </div>
  </div>
  <div class="content-block white-bg" id="logs">
    <table id="log-table" class="table table-striped table-bordered" cellspacing="0" width="100%">
      <thead>
        <tr>
          <th>Level</th>
          <th>Message</th>
          <th>File</th>
          <th>Line</th>
          <th>Time</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <th>Level</th>
          <th>Message</th>
          <th>File</th>
          <th>Line</th>
          <th>Time</th>
        </tr>
      </tfoot>
    </table>
  </div>
</div>

<script>
  $(document).ready(function() {
    // Get the stats data table stats
    $.getJSON("/settings/stats", function(data) {
      $.each(data, function(i, item) {
        var $tr = $('<tr>').append($("<td>").text(item.method), $('<td>').text(item.request_url), $('<td data-order=' + item.avg_s + '>').text(item.avg_time), $('<td data-order=' + item.max_s + '>').text(item.max_time), $(
          '<td data-order=' + item.min_s + '>').text(item.min_time), $('<td data-order=' + item.total_s + '>').text(item.total_time), $('<td>').text(item.times)).appendTo('#stats-datatable');
      });
      $('#stats-datatable').DataTable({
        "order": [
          [2, "desc"]
        ],
        "pageLength": 10
      });
    });

    var table = $('#log-table').DataTable({
      "ajax": {
        url: '/logs',
        dataSrc: ''
      },
      "order": [
        [2, "desc"]
      ],
      "pageLength": 10,
      "columns": [{
        "data": "level"
      }, {
        "data": "msg"
      }, {
        "data": "file"
      }, {
        "data": "line"
      }, {
        "data": "time"
      }],
      dom: "<'row'<'col-sm-3'l><'col-sm-6'B><'col-sm-3'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",
      buttons: [{
        text: '<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="fa fa-edit"></i> Log Level: <span id="active-level">{{.activeLevel}} </span><span class="caret"> </span></button> <ul class="dropdown-menu" aria-labelledby="dropdownMenu1"> {{ range $i, $level :=.allLevels }} <li><a class="dropdown-item" data-level="{{$level}}" href="#">{{$level}}</a></li> {{ end }} </ul>',
      }, {
        text: '<button id="archive-logs" type="button" class="btn btn-default btn-group" style="margin-right:5px"><i class="fa fa-archive"></i> Archive Logs</button>',
        action: function(e, dt, node, config) {
          e.preventDefault();
          $.ajax({
            type: "POST",
            url: "/logs/archive",
            success: function(result) {
              table.ajax.reload();
              $("#logs").append("<div class='alert alert-success'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a> <strong>Success!</strong> Archived logs in /logs. </div>");
              $(".alert").alert();
              window.setTimeout(function() {
                $(".alert").alert('close');
              }, 5000);
            }
          });
        }
      }, {
        text: '<button href="/logs" download="logs.json" class="btn btn-default btn-group" style="margin-right:5px" download><i class="fa fa-download"></i> Download Logs</button>',
      }, {
        text: '<button id="clear-logs" type="button" class="btn btn-danger btn-group"><i class="fa fa-trash"></i> Clear Logs</button>',
        action: function(e, dt, node, config) {
          e.preventDefault();
          $.ajax({
            type: "DELETE",
            url: "/logs",
            success: function(result) {
              table.ajax.reload();
              $("#logs").append("<div class='alert alert-success'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a> <strong>Success!</strong> Cleared logs. </div>");
              $(".alert").alert();
              window.setTimeout(function() {
                $(".alert").alert('close');
              }, 5000);
            }
          });
        }
      }]
    });
    $('.dropdown-item').click(function(e) {
      e.preventDefault();
      var level = $(this).attr("data-level");
      $.ajax({
        type: "POST",
        url: "/logs/level/" + level,
        success: function(result) {
          $("#logs").append("<div class='alert alert-success'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a> <strong>Success!</strong> Updated log level to "+level+". </div>");
          $("#active-level").text(level +" ");
          $(".alert").alert();
          window.setTimeout(function() {
            $(".alert").alert('close');
          }, 5000);
        }
      });
    });
  });

</script>
{{ end }}
