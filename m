Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7372FBDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391539AbhASRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390732AbhASRgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611077690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3WQQsn0c0F55IyRwlGbgw2P5nPc25LQ9ou/ENxcllQ=;
        b=ijUG/MR+KXc238jK18Zzq55gR7rF86hnntSndk2LMS2X9z27ofNQ3bdHRnBj0K7COCDzu2
        evp+bagmCa/l2OiUOzYa8xlqeRXvFUL2s21kVN12Gh497td/RYzkSeku7ivgsfGWwEX6Xa
        FUsw7a9RqBCjfXCdzXDyRPy/hRuuOx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-4qB93kqFMEmALvaVD9YgRA-1; Tue, 19 Jan 2021 12:34:48 -0500
X-MC-Unique: 4qB93kqFMEmALvaVD9YgRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF3AE107ACE3;
        Tue, 19 Jan 2021 17:34:45 +0000 (UTC)
Received: from krava (unknown [10.40.195.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id 48C1660C0F;
        Tue, 19 Jan 2021 17:34:43 +0000 (UTC)
Date:   Tue, 19 Jan 2021 18:34:42 +0100
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
Subject: Re: [PATCH 1/4] perf tools: Allow to enable/disable events via
 control file
Message-ID: <20210119173442.GA1717058@krava>
References: <20201226232038.390883-1-jolsa@kernel.org>
 <20201226232038.390883-2-jolsa@kernel.org>
 <20210119141637.GH12699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119141637.GH12699@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:16:37AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> >   terminal 2:
> >     bash 33349 [034] 149632.228023: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34059
> >     bash 33349 [034] 149632.228050:   sched:sched_wakeup_new: bash:34059 [120] success=1 CPU:036
> >     bash 33349 [034] 149633.950005: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34060
> >     bash 33349 [034] 149633.950030:   sched:sched_wakeup_new: bash:34060 [120] success=1 CPU:036
> 
> 'disable' doesn't seem to be working:
> 
> Terminal 3:
> 
> [root@five ~]# echo 'enable sched:sched_process_fork' > control
> [root@five ~]# echo 'disable sched:sched_process_fork' > control
> [root@five ~]# echo 'disable' > control
> [root@five ~]# echo 'disable sched:sched_process_fork' > control
> [root@five ~]# echo 'disable sched:sched_process_fork' > control
> [root@five ~]# echo 'enable sched:sched_process_fork' > control
> [root@five ~]# echo 'disable sched:sched_process_fork' > control
> [root@five ~]# echo 'enable sched:sched_process_fork' > control
> [root@five ~]# echo 'disable sched:sched_process_fork' > control
> [root@five ~]# echo 'enable' > control
> [root@five ~]# echo 'disable' > control
> [root@five ~]# echo 'disable' > control
> [root@five ~]# echo 'disable' > control
> [root@five ~]#
> 
> Terminal 1:
> 
> [root@five ~]# perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' > perf.pipe
> Events disabled
> Event sched:sched_process_fork enabled
> Event sched:sched_process_fork disabled
> Event sched:sched_process_fork enabled
> Event sched:sched_process_fork disabled
> Events enabled
> 
> I tried also with '-o -', made no difference and:
> 
> [root@five ~]# perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
> Events disabled
> Event sched:sched_process_fork enabled
> Event sched:sched_process_fork disabled
> Event sched:sched_process_fork disabled
> 
> The second probably should be more clear stating that that event was
> already disabled.

ok, I'll make patch for that

> 
> Probably your example with all the sched tracepoints make 'perf record'
> just process the stream of events and not look at the commands?

hum, I'm not sure I understand what's the problem apart
from not printing that the event is already disabled
some events are not disabed?

> 
> If I try with:
> 
> [root@five ~]# perf list sched:sched_process_* 2> /dev/null
> 
> List of pre-defined events (to be used in -e):
> 
>   sched:sched_process_exec                           [Tracepoint event]
>   sched:sched_process_exit                           [Tracepoint event]
>   sched:sched_process_fork                           [Tracepoint event]
>   sched:sched_process_free                           [Tracepoint event]
>   sched:sched_process_wait                           [Tracepoint event]
> 
> [root@five ~]#
> 
> [root@five ~]# perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:sched_process_*' -o - > perf.pipe
> Events disabled
> Events enabled
> Events disabled
> 
> It works.
> 
> So it is a pre-existing problem, I'll continue processing your patches
> and make a note about this...

ok, I'll check the note

thanks,
jirka

