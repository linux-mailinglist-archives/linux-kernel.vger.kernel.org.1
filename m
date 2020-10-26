Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DAB29999D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394171AbgJZWZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:25:35 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37650 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394113AbgJZWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:25:35 -0400
Received: by mail-il1-f195.google.com with SMTP id y17so10622711ilg.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhnLh9Zc0nPouSEKwRorWay32zoFBTTF0SDuN2VaMBI=;
        b=qunfsM1kxnBXcsgS8cv5wkKS2IZ+EoYe2vQ3/aG7PQtArjYvyUm2UsdN3trqFa2FY3
         Dyub1Ad2NYAcCTTY7Q+3QxLWnOr8nukBgqN3n8p2eHl1+K5YmTtaO0VL2EwTQSdDL48r
         5nSLD/PoVsREvmHS5GM2DdLa+pHlGSnAUXKXRdsQolP4WE2kUxMKQlwrDRlXIaTRGMUe
         XmZFFAhq/PpYuRKS9b7ndgzFOKChxfhUTpxOHhP5Q6Ej+usoZPKiMabiwhtJXcnPZkzJ
         R9jSreyBr7Oy8wHXGnwao32StXucHfhXJzRj2iGpN6fkmn9nK9PmDs3t8c2i+tPyOaH+
         tv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhnLh9Zc0nPouSEKwRorWay32zoFBTTF0SDuN2VaMBI=;
        b=sAyGmAqqnuzfahEvQKhIWTFtuzJsOLeAmkKLKRQJGXifekNMozK669m/OEcZYlgWx4
         q1f+sDebBOF6QKLB3qmPzdsXDYlnighID3opdIUd/yx7eU7f0EE0qtKXXb1MceeE5Cmi
         O3YAuf3o12+MWB0NtJpaPzrX+2twkcTOfHCIPJtE+HBggBzUXjMLzWRp13qU50+yAEiF
         JrapOowCEyBPPdr6bBlxOmSunDeIpWGm4XfdF8eONQTGkVf0NwIIqjzZT45akgLltJXl
         dGmKGo+Tl9CBS7OXDMCWEbspGKk3+9CGsLJketvuTMTTCGuiXGpvYBUdEkUu7tJ5d/HY
         RYAA==
X-Gm-Message-State: AOAM533Tngg7D4A07XB7202E1QE16zvE1vNWjtG9/JyCIB6FkNSWy00j
        qF3I0UbHMtWztfWVoCfmUuTQgSqaCm1ZztGd+rWHo2KFd9s=
X-Google-Smtp-Source: ABdhPJyqO/pxu9BFKgwTdkGicsPROnlzx8pSCMyW4DusFXMtTANLFzNn8NlKlgW6B9+s/oDWtX07PpNqFEGX2E8PmWA=
X-Received: by 2002:a92:a182:: with SMTP id b2mr12026557ill.148.1603751133721;
 Mon, 26 Oct 2020 15:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200820162738.33053904@oasis.local.home> <20201022173434.910879-1-lpy@google.com>
In-Reply-To: <20201022173434.910879-1-lpy@google.com>
From:   Peiyong Lin <lpy@google.com>
Date:   Mon, 26 Oct 2020 15:25:22 -0700
Message-ID: <CA+0soA=rrZcHsHt2oGqk0sn7QuJu=TQBdbOHPc1+UupRbWbgZg@mail.gmail.com>
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

Hi there,

May I ask for a review please?

Thanks,
Peiyong


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
