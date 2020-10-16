Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1A2909B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410824AbgJPQbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410818AbgJPQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:31:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A446C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:31:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n9so1747898pgt.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ngWRzHXgFHPy5i53Ui/ywmmjGuNtNloCNac1FIdeRAQ=;
        b=B37qAKhlAWHbfyc7bJHH4NB7PG7hWjfgg2r7HF8pl2x9mcbe0N3kd9ohbS/Yr53sJB
         XN4TqAOuJwRx10ZUi6sVqKGyBbR81Pb5GBHR3rZCqE0ppUKKK2cjKFhnWO2UEMeRFRNs
         VakhFnf+GkAlFEHBzqofhpavg1HVPLvU46OuzXHCXQMm28d++AtiQbgAN4CgXKzPhe0e
         yLGTMiLeXVtDjSPXgO7QSB3pLstp8MV5PmcjUX2MZAajSefUcPFCAddWe8HlSApXbpRq
         +Q3NaL4W4MjC8GvN3lambFerIYVOFfKe0Dk0s7SnSOPu/DLEjOxyoaZUhodWPtI43aHX
         +dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ngWRzHXgFHPy5i53Ui/ywmmjGuNtNloCNac1FIdeRAQ=;
        b=J4VOonWJhfA18Gg839WP/ijD3pLSl4XINRnfcmenXn2slitq0Vfdu4YLukCJspafpz
         v6wi1K1aVrl7buRMdSgvvKriPLlDvJ61wvjRqoF+He0w6PUoWjdwptKKZZQX8zFu5yJM
         PbPTjeMouk6iVrXBZUah9azKOEhE6NrD+40VDbhb4hJ9/rXtpPrNIwo7tr2qPI6a4dsJ
         13muP4Nq5kPHp8ul/zl2QoV5c1i1FWOPdpxlP5QnAPz0z3cW4Xf0PJKOwzCzpVUhVzQe
         yFZBLvX4iAtLhvXN64zzlwVYWefpY51/bX1pE0f6l1Tl2jIKWPZHEtRFzXI5f2rbboot
         t4vw==
X-Gm-Message-State: AOAM530jptF08fbq5z6Gt2QvYASMI4wkusEjSFd0paVJCpel2kzOGqrT
        dnlnQXcGh6OCkt074HBd/n4Wcw==
X-Google-Smtp-Source: ABdhPJx8hiTqCuwIz4lbKvJ5Fw1msi/JR77+ht9hPaB0QMoE48DBqyO1UyUGdczGEQelTvD+mdH4tQ==
X-Received: by 2002:a63:140e:: with SMTP id u14mr3644528pgl.91.1602865863679;
        Fri, 16 Oct 2020 09:31:03 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 131sm3314753pfy.5.2020.10.16.09.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:31:03 -0700 (PDT)
Date:   Fri, 16 Oct 2020 10:31:01 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>, denik@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: etm4x: Skip setting LPOVERRIDE bit for
 qcom,skip-power-up
Message-ID: <20201016163101.GA3885@xps15>
References: <20201016101025.26505-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016101025.26505-1-saiprakash.ranjan@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:40:25PM +0530, Sai Prakash Ranjan wrote:
> There is a bug on the systems supporting to skip power up
> (qcom,skip-power-up) where setting LPOVERRIDE bit(low-power
> state override behaviour) will result in CPU hangs/lockups
> even on the implementations which supports it. So skip
> setting the LPOVERRIDE bit for such platforms.
> 
> Fixes: 02510a5aa78d ("coresight: etm4x: Add support to skip trace unit power up")
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index abd706b216ac..6096d7abf80d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -779,7 +779,7 @@ static void etm4_init_arch_data(void *info)
>  	 * LPOVERRIDE, bit[23] implementation supports
>  	 * low-power state override
>  	 */
> -	if (BMVAL(etmidr5, 23, 23))
> +	if (BMVAL(etmidr5, 23, 23) && (!drvdata->skip_power_up))
>  		drvdata->lpoverride = true;
>  	else
>  		drvdata->lpoverride = false;
>

I have applied your patch.

Thanks,
Mathieu
 
> base-commit: 3477326277451000bc667dfcc4fd0774c039184c
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
