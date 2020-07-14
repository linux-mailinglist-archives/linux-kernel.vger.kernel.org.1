Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1438E21F2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGNNkf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Jul 2020 09:40:35 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:48628 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgGNNkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:40:35 -0400
Received: by unicorn.mansr.com (Postfix, from userid 65534)
        id 0337015360; Tue, 14 Jul 2020 14:40:32 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on unicorn.mansr.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.4
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:8d8e::3])
        by unicorn.mansr.com (Postfix) with ESMTPS id 42A1F15360;
        Tue, 14 Jul 2020 14:40:32 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 392E321A6F3; Tue, 14 Jul 2020 14:40:32 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun4i: hdmi: Fix inverted HPD result
References: <20200711011030.21997-1-wens@kernel.org>
Date:   Tue, 14 Jul 2020 14:40:32 +0100
In-Reply-To: <20200711011030.21997-1-wens@kernel.org> (Chen-Yu Tsai's message
        of "Sat, 11 Jul 2020 09:10:30 +0800")
Message-ID: <yw1x5zaqnrjj.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen-Yu Tsai <wens@kernel.org> writes:

> From: Chen-Yu Tsai <wens@csie.org>
>
> When the extra HPD polling in sun4i_hdmi was removed, the result of
> HPD was accidentally inverted.
>
> Fix this by inverting the check.
>
> Fixes: bda8eaa6dee7 ("drm: sun4i: hdmi: Remove extra HPD polling")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Tested-by: Mans Rullgard <mans@mansr.com>

> ---
>
> Sorry for the screw-up.
>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> index 557cbe5ab35f..2f2c9f0a1071 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -260,7 +260,7 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  	unsigned long reg;
>
>  	reg = readl(hdmi->base + SUN4I_HDMI_HPD_REG);
> -	if (reg & SUN4I_HDMI_HPD_HIGH) {
> +	if (!(reg & SUN4I_HDMI_HPD_HIGH)) {
>  		cec_phys_addr_invalidate(hdmi->cec_adap);
>  		return connector_status_disconnected;
>  	}
> -- 
> 2.27.0
>

-- 
M�ns Rullg�rd
