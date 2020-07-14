Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0021F21C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 15:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGNNFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 09:05:52 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:35934 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNNFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:05:52 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8261B804D0;
        Tue, 14 Jul 2020 15:05:48 +0200 (CEST)
Date:   Tue, 14 Jul 2020 15:05:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, ck.hu@mediatek.com,
        stonea168@163.com, huijuan.xie@mediatek.com
Subject: Re: [PATCH] drm/panel: Fix auo,kd101n80-45na horizontal noise on
 edges of panel
Message-ID: <20200714130546.GA1588550@ravnborg.org>
References: <20200714123332.37609-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714123332.37609-1-jitao.shi@mediatek.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8 a=al6dfsjdgZPfAsxNZ6YA:9
        a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

Material for -fixes or just -next?

	Sam

On Tue, Jul 14, 2020 at 08:33:32PM +0800, Jitao Shi wrote:
> Fine tune the HBP and HFP to avoid the dot noise on the left and right edges.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 48a164257d18..3edb33e61908 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -615,9 +615,9 @@ static const struct panel_desc boe_tv101wum_nl6_desc = {
>  static const struct drm_display_mode auo_kd101n80_45na_default_mode = {
>  	.clock = 157000,
>  	.hdisplay = 1200,
> -	.hsync_start = 1200 + 80,
> -	.hsync_end = 1200 + 80 + 24,
> -	.htotal = 1200 + 80 + 24 + 36,
> +	.hsync_start = 1200 + 60,
> +	.hsync_end = 1200 + 60 + 24,
> +	.htotal = 1200 + 60 + 24 + 56,
>  	.vdisplay = 1920,
>  	.vsync_start = 1920 + 16,
>  	.vsync_end = 1920 + 16 + 4,
> -- 
> 2.25.1
