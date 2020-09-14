Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E0D2699C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINXhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgINXhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:37:42 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118AC2193E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600126662;
        bh=g2lsFfYhlO0VEH/BabeBJeUV+CvFozoYV2u4w8DDEBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Is2F32TUQz6dAc2CCZZJbm2PVGfeKFWGtc8X3UHHkFTabwzkYsfVtwx+Z5/4eYyZ6
         5p1HC3vfP/d9JAlvYrRjHyJJ3Tu6Glimmyv6DKj7IPBdaCQFMZrd4WQE3jVpCaU7W+
         9Z+5ch+Q60DGp6haUsuN+RdUQVqSNkckOwja6/6c=
Received: by mail-ej1-f43.google.com with SMTP id r7so2313929ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:37:42 -0700 (PDT)
X-Gm-Message-State: AOAM5301LO7sjs2vnsFE2Zh/dwNGdeDAEbe9GIre6q/UHkjt0ozTYXqI
        lizxQ9yUhAd13oeI2XsURY8oOJ8bZdgX3gb6OA==
X-Google-Smtp-Source: ABdhPJz3pRz8YQcV+pGBgT3eFAaWdp/Z0XMG/X4qOIDHhb5dqpyLXgI9VzxaDFsYQAz61P2dQ2J7GOroEgLbbm8g8bg=
X-Received: by 2002:a17:906:15cc:: with SMTP id l12mr17632462ejd.7.1600126660682;
 Mon, 14 Sep 2020 16:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200905083058.1631726-1-yukuai3@huawei.com>
In-Reply-To: <20200905083058.1631726-1-yukuai3@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 15 Sep 2020 07:37:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9JA-+Rwiwnwp-tYEhmLKpHs-zkDD-FL31oYrYFeYe3xA@mail.gmail.com>
Message-ID: <CAAOTY_9JA-+Rwiwnwp-tYEhmLKpHs-zkDD-FL31oYrYFeYe3xA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: add missing put_device() call in mtk_ddp_comp_init()
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yt.shen@mediatek.com, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yu Kuai:

Yu Kuai <yukuai3@huawei.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=885=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> if of_find_device_by_node() succeed, mtk_ddp_comp_init() doesn't have
> a corresponding put_device(). Thus add put_device() to fix the exception
> handling for this function implementation.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Fixes: d0afe37f5209 ("drm/mediatek: support CMDQ interface in ddp compone=
nt")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 57c88de9a329..526648885b97 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -496,6 +496,7 @@ int mtk_ddp_comp_init(struct device *dev, struct devi=
ce_node *node,
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         if (of_address_to_resource(node, 0, &res) !=3D 0) {
>                 dev_err(dev, "Missing reg in %s node\n", node->full_name)=
;
> +               put_device(&larb_pdev->dev);
>                 return -EINVAL;
>         }
>         comp->regs_pa =3D res.start;
> --
> 2.25.4
>
