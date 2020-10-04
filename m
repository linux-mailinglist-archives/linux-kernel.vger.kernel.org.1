Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA456282AD2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJDNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 09:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgJDNFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 09:05:24 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F1C206C1;
        Sun,  4 Oct 2020 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601816723;
        bh=b3VJELJHxJ+kqWcCs/bmj4n7ROvR4MBKkbSqU/Xk2ng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S75llJuXkVhNsHZ9NWtMK4on87LqyYF/Iol5MUK9nXxATt9zimtt+R0/1e5tJxb6A
         tUy7MhK5MtGrRV39paO+SOjzompHmL7LJgBbSP13hCTaaGEmuOqpa+TOkwgY3mDQp8
         mJOHw1f0cHu1kYjM5SOBqDoZpTnWJK42au+cEfAo=
Received: by mail-ed1-f45.google.com with SMTP id w1so6580461edr.3;
        Sun, 04 Oct 2020 06:05:23 -0700 (PDT)
X-Gm-Message-State: AOAM533gzDEFEtTIiH1sTQ1NMuhOmdjKtbuECpMX3HPp5YC3fUdJj1Pp
        0DMeknFOkmDnjzm/bOd3N/YXyF6ZkAaEatOv+g==
X-Google-Smtp-Source: ABdhPJzRNV8rMjJitmmvOwtnDM7OTxut1f/+0PXkBKVhYNYUdoWjJXy+wH0JoZphp5SwJc6HEG+LVPNFmEUc31+vzrY=
X-Received: by 2002:a05:6402:c12:: with SMTP id co18mr12243824edb.162.1601816721815;
 Sun, 04 Oct 2020 06:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201004055024.23542-1-phil.chang@mediatek.com>
In-Reply-To: <20201004055024.23542-1-phil.chang@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 4 Oct 2020 21:05:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8vCb-adkbpdmbTWLeOFt-+dHjr4HVonHX7XPkLkzy1yA@mail.gmail.com>
Message-ID: <CAAOTY_8vCb-adkbpdmbTWLeOFt-+dHjr4HVonHX7XPkLkzy1yA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] of_reserved_mem: Increase the number of reserved regions
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Alix Wu <alix.wu@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Liu <joe.liu@mediatek.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Phil:

Phil Chang <phil.chang@mediatek.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=884=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=881:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Certain SoCs need to support large amount of reserved memory
> regions, especially to follow the GKI rules from Google.
> In MTK new SoC requires more than 68 regions of reserved memory
> for each IP's usage, such as load firmware to specific sapce,

space

> so that need to reserve more regisions

regions.

I guess this requirement is from Mediatek SoC, but I find below device
tree and just find one reserved memory region,

arch/arm64/boot/dts/mediatek/mt7622.dtsi
arch/arm64/boot/dts/mediatek/mt8173.dtsi
arch/arm64/boot/dts/mediatek/mt8516.dtsi

Could you show me the 68 regions?

Regards,
Chun-Kuang.

>
> Signed-off-by: Joe Liu <joe.liu@mediatek.com>
> Signed-off-by: YJ Chiang <yj.chiang@mediatek.com>
> Signed-off-by: Alix Wu <alix.wu@mediatek.com>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 46b9371c8a33..595f0741dcef 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -22,7 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/memblock.h>
>
> -#define MAX_RESERVED_REGIONS   64
> +#define MAX_RESERVED_REGIONS   128
>  static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
>  static int reserved_mem_count;
>
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
