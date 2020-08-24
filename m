Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE124FC04
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHXKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:54:21 -0400
Received: from 8bytes.org ([81.169.241.247]:39242 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgHXKyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:54:18 -0400
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id AD0D436B;
        Mon, 24 Aug 2020 12:54:17 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Alexander.Deucher@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/amd: Do not use IOMMUv2 functionality when SME is active
Date:   Mon, 24 Aug 2020 12:54:15 +0200
Message-Id: <20200824105415.21000-3-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824105415.21000-1-joro@8bytes.org>
References: <20200824105415.21000-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

When memory encryption is active the device is likely not in a direct
mapped domain. Forbid using IOMMUv2 functionality for now until finer
grained checks for this have been implemented.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu_v2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index c259108ab6dd..0d175aed1d92 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -737,6 +737,13 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	might_sleep();
 
+	/*
+	 * When memory encryption is active the device is likely not in a
+	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
+	 */
+	if (mem_encrypt_active())
+		return -ENODEV;
+
 	if (!amd_iommu_v2_supported())
 		return -ENODEV;
 
-- 
2.28.0

