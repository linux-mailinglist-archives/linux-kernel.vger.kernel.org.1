Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2913A2BBCE7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKUEFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgKUEFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:05:44 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E038C061A49
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:05:44 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n11so10771694ota.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vDCzn8IpZ7D1wHWvbrDgdoNWq9ddfRFT4DNN+T24cXc=;
        b=gY5vw82/h1f9OVJ6eYtJiP9As4gPHncfRQvhz8TcCdbhtOmCxWl33fmyGQ6MvrZL6A
         waOVRIqwe0WcHXmIblrUj19BejHVizPjBSFo2hNrkki0O7hlNlGU3yuOQkaBZrESXzmR
         qE+uvja8Olo04T/4NAfKxAci/eyYLNH65J3s5cLeZ3VlfRrzVIlHqU1wwUIGI0QJXRpk
         ohNEt48kmWR8niX3dPmKODoDL6iaRgJdTFDao7BK9GH7XkmEHIJcGOvDzdMh/biLtPPl
         4xbJyPHkbmsek6hQwgZtdchqWy4LjTQnOOjTlvXyLDKsu9lrNkb9cQ1A7FdnKoVjbKeH
         c7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vDCzn8IpZ7D1wHWvbrDgdoNWq9ddfRFT4DNN+T24cXc=;
        b=bEruOlZW8RUyVjwrx1ew0lhTRkJGQaZEQ+WD6Wehlf3RB5a/E5x0oWY5/EkcHRwbuc
         0mUVIIWyupsbX16xy94iHMAOmQGRexRlb/5cPFojge+ixRiC9MdQCQ3VpM+cY1NeBXqJ
         HT7ECLbdc9qbBCtG5IvpM4PCAqtLS6b4AYfm+HT4N6xPX06J7HPFmO8BtPlmDk+8596J
         or5r76uBPKL1JXLGsCrKtRvoaFHCxq0Hu2U5a2t6j9u4g1YUUlev+/PY3mJo7FEl4D0C
         ZmsFLnnWI3mGOJbtpq1a8IxNdsvfoqA4vHCk3sg4Dd/fC5u3lq37QkeAErmDaRwulK8c
         7alw==
X-Gm-Message-State: AOAM533MYDkqtpUz9sYI59pVC0+nkPezyamr67FiWBrCeUcgm7kyFAij
        cZx6Q7S98JtcWYUIW1589J2uCQ==
X-Google-Smtp-Source: ABdhPJyEoLAlB4m/u91It7w5xf0owODbLy8PAPhdLNw5Vc0V3GxHTc8Ur+ZzMXEXgxSWKQFTLiGEow==
X-Received: by 2002:a05:6830:1e95:: with SMTP id n21mr16865592otr.49.1605931543881;
        Fri, 20 Nov 2020 20:05:43 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r206sm2760502oih.14.2020.11.20.20.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 20:05:43 -0800 (PST)
Date:   Fri, 20 Nov 2020 22:05:41 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 4/4] remoteproc: qcom: Add minidump id for sm8150 modem
Message-ID: <20201121040541.GM9177@builder.lan>
References: <1605819935-10726-1-git-send-email-sidgup@codeaurora.org>
 <1605819935-10726-5-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605819935-10726-5-git-send-email-sidgup@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Nov 15:05 CST 2020, Siddharth Gupta wrote:

> Add minidump id for modem in sm8150 chipset so that the regions to be
> included in the coredump generated upon a crash is based on the minidump
> tables in SMEM instead of those in the ELF header.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>

When reposting patches without modifications, please add any
Acked-by, Reviewed-by or Tested-by that you received previously.


Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index ca05c2ef..e61ef88 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -630,6 +630,7 @@ static const struct adsp_data mpss_resource_init = {
>  	.crash_reason_smem = 421,
>  	.firmware_name = "modem.mdt",
>  	.pas_id = 4,
> +	.minidump_id = 3,
>  	.has_aggre2_clk = false,
>  	.auto_boot = false,
>  	.active_pd_names = (char*[]){
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
