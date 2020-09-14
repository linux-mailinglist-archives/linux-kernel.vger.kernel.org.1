Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD825268510
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgINGlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgINGlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:41:37 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA87C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:41:37 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c17so11079827ybe.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2e/psGENSerjhRGb83a7xuPA/rRxRn31njhZoBFdOg=;
        b=U7AgBhvolWIDsfkJX4KpEs5Xqg3G4zbEPpaDNxqhJ+OFhjyHR573KW0NEHlhL+hU2R
         hWrCZ+RBz3oupBeXrivd8UARcRnvqmNNT5w2v/8sCcfRkIbRHsjKByI44DJFBaqlJ4Xj
         cZjUqtVa0OgkhHxNY2Akdttu0anZiTxbP33R4SZn4PmhOaSdjoT/RWrazLBNsVCLhbt9
         XYckFS5qNW6SrBrAa09PevjVlavKwuepnGnAA9XokrCCqKVGghOVLdSKvcUo57ZU2L7Y
         7sibaca+o+dsLW27jVDYHTg7GNV6XC8VK7RPaPxIQ4NWt2vpEkj0BmyVqK/jERf9LH1Y
         zwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2e/psGENSerjhRGb83a7xuPA/rRxRn31njhZoBFdOg=;
        b=gVf+F9yT5kI0km83AWc1dR8LNL9kM4vftr+UgsoFiDbbNACoj2h7UeCza4gzvbbPhf
         2Ysj/0gRR4yBlEiUbep4DBPkstkqii0eOdkFeWHM+JNMQykdr2XqM+w5uPFEAhg/eUdN
         ay52Dzl/4lZsqnwaUMxXXrrvpb6Np0bkxOAkqa90zZWOaqsw1fu2LbIgWHS8LgU2Uqxm
         DfgX10nMt9F38JSmV/kX9gkBLzIo6t5Vpwp4o2ZlKj+wJXajcnIjkTbZ+AJf6xWI9j/5
         VrUtJ8f6G6Gtpc7/oPUbYe18VuPHfbDqv0/kteW3yMlIt8yUHhJS8Drr2kEXHyQv9TxQ
         mxbw==
X-Gm-Message-State: AOAM533+7kHoj70ksusxIhXJBvHWX/ALuTmGLsbtjrwrhfu6nJBXulvr
        uiAw8t7Nf3QzxINBD/gzmMyzfw8g/4GfUmdPcpZVvw==
X-Google-Smtp-Source: ABdhPJxTunaGXSnyYhMNL0ZVB/NMgkMlif8yoP9XTICxTedeKA/YFEEv6wEHHxyXHrRulvPrG979A2Z2EuMtIIff8l0=
X-Received: by 2002:a25:d18b:: with SMTP id i133mr17821303ybg.136.1600065693075;
 Sun, 13 Sep 2020 23:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-3-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-3-jolsa@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Sun, 13 Sep 2020 23:41:00 -0700
Message-ID: <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 2:03 PM Jiri Olsa <jolsa@kernel.org> wrote:
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
> +                               __reserved_1   : 29;
>
what happens if I set mmap3 and mmap2?

