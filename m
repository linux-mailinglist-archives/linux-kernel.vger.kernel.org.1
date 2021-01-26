Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC12304674
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbhAZRXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:23:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:55404 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbhAZGzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:55:49 -0500
IronPort-SDR: FwnFRN7Wo60OWUN7nZ8iavhLIPMQl5LnxvZt/iw86KhVk/nyNGPPTzF/q9cgyVFugDeBfVtT9X
 abZbeQgWvXIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177289715"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="177289715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 22:55:06 -0800
IronPort-SDR: RH3RXJF9zBGtEq5jY7S9S3+acyj42r4lVsumTSYEHpczJ5i9xYCafepw6tYaazzrGQFSuDflVy
 Qwu1uXWzoWjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387713029"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2021 22:55:03 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v2 1/4] mfd: intel-m10-bmc: Fix the register access range
Date:   Tue, 26 Jan 2021 14:50:33 +0800
Message-Id: <1611643836-7183-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
References: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the max register address of MAX 10 BMC. The range
0x20000000 ~ 0x200000fc are for control registers of the QSPI flash
controller, which are not accessible to host.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2: no change.
---
 include/linux/mfd/intel-m10-bmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index c8ef2f1..06da62c 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -11,7 +11,7 @@
 
 #define M10BMC_LEGACY_SYS_BASE		0x300400
 #define M10BMC_SYS_BASE			0x300800
-#define M10BMC_MEM_END			0x200000fc
+#define M10BMC_MEM_END			0x1fffffff
 
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
-- 
2.7.4

