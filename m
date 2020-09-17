Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB4426D2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 06:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIQEgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 00:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIQEgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 00:36:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ABBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 21:36:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v54so894049qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ASmnaqlmvLV3DYCl/m4SEZFCwcmLMSD0ZhdmaqWyIl8=;
        b=lNgCZAlIj6lQ73jenE3EOdKSadjFEUkLlLpAyr08G6LssALZVGhq24MfEyHobd7o5h
         IRhhXMTjvVpb1nhWIi9dvyq6hGScQzfHpok5K7J1RcGCZu40dGx4Y+KEQD3+FvvR4bYM
         yQ8/Gj1BIwhwQV+Jkxe2+Pbq7n22UD51PBX2pD/4xo4mYDzcd2xeCARs9CU6k+HwA4g2
         +AJfLduLQB4pCBbPPNTefGWE3Hkm7/pF3pNayx5uqHqqmtVl2/R6AeRjWfvpKiZsQJl8
         sY42CPNAq8cUF6zm9LQKLvzzAZf3+WBuJ1NVnUrDWJIvd+vEcTIUv7bUzhPw9uXDCIu2
         FkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ASmnaqlmvLV3DYCl/m4SEZFCwcmLMSD0ZhdmaqWyIl8=;
        b=A2WvIhq1k3LKtV+SPqCsQW6wRzd72LDm8806kg9uxleRQMx6sV639vocPGXD2NVmBg
         ovSQZjd5UOEBKzLZj+vDEy2GiZ9+Ud1ePOzF+rCA6BPvv4BBlVwJvzvUkgk2imp36it0
         lwPsxZE8Wp/20gzGBrDeYWDCG8dj70+Xwxc5UDJyEp50YUjhrUldGUuXNMROeajQ4Ct6
         4GceePmBdbchF/JbpdLU+ju0EdT+FLTzXHDQM7K2Lq0flLaaZk1uDGQoGr+7Y1FpdGCm
         IY37RlzO4La9ZCa5aVc4lriBDYEP1md1ED9hlz58Txt05lCCvFA2O+gl2sT7H5ThLRIw
         MhgQ==
X-Gm-Message-State: AOAM531j3bLhCZVWpT57JaCysh/5ve3FDml6i8h4Q6DqROSkVP9Wf7kk
        hMjUo10kXtXV8mmkYrxKexeKf2pfcoAIZA==
X-Google-Smtp-Source: ABdhPJyv4cSYBMkZht+naxEL8Ufs+6UVZgOoiaMa6zIMjcRxaxT8MxzbH2MEH5kdxmk5eOyC2UU4jw==
X-Received: by 2002:ac8:5d43:: with SMTP id g3mr14123544qtx.295.1600317370546;
        Wed, 16 Sep 2020 21:36:10 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id p68sm21048764qka.78.2020.09.16.21.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 21:36:09 -0700 (PDT)
Date:   Thu, 17 Sep 2020 04:36:08 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Qilong Zhang <zhangqilong3@huawei.com>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soc: use devm_platform_ioremap_resource_byname
Message-ID: <20200917043608.GA108053@uller>
References: <20200916111517.99670-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916111517.99670-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16 Sep 11:15 UTC 2020, Qilong Zhang wrote:

> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

I fixed up the subject line to match the previous commits in this driver
and applied the patch.

Thank you,
Bjorn

> ---
>  drivers/soc/qcom/llcc-qcom.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 429b5a60a1ba..70fbe70c6213 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -387,7 +387,6 @@ static int qcom_llcc_remove(struct platform_device *pdev)
>  static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
>  		const char *name)
>  {
> -	struct resource *res;
>  	void __iomem *base;
>  	struct regmap_config llcc_regmap_config = {
>  		.reg_bits = 32,
> @@ -396,11 +395,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
>  		.fast_io = true,
>  	};
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> -	if (!res)
> -		return ERR_PTR(-ENODEV);
> -
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource_byname(pdev, name);
>  	if (IS_ERR(base))
>  		return ERR_CAST(base);
>  
> -- 
> 2.17.1
> 
