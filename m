Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9E2C0DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbgKWOak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:30:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731451AbgKWOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:30:40 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 092A720758
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606141839;
        bh=KLPAvAxVgBh/EfteBChKMiZqtTEU7DgUM7QQy95Ctjw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oz5Qll+2GGuPXYNZD0KEIT0+NXyIoujW0YGhpVvWA1FWHd+TCwDjW19QSXMQYNCjI
         xgIjgFoOSb92kD33i7Z5Z3JgOTRU+Wwqxdw7Gum4PfO7n0ZyVXRRRyfLoFDAkKiH/8
         XtPTs+pr8Zn0Locs8zgeHHPmJz6DNzDX4P0WucaU=
Received: by mail-ed1-f51.google.com with SMTP id cq7so17294151edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:30:38 -0800 (PST)
X-Gm-Message-State: AOAM533NaGF3mWjVqf0UfZRxF0LwKZdrceNSmvCRGDHYqZh2R58DPKQm
        3WLXNBXZ7wBpaLCgnWMeceA4NNc/8STF95RHGw==
X-Google-Smtp-Source: ABdhPJzQPN09/o15bRrKCutv+RWMNNb2GzylRxTOKOSHwYw5WeYSFcIdLyi0ge0oOxLKG1dWvGEHZCmCSdfuKLitYdk=
X-Received: by 2002:a50:f742:: with SMTP id j2mr39313857edn.72.1606141837508;
 Mon, 23 Nov 2020 06:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-8-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-8-lee.jones@linaro.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 23 Nov 2020 22:30:25 +0800
X-Gmail-Original-Message-ID: <CAAOTY_90iwNUChw46qeetimRPtA16Ws573sXDo0XaKRgogKVUA@mail.gmail.com>
Message-ID: <CAAOTY_90iwNUChw46qeetimRPtA16Ws573sXDo0XaKRgogKVUA@mail.gmail.com>
Subject: Re: [PATCH 07/40] drm/mediatek/mtk_disp_rdma: Fix formatting and
 supply missing struct member description
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lee:

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter=
 or member 'ddp_comp' not described in 'mtk_disp_rdma'
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter=
 or member 'crtc' not described in 'mtk_disp_rdma'
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c:66: warning: Function parameter=
 or member 'data' not described in 'mtk_disp_rdma'
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index e04319fedf463..d46b8ae1d0800 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -56,8 +56,9 @@ struct mtk_disp_rdma_data {
>
>  /**
>   * struct mtk_disp_rdma - DISP_RDMA driver structure
> - * @ddp_comp - structure containing type enum and hardware resources
> - * @crtc - associated crtc to report irq events to
> + * @ddp_comp: structure containing type enum and hardware resources
> + * @crtc: associated crtc to report irq events to
> + * @data: local driver data
>   */
>  struct mtk_disp_rdma {
>         struct mtk_ddp_comp             ddp_comp;
> --
> 2.25.1
>
