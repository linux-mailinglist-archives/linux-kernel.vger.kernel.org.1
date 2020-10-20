Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5985288F19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389841AbgJIQmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389472AbgJIQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:42:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D0C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:42:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y14so7591300pgf.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yhRF4Bf0Fxw8uBmUilMjScUgjc5ToacEwGW5jec2Co0=;
        b=E3Lv+fddMEZ8IA3+gHF2Qkff/JeWnRJiKJciN62IaAcoIJYnS7ZdzfGJeu0MraFDsn
         xbk6CDyxVVSm/XzwUnrCM8HelV47RdveluFynfnkzklgyOWCTH9rFcCTKYcZOSxwcsT+
         athO2itK4OSekxnku90VmCgBt51SXZoAbWvfGgOE4W6EqgH/ntb/0c/BPIBjioatOP0K
         YXB6XdOQFgw37fHSmKE+ggNq9UhxDnlkEEpcGAmhaM+DnLIAyaI2xNz/+O0YE1F1aemx
         P7ixk0f8dmkbgDf1dOp/tkLP4YBk/WzOGbHlPxGCAQBIlXgoeHKfsywlLHEn69mMc7nN
         40xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yhRF4Bf0Fxw8uBmUilMjScUgjc5ToacEwGW5jec2Co0=;
        b=QGqSooO0PaqY++wu6Yb0goVxVUUQKSkN8kpwqfgh1K1tCZF/2lY106zzE8mesDpRNA
         Azs/KEulSZ+2mm8JDIbQ8xALRfWIy4j7RkkxmdvEvAncRzCM6UucjI3iOg5MzycnMG1G
         1ERtGT6ROW8n8cJfz515cinXftsrhfSMM95U5+fs8bW8djbYq8AmD480m/ZI6vfXOvTy
         XPeSYGLARAHkLBp7Q5TXXejOm5+44tsC0mZVVEHMai7jlI50AtSzmXZS40HUh+tblRY8
         JEqLfLUj5g3QM5nL5iV1XTOe8cH/7fCj4qeaJND5Uif9v+r1xAm1pDSafrQgFrQ7HScK
         oHCA==
X-Gm-Message-State: AOAM532KyyobOsVELqScuDuRlUWdNfpsKtzAWYkTKBzzZbb2S7CcGatx
        XhzThpLTNB8VWVMtwV3kVVIo
X-Google-Smtp-Source: ABdhPJwI1/Z0b9digdvNs3D5Sn+3/hVStc5r71EndANo8iNe9eCHZKVzD0IjBfCON+crmTfzxlDFQQ==
X-Received: by 2002:a62:78d5:0:b029:154:ebc0:c92c with SMTP id t204-20020a6278d50000b0290154ebc0c92cmr13464865pfc.24.1602261771314;
        Fri, 09 Oct 2020 09:42:51 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6292:5a21:d5ff:f3e8:fcf2:ccc7])
        by smtp.gmail.com with ESMTPSA id t13sm11616763pfc.1.2020.10.09.09.42.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Oct 2020 09:42:50 -0700 (PDT)
Date:   Fri, 9 Oct 2020 22:12:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/10] bus: mhi: core: Move to an error state on any
 firmware load failure
Message-ID: <20201009164235.GI4810@Mani-XPS-13-9360>
References: <1600480955-16827-1-git-send-email-bbhatt@codeaurora.org>
 <1600480955-16827-9-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600480955-16827-9-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 07:02:33PM -0700, Bhaumik Bhatt wrote:
> Move MHI to a firmware download error state for a failure to find
> the firmware files or to load SBL or EBL image using BHI/BHIe. This
> helps detect an error state sooner and shortens the wait for a
> synchronous power up timeout.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/boot.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 92b8dd3..fcc71f2 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c

[...]

> -error_read:
> +error_ready_state:
>  	mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
>  	mhi_cntrl->fbc_image = NULL;
>  
> -error_alloc_fw_table:
> -	release_firmware(firmware);
> +error_fw_load:
> +	write_lock_irq(&mhi_cntrl->pm_lock);
> +	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
> +	wake_up_all(&mhi_cntrl->state_event);

Do you really need pm_lock for this?

Thanks,
Mani

> +	write_unlock_irq(&mhi_cntrl->pm_lock);
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
