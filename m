Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77026D094
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgIQB15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:27:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40658 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQB1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:27:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id j2so228319wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9MfYh+B55nPcS/wHplADWbjVnsJmk4+mYoJy+l6Twc=;
        b=uFEWzQDwXYrLnHEOI96eMg99VwyyeRN+vk5iYGcex54lEr07hBTz35szr6BXArKGim
         ElxuYjujEG8/Q72jSsmcelpbH8bJA8WQmwxdeOex7UVVqAfwHQljbfiZ0w07BR3rzCYu
         HeykSKZlf2I/eVTKL2LMinNwEn2tKG+0efJd2Ixt3jK2pjXu3Fa87c7nIUdtOUw5Nx0v
         cfWovCKacx8QM8JOKzlHlLYCFhnJeQVn2lC0wwB+CyovNvni47QOoqhCZOgGMVhbSt2/
         vdxxEV+1aCn2LlB/R1Yw2Kk8lXSJcePJi0Zpkdh255yENyA8fIG5r16/l+t1Sn8hP0Ub
         C2EA==
X-Gm-Message-State: AOAM531/NShLXFLteXAciOVOnN9pfuyCSYkqzp89H0Qq/+Jud7tGqZmS
        psp1WQ8KxrLQnwVHea2f+wwZ3B1JqYajNu9W/NozV8+hg38=
X-Google-Smtp-Source: ABdhPJyeD2VRyHa7Knqib/N9RvCdIJuvlAL1vxoYg1Z/iFBJiLWYF9Qqyxtvzi23t2A185aufWippXYzWw8Vv0eE9AU=
X-Received: by 2002:adf:9e41:: with SMTP id v1mr32027569wre.60.1600306072732;
 Wed, 16 Sep 2020 18:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200914141859.332459-1-namhyung@kernel.org> <20200914141859.332459-3-namhyung@kernel.org>
 <20200915100533.GC2171499@krava> <CAM9d7cjHzbamDDQRmBQ_UydbkUCNA5MZfPj4fGCbb7O9m3KOgA@mail.gmail.com>
 <20200916082443.GB2301783@krava>
In-Reply-To: <20200916082443.GB2301783@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 17 Sep 2020 10:27:41 +0900
Message-ID: <CAM9d7cjLdRDLtgSYqZW1mwCxbBe28tjUjzEDjaBcnV6W0jdQzA@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 5:24 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:55:34PM +0900, Namhyung Kim wrote:
> > On Tue, Sep 15, 2020 at 7:05 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Mon, Sep 14, 2020 at 11:18:59PM +0900, Namhyung Kim wrote:
> > > > No need to load symbols in a DSO when injecting build-id.  I guess the
> > > > reason was to check the DSO is a special file like anon files.  Use
> > > > some helper functions in map.c to check them before reading build-id.
> > > > Also pass sample event's cpumode to a new build-id event.
> > > >
> > > > Original-patch-by: Stephane Eranian <eranian@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/builtin-inject.c | 30 ++++++++++--------------------
> > > >  tools/perf/util/map.c       | 17 +----------------
> > > >  tools/perf/util/map.h       | 14 ++++++++++++++
> > > >  3 files changed, 25 insertions(+), 36 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > > > index a2804d906d2a..6d4e6833efed 100644
> > > > --- a/tools/perf/builtin-inject.c
> > > > +++ b/tools/perf/builtin-inject.c
> > > > @@ -436,21 +436,22 @@ static int dso__read_build_id(struct dso *dso)
> > > >  }
> > > >
> > > >  static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
> > > > -                             struct machine *machine)
> > > > +                             struct machine *machine, u8 cpumode)
> > > >  {
> > > > -     u16 misc = PERF_RECORD_MISC_USER;
> > > >       int err;
> > > >
> > > > +     if (is_anon_memory(dso->long_name))
> > > > +             return 0;
> > > > +     if (is_no_dso_memory(dso->long_name))
> > > > +             return 0;
> > >
> > > should we check for vdso as well? I don't think it has build id
> >
> > I don't know.. But I guess there's no reason it shouldn't?
>
> I haven't checked, it's just I always saw only zeros for vdso build ids

I found this in arch/x86/entry/vdso/Makefile.  It seems to have one..

quiet_cmd_vdso = VDSO    $@
      cmd_vdso = $(LD) -nostdlib -o $@ \
               $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
               -T $(filter %.lds,$^) $(filter %.o,$^) && \
         sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'

VDSO_LDFLAGS = -shared --hash-style=both --build-id \
    $(call ld-option, --eh-frame-hdr) -Bsymbolic

Thanks
Namhyung
