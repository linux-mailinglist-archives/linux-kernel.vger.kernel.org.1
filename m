Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCCD2C913A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgK3WfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbgK3We7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:34:59 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D64C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:34:13 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id qw4so15056133ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKEdC66hJ5JGLsiLl3hBV9f87nrLsLENnZJ383Beve8=;
        b=Hl4XxdMkJ2RDEu06Xnz1qMbOpFWfnI/RbbLjZwWSXyPJJAyRVk39Q8D+aioSqvMEY3
         dMaprc0g8So5ez4Hj/80hfeEQLeZq9/9t+tGeitb43B2yb7SW3JpgNu/nrkMzRWfTIcK
         nobNVsyfNL/QcUlDv/+SD+93thS85zPFRkf+c6608NjfRq8Iu1IxwyxoBMDKASBy/pe3
         HR/5Y2p7ImfAQoikKXEBwUrLXycWd5nCUBKYbrfFf+1hTHwrnj7zOQza/VV9Ryh+Cdf1
         kf8i57L8gAMsMWdMwaWbKGTPe5XlK4hkiv01xgepkCQzMOuyxQ6TuUFdC03+dIKKY1vp
         epyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKEdC66hJ5JGLsiLl3hBV9f87nrLsLENnZJ383Beve8=;
        b=pkJqRQwN3IjzHjdWt8HRRUtHVH1MOzz4Qt8jSy/jkWVJ5+GvkzGF0Hii/R7Ihe+xyQ
         Xba7c+u2XXEyXeaC0JX8i7W5MOfin9tKohEUQRWcpNj08OiTbeJbf10il9vx2pZKk6QF
         w5PrGHxfcSYUQGBSV0wtGhO6U+FttM2c6sZulMz2b/QqOuebPPVUD+h3L7+9mTlJxPQ7
         tSaYYEevfL2YIicKZ/fo3ObbzF3WzE5ULz5r3+mm/UjsjQ5F/VAwlP0EDWP5hP+chQev
         Arur6YuA4gSG7shWgV/PHF1KuDSSnQmTRQAW7vtDj2Z3VSmqMq/n9edtG4HTOViJFFqX
         UjjQ==
X-Gm-Message-State: AOAM532dEyzD9GrLHt/jJa6bBiQ2iu2uFV8FiCa5eD9cXdtUnNh/F9z0
        pUFliiQlt8D6VwBd+A/fIOl3v9LlTPVTxUydPvOnGA==
X-Google-Smtp-Source: ABdhPJy4mx9bz7eZi5E2l30s9A9eHdahnGhj0teAoOlrytTn7Qa2iVKl14LEOUHYXZY+466a9ZU6/pKEl8bMCpCk9Jc=
X-Received: by 2002:a17:906:1c8e:: with SMTP id g14mr9809987ejh.5.1606775651902;
 Mon, 30 Nov 2020 14:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20200820162738.33053904@oasis.local.home> <20201022173434.910879-1-lpy@google.com>
 <CA+0soA=JR45Tad6+0jCDoiXPk_ctDmmFhg9NtPRrMFb9fM3V0Q@mail.gmail.com>
