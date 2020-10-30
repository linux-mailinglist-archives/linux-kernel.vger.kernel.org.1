Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0421F2A00D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJ3JJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3JJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:09:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666D6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:09:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a9so5571308wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfUnFTOfSXFG25x3BnIgOzcDN4IPlLEtsgB9WMJzOuA=;
        b=eSDiZBsdVeZ8YhjpBNK5ZgQZWSgQI5Mysm8lQ5TsGB2ZqMUdGhEFIZP0VVXlfMcKUm
         LwPd8O3SIgi+6vu/tXHEeeU5K9mHbQELrYgErcweripmTqaSfkaydOeJidaFvanXfJF2
         8NsNV450bLQ0tB+LEYEGZIkv3HbBIQr4uUz9AT3g7vq97ZJtf/SbHZk/vpqr1f0nSmmh
         RzYdh3Yli3/CeK2CMtGvCgC50qQAT7iXmNNKrUEa0VVC3fDCR7zFXvsl7GFmDapfrU2W
         LRzQo9BWPe95GLGk0Mur0lzUE7SqBeACwPzrbqLJ8ONVm2cUNvOj1miLDmYYNjlcSxK+
         FNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfUnFTOfSXFG25x3BnIgOzcDN4IPlLEtsgB9WMJzOuA=;
        b=bdQBIrji0Y124dGfZpoGv+LmWfpgKjY61bE3qP/pXPRjTZnbmbMuBhXicRP/kg/Iub
         AuveXM4CAs6UPHzt+V0AVxts8CYWQhGffpNYgOxbs0F25S32+MD1pzlgkjZkR+TIvZQH
         EwNcW8hHRfbhTFNXnYQgB/VL07EVWds5keBUiE4hLdtCxOEncE9QUmniA4mnvik0XD3U
         ydgd3azwbnkcSR5OdYkmzj+iCLDcCWKTnRlBUbgr04ftieEvZ5HGxxagx5eBdJZemiY4
         J87xsFCZ0A6+DvytfMs9kOutAQ2lLTHi7ywCWzKmpmG3TviohD9m1VUJqxxoTNlhulZl
         vzMw==
X-Gm-Message-State: AOAM532v8zDImjxeJzjt2oZQrJS8dy4Pcsc6WcGb1Y8NzxQ/J2WJgPQ1
        fBWzlvcb86XM2xVFjhEiDSrFUgw6KImNrjbx0nQxsA==
X-Google-Smtp-Source: ABdhPJyA9i/Zk/3TmJNQX1c4BPqrlSQfKCOiUmrNfi7O3zDzfW1MV/RUDeOTVF3R3BgHfJ1Qhnt5xSnKRxgMdqlarFM=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr1797680wru.356.1604048995074;
 Fri, 30 Oct 2020 02:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-4-atish.patra@wdc.com>
In-Reply-To: <20201028232759.1928479-4-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 30 Oct 2020 14:39:43 +0530
Message-ID: <CAAhSdy0bgeCLYNTELdyFPj9_W1N6kDTwS6rUmLLnM=N3pTAp0g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] RISC-V: Enable Microchip PolarFire ICICLE SoC
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Padmarao Begari <padmarao.begari@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 4:58 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Enable Microchip PolarFire ICICLE soc config in defconfig.
> It allows the default upstream kernel to boot on PolarFire ICICLE board.
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
> --
> 2.25.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
