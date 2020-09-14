Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608BD268B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgINMxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:53:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44625 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgINMs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:48:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id s12so18560946wrw.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vlodagcs22zibyjAPJ5wkLwD6Gf2F5qWiI3JD8jZYsQ=;
        b=qC9C3N9+rdw3iLl5qzvmdCJLQAeQmadtzo2LnMjp0X8v0Ju3JB5e7M7FBWBwbZr3T9
         ib2bifDPu4TbMLXvB1M6eTzXmtSYyfWDX4wgiMWe7wUzCwKtx0WHkJfNK3Ak2pFXmaOA
         bV2JGuG1mtPMjJ2F5pWl/unZSbRDe6hylIrQQqsoVqgUt86zU+y7gaUnREvBpxpYPza7
         vCmscwVmLId9KHxZOt0rk3x1XVMt60SQ5N7AkJwi4QAxydEd83AnMCsFYA9zskq8MFcb
         I+UbykEghMyGTGOVfAMaDM/kWVKcijnA2d1YGTJXUBtbVdkHn5+wez7cyONqfwVogY1f
         UIgw==
X-Gm-Message-State: AOAM532vWHpqH64BEhAzB1D0+U59BovbMakc6iHLUxcB3lvLlPk+lnAP
        Fbpy9/grnb/kOsZHqPdBUfiwHf1fv6bHlxSZ+cM=
X-Google-Smtp-Source: ABdhPJzfXebMcTIcP3VuxaK0KNmDajg+JlhKL+03BerqsLLLWO0vfjbdTd003Mh+CktpWyDIqOmbs6kNHO22IU02vYY=
X-Received: by 2002:adf:a418:: with SMTP id d24mr7943993wra.80.1600087734486;
 Mon, 14 Sep 2020 05:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200910104153.1672460-1-jolsa@kernel.org> <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
 <20200910144744.GA1663813@krava> <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com>
 <20200911074931.GA1714160@krava>
In-Reply-To: <20200911074931.GA1714160@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 21:48:43 +0900
Message-ID: <CAM9d7cicyzZvkrXTvSrGrOE626==myvF2hnuUNiUoLXiOKHB+A@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix race in perf_mmap_close function
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Wade Mealing <wmealing@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 4:49 PM Jiri Olsa <jolsa@redhat.com> wrote:
> ugh, that's right.. how about change below

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


>
> jirka
>
>
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7ed5248f0445..8ab2400aef55 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5868,11 +5868,11 @@ static void perf_pmu_output_stop(struct perf_event *event);
>  static void perf_mmap_close(struct vm_area_struct *vma)
>  {
>         struct perf_event *event = vma->vm_file->private_data;
> -
>         struct perf_buffer *rb = ring_buffer_get(event);
>         struct user_struct *mmap_user = rb->mmap_user;
>         int mmap_locked = rb->mmap_locked;
>         unsigned long size = perf_data_size(rb);
> +       bool detach_rest = false;
>
>         if (event->pmu->event_unmapped)
>                 event->pmu->event_unmapped(event, vma->vm_mm);
> @@ -5903,7 +5903,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>                 mutex_unlock(&event->mmap_mutex);
>         }
>
> -       atomic_dec(&rb->mmap_count);
> +       if (atomic_dec_and_test(&rb->mmap_count))
> +               detach_rest = true;
>
>         if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
>                 goto out_put;
> @@ -5912,7 +5913,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>         mutex_unlock(&event->mmap_mutex);
>
>         /* If there's still other mmap()s of this buffer, we're done. */
> -       if (atomic_read(&rb->mmap_count))
> +       if (!detach_rest)
>                 goto out_put;
>
>         /*
>
