Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26E22C85C8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgK3Nnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgK3Nnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:43:39 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E48206F9;
        Mon, 30 Nov 2020 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606743778;
        bh=XOgBHPz/V3tzcQ87M9AwtxgpAehQUDA1Xi/TdXN7xMs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IU08llQH7ryG6ji46RvMgvS6GWBWUd5Pqk1ANGEE5KO3nOaGeADN9a0QC7x5FgYAp
         18fLEwPltogLtdbjhjY1NI0qQZNAmBrWPDwP2Hq6DWd9G/yhIUQZHTCvyyj+I2pt/X
         LOsLiMbnLPFqiaERgETfoRAWlqLCnkUBn+y/MahI=
Received: by mail-ot1-f42.google.com with SMTP id f16so11244647otl.11;
        Mon, 30 Nov 2020 05:42:58 -0800 (PST)
X-Gm-Message-State: AOAM532ASuHI1KffnR0mGb+ADtAK9yZhAl/aVC1DAGEkyFEYLobSoh65
        UmAodcpjUn1pC4lp8MM1g+viKlXvHWdU58+Fm7g=
X-Google-Smtp-Source: ABdhPJwE6gHqXSv89hp5ehZefQ3Qo8TpQnuU2cOmgVCzlJWC6i2h1pQ58b4YiPoiweX/9Zrwnsraf5fho2qkU5mLf+g=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr15896825otc.305.1606743777410;
 Mon, 30 Nov 2020 05:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20201130131047.2648960-1-daniel@0x0f.com> <20201130131047.2648960-10-daniel@0x0f.com>
In-Reply-To: <20201130131047.2648960-10-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 30 Nov 2020 14:42:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a15Q=97iWyGu6=2aKfVtrYNL2BgmszHqoqYxFT_uHoP4A@mail.gmail.com>
Message-ID: <CAK8P3a15Q=97iWyGu6=2aKfVtrYNL2BgmszHqoqYxFT_uHoP4A@mail.gmail.com>
Subject: Re: [PATCH 9/9] ARM: mstar: SMP support
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 2:10 PM Daniel Palmer <daniel@0x0f.com> wrote:

> +#ifdef CONFIG_SMP
> +static int mstarv7_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +       struct device_node *np;
> +       u32 bootaddr = (u32) __pa_symbol(secondary_startup_arm);
> +       void __iomem *smpctrl = 0;

The initialization is wrong here: it's not a pointer and the value '0'
is not useful.

> +struct smp_operations __initdata mstarv7_smp_ops  = {
> +       .smp_boot_secondary = mstarv7_boot_secondary,
> +};
> +#endif

So no hotplug operations?

> @@ -78,4 +125,7 @@ static void __init mstarv7_init(void)
>  DT_MACHINE_START(MSTARV7_DT, "MStar/Sigmastar Armv7 (Device Tree)")
>         .dt_compat      = mstarv7_board_dt_compat,
>         .init_machine   = mstarv7_init,
> +#ifdef CONFIG_SMP
> +       .smp            = smp_ops(mstarv7_smp_ops),
> +#endif
>  MACHINE_END

Drop the #ifdef, smp_ops() already makes the assignment conditional.

Or better, use CPU_METHOD_OF_DECLARE() instead of smp_ops.

       Arnd
