Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4C26B375
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgIOXDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:03:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37900 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbgIOOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:55:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id l9so3785457wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uv4sQaq+ahyzlTqvClk5GLdjg5zRMeWdusHQ/6Hxqpw=;
        b=cQTIvWWksUPXp9+CagJRS4fGzlmRE44q9rPzulq7TEixx5MNJSppmhBbxAS1d1NNq8
         tP7n+SIQRs6o3pwEM/L/xG5Wqk7nhhkYFkUPXI8C/2UXfUN1OLJDBlVkPA3XjoQv1zl6
         f4Bn5Uqe6RBkpleW2bpYqReYEYK78PaPHpRi1Xkv9jZw0fz2lYd/MTSl4E2N50PeFBbG
         srewN5GC3m2x//zWH5yT5u2lez3O9YUAm48nYNmgQYpw8383ZQRkC4l2JAUjExRZ6gQQ
         N6KkOtf7o78CKpn08QU2jAVHLZ6soLKOFlNay9Rs+MyUlbQ/Y3M+B5WrISR9aVSkdARp
         ahcQ==
X-Gm-Message-State: AOAM5330dAKcMO1/qcqk+AH0EGRNdjKfB0tERojtsnHl6h14v1ycjrir
        Cd7frRs5vjj/ajMVKc0ShCL+738sFOwfVMBHxI4=
X-Google-Smtp-Source: ABdhPJx7vMb/fJoY1hU6+bArC3IEGlNsEV6UsarJjbi1/zgoSmnG0dQr+W9A809oxOtmJUDAukPiE9xHYWv3UNKK05E=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr5378314wmt.92.1600181745534;
 Tue, 15 Sep 2020 07:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200914141859.332459-1-namhyung@kernel.org> <20200914141859.332459-3-namhyung@kernel.org>
 <20200915100533.GC2171499@krava>
In-Reply-To: <20200915100533.GC2171499@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Sep 2020 23:55:34 +0900
Message-ID: <CAM9d7cjHzbamDDQRmBQ_UydbkUCNA5MZfPj4fGCbb7O9m3KOgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf inject: Do not load map/dso when injecting build-id
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 7:05 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 14, 2020 at 11:18:59PM +0900, Namhyung Kim wrote:
> > No need to load symbols in a DSO when injecting build-id.  I guess the
> > reason was to check the DSO is a special file like anon files.  Use
> > some helper functions in map.c to check them before reading build-id.
> > Also pass sample event's cpumode to a new build-id event.
> >
> > Original-patch-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-inject.c | 30 ++++++++++--------------------
> >  tools/perf/util/map.c       | 17 +----------------
> >  tools/perf/util/map.h       | 14 ++++++++++++++
> >  3 files changed, 25 insertions(+), 36 deletions(-)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index a2804d906d2a..6d4e6833efed 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -436,21 +436,22 @@ static int dso__read_build_id(struct dso *dso)
> >  }
> >
> >  static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
> > -                             struct machine *machine)
> > +                             struct machine *machine, u8 cpumode)
> >  {
> > -     u16 misc = PERF_RECORD_MISC_USER;
> >       int err;
> >
> > +     if (is_anon_memory(dso->long_name))
> > +             return 0;
> > +     if (is_no_dso_memory(dso->long_name))
> > +             return 0;
>
> should we check for vdso as well? I don't think it has build id

I don't know.. But I guess there's no reason it shouldn't?


>
> > +
> >       if (dso__read_build_id(dso) < 0) {
> >               pr_debug("no build_id found for %s\n", dso->long_name);
> >               return -1;
> >       }
> >
> > -     if (dso->kernel)
> > -             misc = PERF_RECORD_MISC_KERNEL;
> > -
> > -     err = perf_event__synthesize_build_id(tool, dso, misc, perf_event__repipe,
> > -                                           machine);
> > +     err = perf_event__synthesize_build_id(tool, dso, cpumode,
> > +                                           perf_event__repipe, machine);
> >       if (err) {
> >               pr_err("Can't synthesize build_id event for %s\n", dso->long_name);
> >               return -1;
> > @@ -478,19 +479,8 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
> >       if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
> >               if (!al.map->dso->hit) {
> >                       al.map->dso->hit = 1;
> > -                     if (map__load(al.map) >= 0) {
>
> nice, that might do some nice speedup, did you see any?

Yes, I believe so.  But my quick test on a laptop was too short.
I will test it again and share the speedup.

Thanks
Namhyung


>
> jirka
>
> > -                             dso__inject_build_id(al.map->dso, tool, machine);
> > -                             /*
> > -                              * If this fails, too bad, let the other side
> > -                              * account this as unresolved.
> > -                              */
> > -                     } else {
> > -#ifdef HAVE_LIBELF_SUPPORT
> > -                             pr_warning("no symbols found in %s, maybe "
> > -                                        "install a debug package?\n",
> > -                                        al.map->dso->long_name);
> > -#endif
> > -                     }
> > +                     dso__inject_build_id(al.map->dso, tool, machine,
> > +                                          sample->cpumode);
> >               }
>
> SNIP
>
