Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD3E2E88C8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbhABWFr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:05:47 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:49719 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbhABWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:05:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-EO5_ncr4P-ObdA2b1xQVhA-1; Sat, 02 Jan 2021 17:04:47 -0500
X-MC-Unique: EO5_ncr4P-ObdA2b1xQVhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B80959;
        Sat,  2 Jan 2021 22:04:45 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53CF819481;
        Sat,  2 Jan 2021 22:04:42 +0000 (UTC)
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
Subject: [PATCHv2 00/22] perf tools: Add daemon command
Date:   Sat,  2 Jan 2021 23:04:19 +0100
Message-Id: <20210102220441.794923-1-jolsa@kernel.org>
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

hi,
we were asked for possibility to be able run record
sessions on background.

This patchset adds support to configure and run record
sessions on background via new 'perf daemon' command.

Please check below the example on usage.

The patchset is based on following control changes:
  https://lore.kernel.org/lkml/20201226232038.390883-1-jolsa@kernel.org/

Available also here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/daemon

v2 changes:
  - switch options to sub-commands [Namhyung]
  - use signalfd to track on sessions [Alexei]
  - use stop command to stop sessions [Alexei]
  - couple minor fixes [Alexei]
  - more detailed changelogs [Arnaldo]
  - added tests

thanks,
jirka


---
Jiri Olsa (22):
      perf tools: Make perf_config_from_file static
      perf tools: Add config set interface
      perf tools: Add debug_set_display_time function
      perf tools: Add perf_home_perfconfig function
      perf tools: Make perf_config_system global
      perf tools: Make perf_config_global gobal
      perf daemon: Add daemon command
      perf daemon: Add config file change check
      perf daemon: Add signalfd support
      perf daemon: Add signal command
      perf daemon: Add stop command
      perf daemon: Allow only one daemon over base directory
      perf daemon: Set control fifo for session
      perf daemon: Add ping command
      perf daemon: Use control to stop session
      perf daemon: Add up time for daemon/session list
      perf daemon: Add man page for perf-daemon
      perf test: Add daemon list command test
      perf test: Add daemon reconfig test
      perf test: Add daemon stop command test
      perf test: Add daemon signal command test
      perf test: Add daemon ping command test

 tools/perf/Build                         |    1 +
 tools/perf/Documentation/perf-config.txt |   14 ++
 tools/perf/Documentation/perf-daemon.txt |  187 ++++++++++++++++
 tools/perf/builtin-daemon.c              | 1327 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin.h                     |    1 +
 tools/perf/command-list.txt              |    1 +
 tools/perf/perf.c                        |    1 +
 tools/perf/tests/shell/daemon.sh         |  388 ++++++++++++++++++++++++++++++++
 tools/perf/util/config.c                 |  123 +++++++----
 tools/perf/util/config.h                 |    7 +-
 tools/perf/util/debug.c                  |   34 ++-
 tools/perf/util/debug.h                  |    1 +
 12 files changed, 2037 insertions(+), 48 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-daemon.txt
 create mode 100644 tools/perf/builtin-daemon.c
 create mode 100755 tools/perf/tests/shell/daemon.sh


---
Example with 2 record sessions:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata

  [session-cycles]
  run = -m 10M -e cycles --overwrite --switch-output -a

  [session-sched]
  run = -m 20M -e sched:* --overwrite --switch-output -a


Starting the daemon:

  # perf daemon start


Check sessions:

  # perf daemon
  [603349:daemon] base: /opt/perfdata
  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a

First line is daemon process info with configured daemon base.


Check sessions with more info:

  # perf daemon -v
  [603349:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
    lock:    /opt/perfdata/lock
    up:      1 minutes
  [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
    base:    /opt/perfdata/session-cycles
    output:  /opt/perfdata/session-cycles/output
    control: /opt/perfdata/session-cycles/control
    ack:     /opt/perfdata/session-cycles/ack
    up:      1 minutes
  [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
    base:    /opt/perfdata/session-sched
    output:  /opt/perfdata/session-sched/output
    control: /opt/perfdata/session-sched/control
    ack:     /opt/perfdata/session-sched/ack
    up:      1 minutes

The 'base' path is daemon/session base.
The 'lock' file is daemon's lock file guarding that no other
daemon is running on top of the base.
The 'output' file is perf record output for specific session.
The 'control' and 'ack' files are perf control files.
The 'up' number shows minutes daemon/session is running.


Make sure control session is online:

  # perf daemon ping
  OK   cycles
  OK   sched


Send USR2 signal to session 'cycles' to generate perf.data file:

  # perf daemon signal --session cycles
  signal 12 sent to session 'cycles [603452]'

  # tail -2  /opt/perfdata/session-cycles/output
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020123017013149 ]


Send USR2 signal to all sessions:

  # perf daemon signal
  signal 12 sent to session 'cycles [603452]'
  signal 12 sent to session 'sched [603453]'

  # tail -2  /opt/perfdata/session-cycles/output
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020123017024689 ]
  # tail -2  /opt/perfdata/session-sched/output
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020123017024713 ]


Stop daemon:

  # perf daemon stop

