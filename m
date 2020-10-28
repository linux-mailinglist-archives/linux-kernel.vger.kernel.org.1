Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4329DCEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgJ1WU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731701AbgJ1WRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EEBD24752
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603891697;
        bh=0AiJ6MSBrV2gPFEgikjETnPmWhL6QMosoYBf9SDsHoQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uX0CxCQmE4ChbPYlWywtxnXbQGD1Zx5QAn7p9cnuZwe1tVkrr+5/5F94S1CZc/+gL
         v2M0004jWAffs3DZ1gZaq3Q0otUSTxGADaHrO3E8vQLsmOHBAYn0WPWh7P4sRP8MCQ
         8xescS9waMNhyuD8jpE5QYBMHZGz8nvGKiWlqInk=
Received: by mail-ot1-f47.google.com with SMTP id f97so4196370otb.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 06:28:17 -0700 (PDT)
X-Gm-Message-State: AOAM531mS8mpM3I61NCm9kOIopH4ygOeb5V3kzSEsoJjA/GQhpD85So0
        xTjfMLPqbeURPKRxDSQnVYRENPHK7JNkq+2zPA==
X-Google-Smtp-Source: ABdhPJxg/z0xH24jY8WHeX7E/ADveeXjUn6uv+v73d9gdV2qlIx7mSpqQbSEC9CurRjtGBuMiBRfZmItePVuqn0k5DA=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr5250175otm.129.1603891696733;
 Wed, 28 Oct 2020 06:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <1589953889-30955-1-git-send-email-peng.fan@nxp.com> <1589953889-30955-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1589953889-30955-2-git-send-email-peng.fan@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Oct 2020 08:28:05 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+2X-7=MKA4U8SDDwXWEvfTaiSK-tBUi8hMZKpSR+B-=w@mail.gmail.com>
Message-ID: <CAL_Jsq+2X-7=MKA4U8SDDwXWEvfTaiSK-tBUi8hMZKpSR+B-=w@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] ARM: imx: use device_initcall for imx_soc_device_init
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Enrico Weigelt <info@metux.net>,
        Chris Healy <cphealy@gmail.com>,
        Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 1:01 AM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> This is preparation to move imx_soc_device_init to drivers/soc/imx/
>
> There is no reason to must put dt devices under /sys/devices/soc0,
> they could also be under /sys/devices/platform, so we could
> pass NULL as parent when calling of_platform_default_populate.
>
> Following soc-imx8.c soc-imx-scu.c using device_initcall, need
> to change return type to int type for imx_soc_device_init.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 284bce1112d2..85c084a716ab 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -245,21 +245,15 @@ static void __init imx6q_axi_init(void)
>
>  static void __init imx6q_init_machine(void)
>  {
> -       struct device *parent;
> -
>         if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_2_0)
>                 imx_print_silicon_rev("i.MX6QP", IMX_CHIP_REVISION_1_0);
>         else
>                 imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
>                                 imx_get_soc_revision());
>
> -       parent = imx_soc_device_init();
> -       if (parent == NULL)
> -               pr_warn("failed to initialize soc device\n");
> -
>         imx6q_enet_phy_init();
>
> -       of_platform_default_populate(NULL, NULL, parent);
> +       of_platform_default_populate(NULL, NULL, NULL);

I know this is already applied, but really we want to get rid of
of_platform_default_populate calls and let the core code call it. i.MX
is one of the last remaining platforms to fix. This one remained
mainly because of 'parent'. Looks like there's some initcall ordering
issues to fix though. Maybe moving things to init_late works? If not,
moving the setup to drivers would be better if there's any ordering
issues as with deferred probe, initcalls alone don't guarantee the
order.

Rob
