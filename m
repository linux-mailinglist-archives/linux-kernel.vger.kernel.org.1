Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23992A6246
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgKDKkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:40:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59162 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbgKDKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:40:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F359A1F458F3
Subject: Re: [PATCH] drm/mediatek: mtk_dpi: Fix unused variable
 'mtk_dpi_encoder_funcs'
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        kernel test robot <lkp@intel.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201005162241.172912-1-enric.balletbo@collabora.com>
Message-ID: <9752ce85-a3e3-1e2f-c9d8-eae729364fee@collabora.com>
Date:   Wed, 4 Nov 2020 11:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005162241.172912-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 5/10/20 18:22, Enric Balletbo i Serra wrote:
> Commit f89c696e7f63 ("drm/mediatek: mtk_dpi: Convert to bridge driver")
> introduced the following build warning with W=1
> 
>  drivers/gpu/drm/mediatek/mtk_dpi.c:530:39: warning: unused variable 'mtk_dpi_encoder_funcs' [-Wunused-const-variable]
>  static const struct drm_encoder_funcs mtk_dpi_encoder_funcs = {
> 
> This struct is and the 'mtk_dpi_encoder_destroy()' are not needed
> anymore, so remove them.
> 
> Fixes: f89c696e7f63 ("drm/mediatek: mtk_dpi: Convert to bridge driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

A gentle ping on this small fix. Thanks,

  Enric

> 
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 589ef33a1780..2609d917e3f9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -522,15 +522,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	return 0;
>  }
>  
> -static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
> -{
> -	drm_encoder_cleanup(encoder);
> -}
> -
> -static const struct drm_encoder_funcs mtk_dpi_encoder_funcs = {
> -	.destroy = mtk_dpi_encoder_destroy,
> -};
> -
>  static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
>  				 enum drm_bridge_attach_flags flags)
>  {
> 
