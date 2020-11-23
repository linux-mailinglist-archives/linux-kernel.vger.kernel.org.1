Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30662C0DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbgKWOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730138AbgKWOaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:30:00 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA71520781
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606141799;
        bh=0PG9sY/7kjLC2BEUJJD7uXQqxRjzgGOvNgsyi7FCsBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hbbz43XKlcQvVplsZFIcT5hsKkYI9fWwgORdTxxV+osw6Lxxzw5u+ktlCJ8wjrK2/
         Z5zSxlmHaMmWfbqFe+HZSIXBuGT6FUYg6EYpEmx2ut11nzTVKI1ETPw6z/uCleGzLo
         zyZk80qz1TpskOwQ8hsOulxq6GA8K//3cFqNdlWw=
Received: by mail-ed1-f51.google.com with SMTP id q3so17254711edr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:29:58 -0800 (PST)
X-Gm-Message-State: AOAM5339mdJrgWIIMTsH16QXPuDiVjQEmadvnEq/ZS31FX4qpNU3CAb1
        MxGq8QrVQ5JecBw92SEr+nvIAEOrJ/a6iJWukA==
X-Google-Smtp-Source: ABdhPJwHSc8rFuh9ehjBm9YKuZooHOGW+0h0xXZqHkKhXMPDEqgmgVdpEM6Eg0UZfQjSb1pTx0AQWx+IJMvN12Wrf+Q=
X-Received: by 2002:a50:f1d2:: with SMTP id y18mr13451389edl.166.1606141797356;
 Mon, 23 Nov 2020 06:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20201112190039.2785914-1-lee.jones@linaro.org> <20201112190039.2785914-31-lee.jones@linaro.org>
In-Reply-To: <20201112190039.2785914-31-lee.jones@linaro.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 23 Nov 2020 22:29:45 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-hTb_yur9QVynKggdY69-E2vJ2-qj3i7+LPzsBJkdy1g@mail.gmail.com>
Message-ID: <CAAOTY_-hTb_yur9QVynKggdY69-E2vJ2-qj3i7+LPzsBJkdy1g@mail.gmail.com>
Subject: Re: [PATCH 30/30] drm/mediatek/mtk_disp_ovl: Fix formatting and
 provide missing member description
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
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=883:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c:75: warning: Function parameter =
or member 'ddp_comp' not described in 'mtk_disp_ovl'
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c:75: warning: Function parameter =
or member 'crtc' not described in 'mtk_disp_ovl'
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c:75: warning: Function parameter =
or member 'data' not described in 'mtk_disp_ovl'

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
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
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 28651bc579bc9..74ef6fc0528b6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -65,8 +65,9 @@ struct mtk_disp_ovl_data {
>
>  /**
>   * struct mtk_disp_ovl - DISP_OVL driver structure
> - * @ddp_comp - structure containing type enum and hardware resources
> - * @crtc - associated crtc to report vblank events to
> + * @ddp_comp: structure containing type enum and hardware resources
> + * @crtc: associated crtc to report vblank events to
> + * @data: platform data
>   */
>  struct mtk_disp_ovl {
>         struct mtk_ddp_comp             ddp_comp;
> --
> 2.25.1
>
