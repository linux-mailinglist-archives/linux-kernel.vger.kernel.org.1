Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C480D2A40D2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKCJzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgKCJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:55:23 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA98DC0613D1;
        Tue,  3 Nov 2020 01:55:22 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id b138so14303849yba.5;
        Tue, 03 Nov 2020 01:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aPHJUg5B3RUfQUFOOBY1vaKVKuqoNKBnfLkp7Eh0jM=;
        b=XVOnFxkHJAJZNHnA/v6Gq5JtUIinsSxGpS1KEgaNga35aGZxYKXo9IhsmUMpabmFr+
         B/c++uqqz8D6VcZr3NW/+TB93t/w+uW75HKVQK5IXbE2s0dIbnTQAVZVeaDveBy74hD7
         1KxggN5i1R8j93SWOxqSKj8bnhuP+6lekISChsMZUelgOTTSPeoXTnkwkL3vRgfYyECB
         hzxJZCGOqjnkmT1xOgFFwKHLdeH6eZ16WCDY1xGZvs4HGVXHbvCs3G/FDbhJT1yS9Knj
         hVLFLdtNzbE+LDNBaEeNKq4lX77kWoA/Vbwjy2QLKRaANDjVlnnRQQ/wV1d05n9ZJU/w
         h8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aPHJUg5B3RUfQUFOOBY1vaKVKuqoNKBnfLkp7Eh0jM=;
        b=Nr+bKZXNS2e1kCwANdVFru7gNiOQJy2WLRr4aZvx3Xy4U74xb466FTF/n+MnBWurL+
         yGh6AhWia/SLrDsKJUCqlo6GBSk09pWYBjegJipBq20MtR3LLg04oDTrxc3cmVVr6CDV
         nsr7iKYdLzAkjSRt9cH6sqRgYv2hQdVCumJkMwxLBJ0zsBUh6Fnlae+QlKKY4eYt1xZA
         viyukh66s3MRnbZdkEvleu6byf3SqjhD2533PcBzItPdldzQsxxoAFdsiLtGB5LslUQ8
         EB0CisdL+JywAel34y3kYVMQ4/YfcaZ4hP7ky2gRZ3dYkEINuniFpResZPNv5osvmwh+
         yThg==
X-Gm-Message-State: AOAM53121Tqubx7YOlIM0OAP8NhrsZzHvwueErwaM729M4XKQV7ojbjY
        316MDXjUQaMXI3V7Rkg2T4Y3Z6jFAPE04YwkW6M=
X-Google-Smtp-Source: ABdhPJw+K7g1mkaqrzx+t32l56UmOR6oKyXcs5lnQ5hnNBVOjKohJrQmXNa3LmrQ7CBbbSxAwn/P2bm1FOIk29WCzzs=
X-Received: by 2002:a25:bacd:: with SMTP id a13mr29382343ybk.387.1604397322266;
 Tue, 03 Nov 2020 01:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20201028232759.1928479-1-atish.patra@wdc.com> <20201028232759.1928479-2-atish.patra@wdc.com>
In-Reply-To: <20201028232759.1928479-2-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 3 Nov 2020 17:55:10 +0800
Message-ID: <CAEUhbmXknfx58q0Ae0MAZLT3zQuqGyAXXn1wDxHP36LQzew2Jw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] RISC-V: Add Microchip PolarFire SoC kconfig option
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
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

On Thu, Oct 29, 2020 at 6:00 PM Atish Patra <atish.patra@wdc.com> wrote:
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

Please put this in the alphabetical order

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

Otherwise LGTM
Reviewed-by: Bin Meng <bin.meng@windriver.com>
