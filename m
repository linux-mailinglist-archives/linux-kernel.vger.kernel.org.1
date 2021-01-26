Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12943042DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbhAZPpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391590AbhAZPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:43:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CEFC0698C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:42:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so10635201pfm.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ncmDJ68LDAWGkThxmEqJx8RH/Iz+CIH9uZm9OmJVrJA=;
        b=DiYM45UvYl57ZNe9Tn+LfR8CPVxag36gJh8uxi3TK4FMrwm9MkOrVk+4xerXzw2Nve
         pHI6NXyUjF0BnwFohfWjBkvjdsAhEfSr3tghQV+cwY+kDQFUkH/Ru8cpmv/rjDY2qXaG
         epAlr4IAMkNUGSFuwQvWWUbOPA1XdvW1hZwGGdX8A0DjvhGFN9JZgoW2/NJQVcgzhLRC
         ItTKCAsYL78FCDCZFLAX0C1CRg9B2xTCBmOWD6D80mplm4cV5WasNlpogdejVCVxNU/L
         E61r0HyD1Ipqn23Xp5pI3qUA4wJNAjQkAyh+zyUGC/uc/fqsxqbvWcgDrExqEnxM4uFE
         NUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncmDJ68LDAWGkThxmEqJx8RH/Iz+CIH9uZm9OmJVrJA=;
        b=IyHNx6lCu4qBfvUi/T1l30VAiaaE0+aTPoMBs4NDYk8AX+jq/YrjW77l5aCdkaLukZ
         DEjUY+PmnnE/zWBaIVMAyLCmGnlvVfdtTDwXLQGOnUU/CIppmu9Ejvv6ge0U4NorCBy0
         t5tJRW71AaSLW/OShe+zjkcXzgRCRtGDdv4ikW8Wi2JIsOsaqga0yoLKCmXXLFCLPv1f
         5kdl97gX2CmIdUcSarCmt8Vh7Hk95CoChGJKdiy4Dt7oQL4PG/RSa+OoH5AJ09Em6xbo
         v5l2FY8l9UhTufVy4sx/3FyTPV1xraWBhcL6yi6xpjDeKZZqIOJQMqWyFYhMF1q9AO0u
         JfbQ==
X-Gm-Message-State: AOAM5339zZ1+j7Z9S/KFx1p7LPN4fkOMOzvPRsbwY3tBh3jsGk/IZIa2
        pCqzT01vAj07tDn7icV1nTBD
X-Google-Smtp-Source: ABdhPJzHK/ein4ssvfyWWKrPolLlt2P/WTA6QFF9GDoPKbSBKsC+AG5ViuVclI03U436RiufrvbD+w==
X-Received: by 2002:a63:e049:: with SMTP id n9mr6191385pgj.339.1611675770575;
        Tue, 26 Jan 2021 07:42:50 -0800 (PST)
Received: from thinkpad ([2409:4072:6d84:5293:c96f:fa31:6124:85e6])
        by smtp.gmail.com with ESMTPSA id n12sm18353963pff.29.2021.01.26.07.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 07:42:49 -0800 (PST)
Date:   Tue, 26 Jan 2021 21:12:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Carl Huang <cjhuang@codeaurora.org>,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mhi: use irq_flags if controller driver configures it
Message-ID: <20210126154242.GA29751@thinkpad>
References: <20210104101128.8217-1-cjhuang@codeaurora.org>
 <20210104170359.GE2256@work>
 <87o8hti8t8.fsf@codeaurora.org>
 <20210121075242.GB30041@thinkpad>
 <87k0s0atub.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0s0atub.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:14:04PM +0200, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > On Wed, Jan 13, 2021 at 09:40:19AM +0200, Kalle Valo wrote:
> >> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> >> 

[...]

> >> > Applied to mhi-next!
> >> 
> >> Would it be possible again to have an immutable branch for this commit?
> >> We need it for implementing one MHI support to ath11k[1] required by
> >> Dell XPS 13 9310 laptops, which a lot of people are waiting. Otherwise I
> >> can only apply the feature for v5.13, which will be released on July.
> >> 
> >
> > Dropped this patch from mhi-next and applied to mhi-ath11k-immutable branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/log/?h=mhi-ath11k-immutable
> >
> > This branch will also be merged into mhi-next.
> 
> Thanks a lot!
> 
> And Greg will also pull this directly so that commit ids won't change?
> Just trying to avoid conflicts between ath and mhi trees as much as
> possible.
> 

Yes, I'm gonna send a PR to Greg this time also!

Thanks,
Mani

> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
