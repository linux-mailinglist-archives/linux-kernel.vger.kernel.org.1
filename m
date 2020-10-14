Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1641028E020
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgJNL6h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Oct 2020 07:58:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:37802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgJNL6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:58:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0BB14AC6D;
        Wed, 14 Oct 2020 11:58:35 +0000 (UTC)
Date:   Wed, 14 Oct 2020 13:58:33 +0200
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     <airlied@linux.ie>, <daniel@ffwll.ch>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH drm/hisilicon 1/2] drm/hisilicon: Use the same style of
 variable type in hibmc_drm_de
Message-ID: <20201014135833.285ee0e2@linux-uq9g>
In-Reply-To: <1601449988-41463-2-git-send-email-tiantao6@hisilicon.com>
References: <1601449988-41463-1-git-send-email-tiantao6@hisilicon.com>
        <1601449988-41463-2-git-send-email-tiantao6@hisilicon.com>
Organization: SUSE Software Solutions Germany GmbH
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

reviews take a while as I'm very busy ATM.

On Wed, 30 Sep 2020 15:13:07 +0800 Tian Tao <tiantao6@hisilicon.com> wrote:

> Consistently Use the same style of variable type in hibmc_drm_de.c.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 59
> +++++++++++++------------- 1 file changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c index a3a9e0a..c54f93d
> 100644 --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -23,15 +23,15 @@
>  #include "hibmc_drm_regs.h"
>  
>  struct hibmc_display_panel_pll {
> -	unsigned long M;
> -	unsigned long N;
> -	unsigned long OD;
> -	unsigned long POD;
> +	u64 M;
> +	u64 N;
> +	u64 OD;
> +	u64 POD;
>  };
>  
>  struct hibmc_dislay_pll_config {
> -	unsigned long hdisplay;
> -	unsigned long vdisplay;
> +	u64 hdisplay;
> +	u64 vdisplay;
>  	u32 pll1_config_value;
>  	u32 pll2_config_value;
>  };
> @@ -102,7 +102,7 @@ static void hibmc_plane_atomic_update(struct drm_plane
> *plane, struct drm_plane_state	*state	= plane->state;
>  	u32 reg;
>  	s64 gpu_addr = 0;
> -	unsigned int line_l;
> +	u32 line_l;
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(plane->dev);
>  	struct drm_gem_vram_object *gbo;
>  
> @@ -155,10 +155,10 @@ static const struct drm_plane_helper_funcs
> hibmc_plane_helper_funcs = { .atomic_update = hibmc_plane_atomic_update,
>  };
>  
> -static void hibmc_crtc_dpms(struct drm_crtc *crtc, int dpms)
> +static void hibmc_crtc_dpms(struct drm_crtc *crtc, u32 dpms)
>  {
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
> -	unsigned int reg;
> +	u32 reg;
>  
>  	reg = readl(priv->mmio + HIBMC_CRT_DISP_CTL);
>  	reg &= ~HIBMC_CRT_DISP_CTL_DPMS_MASK;
> @@ -172,7 +172,7 @@ static void hibmc_crtc_dpms(struct drm_crtc *crtc, int
> dpms) static void hibmc_crtc_atomic_enable(struct drm_crtc *crtc,
>  				     struct drm_crtc_state *old_state)
>  {
> -	unsigned int reg;
> +	u32 reg;
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
>  
>  	hibmc_set_power_mode(priv, HIBMC_PW_MODE_CTL_MODE_MODE0);
> @@ -191,7 +191,7 @@ static void hibmc_crtc_atomic_enable(struct drm_crtc
> *crtc, static void hibmc_crtc_atomic_disable(struct drm_crtc *crtc,
>  				      struct drm_crtc_state *old_state)
>  {
> -	unsigned int reg;
> +	u32 reg;
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
>  
>  	hibmc_crtc_dpms(crtc, HIBMC_CRT_DPMS_OFF);
> @@ -212,7 +212,7 @@ static enum drm_mode_status
>  hibmc_crtc_mode_valid(struct drm_crtc *crtc,
>  		      const struct drm_display_mode *mode)
>  {
> -	int i = 0;
> +	u32 i = 0;

This is a counter against ARRAY_SIZE. i should be of type 'size_t'.

>  	int vrefresh = drm_mode_vrefresh(mode);
>  
>  	if (vrefresh < 59 || vrefresh > 61)
> @@ -227,9 +227,9 @@ hibmc_crtc_mode_valid(struct drm_crtc *crtc,
>  	return MODE_BAD;
>  }
>  
> -static unsigned int format_pll_reg(void)
> +static u32 format_pll_reg(void)
>  {
> -	unsigned int pllreg = 0;
> +	u32 pllreg = 0;
>  	struct hibmc_display_panel_pll pll = {0};
>  
>  	/*
> @@ -249,7 +249,7 @@ static unsigned int format_pll_reg(void)
>  	return pllreg;
>  }
>  
> -static void set_vclock_hisilicon(struct drm_device *dev, unsigned long pll)
> +static void set_vclock_hisilicon(struct drm_device *dev, u64 pll)
>  {
>  	u32 val;
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> @@ -279,11 +279,10 @@ static void set_vclock_hisilicon(struct drm_device
> *dev, unsigned long pll) writel(val, priv->mmio + CRT_PLL1_HS);
>  }
>  
> -static void get_pll_config(unsigned long x, unsigned long y,
> -			   u32 *pll1, u32 *pll2)
> +static void get_pll_config(u64 x, u64 y, u32 *pll1, u32 *pll2)
>  {
> -	int i;
> -	int count = ARRAY_SIZE(hibmc_pll_table);
> +	u32 i;
> +	u32 count = ARRAY_SIZE(hibmc_pll_table);

These variables should also be size_t.

>  
>  	for (i = 0; i < count; i++) {
>  		if (hibmc_pll_table[i].hdisplay == x &&
> @@ -306,11 +305,11 @@ static void get_pll_config(unsigned long x, unsigned
> long y,
>   * FPGA only supports 7 predefined pixel clocks, and clock select is
>   * in bit 4:0 of new register 0x802a8.
>   */
> -static unsigned int display_ctrl_adjust(struct drm_device *dev,
> -					struct drm_display_mode *mode,
> -					unsigned int ctrl)
> +static u32 display_ctrl_adjust(struct drm_device *dev,
> +			       struct drm_display_mode *mode,
> +			       u32 ctrl)
>  {
> -	unsigned long x, y;
> +	u64 x, y;
>  	u32 pll1; /* bit[31:0] of PLL */
>  	u32 pll2; /* bit[63:32] of PLL */
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> @@ -358,12 +357,12 @@ static unsigned int display_ctrl_adjust(struct
> drm_device *dev, 
>  static void hibmc_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  {
> -	unsigned int val;
> +	u32 val;
>  	struct drm_display_mode *mode = &crtc->state->mode;
>  	struct drm_device *dev = crtc->dev;
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> -	int width = mode->hsync_end - mode->hsync_start;
> -	int height = mode->vsync_end - mode->vsync_start;
> +	u32 width = mode->hsync_end - mode->hsync_start;
> +	u32 height = mode->vsync_end - mode->vsync_start;
>  
>  	writel(format_pll_reg(), priv->mmio + HIBMC_CRT_PLL_CTRL);
>  	writel(HIBMC_FIELD(HIBMC_CRT_HORZ_TOTAL_TOTAL, mode->htotal - 1) |
> @@ -393,7 +392,7 @@ static void hibmc_crtc_mode_set_nofb(struct drm_crtc
> *crtc) static void hibmc_crtc_atomic_begin(struct drm_crtc *crtc,
>  				    struct drm_crtc_state *old_state)
>  {
> -	unsigned int reg;
> +	u32 reg;
>  	struct drm_device *dev = crtc->dev;
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>  
> @@ -446,15 +445,15 @@ static void hibmc_crtc_load_lut(struct drm_crtc *crtc)
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
>  	void __iomem   *mmio = priv->mmio;
>  	u16 *r, *g, *b;
> -	unsigned int reg;
> -	int i;
> +	u32 reg;
> +	u32 i;

This one's correct because crtc->gamma_size is uint32_t.

With my comments addressed:

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

>  
>  	r = crtc->gamma_store;
>  	g = r + crtc->gamma_size;
>  	b = g + crtc->gamma_size;
>  
>  	for (i = 0; i < crtc->gamma_size; i++) {
> -		unsigned int offset = i << 2;
> +		u32 offset = i << 2;
>  		u8 red = *r++ >> 8;
>  		u8 green = *g++ >> 8;
>  		u8 blue = *b++ >> 8;



-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
