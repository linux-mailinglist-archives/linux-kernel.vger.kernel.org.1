Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAE300492
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhAVNvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbhAVNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:51:43 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4272C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:51:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w18so3709534pfu.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1DGptUPlPUDIn46y7qVQ8wP/NzkZbz3BOz3IJ/t3Ri4=;
        b=K5ZxW5R6zCAWwRlAyqFvab6iy9nUnoYhM+Hfj1cVsyl4Dur1lEoF432t4M1p+3ym+6
         3bmcSqExz+TlsKo27fgffGVoHS5tqJqltp2pW0jsEAX1Csq8V4zEnGeCoT4gMqvBFtYu
         N2foheRcmuoMdvJheolSLC9I2sQ46YUWH9PsubGu044f8UlgsffKfd96TrdpntMaXZsg
         8S+rinNqdJdX8gGnpu4zg0QfL2MF7X3KdnKXEhC06epLv9CRrL2sCkQeU/GZ9ZSZVcWK
         T/LeKssx7reL5o4KUHBkO7c4ozEZaO0U0OZH7TRbyc/uUcH0SiNJIKlkeSXyz9lHq5DE
         W/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1DGptUPlPUDIn46y7qVQ8wP/NzkZbz3BOz3IJ/t3Ri4=;
        b=OaiFiIM4Evm8USPhamjMFhYXnVvfhLcyuLRQHdSmRDsucbQI90ePPiYdYX9i8RuJI+
         v4Ltu8PduLjuI6jX6eapdz1t5PynnuVhd6x1mVO3kWQxmT3aUeZfgmvR+P5hQc8K7vly
         lyGPn81OxDUAELzpIHN5GSPRtwt49MYlWG7YLYwjVh15wJiL69kgncidBuVwCInGQXJR
         hLej6Tv6YwR8ueBhNWbksEyu1He/ng4lYbvoW3Wy7IIq92imY0k1Qzl2NK9B+WVmiaNp
         J+1h4xHzyh6IC6MOCyozyzx7VBm2kXevae9Lz21btmvWoh0yYtB8FMM8ulLf9r2tHEJ2
         jmGw==
X-Gm-Message-State: AOAM530hV7En/zQfs4AeD6MUB1FDQn0f/MUIhn1a1XYj9+WUTAr7Kioh
        rqAiZtr8UOE61g3M18azfFt0
X-Google-Smtp-Source: ABdhPJyLPLAM/0qyg6GdxdI1af+ix4NN6PsYGYu3BDKebA3E1Sak2EbnzgI+kYjzh2sCnSCMx8qqPQ==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr4804757pgh.396.1611323462136;
        Fri, 22 Jan 2021 05:51:02 -0800 (PST)
Received: from work ([103.77.37.137])
        by smtp.gmail.com with ESMTPSA id m18sm5971806pfd.206.2021.01.22.05.50.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jan 2021 05:51:01 -0800 (PST)
Date:   Fri, 22 Jan 2021 19:20:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, robh+dt@kernel.org,
        iommu@lists.linux-foundation.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add binding for Qcom SDX55
 SMMU
Message-ID: <20210122135056.GA32437@work>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
 <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
 <20210113032223.GA1467511@robh.at.kernel.org>
 <20210122131448.GE24102@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122131448.GE24102@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 01:14:49PM +0000, Will Deacon wrote:
> On Tue, Jan 12, 2021 at 09:22:23PM -0600, Rob Herring wrote:
> > On Thu, 07 Jan 2021 20:01:18 +0530, Manivannan Sadhasivam wrote:
> > > Add devicetree binding for Qualcomm SDX55 SMMU.
> > > 
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > Cc: iommu@lists.linux-foundation.org
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Is there another patch adding driver support for matching this new binding?
> 

Nope. But the compatible is used as a fallback with "arm,mmu-500". The
dts patch is merged into qcom tree:

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=dts-for-5.12&id=a2bdfdfba2afb532f2a2c8082bdb7de8379a4b6c

Thanks,
Mani

> Will
