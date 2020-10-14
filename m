Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DA828E03E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgJNMCu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Oct 2020 08:02:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgJNMCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:02:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F5A3AC6D;
        Wed, 14 Oct 2020 12:02:48 +0000 (UTC)
Date:   Wed, 14 Oct 2020 14:02:47 +0200
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     <airlied@linux.ie>, <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH drm/hisilicon 2/2] drm/hisilicon: Use the same style of
 variable type in hibmc_drm_drv
Message-ID: <20201014140247.154ed8ee@linux-uq9g>
In-Reply-To: <1601449988-41463-3-git-send-email-tiantao6@hisilicon.com>
References: <1601449988-41463-1-git-send-email-tiantao6@hisilicon.com>
        <1601449988-41463-3-git-send-email-tiantao6@hisilicon.com>
Organization: SUSE Software Solutions Germany GmbH
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, 30 Sep 2020 15:13:08 +0800 Tian Tao <tiantao6@hisilicon.com> wrote:

> Consistently Use the same style of variable type in hibmc_drm_de.c and
> hibmc_drm_de.h.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 13 ++++++-------
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  8 ++++----
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c index 5632bce..0c1b40d
> 100644 --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -121,12 +121,11 @@ static void hibmc_kms_fini(struct hibmc_drm_private
> *priv) /*
>   * It can operate in one of three modes: 0, 1 or Sleep.
>   */
> -void hibmc_set_power_mode(struct hibmc_drm_private *priv,
> -			  unsigned int power_mode)
> +void hibmc_set_power_mode(struct hibmc_drm_private *priv, u32 power_mode)
>  {
> -	unsigned int control_value = 0;
> +	u32 control_value = 0;
>  	void __iomem   *mmio = priv->mmio;
> -	unsigned int input = 1;
> +	u32 input = 1;
>  
>  	if (power_mode > HIBMC_PW_MODE_CTL_MODE_SLEEP)
>  		return;
> @@ -144,8 +143,8 @@ void hibmc_set_power_mode(struct hibmc_drm_private
> *priv, 
>  void hibmc_set_current_gate(struct hibmc_drm_private *priv, unsigned int
> gate) {
> -	unsigned int gate_reg;
> -	unsigned int mode;
> +	u32 gate_reg;
> +	u32 mode;
>  	void __iomem   *mmio = priv->mmio;
>  
>  	/* Get current power mode. */
> @@ -170,7 +169,7 @@ void hibmc_set_current_gate(struct hibmc_drm_private
> *priv, unsigned int gate) 
>  static void hibmc_hw_config(struct hibmc_drm_private *priv)
>  {
> -	unsigned int reg;
> +	u32 reg;
>  
>  	/* On hardware reset, power mode 0 is default. */
>  	hibmc_set_power_mode(priv, HIBMC_PW_MODE_CTL_MODE_MODE0);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h index 6a63502..5c4030d
> 100644 --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -33,8 +33,8 @@ struct hibmc_drm_private {
>  	/* hw */
>  	void __iomem   *mmio;
>  	void __iomem   *fb_map;
> -	unsigned long  fb_base;
> -	unsigned long  fb_size;
> +	u64  fb_base;
> +	u64  fb_size;

resource_size_t would be the correct type here.

With my comments addressed:

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

>  
>  	/* drm */
>  	struct drm_device  *dev;
> @@ -56,9 +56,9 @@ static inline struct hibmc_drm_private
> *to_hibmc_drm_private(struct drm_device * }
>  
>  void hibmc_set_power_mode(struct hibmc_drm_private *priv,
> -			  unsigned int power_mode);
> +			  u32 power_mode);
>  void hibmc_set_current_gate(struct hibmc_drm_private *priv,
> -			    unsigned int gate);
> +			    u32 gate);
>  
>  int hibmc_de_init(struct hibmc_drm_private *priv);
>  int hibmc_vdac_init(struct hibmc_drm_private *priv);



-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
