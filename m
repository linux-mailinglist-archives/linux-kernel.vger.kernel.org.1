Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73752D4404
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbgLIONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgLIONX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:13:23 -0500
Date:   Wed, 9 Dec 2020 14:12:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607523163;
        bh=FAI/30k4kJrlpskHB/PfBKqSeCQ0aih1cBOMGE821UE=;
        h=From:To:Cc:Subject:From;
        b=Jwed7xDpuN9x4w57KLlIz4Z0VcspD08U6jWr2hmBYNIkFB47HgyWWxZmIkIL3BZo1
         5/l0U7I2Uia4pTcNoHfpvpgtzQM+1srtYEurcc5MKnXo+eCF9SrMEpsP0gGgvG1xrp
         WoKLv0sQlBjo0kmISb+FTRiIdo3xmVwt7Fwv8XcM3I5v2LZHbEVqmsnMC3y8V//q6P
         dTXiD/tQFBxu3aM/35XS20idj2VJHXB0yrmZu8oVeOF/iwXdLB8y57HtRqeQ02JZVa
         NtJ5Ub0vf4iCslV73T2F2oP+ouuM1RVj2J1lE7Oqjw0T/7AP7j/xDeNtobmjPQ0/9Z
         tPdlf1ZK/xYEg==
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [GIT PULL] IOMMU fix for 5.10 (-final)
Message-ID: <20201209141237.GA8092@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
for a fix, where the size of the interrupt remapping table was increased
but a related constant for the size of the interrupt table was forgotten.

Cheers,

Will

--->8

The following changes since commit d76b42e92780c3587c1a998a3a943b501c137553:

  iommu/vt-d: Don't read VCCAP register unless it exists (2020-11-26 14:50:24 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to 4165bf015ba9454f45beaad621d16c516d5c5afe:

  iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs (2020-12-07 11:00:24 +0000)

----------------------------------------------------------------
iommu fix for 5.10

- Fix interrupt table length definition for AMD IOMMU

----------------------------------------------------------------
Suravee Suthikulpanit (1):
      iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs

 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

