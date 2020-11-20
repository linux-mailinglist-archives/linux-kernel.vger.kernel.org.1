Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307332BA995
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgKTLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgKTLul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:50:41 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B814422253;
        Fri, 20 Nov 2020 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605873040;
        bh=ea4nW8m0igZipC/exKVzNA25UDfEbUhPnBl6fApkIiA=;
        h=Date:From:To:Cc:Subject:From;
        b=fgnex9fZNYd4RsdG05/19EG//wUcJ+LuTxh+Aq76dXYVc0K2nxAIRplSLXyrfOM5s
         14G263Hg3zeB/tM1LclLlz0+XOHNvDGwdsuJ3588EO3viweTQPd25BBBsC/J+XNPvs
         ikl1FFZvGmUvcvjSFUH55adVwCN0JgdgYdUfYHlg=
Date:   Fri, 20 Nov 2020 11:50:35 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, tglx@linutronix.de,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [GIT PULL] IOMMU fixes for -rc5
Message-ID: <20201120115034.GA6386@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As mentioned at [1], I'm temporarily helping out with the IOMMU tree so
here are some fixes I've collected for -rc5, including an update to
MAINTAINERS as suggested by Joerg on IRC.

Anyway, two straightforward vt-d fixes summarised in the tag. I ended up
pulling in some x86 fixes from tip which you already merged for -rc4, as
the DMAR build failure was introduced there and so I needed that in order
to apply the fix.

Please pull.

Cheers,

Will

[1] https://lore.kernel.org/lkml/20201117100953.GR22888@8bytes.org/

--->8

The following changes since commit ff828729be446b86957f7c294068758231cd2183:

  iommu/vt-d: Cure VF irqdomain hickup (2020-11-13 12:00:40 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to 91c2c28d8de34815ea9bb4d16e9db7308ad33d3e:

  MAINTAINERS: Temporarily add myself to the IOMMU entry (2020-11-19 11:12:17 +0000)

----------------------------------------------------------------
iommu fixes for -rc5

- Fix boot when intel iommu initialisation fails under TXT (tboot)

- Fix intel iommu compilation error when DMAR is enabled without ATS

- Temporarily update IOMMU MAINTAINERs entry

----------------------------------------------------------------
Lu Baolu (1):
      iommu/vt-d: Fix compile error with CONFIG_PCI_ATS not set

Will Deacon (2):
      Merge tag 'x86-urgent-2020-11-15' of git://git.kernel.org/.../tip/tip into for-next/iommu/fixes
      MAINTAINERS: Temporarily add myself to the IOMMU entry

Zhenzhong Duan (1):
      iommu/vt-d: Avoid panic if iommu init fails in tboot system

 MAINTAINERS                 | 1 +
 arch/x86/kernel/tboot.c     | 3 ---
 drivers/iommu/intel/dmar.c  | 4 +++-
 drivers/iommu/intel/iommu.c | 5 +++--
 include/linux/intel-iommu.h | 1 -
 5 files changed, 7 insertions(+), 7 deletions(-)
