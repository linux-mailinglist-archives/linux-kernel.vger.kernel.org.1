Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347112F24AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404933AbhALAZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404157AbhAKXkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:40:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA7CC22D37;
        Mon, 11 Jan 2021 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610408401;
        bh=SUTe1YRrwFqH+vKzLDa3Og8DsDF1ZslKpsxpjuqS79Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C4SRUzfgdqbPO9+4zUA34idzVN/yden/m5HsHWYfd+XTYEC++Ui3SBEj9nck9hOfE
         liCL2d1S7L9webHpS/jmoyOYZmy8YXGdkpcwsluC+HdaXv1tARWHsI+obIHm43W25g
         01vJ5Ja8Utn61uvTSuBj7VYppOyrWA5/YFeuZn/LY16G1cYgXAjC5K7iIeG6QA1gI1
         sXRDVQ+Tr8x2KfPkY8zCHFu6Rq2a3Y+bhjlMM9mZN36UMh23iDBG2lqkni4bZkEzun
         fWv/hmKidkno64/wf8cgGW1mU/9gbiUw4xrRlduZO+cQSAxU+qObUIgzyezXiW3O7f
         s81LcVzYZWBNw==
Received: by mail-ej1-f41.google.com with SMTP id q22so891406eja.2;
        Mon, 11 Jan 2021 15:40:00 -0800 (PST)
X-Gm-Message-State: AOAM531ts4hCkUxiVbLUc0/rkARl05fTI+plgDtapxjfCFbbTXGhKVL+
        V8q8MfBW9WNmmgN6Awr5e8jUOLJ3PegV1PNyIg==
X-Google-Smtp-Source: ABdhPJy3eFEmLOMrjiND05dS8vMTb4vPOL8mvRHpetE+fXbs9sEJc5/Jr5lXrVgBYYr+sVlxdWA4fZ74fE5DQFk/WR4=
X-Received: by 2002:a17:906:3753:: with SMTP id e19mr1211701ejc.267.1610408399484;
 Mon, 11 Jan 2021 15:39:59 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 12 Jan 2021 07:39:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_91MUXgQg3zF=4Cjb4xAW+FKKXQKGSGE0YsTgO855_LiQ@mail.gmail.com>
Message-ID: <CAAOTY_91MUXgQg3zF=4Cjb4xAW+FKKXQKGSGE0YsTgO855_LiQ@mail.gmail.com>
Subject: Re: [PATCH v3, 02/15] dt-bindings: mediatek: add description for
 mt8192 display
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

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add description for mt8192 display

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 2=
 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index 9d9ab65..b47e1a0 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -44,7 +44,7 @@ Required properties (all function blocks):
>         "mediatek,<chip>-dpi"                   - DPI controller, see med=
iatek,dpi.txt
>         "mediatek,<chip>-disp-mutex"            - display mutex
>         "mediatek,<chip>-disp-od"               - overdrive
> -  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173 and mt8=
183.
> +  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173, mt8183=
 and mt8192.
>  - reg: Physical base address and length of the function block register s=
pace
>  - interrupts: The interrupt signal from the function block (required, ex=
cept for
>    merge and split function blocks).
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
