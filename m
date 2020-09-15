Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6E26A6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIOOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIOOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:08:28 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D32C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:46:42 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y6so3902848oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7kQUdTgGYoCzTCj4OvU1jcQHb8SMV5JA5QYW5I7lhYw=;
        b=sJrSnw+PU8y1m737k6muECCwVG5aj4zCJA2nLnV95+Q1NrWEFemy2GnFFwvFp+vosO
         zyqHSSGRMAINWReGkldACua7QAlbCXoVCFO5WW6rLZsUyG71XPbkg2PyIiLXmz6ImkdN
         DD8jTHi8r937YTN1Ua0KQiCUwE7QXk8LQspbh6u2CA9fR901gglFSjlGI1vQ5VBr24aY
         nMuVwV+51LDYhNPbUxGk6/yx+fMQlYaBXXDyz578KMjTlHWbU8I1slivhujHiMvcCixS
         VQ9auC2zX3qdM5qigSF1QFk5EUv4z9wDVxyVkAKvsCt4Uym7U7oYgJhOYy60K6gLsa68
         L4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kQUdTgGYoCzTCj4OvU1jcQHb8SMV5JA5QYW5I7lhYw=;
        b=uNtEHXeeRrTaRfwJce5F4XyIwBWFH8jfpPvIhFE2BP37fmScn35aGtphJjs2twscBv
         Yh/CBWV9JTtwzxvzJWyuF9/S65vB0NQalww3zJzs1l2Zy/r5FrUIidFMOhDHO07HGCje
         YUwaEo8ZnkPJ3dSK4kpZbt8Y8T/8UZlI7GkaRga1j/manmvEvv4+AkViAtlxI+HZ197i
         10foMRxQdv6XCmd11zp5hdQ3Xk+mHwWjwoR0IyvYi9LFXVZ5r++yKpLWNPuZ2DXh64PG
         wEfwQ7kB4eYpr7Q7/HtlN5sBXS8Q/X8SsQmUkhfGqsj+hjwo0HQd2ERgfs/8xr1m6jkr
         7JIg==
X-Gm-Message-State: AOAM5327QQkdqAhx87ujNqE8OpeQtVzV+F7QqYwXonYcx8Z2uIGm4p/M
        cxrStbC4Re2MFCHb6d7FkSI3qg==
X-Google-Smtp-Source: ABdhPJw7g1BDuEzE354nYgiFc4YO4/ESWG6hPfxm0Tj+jq7CWgKof2GUPNmm3oo7KeiklL2zo5zgDg==
X-Received: by 2002:aca:5b45:: with SMTP id p66mr3566531oib.39.1600177602112;
        Tue, 15 Sep 2020 06:46:42 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id d1sm5588353otb.80.2020.09.15.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:46:41 -0700 (PDT)
Date:   Tue, 15 Sep 2020 08:46:38 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     cang@codeaurora.org, asutoshd@codeaurora.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Bean Huo <beanhuo@micron.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] scsi: ufs: Support reading UFS's Vcc voltage from
 device tree
Message-ID: <20200915134638.GF670377@yoga>
References: <cover.1598939393.git.nguyenb@codeaurora.org>
 <69db325a09d5c3fa7fc260db031b1e498b601c25.1598939393.git.nguyenb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69db325a09d5c3fa7fc260db031b1e498b601c25.1598939393.git.nguyenb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01 Sep 01:00 CDT 2020, Bao D. Nguyen wrote:

> The UFS specifications supports a range of Vcc operating voltage
> from 2.4-3.6V depending on the device and manufacturers.
> Allows selecting the UFS Vcc voltage level by setting the
> UFS's entry vcc-voltage-level in the device tree. If UFS's
> vcc-voltage-level setting is not found in the device tree,
> use default values provided by the driver.
> 

As stated in the reply to patch 1, this is not the right approach.  As
long as you have static min/max values requested by the driver you
should rely on the board's constraints for the regulator levels and
instead remove the min_uV/max_uV code from the driver.

Thanks,
Bjorn

> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd-pltfrm.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index 3db0af6..48f429c 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -104,10 +104,11 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>  static int ufshcd_populate_vreg(struct device *dev, const char *name,
>  		struct ufs_vreg **out_vreg)
>  {
> -	int ret = 0;
> +	int len, ret = 0;
>  	char prop_name[MAX_PROP_SIZE];
>  	struct ufs_vreg *vreg = NULL;
>  	struct device_node *np = dev->of_node;
> +	const __be32 *prop;
>  
>  	if (!np) {
>  		dev_err(dev, "%s: non DT initialization\n", __func__);
> @@ -138,8 +139,16 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
>  			vreg->min_uV = UFS_VREG_VCC_1P8_MIN_UV;
>  			vreg->max_uV = UFS_VREG_VCC_1P8_MAX_UV;
>  		} else {
> -			vreg->min_uV = UFS_VREG_VCC_MIN_UV;
> -			vreg->max_uV = UFS_VREG_VCC_MAX_UV;
> +			prop = of_get_property(np, "vcc-voltage-level", &len);
> +			if (!prop || (len != (2 * sizeof(__be32)))) {
> +				dev_warn(dev, "%s vcc-voltage-level property.\n",
> +					prop ? "invalid format" : "no");
> +				vreg->min_uV = UFS_VREG_VCC_MIN_UV;
> +				vreg->max_uV = UFS_VREG_VCC_MAX_UV;
> +			} else {
> +				vreg->min_uV = be32_to_cpup(&prop[0]);
> +				vreg->max_uV = be32_to_cpup(&prop[1]);
> +			}
>  		}
>  	} else if (!strcmp(name, "vccq")) {
>  		vreg->min_uV = UFS_VREG_VCCQ_MIN_UV;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
