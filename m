Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE222E2CCC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgLZBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgLZBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:17:58 -0500
X-Greylist: delayed 2355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Dec 2020 17:17:17 PST
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38074C061757;
        Fri, 25 Dec 2020 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=HDKYwVqxnSO78kPzjriOKumvWEUA5kK6eRl+PUX8PiE=; b=hS/KU5KpmpzH2Xmp6NEWhFaiWN
        1tieLCIUKXYFRBYtMzRNeKDUgbGObRAuA61rC6FabjpQJhZvqL9ZNkgdwOXNRuJeAT0O89krXeVqi
        gXcz8OZPkv9g0r6/0MzZ90z3doQXeJy5DWX+WlRU8jl05X94wbs/C8Gh4Wvy0+T1J98+Pui4LwW1q
        AhxDG8Sst7oVcQxuOiijAMaECg0IuS8Y2LO0hTEseOR8cw/3kBxsZtYff0I15/ZNxOThoONWLvFk5
        cx/fB7R5Z1aiEDSgSRUarrZBETNGfmrY/CluO8NVYAnKSZxkQwWE60ASEQR9NmPMLd1wQsFZqGa3A
        /n1VkOJg==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1ksxan-0007CO-0F; Sat, 26 Dec 2020 01:37:57 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
        (envelope-from <aurelien@aurel32.net>)
        id 1ksxal-001F6s-09; Sat, 26 Dec 2020 01:37:55 +0100
Date:   Sat, 26 Dec 2020 01:37:54 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bin Meng <bin.meng@windriver.com>, Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <anup.patel@wdc.com>, Conor.Dooley@microchip.com,
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 4/5] RISC-V: Enable Microchip PolarFire ICICLE SoC
Message-ID: <X+aF4q8RyayzTNk3@aurel32.net>
Mail-Followup-To: Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bin Meng <bin.meng@windriver.com>, Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup@brainfault.org>, Anup Patel <anup.patel@wdc.com>,
        Conor.Dooley@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Ivan.Griffin@microchip.com, Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
References: <20201204085835.2406541-1-atish.patra@wdc.com>
 <20201204085835.2406541-5-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204085835.2406541-5-atish.patra@wdc.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-04 00:58, Atish Patra wrote:
> Enable Microchip PolarFire ICICLE soc config in defconfig.
> It allows the default upstream kernel to boot on PolarFire ICICLE board.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
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

I guess this should be CONFIG_MMC_SDHCI=y

> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_CADENCE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
>  CONFIG_RTC_CLASS=y

Regards,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
