Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A77295649
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 04:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894911AbgJVCMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 22:12:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894903AbgJVCMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 22:12:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3CC46E8379C13C591C45;
        Thu, 22 Oct 2020 10:12:34 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 22 Oct 2020 10:12:27 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <rui.xiang@huawei.com>,
        <weiyongjun1@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH] Kconfig: Move CONFIG_DEBUG_KMEMLEAK_TEST to samples/Kconfig
Date:   Thu, 22 Oct 2020 02:12:34 +0000
Message-ID: <20201022021234.6638-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Jun <c00424029@huawei.com>

commit 1abbef4f51724fb11f09adf0e75275f7cb422a8a
("mm,kmemleak-test.c: move kmemleak-test.c to samples dir")
make CONFIG_DEBUG_KMEMLEAK_TEST depend on CONFIG_SAMPLES implicitly.
And the dependency cannot be guaranteed by Kconfig.

move the definition of CONFIG_DEBUG_KMEMLEAK_TEST from lib/Kconfig.debug
to samples/Kconfig.

Signed-off-by: Chen Jun <c00424029@huawei.com>
---
 lib/Kconfig.debug | 8 --------
 samples/Kconfig   | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 66d44d3..debacdc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -678,14 +678,6 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
 	  fully initialised, this memory pool acts as an emergency one
 	  if slab allocations fail.
 
-config DEBUG_KMEMLEAK_TEST
-	tristate "Simple test for the kernel memory leak detector"
-	depends on DEBUG_KMEMLEAK && m
-	help
-	  This option enables a module that explicitly leaks memory.
-
-	  If unsure, say N.
-
 config DEBUG_KMEMLEAK_DEFAULT_OFF
 	bool "Default kmemleak to off"
 	depends on DEBUG_KMEMLEAK
diff --git a/samples/Kconfig b/samples/Kconfig
index 0ed6e4d..15978dd 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -216,4 +216,12 @@ config SAMPLE_WATCH_QUEUE
 	  Build example userspace program to use the new mount_notify(),
 	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
 
+config DEBUG_KMEMLEAK_TEST
+	tristate "Simple test for the kernel memory leak detector"
+	depends on DEBUG_KMEMLEAK && m
+	help
+	  This option enables a module that explicitly leaks memory.
+
+	  If unsure, say N.
+
 endif # SAMPLES
-- 
2.7.4

