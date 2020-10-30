Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0575A29FBEE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJ3C7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:23856 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgJ3C6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:19 -0400
IronPort-SDR: ZtiNijMNHHSK5Ks9ieBocwl0SmSPEtVVGEj6DizXofkiYM1TH+B1It2HS5/CFM0Myq9u1e/Zy0
 AOLPq9AVqFCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156326132"
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="156326132"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 19:58:19 -0700
IronPort-SDR: F5edtGBYImLPwum8yOMDL5Mle0zF4/DVLP2olhY+7FWpKf488xMvUn6fveggURre8kbs0Ilelt
 uMs08YyzjIxw==
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="469374416"
Received: from yisun1-ubuntu2.bj.intel.com ([10.238.144.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 29 Oct 2020 19:58:16 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        jean-philippe@linaro.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.l.liu@intel.com, jacob.jun.pan@linux.intel.com,
        Liu@vger.kernel.org, Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Fix a bug for PDP check in prq_event_thread
Date:   Fri, 30 Oct 2020 10:37:24 +0800
Message-Id: <1604025444-6954-3-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liu, Yi L" <yi.l.liu@intel.com>

In prq_event_thread(), the QI_PGRP_PDP is wrongly set by
'req->pasid_present' which should be replaced to
'req->priv_data_present'.

Fixes: 5b438f4ba315 ("iommu/vt-d: Support page request in scalable mode")
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7584669..3242ebd 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1035,7 +1035,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			resp.qw0 = QI_PGRP_PASID(req->pasid) |
 				QI_PGRP_DID(req->rid) |
 				QI_PGRP_PASID_P(req->pasid_present) |
-				QI_PGRP_PDP(req->pasid_present) |
+				QI_PGRP_PDP(req->priv_data_present) |
 				QI_PGRP_RESP_CODE(result) |
 				QI_PGRP_RESP_TYPE;
 			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
-- 
2.7.4

