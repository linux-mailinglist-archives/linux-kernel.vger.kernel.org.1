Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDFB20ACED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 09:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgFZHVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 03:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFZHVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:21:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC113C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:21:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r18so4573152pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jPjxTeB7DcZFNvR4lCQsdqpTCmjL1iaR4x39hd7bSd4=;
        b=nvdBEZ7rHAbq4p48jarp/krSDKhwuZMDK25DPWCRh4Q47iMgknYwYuYQjoMAtA0XHF
         eS+/+dFsEOA5xX9cxSK6uYMAsvGVRYDRVUTtkUWGff6WbS9RRsTAW2mAeIIFrEFL10MD
         9x8gbRb0RVmXdpL0sWICjveFCkg11iuLkA0a+nc+1PWlfOINJ/7WzIQYZcBhIYMlmuOm
         6n+edET86wnicxODQilAASlhvhAbTfxIsvPfJKvcV3/mrONLkIbYLh2abBkxBqfjfeER
         tPLWn+dPhU5P9d1IoIQI9NQabEbs4n0tvwOa3C/dqVhAqFERhlFxcRP2yAzHQ7yV2OmR
         oyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPjxTeB7DcZFNvR4lCQsdqpTCmjL1iaR4x39hd7bSd4=;
        b=OuAYovaVwiE2mtxXRBvV3bAEiS/h/ZSHZfpVVlMUo7IEh9IR3WFwbKRzmq4qdhC9Qv
         UGpJkoMqEItrtDZm97wjCfZkz5GCRFvd/5NKD+dt4EnWxsvMjhR4xNnRkFsusvJRrtSe
         GEEC6o2JSNH5dDEfKCUtxFHauiXsD4om7MQUZaYQ+8gUPSPHI4GrTCbX7yzdPk6k/dI4
         f0UhjnQnFg8x2q0B2eFGoKx7tjzO8be8BJ+CELt8/tkLYzDrUa7bLQtlJ0q52jBq8Ph9
         dG7rLjNDczIwh/lwE+PSsPr1YsLIcZBXaibqXIWpQVSgZGfxE2jXb3SgRTh2/AN97D+B
         kZuA==
X-Gm-Message-State: AOAM532+XHyfQY33AmL87thbVJJz6KbxowzdiRi0fxmqs8DLgIN8BKoI
        5AKa7f7ao6BMIe8UftO5b0h37g==
X-Google-Smtp-Source: ABdhPJxh4m7dx47I/UYghsbYaLrbQLLj/RfDd1kukrzDy0jInIROjoornub6OBEtA1HErZokevwI6w==
X-Received: by 2002:aa7:98c1:: with SMTP id e1mr1576927pfm.318.1593156084235;
        Fri, 26 Jun 2020 00:21:24 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w30sm7638826pjj.3.2020.06.26.00.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:21:23 -0700 (PDT)
Date:   Fri, 26 Jun 2020 00:18:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/9] regulator: qcom-rpmh-regulator: Repair dodgy
 kerneldoc header formatting
Message-ID: <20200626071845.GC388985@builder.lan>
References: <20200626065738.93412-1-lee.jones@linaro.org>
 <20200626065738.93412-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626065738.93412-3-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Jun 23:57 PDT 2020, Lee Jones wrote:

> W=1 kernel builds report a lack of descriptions for various
> enum properties and function arguments.  In reality they are
> documented, but the formatting was not as expected '@.*:'.
> Instead, some weird arg identifiers were used or none at all.
> 
> This change fixes the following warnings:
> 
>  drivers/regulator/qcom-rpmh-regulator.c:33: warning: Enum value 'VRM' not described in enum 'rpmh_regulator_type'
>  drivers/regulator/qcom-rpmh-regulator.c:33: warning: Enum value 'XOB' not described in enum 'rpmh_regulator_type'
>  drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'vreg' not described in 'rpmh_regulator_init_vreg'
>  drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'dev' not described in 'rpmh_regulator_init_vreg'
>  drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'node' not described in 'rpmh_regulator_init_vreg'
>  drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'pmic_id' not described in 'rpmh_regulator_init_vreg'
>  drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'pmic_rpmh_data' not described in 'rpmh_regulator_init_vreg'
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
Bjorn

> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 79bdc129cb504..08dcc614efa7f 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -22,9 +22,9 @@
>  
>  /**
>   * enum rpmh_regulator_type - supported RPMh accelerator types
> - * %VRM:	RPMh VRM accelerator which supports voting on enable, voltage,
> + * @VRM:	RPMh VRM accelerator which supports voting on enable, voltage,
>   *		and mode of LDO, SMPS, and BOB type PMIC regulators.
> - * %XOB:	RPMh XOB accelerator which supports voting on the enable state
> + * @XOB:	RPMh XOB accelerator which supports voting on the enable state
>   *		of PMIC regulators.
>   */
>  enum rpmh_regulator_type {
> @@ -399,13 +399,13 @@ static const struct regulator_ops rpmh_regulator_xob_ops = {
>  
>  /**
>   * rpmh_regulator_init_vreg() - initialize all attributes of an rpmh-regulator
> - * vreg:		Pointer to the individual rpmh-regulator resource
> - * dev:			Pointer to the top level rpmh-regulator PMIC device
> - * node:		Pointer to the individual rpmh-regulator resource
> + * @vreg:		Pointer to the individual rpmh-regulator resource
> + * @dev:			Pointer to the top level rpmh-regulator PMIC device
> + * @node:		Pointer to the individual rpmh-regulator resource
>   *			device node
> - * pmic_id:		String used to identify the top level rpmh-regulator
> + * @pmic_id:		String used to identify the top level rpmh-regulator
>   *			PMIC device on the board
> - * pmic_rpmh_data:	Pointer to a null-terminated array of rpmh-regulator
> + * @pmic_rpmh_data:	Pointer to a null-terminated array of rpmh-regulator
>   *			resources defined for the top level PMIC device
>   *
>   * Return: 0 on success, errno on failure
> -- 
> 2.25.1
> 
