Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899A42B5345
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgKPUzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKPUzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:55:41 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1106BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:55:41 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r12so18894779iot.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Be144PmpR2r/+3mLxCPcCbcigQoOxzS6Vke1CO1s/GU=;
        b=c1wcBdkONeTDIyTRb5fxCLkD5WeJx0AqEuzOeOBUwczSP+V8/+v5gfe5gM7PW6qNgM
         2FKMdkyrQuMCZ2D2b8jjubyIBXJa3jn9/4UKLTjp8NCbpupJm5YLnKqJBCXIrMWKvQdX
         1pn7vx7Df8NmSN91jUI11BfeBk7c5GiHp6AMgIgG/hVZ1zCrJZh0AX8GClxneQaSa38t
         U9wgZWvttfMrvpsrqlJUfs1+OzbVNMio4oKrLQRd3RVu4Z/N1k9cf25s2hlPYy8kzppp
         /sKROZ7VVr6AgkAJv0YF0PmGB0z8aJvjCr3cyV5afFxN6uyxL7lANugIyDeKIqFHLZdK
         pQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Be144PmpR2r/+3mLxCPcCbcigQoOxzS6Vke1CO1s/GU=;
        b=CHum128lqINzyjyZamBvq81zRxUzUxX9L/fe/GBU4wjt8AuUOAlFr0XCM9M4mWoiAu
         VBrKfc9pD5VMGenahnRaMdfejj7SYNzZrPNlG7gy9EB1CnQaMmgHRZAy3qJUezpmXADJ
         wExl0O+ZcXyjWKcJXuSYv/4EoRI1rHRaF74qB/NIMiBNCEJkbLTpNIfwcIQSmfbJKjHM
         +4OcBPzMO7yzALVZx7CiDtGoxpiNvZDtl7HwVxBRDxGuLmvPijwQmfDXTbtE69deee6u
         1nwftNZWdKigaifB9A5SUv1AjNr7hnFF2wh2dkGp+Q/XaUY+oWy1TuY3f+9k4Gt4rpNq
         DG9Q==
X-Gm-Message-State: AOAM530fi/EIGK7pl1jItmxyEXgXUJlEDjEkumhkc5CkjcKXqxupV3LC
        wJq8Y0dzE+l+jXODrXzqpWCp9Yy8Mr9STPxMJb4/eA==
X-Google-Smtp-Source: ABdhPJyY4x0wcN+Rnb91pciYL8+eiS6j3KSVLPxfw04duPuFPIO+eVe2VczDlFTiwVwqh2Wsjyhxa3bkB+3zd146cKs=
X-Received: by 2002:a6b:6a03:: with SMTP id x3mr4250371iog.96.1605560140084;
 Mon, 16 Nov 2020 12:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20200820162738.33053904@oasis.local.home> <20201022173434.910879-1-lpy@google.com>
In-Reply-To: <20201022173434.910879-1-lpy@google.com>
From:   Peiyong Lin <lpy@google.com>
Date:   Mon, 16 Nov 2020 12:55:29 -0800
Message-ID: <CA+0soAkD7BG6CjhMW6PYR4yAgDykU2uUizcHx1QQdXqgesCFFg@mail.gmail.com>
Subject: Re: [PATCH v4] Add power/gpu_frequency tracepoint.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        android-kernel@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        Prahlad Kilambi <prahladk@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        zzyiwei@android.com, Sidath Senanayake <sidaths@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:34 AM Peiyong Lin <lpy@google.com> wrote:
>
> Historically there is no common trace event for GPU frequency, in
> downstream Android each different hardware vendor implements their own
> way to expose GPU frequency, for example as a debugfs node.  This patch
> standardize it as a common trace event in upstream linux kernel to help
> the ecosystem have a common implementation across hardware vendors.
> Toolings in the Linux ecosystem will benefit from this especially in the
> downstream Android, where this information is critical to graphics
> developers.
>
> Signed-off-by: Peiyong Lin <lpy@google.com>
> ---
>
> Changelog since v3:
>  - Correct copyright title.
>
> Changelog since v2:
>  - Add more comments to indicate when the event should be emitted.
>  - Change state to frequency.
>
> Changelog since v1:
>  - Use %u in TP_printk
>
>  drivers/gpu/Makefile                    |  1 +
>  drivers/gpu/trace/Kconfig               |  3 +++
>  drivers/gpu/trace/Makefile              |  1 +
>  drivers/gpu/trace/trace_gpu_frequency.c | 13 ++++++++++
>  include/trace/events/power.h            | 33 +++++++++++++++++++++++++
>  5 files changed, 51 insertions(+)
>  create mode 100644 drivers/gpu/trace/trace_gpu_frequency.c
>
> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index 835c88318cec..f289a47eb031 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_TEGRA_HOST1X)      += host1x/
>  obj-y                  += drm/ vga/
>  obj-$(CONFIG_IMX_IPUV3_CORE)   += ipu-v3/
>  obj-$(CONFIG_TRACE_GPU_MEM)            += trace/
> +obj-$(CONFIG_TRACE_GPU_FREQUENCY)              += trace/
> diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
> index c24e9edd022e..ac4aec8d5845 100644
> --- a/drivers/gpu/trace/Kconfig
> +++ b/drivers/gpu/trace/Kconfig
> @@ -2,3 +2,6 @@
>
>  config TRACE_GPU_MEM
>         bool
> +
> +config TRACE_GPU_FREQUENCY
> +       bool
> diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
> index b70fbdc5847f..2b7ae69327d6 100644
> --- a/drivers/gpu/trace/Makefile
> +++ b/drivers/gpu/trace/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
> +obj-$(CONFIG_TRACE_GPU_FREQUENCY) += trace_gpu_frequency.o
> diff --git a/drivers/gpu/trace/trace_gpu_frequency.c b/drivers/gpu/trace/trace_gpu_frequency.c
> new file mode 100644
> index 000000000000..668fabd6b77a
> --- /dev/null
> +++ b/drivers/gpu/trace/trace_gpu_frequency.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPU frequency trace points
> + *
> + * Copyright (C) 2020 Google LLC
> + */
> +
> +#include <linux/module.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/power.h>
> +
> +EXPORT_TRACEPOINT_SYMBOL(gpu_frequency);
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index af5018aa9517..343825a76953 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -500,6 +500,39 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
>
>         TP_ARGS(name, type, new_value)
>  );
> +
> +/**
> + * gpu_frequency - Reports the GPU frequency in GPU clock domains.
> + *
> + * This event should be emitted whenever there's a GPU frequency change happens,
> + * or a GPU goes from idle state to active state, or vice versa.
> + *
> + * When the GPU goes from idle state to active state, this event should report
> + * the GPU frequency of the active state. When the GPU goes from active state to
> + * idle state, this event should report a zero frequency value.
> + *
> + * @frequency:  New frequency (in KHz)
> + * @gpu_id: Id for each GPU clock domain
> + */
> +TRACE_EVENT(gpu_frequency,
> +
> +       TP_PROTO(unsigned int frequency, unsigned int gpu_id),
> +
> +       TP_ARGS(frequency, gpu_id),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned int, frequency)
> +               __field(unsigned int, gpu_id)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->frequency = frequency;
> +               __entry->gpu_id = gpu_id;
> +       ),
> +
> +       TP_printk("frequency=%u gpu_id=%u",
> +               __entry->frequency, __entry->gpu_id)
> +);
>  #endif /* _TRACE_POWER_H */
>
>  /* This part must be outside protection */
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>

Hi there,

May I ask whether the merge window has passed? If so is it possible to
ask for a review?

Thanks,
Peiyong
