Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18433288D83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389592AbgJIP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:57:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B582C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:57:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so7530887pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tCOb/8vzLqioPTFTYbLnGFxEUlw4hKTC+t8qOouMNMI=;
        b=DiQiPZ/fwVRWIVHvWpXSmTqzmOXaAMAZn2XyFi5bZPAr0LqYK2XBlVTwSVHmnDF/sj
         9MWwFFnzV8fpV3thKG3Al4ixkDgGcMwa813uqb2MHhdsU68kqAk6YYgjXY8s+WbnfLf/
         jpw63YMaA76vTrNMem63cCk+tZcwnijXkpM8fkwYZsgxK+BtiEkOxfEyE0BLpflPwZc5
         UIXfMhJILitj41Jwcl0s9VIYgTjy121uMnhuWj2R5jg+1u55lbU23hbxBk1MSzfKKnr9
         +Xhmlecz/UNe7NqnGYxH6UMIhu9FekK1z8qPgx4QNeUbTED0GnsCnD9DzQk/T2t+y7X8
         zk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tCOb/8vzLqioPTFTYbLnGFxEUlw4hKTC+t8qOouMNMI=;
        b=XHDw5VumGYbMxkKo9oYYwLGt9NjliK7alW+fm8wJAvUgWFo5rXJjYJi14BIyvAtqJ4
         LtT9ROqjF3cyc2GuziRdvHlqEIOJuKbDMwU4eNRSsiMokT5tYTttg1iCXgjI23FohB3g
         A6CN/zMRQlbBv7GBKGYlodOXp/+V5AYr+YcrIMygm+h17EdK+UouLNarHaPnmpBpWDLh
         5rpauPSgBkLr1Ql3r3+qAFo51xQiAR8G5lb7w2ciNVwQnvnwWZUVoLFSmr6DC+hts8vc
         akXRfb/2+ZWd8SBC6ZtEvUXFVw7kNuFQRXHSS6hDYKTlcjGUTV/uyp5XeJVJAa0FFZHq
         JegQ==
X-Gm-Message-State: AOAM531zEUctvjBWn56NV+GDarALIxrrn2B4Qogxiu9KG6KqRNKg6Lcm
        3HOLRXjBiXxAZ58nd4iAa51g
X-Google-Smtp-Source: ABdhPJxXWRo+8nQRuOPBGqlb6ulnDbwBuFOWVldgFygx7ne9pqbH5fwXDyP2qTO9WstvRVjdTn2e4g==
X-Received: by 2002:a63:161e:: with SMTP id w30mr3806612pgl.255.1602259034854;
        Fri, 09 Oct 2020 08:57:14 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6292:5a21:d5ff:f3e8:fcf2:ccc7])
        by smtp.gmail.com with ESMTPSA id o17sm11921274pji.30.2020.10.09.08.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Oct 2020 08:57:13 -0700 (PDT)
Date:   Fri, 9 Oct 2020 21:27:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/10] bus: mhi: core: Use the IRQF_ONESHOT flag for
 the BHI interrupt line
Message-ID: <20201009155706.GE4810@Mani-XPS-13-9360>
References: <1600480955-16827-1-git-send-email-bbhatt@codeaurora.org>
 <1600480955-16827-5-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600480955-16827-5-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 07:02:29PM -0700, Bhaumik Bhatt wrote:
> Remove the IRQF_SHARED flag as it is not needed for the BHI interrupt
> and replace it with IRQF_ONESHOT so that host can be sure that the
> next BHI hard interrupt is triggered only when the threaded interrupt
> handler has returned. This is to avoid any race conditions we may run
> into if BHI interrupts fire one after another.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index ca32563..9ae4c19 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -167,7 +167,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
>  	/* Setup BHI_INTVEC IRQ */
>  	ret = request_threaded_irq(mhi_cntrl->irq[0], mhi_intvec_handler,
>  				   mhi_intvec_threaded_handler,
> -				   IRQF_SHARED | IRQF_NO_SUSPEND,
> +				   IRQF_ONESHOT | IRQF_NO_SUSPEND,

Jeff, I believe you're the one requested for shared irq during initial push.
Are you okay with this?

Thanks,
Mani

>  				   "bhi", mhi_cntrl);
>  	if (ret)
>  		return ret;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
