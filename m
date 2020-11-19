Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843F62B9724
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgKSPzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:43273 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgKSPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:30 -0500
IronPort-SDR: cWW8kGmcqumybL/ZPc2Uwe3FFnILMIaWsMnhMzvPPEuAy5BoyYunWaIPneKtQ5e7S8ghLkg+f4
 JwSgCtCqv/ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159081204"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="159081204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:29 -0800
IronPort-SDR: hTNG8JPEbqlkqYL0b8qO7ocadxyJ/t2WzY+23hWKo+uc8ykiO+W7D/53Uws0Ir8IKPjVA7anzH
 OKQChYuoGgVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,353,1599548400"; 
   d="scan'208";a="431281603"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 07:55:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 41568942; Thu, 19 Nov 2020 17:55:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 12/12] thunderbolt: Add support for Intel Maple Ridge
Date:   Thu, 19 Nov 2020 18:55:23 +0300
Message-Id: <20201119155523.41332-13-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maple Ridge is first discrete USB4 host controller from Intel. It comes
with firmware based connection manager and the flows are similar as used
in Intel Titan Ridge.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 11 +++++++++++
 drivers/thunderbolt/nhi.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 35935c106e3d..adc7b61937a1 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -2499,6 +2499,17 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 		icm->rtd3_veto = icm_icl_rtd3_veto;
 		tb->cm_ops = &icm_icl_ops;
 		break;
+
+	case PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_4C_NHI:
+		icm->is_supported = icm_tgl_is_supported;
+		icm->get_mode = icm_ar_get_mode;
+		icm->driver_ready = icm_tr_driver_ready;
+		icm->device_connected = icm_tr_device_connected;
+		icm->device_disconnected = icm_tr_device_disconnected;
+		icm->xdomain_connected = icm_tr_xdomain_connected;
+		icm->xdomain_disconnected = icm_tr_xdomain_disconnected;
+		tb->cm_ops = &icm_tr_ops;
+		break;
 	}
 
 	if (!icm->is_supported || !icm->is_supported(tb)) {
diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 80162e4b013f..ffe0531c0fd0 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -55,6 +55,7 @@ extern const struct tb_nhi_ops icl_nhi_ops;
  * need for the PCI quirk anymore as we will use ICM also on Apple
  * hardware.
  */
+#define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_4C_NHI		0x1137
 #define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_NHI            0x157d
 #define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_BRIDGE         0x157e
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_NHI		0x15bf
-- 
2.29.2

