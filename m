Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD452A9016
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgKFHOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgKFHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:14:34 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B63C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:14:34 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id h6so255640pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6hIImNRnU9cgbmxIIbosNrDfQ1fw4BJiExYh05cGrVo=;
        b=fsVJL39F/dBNGipzDNkM1dCZnsNJ3fBUnu630YD3xO8ImShiYeWPgje2vKSGCrF+ly
         30tNA9MYJhgYNpA2MAz9uaV9WM46yLRiYPgc1N4h7aEJgmfG9S9ncmuuvlOu8cinFXSG
         igmaPoQsEfuJM+92m7fQRwvv4dc716gcLunk8HGT/JU8+U9eCksmUfXQC/032Cfvu0g0
         o2PdMp0EIQg03jSYMwZEZGyPhb1NvKsIcCxSAtAiXRnVOLdH/64aQFxz41W2DwPRVud/
         MeuwdWD2nHJAPxjqZBUhpRfcYJSm/lA6ACxLu4A77zeqVkVN0bj/StGWFEktnQqHmse5
         ew0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6hIImNRnU9cgbmxIIbosNrDfQ1fw4BJiExYh05cGrVo=;
        b=YtJCqfs1TXbYWDIHZtklJpfpvxN134TX/zcBp9PhKMiekIVJunht8Ccn3EaMZ3wC7M
         SpmPKriMoWmWODaeVCYCje/n3+LxrOX1w0kegh3pjDmTlhxldXXePb04Lle0GaR5Uzck
         NkA9txcvuzYEDzysMajN4ZVgVN+J8W4nlvD+XrL+/rVLAiK2u3QbPxdQ2UBXiR654SYM
         yI020ruxleCQT8h6jOPFP4VLBcydZqxL7zXT6nzPbV0btGT6QLKbcfgmdkvGqAWYZh34
         zWD5d+ttGZd8Jyw/wt9Vs1Vb0jarDxMH3309smcQXdxyBTQs+PPb1KiYRJIzV5Ad/s+E
         3Fhg==
X-Gm-Message-State: AOAM531/XIrloczu6DmhA1rAh3qQLycFQ0Ol4itWQBb28aeuorEfBkTT
        02Em91sLJyNXV/ieukfH2eCkkFs3+hU6o8Ht
X-Google-Smtp-Source: ABdhPJz5XPcq4MAZ3pYcr4Ajim+EB6OVrNRi6M08jrMIudLSVO+kKYyr1tGKQKg886UJtHZVpijMeQ==
X-Received: by 2002:a17:90a:474b:: with SMTP id y11mr998795pjg.114.1604646873941;
        Thu, 05 Nov 2020 23:14:33 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f19sm782687pfa.82.2020.11.05.23.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:14:33 -0800 (PST)
Date:   Thu, 05 Nov 2020 23:14:33 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 22:59:38 PST (-0800)
Subject:     Re: [RFC PATCH 3/3] RISC-V: Enable Microchip PolarFire ICICLE SoC
In-Reply-To: <20201028232759.1928479-4-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        padmarao.begari@microchip.com, daire.mcnamara@microchip.com,
        Cyril.Jean@microchip.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-b5dd0def-a774-43e9-ae39-026f5b2411b9@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 16:27:59 PDT (-0700), Atish Patra wrote:
> Enable Microchip PolarFire ICICLE soc config in defconfig.
> It allows the default upstream kernel to boot on PolarFire ICICLE board.

I don't actually have one of these to test on yet.  That said, if it boots for
you then I don't really see any reason to delay this -- maybe there's some
issues floating around, but I don't really see any reason to delay putting this
on for-next.  I'd even go so far as to say we should take it during the RCs, as
so far it's just build/DT stuff.

Given that this is currently the only production RISC-V Linux board I don't
really any reason not to add it to the defconfigs.

Is there a reason this is an RFC?

>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/configs/defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index d222d353d86d..2660fa05451e 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -16,6 +16,7 @@ CONFIG_EXPERT=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
> +CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SMP=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
> @@ -79,6 +80,9 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_CADENCE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
>  CONFIG_RTC_CLASS=y

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
