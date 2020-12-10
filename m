Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0840D2D6380
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392755AbgLJR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392712AbgLJRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:17:01 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40651C061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:16:21 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id j12so5568491ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+raCjKpIVRC3ckpKE04FFg3Paj0t2Ny6Ep6v2MYPiMM=;
        b=o3A4AwtYlW6bPDSRlI3lKl44/gTAYqaw73Z6IGfReAqL4SyeJCixVDyc0eortU+pks
         mFYkfqhYfwJuN2bNHchU3TDgx+z/bUs8mlVOAwW1nCYr6q6e7a8dMlocILdkuwTjZbSo
         CUr9rLTjAHw8y8zcAiFn9CUQzHCuoVSeJvkLCa6RMpLke2How3KX/eQe5gDAyLIIqBCk
         L51whIp9xlIXDG7SUjdUb36DANdEG+Gaum8j3KHXYadUBvhG7GsHx7/FmchCOnMOZFy8
         tujxLVZ9mTs4RWK9LQ/ZB90+/sov/HGCcDxWuzsYmnKv0qI1bYse/foM+/0KfIe0/yUB
         g7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+raCjKpIVRC3ckpKE04FFg3Paj0t2Ny6Ep6v2MYPiMM=;
        b=KSl+y1VX4ZprwDj9wdWRbi5Ctl05IOU0iW2ThEzvKTuvelY8M30MQU1VCMWCn7C8ly
         dOHMWCoYuAy67tDXI6YdnLdmeNe4Af3aN+2EQeZPAfBwmtIZF1hOchFr35z+h8BnmQIM
         7wcyyj7lMRwfkSFcbJ2LSSGa82lW0LWWDpXi83gUQikk6fNvguJeItIFZc0zx0je1N8t
         h6EClWUNv7WOeiZ6wjSZaEDwOugLc9NOuH1WFc6nSNxsy+W/FpNJ53xdgOrSETCNsJOm
         W4VwXqupRyOuKeK21uIMbbPjU9IgzoDs2enxSd8xKkz7HMT1zhgVecVrmLMXu7dMjObF
         ETJg==
X-Gm-Message-State: AOAM533gWcWbQ+oIxqR0pBuHNwC7nIpBiz7Qg58BwWlWhkaA0yKOHVqL
        udq0Efmok0D/knWrFn+UMLtFnQ==
X-Google-Smtp-Source: ABdhPJzBYZeTDTKAR5za8xy1+HAnmnZJY9ploQ2X9GbJ4vF8FwlDDODAG/p2/i3CNd/aPyy/czMH/g==
X-Received: by 2002:a9d:d4a:: with SMTP id 68mr6754095oti.101.1607620580521;
        Thu, 10 Dec 2020 09:16:20 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k23sm1122538oih.52.2020.12.10.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:16:19 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:16:18 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v2 1/3] soc: qcom: Add tracepoints to mdt loader
Message-ID: <X9JX4txhmr0PQ5pX@builder.lan>
References: <1605563084-30385-1-git-send-email-rishabhb@codeaurora.org>
 <1605563084-30385-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605563084-30385-2-git-send-email-rishabhb@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Nov 15:44 CST 2020, Rishabh Bhatnagar wrote:

> Add trace events to the mdt loader driver. These events
> can help us trace the region where we are loading the
> segments and the time it takes to initialize the image
> and setup the memory region.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/soc/qcom/mdt_loader.c     |  7 +++++++
>  include/trace/events/mdt_loader.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 include/trace/events/mdt_loader.h
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 24cd193..96dc912 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -17,6 +17,9 @@
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mdt_loader.h>
> +
>  static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
>  {
>  	if (phdr->p_type != PT_LOAD)
> @@ -198,6 +201,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  		if (pas_init) {
>  			ret = qcom_scm_pas_mem_setup(pas_id, mem_phys,
>  						     max_addr - min_addr);
> +

This change is unnecessary.

>  			if (ret) {
>  				dev_err(dev, "unable to setup relocation\n");
>  				goto out;
> @@ -232,6 +236,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  
>  		ptr = mem_region + offset;
>  
> +

Ditto.

>  		if (phdr->p_filesz && phdr->p_offset < fw->size) {
>  			/* Firmware is large enough to be non-split */
>  			if (phdr->p_offset + phdr->p_filesz > fw->size) {
> @@ -256,6 +261,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  			release_firmware(seg_fw);
>  		}
>  
> +		trace_qcom_mdt_load_segment(mem_phys + offset, phdr->p_filesz,
> +					    fw_name);
>  		if (phdr->p_memsz > phdr->p_filesz)
>  			memset(ptr + phdr->p_filesz, 0, phdr->p_memsz - phdr->p_filesz);
>  	}
> diff --git a/include/trace/events/mdt_loader.h b/include/trace/events/mdt_loader.h
> new file mode 100644
> index 0000000..01c2461
> --- /dev/null
> +++ b/include/trace/events/mdt_loader.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM mdt_loader
> +
> +#if !defined(_TRACE_MDT_LOADER_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MDT_LOADER_H
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(qcom_mdt_load_segment,
> +
> +	TP_PROTO(phys_addr_t region_start, size_t region_size, const char *fw),
> +
> +	TP_ARGS(region_start, region_size, fw),
> +
> +	TP_STRUCT__entry(
> +		__field(phys_addr_t, region_start)
> +		__field(size_t, region_size)
> +		__string(fw, fw)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->region_start = region_start;
> +		__entry->region_size = region_size;
> +		__assign_str(fw, fw);
> +	),
> +
> +	TP_printk("firmware:%s region start=%pa size=%zx",
> +		  __get_str(fw), __entry->region_start, __entry->region_size)

Doesn't this printk use the normal format specifiers, where %pa should
be passed by reference? (I.e. shouldn't this be &__entry->region_start?)

Regards,
Bjorn

> +);
> +
> +#endif
> +#include <trace/define_trace.h>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
