Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5D20F4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgF3MqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbgF3MqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:46:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:46:16 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 072B52A7; Tue, 30 Jun 2020 14:46:14 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Make amd_iommu_apply_ivrs_quirks() static inline
Date:   Tue, 30 Jun 2020 14:46:11 +0200
Message-Id: <20200630124611.23153-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

At least the version in the header file to fix a compile warning about
the function being unused.

Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f892992c8744..57309716fd18 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -102,7 +102,7 @@ extern int __init add_special_device(u8 type, u8 id, u16 *devid,
 #ifdef CONFIG_DMI
 void amd_iommu_apply_ivrs_quirks(void);
 #else
-static void amd_iommu_apply_ivrs_quirks(void) { }
+static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
 
 #endif
-- 
2.27.0

