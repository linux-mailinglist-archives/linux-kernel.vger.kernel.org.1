Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC027C1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgI2JvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2JvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:51:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20811C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:51:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so3959647wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=g//3YKslqEEjdWy4bFstcnviEz8Yjtvb1bJDuqH9QfE=;
        b=KM7/B/44Z4zZq5f25gu+hF+LJFGIUg+P2fUBeUj31s75he1XhFefiaqsnnrlYkEFQ1
         qJF4E8TJvsIRWLsP1Ra7PniO2iEO3rnrIHT8/KB3j6xPXEiuEtTbKIX9KvB1WP2mMfTc
         t5kgcG+AFHBgATTCK9oQ2AWJ7Ca424ekWbBz5tkuVdZ/UowL0pD7jdR8kTp9dICsvXuX
         pn2K7X7tX3UeHUw3smf+XFRXrGtOaB8tyjOmeDw+nCqqEMPpWqX6kv8ash9LWYI9cZmz
         3f/O2uzLqSrhixsOZJJM76YcK0eiOLfENJnMrowexKiRY5DtI0xob7XM7JeCPgt38Mwn
         7l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g//3YKslqEEjdWy4bFstcnviEz8Yjtvb1bJDuqH9QfE=;
        b=RaOK+9j9XS/ZJf0bm6JxjO871i2GxJzGjAIQmwTNoYm6h62Seg/8MB0kjFCqLyJ9Ue
         BVJ/+LzpRs12T87HjezgbxLI+B59mwoINtipOasONMsFJWCvAdolEkJHzettwSbPrr7T
         +9wOsScHjr+5QVkBNdIn0Bt/anP1KdheyCFSPyLKjQfZBySHeFlLYxFP7jNWr1s3OazM
         n8L8pyONmDPck4QAGI5VkXpQKvzUfGZQils71Si1wSBsfuEwWbARUmGXIXy5Q3cea73v
         oh6pedlqNWtdntcnXRXhpoFQ87OsPPCVRSFGsHWzYMSNfV8w/imsPracXsli6GDkaLLq
         jfoA==
X-Gm-Message-State: AOAM531XS34TeQRLSGmG0FUjjjizEg4nHctJy6dSWCv8KDdPBMZmuLRr
        2vGEGJuLACYRZe66K5vITLf+1Q==
X-Google-Smtp-Source: ABdhPJwCbmhF47JEAgld/dSPUltKiEKJn903XuyqkTkNAIZrfNzJbuSsAWeQttI0/PP713UsXqfi0g==
X-Received: by 2002:a1c:ed19:: with SMTP id l25mr3654659wmh.49.1601373068677;
        Tue, 29 Sep 2020 02:51:08 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id r21sm6040568wrc.70.2020.09.29.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 02:51:07 -0700 (PDT)
Date:   Tue, 29 Sep 2020 10:51:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: intel_pmt: Add OOBMSM device ID
Message-ID: <20200929095106.GG6148@dell>
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200911194549.12780-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020, David E. Box wrote:

> Add Out of Band Management Services Module device ID to Intel PMT driver.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/mfd/intel_pmt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> index 0e572b105101..8f9970ab3026 100644
> --- a/drivers/mfd/intel_pmt.c
> +++ b/drivers/mfd/intel_pmt.c
> @@ -55,6 +55,8 @@ struct pmt_platform_info {
>  	unsigned long quirks;
>  };
>  
> +static const struct pmt_platform_info pmt_info;
> +
>  static const struct pmt_platform_info tgl_info = {
>  	.quirks = PMT_QUIRK_NO_WATCHER | PMT_QUIRK_NO_CRASHLOG |
>  		  PMT_QUIRK_TABLE_SHIFT,
> @@ -200,8 +202,10 @@ static void pmt_pci_remove(struct pci_dev *pdev)
>  	pm_runtime_get_sync(&pdev->dev);
>  }
>  
> +#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
>  #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
>  static const struct pci_device_id pmt_pci_ids[] = {
> +	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, &pmt_info) },

Why are you supplying an empty struct?

>  	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
>  	{ }
>  };

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
