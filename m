Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D146A2DC2F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgLPPSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgLPPSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:18:11 -0500
X-Gm-Message-State: AOAM5311izRs3g4Zqaf9eHp8oQQBP6UO4GHpE4UFGy26QK9Q/ODabb4s
        PhrNsTX3Qhk0hayxJmULQjwlZ8O69UtlHdNu6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608131850;
        bh=YOC88DJH1Ldr/FjwTLsg5NLtJ+aB+EfBl/k2z67zy1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d3zPyyMVKaYdL5mltO4VQCc6Hwjmj9nRQPDH6TpXWUQOQ8tS2RTsGSUMuyMGmxQuG
         vt1J6iptJANrfVh0GdiXg2hqdmT38JHCJdvDA5WNs6nb4RPpeBslQuiAyi5EiM0WUl
         Ry6gG/cr5UJiSxuA3OUgt/+Oo51YGH/WCvv02r468d3Wn93Sca7Mmi+OyfY0t9GK3D
         7UZukCc5eNzrKPfF3jt74uit73q6Gge2zvm58xHWt3vjz+fFi34JTndsNRFj/Rj/gn
         JbuZ+Xwo5xOYaOWE7qnWYYto/8aBCdstxFLBE72PdvH4XHQ+VXHHfp+ppkAjvtAHpc
         HT76siTDS9xwg==
X-Google-Smtp-Source: ABdhPJxAAxsNxeLlUnTnLtNubQg6skrY+y2JxetX9D6LYAb9dpqNodHx3+yLdJbf7zIjVVvZiAZDbQ98NMhP+W08ATE=
X-Received: by 2002:a05:600c:25c2:: with SMTP id 2mr3941456wml.170.1608131848789;
 Wed, 16 Dec 2020 07:17:28 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 16 Dec 2020 23:17:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-YjP50QrBKfoCqVnMWp41efbs9wdon4gts5QhUfZO8OA@mail.gmail.com>
Message-ID: <CAAOTY_-YjP50QrBKfoCqVnMWp41efbs9wdon4gts5QhUfZO8OA@mail.gmail.com>
Subject: Re: [PATCH v2, 02/17] dt-bindings: mediatek: add CLK_MM_DISP_CONFIG
 control description for mt8192 display
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=8812=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add CLK_MM_DISP_CONFIG control description for mt8192 displa

display

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 3=
 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index 1972fa7..dfbec76 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -54,6 +54,9 @@ Required properties (all function blocks):
>    DPI controller nodes have multiple clock inputs. These are documented =
in
>    mediatek,dsi.txt and mediatek,dpi.txt, respectively.
>    An exception is that the mt8183 mutex is always free running with no c=
locks property.
> +  An exception is that the mt8192 display add 2 more clocks(CLK_MM_DISP_=
CONFIG, CLK_MM_26MHZ),
> +  and these 2 clocks need enabled before display module work like mutex =
clock, so we add these
> +  2 clocks controled same with mutex clock.

If every display module needs these two clock, add these two clock to
all the display module which need them.

Regards,
Chun-Kuang.

>
>  Required properties (DMA function blocks):
>  - compatible: Should be one of
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
