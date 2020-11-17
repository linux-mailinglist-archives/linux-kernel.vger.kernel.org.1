Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A99B2B6F66
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgKQTxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:53:31 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:19339 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730096AbgKQTxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:53:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605642810; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=I8Uoa9WMfOpRw2GhOBpzrpwBUS+efGBMbXmJ+Bhf1nQ=;
 b=uHSHXIh4r10LzVlLBB673SUgknqxM2jQEsa+euhX4W0LqOvixfs38NDyI3j980vEVHFx4g0K
 hozIYWvT4I3Xeii1bfvgZr1+2lNpi0zp0Z3NOQEDYDaNHPSNFT5A5MD2KMksYtkGdIzVyL37
 rCjLuh5iPgcXuSDNf4DUtWANUeM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fb42a2f8bd2e3c222a75451 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 19:53:19
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EAA03C43469; Tue, 17 Nov 2020 19:53:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8327FC43462;
        Tue, 17 Nov 2020 19:53:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Nov 2020 11:53:17 -0800
From:   abhinavk@codeaurora.org
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     robdclark@gmail.com, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: Fix error return code in
 dpu_mdss_init()
In-Reply-To: <20201117025617.168259-1-chenzhou10@huawei.com>
References: <20201117025617.168259-1-chenzhou10@huawei.com>
Message-ID: <c33b123fb1893a3c972f724e4cd1ff08@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-16 18:56, Chen Zhou wrote:
> Fix to return a negative error code from the error handling case
> instead of 0 in function dpu_mdss_init(), as done elsewhere in this
> function.
> 
> Fixes: 070e64dc1bbc ("drm/msm/dpu: Convert to a chained irq chip")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> index cd4078807db1..6e600b4ca995 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> @@ -297,8 +297,10 @@ int dpu_mdss_init(struct drm_device *dev)
>  		goto irq_domain_error;
> 
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> +	if (irq < 0) {
> +		ret = irq;
>  		goto irq_error;
> +	}
> 
>  	irq_set_chained_handler_and_data(irq, dpu_mdss_irq,
>  					 dpu_mdss);
