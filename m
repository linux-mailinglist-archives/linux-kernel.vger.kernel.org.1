Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59685283F25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgJES5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJES5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:57:33 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5E220FC3;
        Mon,  5 Oct 2020 18:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601924252;
        bh=5sBlf2EPxcY+i8bwPmBW/rVdcSRu5idEAY1UAVMD3lY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I2D+EipKP0omGz0Ld3Luie8tPjs8y+9S4HKFn4ya6Q50+mBz4Dq9HHdE9LRbCy1Kb
         bd1O09H814/GO7oBRkovr7Ha3bbtMVhuAJn6k7VJiySYzrXjLC0oxygyLdqK4btkh7
         keddtmnyNEIwAo8gg0gqcRkxXyEf8Cdgx4Cvlz9w=
Received: by mail-oi1-f175.google.com with SMTP id 16so2145303oix.9;
        Mon, 05 Oct 2020 11:57:32 -0700 (PDT)
X-Gm-Message-State: AOAM5312HWpoOejP3wsPplTz14St/U41ibgPlE7YtEb5PALqANP1uckq
        I0CpzfdVM9rFlcfiLfSx2AU85VOjXJtsqkThjg==
X-Google-Smtp-Source: ABdhPJyXdcSo2Li4laYJlNMKjj8n6wrlDkVCgB3+NRhqSkW2Z9SImOMNHT5VmWucvZaU5k4QlTl/x8x+pbU+t/xixj8=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr492047oiy.106.1601924251431;
 Mon, 05 Oct 2020 11:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201004055024.23542-1-phil.chang@mediatek.com>
 <CAAOTY_8vCb-adkbpdmbTWLeOFt-+dHjr4HVonHX7XPkLkzy1yA@mail.gmail.com> <1601918237.17256.3.camel@mtksdccf07>
In-Reply-To: <1601918237.17256.3.camel@mtksdccf07>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Oct 2020 13:57:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJQcWsguwfehAoaRf4o-2VqXxSzKzTqg7s4+N1bp=6V5Q@mail.gmail.com>
Message-ID: <CAL_JsqJQcWsguwfehAoaRf4o-2VqXxSzKzTqg7s4+N1bp=6V5Q@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] of_reserved_mem: Increase the number of reserved regions
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Alix Wu <alix.wu@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Mon, Oct 5, 2020 at 12:17 PM Phil Chang <phil.chang@mediatek.com> wrote:
>
> Hi Chun-Kuang

Please don't top post to the lists.

> Sorry for typo. In fact, the dts of new SoC is not upstream yet. I'm so
> sorry for couldn't show the detail now.

Don't have to have the dts upstream. Can you point to a downstream dts
or post a snippet of the reserved memory?

> How about the configurable MAX_RESERVED_REGIONS size like this patch?
> https://patchwork.kernel.org/patch/10692101/

No, as I already said in that patch. But glad you found what's needed
to make it dynamic. But even for dynamic, I want to understand the
use.

Rob

>
>
> On Sun, 2020-10-04 at 21:05 +0800, Chun-Kuang Hu wrote:
> > Hi, Phil:
> >
> > Phil Chang <phil.chang@mediatek.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=88=
4=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=881:51=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > Certain SoCs need to support large amount of reserved memory
> > > regions, especially to follow the GKI rules from Google.
> > > In MTK new SoC requires more than 68 regions of reserved memory
> > > for each IP's usage, such as load firmware to specific sapce,
> >
> > space
> >
> > > so that need to reserve more regisions
> >
> > regions.
> >
> > I guess this requirement is from Mediatek SoC, but I find below device
> > tree and just find one reserved memory region,
> >
> > arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > arch/arm64/boot/dts/mediatek/mt8516.dtsi
> >
> > Could you show me the 68 regions?
> >
> > Regards,
> > Chun-Kuang.
> >
> > >
> > > Signed-off-by: Joe Liu <joe.liu@mediatek.com>
> > > Signed-off-by: YJ Chiang <yj.chiang@mediatek.com>
> > > Signed-off-by: Alix Wu <alix.wu@mediatek.com>
> > > Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> > > ---
> > >  drivers/of/of_reserved_mem.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_me=
m.c
> > > index 46b9371c8a33..595f0741dcef 100644
> > > --- a/drivers/of/of_reserved_mem.c
> > > +++ b/drivers/of/of_reserved_mem.c
> > > @@ -22,7 +22,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/memblock.h>
> > >
> > > -#define MAX_RESERVED_REGIONS   64
> > > +#define MAX_RESERVED_REGIONS   128
> > >  static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
> > >  static int reserved_mem_count;
> > >
> > > --
> > > 2.18.0
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
