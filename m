Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895BB2525D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 05:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHZDox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 23:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHZDov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:44:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1FCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 20:44:50 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o21so321495oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vj9jHV3Nh5KlI/aHeO4Vw72Jl2llbstQbIn89ZgeTF8=;
        b=OvXEmpgA9rzoCBGMIr3Z/Y0sZa6QDHXNlqji2Lq8CTzC+GG8HIK6vYiQ9BLOXEHAhe
         cB8T1ocWUcH5iXddnTVdrYkF1mN8woDXJRGqeP8Y/HBY4YGibDA304UOUV+CZTl2wiTD
         WJ8qspN4pZD0UID2fs7LcNRuvgOn7T1NCaRE1p5wlpDAxmyYLOqZfjUzjqi6QBcDwuho
         cvoLzqFH+LSf43lQ9olZg/t54BfBCFz+zwmCAuCiuiDhcLjRTc5Skx21zLTWrU7RrJm6
         +dnjrHs79Gv1s1mFCV4xEr7VO7N7S0VOIlK/XIjfiUHkievJZQ8VkhAMjVaJDsqsGOzr
         r9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vj9jHV3Nh5KlI/aHeO4Vw72Jl2llbstQbIn89ZgeTF8=;
        b=jjQ7nJowWY5A+g6DjXfQyhnSOAb5APCpD4hO8GQiPHvJ3hDrPk+xGWZ13tzjPR6MvJ
         WeCr6tTD/RGpCkolZA7LqfDq5b0jXYSmoIBrA7Ktc2vcThT1islvpD7Z8Xscvsymwdhk
         qW8j92Y9SQyMt5xSokA8WblvkUe5NV2ZZErSCQV1GoJrzbMyH4rtmn4YZT/UIgOH7Ult
         jp2WN0uohhzevjBO1PfAwDsthOvuapgM/Fzpfu9EthW9ABE7BXCJLXI4mnVc++C6qeqr
         geM5U4BTpo5wBh0FQ7Uo8YTWEPatpyx+yToHJoB2PR3mCgwAlcTgVWZ/XtHzIg9rs+tr
         ZO2g==
X-Gm-Message-State: AOAM531V1ez11tJ1EgPRHjUSue3zcwPVfeP/jxPeAseXPDhuvMtXAlz6
        LEwevWfQEiQUIk3/8CtRsUuUAw==
X-Google-Smtp-Source: ABdhPJy3j8LJQFL8ybKeyBKKFeKk3XfOnAsGrQXI2jYprxc20qp9LlCi/15hLZePkPyAMba6XtIBRQ==
X-Received: by 2002:aca:a9d0:: with SMTP id s199mr2680456oie.154.1598413489568;
        Tue, 25 Aug 2020 20:44:49 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id y3sm83744ooc.48.2020.08.25.20.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 20:44:48 -0700 (PDT)
Date:   Tue, 25 Aug 2020 22:44:46 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v1 3/9] phy: qcom-qmp: Remove 'initialized' in favor of
 'init_count'
Message-ID: <20200826034446.GE3715@yoga>
References: <20200826024711.220080-1-swboyd@chromium.org>
 <20200826024711.220080-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826024711.220080-4-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Aug 21:47 CDT 2020, Stephen Boyd wrote:

> We already track if any phy inside the qmp wrapper has been initialized
> by means of the struct qcom_qmp::init_count member. Let's drop the
> duplicate 'initialized' member to simplify the code a bit.
> 
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Cc: Chandan Uddaraju <chandanu@codeaurora.org>
> Cc: Vara Reddy <varar@codeaurora.org>
> Cc: Tanmay Shah <tanmay@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Cc: Manu Gautam <mgautam@codeaurora.org>
> Cc: Sandeep Maheswaram <sanm@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Jonathan Marek <jonathan@marek.ca>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 7ee9e966dc6d..4a23ba9361b3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1844,7 +1844,6 @@ struct qmp_phy {
>   * @phys: array of per-lane phy descriptors
>   * @phy_mutex: mutex lock for PHY common block initialization
>   * @init_count: phy common block initialization count
> - * @phy_initialized: indicate if PHY has been initialized
>   * @ufs_reset: optional UFS PHY reset handle
>   */
>  struct qcom_qmp {
> @@ -1861,7 +1860,6 @@ struct qcom_qmp {
>  
>  	struct mutex phy_mutex;
>  	int init_count;
> -	bool phy_initialized;
>  
>  	struct reset_control *ufs_reset;
>  };
> @@ -2748,7 +2746,6 @@ static int qcom_qmp_phy_enable(struct phy *phy)
>  		dev_err(qmp->dev, "phy initialization timed-out\n");
>  		goto err_pcs_ready;
>  	}
> -	qmp->phy_initialized = true;
>  	return 0;
>  
>  err_pcs_ready:
> @@ -2792,8 +2789,6 @@ static int qcom_qmp_phy_disable(struct phy *phy)
>  
>  	qcom_qmp_phy_com_exit(qmp);
>  
> -	qmp->phy_initialized = false;
> -
>  	return 0;
>  }
>  
> @@ -2868,7 +2863,7 @@ static int __maybe_unused qcom_qmp_phy_runtime_suspend(struct device *dev)
>  	if (cfg->type != PHY_TYPE_USB3)
>  		return 0;
>  
> -	if (!qmp->phy_initialized) {
> +	if (!qmp->init_count) {
>  		dev_vdbg(dev, "PHY not initialized, bailing out\n");
>  		return 0;
>  	}
> @@ -2894,7 +2889,7 @@ static int __maybe_unused qcom_qmp_phy_runtime_resume(struct device *dev)
>  	if (cfg->type != PHY_TYPE_USB3)
>  		return 0;
>  
> -	if (!qmp->phy_initialized) {
> +	if (!qmp->init_count) {
>  		dev_vdbg(dev, "PHY not initialized, bailing out\n");
>  		return 0;
>  	}
> -- 
> Sent by a computer, using git, on the internet
> 
