Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D12C1ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 02:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgKXBNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 20:13:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36838 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgKXBNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 20:13:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id y24so12282527otk.3;
        Mon, 23 Nov 2020 17:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m15TpcUJVqEKAQ3JOtMNdbRW68L7bTvdLomIqDVX8rk=;
        b=EmD2OhIxHXMjXZx0lbAD62ehSuEKrtJve0JPBC6pOMujvPjxVKe9uWRS4ExrDkoimU
         SECmcNAA4+lrUW4kDFf+d7MEnHOyxJFRuI+b1Psrc35RGrlGRqmGPHOLva+NN6jaLNBb
         9CMA2OCBbngSgDJc37aflQSbAavOcM5BobdwVmKy5/HPEoLk7CtT852c6hj93tK34tJ6
         Q30mS+OmYkMvyGpEk2tDiMXy6MmB1Cv8lsSpKf6bE4t7gIj37BLthqNPkm4hDgmce6EO
         TyNGX5TK9o4FulXySi1VJGr5Or6LyYHVTVpP/pRR25BxfaCqFoiU9ZlIJpUILBa//2xj
         jixA==
X-Gm-Message-State: AOAM532iR2yK7Y47o8EkawIAeOjbRXwj4cJJwSEDHmO5xP311rgs/iFI
        tyPnMcYDoenolQ5b9S8RBu8Fw+9XtiVYRQ==
X-Google-Smtp-Source: ABdhPJzq9fnGKsQwBB248aFFRYi8gyP+FOsoxhH9+AfoDFrgEWSppI5Sl15mOFK4KTBHRKoI9RpuKQ==
X-Received: by 2002:a9d:261:: with SMTP id 88mr1576576otb.202.1606180402670;
        Mon, 23 Nov 2020 17:13:22 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id z25sm8818327ooj.39.2020.11.23.17.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 17:13:21 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id z24so3821588oto.6;
        Mon, 23 Nov 2020 17:13:21 -0800 (PST)
X-Received: by 2002:a05:6830:160d:: with SMTP id g13mr1693295otr.74.1606180401496;
 Mon, 23 Nov 2020 17:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20201102072652.34893-1-ran.wang_1@nxp.com>
In-Reply-To: <20201102072652.34893-1-ran.wang_1@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 23 Nov 2020 19:13:09 -0600
X-Gmail-Original-Message-ID: <CADRPPNR6-xJ8Oc2J-c=Pa8vdvRpfAvf6tSzfBS0zNqCRbe-BzQ@mail.gmail.com>
Message-ID: <CADRPPNR6-xJ8Oc2J-c=Pa8vdvRpfAvf6tSzfBS0zNqCRbe-BzQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] soc: fsl: handle RCPM errata A-008646 on SoC LS1021A
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 1:37 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> From: Biwen Li <biwen.li@nxp.com>
>
> Hardware issue:
> - Reading register RCPM_IPPDEXPCR1 always return zero, this causes
>   system firmware could not get correct information and wrongly do
>   clock gating for all wakeup source IP during system suspend. Then
>   those IPs will never get chance to wake system.
>
> Workaround:
> - Copy register RCPM_IPPDEXPCR1's setting to register SCFG_SPARECR8
>   to allow system firmware's psci method read it and do things accordingly.
>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied for next.  Thanks.

> ---
> Change in v4:
>  - Replace property 'fsl,ippdexpcr1-alt-reg' with compatible checking as the
>    workaround trigger condition.
>
> Change in v3:
>  - Add  copy_ippdexpcr1_setting(), simplize workaournd's implementation
>    according to binding update.
>  - Minor update on commit message.
>
> Change in v2:
>  - Update commit message to be more clear.
>  - Replace device_property_read_u32_array() with syscon_regmap_lookup_by_phandle_args()
>    to make code simpler.
>
>  drivers/soc/fsl/rcpm.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
> index a093dbe..4ace28c 100644
> --- a/drivers/soc/fsl/rcpm.c
> +++ b/drivers/soc/fsl/rcpm.c
> @@ -2,7 +2,7 @@
>  //
>  // rcpm.c - Freescale QorIQ RCPM driver
>  //
> -// Copyright 2019 NXP
> +// Copyright 2019-2020 NXP
>  //
>  // Author: Ran Wang <ran.wang_1@nxp.com>
>
> @@ -22,6 +22,28 @@ struct rcpm {
>         bool            little_endian;
>  };
>
> +#define  SCFG_SPARECR8 0x051c
> +
> +static void copy_ippdexpcr1_setting(u32 val)
> +{
> +       struct device_node *np;
> +       void __iomem *regs;
> +       u32 reg_val;
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-scfg");
> +       if (!np)
> +               return;
> +
> +       regs = of_iomap(np, 0);
> +       if (!regs)
> +               return;
> +
> +       reg_val = ioread32be(regs + SCFG_SPARECR8);
> +       iowrite32be(val | reg_val, regs + SCFG_SPARECR8);
> +
> +       iounmap(regs);
> +}
> +
>  /**
>   * rcpm_pm_prepare - performs device-level tasks associated with power
>   * management, such as programming related to the wakeup source control.
> @@ -90,6 +112,17 @@ static int rcpm_pm_prepare(struct device *dev)
>                         tmp |= ioread32be(address);
>                         iowrite32be(tmp, address);
>                 }
> +               /*
> +                * Workaround of errata A-008646 on SoC LS1021A:
> +                * There is a bug of register ippdexpcr1.
> +                * Reading configuration register RCPM_IPPDEXPCR1
> +                * always return zero. So save ippdexpcr1's value
> +                * to register SCFG_SPARECR8.And the value of
> +                * ippdexpcr1 will be read from SCFG_SPARECR8.
> +                */
> +               if (dev_of_node(dev) && (i == 1))
> +                       if (of_device_is_compatible(np, "fsl,ls1021a-rcpm"))
> +                               copy_ippdexpcr1_setting(tmp);
>         }
>
>         return 0;
> --
> 2.7.4
>
