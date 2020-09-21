Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1167272695
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgIUOD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:03:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7540EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:03:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k133so4368625pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ure3si/tYjsbRCU0EwPyJfAlat4O1xAue0I3OTloxBE=;
        b=IbmmAYDofbT6k/lMMUKNFUvJQN+qDm8sFzdWHY+T/jpQ42pwIZOYbSGfTboMjkIIki
         Jkrxy/xRizmjaL3yhpOsDT8zVKn6dCr/Qx4NTXFJ5PMTyljCQ06yTfP7v9kPGwYl6nhB
         corbu1t3jb8tgFBVcGRnILxUa8/RbU2ExhVwR0IX4/WqvK163uTz6DZZBEG+mPjrFBUh
         NwlfO4usJNkcLEJhv+nc2+YB8BnXAfdYl0RRa9eEy2qs6SQkq394Wmw9+qk2innSBEp8
         +kLZbvlMGH2TpWMTgvIMzH6akl7HjQeGytHw42M1x8BfTdwgtIRnGcGZR9WcHISKC7po
         WW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ure3si/tYjsbRCU0EwPyJfAlat4O1xAue0I3OTloxBE=;
        b=IOzNmnh6ciYqI2XcZoaVpOC3a/jGrJKiDtQgFreOeq/lUtYSALPlUWmSZawpsb8/IU
         LDXak4XLOgjBH6rHoDYxM8VC14Djw6euGDhwUWCb2Q3X/4zcDEQMmPI1cbSI1eRDtr3a
         RHkRI/sNtP/Yt+YXkr0pR7VFlOjPRekP/zS3eWgHFmaiqvhfPUN+VbanaxHa/yWU51e7
         Dw2ZIqDttlgspho0qIbL/82zwJ7kvY2BI8PojivvIP15g0bFViXu/e8ND/R7HfKZGslg
         LhyCO1+9Y02fhYx/C2DCLbXBjXSZ7xUQ+7yiEDXBs7r94R2HXkioiQRlhGge2/91zsCc
         +2xA==
X-Gm-Message-State: AOAM531NG8pp07s5BQty5YMgVr1ayr/tIq6lhzUHOwcsNWeFxEh/53bp
        fCMMr3wWq92ItQoSn6H678lQ
X-Google-Smtp-Source: ABdhPJxigjLOV7f6CSoqVqVDbHIE443wB+VHWNUBrEke/v73GfmkYFIvsn1GUFVRK+tpgzFGhAYDJA==
X-Received: by 2002:a63:fe57:: with SMTP id x23mr36499351pgj.309.1600697036935;
        Mon, 21 Sep 2020 07:03:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d03:bd12:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id gn24sm11039713pjb.8.2020.09.21.07.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 07:03:56 -0700 (PDT)
Date:   Mon, 21 Sep 2020 19:33:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Debugfs and Sysfs entries for MHI
Message-ID: <20200921140351.GD3262@Mani-XPS-13-9360>
References: <1600457992-18448-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600457992-18448-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:39:49PM -0700, Bhaumik Bhatt wrote:
> Introduce debugfs and sysfs entries for MHI.
> Fixes to allow building MHI as a module without warnings/errors.
> 
> This set of patches was tested on arm64 and x86_64 architectures.
> 
> v3:
> -Fix typo in commit text and add a minor update to it
> 

Series applied to mhi-next!

Thanks,
Mani

> v2:
> -Remove the patch for removal of MODULE_LICENSE() warnings
> -Add fixes to adhere to the Kconfig coding style
> 
> Bhaumik Bhatt (3):
>   bus: mhi: Fix entries based on Kconfig coding style
>   bus: mhi: core: Introduce debugfs entries for MHI
>   bus: mhi: core: Introduce sysfs entries for MHI
> 
>  Documentation/ABI/stable/sysfs-bus-mhi |  21 ++
>  MAINTAINERS                            |   1 +
>  drivers/bus/mhi/Kconfig                |  20 +-
>  drivers/bus/mhi/core/Makefile          |   1 +
>  drivers/bus/mhi/core/debugfs.c         | 410 +++++++++++++++++++++++++++++++++
>  drivers/bus/mhi/core/init.c            |  60 +++++
>  drivers/bus/mhi/core/internal.h        |  24 ++
>  include/linux/mhi.h                    |   2 +
>  8 files changed, 533 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
>  create mode 100644 drivers/bus/mhi/core/debugfs.c
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
