Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E675B2AE860
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgKKFsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:48:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:33742 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgKKFsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:48:39 -0500
IronPort-SDR: 6q+AaG+BqArPIXNpYq1LzMHghdA3cuVWdFUM5RjPvsz2WjRvKjJYLG5QKH1MKLvQY8J8iel6Sg
 LCSFSkS9gi3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="167514658"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="167514658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:48:37 -0800
IronPort-SDR: GQAn2AxdTbUNCmGj5XIbdbjeNUiJ+V1YnGDXRmBndF6GCSgxDLp4gIKWrZXO9h2G5Bw3LUXsoP
 FNlzG0sMSO0A==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="308336271"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:48:34 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/4][RFC] e1000e: save the return value of e1000e_reset()
Date:   Wed, 11 Nov 2020 13:51:00 +0800
Message-Id: <7e68b2f6a9b0a6e03f6eeba8433bc532a3256830.1605073208.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes e1000e_reset() might fail during reume from S3 due to
hardware/firmware issues. Actually the return value from e1000e_reset()
can be used by the caller to verify if the NIC succeed to initialize or
not.

Introduce a static function _e1000e_reset() which is derived
from e1000e_reset(), except that the former returns the result
of this reset.

No functional change expected.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b30f00891c03..f7c08426c0d7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3998,7 +3998,7 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
  * set/changed during runtime. After reset the device needs to be
  * properly configured for Rx, Tx etc.
  */
-void e1000e_reset(struct e1000_adapter *adapter)
+static int _e1000e_reset(struct e1000_adapter *adapter)
 {
 	struct e1000_mac_info *mac = &adapter->hw.mac;
 	struct e1000_fc_info *fc = &adapter->hw.fc;
@@ -4191,14 +4191,14 @@ void e1000e_reset(struct e1000_adapter *adapter)
 		default:
 			dev_err(&adapter->pdev->dev,
 				"Invalid PHY type setting EEE advertisement\n");
-			return;
+			return -EINVAL;
 		}
 
 		ret_val = hw->phy.ops.acquire(hw);
 		if (ret_val) {
 			dev_err(&adapter->pdev->dev,
 				"EEE advertisement - unable to acquire PHY\n");
-			return;
+			return -EBUSY;
 		}
 
 		e1000_write_emi_reg_locked(hw, adv_addr,
@@ -4239,6 +4239,12 @@ void e1000e_reset(struct e1000_adapter *adapter)
 		ew32(FEXTNVM9, reg);
 	}
 
+	return 0;
+}
+
+void e1000e_reset(struct e1000_adapter *adapter)
+{
+	_e1000e_reset(adapter);
 }
 
 /**
-- 
2.17.1

