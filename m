Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61A42DAF61
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgLOOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbgLOOuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:50:10 -0500
X-Gm-Message-State: AOAM5335hZ4wc6d2naPHAqjs/usj6CJOeVFjO/iB9r5oN9JPHrW38Mf5
        DK8Qh2HPvLuL/puzInU23gdFcaU3TZFFOva9NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608043769;
        bh=pcW98idFE8j4CPrJmo7rwXxa0kGRpcZ4oIUzDbC2c/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HPoLcBk9VIqe4+/U+MkqxElc8KoM3OHM8y3hCkubQRLWCE0WGc3ZqIfxv7wJxu41l
         uJ1RSIbwfWFbMv22NqGaJ6yRSetwY33+YD2trssPf3h2l0ezrngjHJCI5SeBt+5o1X
         p7O3WNyttX1eLLzEvZ5OgSDzqazuvVTz9q6ZCZQgeMyj6xKmKfXf9Wi0CvzRsLwB0b
         vMs7rvUc6LIkif5P1VePoQQoiu2WNdQLRSLuuwrZV519O3Vs2lJ0jPJCcN3JlpbtZP
         nW1SesrHlIMF2k90mtr6IhadmEuHVVhkk+4XNEVvzehXeFTVYyezJ+l50dmthTHzJn
         H1G0cvQ1F9obA==
X-Google-Smtp-Source: ABdhPJzVIhS7/7kGUOi+nJf5HUvRGw0qwmZ5xmolBwFv7MPtxTCbsdxcHfV1ADt98+QRviRZJRXHnIf61pDNrmVvoE4=
X-Received: by 2002:adf:e60f:: with SMTP id p15mr3067578wrm.60.1608043767643;
 Tue, 15 Dec 2020 06:49:27 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 15 Dec 2020 22:49:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-=4ZwXgTA57UE9+nZm-0E-B1oimWXfaJuWxufo8LJ+pg@mail.gmail.com>
Message-ID: <CAAOTY_-=4ZwXgTA57UE9+nZm-0E-B1oimWXfaJuWxufo8LJ+pg@mail.gmail.com>
Subject: Re: [PATCH v2, 01/17] dt-bindings: mediatek: add description for postmask
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
> add description for postmask

What is postmask? I google it and find a postmask ECO. So it is postmask EC=
O?

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1=
 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index 5ca693a..1972fa7 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -37,6 +37,7 @@ Required properties (all function blocks):
>         "mediatek,<chip>-disp-aal"              - adaptive ambient light =
controller
>         "mediatek,<chip>-disp-gamma"            - gamma correction
>         "mediatek,<chip>-disp-merge"            - merge streams from two =
RDMA sources
> +       "mediatek,<chip>-disp-postmask"         - post mask
>         "mediatek,<chip>-disp-split"            - split stream to two enc=
oders
>         "mediatek,<chip>-disp-ufoe"             - data compression engine
>         "mediatek,<chip>-dsi"                   - DSI controller, see med=
iatek,dsi.txt
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
