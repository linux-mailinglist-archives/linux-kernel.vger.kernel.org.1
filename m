Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0A2F24A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404845AbhALAZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404122AbhAKXbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:31:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 075EF22D57;
        Mon, 11 Jan 2021 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610407829;
        bh=wY6WyJnyn9l1uwrWbWHDhefPmOISumjIE80nS7nbeWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y8T4muPUcBgbTVPe7FTnsA5LKfJuPHHRfgndFWSilgpS0ZTgL/ptC/wZULassWj6C
         4j8UKWV2fGSGgERGw9SoY1PeqwbalopJtlD9dPVfdiASi0c20eHH0o/GEc4oPKIBSP
         JDjPEN6T3MhIMKlxeJiaa+1QuaE09Vs/01xG4u7gz+PWESD9aclM+MqTuLGm22tbkO
         AesCFZj8KgUyL040eHfiXr2KHrhFYXTUAVv69fe9uQtS8pgwl03f3Tl71em2RdpFqf
         TwGMv2zOFfqpAyyu1tGdiWoxYpJ/b949IU6vwY7SPoEKYBVMHDNCkE0hJ4KqskE8WD
         mBArExwmnNqcw==
Received: by mail-ed1-f48.google.com with SMTP id g24so271331edw.9;
        Mon, 11 Jan 2021 15:30:28 -0800 (PST)
X-Gm-Message-State: AOAM5321hTBmvIrGX11l2GtwmFJvqHE1qvbY3mu8YvXD27mjFvzGMfXJ
        YUQUdGYFdqpDwPtC6XT+V50jMtOZdq+WCgegWw==
X-Google-Smtp-Source: ABdhPJw/nqrPwedUsYYELvqmQQV2DVc/qTFoJ6TexxxOKDBI8IG/Cky1sIApLzU+/jMMXRGHkDWXdP+ADAPgZ8NARYQ=
X-Received: by 2002:a50:fc96:: with SMTP id f22mr1283182edq.162.1610407827487;
 Mon, 11 Jan 2021 15:30:27 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 12 Jan 2021 07:30:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8aUJQJimDk8gy-Jc8JXtdOmvm_+2eKnYp1p_CDbF_=dQ@mail.gmail.com>
Message-ID: <CAAOTY_8aUJQJimDk8gy-Jc8JXtdOmvm_+2eKnYp1p_CDbF_=dQ@mail.gmail.com>
Subject: Re: [PATCH v3, 01/15] dt-bindings: mediatek: add description for postmask
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add description for postmask
> postmask is used control round corner for display frame

After changing to 'used to control',

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

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
> index c562cda..9d9ab65 100644
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
> +       "mediatek,<chip>-disp-postmask"         - control round corner fo=
r display frame
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
