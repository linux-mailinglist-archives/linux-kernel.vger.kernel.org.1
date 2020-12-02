Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2672CC243
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgLBQ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgLBQ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:28:05 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFBC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:27:24 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id iq13so1297974pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K3R13J9lr9BqACKYR74sxEfXdGFRf+uRv0uo4OMDycs=;
        b=nUMQhvrlR5K/G5CyxXF57FkF9QNPSZHmzpZHKMaWtHDB5XsVpushnO/x09TW0eCabF
         yd80g5N2RjQPDdEtorH8TSMtgBIkt52EqNz57pJr9EZeKd5/S+Uhph5hpZh42KMfpAI0
         rxdB02ppSnjS4wgplOOlMAOJnQ0DG6/R6inB1EdqUqyMkznEWzeBCaSmdofdjLfQc1eu
         yxZ/RHs/Tc0xgFynNGodFUTxXV8F3gQyP6IgYmVvzHnvUNnWpVRtNl2TRwiSPhxqOFsb
         wjRCdypHs9t8MVuA3DScDVM6M1X7eUW7zxhmyAdLQLlGywcSYkXPUMql7HAIabECU+ux
         P7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K3R13J9lr9BqACKYR74sxEfXdGFRf+uRv0uo4OMDycs=;
        b=NtZIP/cDRmZ0ZYyDFU1C+i14Z51BDaMybBnsc+e/PUlQejx3e89svKPN01bC6xr1Kr
         LCHPl7FHdO8IVH+VGUUdDuXTO4iOkTlM8saiUKQj0yEutJZbMYKsIn0Jemt5ofJtEvaQ
         HkxF0z/MAYpvj48XaryZ1XgTBWH8DAxWJf76IGV+gl75SQbdaGSK3vvS0sVguXJtCDmP
         MKmDoMFKC3KN33OhT72i8Fxnk1ddJ2Bt99C5CKEB4t5mncePgXoJrs+cZAuUrp2LqkjC
         oNfxQl+33tjjyYdFlEuBu37TjCdARR5Vj3oBqrJ2uVSMFwyXFL9xJeUP5sDRKOXZCTMz
         Gczg==
X-Gm-Message-State: AOAM533zM1NME7ahs6+SgiMqr0Osd3cgqCHysygPOArBF5zEFCeD+jQD
        5VSjwqynpqWrfQqJlm2rSSzV
X-Google-Smtp-Source: ABdhPJyMEIwYQyoMgcxwVLmq9R1UT5SO+2peUyP8oYZBhuKL16cJBXEoMvWjEEP0km1WyWQsLD+arQ==
X-Received: by 2002:a17:90a:4a90:: with SMTP id f16mr640535pjh.10.1606926444302;
        Wed, 02 Dec 2020 08:27:24 -0800 (PST)
Received: from thinkpad ([2409:4072:100:69b9:b5fe:d7f9:67a:4196])
        by smtp.gmail.com with ESMTPSA id a21sm186283pjq.37.2020.12.02.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:27:23 -0800 (PST)
Date:   Wed, 2 Dec 2020 21:57:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, hemantk@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH 01/29] bus: mhi: Remove auto-start option
Message-ID: <20201202162716.GA3033@thinkpad>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
 <20201202094159.107075-2-manivannan.sadhasivam@linaro.org>
 <87pn3si4fu.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn3si4fu.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 06:00:05PM +0200, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > From: Loic Poulain <loic.poulain@linaro.org>
> >
> > There is really no point having an auto-start for channels.
> > This is confusing for the device drivers, some have to enable the
> > channels, others don't have... and waste resources (e.g. pre allocated
> > buffers) that may never be used.
> >
> > This is really up to the MHI device(channel) driver to manage the state
> > of its channels.
> >
> > While at it, let's also remove the auto-start option from ath11k mhi
> > controller.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > Acked-by: Kalle Valo <kvalo@codeaurora.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > [mani: clubbed ath11k change]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Hmm, didn't we apply this already? At least I pulled the immutable
> branch to my tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=526740b495059ebbc0c3c086dceca1263820fa4f
> 
> So if there's a new version of this patch (and a new commit id) the
> immutable branch I pulled is not immutable anymore.

This is not a new version of the patch. The commit SHA of this patch in
immutable branch is ed5298c7d500abaf34ed7783969e953a1f028e5b and that is same
in mhi-next as well.

Now I'm funneling all patches in mhi-next to mainline through Greg, so this
patch is part of the (MHI changes for v5.11) patch series. Perhaps you might be
dealing with pull requests to Dave/Jakub but since the MHI patch flow is usually
fairly low, Greg is happy with patch series.

But since we are dealing with immutable branch I should send the pull request
to Greg now.

Thanks,
Mani

> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
