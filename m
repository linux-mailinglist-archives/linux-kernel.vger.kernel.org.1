Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8CD2B3D32
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKPGhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgKPGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:37:16 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A937C0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 22:37:16 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id a18so13224228pfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 22:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RiFP4U37YWvqMZtaHOm+AYQoa+HU2sHN39+uwlBwLH8=;
        b=hxH4p+xkT0KjZ5j5kUCxKhE/ssR/cCMc2VQG8Uz8E+PjpwO6RwPvK1kIc77/TxikDI
         1fCttRiPkuiytXPCf0Z5sXW6F3eRSut5GRvE5an9Al/VwC1f6jM/0/lx3Gq1VinKjyXi
         CdfhRu595KEgo59tlQAK8Ns9AAPJFlNGYa2AsrRVjJNEM6HYgpwgB3drZpAiVXRmFU6f
         ORVZUBZWFNlLhMFtxgSywcN6sgxaVCUqX8xYVh+PJqTRwqAib7J11eUsln/9QAD1i5nm
         gw2n2P+2itkscLGWBzQtZost3B9aX+o5wGJ1NXOJ8hQxFTcLqVIZl5IGo5IvyhFpRmwF
         jbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RiFP4U37YWvqMZtaHOm+AYQoa+HU2sHN39+uwlBwLH8=;
        b=pBEw2Da4RE/YvVLYh1m34SnPbHzFe/qL4hcXzbmDdxG/cWmG1m6BpQkGuyqwuBcdY2
         g9nI3Dx2VJSp4FLULSl/QtsMfbsAFxYAE8M7M2CcHOh1ftrA4kLOKDTArbwZPsmtzp3Q
         XRlriqI0bL/YLFMb97TywptYCXQlUBeBsynnfvl8CXLbhEl6c2MzdpuqqKiHo8fpqVjc
         JS0Fc+/sXG8PSt+1EpGXKVsWs7ANmiyDlM82105gAWFxr7Iq5rBpA0KYRK9OXF2Z0BJe
         PUhGap2b1YgAgY0BQWkS7I5F2rYECm5uI1/BY1iBdp6oGyOpbSiIf4ItFG3uZv1zQQbq
         +Xog==
X-Gm-Message-State: AOAM533J0nx000sOo4L+OGP4sFtXoyVCHmuOEx15mUQRtPTl0EEhhsMg
        i8woky2l76D5KlIsuEkdbAbv
X-Google-Smtp-Source: ABdhPJwgiZl1RGqrXe04yLdVJxH/3XFAERT8WGwCZO22Qd8+XSkyrneXROQhxDZ2ZEQ9EAGBCm3OKA==
X-Received: by 2002:a17:90a:e646:: with SMTP id ep6mr3921470pjb.218.1605508635406;
        Sun, 15 Nov 2020 22:37:15 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:618e:9b0a:75fd:1290:bf5c:a350])
        by smtp.gmail.com with ESMTPSA id i6sm16456602pjt.49.2020.11.15.22.37.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Nov 2020 22:37:14 -0800 (PST)
Date:   Mon, 16 Nov 2020 12:07:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] Bug fixes and improvements for MHI power
 operations
Message-ID: <20201116063707.GG3926@Mani-XPS-13-9360>
References: <1604954851-23396-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604954851-23396-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 12:47:19PM -0800, Bhaumik Bhatt wrote:
> Bug fixes and improvements for MHI powerup and shutdown handling.
> Firmware load function names are updated to accurately reflect their purpose.
> Closed certain design gaps where the host (MHI bus) would allow clients to
> operate after a power down or error detection.
> Move to an error state sooner based on different scenarios.
> 
> These patches were tested on arm64 and X86_64 architectures.
> 
> v4:
> -Fixed up bus: mhi: core: Move to SYS_ERROR regardless of RDDM capability patch
> by removing check for EE as well since a previous guard to check if MHI pm_state
> allows event ring access is already present. Event ring access should not be
> allowed at the time and hence the check is safe to remove.
> 
> v3:
> -Fixed bus: mhi: core: Remove MHI event ring IRQ handlers when powering down
> -Mistakenly placed the free_irq() calls in mhi_pm_sys_error_transition()
> -Moved it to mhi_pm_disable_transition()
> 
> v2:
> -Addressed patches based on review comments and made improvements
> -Added bus: mhi: core: Check for IRQ availability during registration
> -Dropped bus: mhi: core: Use the IRQF_ONESHOT flag for the BHI interrupt line
> -Split bus: mhi: core: Move to an error state on any firmware load failure
> -Modified the following patches:
> -bus: mhi: core: Disable IRQs when powering down
> -bus: mhi: core: Improve shutdown handling after link down detection
> -bus: mhi: core: Mark device inactive soon after host issues a shutdown
> -bus: mhi: core: Move to SYS_ERROR regardless of RDDM capability
> -Addressed the above as follow-up patches with improvements:
> -bus: mhi: core: Prevent sending multiple RDDM entry callbacks
> -bus: mhi: core: Separate system error and power down handling
> -bus: mhi: core: Remove MHI event ring IRQ handlers when powering down
> 
> Bhaumik Bhatt (12):
>   bus: mhi: core: Use appropriate names for firmware load functions
>   bus: mhi: core: Move to using high priority workqueue
>   bus: mhi: core: Skip device wake in error or shutdown states
>   bus: mhi: core: Move to SYS_ERROR regardless of RDDM capability
>   bus: mhi: core: Prevent sending multiple RDDM entry callbacks
>   bus: mhi: core: Move to an error state on any firmware load failure
>   bus: mhi: core: Use appropriate label in firmware load handler API
>   bus: mhi: core: Move to an error state on mission mode failure
>   bus: mhi: core: Check for IRQ availability during registration
>   bus: mhi: core: Separate system error and power down handling
>   bus: mhi: core: Mark and maintain device states early on after power
>     down
>   bus: mhi: core: Remove MHI event ring IRQ handlers when powering down

Series applied to mhi-next!

Thanks,
Mani

> 
>  drivers/bus/mhi/core/boot.c |  60 ++++++-----
>  drivers/bus/mhi/core/init.c |  11 ++-
>  drivers/bus/mhi/core/main.c |   9 +-
>  drivers/bus/mhi/core/pm.c   | 236 ++++++++++++++++++++++++++++++++------------
>  include/linux/mhi.h         |   2 +
>  5 files changed, 222 insertions(+), 96 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
