Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15472FA09A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391382AbhARM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390465AbhARM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610974535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPe5km8P4/J3b/UQWJza5OrI9DrtBInJ5nrm44CAXGU=;
        b=RWkR3QI4gJ82mnbyBnYmU6jb/BXV/Cf5VUPkjswK5LgyFlEOTMZD4rt/YvPq0Ui8f/S9H1
        ANLL7H0NQtNFdJSvs/JLmukjxFvZhUzj0a+S57EbqiFLqAbVEvLHoFK7p0Fg4nPSqdghCu
        6+/RHJcFzvaJBM+N4AlHd0aQGvEl+qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-vcJ_cqX9M8qOSE0IoHA2bQ-1; Mon, 18 Jan 2021 07:55:33 -0500
X-MC-Unique: vcJ_cqX9M8qOSE0IoHA2bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF2B107ACE3;
        Mon, 18 Jan 2021 12:55:31 +0000 (UTC)
Received: from krava (unknown [10.40.195.226])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2E3645D9CD;
        Mon, 18 Jan 2021 12:55:28 +0000 (UTC)
Date:   Mon, 18 Jan 2021 13:55:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCHv2 00/22] perf tools: Add daemon command
Message-ID: <20210118125527.GA1645107@krava>
References: <20210102220441.794923-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102220441.794923-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping, any reviews?

thanks,
jirka

On Sat, Jan 02, 2021 at 11:04:19PM +0100, Jiri Olsa wrote:
> hi,
> we were asked for possibility to be able run record
> sessions on background.
> 
> This patchset adds support to configure and run record
> sessions on background via new 'perf daemon' command.
> 
> Please check below the example on usage.
> 
> The patchset is based on following control changes:
>   https://lore.kernel.org/lkml/20201226232038.390883-1-jolsa@kernel.org/
> 
> Available also here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/daemon
> 
> v2 changes:
>   - switch options to sub-commands [Namhyung]
>   - use signalfd to track on sessions [Alexei]
>   - use stop command to stop sessions [Alexei]
>   - couple minor fixes [Alexei]
>   - more detailed changelogs [Arnaldo]
>   - added tests
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (22):
>       perf tools: Make perf_config_from_file static
>       perf tools: Add config set interface
>       perf tools: Add debug_set_display_time function
>       perf tools: Add perf_home_perfconfig function
>       perf tools: Make perf_config_system global
>       perf tools: Make perf_config_global gobal
>       perf daemon: Add daemon command
>       perf daemon: Add config file change check
>       perf daemon: Add signalfd support
>       perf daemon: Add signal command
>       perf daemon: Add stop command
>       perf daemon: Allow only one daemon over base directory
>       perf daemon: Set control fifo for session
>       perf daemon: Add ping command
>       perf daemon: Use control to stop session
>       perf daemon: Add up time for daemon/session list
>       perf daemon: Add man page for perf-daemon
>       perf test: Add daemon list command test
>       perf test: Add daemon reconfig test
>       perf test: Add daemon stop command test
>       perf test: Add daemon signal command test
>       perf test: Add daemon ping command test
> 
>  tools/perf/Build                         |    1 +
>  tools/perf/Documentation/perf-config.txt |   14 ++
>  tools/perf/Documentation/perf-daemon.txt |  187 ++++++++++++++++
>  tools/perf/builtin-daemon.c              | 1327 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin.h                     |    1 +
>  tools/perf/command-list.txt              |    1 +
>  tools/perf/perf.c                        |    1 +
>  tools/perf/tests/shell/daemon.sh         |  388 ++++++++++++++++++++++++++++++++
>  tools/perf/util/config.c                 |  123 +++++++----
>  tools/perf/util/config.h                 |    7 +-
>  tools/perf/util/debug.c                  |   34 ++-
>  tools/perf/util/debug.h                  |    1 +
>  12 files changed, 2037 insertions(+), 48 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-daemon.txt
>  create mode 100644 tools/perf/builtin-daemon.c
>  create mode 100755 tools/perf/tests/shell/daemon.sh
> 
> 
> ---
> Example with 2 record sessions:
> 
>   # cat ~/.perfconfig
>   [daemon]
>   base=/opt/perfdata
> 
>   [session-cycles]
>   run = -m 10M -e cycles --overwrite --switch-output -a
> 
>   [session-sched]
>   run = -m 20M -e sched:* --overwrite --switch-output -a
> 
> 
> Starting the daemon:
> 
>   # perf daemon start
> 
> 
> Check sessions:
> 
>   # perf daemon
>   [603349:daemon] base: /opt/perfdata
>   [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
>   [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
> 
> First line is daemon process info with configured daemon base.
> 
> 
> Check sessions with more info:
> 
>   # perf daemon -v
>   [603349:daemon] base: /opt/perfdata
>     output:  /opt/perfdata/output
>     lock:    /opt/perfdata/lock
>     up:      1 minutes
>   [603350:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
>     base:    /opt/perfdata/session-cycles
>     output:  /opt/perfdata/session-cycles/output
>     control: /opt/perfdata/session-cycles/control
>     ack:     /opt/perfdata/session-cycles/ack
>     up:      1 minutes
>   [603351:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
>     base:    /opt/perfdata/session-sched
>     output:  /opt/perfdata/session-sched/output
>     control: /opt/perfdata/session-sched/control
>     ack:     /opt/perfdata/session-sched/ack
>     up:      1 minutes
> 
> The 'base' path is daemon/session base.
> The 'lock' file is daemon's lock file guarding that no other
> daemon is running on top of the base.
> The 'output' file is perf record output for specific session.
> The 'control' and 'ack' files are perf control files.
> The 'up' number shows minutes daemon/session is running.
> 
> 
> Make sure control session is online:
> 
>   # perf daemon ping
>   OK   cycles
>   OK   sched
> 
> 
> Send USR2 signal to session 'cycles' to generate perf.data file:
> 
>   # perf daemon signal --session cycles
>   signal 12 sent to session 'cycles [603452]'
> 
>   # tail -2  /opt/perfdata/session-cycles/output
>   [ perf record: dump data: Woken up 1 times ]
>   [ perf record: Dump perf.data.2020123017013149 ]
> 
> 
> Send USR2 signal to all sessions:
> 
>   # perf daemon signal
>   signal 12 sent to session 'cycles [603452]'
>   signal 12 sent to session 'sched [603453]'
> 
>   # tail -2  /opt/perfdata/session-cycles/output
>   [ perf record: dump data: Woken up 1 times ]
>   [ perf record: Dump perf.data.2020123017024689 ]
>   # tail -2  /opt/perfdata/session-sched/output
>   [ perf record: dump data: Woken up 1 times ]
>   [ perf record: Dump perf.data.2020123017024713 ]
> 
> 
> Stop daemon:
> 
>   # perf daemon stop
> 

