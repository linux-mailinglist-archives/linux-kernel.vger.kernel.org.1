Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942912725E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgIUNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:40:31 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36348 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgIUNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:40:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LDe2ft052643;
        Mon, 21 Sep 2020 08:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600695602;
        bh=AXdoqzco7TbaWou99N2XIIUtMQZd77nIXrviH2W24/A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YOgaj0O9zkuoslIVf0Y+mvdEZ0T93AgMdgfUgmMmhSt20QKE6C1NkzAv2KKo2AyhL
         ilkrzOCVm/XX/jKiylUkE6wRntf2lTGKaCrkky0BFKCRkwol14ycpcWCCfQXtWc2DP
         HVGI9epioE8fjfEaLkEybRXDkRXPr46HfKrZVfA0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08LDe2MI045174
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 08:40:02 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 08:40:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 08:40:01 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LDe0TH075950;
        Mon, 21 Sep 2020 08:40:00 -0500
Subject: Re: [PATCH -next] drm: omapdrm: dss: simplify the return expression
 of hdmi_init_pll_data
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20200921131015.91422-1-miaoqinglang@huawei.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <1f22b1c4-d92e-2dc8-7052-f6df23a187a6@ti.com>
Date:   Mon, 21 Sep 2020 16:39:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921131015.91422-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/09/2020 16:10, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/hdmi_pll.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
> index cf2b000f3..c3e85b636 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
> @@ -131,7 +131,6 @@ static int hdmi_init_pll_data(struct dss_device *dss,
>  {
>  	struct dss_pll *pll = &hpll->pll;
>  	struct clk *clk;
> -	int r;
>  
>  	clk = devm_clk_get(&pdev->dev, "sys_clk");
>  	if (IS_ERR(clk)) {
> @@ -151,11 +150,7 @@ static int hdmi_init_pll_data(struct dss_device *dss,
>  
>  	pll->ops = &hdmi_pll_ops;
>  
> -	r = dss_pll_register(dss, pll);
> -	if (r)
> -		return r;
> -
> -	return 0;
> +	return dss_pll_register(dss, pll);
>  }
>  
>  int hdmi_pll_init(struct dss_device *dss, struct platform_device *pdev,
> 

I like it more when there's a return 0 at the end of the function, especially in functions where
there are multiple cases of if(...) return r. It's more easily readable, at least to my eyes.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
