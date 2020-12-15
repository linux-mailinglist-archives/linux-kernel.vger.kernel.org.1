Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28C2DADEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgLONVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:21:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:21857 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbgLONVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:21:03 -0500
IronPort-SDR: PQrBzB5z7mlpB+e/YBxznJFyZ3krR+/9Aj01hmEXoJTOUXX4bHpx6Hf76/gPNi6XEmi9Zj63BJ
 MIjDFg3glqHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="174983530"
X-IronPort-AV: E=Sophos;i="5.78,421,1599548400"; 
   d="scan'208";a="174983530"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 05:20:20 -0800
IronPort-SDR: dBtNgZkVJFbGNgvyaqbW9BHLS7xzgSLyrRvZT9PTD25l132ycU4QQLAFqmxkhgOSPtEFYRedUr
 qGHUfjMKw0GA==
X-IronPort-AV: E=Sophos;i="5.78,421,1599548400"; 
   d="scan'208";a="368214715"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 05:20:16 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Muchowski, MaciejX" <maciejx.muchowski@intel.com>,
        "Paczynski, Lukasz" <lukasz.paczynski@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] xhci: Introduce max wait timeout in xhci_handshake()
Date:   Tue, 15 Dec 2020 21:22:40 +0800
Message-Id: <20201215132240.4094-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time to finish a xhci_handshake() is platform specific
and sometimes during suspend resume test the followng
errors were encountered:
[53455.418330] ACPI: Waking up from system sleep state S4
[66838.490856] xhci_hcd 0000:00:14.0: xHCI dying, ignoring interrupt.
               Shouldn't IRQs be disabled?
After changing the poll time granularity from 1 usec to 20 usec in
xhci_handshake() this issue was not reproduced. While tuning on the
poll time granularity might be painful on different platforms, it is
applicable to introduce a module parameter to allow the xhci driver to wait
for at max 16 ms.

Reported-by: "Muchowski, MaciejX" <maciejx.muchowski@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/usb/host/xhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index d4a8d0efbbc4..b8be9f3cc987 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -38,6 +38,10 @@ static unsigned long long quirks;
 module_param(quirks, ullong, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
+static int wait_handshake;
+module_param(wait_handshake, int, 0644);
+MODULE_PARM_DESC(wait_handshake, "Force wait for completion of handshake");
+
 static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 {
 	struct xhci_segment *seg = ring->first_seg;
@@ -74,7 +78,7 @@ int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
 	ret = readl_poll_timeout_atomic(ptr, result,
 					(result & mask) == done ||
 					result == U32_MAX,
-					1, usec);
+					1, wait_handshake ? XHCI_MAX_HALT_USEC : usec);
 	if (result == U32_MAX)		/* card removed */
 		return -ENODEV;
 
-- 
2.17.1

