Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41622E27B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 15:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgLXO3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 09:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgLXO3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 09:29:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A2CD224B0;
        Thu, 24 Dec 2020 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608820129;
        bh=avuCDzNbHj2dpF1wMtlr+eCWDnDVKL9dKK9/kgnxfs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ENCPJqaoTtx/w/gjRxswEHbm+8HVvkn/o6ithsijzpCIyPfZxK6j1NMT5Bqr0GEGI
         nJVwGA+Av6dt/xpjmGqyZ0IerOW/S1adE0iqYlvt0jFYaEoV/sc4DI1VKJR/6/4Uu+
         lNaBlogIq22j485Mm06pp3JZi3HVh0MxQ3EkbAUlgpSVgK7mBmF0L/hsLNbRCJnGRJ
         +J437zPckoQBf8YfDHgLzoGb+sQdGWxdfEDRl4E9vbSvHVONERHw+PCh/jPLTvwvNJ
         c4QetSUTVX0uPyqGtPdArOXyrscuH+NmJzl8L4QcKU299UfhUOUzMDaZU0rZGoTxYm
         XdnBTAc/QCFJQ==
Received: by mail-ej1-f53.google.com with SMTP id ga15so3548438ejb.4;
        Thu, 24 Dec 2020 06:28:49 -0800 (PST)
X-Gm-Message-State: AOAM533OZaL7yBReB98C49ZxlvvI9wJXl+oWVkzHA4+nhtBbn36ERmuZ
        uubFOhz0z4/YU4lcUAn+5B3TU7pCsOek0lNtsA==
X-Google-Smtp-Source: ABdhPJz4FZaQVqFZ83WxFt3Fe2+BmFRA28vGU8ERYHuq8sPphR3iLihx8v6LeP10GlrFZUcP3U+83p989lbPDy9D1OQ=
X-Received: by 2002:a17:907:9627:: with SMTP id gb39mr28660682ejc.267.1608820128218;
 Thu, 24 Dec 2020 06:28:48 -0800 (PST)
MIME-Version: 1.0
References: <1608770889-9403-1-git-send-email-yongqiang.niu@mediatek.com> <1608770889-9403-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1608770889-9403-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 24 Dec 2020 22:28:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9e9qadeO9k7zQnvSLZAAJFxjWwYSBz-XXEUUh16jsptA@mail.gmail.com>
Message-ID: <CAAOTY_9e9qadeO9k7zQnvSLZAAJFxjWwYSBz-XXEUUh16jsptA@mail.gmail.com>
Subject: Re: [PATCH v2, 3/3] mailbox: cmdq: add mt8192 support
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:55=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add mt8192 support
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 75378e3..7f243e1 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -607,6 +607,7 @@ static int cmdq_probe(struct platform_device *pdev)
>         {.compatible =3D "mediatek,mt8173-gce", .data =3D (void *)&gce_pl=
at_v2},
>         {.compatible =3D "mediatek,mt8183-gce", .data =3D (void *)&gce_pl=
at_v3},
>         {.compatible =3D "mediatek,mt6779-gce", .data =3D (void *)&gce_pl=
at_v4},
> +       {.compatible =3D "mediatek,mt8192-gce", .data =3D (void *)&gce_pl=
at_v4},

In the view of hardware function, is mt8192-gce identical to
mt6779-gce? If these two are identical, you need not to modify driver,
and the compatible should be

compatible =3D "mediatek,mt8192-gce", "mediatek,mt6779-gce";

If they are not identical, what's the different?

Regards,
Chun-Kuang.

>         {}
>  };
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
