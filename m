Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86828EE43
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbgJOIKn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Oct 2020 04:10:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:47584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387827AbgJOIKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:10:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D227EB20A;
        Thu, 15 Oct 2020 08:10:16 +0000 (UTC)
Date:   Thu, 15 Oct 2020 10:10:15 +0200
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     b.zolnierkie@samsung.com, gustavoars@kernel.org, arnd@arndb.de,
        daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: sh_mobile_lcdcfb: Remove redundant null
 check before clk_prepare_enable/clk_disable_unprepare
Message-ID: <20201015101015.6dbd25ce@linux-uq9g>
In-Reply-To: <20201014085722.26069-1-vulab@iscas.ac.cn>
References: <20201014085722.26069-1-vulab@iscas.ac.cn>
Organization: SUSE Software Solutions Germany GmbH
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 08:57:22 +0000 Xu Wang <vulab@iscas.ac.cn> wrote:

> Because clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> b/drivers/video/fbdev/sh_mobile_lcdcfb.c index c1043420dbd3..c0952cc96bdb
> 100644 --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -341,8 +341,7 @@ static void lcdc_wait_bit(struct sh_mobile_lcdc_priv
> *priv, static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
>  {
>  	if (atomic_inc_and_test(&priv->hw_usecnt)) {
> -		if (priv->dot_clk)
> -			clk_prepare_enable(priv->dot_clk);
> +		clk_prepare_enable(priv->dot_clk);
>  		pm_runtime_get_sync(priv->dev);
>  	}
>  }
> @@ -351,8 +350,7 @@ static void sh_mobile_lcdc_clk_off(struct
> sh_mobile_lcdc_priv *priv) {
>  	if (atomic_sub_return(1, &priv->hw_usecnt) == -1) {
>  		pm_runtime_put(priv->dev);
> -		if (priv->dot_clk)
> -			clk_disable_unprepare(priv->dot_clk);
> +		clk_disable_unprepare(priv->dot_clk);
>  	}
>  }
>  



-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
