Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7112FF5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbhAUUgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbhAUHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:53:29 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56041C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:52:49 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v19so822560pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dT9+H7Wn+xe3mxpnUyhf4xC/aOE8YkVdW3Zd3U5DkAE=;
        b=mgoKd1TUDtE9hpIY2dItKRVTwAcV6hUUtfa5S384O/FDwQveLM9dbdNMgBMHXV0JbG
         Scoce0JJnigfMrWhJ/5Zg2dvzes1eDyDWrjhKjuSv7OTaZLpTyIKuOtqK38kCZEGpLl3
         DzmfRwnLnWLoJmG4zCMe0lRaMZnnT/iV0Glsy9uHBuBpY1P6aoV8XcgxyR0hpuDRHXjQ
         5xEknotM20Ptm9ZSx1y59mukcLOpGZ04VFvfECdP1IRblEIZTTQ1VCJl3aQKWYcEEwR7
         3P02mMSI2Q8ikeGCg+i9VOBcJ+nN31UFbexf7pFXYyd78pdAZXsrgZqTSzgyN73Wo4jp
         MT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dT9+H7Wn+xe3mxpnUyhf4xC/aOE8YkVdW3Zd3U5DkAE=;
        b=eMibfn86ZDFgMIUI8f6HnXwI9AmBABFynQbnehI7WXvWt8r9iFXUN4KzKsZPRaByCA
         G+CDeORUbehKCbhjK2C/iaN5IwmxQOaHfg5dAyTfAULvI3EXuvIy8bFvR91EBuqLRcyP
         rKBXsh41mjco619IQB5vaAGoNwIFbmDxMkjkEhX0G5ahxxGRdRZ0u3yYULhQrC1zJcYy
         Z0U3EHsVVa2y05XYmxwr0ZHa7KukD/07wKbzvG/iqHPVHOkeuAk0nU7k0+vufS2J04Ez
         9zTT2O7IRBNYKivFEPof86esXl7D751aS9vDrl8MbVLuN1CYSR+dBpTHILprR32jd68L
         uCfg==
X-Gm-Message-State: AOAM533oBSjMW4KxegU1gh0nBDv89KZkFTeam/4KjTcfmz0AUeStElhW
        nFMZ5JnrjW+TL6MPv8OX3dGX
X-Google-Smtp-Source: ABdhPJx/nzxnmS/57IY8S3HyB80kjVJ1GniNQmxUlfCxDq6JD4rdGp1huhlfoy3elXUD/qnM2O85yg==
X-Received: by 2002:a63:e14a:: with SMTP id h10mr13372799pgk.297.1611215568647;
        Wed, 20 Jan 2021 23:52:48 -0800 (PST)
Received: from thinkpad ([2409:4072:6182:23c4:4d5:e6d9:fc7e:c8e2])
        by smtp.gmail.com with ESMTPSA id i6sm4685076pgc.58.2021.01.20.23.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 23:52:47 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:22:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>, hemantk@codeaurora.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] mhi: use irq_flags if controller driver configures it
Message-ID: <20210121075242.GB30041@thinkpad>
References: <20210104101128.8217-1-cjhuang@codeaurora.org>
 <20210104170359.GE2256@work>
 <87o8hti8t8.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8hti8t8.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:40:19AM +0200, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > On Mon, Jan 04, 2021 at 06:11:28PM +0800, Carl Huang wrote:
> >> If controller driver has specified the irq_flags, mhi uses this specified
> >> irq_flags. Otherwise, mhi uses default irq_flags.
> >> 
> >> The purpose of this change is to support one MSI vector for QCA6390.
> >> MHI will use one same MSI vector too in this scenario.
> >> 
> >> In case of one MSI vector, IRQ_NO_BALANCING is needed when irq handler
> >> is requested. The reason is if irq migration happens, the msi_data may
> >> change too. However, the msi_data is already programmed to QCA6390
> >> hardware during initialization phase. This msi_data inconsistence will
> >> result in crash in kernel.
> >> 
> >> Another issue is in case of one MSI vector, IRQF_NO_SUSPEND will trigger
> >> WARNINGS because QCA6390 wants to disable the IRQ during the suspend.
> >> 
> >> To avoid above two issues, QCA6390 driver specifies the irq_flags in case
> >> of one MSI vector when mhi_register_controller is called.
> >> 
> >> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> >> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Applied to mhi-next!
> 
> Would it be possible again to have an immutable branch for this commit?
> We need it for implementing one MHI support to ath11k[1] required by
> Dell XPS 13 9310 laptops, which a lot of people are waiting. Otherwise I
> can only apply the feature for v5.13, which will be released on July.
> 

Dropped this patch from mhi-next and applied to mhi-ath11k-immutable branch:
https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/log/?h=mhi-ath11k-immutable

This branch will also be merged into mhi-next.

Thanks,
Mani
