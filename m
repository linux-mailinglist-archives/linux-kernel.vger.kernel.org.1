Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839472842E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 01:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJEXQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 19:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgJEXQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 19:16:48 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E647D20853;
        Mon,  5 Oct 2020 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601939807;
        bh=6DMPlpHNHe4zYX2cCxmqu0FZ0HVxYMhqiIb/DWSRMTI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H+b6kenMeWsX9eq+4bPl2RCSDUICLwxdkRcGYM/TXz4OOuu1uD9NgoRzZIlFj5t0g
         gpu3fAOxggZHgfW5CRKUgDcavU8OJAeSsZnlHfeWDd51fiRlYIacqvMd3XebH5z4Lh
         ErQL7BIX8FSUiKiUFArd5+sy+lTGLB8TK3H5LiIM=
Received: by mail-ej1-f54.google.com with SMTP id lw21so10662842ejb.6;
        Mon, 05 Oct 2020 16:16:46 -0700 (PDT)
X-Gm-Message-State: AOAM5336x4O5AvY0tAR8FD3B+LiQ+OyNXeP5n4lrNvgQbHtkVJ55WmxU
        jdm6dt//4zX3FSdJzwBBWhGfFHaBqlZQwuP/Lw==
X-Google-Smtp-Source: ABdhPJz+Lh5Br5zMq2O8/0TV2SM0C8V3geQcrgh1DjX05SgjXPF8trpetHJx9SOXrPdjPK+KRKeszl906LIvVUbBr4I=
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr2114998ejd.310.1601939805305;
 Mon, 05 Oct 2020 16:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201004055024.23542-1-phil.chang@mediatek.com>
 <CAAOTY_8vCb-adkbpdmbTWLeOFt-+dHjr4HVonHX7XPkLkzy1yA@mail.gmail.com>
 <1601918237.17256.3.camel@mtksdccf07> <CAL_JsqJQcWsguwfehAoaRf4o-2VqXxSzKzTqg7s4+N1bp=6V5Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJQcWsguwfehAoaRf4o-2VqXxSzKzTqg7s4+N1bp=6V5Q@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 6 Oct 2020 07:16:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8iGY_-_6iOxgigjbQc8k6iD38BAQiMi9vWEkddCGPJ9g@mail.gmail.com>
Message-ID: <CAAOTY_8iGY_-_6iOxgigjbQc8k6iD38BAQiMi9vWEkddCGPJ9g@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] of_reserved_mem: Increase the number of reserved regions
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Phil Chang <phil.chang@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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

Rob Herring <robh+dt@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Oct 5, 2020 at 12:17 PM Phil Chang <phil.chang@mediatek.com> wrot=
e:
> >
> > Hi Chun-Kuang
>
> Please don't top post to the lists.
>
> > Sorry for typo. In fact, the dts of new SoC is not upstream yet. I'm so
> > sorry for couldn't show the detail now.
>
> Don't have to have the dts upstream. Can you point to a downstream dts
> or post a snippet of the reserved memory?
>
> > How about the configurable MAX_RESERVED_REGIONS size like this patch?
> > https://patchwork.kernel.org/patch/10692101/
>
> No, as I already said in that patch. But glad you found what's needed
> to make it dynamic. But even for dynamic, I want to understand the
> use.

I get the point. We should prevent too many config. If this
information could be get from dts, we should not get it from config.
Agree that WHY of this patch is more important than HOW of this patch.

Regards,
Chun-Kuang.

>
> Rob
>
> >
> >
> > On Sun, 2020-10-04 at 21:05 +0800, Chun-Kuang Hu wrote:
> > > Hi, Phil:
> > >
> > > Phil Chang <phil.chang@mediatek.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=
=884=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=881:51=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > >
> > > > Certain SoCs need to support large amount of reserved memory
> > > > regions, especially to follow the GKI rules from Google.
> > > > In MTK new SoC requires more than 68 regions of reserved memory
> > > > for each IP's usage, such as load firmware to specific sapce,
> > >
> > > space
> > >
> > > > so that need to reserve more regisions
> > >
> > > regions.
> > >
> > > I guess this requirement is from Mediatek SoC, but I find below devic=
e
> > > tree and just find one reserved memory region,
> > >
> > > arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > > arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > > arch/arm64/boot/dts/mediatek/mt8516.dtsi
> > >
> > > Could you show me the 68 regions?
> > >
> > > Regards,
> > > Chun-Kuang.
> > >
> > > >
> > > > Signed-off-by: Joe Liu <joe.liu@mediatek.com>
> > > > Signed-off-by: YJ Chiang <yj.chiang@mediatek.com>
> > > > Signed-off-by: Alix Wu <alix.wu@mediatek.com>
> > > > Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> > > > ---
> > > >  drivers/of/of_reserved_mem.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_=
mem.c
> > > > index 46b9371c8a33..595f0741dcef 100644
> > > > --- a/drivers/of/of_reserved_mem.c
> > > > +++ b/drivers/of/of_reserved_mem.c
> > > > @@ -22,7 +22,7 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/memblock.h>
> > > >
> > > > -#define MAX_RESERVED_REGIONS   64
> > > > +#define MAX_RESERVED_REGIONS   128
> > > >  static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
> > > >  static int reserved_mem_count;
> > > >
> > > > --
> > > > 2.18.0
> > > > _______________________________________________
> > > > Linux-mediatek mailing list
> > > > Linux-mediatek@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >
