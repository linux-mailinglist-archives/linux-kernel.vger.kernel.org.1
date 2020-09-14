Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214E0269609
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:07:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726040AbgINUHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600114043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRlln9V1GvO5+NGpvkV2buBDGuKlOmRWgBQoF1uRx3c=;
        b=HW8Rt1Bl+0c+N0fxDnTy9OFmd7I0X9GNY/ISVo64cvpzHLdzWZP539o/YDPywxOQYlzH/A
        re5tKAJORFLv8QX7XP2gCV/4qetVDvcjIDUxVLdxBtgLYKc5aUEkWgYV+Op/P4rT3yTjpA
        jVGzFwyaXSXJq33Vm3oGtFwpaiKlVQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-IFp-zbWpOIiZ13MOUbmYrQ-1; Mon, 14 Sep 2020 16:07:21 -0400
X-MC-Unique: IFp-zbWpOIiZ13MOUbmYrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C8D1084C92;
        Mon, 14 Sep 2020 20:07:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 03F1D19C4F;
        Mon, 14 Sep 2020 20:07:12 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:07:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914200711.GS1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <20200914152841.GC160517@kernel.org>
 <20200914163534.GT1362448@hirez.programming.kicks-ass.net>
 <CAP-5=fUansxK_as61teHsLyRQu3Zu5UE-+SDqWVYGhSz36uCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUansxK_as61teHsLyRQu3Zu5UE-+SDqWVYGhSz36uCzQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:08:01AM -0700, Ian Rogers wrote:

SNIP

> >
> > Using one of the MISC bits to resolve the union. Might actually bring
> > benefit to everyone. Us normal people get to have a smaller MMAP record,
> > while the buildid folks can have it too.
> >
> > Even more extreme would be using 2 MISC bits and allowing the union to
> > be 0 sized for anon.
> >
> > That said; I have the nagging feeling there were unresolved issues with
> > mmap2, but I can't seem to find any relevant emails on it :/ My
> > google-fu is weak today.
> 
> Firstly, thanks Jiri for this really useful patch set for our
> use-cases! Some thoughts:
> 
> One issue with mmap2 events at the moment is that they happen "after"
> the mmap is performed. This allows the mapped address to be known but
> has the unfortunate problem of causing mmap events to get "extended"
> due to adjacent vmas being merged. There are some workarounds like
> commit c8f6ae1fb28d (perf inject jit: Remove //anon mmap events).
> Perhaps these events can switch to reporting the length the mmap
> requested rather than the length of the vma?

seems like separate feature, perhaps we could use another MISC bit for that?

> 
> I could imagine that changes here could be interesting to folks doing
> CHERI or hypervisors, for example, they may want more address bits.
> 
> BPF has stack traces with elements of buildid + offset. Using these in
> perf samples would avoid the need for mmap events, synthesis, etc. but
> at the cost of larger and possibly slower stack traces. Perhaps we
> should just remove the idea of mmap events altogether?

hm, we also need mmap events to resolve PERF_SAMPLE_IP, right?
also not sure how would we do that for dwarf unwind, and perhaps
there are some other places.. c2c data address resolving?

thanks,
jirka

