Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F27283944
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgJEPMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgJEPMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:12:33 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBAB320874;
        Mon,  5 Oct 2020 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601910750;
        bh=OTdYwMEyL+J44FhDFfQgzJZxz6q76bc6Lh6jwKmwS5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nM7wmTlTuX8R6hHGqmal6NH3CaoOeFSQp8Aib7IWXtH2mBaqcaLd++9AwOC4SH3K8
         4fgb3X0TKzhJsFs+FrE50DinNtT/KbsYnShjJxhWAigmLKLS+BgGuAMzOgodQ7NX84
         dIAQsN+xG4L2W75I1bwD6AmzaOtU/KNMD28jjDI4=
Received: by mail-ej1-f41.google.com with SMTP id a3so12487574ejy.11;
        Mon, 05 Oct 2020 08:12:29 -0700 (PDT)
X-Gm-Message-State: AOAM5302AhgBSEDbGfr4D9/FAYN7j+SsBbxybQ05dZM+x93Up5QB6Y5b
        yjNen7KlYKf9Q5bcMvhaqGxQu0VcvWYrckZl6g==
X-Google-Smtp-Source: ABdhPJxHcaGDOyyyIo/bjLD+yrWmGhwiaOGN1qPppcdcHTNE1w5AmntLhaCL61aXtfLjtQNitBu+7/fe7jtt0Cj46XE=
X-Received: by 2002:a17:906:3b8e:: with SMTP id u14mr162034ejf.127.1601910748378;
 Mon, 05 Oct 2020 08:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201004055024.23542-1-phil.chang@mediatek.com> <CAL_JsqJ4rTChMpn7F--fh1A6bOTZxR4rEM9bbA1rdetXmPDeVA@mail.gmail.com>
In-Reply-To: <CAL_JsqJ4rTChMpn7F--fh1A6bOTZxR4rEM9bbA1rdetXmPDeVA@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 5 Oct 2020 23:12:17 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-5M77vVXuSJiWJK5KVUFXg8m6u054z-CiwVhc1fheDtg@mail.gmail.com>
Message-ID: <CAAOTY_-5M77vVXuSJiWJK5KVUFXg8m6u054z-CiwVhc1fheDtg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] of_reserved_mem: Increase the number of reserved regions
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Phil Chang <phil.chang@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Alix Wu <alix.wu@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Liu <joe.liu@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob:

Rob Herring <robh+dt@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sun, Oct 4, 2020 at 12:50 AM Phil Chang <phil.chang@mediatek.com> wrot=
e:
> >
> > Certain SoCs need to support large amount of reserved memory
> > regions, especially to follow the GKI rules from Google.
> > In MTK new SoC requires more than 68 regions of reserved memory
> > for each IP's usage, such as load firmware to specific sapce,
>
> typo
>
> > so that need to reserve more regisions
>
> typo. Missing punctuation.
>
> >
> > Signed-off-by: Joe Liu <joe.liu@mediatek.com>
> > Signed-off-by: YJ Chiang <yj.chiang@mediatek.com>
> > Signed-off-by: Alix Wu <alix.wu@mediatek.com>
> > Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> > ---
> >  drivers/of/of_reserved_mem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.=
c
> > index 46b9371c8a33..595f0741dcef 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -22,7 +22,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/memblock.h>
> >
> > -#define MAX_RESERVED_REGIONS   64
> > +#define MAX_RESERVED_REGIONS   128
>
> At some point, this starts to feel like abuse of reserved regions.
> Please provide details on what the regions are.
>
> Also, this probably just needs to be dynamic. I think we're at that point=
.

How about using a config like DRM_FBDEV_OVERALLOC [1] ?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/gpu/drm/Kconfig?h=3Dv5.9-rc8#n125

Regards,
Chun-Kuang.

>
> Rob
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
