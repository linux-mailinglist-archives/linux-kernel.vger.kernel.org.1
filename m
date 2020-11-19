Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B02B972B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgKSPz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:40299 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbgKSPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:27 -0500
IronPort-SDR: pnbMJq1NjcFMe2qQ5Lzf8P4X9qWAMX8fQ1sSh1DgSyFbAAHdKCm3LKtgRIrd+/y5Ku8j9LAtnM
 HrMgCq+6u6XA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170527256"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="170527256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:26 -0800
IronPort-SDR: LbEXB00T3Xt0bqvCp/0/QGK7mGpZ5zmWwLzTG+K/fKg+WD/rSXnU3u63m9FueP1nf62AQrn/hC
 3r4e5kdIWyYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="330971885"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Nov 2020 07:55:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DB2AC48A; Thu, 19 Nov 2020 17:55:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 04/12] thunderbolt: Keep the parent runtime resumed for a while on device disconnect
Date:   Thu, 19 Nov 2020 18:55:15 +0300
Message-Id: <20201119155523.41332-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing device firmware upgrade the device will disconnect for a
while and then reconnect back. Keep the parent device (and the whole
domain) powered for a while so we don't need to runtime resume
immediately when the device is connected back after the device upgrade
completes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index beee6e6b8b6e..635b949fb1d6 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -870,7 +870,13 @@ icm_fr_device_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
+	pm_runtime_get_sync(sw->dev.parent);
+
 	remove_switch(sw);
+
+	pm_runtime_mark_last_busy(sw->dev.parent);
+	pm_runtime_put_autosuspend(sw->dev.parent);
+
 	tb_switch_put(sw);
 }
 
@@ -1280,8 +1286,13 @@ icm_tr_device_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 		tb_warn(tb, "no switch exists at %llx, ignoring\n", route);
 		return;
 	}
+	pm_runtime_get_sync(sw->dev.parent);
 
 	remove_switch(sw);
+
+	pm_runtime_mark_last_busy(sw->dev.parent);
+	pm_runtime_put_autosuspend(sw->dev.parent);
+
 	tb_switch_put(sw);
 }
 
-- 
2.29.2