In-Reply-To: <CA+0soA=JR45Tad6+0jCDoiXPk_ctDmmFhg9NtPRrMFb9fM3V0Q@mail.gmail.com>
From:   Peiyong Lin <lpy@google.com>
Date:   Mon, 30 Nov 2020 14:33:59 -0800
Message-ID: <CA+0soAkd3nq0ys1TQ3m8DxMAT4-EGfo7obQ9OrGQ15bipT=wTA@mail.gmail.com>
Subject: Re: [PATCH v4] Add power/gpu_frequency tracepoint.
To:     Steven Rostedt <rostedt@goodmis.org>, alexdeucher@gmail.com
Cc:     android-kernel@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        Prahlad Kilambi <prahladk@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        zzyiwei@android.com, Sidath Senanayake <sidaths@google.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 1:31 PM Peiyong Lin <lpy@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 10:34 AM Peiyong Lin <lpy@google.com> wrote:
> >
> > Historically there is no common trace event for GPU frequency, in
> > downstream Android each different hardware vendor implements their own
> > way to expose GPU frequency, for example as a debugfs node.  This patch
> > standardize it as a common trace event in upstream linux kernel to help
> > the ecosystem have a common implementation across hardware vendors.
> > Toolings in the Linux ecosystem will benefit from this especially in the
> > downstream Android, where this information is critical to graphics
> > developers.
> >
> > Signed-off-by: Peiyong Lin <lpy@google.com>
> > ---
> >
> > Changelog since v3:
> >  - Correct copyright title.
> >
> > Changelog since v2:
> >  - Add more comments to indicate when the event should be emitted.
> >  - Change state to frequency.
> >
> > Changelog since v1:
> >  - Use %u in TP_printk
> >
> >  drivers/gpu/Makefile                    |  1 +
> >  drivers/gpu/trace/Kconfig               |  3 +++
> >  drivers/gpu/trace/Makefile              |  1 +
> >  drivers/gpu/trace/trace_gpu_frequency.c | 13 ++++++++++
> >  include/trace/events/power.h            | 33 +++++++++++++++++++++++++
> >  5 files changed, 51 insertions(+)
> >  create mode 100644 drivers/gpu/trace/trace_gpu_frequency.c
> >
> > diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> > index 835c88318cec..f289a47eb031 100644
> > --- a/drivers/gpu/Makefile
> > +++ b/drivers/gpu/Makefile
> > @@ -6,3 +6,4 @@ obj-$(CONFIG_TEGRA_HOST1X)      += host1x/
> >  obj-y                  += drm/ vga/
> >  obj-$(CONFIG_IMX_IPUV3_CORE)   += ipu-v3/
> >  obj-$(CONFIG_TRACE_GPU_MEM)            += trace/
> > +obj-$(CONFIG_TRACE_GPU_FREQUENCY)              += trace/
> > diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
> > index c24e9edd022e..ac4aec8d5845 100644
> > --- a/drivers/gpu/trace/Kconfig
> > +++ b/drivers/gpu/trace/Kconfig
> > @@ -2,3 +2,6 @@
> >
> >  config TRACE_GPU_MEM
> >         bool
> > +
> > +config TRACE_GPU_FREQUENCY
> > +       bool
> > diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
> > index b70fbdc5847f..2b7ae69327d6 100644
> > --- a/drivers/gpu/trace/Makefile
> > +++ b/drivers/gpu/trace/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
> > +obj-$(CONFIG_TRACE_GPU_FREQUENCY) += trace_gpu_frequency.o
> > diff --git a/drivers/gpu/trace/trace_gpu_frequency.c b/drivers/gpu/trace/trace_gpu_frequency.c
> > new file mode 100644
> > index 000000000000..668fabd6b77a
> > --- /dev/null
> > +++ b/drivers/gpu/trace/trace_gpu_frequency.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * GPU frequency trace points
> > + *
> > + * Copyright (C) 2020 Google LLC
> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/power.h>
> > +
> > +EXPORT_TRACEPOINT_SYMBOL(gpu_frequency);
> > diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> > index af5018aa9517..343825a76953 100644
> > --- a/include/trace/events/power.h
> > +++ b/include/trace/events/power.h
> > @@ -500,6 +500,39 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
> >
> >         TP_ARGS(name, type, new_value)
> >  );
> > +
> > +/**
> > + * gpu_frequency - Reports the GPU frequency in GPU clock domains.
> > + *
> > + * This event should be emitted whenever there's a GPU frequency change happens,
> > + * or a GPU goes from idle state to active state, or vice versa.
> > + *
> > + * When the GPU goes from idle state to active state, this event should report
> > + * the GPU frequency of the active state. When the GPU goes from active state to
> > + * idle state, this event should report a zero frequency value.
> > + *
> > + * @frequency:  New frequency (in KHz)
> > + * @gpu_id: Id for each GPU clock domain
> > + */
> > +TRACE_EVENT(gpu_frequency,
> > +
> > +       TP_PROTO(unsigned int frequency, unsigned int gpu_id),
> > +
> > +       TP_ARGS(frequency, gpu_id),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(unsigned int, frequency)
> > +               __field(unsigned int, gpu_id)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->frequency = frequency;
> > +               __entry->gpu_id = gpu_id;
> > +       ),
> > +
> > +       TP_printk("frequency=%u gpu_id=%u",
> > +               __entry->frequency, __entry->gpu_id)
> > +);
> >  #endif /* _TRACE_POWER_H */
> >
> >  /* This part must be outside protection */
> > --
> > 2.29.0.rc1.297.gfa9743e501-goog
> >
>
>
> Hi there,
>
> Per request, re-send this patch with dri-devel@ list CCed.
>
> Thanks,
> Peiyong

Hi there,

For GPU drivers folks in dri-devel@ list, any input?

Thanks,
Peiyong
