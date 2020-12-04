Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A002CE573
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgLDB7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:59:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:63510 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgLDB7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:59:38 -0500
IronPort-SDR: Gz14yc5xXlFNMV8OlI4dXZHmsP61ZKHta39QAANLThsrVnxdagaO0BbWjp8KQ7YNAphcal4Ldl
 pQ7YjzpfVJoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="170745349"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="170745349"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 17:57:57 -0800
IronPort-SDR: qaZVTzFz2rq/pkc+r11h5R/ogOEs12fSqr7bvnUCbos+zQgCFm5aJzGXPTMOvHl2QAu+zvyzFC
 todbiBzBgx7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="331053755"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2020 17:57:57 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] platform/x86: ISST: Check for unaligned mmio address
Date:   Thu,  3 Dec 2020 17:57:44 -0800
Message-Id: <20201204015746.1168941-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address should be aligned to 4 byte boundary. So send an error for
unaligned address.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
index aa17fd7817f8..e7e9808a1aed 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -42,6 +42,9 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
 	if (io_reg->reg < 0x04 || io_reg->reg > 0xD0)
 		return -EINVAL;
 
+	if (io_reg->reg % 4)
+		return -EINVAL;
+
 	if (io_reg->read_write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.25.4

