Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE3B2FC864
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbhATDDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:03:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:40624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbhATCj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 21:39:59 -0500
IronPort-SDR: 5Hlb9OmTD6Qpk5cJocUb1cr3wuuXRnDSwNvh12e40SdFg/T2Dxb1PzjCDA6Qli17qVCnXh/vLG
 mUT5chQRYcQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243103790"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243103790"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 18:39:13 -0800
IronPort-SDR: tVJQaAF/FT1V8bIT/JDWrOT3VxjGJe9koZBp9bzSU+luwpO5ZQ1sht/etOQJxS0zf/FKAoHXN4
 2F+K+DcGlzLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="355869067"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 18:39:11 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH 1/2] mfd: intel-m10-bmc: fix the register access range
Date:   Wed, 20 Jan 2021 10:34:40 +0800
Message-Id: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the max register address of MAX 10 BMC. The range
0x20000000 ~ 0x200000fc are for control registers of the QSPI flash
controller, which are not accessible to host.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
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

