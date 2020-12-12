Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8432D85F8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407371AbgLLKpE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:45:04 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:42878 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407359AbgLLKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:04 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-pA80Mip4PumNsufpWgvXWA-1; Sat, 12 Dec 2020 05:44:06 -0500
X-MC-Unique: pA80Mip4PumNsufpWgvXWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22036107ACE3;
        Sat, 12 Dec 2020 10:44:04 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F4837086D;
        Sat, 12 Dec 2020 10:43:59 +0000 (UTC)
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
Subject: [RFC 0/8] perf tools: Add daemon command
Date:   Sat, 12 Dec 2020 11:43:50 +0100
Message-Id: <20201212104358.412065-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
sessions on background, sending the first stab on it
to gather more info.

This patchset adds support to configure and run record
sessions on background via new 'perf daemon' command.

Please check below the example on usage.

Available also here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/daemon

thoughts? ;-)

thanks,
jirka


---
Jiri Olsa (8):
      perf tools: Add debug_set_file function
      perf tools: Add debug_set_display_time function
      perf tools: Add config set interface
      perf daemon: Add daemon command
      perf daemon: Add signal command
      perf daemon: Add stop command
      perf daemon: Allow only one daemon over base directory
      perf daemon: Set control fifo for session

 tools/perf/Build                         |   3 +
 tools/perf/Documentation/perf-daemon.txt | 135 +++++++++++++++++
 tools/perf/builtin-daemon.c              | 916 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin.h                     |   1 +
 tools/perf/command-list.txt              |   1 +
 tools/perf/perf.c                        |   1 +
 tools/perf/util/config.c                 |  28 +++-
 tools/perf/util/config.h                 |   3 +
 tools/perf/util/debug.c                  |  41 ++++-
 tools/perf/util/debug.h                  |   3 +
 10 files changed, 1124 insertions(+), 8 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-daemon.txt
 create mode 100644 tools/perf/builtin-daemon.c


---
Example with that runs 2 record sessions:

  # cat config.daemon
  [daemon]
  base=/opt/perfdata

  [session-1]
  run = -m 10M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a

  [session-2]
  run = -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a


Default perf config has the same daemon base:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata


Starting the daemon:

  # perf daemon --config config.daemon


Check sessions:

  # perf daemon
  [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
  [2:92188] perf record -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a

Check sessions with more info:

  # perf daemon -v
  [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
    output:  /opt/perfdata/1/output
    control: /opt/perfdata/1/control
    ack:     /opt/perfdata/1/ack
  [2:92188] perf record -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
    output:  /opt/perfdata/2/output
    control: /opt/perfdata/2/control
    ack:     /opt/perfdata/2/ack

The 'output' file is perf record output for specific session.
The 'control' and 'ack' files are perf control files.


Send SIGUSR2 signal to all sessions:

  # perf daemon -s
  signal 12 sent to session '1 [92187]'
  signal 12 sent to session '2 [92188]'

Send SIGUSR2 signal to session '1':

  # perf daemon --signal=1
  signal 12 sent to session '1 [364758]'

And check that the perf data dump was trigered:

  # cat /opt/perfdata/2/output
  rounding mmap pages size to 32M (8192 pages)
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump /opt/perfdata/2/perf.data.2020120715220385 ]


Stop daemon:

  # perf daemon --stop
  perf daemon is exciting

