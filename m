Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F837268422
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgINFi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 01:38:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52183 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINFiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:38:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id w2so9377639wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 22:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8QFwCG5mYnHRxaGdvZtDFz1aJ8Aevr6zjHyKrFYWKk=;
        b=lOwk70hecvbosD+VfgQZO9ERCEKElA5d9zNOc4UjWvKRuPs6yhkYvEhghFV0TCOzva
         3S6uOqIx6/bcvNwsq9qi7Apoe3Ea+Pn3NgZTsp7vyFNhxsEKLbiU+SCWtZ/E61K49CYG
         jxW9G+bj9pT1Jq1Ava6Qh+hxIl514DbzQEWRU3I3rigXfyKrKPcPny8p1UEE27Se/ZwO
         4PxMumKbPfRARiXNqaRAF/HSoBg9DPT5QcI1V9awESjTp59NB5kAlej5UopEFR2iRKGK
         Ev84I3udybVnbE7rZS06uAaFLRrpHYjVj/rcdek+yrJ+iZ8eZHH8dgj0fMpZ2r97R7xS
         01eQ==
X-Gm-Message-State: AOAM531tqu9kKas9Lg7eBd+iGJdjs0uVKpxou3Ej0LfJOuWzhkO1THi8
        xoSPaYsDc6Dn1eB9ieHf0mxdXwcB/qWldZfmkvY=
X-Google-Smtp-Source: ABdhPJyE1Q3SHKwyLkXAOFYmdai+jhybYtDpjk71r/UlyUmVA4Hdr6okkrsnEkliGGZTtHrAQA5jjrbJ49Z+moHhwC4=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr13171238wmi.168.1600061918945;
 Sun, 13 Sep 2020 22:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-3-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-3-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 14:38:27 +0900
Message-ID: <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add new version of mmap event. The MMAP3 record is an
> augmented version of MMAP2, it adds build id value to
> identify the exact binary object behind memory map:
>
>   struct {
>     struct perf_event_header header;
>
>     u32                      pid, tid;
>     u64                      addr;
>     u64                      len;
>     u64                      pgoff;
>     u32                      maj;
>     u32                      min;
>     u64                      ino;
>     u64                      ino_generation;
>     u32                      prot, flags;
>     u32                      reserved;
>     u8                       buildid[20];

Do we need maj, min, ino, ino_generation for mmap3 event?
I think they are to compare binaries, then we can do it with
build-id (and I think it'd be better)..


>     char                     filename[];
>     struct sample_id         sample_id;
>   };
>
> Adding 4 bytes reserved field to align buildid data to 8 bytes,
> so sample_id data is properly aligned.
>
> The mmap3 event is enabled by new mmap3 bit in perf_event_attr
> struct.  When set for an event, it enables the build id retrieval
> and will use mmap3 format for the event.
>
> Keeping track of mmap3 events and calling build_id_parse
> in perf_event_mmap_event only if we have any defined.
>
> Having build id attached directly to the mmap event will help
> tool like perf to skip final search through perf data for
> binaries that are needed in the report time. Also it prevents
> possible race when the binary could be removed or replaced
> during profiling.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++-
>  kernel/events/core.c            | 38 +++++++++++++++++++++++++++------
>  2 files changed, 57 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 077e7ee69e3d..facfc3c673ed 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -384,7 +384,8 @@ struct perf_event_attr {
>                                 aux_output     :  1, /* generate AUX records instead of events */
>                                 cgroup         :  1, /* include cgroup events */
>                                 text_poke      :  1, /* include text poke events */
> -                               __reserved_1   : 30;
> +                               mmap3          :  1, /* include bpf events */

???

> +                               __reserved_1   : 29;
>
>         union {
>                 __u32           wakeup_events;    /* wakeup every n events */
> @@ -1060,6 +1061,30 @@ enum perf_event_type {
>          */
>         PERF_RECORD_TEXT_POKE                   = 20,
>
> +       /*
> +        * The MMAP3 records are an augmented version of MMAP2, they add
> +        * build id value to identify the exact binary behind map
> +        *
> +        * struct {
> +        *      struct perf_event_header        header;
> +        *
> +        *      u32                             pid, tid;
> +        *      u64                             addr;
> +        *      u64                             len;
> +        *      u64                             pgoff;
> +        *      u32                             maj;
> +        *      u32                             min;
> +        *      u64                             ino;
> +        *      u64                             ino_generation;
> +        *      u32                             prot, flags;
> +        *      u32                             reserved;
> +        *      u8                              buildid[20];
> +        *      char                            filename[];
> +        *      struct sample_id                sample_id;
> +        * };
> +        */
> +       PERF_RECORD_MMAP3                       = 21,
> +
>         PERF_RECORD_MAX,                        /* non-ABI */
>  };
>
[SNIP]
> @@ -8098,6 +8116,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
>         mmap_event->prot = prot;
>         mmap_event->flags = flags;
>
> +       if (atomic_read(&nr_mmap3_events))
> +               build_id_parse(vma, mmap_event->buildid);

What about if it failed?  We should zero out the build-id..

Thanks
Namhyung

> +
>         if (!(vma->vm_flags & VM_EXEC))
>                 mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_DATA;
>
> @@ -8241,6 +8262,7 @@ void perf_event_mmap(struct vm_area_struct *vma)
>                 /* .ino_generation (attr_mmap2 only) */
>                 /* .prot (attr_mmap2 only) */
>                 /* .flags (attr_mmap2 only) */
> +               /* .buildid (attr_mmap3 only) */
>         };
>
>         perf_addr_filters_adjust(vma);
> @@ -11040,6 +11062,8 @@ static void account_event(struct perf_event *event)
>                 inc = true;
>         if (event->attr.mmap || event->attr.mmap_data)
>                 atomic_inc(&nr_mmap_events);
> +       if (event->attr.mmap3)
> +               atomic_inc(&nr_mmap3_events);
>         if (event->attr.comm)
>                 atomic_inc(&nr_comm_events);
>         if (event->attr.namespaces)
> --
> 2.26.2
>
