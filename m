Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB256269297
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgINRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:08:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:08:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so812127wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EOCx9ftlXj9r5hUVYs4UrtJe1lnrNygcuxr0i6YY/o=;
        b=W/PkP+J+A5uVeI0t9NwdGy9u6SXPvioNMmJApM0IhvCdhGeeVQ/0sSLzpbtV6fHxOO
         TQA7URqIQXMcFyhPnkZL00bGwjQYlVfd8ZGP7Tr9U0URP6LIWwhW5cI3DpcdnZziCe3A
         rkMi/fX2tRSMb8AXgS6ZJqc/Z7MkbC669iHpSYUfE/yNyKjXLon5Y84ptPDd3LxckRTM
         /89hO7enXbpddOyQjfLUgGQOtu5ucvyfMwXRa5f7+BSLzE5I/s5e+SmOwb/9FPwXEWic
         SMSmbELfgqNO3BovNsBFDowXf74LKxlzY7G6f6FTP1uTuMEFOSE2TgL0P+gRZ6rLfQBM
         1Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EOCx9ftlXj9r5hUVYs4UrtJe1lnrNygcuxr0i6YY/o=;
        b=P9k62QWx9qG7MD3nRt02Og6wPaIRFPlMYHAmiVPU+bubvQvQ7H5azombvc2vD3REUZ
         chSmZ/dfB1Pe40NW+DrFEeuVG7CCP5znuT3KRnDE4EUpEmF2P/D4kp+6xkS2XivcYJhJ
         wIj/5X8G4ieTRoirXybUhfb31Rmu7oBGAIgMQneKCeDlxK3aBa9gsPSkSa6rUpGkZ9yp
         EJYdE42pg3rKoAHGmh35ixfVV6g/Xw9gfrrnbq/qwgh4DLHJ8/p68gEKPX4XAl/YC/0u
         eYZFBhd7xvcfEoqrugBu+tURJVo/c1H6QTQL5j+l/D4sH2lQrvL+ovmfNIhXE3qgDKan
         8tKw==
X-Gm-Message-State: AOAM530y5KbcTRGB2ByvaVsTgeWFk4nbUS2dkS1B2F1x/SDq/GG3b1+0
        lh/2uDw82zrs0hs194L3/yqqhFlsjfYbBLJvxqUu1Q==
X-Google-Smtp-Source: ABdhPJzo42d282HlrCe/sGhZUIISKzPkZFivLUB/pih0RIrPmUgtJYd+qrAqGWY+WFJH55OaaFgv6Fas7g//h4N8X4c=
X-Received: by 2002:a1c:f402:: with SMTP id z2mr335531wma.87.1600103301802;
 Mon, 14 Sep 2020 10:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <20200914152841.GC160517@kernel.org> <20200914163534.GT1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200914163534.GT1362448@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Sep 2020 10:08:01 -0700
Message-ID: <CAP-5=fUansxK_as61teHsLyRQu3Zu5UE-+SDqWVYGhSz36uCzQ@mail.gmail.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 9:35 AM <peterz@infradead.org> wrote:
>
> On Mon, Sep 14, 2020 at 12:28:41PM -0300, Arnaldo Carvalho de Melo wrote:
>
> > > >   struct {
> > > >     struct perf_event_header header;
> >
> > > >     u32                      pid, tid;
> > > >     u64                      addr;
> > > >     u64                      len;
> > > >     u64                      pgoff;
> > > >     u32                      maj;
> > > >     u32                      min;
> > > >     u64                      ino;
> > > >     u64                      ino_generation;
> > > >     u32                      prot, flags;
> > > >     u32                      reserved;
> >
> > What for this reserved? its all nicely aligned already, u64 followed by
> > two u32 (prot, flags).
>
> I suspect it is so that sizeof(reserve+buildid) is a multiple of 8. But
> yes, that's a wee bit daft, since the next field is a variable length
> character array.
>
> > > >     u8                       buildid[20];
> >
> > > Do we need maj, min, ino, ino_generation for mmap3 event?
> > > I think they are to compare binaries, then we can do it with
> > > build-id (and I think it'd be better)..
> >
> > Humm, I thought MMAP2 would be a superset of MMAP and MMAP3 would be a
> > superset of MMAP2.
>
> Well, the 'funny' thing is that if you do use buildid, then
> {maj,min,ino,ino_generation} are indeed superfluous, but are combined
> also large enough to contain buildid.
>
> > If we want to ditch useless stuff, then trow away pid, tid too, as we
> > can select those via sample_type.
>
> Correct.
>
> So something like:
>
> struct {
>   struct perf_event_header header;
>
>   u64                      addr;
>   u64                      len;
>   u64                      pgoff;
>   union {
>     struct {
>       u32                  maj;
>       u32                  min;
>       u64                  ino;
>       u64                  ino_generation;
>     };
>     u8                     buildid[20];
>   };
>   u32                      prot, flags;
>   char                     filename[];
>   struct sample_id         sample_id;
> };
>
> Using one of the MISC bits to resolve the union. Might actually bring
> benefit to everyone. Us normal people get to have a smaller MMAP record,
> while the buildid folks can have it too.
>
> Even more extreme would be using 2 MISC bits and allowing the union to
> be 0 sized for anon.
>
> That said; I have the nagging feeling there were unresolved issues with
> mmap2, but I can't seem to find any relevant emails on it :/ My
> google-fu is weak today.

Firstly, thanks Jiri for this really useful patch set for our
use-cases! Some thoughts:

One issue with mmap2 events at the moment is that they happen "after"
the mmap is performed. This allows the mapped address to be known but
has the unfortunate problem of causing mmap events to get "extended"
due to adjacent vmas being merged. There are some workarounds like
commit c8f6ae1fb28d (perf inject jit: Remove //anon mmap events).
Perhaps these events can switch to reporting the length the mmap
requested rather than the length of the vma?

I could imagine that changes here could be interesting to folks doing
CHERI or hypervisors, for example, they may want more address bits.

BPF has stack traces with elements of buildid + offset. Using these in
perf samples would avoid the need for mmap events, synthesis, etc. but
at the cost of larger and possibly slower stack traces. Perhaps we
should just remove the idea of mmap events altogether?

Thanks,
Ian
