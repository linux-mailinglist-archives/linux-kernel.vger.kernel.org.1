Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A761A2E8E16
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbhACU34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbhACU3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D605520780;
        Sun,  3 Jan 2021 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609705754;
        bh=oQGIgV/H6wrkBUA2S35RTQkgGejmTkSBTYtV62nHBbA=;
        h=From:To:Cc:Subject:Date:From;
        b=rEV4XlJbWuGqje85a2fGio8WYGPZCTt8vOqcAB55vPu6cqXY9PzJgET4tBoR6k1Mi
         6qtuV77zjpg8gmYAqLdgKApYqJgvtZvx+zFPlDzraPN1lhqViCYaopQ0iYUpSv99H3
         ls2nSchzUdePf+GQ4si29qJBOIYAv0w1QnDiUzJMK2T7SLaD6P4p4DzsaVQN3jsCWu
         /1699fLBMgcjeHwzjybR6/EcLZhgZD93GgO/cZ+yD0GBzSqiO6n7FN3LDqiDlvoHab
         H7eXQEJOtq1btCCGfXqQSJm8qzOzIZhA2JrTFJDhzo/QV5kplk1CJn9m2IEvJeKgVW
         +EqQapLYMQdpw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/4] habanalabs: separate common code to dedicated folders
Date:   Sun,  3 Jan 2021 22:29:06 +0200
Message-Id: <20210103202909.243-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We separate some of the common code source files to different
folders for a better maintainability and testability.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/Makefile           | 10 ++++++++--
 drivers/misc/habanalabs/common/mmu/Makefile       |  2 ++
 drivers/misc/habanalabs/common/{ => mmu}/mmu.c    |  2 +-
 drivers/misc/habanalabs/common/{ => mmu}/mmu_v1.c |  4 ++--
 drivers/misc/habanalabs/common/pci/Makefile       |  2 ++
 drivers/misc/habanalabs/common/{ => pci}/pci.c    |  4 ++--
 6 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/mmu/Makefile
 rename drivers/misc/habanalabs/common/{ => mmu}/mmu.c (99%)
 rename drivers/misc/habanalabs/common/{ => mmu}/mmu_v1.c (99%)
 create mode 100644 drivers/misc/habanalabs/common/pci/Makefile
 rename drivers/misc/habanalabs/common/{ => pci}/pci.c (99%)

diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index eccd8c7dc62d..5d8b48288cf4 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -1,7 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+include $(src)/common/mmu/Makefile
+habanalabs-y += $(HL_COMMON_MMU_FILES)
+
+include $(src)/common/pci/Makefile
+habanalabs-y += $(HL_COMMON_PCI_FILES)
+
 HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/asid.o common/habanalabs_ioctl.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
-		common/command_submission.o common/mmu.o common/mmu_v1.o \
-		common/firmware_if.o common/pci.o
+		common/command_submission.o common/firmware_if.o
diff --git a/drivers/misc/habanalabs/common/mmu/Makefile b/drivers/misc/habanalabs/common/mmu/Makefile
new file mode 100644
index 000000000000..d852c3874658
--- /dev/null
+++ b/drivers/misc/habanalabs/common/mmu/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+HL_COMMON_MMU_FILES := common/mmu/mmu.o common/mmu/mmu_v1.o
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
similarity index 99%
rename from drivers/misc/habanalabs/common/mmu.c
rename to drivers/misc/habanalabs/common/mmu/mmu.c
index ec11111aee8a..105d556e3028 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -7,7 +7,7 @@
 
 #include <linux/slab.h>
 
-#include "habanalabs.h"
+#include "../habanalabs.h"
 
 static bool is_dram_va(struct hl_device *hdev, u64 virt_addr)
 {
diff --git a/drivers/misc/habanalabs/common/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
similarity index 99%
rename from drivers/misc/habanalabs/common/mmu_v1.c
rename to drivers/misc/habanalabs/common/mmu/mmu_v1.c
index 2ce6ea89d4fa..9d37ac9bf316 100644
--- a/drivers/misc/habanalabs/common/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -5,8 +5,8 @@
  * All Rights Reserved.
  */
 
-#include "habanalabs.h"
-#include "../include/hw_ip/mmu/mmu_general.h"
+#include "../habanalabs.h"
+#include "../../include/hw_ip/mmu/mmu_general.h"
 
 #include <linux/slab.h>
 
diff --git a/drivers/misc/habanalabs/common/pci/Makefile b/drivers/misc/habanalabs/common/pci/Makefile
new file mode 100644
index 000000000000..dc922a686683
--- /dev/null
+++ b/drivers/misc/habanalabs/common/pci/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+HL_COMMON_PCI_FILES := common/pci/pci.o
diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
similarity index 99%
rename from drivers/misc/habanalabs/common/pci.c
rename to drivers/misc/habanalabs/common/pci/pci.c
index b4725e6101f6..c56ec1574127 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -5,8 +5,8 @@
  * All Rights Reserved.
  */
 
-#include "habanalabs.h"
-#include "../include/hw_ip/pci/pci_general.h"
+#include "../habanalabs.h"
+#include "../../include/hw_ip/pci/pci_general.h"
 
 #include <linux/pci.h>
 
-- 
2.25.1

