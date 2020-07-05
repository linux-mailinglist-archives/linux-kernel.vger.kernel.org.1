Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E123214B13
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgGEIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 04:06:43 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36188 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgGEIGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 04:06:43 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 97B27804E6;
        Sun,  5 Jul 2020 10:06:38 +0200 (CEST)
Date:   Sun, 5 Jul 2020 10:06:37 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, ck.hu@mediatek.com,
        stonea168@163.com, huijuan.xie@mediatek.com
Subject: Re: [PATCH] drm/panel: auo,b116xw03: fix flash backlight when power
 on
Message-ID: <20200705080637.GA1745670@ravnborg.org>
References: <20200703095113.55712-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703095113.55712-1-jitao.shi@mediatek.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8 a=zYKW7BbRKYs78E-HfYEA:9
        a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

On Fri, Jul 03, 2020 at 05:51:13PM +0800, Jitao Shi wrote:
> Delay the backlight on to make sure the video stable.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 3ad828eaefe1..18f34f286d3d 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -734,6 +734,9 @@ static const struct panel_desc auo_b116xw03 = {
>  		.width = 256,
>  		.height = 144,
>  	},
> +	.delay = {
> +		.enable = 400,
> +	},
>  };
>  
>  static const struct drm_display_mode auo_b133xtn01_mode = {

Patch did not apply to drm-misc-next.
Please update - and when you do so also add:
.bus_flags
.bus_format
.connector_type

So we have this panel properly defined.

	Sam
