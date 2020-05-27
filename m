Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043511E408B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgE0Lxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgE0Lx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:28 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0D1C08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:53:28 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C97624F2; Wed, 27 May 2020 13:53:24 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 10/10] iommu/amd: Remove redundant devid checks
Date:   Wed, 27 May 2020 13:53:13 +0200
Message-Id: <20200527115313.7426-11-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Checking the return value of get_device_id() in a code-path which has
already done check_device() is not needed, as check_device() does the
same check and bails out if it fails.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2504aa184837..db149c1a35bf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -413,13 +413,8 @@ static void iommu_ignore_device(struct device *dev)
 static void amd_iommu_uninit_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
-	int devid;
-
-	devid = get_device_id(dev);
-	if (devid < 0)
-		return;
 
-	dev_data = search_dev_data(devid);
+	dev_data = dev_iommu_priv_get(dev);
 	if (!dev_data)
 		return;
 
@@ -2173,16 +2168,12 @@ static void amd_iommu_probe_finalize(struct device *dev)
 
 static void amd_iommu_release_device(struct device *dev)
 {
+	int devid = get_device_id(dev);
 	struct amd_iommu *iommu;
-	int devid;
 
 	if (!check_device(dev))
 		return;
 
-	devid = get_device_id(dev);
-	if (devid < 0)
-		return;
-
 	iommu = amd_iommu_rlookup_table[devid];
 
 	amd_iommu_uninit_device(dev);
-- 
2.17.1

