Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF0A2E88D8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbhABWGn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:43 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:22024 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726737AbhABWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:41 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-jT8CpJ9pOQ2WES955Ac6Vg-1; Sat, 02 Jan 2021 17:05:43 -0500
X-MC-Unique: jT8CpJ9pOQ2WES955Ac6Vg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E697C287;
        Sat,  2 Jan 2021 22:05:42 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7296919727;
        Sat,  2 Jan 2021 22:05:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 17/22] perf daemon: Add man page for perf-daemon
Date:   Sat,  2 Jan 2021 23:04:36 +0100
Message-Id: <20210102220441.794923-18-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-1-jolsa@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding man page for perf-daemon usage.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-config.txt |  14 ++
 tools/perf/Documentation/perf-daemon.txt | 187 +++++++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c3ce48f1b379..153bde14bbe0 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -703,6 +703,20 @@ auxtrace.*::
 		If the directory does not exist or has the wrong file type,
 		the current directory is used.
 
+daemon.*::
+
+	daemon.base::
+		Base path for daemon data. All sessions data are stored under
+		this path.
+
+session-<NAME>.*::
+
+	session-<NAME>.run::
+
+		Defines new record session for daemon. The value is record's
+		command line without the 'record' keyword.
+
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index e69de29bb2d1..b0e1015476c2 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -0,0 +1,187 @@
+perf-daemon(1)
+==============
+
+NAME
+----
+perf-daemon - Run record sessions on background
+
+SYNOPSIS
+--------
+[verse]
+'perf daemon'
+'perf daemon' [<options>]
+'perf daemon start'  [<options>]
+'perf daemon stop'   [<options>]
+'perf daemon signal' [<options>]
+'perf daemon ping'   [<options>]
+
+
+DESCRIPTION
+-----------
+This command allows to run simple daemon process that starts and
+monitors configured record sessions.
+
+Each session represents one perf record process started with
+control setup (with perf record --control.. options).
+
+These sessions are configured through config file, see CONFIG FILE
+section with EXAMPLES.
+
+
+OPTIONS
+-------
+--config=<PATH>::
+	Config file path, if not perf will check system and default
+	locations (/etc/perfconfig, $HOME/.perfconfig).
+
+-v::
+--verbose::
+	Be more verbose.
+
+
+All generic options are available also under commands.
+
+
+START COMMAND
+-------------
+The start command creates the daemon process.
+
+-f::
+--foreground::
+	Do not put the process in background.
+
+
+STOP COMMAND
+------------
+The stop command stops all the session and the daemon process.
+
+
+SIGNAL COMMAND
+--------------
+The signal command sends signal to configured sessions.
+
+--session::
+	Send signal to specific session.
+
+
+PING COMMAND
+------------
+The ping command sends control ping to configured sessions.
+
+--session::
+	Send ping to specific session.
+
+
+CONFIG FILE
+-----------
+The daemon is configured within standard perf config file by
+following new variables:
+
+daemon.base:
+	Base path for daemon data. All sessions data are
+	stored under this path.
+
+session-<NAME>.run:
+	Defines new record session. The value is record's command
+	line without the 'record' keyword.
+
+Each perf record session is run in daemon.base/<NAME> directory.
+
+
+EXAMPLES
+--------
+Example with 2 record sessions:
+
+  # cat ~/.perfconfig
+  [daemon]
+  base=/opt/perfdata
+
+  [session-cycles]
+  run = -m 10M -e cycles --overwrite --switch-output -a
+
+  [session-sched]
+  run = -m 20M -e sched:* --overwrite --switch-output -a
+
+
+Starting the daemon:
+
+  # perf daemon start
+
+
+Check sessions:
+
+  # perf daemon
+  [603349:daemon] base: /opt/perfdata
+  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
+  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
+
+First line is daemon process info with configured daemon base.
+
+
+Check sessions with more info:
+
+  # perf daemon -v
+  [603349:daemon] base: /opt/perfdata
+    output:  /opt/perfdata/output
+    lock:    /opt/perfdata/lock
+    up:      1 minutes
+  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
+    base:    /opt/perfdata/session-cycles
+    output:  /opt/perfdata/session-cycles/output
+    control: /opt/perfdata/session-cycles/control
+    ack:     /opt/perfdata/session-cycles/ack
+    up:      1 minutes
+  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
+    base:    /opt/perfdata/session-sched
+    output:  /opt/perfdata/session-sched/output
+    control: /opt/perfdata/session-sched/control
+    ack:     /opt/perfdata/session-sched/ack
+    up:      1 minutes
+
+The 'base' path is daemon/session base.
+The 'lock' file is daemon's lock file guarding that no other
+daemon is running on top of the base.
+The 'output' file is perf record output for specific session.
+The 'control' and 'ack' files are perf control files.
+The 'up' number shows minutes daemon/session is running.
+
+
+Make sure control session is online:
+
+  # perf daemon ping
+  OK   cycles
+  OK   sched
+
+
+Send USR2 signal to session 'cycles' to generate perf.data file:
+
+  # perf daemon signal --session cycles
+  signal 12 sent to session 'cycles [603452]'
+
+  # tail -2  /opt/perfdata/session-cycles/output
+  [ perf record: dump data: Woken up 1 times ]
+  [ perf record: Dump perf.data.2020123017013149 ]
+
+
+Send USR2 signal to all sessions:
+
+  # perf daemon signal
+  signal 12 sent to session 'cycles [603452]'
+  signal 12 sent to session 'sched [603453]'
+
+  # tail -2  /opt/perfdata/session-cycles/output
+  [ perf record: dump data: Woken up 1 times ]
+  [ perf record: Dump perf.data.2020123017024689 ]
+  # tail -2  /opt/perfdata/session-sched/output
+  [ perf record: dump data: Woken up 1 times ]
+  [ perf record: Dump perf.data.2020123017024713 ]
+
+
+Stop daemon:
+
+  # perf daemon stop
+
+
+SEE ALSO
+--------
+linkperf:perf-record[1], linkperf:perf-config[1]
-- 
2.26.2

