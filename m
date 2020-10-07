Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E1285974
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgJGHXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:23:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42136 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgJGHXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:23:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id e18so894412wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vm13Z3HWwFFOXzAYg9vXSvr/1kojOsqrdIrCgv8M87U=;
        b=QdpWMGznDkim71teTKnuNeEf2ndCLnrUbK+6fWboH8ZqC5WBv0CTmxip4vBXZ4W8dZ
         IH8rijrzDlioXR279Qe5iRcRz722gwS847f+0xkPEcXNADrKgDF2JivVA8X0SaU+Oric
         YX6WgHM+BgGCvsG90vv+hlNQu6toFnj8Kvgu0YOFqBf0kEX46TRgFeG3CeEtA9UspHYZ
         nPoZjMvy9CivQM+VjCDYJiFUG+DeOQst7seKwMCcpe65CcLegYSbYlMgkftZNt0KPCQb
         k20LLOEPeYzpSj4A8q1zZ6P7HQPH8L3L44zsraXHmoBZDIybna3UpNmVlHDe1MFO+a4F
         nlKw==
X-Gm-Message-State: AOAM531p+63EbIa4ebyrxNo+w66bRKDOphiOYKxGd/NUz+GAvNqZNsKX
        cbTRj4RA0w1hU5bDx5BygIQNxQuc0HNr3OhrDSU=
X-Google-Smtp-Source: ABdhPJweoPfZc7kZOQggtHMZvSTiohk4kLP3Yjk8tVRBNClNeAGziq7dJleJ1EduuVx+3h3mkQ6bv7aWKjT14Y6DNnM=
X-Received: by 2002:adf:8b48:: with SMTP id v8mr1878671wra.21.1602055424968;
 Wed, 07 Oct 2020 00:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201001115729.27116-1-song.bao.hua@hisilicon.com>
 <20201001230653.GM50079@tassilo.jf.intel.com> <dc9c24dcc58d477fa7e9c1a2ea246791@hisilicon.com>
 <CAM9d7cjM262j4ixjayz+M1BqYDuiqRmrd9ifx++XBxT830ymRQ@mail.gmail.com>
 <41a3e45d558242f79f9e10a8d9ca92f1@hisilicon.com> <20201006111113.GB249615@krava>
In-Reply-To: <20201006111113.GB249615@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Oct 2020 16:23:10 +0900
Message-ID: <CAM9d7cjWQWC6ECw2OYz_Qpv3iE6aG5V9qff_P2v9YXfsozZnGg@mail.gmail.com>
Subject: Re: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 6, 2020 at 8:11 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Oct 06, 2020 at 06:39:44AM +0000, Song Bao Hua (Barry Song) wrote:
>
> SNIP
>
> > > > Andi, thanks! Could you share the link or the commit ID? I'd like to take a
> > > look at the fix.
> > > > I could still reproduce this issue in the latest linus' tree and I didn't find any
> > > commit
> > > > related to this issue in linux-next and tip/perf/core.
> > >
> > > I think Andi was referring to this discussion which is not merged yet:
> > >
> > > https://lore.kernel.org/lkml/20200922031346.15051-2-liwei391@huawei.co
> > > m/
> > >
> > > I suggested a patch at the end.  Can you please try it?
> >
> > I tried the patch you suggested.
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 2208444ecb44..cfcdbd7be066 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -45,6 +45,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >          if (!evsel->own_cpus || evlist->has_user_cpus) {
> >                  perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus = perf_cpu_map__get(evlist->cpus);
> > +       } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->cpus)) {
> > +               perf_cpu_map__put(evsel->cpus);
> > +               evsel->cpus = perf_cpu_map__get(evlist->cpus);
> >         } else if (evsel->cpus != evsel->own_cpus) {
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> >
> > it did fix the crash I have seen on arm64. I'd prefer you put the below fixes tag in the commit log.
> > Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
> > Perf stat began to crash from v5.4 kernel, so the fix should be backported to stable trees.
>
> awesome.. Namhyung, could you please send full patch?

Sure, I'll do!

Thanks
Namhyung
