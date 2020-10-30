Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688FC2A0D53
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJ3S0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:26:40 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:26669 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgJ3S0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:26:40 -0400
Received: from localhost.localdomain ([81.185.160.173])
        by mwinf5d86 with ME
        id mJSW2300E3km4KV03JSWA8; Fri, 30 Oct 2020 19:26:37 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Oct 2020 19:26:37 +0100
X-ME-IP: 81.185.160.173
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iommu/vt-d: Avoid GFP_ATOMIC where it is not needed
Date:   Fri, 30 Oct 2020 19:26:30 +0100
Message-Id: <20201030182630.5154-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to use GFP_ATOMIC in a 'suspend' function.
Use GFP_KERNEL instead to give more opportunities to allocate the
requested memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Should GFP_ATOMIC be mandatory here, a comment explaining why would be great
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f8177c59d229..cd2a82ed78b5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4114,7 +4114,7 @@ static int iommu_suspend(void)
 
 	for_each_active_iommu(iommu, drhd) {
 		iommu->iommu_state = kcalloc(MAX_SR_DMAR_REGS, sizeof(u32),
-						 GFP_ATOMIC);
+					     GFP_KERNEL);
 		if (!iommu->iommu_state)
 			goto nomem;
 	}
-- 
2.27.0

