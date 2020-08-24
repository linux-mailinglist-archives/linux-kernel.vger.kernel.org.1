Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042E124FC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHXKze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:55:34 -0400
Received: from 8bytes.org ([81.169.241.247]:39232 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgHXKyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:54:19 -0400
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 77D9E35A;
        Mon, 24 Aug 2020 12:54:17 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Alexander.Deucher@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/amd: Do not force direct mapping when SME is active
Date:   Mon, 24 Aug 2020 12:54:14 +0200
Message-Id: <20200824105415.21000-2-joro@8bytes.org>
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

Do not force devices supporting IOMMUv2 to be direct mapped when memory
encryption is active. This might cause them to be unusable because their
DMA mask does not include the encryption bit.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ba9f3dbc5b94..77e4268e41cf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2659,7 +2659,12 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	if (!dev_data)
 		return 0;
 
-	if (dev_data->iommu_v2)
+	/*
+	 * Do not identity map IOMMUv2 capable devices when memory encryption is
+	 * active, because some of those devices (AMD GPUs) don't have the
+	 * encryption bit in their DMA-mask and require remapping.
+	 */
+	if (!mem_encrypt_active() && dev_data->iommu_v2)
 		return IOMMU_DOMAIN_IDENTITY;
 
 	return 0;
-- 
2.28.0

