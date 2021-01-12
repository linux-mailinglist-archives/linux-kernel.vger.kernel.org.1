Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89882F3FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbhALXKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbhALXKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:10:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78D4723136;
        Tue, 12 Jan 2021 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610492992;
        bh=0nyABi1I6IbH4taoMU8LdjyQhHLxaseiMU9/vMX1KR0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sbovZzbeFJgifUDQV6OfTlsFv8x0Syu8Dw9ldR+eHROYAH3KszT1DYse3BzCKeJsr
         qWwvJ4VIjMg8HUHrO0AAdrRf+FH9vjPcfdb4HZC46HRKpCMXwNdSlKBA31R6NI2RFo
         xebqqRHLQkJaOSKXIbCCutgSfCM+9vcHQ8KXdiwtpKYouZSImcEtubsYRR3ytFsRV/
         M2Hc3yd/tUMbmExxC4tUogz6aNe5nOlsscWpP4/gjsKnR3CwS0+W0RWcbEolWJt6/d
         2eokurBSDvsK/xWbxSnpSlaIEjym1JZxskxtgE9K7G2Qtmw3PH4F3PvLwwGlWQxQMt
         5raltDROxOfrg==
Received: by mail-ej1-f46.google.com with SMTP id t16so305900ejf.13;
        Tue, 12 Jan 2021 15:09:52 -0800 (PST)
X-Gm-Message-State: AOAM5333uebeWr16VbrtGqlRko6QyXBBTVfvZRKLa9bGe5RiW4GAcQQt
        GNvEM6UeW6KpK4hd1gMGYN0RoBTvQapaN43Tgg==
X-Google-Smtp-Source: ABdhPJwP64jmhjn4D+dF85A/6b6TbFHN8xXLISjTvjsyFKbBPrJtBOL7OecdSuy90tRVPSF9pUMEob05jWopgh4yEjg=
X-Received: by 2002:a17:906:fb1a:: with SMTP id lz26mr791422ejb.194.1610492990879;
 Tue, 12 Jan 2021 15:09:50 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-10-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-10-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 13 Jan 2021 07:09:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8qDAy=hmbuyxuJTqp3nG_ZqiYHpP0fp4C5Zvs4tKeoNA@mail.gmail.com>
Message-ID: <CAAOTY_8qDAy=hmbuyxuJTqp3nG_ZqiYHpP0fp4C5Zvs4tKeoNA@mail.gmail.com>
Subject: Re: [PATCH v3, 09/15] drm/mediatek: Add pm runtime support for gamma
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
        Yidi Lin <yidi.lin@mediatek.com>,
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
> gamma power domain need controled in the device.

In this series, why only gamma and color add pm runtime support? I
think all ddp component need pm runtime support. And pm runtime
support is not related to mt8192, so move these patches out of this
series.

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Yidi Lin <yidi.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/=
mediatek/mtk_disp_gamma.c
> index 3c1ea07..da93079 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -10,6 +10,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/soc/mediatek/mtk-cmdq.h>
>
>  #include "mtk_drm_crtc.h"
> @@ -156,6 +157,8 @@ static int mtk_disp_gamma_probe(struct platform_devic=
e *pdev)
>
>         platform_set_drvdata(pdev, priv);
>
> +       pm_runtime_enable(dev);
> +
>         ret =3D component_add(dev, &mtk_disp_gamma_component_ops);
>         if (ret)
>                 dev_err(dev, "Failed to add component: %d\n", ret);
> @@ -165,6 +168,8 @@ static int mtk_disp_gamma_probe(struct platform_devic=
e *pdev)
>
>  static int mtk_disp_gamma_remove(struct platform_device *pdev)
>  {
> +       pm_runtime_disable(&pdev->dev);
> +
>         component_del(&pdev->dev, &mtk_disp_gamma_component_ops);
>
>         return 0;
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