I think using mmap3 for every mmap may be overkill as you add useless
20 bytes to an mmap record.
I am not sure if your code handles the case where mmap3 is not needed
because there is no buildid, e.g, anonymous memory.
It seems to me you've written the patch in such a way that if the user
tool supports mmap3, then it supersedes mmap2, and thus
you need all the fields of mmap2. But if could be more interesting to
return either MMAP2 or MMAP3 depending on tool support
and type of mmap, that would certainly save 20 bytes on any anon mmap.
But maybe that logic is already in your patch and I missed it.


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
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7ed5248f0445..719894492dac 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -51,6 +51,7 @@
>  #include <linux/proc_ns.h>
>  #include <linux/mount.h>
>  #include <linux/min_heap.h>
> +#include <linux/buildid.h>
>
>  #include "internal.h"
>
> @@ -386,6 +387,7 @@ static DEFINE_PER_CPU(int, perf_sched_cb_usages);
>  static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
>
>  static atomic_t nr_mmap_events __read_mostly;
> +static atomic_t nr_mmap3_events __read_mostly;
>  static atomic_t nr_comm_events __read_mostly;
>  static atomic_t nr_namespaces_events __read_mostly;
>  static atomic_t nr_task_events __read_mostly;
> @@ -4588,7 +4590,7 @@ static bool is_sb_event(struct perf_event *event)
>                 return false;
>
>         if (attr->mmap || attr->mmap_data || attr->mmap2 ||
> -           attr->comm || attr->comm_exec ||
> +           attr->mmap3 || attr->comm || attr->comm_exec ||
>             attr->task || attr->ksymbol ||
>             attr->context_switch || attr->text_poke ||
>             attr->bpf_event)
> @@ -4644,6 +4646,8 @@ static void unaccount_event(struct perf_event *event)
>                 dec = true;
>         if (event->attr.mmap || event->attr.mmap_data)
>                 atomic_dec(&nr_mmap_events);
> +       if (event->attr.mmap3)
> +               atomic_dec(&nr_mmap3_events);
>         if (event->attr.comm)
>                 atomic_dec(&nr_comm_events);
>         if (event->attr.namespaces)
> @@ -7465,7 +7469,7 @@ static void perf_pmu_output_stop(struct perf_event *event)
>  /*
>   * task tracking -- fork/exit
>   *
> - * enabled by: attr.comm | attr.mmap | attr.mmap2 | attr.mmap_data | attr.task
> + * enabled by: attr.comm | attr.mmap | attr.mmap2 | attr.mmap3 | attr.mmap_data | attr.task
>   */
>
>  struct perf_task_event {
> @@ -7486,8 +7490,8 @@ struct perf_task_event {
>  static int perf_event_task_match(struct perf_event *event)
>  {
>         return event->attr.comm  || event->attr.mmap ||
> -              event->attr.mmap2 || event->attr.mmap_data ||
> -              event->attr.task;
> +              event->attr.mmap2 || event->attr.mmap3 ||
> +              event->attr.mmap_data || event->attr.task;
>  }
>
>  static void perf_event_task_output(struct perf_event *event,
> @@ -7913,6 +7917,7 @@ struct perf_mmap_event {
>         u64                     ino;
>         u64                     ino_generation;
>         u32                     prot, flags;
> +       u8                      buildid[BUILD_ID_SIZE];
>
>         struct {
>                 struct perf_event_header        header;
> @@ -7933,7 +7938,7 @@ static int perf_event_mmap_match(struct perf_event *event,
>         int executable = vma->vm_flags & VM_EXEC;
>
>         return (!executable && event->attr.mmap_data) ||
> -              (executable && (event->attr.mmap || event->attr.mmap2));
> +              (executable && (event->attr.mmap || event->attr.mmap2 || event->attr.mmap3));
>  }
>
>  static void perf_event_mmap_output(struct perf_event *event,
> @@ -7949,7 +7954,7 @@ static void perf_event_mmap_output(struct perf_event *event,
>         if (!perf_event_mmap_match(event, data))
>                 return;
>
> -       if (event->attr.mmap2) {
> +       if (event->attr.mmap2 || event->attr.mmap3) {
>                 mmap_event->event_id.header.type = PERF_RECORD_MMAP2;
>                 mmap_event->event_id.header.size += sizeof(mmap_event->maj);
>                 mmap_event->event_id.header.size += sizeof(mmap_event->min);
> @@ -7959,6 +7964,12 @@ static void perf_event_mmap_output(struct perf_event *event,
>                 mmap_event->event_id.header.size += sizeof(mmap_event->flags);
>         }
>
> +       if (event->attr.mmap3) {
> +               mmap_event->event_id.header.type = PERF_RECORD_MMAP3;
> +               mmap_event->event_id.header.size += sizeof(u32);
> +               mmap_event->event_id.header.size += sizeof(mmap_event->buildid);
> +       }
> +
>         perf_event_header__init_id(&mmap_event->event_id.header, &sample, event);
>         ret = perf_output_begin(&handle, event,
>                                 mmap_event->event_id.header.size);
> @@ -7970,7 +7981,7 @@ static void perf_event_mmap_output(struct perf_event *event,
>
>         perf_output_put(&handle, mmap_event->event_id);
>
> -       if (event->attr.mmap2) {
> +       if (event->attr.mmap2 || event->attr.mmap3) {
>                 perf_output_put(&handle, mmap_event->maj);
>                 perf_output_put(&handle, mmap_event->min);
>                 perf_output_put(&handle, mmap_event->ino);
> @@ -7979,6 +7990,13 @@ static void perf_event_mmap_output(struct perf_event *event,
>                 perf_output_put(&handle, mmap_event->flags);
>         }
>
> +       if (event->attr.mmap3) {
> +               u32 reserved = 0;
> +
> +               perf_output_put(&handle, reserved);
> +               __output_copy(&handle, mmap_event->buildid, BUILD_ID_SIZE);
> +       }
> +
>         __output_copy(&handle, mmap_event->file_name,
>                                    mmap_event->file_size);
>
> @@ -8098,6 +8116,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
>         mmap_event->prot = prot;
>         mmap_event->flags = flags;
>
> +       if (atomic_read(&nr_mmap3_events))
> +               build_id_parse(vma, mmap_event->buildid);
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
