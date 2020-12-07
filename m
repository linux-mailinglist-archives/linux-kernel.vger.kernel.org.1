Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0797F2D185E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLGSSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:18:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:55724 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgLGSSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:18:46 -0500
IronPort-SDR: fuPoArL3QF3FWuGvhQz4wZigChuLmXV+gtzZGayAXcf3ws8KxIz7yGhjgiEOQ1WuRewx+0T3qG
 S0oVkFFRlfxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173896495"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="173896495"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:15:39 -0800
IronPort-SDR: dioFEqjJm9PiGziHPgN8hDPTmWvkpd6c1xrOHyWe5pQj4W3rKRnLu9p8xiDi4HQhKKZyvi/Wey
 eG+W5MJ8rckw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="539892865"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2020 10:15:38 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/3] platform/x86: ISST: Check for unaligned mmio address
Date:   Mon,  7 Dec 2020 10:15:29 -0800
Message-Id: <20201207181531.1718148-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201207181531.1718148-1-srinivas.pandruvada@linux.intel.com>
References: <20201207181531.1718148-1-srinivas.pandruvada@linux.intel.com>
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

