Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A003275A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIWOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:35:50 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:23612 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgIWOft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:35:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600871749; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=+9NMW0QpZTRk/RhtR4bzIYvxdaJgDL21LKZfASquHyY=; b=g8dQNtVyNuuTSV2ps+sEIdVcO2CpnTT8JT2oTVgoUT8pgDwm8oZnyvUZVabGukqxLzmBuBou
 2sHr4dPrlqLV+bNp7kEsXuIA2P3Ko1YW4E6hOqMCT13sB+vNdYB71915X8AH6SzyDybyBcGj
 nywf+opH8XqrESQ65nrIi9KarJg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f6b5d2d244d44dc655be1f8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 14:35:25
 GMT
Sender: jcrouse=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C733CC433FE; Wed, 23 Sep 2020 14:35:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36546C433C8;
        Wed, 23 Sep 2020 14:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36546C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 23 Sep 2020 08:35:19 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        freedreno@lists.freedesktop.org
Subject: Re: [Freedreno] [PATCH] drm/msm: Remove depends on interconnect
Message-ID: <20200923143519.GA31425@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Georgi Djakov <georgi.djakov@linaro.org>,
        robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        freedreno@lists.freedesktop.org
References: <20200916110706.6671-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916110706.6671-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:07:06PM +0300, Georgi Djakov wrote:
> The dependency on interconnect in the Kconfig was introduced to avoid
> the case of interconnect=m and driver=y, but the interconnect framework
> has been converted from tristate to bool now. Remove the dependency as
> the framework can't be a module anymore.

QCOM interconnect is still selectable, right? I think we would need to retain
the dependency but drop the ! clause. 

Jordan
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/gpu/drm/msm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 5c55cd0ce9f9..3348969460ab 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -6,7 +6,6 @@ config DRM_MSM
>  	depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
>  	depends on OF && COMMON_CLK
>  	depends on MMU
> -	depends on INTERCONNECT || !INTERCONNECT
>  	depends on QCOM_OCMEM || QCOM_OCMEM=n
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select REGULATOR
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
