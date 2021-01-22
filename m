Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701823003EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbhAVNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbhAVNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:15:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67637223C8;
        Fri, 22 Jan 2021 13:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611321294;
        bh=aUNv5OQ3ojub5SgRUon07BSPkAi4qHPQy3X9xJmVeB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZ+pQP5nmlTsL6cfqqrg4vVEXsHM3mef5BJenNV8tLkjscSu8oIDUuSwU1XFX4yI2
         8CjOmtlWnOYht8UKRPWKt3fWdEukdWxqXjLzIpdpfu6Qmzj1ne5TMeV6+KVNuKm+6V
         3IdapU83G4pXT6Bt91Uf13rQLY/nC1QhJu5TcYLk4zokt2894YpnQRe85Ffcgv4LFE
         eNf/29Gf6IQVkadsqAf6EamffaNEyT9Adrr04IkNjcU8hmc7lbg8GtXM6ENaccvaWt
         XG4btFP3rhSDuWCTspUiMdglCq8Ali8jtJUD1YDWlp0KqnGeaFMLi9Z/pDO3741k87
         pQ2CUMMUzyrRw==
Date:   Fri, 22 Jan 2021 13:14:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, robh+dt@kernel.org,
        iommu@lists.linux-foundation.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add binding for Qcom SDX55
 SMMU
Message-ID: <20210122131448.GE24102@willie-the-truck>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
 <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
 <20210113032223.GA1467511@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113032223.GA1467511@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:22:23PM -0600, Rob Herring wrote:
> On Thu, 07 Jan 2021 20:01:18 +0530, Manivannan Sadhasivam wrote:
> > Add devicetree binding for Qualcomm SDX55 SMMU.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Is there another patch adding driver support for matching this new binding?

Will
