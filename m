Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99A42F4266
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbhAMDXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:23:06 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40246 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbhAMDXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:23:06 -0500
Received: by mail-ot1-f43.google.com with SMTP id j12so623389ota.7;
        Tue, 12 Jan 2021 19:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFD+4R4DB+Y+hIT2uTSS82J75l4RpMhVU01lAZvb2CI=;
        b=mqc7r3ANvGEV7km/zdr+KiGIwvYoGKAdblHQ1+QsejZXC5fPBWyWVbi/+UF3j5niQX
         W41n7dObFN7XlXWZiY0kiHr76fQFbtYlE/F3CtSWI54F+L+O8avU8jLl7cjvXiE5J7Ih
         oKwiZTHbY6ni2QObYp0XFaoVEkGKU1sJymEd0faFh//LWcuTxmBPw7Y1UdN+S/rrgs6b
         nfctq8yUsUuhgeErnzUyy4sJzxyOy4xKxy2Of1nCvYvT6biCiCeUS/VS1LJOSo4r8ydU
         VMxKkXmOtcoJC8MS9iJKtxDE5kGTKTPnX+b8/yhk2iycsgx8SXDtTiKcFw/vWdV7s0Xq
         3zow==
X-Gm-Message-State: AOAM530CIgyOQfeYIQIA4KFbXp3Pmje/8OwHfN0hJz2wNn8Ftug203Uz
        FxsXKfslXCze+hAqWtgweQ==
X-Google-Smtp-Source: ABdhPJwVVOTMrJbThfuk487IYRWLYVeUWVU+77/cosixS6TZmaY/4vlEVD2pjzV0pdWCiXhOuUsCAg==
X-Received: by 2002:a9d:1c6:: with SMTP id e64mr16380ote.50.1610508145162;
        Tue, 12 Jan 2021 19:22:25 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7sm157940ool.29.2021.01.12.19.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:22:24 -0800 (PST)
Received: (nullmailer pid 1467559 invoked by uid 1000);
        Wed, 13 Jan 2021 03:22:23 -0000
Date:   Tue, 12 Jan 2021 21:22:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, robh+dt@kernel.org,
        iommu@lists.linux-foundation.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add binding for Qcom SDX55
 SMMU
Message-ID: <20210113032223.GA1467511@robh.at.kernel.org>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
 <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jan 2021 20:01:18 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Qualcomm SDX55 SMMU.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
