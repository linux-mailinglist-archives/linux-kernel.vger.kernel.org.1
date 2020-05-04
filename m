Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913751C3A50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgEDMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 08:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728154AbgEDMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE5C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 05:54:17 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B004139F; Mon,  4 May 2020 14:54:14 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Qian Cai <cai@lca.pw>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/5] iommu/amd: Fix race conditions around increase_address_space()
Date:   Mon,  4 May 2020 14:54:08 +0200
Message-Id: <20200504125413.16798-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Qian reported more race conditions around the dma-mapping
code path in the AMD IOMMU driver. The race condtions are
between increas_address_space() and fetch_pte(), there were
two of them:

	1) the 'pt_root' and 'mode' fields of 'struct
	   protection_domain' relate to each other so that
	   they must be updated together atomically.

	2) The increase_address_space() function publishes
	   the updated page-table before it has been written
	   to the DTE. This might cause PTEs to be mapped
	   and addresses handed to the device which are not
	   yet reachable through the DTE entry, causing IO
	   page-faults.

This patch-set fixes these issues, as tested by Qian Cai.

Thanks a lot again for reporting these issued and testing
the fixes!

Regards,

	Joerg


Joerg Roedel (5):
  iommu/amd: Fix race in increase_address_space()/fetch_pte()
  iommu/amd: Do not loop forever when trying to increase address space
  iommu/amd: Call domain_flush_complete() in update_domain()
  iommu/amd: Update Device Table in increase_address_space()
  iommu/amd: Do not flush Device Table in iommu_map_page()

 drivers/iommu/amd_iommu.c       | 198 +++++++++++++++++++++++++-------
 drivers/iommu/amd_iommu_types.h |   9 +-
 2 files changed, 161 insertions(+), 46 deletions(-)

-- 
2.17.1

