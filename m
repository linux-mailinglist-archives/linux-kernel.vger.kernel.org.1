Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7F2A00BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgJ3JIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgJ3JI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:08:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:08:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so6069034lji.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3nqhr01eQvSJI6e+N1t85n2JUuDRDQvN6DV/F+qtOg=;
        b=Pbc9yb6+BtXWo1L5tuGBtUvLjbqwm8vybLhFatacNFqibwrwzRpTS1ds3Zvak0xcKM
         V8P8DuKXdbc+a6Ys+3QbJ5f5quGNRRmM0WyphpMhiJGoqAPyXW04d2UyiYyatvzvLNrh
         4gKHIvkWMvdV3C++5KUU95Ml4r3h/PIVS7ve1IglLFYhMmtShvv8EyNSBp9/5IY5OsPr
         qTejUAekNMJwYtQesHJ7J6nFxSnAY0XDT9GIRrSpg3W4+sPzais1l89GOmnJJPjxqyQ2
         AHcyCbdLkBHEYCRJH0aXliCp/mXw00OYwaPBEML+r4pIIweZ6TMnfi6jLYoOslg8IipD
         MWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3nqhr01eQvSJI6e+N1t85n2JUuDRDQvN6DV/F+qtOg=;
        b=T277O1HgB6EgPDLiytTEJYCKTiGAtXoMFVEBvpOI8XQzP2rp/vxwvbSKAtFlWpBazT
         qDR689FO22nQOZ4XfB0blbItV7QrjBWjrWMfUIptaAqxCIehPBOyiequnvdSxMT6ZSid
         RlraToWsUr/eCaFKoqemeWkeAGhn+5/nfoUlZB/PKqOioYStf6JpajAuXAjT2C+9G4ax
         XDbRXsLAqfH+/Ux6kxy5/VYrukIZ+H5hIfcrwdn7gerDMr6sbTtOR1+z7RlIjmiYlYZm
         Kh3yR//MsfdJuTCxpO+w7920ffKnI9uGkVkOt7MA2eD1cSXEZKgYDm2XjZD+k0iI3RgM
         jzuA==
X-Gm-Message-State: AOAM5307nFMs5NTQJGS8TpOrylLL5F9h6N3wfi47DZBUj0mODgGO+Lxa
        3MWfSJAYn/hTeNtl3J4cGp5xVj0UTgz+rGs0vEr1BA==
X-Google-Smtp-Source: ABdhPJxkLrO+rJWRgS6d7zV8/ubv9r6UYekRS16NxBfxGeFBlNnomGPzrvg/AntYqT8EDdFMBhFZ1RH0FCIF+gOiV0k=
X-Received: by 2002:a2e:819a:: with SMTP id e26mr623157ljg.469.1604048907900;
 Fri, 30 Oct 2020 02:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-2-atish.patra@wdc.com>
In-Reply-To: <20201028232759.1928479-2-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 30 Oct 2020 14:38:16 +0530
Message-ID: <CAAhSdy3bf6gTrb5qA8aHm+KzrZQTKqSdBkGNpN1k_+_Vn3=uuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] RISC-V: Add Microchip PolarFire SoC kconfig option
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
> Add Microchip PolarFire kconfig option which selects SoC specific
> and common drivers that is required for this SoC.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig.socs | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 8a55f6156661..74d07250ecc5 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -22,6 +22,13 @@ config SOC_VIRT
>         help
>           This enables support for QEMU Virt Machine.
>
> +config SOC_MICROCHIP_POLARFIRE
> +       bool "Microchip PolarFire SoCs"
> +       select MCHP_CLK_PFSOC
> +       select SIFIVE_PLIC
> +       help
> +         This enables support for Microchip PolarFire SoC platforms.
> +
>  config SOC_KENDRYTE
>         bool "Kendryte K210 SoC"
>         depends on !MMU
> --
> 2.25.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
