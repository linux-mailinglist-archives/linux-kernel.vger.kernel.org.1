Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400822D1A0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgLGTxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgLGTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607370712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hoHm67lT1rUAyo2FbAvC9vsgAeEapoCljghveF2Ra3w=;
        b=TwL0fYMjQEKpABRei08ErtOVm2QyH/qfoYd3aZFxdwHRC8zJwgnTqQs0VLkmcNwh0ZawJj
        eboBbqPaNmtrgESLYfEHl3YDyDXlUfrLBJClk52J5SYKqSDlrNtgItw893XyCDd8R9OzYm
        ZmmjE7gZhHLOoSWUEqGEw7i1M+Tbs2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-ECvP0KF4PTy-8vITan9Zqw-1; Mon, 07 Dec 2020 14:51:49 -0500
X-MC-Unique: ECvP0KF4PTy-8vITan9Zqw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 076801005513;
        Mon,  7 Dec 2020 19:51:48 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D8B160BE2;
        Mon,  7 Dec 2020 19:51:44 +0000 (UTC)
Date:   Mon, 7 Dec 2020 20:51:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 3/3] perf tools: Allow to list events via control file
Message-ID: <20201207195142.GA4103648@krava>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-4-jolsa@kernel.org>
 <20201207162806.GE125383@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207162806.GE125383@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 01:28:06PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> >     sched:sched_stick_numa
> >     sched:sched_swap_numa
> >     sched:sched_wake_idle_without_ipi
> >     dummy:HG
> > 
> > This new command is handy to get real event names when
> > wildcards are used.
> 
> Ok, would be nice to have a verbose mode like:
> 
> [acme@five ~]$ sudo ~acme/bin/perf record -e 'sched:*' sleep 0.001
> [ perf record: Woken up 14 times to write data ]
> [ perf record: Captured and wrote 0.023 MB perf.data (16 samples) ]
> [acme@five ~]$ sudo ~acme/bin/perf evlist
> sched:sched_kthread_stop
> sched:sched_kthread_stop_ret
> sched:sched_waking
> sched:sched_wakeup
> sched:sched_wakeup_new
> sched:sched_switch
> sched:sched_migrate_task
> sched:sched_process_free
> sched:sched_process_exit
> sched:sched_wait_task
> sched:sched_process_wait
> sched:sched_process_fork
> sched:sched_process_exec
> sched:sched_stat_wait
> sched:sched_stat_sleep
> sched:sched_stat_iowait
> sched:sched_stat_blocked
> sched:sched_stat_runtime
> sched:sched_pi_setprio
> sched:sched_move_numa
> sched:sched_stick_numa
> sched:sched_swap_numa
> sched:sched_wake_idle_without_ipi
> # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
> [acme@five ~]$ sudo ~acme/bin/perf evlist -v
> sched:sched_kthread_stop: type: 2, size: 120, config: 0x13f, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1

yea, hopefuly we won't be surprised what's enabled live in evsel ;-)

SNIP

> sched:sched_wake_idle_without_ipi: type: 2, size: 120, config: 0x129, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ID|CPU|PERIOD|RAW, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
> # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
> [acme@five ~]$
> 
> Also I think we should use 'evlist' instead of 'list', to be consistent.

ok, makes sense

thanks,
jirka

