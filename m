Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A1D2ACBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgKJD3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbgKJD3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:29:18 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF36EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 19:29:16 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id a15so9474993otf.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 19:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBdsDRfH0FHtxmwB5xLlqinVd4Y5dkqyDaI/LWJdwN0=;
        b=C4LBHiwph1WQAmv/k0YbDnKYv09yEGgtfzYyCaB+NrX06O4FC3KH+N4aBXvoPyhDwu
         EbUxiMOJARlB92zq9SPdkceLMZbUk1TDcTcmYbeTeojYDlG3Q4dOWZ8D3p6QYDFWaciM
         yetqgab03WMwbRh/YtK0b9TZJDHCyNjdwiPVniWlnYQrKM49rVcdmzUSX/wCm+2/bTJN
         LuMqifEVHgVcaC6L4xG8mreqMOf/EnYnLfbJqgat5vGaWDdV84gFqV5T+iJVfo0dx3e/
         girONLYUsAXDPQcDXGbSG/kb8Kwm+9HRkPffCdZtaCTyjGN8BA/Yu4rJh88Vzkh5fppa
         aVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBdsDRfH0FHtxmwB5xLlqinVd4Y5dkqyDaI/LWJdwN0=;
        b=t8qG/wrenKpG8SHgIOJCAIjofyMWIggFGXLCeID/giGWfGVX8shBGxGmPXhiCVJvpD
         z059NAg3nq6fLmwhM9KXAmp/mD3Kd5urjXhLk3ZAkXEvNJO2oci7seVH5RVQLf9tMnPu
         gyoKy74zBmsq6r094iC12ZRj20nRl+kTpCZJWwGdRwYvIy66G8nhiLM4O9g5dzn/b0zj
         JdZ+RFtm4SxVkCPSDZA9zAjQ4si4md0Qq7LNmBXfGNO3QNY/cUwO4+lqCc7/d6mLZG6K
         1aro39+hfGTdm1sE5qasZA6/14xMCohPpwicY7y/wXAd4eGe/K3xH2VbUq/V3GWpJCN5
         cSJw==
X-Gm-Message-State: AOAM531OeCKRHyxIzyGqvR0cNDEhBLISrMhdp/QNrITz3nDqSJTBA3jx
        w7m72dpMbb+7Xe1TDDtyVFas0g==
X-Google-Smtp-Source: ABdhPJw5LvP9zCjf0MwtuDtaGbQ8Jn2DgYUN5KeLGHlc/YGu3BZ3xxRjKkUrfa4CvlLVLf9EHlvV6g==
X-Received: by 2002:a05:6830:18c9:: with SMTP id v9mr13358229ote.74.1604978956205;
        Mon, 09 Nov 2020 19:29:16 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q7sm2844609oig.42.2020.11.09.19.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 19:29:15 -0800 (PST)
Date:   Mon, 9 Nov 2020 21:29:13 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH 2/2] remoteproc: qcom: Add trace events for q6v5_pas
 driver
Message-ID: <20201110032913.GC332990@builder.lan>
References: <1604971241-29000-1-git-send-email-rishabhb@codeaurora.org>
 <1604971241-29000-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604971241-29000-3-git-send-email-rishabhb@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Nov 19:20 CST 2020, Rishabh Bhatnagar wrote:

> Add tracepoints for q6v5_pas driver. These will help in
> analyzing the time taken by each step in remoteproc
> bootup/shutdown process and also serve as standard
> checkpoints in code.
> 

These tracepoints seems quite generic and useful to drivers other than
the Qualcomm PAS driver. Please move them into the framework instead.

> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 11 +++++++++++
>  include/trace/events/q6v5_pas.h    | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 include/trace/events/q6v5_pas.h
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 3837f23..b3c0a6a 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -29,6 +29,9 @@
>  #include "qcom_q6v5.h"
>  #include "remoteproc_internal.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/q6v5_pas.h>
> +
>  struct adsp_data {
>  	int crash_reason_smem;
>  	const char *firmware_name;
> @@ -121,12 +124,14 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>  	int ret;
>  
> +	trace_q6v5_pas("setting up memory and loading segments", rproc->name);
>  	ret = qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
>  			    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
>  			    &adsp->mem_reloc);
>  	if (ret)
>  		return ret;
>  
> +	trace_q6v5_pas("done loading segments", rproc->name);
>  	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
>  
>  	return 0;
> @@ -137,6 +142,7 @@ static int adsp_start(struct rproc *rproc)
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>  	int ret;
>  
> +	trace_q6v5_pas("Voting for resources", rproc->name);
>  	qcom_q6v5_prepare(&adsp->q6v5);
>  
>  	ret = adsp_pds_enable(adsp, adsp->active_pds, adsp->active_pd_count);
> @@ -163,12 +169,14 @@ static int adsp_start(struct rproc *rproc)
>  	if (ret)
>  		goto disable_cx_supply;
>  
> +	trace_q6v5_pas("Before authenticate and reset", rproc->name);
>  	ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
>  	if (ret) {
>  		dev_err(adsp->dev,
>  			"failed to authenticate image and release reset\n");
>  		goto disable_px_supply;
>  	}
> +	trace_q6v5_pas("After authenticate and reset", rproc->name);
>  
>  	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
>  	if (ret == -ETIMEDOUT) {
> @@ -177,6 +185,7 @@ static int adsp_start(struct rproc *rproc)
>  		goto disable_px_supply;
>  	}
>  
> +	trace_q6v5_pas("Remoteproc is up", rproc->name);
>  	return 0;
>  
>  disable_px_supply:
> @@ -214,6 +223,7 @@ static int adsp_stop(struct rproc *rproc)
>  	int handover;
>  	int ret;
>  
> +	trace_q6v5_pas("Request stop", rproc->name);
>  	ret = qcom_q6v5_request_stop(&adsp->q6v5);
>  	if (ret == -ETIMEDOUT)
>  		dev_err(adsp->dev, "timed out on wait\n");
> @@ -227,6 +237,7 @@ static int adsp_stop(struct rproc *rproc)
>  	if (handover)
>  		qcom_pas_handover(&adsp->q6v5);
>  
> +	trace_q6v5_pas("Remoteproc is down", rproc->name);
>  	return ret;
>  }
>  
> diff --git a/include/trace/events/q6v5_pas.h b/include/trace/events/q6v5_pas.h
> new file mode 100644
> index 0000000..38ee5e2
> --- /dev/null
> +++ b/include/trace/events/q6v5_pas.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM q6v5_pas
> +
> +#if !defined(_TRACE_Q6V5_PAS_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_Q6V5_PAS_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(q6v5_pas,
> +
> +	TP_PROTO(const char *event, const char *rproc_name),

Rather than distinguishing the trace events by the textual first
parameter, split it into individual trace events for each event.

Regards,
Bjorn

> +
> +	TP_ARGS(event, rproc_name),
> +
> +	TP_STRUCT__entry(
> +		__string(event, event)
> +		__string(rproc_name, rproc_name)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(event, event);
> +		__assign_str(rproc_name, rproc_name);
> +	),
> +
> +	TP_printk("event=%s remoteproc:%s", __get_str(event), __get_str(rproc_name))
> +);
> +
> +#endif
> +#include <trace/define_trace.h>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
