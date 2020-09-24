Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C82779A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIXTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:46:10 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50622 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIXTqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:46:09 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 687FB20073;
        Thu, 24 Sep 2020 21:46:07 +0200 (CEST)
Date:   Thu, 24 Sep 2020 21:46:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/panel: simplify the return expression of
 td028ttec1_prepare
Message-ID: <20200924194606.GB1223313@ravnborg.org>
References: <20200921131018.91513-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131018.91513-1-miaoqinglang@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=t2hpYR1j4ttwukXXcmsA:9
        a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qinglang

On Mon, Sep 21, 2020 at 09:10:18PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>


Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-tpo-td028ttec1.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> index 037c14fd6..ba0c00d1a 100644
> --- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> +++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> @@ -242,13 +242,8 @@ static int td028ttec1_prepare(struct drm_panel *panel)
>  static int td028ttec1_enable(struct drm_panel *panel)
>  {
>  	struct td028ttec1_panel *lcd = to_td028ttec1_device(panel);
> -	int ret;
>  
> -	ret = jbt_ret_write_0(lcd, JBT_REG_DISPLAY_ON, NULL);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return jbt_ret_write_0(lcd, JBT_REG_DISPLAY_ON, NULL);
>  }
>  
>  static int td028ttec1_disable(struct drm_panel *panel)
> -- 
> 2.23.0
