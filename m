Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32B22AD821
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgKJN5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgKJN5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:57:03 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E89920797;
        Tue, 10 Nov 2020 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605016622;
        bh=pUCSLw0dp38jb6CdCj20KMAJ24P3TkHkgt3ZT3RYx0k=;
        h=Date:From:To:Cc:Subject:From;
        b=0KCiYdkyFaR5w/qPRTfH+xDMnjI09MxOjiucXHAY9YlPQfNr1y4j4FeXENtrJeyOP
         9GFYL2y2nBVLmWT8dVYee4pFrETH/0D1gql3kOhB8tcu7yO0GXEayqV1UFzrxcPtXT
         cEfTcFL+JT9MvvwFugQ7nr1lhhz4GLBXoMDJOgGQ=
Date:   Tue, 10 Nov 2020 13:56:58 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, john.stultz@linaro.org,
        bjorn.andersson@linaro.org
Subject: [GIT PULL] iommu/arm-smmu: First batch of updates for 5.11
Message-ID: <20201110135657.GA17034@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please can you pull these Arm SMMU updates for 5.11 so that they can get
into -next? I think Bjorn is keen to get a bunch of DT updates moving, so
the sooner we can get this lot out there, the better. Summary in the tag.

There are a few other patches kicking around on the list, so I may send
a second pull on top in a couple of weeks or so.

Cheers,

Will

--->8

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to a29bbb0861f487a5e144dc997a9f71a36c7a2404:

  dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU (2020-11-10 12:25:49 +0000)

----------------------------------------------------------------
First batch of Arm SMMU updates for 5.11

- Allow implementations to hook writes to S2CR and SCTLR registers

- Handle broken Qualcomm bootloader/firmware

- Support Adreno tightly-coupled SMMU implementation

- Use devm_krealloc()

- Use 'true' instead of '1' when assigning 'bool disable_bypass'

----------------------------------------------------------------
Bjorn Andersson (3):
      iommu/arm-smmu: Allow implementation specific write_s2cr
      iommu/arm-smmu-qcom: Read back stream mappings
      iommu/arm-smmu-qcom: Implement S2CR quirk

Jordan Crouse (2):
      iommu/arm-smmu-qcom: Add implementation for the adreno GPU SMMU
      dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU

Kaixu Xia (1):
      iommu/arm-smmu-v3: Assign boolean values to a bool variable

Rob Clark (1):
      iommu/arm-smmu: Add a way for implementations to influence SCTLR

Robin Murphy (1):
      iommu/arm-smmu: Use new devm_krealloc()

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   9 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |   8 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c       |  17 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 259 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  18 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   4 +
 7 files changed, 284 insertions(+), 33 deletions(-)
