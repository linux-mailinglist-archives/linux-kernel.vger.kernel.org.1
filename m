Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11DC269C29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgIOCy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:54:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54968 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgIOCy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:54:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id s13so1817963wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cfO0hHUv0ql0LZw8NdlMoLBWTLiyNGCr+tD4ousFFc=;
        b=Zp2ZlMT4WZpDt9rPs2XkTO5pHh+vNWUZwQTsHkRaAokulEAlaI5OXRuKDR1+pIaJio
         tY/nDAMI8oxSaV0nGxycfJxPprpUmyaRWrHaEh7HYwals9dQOym1UuMI7Bmm98IaRwRP
         DuqRdrfrLggMG6yXCU/FZA6gCOiN2zEjNPBLj7WVOU7y8+isFE/0m42p2sIXLFegJBrl
         PGdvwEJd4geL3ohPR9K50iEkWwfrjA8sG34X+1We9sDg5iC3f+zSHkHBC6+2oYEv17r/
         f2D0mDDywLDdirLqjnFWyert3Cr8QKPYiXGl4jzs8AA6uSMMUOo+SqrXUh7M+wkKHOZ5
         CKHg==
X-Gm-Message-State: AOAM5319BAqNCKa4Mdqupjb+43cjXpxd/vPKyjNBODqx3ZivA4uwii0X
        rwkeB03UMV0hiuzqZoAp1H3ecXko3GYks047zsZ9m7BHDUM=
X-Google-Smtp-Source: ABdhPJyMBRx9h2dd0F1ef2QfilyfH10YEwpQlta4uo7S9kqteJsgI/UonktLaY06SSf1ocFNzhEgqCFly2NxmhAzrPs=
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr2210152wmm.128.1600138495527;
 Mon, 14 Sep 2020 19:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com> <20200914193841.GM1714160@krava>
In-Reply-To: <20200914193841.GM1714160@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Sep 2020 11:54:44 +0900
Message-ID: <CAM9d7ciWF-B7+YyEQd9D2DCdHPyLMdX0wMCFEihR41M8SJZKDw@mail.gmail.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Sep 15, 2020 at 4:38 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 14, 2020 at 02:38:27PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index 077e7ee69e3d..facfc3c673ed 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -384,7 +384,8 @@ struct perf_event_attr {
> > >                                 aux_output     :  1, /* generate AUX records instead of events */
> > >                                 cgroup         :  1, /* include cgroup events */
> > >                                 text_poke      :  1, /* include text poke events */
> > > -                               __reserved_1   : 30;
> > > +                               mmap3          :  1, /* include bpf events */
> >
> > ???
> >
> > > +                               __reserved_1   : 29;
> > >
> > >         union {
> > >                 __u32           wakeup_events;    /* wakeup every n events */
> > > @@ -1060,6 +1061,30 @@ enum perf_event_type {
> > >          */
> > >         PERF_RECORD_TEXT_POKE                   = 20,
> > >
> > > +       /*
> > > +        * The MMAP3 records are an augmented version of MMAP2, they add
> > > +        * build id value to identify the exact binary behind map
> > > +        *
> > > +        * struct {
> > > +        *      struct perf_event_header        header;
> > > +        *
> > > +        *      u32                             pid, tid;
> > > +        *      u64                             addr;
> > > +        *      u64                             len;
> > > +        *      u64                             pgoff;
> > > +        *      u32                             maj;
> > > +        *      u32                             min;
> > > +        *      u64                             ino;
> > > +        *      u64                             ino_generation;
> > > +        *      u32                             prot, flags;
> > > +        *      u32                             reserved;
> > > +        *      u8                              buildid[20];
> > > +        *      char                            filename[];
> > > +        *      struct sample_id                sample_id;
> > > +        * };
> > > +        */
> > > +       PERF_RECORD_MMAP3                       = 21,
> > > +
> > >         PERF_RECORD_MAX,                        /* non-ABI */
> > >  };
> > >
> > [SNIP]
> > > @@ -8098,6 +8116,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
> > >         mmap_event->prot = prot;
> > >         mmap_event->flags = flags;
> > >
> > > +       if (atomic_read(&nr_mmap3_events))
> > > +               build_id_parse(vma, mmap_event->buildid);
> >
> > What about if it failed?  We should zero out the build-id..
>
> it is initialized to zero in perf_event_mmap
>
>         mmap_event = (struct perf_mmap_event){
>                 .vma    = vma,
>         ...
>
> I'll double check build_id_parse won't leave anything half
> baked there, but I dont think so

Oh, you're right.  I missed that..

Thanks
Namhyung
