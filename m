Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC512D90EF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406764AbgLMWga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 17:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729966AbgLMWg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 17:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607898903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UdUTcnSrZvkbpzpBLWePF6FEJ4/tcNlPrh1CShjKYuw=;
        b=UldDuV8GRWKVKQ3rcKZEuxYZScVkUZPcMJpQnNY7ZvlQJA9WJCObsUxCDpm8wkdXF7RKgo
        LgpLiSDJzlIreWPRB8LqA7jM7vh5EWjvsYdX40dtPqiZZ2RtU/yQv9DAr+DghUG4UH7JeU
        dFdDAE3KQFkJa7EZf+GvH5opxMYOlss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-DiKPYxLONqK5ZxNyvbw2Rw-1; Sun, 13 Dec 2020 17:35:00 -0500
X-MC-Unique: DiKPYxLONqK5ZxNyvbw2Rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8544801817;
        Sun, 13 Dec 2020 22:34:58 +0000 (UTC)
Received: from krava (unknown [10.40.192.121])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9F9EB70477;
        Sun, 13 Dec 2020 22:34:56 +0000 (UTC)
Date:   Sun, 13 Dec 2020 23:34:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201213223455.GA502638@krava>
References: <20201208181646.3044417-1-songliubraving@fb.com>
 <20201208181646.3044417-3-songliubraving@fb.com>
 <20201209170348.GD69683@krava>
 <FE4D28BB-E0D8-4F33-A6F5-F3FD4D1A3F25@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FE4D28BB-E0D8-4F33-A6F5-F3FD4D1A3F25@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:15:16AM +0000, Song Liu wrote:
> 
> 
> > On Dec 9, 2020, at 9:03 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Tue, Dec 08, 2020 at 10:16:46AM -0800, Song Liu wrote:
> >> Introduce perf-stat -b option, which counts events for BPF programs, like:
> >> 
> >> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
> >>     1.487903822            115,200      ref-cycles
> >>     1.487903822             86,012      cycles
> >>     2.489147029             80,560      ref-cycles
> >>     2.489147029             73,784      cycles
> >>     3.490341825             60,720      ref-cycles
> >>     3.490341825             37,797      cycles
> >>     4.491540887             37,120      ref-cycles
> >>     4.491540887             31,963      cycles
> >> 
> >> The example above counts cycles and ref-cycles of BPF program of id 254.
> >> This is similar to bpftool-prog-profile command, but more flexible.
> >> 
> >> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> >> programs (monitor-progs) to the target BPF program (target-prog). The
> >> monitor-progs read perf_event before and after the target-prog, and
> >> aggregate the difference in a BPF map. Then the user space reads data
> >> from these maps.
> >> 
> >> A new struct bpf_counter is introduced to provide common interface that
> >> uses BPF programs/maps to count perf events.
> >> 
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> > 
> > I'm getting this at the end of the compilation:
> > 
> >  LINK     perf
> > rm /home/jolsa/linux-perf/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
> > 
> > I guess we can keep it or make it silent somehow
> 
> I also noticed this, but haven't figured out how to silent it. I guess 
> we can fix it out later.

I think this might do it:

.PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o

SNIP

> >> tools/perf/util/evsel.c                       |  11 +
> >> tools/perf/util/evsel.h                       |   6 +
> >> tools/perf/util/stat-display.c                |   4 +-
> >> tools/perf/util/target.c                      |  34 +-
> >> tools/perf/util/target.h                      |  10 +
> >> 11 files changed, 591 insertions(+), 17 deletions(-)
> >> create mode 100644 tools/perf/util/bpf_counter.c
> >> create mode 100644 tools/perf/util/bpf_counter.h
> >> create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> > 
> > we need man page update, would be great with some example
> 
> How about we do this in a follow up patch?

sry, we need to add man changes with new option

thanks,
jirka

