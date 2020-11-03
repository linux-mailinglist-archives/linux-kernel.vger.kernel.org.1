Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB8B2A3C99
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKCGHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCGH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:07:27 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E5C2227F;
        Tue,  3 Nov 2020 06:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604383631;
        bh=QqUw6eGdD6erdCZqwY4+Eh55ruPwsDnjkdCJpdCsbz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1O9c88ynUWwVVnqgUDnYjuoCaLHotWdhms74nFxJatdMifBa2NxIPXAu5tt5Oe5k1
         24ApH7u7GLv2DqK32MUn3RY3HbEY6yCTu1gFcIHg8tA/kP1Ck+fMwDBIT6Lbr9I0ut
         8AJEwiSuQ/VGZzFIjQjP9oVNtxtgNR1y/dIEo9bc=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     SW_Drivers@habana.ai, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 1/4] habanalabs/gaudi: add NIC QMAN H/W and registers definitions
Date:   Tue,  3 Nov 2020 08:06:58 +0200
Message-Id: <20201103060701.25852-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103060701.25852-1-ogabbay@kernel.org>
References: <20201103060701.25852-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add auto-generated header files that describe the NIC QMANs registers
used by the driver.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../include/gaudi/asic_reg/gaudi_regs.h       |  14 +-
 .../include/gaudi/asic_reg/nic0_qm0_masks.h   | 800 +++++++++++++++++
 .../include/gaudi/asic_reg/nic0_qm0_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic0_qm1_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic1_qm0_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic1_qm1_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic2_qm0_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic2_qm1_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic3_qm0_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic3_qm1_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic4_qm0_regs.h    | 834 ++++++++++++++++++
 .../include/gaudi/asic_reg/nic4_qm1_regs.h    | 834 ++++++++++++++++++
 .../habanalabs/include/gaudi/gaudi_masks.h    |  15 +
 13 files changed, 9168 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm1_regs.h

diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
index f92dc53af074..df21a40691e5 100644
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
@@ -89,7 +89,19 @@
 #include "tpc0_cfg_masks.h"
 #include "psoc_global_conf_masks.h"
 
-#include "psoc_pci_pll_regs.h"
+#include "nic0_qm0_regs.h"
+#include "nic1_qm0_regs.h"
+#include "nic2_qm0_regs.h"
+#include "nic3_qm0_regs.h"
+#include "nic4_qm0_regs.h"
+#include "nic0_qm1_regs.h"
+#include "nic1_qm1_regs.h"
+#include "nic2_qm1_regs.h"
+#include "nic3_qm1_regs.h"
+#include "nic4_qm1_regs.h"
+
+#include "nic0_qm0_masks.h"
+
 #include "psoc_hbm_pll_regs.h"
 #include "psoc_cpu_pll_regs.h"
 
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_masks.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_masks.h
new file mode 100644
index 000000000000..bd37b6452133
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_masks.h
@@ -0,0 +1,800 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC0_QM0_MASKS_H_
+#define ASIC_REG_NIC0_QM0_MASKS_H_
+
+/*
+ *****************************************
+ *   NIC0_QM0 (Prototype: QMAN)
+ *****************************************
+ */
+
+/* NIC0_QM0_GLBL_CFG0 */
+#define NIC0_QM0_GLBL_CFG0_PQF_EN_SHIFT                              0
+#define NIC0_QM0_GLBL_CFG0_PQF_EN_MASK                               0xF
+#define NIC0_QM0_GLBL_CFG0_CQF_EN_SHIFT                              4
+#define NIC0_QM0_GLBL_CFG0_CQF_EN_MASK                               0x1F0
+#define NIC0_QM0_GLBL_CFG0_CP_EN_SHIFT                               9
+#define NIC0_QM0_GLBL_CFG0_CP_EN_MASK                                0x3E00
+
+/* NIC0_QM0_GLBL_CFG1 */
+#define NIC0_QM0_GLBL_CFG1_PQF_STOP_SHIFT                            0
+#define NIC0_QM0_GLBL_CFG1_PQF_STOP_MASK                             0xF
+#define NIC0_QM0_GLBL_CFG1_CQF_STOP_SHIFT                            4
+#define NIC0_QM0_GLBL_CFG1_CQF_STOP_MASK                             0x1F0
+#define NIC0_QM0_GLBL_CFG1_CP_STOP_SHIFT                             9
+#define NIC0_QM0_GLBL_CFG1_CP_STOP_MASK                              0x3E00
+#define NIC0_QM0_GLBL_CFG1_PQF_FLUSH_SHIFT                           16
+#define NIC0_QM0_GLBL_CFG1_PQF_FLUSH_MASK                            0xF0000
+#define NIC0_QM0_GLBL_CFG1_CQF_FLUSH_SHIFT                           20
+#define NIC0_QM0_GLBL_CFG1_CQF_FLUSH_MASK                            0x1F00000
+#define NIC0_QM0_GLBL_CFG1_CP_FLUSH_SHIFT                            25
+#define NIC0_QM0_GLBL_CFG1_CP_FLUSH_MASK                             0x3E000000
+
+/* NIC0_QM0_GLBL_PROT */
+#define NIC0_QM0_GLBL_PROT_PQF_SHIFT                                 0
+#define NIC0_QM0_GLBL_PROT_PQF_MASK                                  0xF
+#define NIC0_QM0_GLBL_PROT_CQF_SHIFT                                 4
+#define NIC0_QM0_GLBL_PROT_CQF_MASK                                  0x1F0
+#define NIC0_QM0_GLBL_PROT_CP_SHIFT                                  9
+#define NIC0_QM0_GLBL_PROT_CP_MASK                                   0x3E00
+#define NIC0_QM0_GLBL_PROT_ERR_SHIFT                                 14
+#define NIC0_QM0_GLBL_PROT_ERR_MASK                                  0x4000
+#define NIC0_QM0_GLBL_PROT_ARB_SHIFT                                 15
+#define NIC0_QM0_GLBL_PROT_ARB_MASK                                  0x8000
+
+/* NIC0_QM0_GLBL_ERR_CFG */
+#define NIC0_QM0_GLBL_ERR_CFG_PQF_ERR_MSG_EN_SHIFT                   0
+#define NIC0_QM0_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK                    0xF
+#define NIC0_QM0_GLBL_ERR_CFG_CQF_ERR_MSG_EN_SHIFT                   4
+#define NIC0_QM0_GLBL_ERR_CFG_CQF_ERR_MSG_EN_MASK                    0x1F0
+#define NIC0_QM0_GLBL_ERR_CFG_CP_ERR_MSG_EN_SHIFT                    9
+#define NIC0_QM0_GLBL_ERR_CFG_CP_ERR_MSG_EN_MASK                     0x3E00
+#define NIC0_QM0_GLBL_ERR_CFG_PQF_STOP_ON_ERR_SHIFT                  16
+#define NIC0_QM0_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK                   0xF0000
+#define NIC0_QM0_GLBL_ERR_CFG_CQF_STOP_ON_ERR_SHIFT                  20
+#define NIC0_QM0_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK                   0x1F00000
+#define NIC0_QM0_GLBL_ERR_CFG_CP_STOP_ON_ERR_SHIFT                   25
+#define NIC0_QM0_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK                    0x3E000000
+#define NIC0_QM0_GLBL_ERR_CFG_ARB_STOP_ON_ERR_SHIFT                  31
+#define NIC0_QM0_GLBL_ERR_CFG_ARB_STOP_ON_ERR_MASK                   0x80000000
+
+/* NIC0_QM0_GLBL_SECURE_PROPS */
+#define NIC0_QM0_GLBL_SECURE_PROPS_0_ASID_SHIFT                      0
+#define NIC0_QM0_GLBL_SECURE_PROPS_0_ASID_MASK                       0x3FF
+#define NIC0_QM0_GLBL_SECURE_PROPS_1_ASID_SHIFT                      0
+#define NIC0_QM0_GLBL_SECURE_PROPS_1_ASID_MASK                       0x3FF
+#define NIC0_QM0_GLBL_SECURE_PROPS_2_ASID_SHIFT                      0
+#define NIC0_QM0_GLBL_SECURE_PROPS_2_ASID_MASK                       0x3FF
+#define NIC0_QM0_GLBL_SECURE_PROPS_3_ASID_SHIFT                      0
+#define NIC0_QM0_GLBL_SECURE_PROPS_3_ASID_MASK                       0x3FF
+#define NIC0_QM0_GLBL_SECURE_PROPS_4_ASID_SHIFT                      0
+#define NIC0_QM0_GLBL_SECURE_PROPS_4_ASID_MASK                       0x3FF
+#define NIC0_QM0_GLBL_SECURE_PROPS_0_MMBP_SHIFT                      10
+#define NIC0_QM0_GLBL_SECURE_PROPS_0_MMBP_MASK                       0x400
+#define NIC0_QM0_GLBL_SECURE_PROPS_1_MMBP_SHIFT                      10
+#define NIC0_QM0_GLBL_SECURE_PROPS_1_MMBP_MASK                       0x400
+#define NIC0_QM0_GLBL_SECURE_PROPS_2_MMBP_SHIFT                      10
+#define NIC0_QM0_GLBL_SECURE_PROPS_2_MMBP_MASK                       0x400
+#define NIC0_QM0_GLBL_SECURE_PROPS_3_MMBP_SHIFT                      10
+#define NIC0_QM0_GLBL_SECURE_PROPS_3_MMBP_MASK                       0x400
+#define NIC0_QM0_GLBL_SECURE_PROPS_4_MMBP_SHIFT                      10
+#define NIC0_QM0_GLBL_SECURE_PROPS_4_MMBP_MASK                       0x400
+
+/* NIC0_QM0_GLBL_NON_SECURE_PROPS */
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_0_ASID_SHIFT                  0
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_0_ASID_MASK                   0x3FF
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_1_ASID_SHIFT                  0
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_1_ASID_MASK                   0x3FF
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_2_ASID_SHIFT                  0
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_2_ASID_MASK                   0x3FF
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_3_ASID_SHIFT                  0
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_3_ASID_MASK                   0x3FF
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_4_ASID_SHIFT                  0
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_4_ASID_MASK                   0x3FF
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_0_MMBP_SHIFT                  10
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_0_MMBP_MASK                   0x400
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_1_MMBP_SHIFT                  10
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_1_MMBP_MASK                   0x400
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_2_MMBP_SHIFT                  10
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_2_MMBP_MASK                   0x400
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_3_MMBP_SHIFT                  10
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_3_MMBP_MASK                   0x400
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_4_MMBP_SHIFT                  10
+#define NIC0_QM0_GLBL_NON_SECURE_PROPS_4_MMBP_MASK                   0x400
+
+/* NIC0_QM0_GLBL_STS0 */
+#define NIC0_QM0_GLBL_STS0_PQF_IDLE_SHIFT                            0
+#define NIC0_QM0_GLBL_STS0_PQF_IDLE_MASK                             0xF
+#define NIC0_QM0_GLBL_STS0_CQF_IDLE_SHIFT                            4
+#define NIC0_QM0_GLBL_STS0_CQF_IDLE_MASK                             0x1F0
+#define NIC0_QM0_GLBL_STS0_CP_IDLE_SHIFT                             9
+#define NIC0_QM0_GLBL_STS0_CP_IDLE_MASK                              0x3E00
+#define NIC0_QM0_GLBL_STS0_PQF_IS_STOP_SHIFT                         16
+#define NIC0_QM0_GLBL_STS0_PQF_IS_STOP_MASK                          0xF0000
+#define NIC0_QM0_GLBL_STS0_CQF_IS_STOP_SHIFT                         20
+#define NIC0_QM0_GLBL_STS0_CQF_IS_STOP_MASK                          0x1F00000
+#define NIC0_QM0_GLBL_STS0_CP_IS_STOP_SHIFT                          25
+#define NIC0_QM0_GLBL_STS0_CP_IS_STOP_MASK                           0x3E000000
+#define NIC0_QM0_GLBL_STS0_ARB_IS_STOP_SHIFT                         31
+#define NIC0_QM0_GLBL_STS0_ARB_IS_STOP_MASK                          0x80000000
+
+/* NIC0_QM0_GLBL_STS1 */
+#define NIC0_QM0_GLBL_STS1_PQF_RD_ERR_SHIFT                          0
+#define NIC0_QM0_GLBL_STS1_PQF_RD_ERR_MASK                           0x1
+#define NIC0_QM0_GLBL_STS1_CQF_RD_ERR_SHIFT                          1
+#define NIC0_QM0_GLBL_STS1_CQF_RD_ERR_MASK                           0x2
+#define NIC0_QM0_GLBL_STS1_CP_RD_ERR_SHIFT                           2
+#define NIC0_QM0_GLBL_STS1_CP_RD_ERR_MASK                            0x4
+#define NIC0_QM0_GLBL_STS1_CP_UNDEF_CMD_ERR_SHIFT                    3
+#define NIC0_QM0_GLBL_STS1_CP_UNDEF_CMD_ERR_MASK                     0x8
+#define NIC0_QM0_GLBL_STS1_CP_STOP_OP_SHIFT                          4
+#define NIC0_QM0_GLBL_STS1_CP_STOP_OP_MASK                           0x10
+#define NIC0_QM0_GLBL_STS1_CP_MSG_WR_ERR_SHIFT                       5
+#define NIC0_QM0_GLBL_STS1_CP_MSG_WR_ERR_MASK                        0x20
+#define NIC0_QM0_GLBL_STS1_CP_WREG_ERR_SHIFT                         6
+#define NIC0_QM0_GLBL_STS1_CP_WREG_ERR_MASK                          0x40
+#define NIC0_QM0_GLBL_STS1_CP_FENCE0_OVF_ERR_SHIFT                   8
+#define NIC0_QM0_GLBL_STS1_CP_FENCE0_OVF_ERR_MASK                    0x100
+#define NIC0_QM0_GLBL_STS1_CP_FENCE1_OVF_ERR_SHIFT                   9
+#define NIC0_QM0_GLBL_STS1_CP_FENCE1_OVF_ERR_MASK                    0x200
+#define NIC0_QM0_GLBL_STS1_CP_FENCE2_OVF_ERR_SHIFT                   10
+#define NIC0_QM0_GLBL_STS1_CP_FENCE2_OVF_ERR_MASK                    0x400
+#define NIC0_QM0_GLBL_STS1_CP_FENCE3_OVF_ERR_SHIFT                   11
+#define NIC0_QM0_GLBL_STS1_CP_FENCE3_OVF_ERR_MASK                    0x800
+#define NIC0_QM0_GLBL_STS1_CP_FENCE0_UDF_ERR_SHIFT                   12
+#define NIC0_QM0_GLBL_STS1_CP_FENCE0_UDF_ERR_MASK                    0x1000
+#define NIC0_QM0_GLBL_STS1_CP_FENCE1_UDF_ERR_SHIFT                   13
+#define NIC0_QM0_GLBL_STS1_CP_FENCE1_UDF_ERR_MASK                    0x2000
+#define NIC0_QM0_GLBL_STS1_CP_FENCE2_UDF_ERR_SHIFT                   14
+#define NIC0_QM0_GLBL_STS1_CP_FENCE2_UDF_ERR_MASK                    0x4000
+#define NIC0_QM0_GLBL_STS1_CP_FENCE3_UDF_ERR_SHIFT                   15
+#define NIC0_QM0_GLBL_STS1_CP_FENCE3_UDF_ERR_MASK                    0x8000
+
+/* NIC0_QM0_GLBL_STS1_4 */
+#define NIC0_QM0_GLBL_STS1_4_CQF_RD_ERR_SHIFT                        1
+#define NIC0_QM0_GLBL_STS1_4_CQF_RD_ERR_MASK                         0x2
+#define NIC0_QM0_GLBL_STS1_4_CP_RD_ERR_SHIFT                         2
+#define NIC0_QM0_GLBL_STS1_4_CP_RD_ERR_MASK                          0x4
+#define NIC0_QM0_GLBL_STS1_4_CP_UNDEF_CMD_ERR_SHIFT                  3
+#define NIC0_QM0_GLBL_STS1_4_CP_UNDEF_CMD_ERR_MASK                   0x8
+#define NIC0_QM0_GLBL_STS1_4_CP_STOP_OP_SHIFT                        4
+#define NIC0_QM0_GLBL_STS1_4_CP_STOP_OP_MASK                         0x10
+#define NIC0_QM0_GLBL_STS1_4_CP_MSG_WR_ERR_SHIFT                     5
+#define NIC0_QM0_GLBL_STS1_4_CP_MSG_WR_ERR_MASK                      0x20
+#define NIC0_QM0_GLBL_STS1_4_CP_WREG_ERR_SHIFT                       6
+#define NIC0_QM0_GLBL_STS1_4_CP_WREG_ERR_MASK                        0x40
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE0_OVF_ERR_SHIFT                 8
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE0_OVF_ERR_MASK                  0x100
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE1_OVF_ERR_SHIFT                 9
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE1_OVF_ERR_MASK                  0x200
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE2_OVF_ERR_SHIFT                 10
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE2_OVF_ERR_MASK                  0x400
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE3_OVF_ERR_SHIFT                 11
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE3_OVF_ERR_MASK                  0x800
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE0_UDF_ERR_SHIFT                 12
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE0_UDF_ERR_MASK                  0x1000
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE1_UDF_ERR_SHIFT                 13
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE1_UDF_ERR_MASK                  0x2000
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE2_UDF_ERR_SHIFT                 14
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE2_UDF_ERR_MASK                  0x4000
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE3_UDF_ERR_SHIFT                 15
+#define NIC0_QM0_GLBL_STS1_4_CP_FENCE3_UDF_ERR_MASK                  0x8000
+
+/* NIC0_QM0_GLBL_MSG_EN */
+#define NIC0_QM0_GLBL_MSG_EN_PQF_RD_ERR_SHIFT                        0
+#define NIC0_QM0_GLBL_MSG_EN_PQF_RD_ERR_MASK                         0x1
+#define NIC0_QM0_GLBL_MSG_EN_CQF_RD_ERR_SHIFT                        1
+#define NIC0_QM0_GLBL_MSG_EN_CQF_RD_ERR_MASK                         0x2
+#define NIC0_QM0_GLBL_MSG_EN_CP_RD_ERR_SHIFT                         2
+#define NIC0_QM0_GLBL_MSG_EN_CP_RD_ERR_MASK                          0x4
+#define NIC0_QM0_GLBL_MSG_EN_CP_UNDEF_CMD_ERR_SHIFT                  3
+#define NIC0_QM0_GLBL_MSG_EN_CP_UNDEF_CMD_ERR_MASK                   0x8
+#define NIC0_QM0_GLBL_MSG_EN_CP_STOP_OP_SHIFT                        4
+#define NIC0_QM0_GLBL_MSG_EN_CP_STOP_OP_MASK                         0x10
+#define NIC0_QM0_GLBL_MSG_EN_CP_MSG_WR_ERR_SHIFT                     5
+#define NIC0_QM0_GLBL_MSG_EN_CP_MSG_WR_ERR_MASK                      0x20
+#define NIC0_QM0_GLBL_MSG_EN_CP_WREG_ERR_SHIFT                       6
+#define NIC0_QM0_GLBL_MSG_EN_CP_WREG_ERR_MASK                        0x40
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE0_OVF_ERR_SHIFT                 8
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE0_OVF_ERR_MASK                  0x100
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE1_OVF_ERR_SHIFT                 9
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE1_OVF_ERR_MASK                  0x200
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE2_OVF_ERR_SHIFT                 10
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE2_OVF_ERR_MASK                  0x400
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE3_OVF_ERR_SHIFT                 11
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE3_OVF_ERR_MASK                  0x800
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE0_UDF_ERR_SHIFT                 12
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE0_UDF_ERR_MASK                  0x1000
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE1_UDF_ERR_SHIFT                 13
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE1_UDF_ERR_MASK                  0x2000
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE2_UDF_ERR_SHIFT                 14
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE2_UDF_ERR_MASK                  0x4000
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE3_UDF_ERR_SHIFT                 15
+#define NIC0_QM0_GLBL_MSG_EN_CP_FENCE3_UDF_ERR_MASK                  0x8000
+
+/* NIC0_QM0_GLBL_MSG_EN_4 */
+#define NIC0_QM0_GLBL_MSG_EN_4_CQF_RD_ERR_SHIFT                      1
+#define NIC0_QM0_GLBL_MSG_EN_4_CQF_RD_ERR_MASK                       0x2
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_RD_ERR_SHIFT                       2
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_RD_ERR_MASK                        0x4
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_UNDEF_CMD_ERR_SHIFT                3
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_UNDEF_CMD_ERR_MASK                 0x8
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_STOP_OP_SHIFT                      4
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_STOP_OP_MASK                       0x10
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_MSG_WR_ERR_SHIFT                   5
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_MSG_WR_ERR_MASK                    0x20
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_WREG_ERR_SHIFT                     6
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_WREG_ERR_MASK                      0x40
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE0_OVF_ERR_SHIFT               8
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE0_OVF_ERR_MASK                0x100
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE1_OVF_ERR_SHIFT               9
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE1_OVF_ERR_MASK                0x200
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE2_OVF_ERR_SHIFT               10
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE2_OVF_ERR_MASK                0x400
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE3_OVF_ERR_SHIFT               11
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE3_OVF_ERR_MASK                0x800
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE0_UDF_ERR_SHIFT               12
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE0_UDF_ERR_MASK                0x1000
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE1_UDF_ERR_SHIFT               13
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE1_UDF_ERR_MASK                0x2000
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE2_UDF_ERR_SHIFT               14
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE2_UDF_ERR_MASK                0x4000
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE3_UDF_ERR_SHIFT               15
+#define NIC0_QM0_GLBL_MSG_EN_4_CP_FENCE3_UDF_ERR_MASK                0x8000
+
+/* NIC0_QM0_PQ_BASE_LO */
+#define NIC0_QM0_PQ_BASE_LO_VAL_SHIFT                                0
+#define NIC0_QM0_PQ_BASE_LO_VAL_MASK                                 0xFFFFFFFF
+
+/* NIC0_QM0_PQ_BASE_HI */
+#define NIC0_QM0_PQ_BASE_HI_VAL_SHIFT                                0
+#define NIC0_QM0_PQ_BASE_HI_VAL_MASK                                 0xFFFFFFFF
+
+/* NIC0_QM0_PQ_SIZE */
+#define NIC0_QM0_PQ_SIZE_VAL_SHIFT                                   0
+#define NIC0_QM0_PQ_SIZE_VAL_MASK                                    0xFFFFFFFF
+
+/* NIC0_QM0_PQ_PI */
+#define NIC0_QM0_PQ_PI_VAL_SHIFT                                     0
+#define NIC0_QM0_PQ_PI_VAL_MASK                                      0xFFFFFFFF
+
+/* NIC0_QM0_PQ_CI */
+#define NIC0_QM0_PQ_CI_VAL_SHIFT                                     0
+#define NIC0_QM0_PQ_CI_VAL_MASK                                      0xFFFFFFFF
+
+/* NIC0_QM0_PQ_CFG0 */
+#define NIC0_QM0_PQ_CFG0_RESERVED_SHIFT                              0
+#define NIC0_QM0_PQ_CFG0_RESERVED_MASK                               0x1
+
+/* NIC0_QM0_PQ_CFG1 */
+#define NIC0_QM0_PQ_CFG1_CREDIT_LIM_SHIFT                            0
+#define NIC0_QM0_PQ_CFG1_CREDIT_LIM_MASK                             0xFFFF
+#define NIC0_QM0_PQ_CFG1_MAX_INFLIGHT_SHIFT                          16
+#define NIC0_QM0_PQ_CFG1_MAX_INFLIGHT_MASK                           0xFFFF0000
+
+/* NIC0_QM0_PQ_ARUSER_31_11 */
+#define NIC0_QM0_PQ_ARUSER_31_11_VAL_SHIFT                           0
+#define NIC0_QM0_PQ_ARUSER_31_11_VAL_MASK                            0x1FFFFF
+
+/* NIC0_QM0_PQ_STS0 */
+#define NIC0_QM0_PQ_STS0_PQ_CREDIT_CNT_SHIFT                         0
+#define NIC0_QM0_PQ_STS0_PQ_CREDIT_CNT_MASK                          0xFFFF
+#define NIC0_QM0_PQ_STS0_PQ_FREE_CNT_SHIFT                           16
+#define NIC0_QM0_PQ_STS0_PQ_FREE_CNT_MASK                            0xFFFF0000
+
+/* NIC0_QM0_PQ_STS1 */
+#define NIC0_QM0_PQ_STS1_PQ_INFLIGHT_CNT_SHIFT                       0
+#define NIC0_QM0_PQ_STS1_PQ_INFLIGHT_CNT_MASK                        0xFFFF
+#define NIC0_QM0_PQ_STS1_PQ_BUF_EMPTY_SHIFT                          30
+#define NIC0_QM0_PQ_STS1_PQ_BUF_EMPTY_MASK                           0x40000000
+#define NIC0_QM0_PQ_STS1_PQ_BUSY_SHIFT                               31
+#define NIC0_QM0_PQ_STS1_PQ_BUSY_MASK                                0x80000000
+
+/* NIC0_QM0_CQ_CFG0 */
+#define NIC0_QM0_CQ_CFG0_RESERVED_SHIFT                              0
+#define NIC0_QM0_CQ_CFG0_RESERVED_MASK                               0x1
+
+/* NIC0_QM0_CQ_CFG1 */
+#define NIC0_QM0_CQ_CFG1_CREDIT_LIM_SHIFT                            0
+#define NIC0_QM0_CQ_CFG1_CREDIT_LIM_MASK                             0xFFFF
+#define NIC0_QM0_CQ_CFG1_MAX_INFLIGHT_SHIFT                          16
+#define NIC0_QM0_CQ_CFG1_MAX_INFLIGHT_MASK                           0xFFFF0000
+
+/* NIC0_QM0_CQ_ARUSER_31_11 */
+#define NIC0_QM0_CQ_ARUSER_31_11_VAL_SHIFT                           0
+#define NIC0_QM0_CQ_ARUSER_31_11_VAL_MASK                            0x1FFFFF
+
+/* NIC0_QM0_CQ_STS0 */
+#define NIC0_QM0_CQ_STS0_CQ_CREDIT_CNT_SHIFT                         0
+#define NIC0_QM0_CQ_STS0_CQ_CREDIT_CNT_MASK                          0xFFFF
+#define NIC0_QM0_CQ_STS0_CQ_FREE_CNT_SHIFT                           16
+#define NIC0_QM0_CQ_STS0_CQ_FREE_CNT_MASK                            0xFFFF0000
+
+/* NIC0_QM0_CQ_STS1 */
+#define NIC0_QM0_CQ_STS1_CQ_INFLIGHT_CNT_SHIFT                       0
+#define NIC0_QM0_CQ_STS1_CQ_INFLIGHT_CNT_MASK                        0xFFFF
+#define NIC0_QM0_CQ_STS1_CQ_BUF_EMPTY_SHIFT                          30
+#define NIC0_QM0_CQ_STS1_CQ_BUF_EMPTY_MASK                           0x40000000
+#define NIC0_QM0_CQ_STS1_CQ_BUSY_SHIFT                               31
+#define NIC0_QM0_CQ_STS1_CQ_BUSY_MASK                                0x80000000
+
+/* NIC0_QM0_CQ_PTR_LO_0 */
+#define NIC0_QM0_CQ_PTR_LO_0_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_LO_0_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_PTR_HI_0 */
+#define NIC0_QM0_CQ_PTR_HI_0_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_HI_0_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_TSIZE_0 */
+#define NIC0_QM0_CQ_TSIZE_0_VAL_SHIFT                                0
+#define NIC0_QM0_CQ_TSIZE_0_VAL_MASK                                 0xFFFFFFFF
+
+/* NIC0_QM0_CQ_CTL_0 */
+#define NIC0_QM0_CQ_CTL_0_RPT_SHIFT                                  0
+#define NIC0_QM0_CQ_CTL_0_RPT_MASK                                   0xFFFF
+#define NIC0_QM0_CQ_CTL_0_CTL_SHIFT                                  16
+#define NIC0_QM0_CQ_CTL_0_CTL_MASK                                   0xFFFF0000
+
+/* NIC0_QM0_CQ_PTR_LO_1 */
+#define NIC0_QM0_CQ_PTR_LO_1_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_LO_1_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_PTR_HI_1 */
+#define NIC0_QM0_CQ_PTR_HI_1_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_HI_1_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_TSIZE_1 */
+#define NIC0_QM0_CQ_TSIZE_1_VAL_SHIFT                                0
+#define NIC0_QM0_CQ_TSIZE_1_VAL_MASK                                 0xFFFFFFFF
+
+/* NIC0_QM0_CQ_CTL_1 */
+#define NIC0_QM0_CQ_CTL_1_RPT_SHIFT                                  0
+#define NIC0_QM0_CQ_CTL_1_RPT_MASK                                   0xFFFF
+#define NIC0_QM0_CQ_CTL_1_CTL_SHIFT                                  16
+#define NIC0_QM0_CQ_CTL_1_CTL_MASK                                   0xFFFF0000
+
+/* NIC0_QM0_CQ_PTR_LO_2 */
+#define NIC0_QM0_CQ_PTR_LO_2_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_LO_2_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_PTR_HI_2 */
+#define NIC0_QM0_CQ_PTR_HI_2_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_HI_2_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_TSIZE_2 */
+#define NIC0_QM0_CQ_TSIZE_2_VAL_SHIFT                                0
+#define NIC0_QM0_CQ_TSIZE_2_VAL_MASK                                 0xFFFFFFFF
+
+/* NIC0_QM0_CQ_CTL_2 */
+#define NIC0_QM0_CQ_CTL_2_RPT_SHIFT                                  0
+#define NIC0_QM0_CQ_CTL_2_RPT_MASK                                   0xFFFF
+#define NIC0_QM0_CQ_CTL_2_CTL_SHIFT                                  16
+#define NIC0_QM0_CQ_CTL_2_CTL_MASK                                   0xFFFF0000
+
+/* NIC0_QM0_CQ_PTR_LO_3 */
+#define NIC0_QM0_CQ_PTR_LO_3_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_LO_3_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_PTR_HI_3 */
+#define NIC0_QM0_CQ_PTR_HI_3_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_HI_3_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_TSIZE_3 */
+#define NIC0_QM0_CQ_TSIZE_3_VAL_SHIFT                                0
+#define NIC0_QM0_CQ_TSIZE_3_VAL_MASK                                 0xFFFFFFFF
+
+/* NIC0_QM0_CQ_CTL_3 */
+#define NIC0_QM0_CQ_CTL_3_RPT_SHIFT                                  0
+#define NIC0_QM0_CQ_CTL_3_RPT_MASK                                   0xFFFF
+#define NIC0_QM0_CQ_CTL_3_CTL_SHIFT                                  16
+#define NIC0_QM0_CQ_CTL_3_CTL_MASK                                   0xFFFF0000
+
+/* NIC0_QM0_CQ_PTR_LO_4 */
+#define NIC0_QM0_CQ_PTR_LO_4_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_LO_4_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_PTR_HI_4 */
+#define NIC0_QM0_CQ_PTR_HI_4_VAL_SHIFT                               0
+#define NIC0_QM0_CQ_PTR_HI_4_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_CQ_TSIZE_4 */
+#define NIC0_QM0_CQ_TSIZE_4_VAL_SHIFT                                0
+#define NIC0_QM0_CQ_TSIZE_4_VAL_MASK                                 0xFFFFFFFF
+
+/* NIC0_QM0_CQ_CTL_4 */
+#define NIC0_QM0_CQ_CTL_4_RPT_SHIFT                                  0
+#define NIC0_QM0_CQ_CTL_4_RPT_MASK                                   0xFFFF
+#define NIC0_QM0_CQ_CTL_4_CTL_SHIFT                                  16
+#define NIC0_QM0_CQ_CTL_4_CTL_MASK                                   0xFFFF0000
+
+/* NIC0_QM0_CQ_PTR_LO_STS */
+#define NIC0_QM0_CQ_PTR_LO_STS_VAL_SHIFT                             0
+#define NIC0_QM0_CQ_PTR_LO_STS_VAL_MASK                              0xFFFFFFFF
+
+/* NIC0_QM0_CQ_PTR_HI_STS */
+#define NIC0_QM0_CQ_PTR_HI_STS_VAL_SHIFT                             0
+#define NIC0_QM0_CQ_PTR_HI_STS_VAL_MASK                              0xFFFFFFFF
+
+/* NIC0_QM0_CQ_TSIZE_STS */
+#define NIC0_QM0_CQ_TSIZE_STS_VAL_SHIFT                              0
+#define NIC0_QM0_CQ_TSIZE_STS_VAL_MASK                               0xFFFFFFFF
+
+/* NIC0_QM0_CQ_CTL_STS */
+#define NIC0_QM0_CQ_CTL_STS_RPT_SHIFT                                0
+#define NIC0_QM0_CQ_CTL_STS_RPT_MASK                                 0xFFFF
+#define NIC0_QM0_CQ_CTL_STS_CTL_SHIFT                                16
+#define NIC0_QM0_CQ_CTL_STS_CTL_MASK                                 0xFFFF0000
+
+/* NIC0_QM0_CQ_IFIFO_CNT */
+#define NIC0_QM0_CQ_IFIFO_CNT_VAL_SHIFT                              0
+#define NIC0_QM0_CQ_IFIFO_CNT_VAL_MASK                               0x3
+
+/* NIC0_QM0_CP_MSG_BASE0_ADDR_LO */
+#define NIC0_QM0_CP_MSG_BASE0_ADDR_LO_VAL_SHIFT                      0
+#define NIC0_QM0_CP_MSG_BASE0_ADDR_LO_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_MSG_BASE0_ADDR_HI */
+#define NIC0_QM0_CP_MSG_BASE0_ADDR_HI_VAL_SHIFT                      0
+#define NIC0_QM0_CP_MSG_BASE0_ADDR_HI_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_MSG_BASE1_ADDR_LO */
+#define NIC0_QM0_CP_MSG_BASE1_ADDR_LO_VAL_SHIFT                      0
+#define NIC0_QM0_CP_MSG_BASE1_ADDR_LO_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_MSG_BASE1_ADDR_HI */
+#define NIC0_QM0_CP_MSG_BASE1_ADDR_HI_VAL_SHIFT                      0
+#define NIC0_QM0_CP_MSG_BASE1_ADDR_HI_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_MSG_BASE2_ADDR_LO */
+#define NIC0_QM0_CP_MSG_BASE2_ADDR_LO_VAL_SHIFT                      0
+#define NIC0_QM0_CP_MSG_BASE2_ADDR_LO_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_MSG_BASE2_ADDR_HI */
+#define NIC0_QM0_CP_MSG_BASE2_ADDR_HI_VAL_SHIFT                      0
+#define NIC0_QM0_CP_MSG_BASE2_ADDR_HI_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_MSG_BASE3_ADDR_LO */
+#define NIC0_QM0_CP_MSG_BASE3_ADDR_LO_VAL_SHIFT                      0
+#define NIC0_QM0_CP_MSG_BASE3_ADDR_LO_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_MSG_BASE3_ADDR_HI */
+#define NIC0_QM0_CP_MSG_BASE3_ADDR_HI_VAL_SHIFT                      0
+#define NIC0_QM0_CP_MSG_BASE3_ADDR_HI_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_LDMA_TSIZE_OFFSET */
+#define NIC0_QM0_CP_LDMA_TSIZE_OFFSET_VAL_SHIFT                      0
+#define NIC0_QM0_CP_LDMA_TSIZE_OFFSET_VAL_MASK                       0xFFFFFFFF
+
+/* NIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET */
+#define NIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_VAL_SHIFT                0
+#define NIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_VAL_MASK                 0xFFFFFFFF
+
+/* NIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET */
+#define NIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_VAL_SHIFT                0
+#define NIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_VAL_MASK                 0xFFFFFFFF
+
+/* NIC0_QM0_CP_FENCE0_RDATA */
+#define NIC0_QM0_CP_FENCE0_RDATA_INC_VAL_SHIFT                       0
+#define NIC0_QM0_CP_FENCE0_RDATA_INC_VAL_MASK                        0xF
+
+/* NIC0_QM0_CP_FENCE1_RDATA */
+#define NIC0_QM0_CP_FENCE1_RDATA_INC_VAL_SHIFT                       0
+#define NIC0_QM0_CP_FENCE1_RDATA_INC_VAL_MASK                        0xF
+
+/* NIC0_QM0_CP_FENCE2_RDATA */
+#define NIC0_QM0_CP_FENCE2_RDATA_INC_VAL_SHIFT                       0
+#define NIC0_QM0_CP_FENCE2_RDATA_INC_VAL_MASK                        0xF
+
+/* NIC0_QM0_CP_FENCE3_RDATA */
+#define NIC0_QM0_CP_FENCE3_RDATA_INC_VAL_SHIFT                       0
+#define NIC0_QM0_CP_FENCE3_RDATA_INC_VAL_MASK                        0xF
+
+/* NIC0_QM0_CP_FENCE0_CNT */
+#define NIC0_QM0_CP_FENCE0_CNT_VAL_SHIFT                             0
+#define NIC0_QM0_CP_FENCE0_CNT_VAL_MASK                              0x3FFF
+
+/* NIC0_QM0_CP_FENCE1_CNT */
+#define NIC0_QM0_CP_FENCE1_CNT_VAL_SHIFT                             0
+#define NIC0_QM0_CP_FENCE1_CNT_VAL_MASK                              0x3FFF
+
+/* NIC0_QM0_CP_FENCE2_CNT */
+#define NIC0_QM0_CP_FENCE2_CNT_VAL_SHIFT                             0
+#define NIC0_QM0_CP_FENCE2_CNT_VAL_MASK                              0x3FFF
+
+/* NIC0_QM0_CP_FENCE3_CNT */
+#define NIC0_QM0_CP_FENCE3_CNT_VAL_SHIFT                             0
+#define NIC0_QM0_CP_FENCE3_CNT_VAL_MASK                              0x3FFF
+
+/* NIC0_QM0_CP_STS */
+#define NIC0_QM0_CP_STS_MSG_INFLIGHT_CNT_SHIFT                       0
+#define NIC0_QM0_CP_STS_MSG_INFLIGHT_CNT_MASK                        0xFFFF
+#define NIC0_QM0_CP_STS_ERDY_SHIFT                                   16
+#define NIC0_QM0_CP_STS_ERDY_MASK                                    0x10000
+#define NIC0_QM0_CP_STS_RRDY_SHIFT                                   17
+#define NIC0_QM0_CP_STS_RRDY_MASK                                    0x20000
+#define NIC0_QM0_CP_STS_MRDY_SHIFT                                   18
+#define NIC0_QM0_CP_STS_MRDY_MASK                                    0x40000
+#define NIC0_QM0_CP_STS_SW_STOP_SHIFT                                19
+#define NIC0_QM0_CP_STS_SW_STOP_MASK                                 0x80000
+#define NIC0_QM0_CP_STS_FENCE_ID_SHIFT                               20
+#define NIC0_QM0_CP_STS_FENCE_ID_MASK                                0x300000
+#define NIC0_QM0_CP_STS_FENCE_IN_PROGRESS_SHIFT                      22
+#define NIC0_QM0_CP_STS_FENCE_IN_PROGRESS_MASK                       0x400000
+
+/* NIC0_QM0_CP_CURRENT_INST_LO */
+#define NIC0_QM0_CP_CURRENT_INST_LO_VAL_SHIFT                        0
+#define NIC0_QM0_CP_CURRENT_INST_LO_VAL_MASK                         0xFFFFFFFF
+
+/* NIC0_QM0_CP_CURRENT_INST_HI */
+#define NIC0_QM0_CP_CURRENT_INST_HI_VAL_SHIFT                        0
+#define NIC0_QM0_CP_CURRENT_INST_HI_VAL_MASK                         0xFFFFFFFF
+
+/* NIC0_QM0_CP_BARRIER_CFG */
+#define NIC0_QM0_CP_BARRIER_CFG_EBGUARD_SHIFT                        0
+#define NIC0_QM0_CP_BARRIER_CFG_EBGUARD_MASK                         0xFFF
+#define NIC0_QM0_CP_BARRIER_CFG_RBGUARD_SHIFT                        16
+#define NIC0_QM0_CP_BARRIER_CFG_RBGUARD_MASK                         0xF0000
+
+/* NIC0_QM0_CP_DBG_0 */
+#define NIC0_QM0_CP_DBG_0_CS_SHIFT                                   0
+#define NIC0_QM0_CP_DBG_0_CS_MASK                                    0xF
+#define NIC0_QM0_CP_DBG_0_EB_CNT_NOT_ZERO_SHIFT                      4
+#define NIC0_QM0_CP_DBG_0_EB_CNT_NOT_ZERO_MASK                       0x10
+#define NIC0_QM0_CP_DBG_0_BULK_CNT_NOT_ZERO_SHIFT                    5
+#define NIC0_QM0_CP_DBG_0_BULK_CNT_NOT_ZERO_MASK                     0x20
+#define NIC0_QM0_CP_DBG_0_MREB_STALL_SHIFT                           6
+#define NIC0_QM0_CP_DBG_0_MREB_STALL_MASK                            0x40
+#define NIC0_QM0_CP_DBG_0_STALL_SHIFT                                7
+#define NIC0_QM0_CP_DBG_0_STALL_MASK                                 0x80
+
+/* NIC0_QM0_CP_ARUSER_31_11 */
+#define NIC0_QM0_CP_ARUSER_31_11_VAL_SHIFT                           0
+#define NIC0_QM0_CP_ARUSER_31_11_VAL_MASK                            0x1FFFFF
+
+/* NIC0_QM0_CP_AWUSER_31_11 */
+#define NIC0_QM0_CP_AWUSER_31_11_VAL_SHIFT                           0
+#define NIC0_QM0_CP_AWUSER_31_11_VAL_MASK                            0x1FFFFF
+
+/* NIC0_QM0_ARB_CFG_0 */
+#define NIC0_QM0_ARB_CFG_0_TYPE_SHIFT                                0
+#define NIC0_QM0_ARB_CFG_0_TYPE_MASK                                 0x1
+#define NIC0_QM0_ARB_CFG_0_IS_MASTER_SHIFT                           4
+#define NIC0_QM0_ARB_CFG_0_IS_MASTER_MASK                            0x10
+#define NIC0_QM0_ARB_CFG_0_EN_SHIFT                                  8
+#define NIC0_QM0_ARB_CFG_0_EN_MASK                                   0x100
+#define NIC0_QM0_ARB_CFG_0_MASK_SHIFT                                12
+#define NIC0_QM0_ARB_CFG_0_MASK_MASK                                 0xF000
+#define NIC0_QM0_ARB_CFG_0_MST_MSG_NOSTALL_SHIFT                     16
+#define NIC0_QM0_ARB_CFG_0_MST_MSG_NOSTALL_MASK                      0x10000
+
+/* NIC0_QM0_ARB_CHOISE_Q_PUSH */
+#define NIC0_QM0_ARB_CHOISE_Q_PUSH_VAL_SHIFT                         0
+#define NIC0_QM0_ARB_CHOISE_Q_PUSH_VAL_MASK                          0x3
+
+/* NIC0_QM0_ARB_WRR_WEIGHT */
+#define NIC0_QM0_ARB_WRR_WEIGHT_VAL_SHIFT                            0
+#define NIC0_QM0_ARB_WRR_WEIGHT_VAL_MASK                             0xFFFFFFFF
+
+/* NIC0_QM0_ARB_CFG_1 */
+#define NIC0_QM0_ARB_CFG_1_CLR_SHIFT                                 0
+#define NIC0_QM0_ARB_CFG_1_CLR_MASK                                  0x1
+
+/* NIC0_QM0_ARB_MST_AVAIL_CRED */
+#define NIC0_QM0_ARB_MST_AVAIL_CRED_VAL_SHIFT                        0
+#define NIC0_QM0_ARB_MST_AVAIL_CRED_VAL_MASK                         0x7F
+
+/* NIC0_QM0_ARB_MST_CRED_INC */
+#define NIC0_QM0_ARB_MST_CRED_INC_VAL_SHIFT                          0
+#define NIC0_QM0_ARB_MST_CRED_INC_VAL_MASK                           0xFFFFFFFF
+
+/* NIC0_QM0_ARB_MST_CHOISE_PUSH_OFST */
+#define NIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_VAL_SHIFT                  0
+#define NIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_VAL_MASK                   0xFFFFFFFF
+
+/* NIC0_QM0_ARB_SLV_MASTER_INC_CRED_OFST */
+#define NIC0_QM0_ARB_SLV_MASTER_INC_CRED_OFST_VAL_SHIFT              0
+#define NIC0_QM0_ARB_SLV_MASTER_INC_CRED_OFST_VAL_MASK               0xFFFFFFFF
+
+/* NIC0_QM0_ARB_MST_SLAVE_EN */
+#define NIC0_QM0_ARB_MST_SLAVE_EN_VAL_SHIFT                          0
+#define NIC0_QM0_ARB_MST_SLAVE_EN_VAL_MASK                           0xFFFFFFFF
+
+/* NIC0_QM0_ARB_MST_QUIET_PER */
+#define NIC0_QM0_ARB_MST_QUIET_PER_VAL_SHIFT                         0
+#define NIC0_QM0_ARB_MST_QUIET_PER_VAL_MASK                          0xFFFFFFFF
+
+/* NIC0_QM0_ARB_SLV_CHOISE_WDT */
+#define NIC0_QM0_ARB_SLV_CHOISE_WDT_VAL_SHIFT                        0
+#define NIC0_QM0_ARB_SLV_CHOISE_WDT_VAL_MASK                         0xFFFFFFFF
+
+/* NIC0_QM0_ARB_SLV_ID */
+#define NIC0_QM0_ARB_SLV_ID_VAL_SHIFT                                0
+#define NIC0_QM0_ARB_SLV_ID_VAL_MASK                                 0x1F
+
+/* NIC0_QM0_ARB_MSG_MAX_INFLIGHT */
+#define NIC0_QM0_ARB_MSG_MAX_INFLIGHT_VAL_SHIFT                      0
+#define NIC0_QM0_ARB_MSG_MAX_INFLIGHT_VAL_MASK                       0x3F
+
+/* NIC0_QM0_ARB_MSG_AWUSER_31_11 */
+#define NIC0_QM0_ARB_MSG_AWUSER_31_11_VAL_SHIFT                      0
+#define NIC0_QM0_ARB_MSG_AWUSER_31_11_VAL_MASK                       0x1FFFFF
+
+/* NIC0_QM0_ARB_MSG_AWUSER_SEC_PROP */
+#define NIC0_QM0_ARB_MSG_AWUSER_SEC_PROP_ASID_SHIFT                  0
+#define NIC0_QM0_ARB_MSG_AWUSER_SEC_PROP_ASID_MASK                   0x3FF
+#define NIC0_QM0_ARB_MSG_AWUSER_SEC_PROP_MMBP_SHIFT                  10
+#define NIC0_QM0_ARB_MSG_AWUSER_SEC_PROP_MMBP_MASK                   0x400
+
+/* NIC0_QM0_ARB_MSG_AWUSER_NON_SEC_PROP */
+#define NIC0_QM0_ARB_MSG_AWUSER_NON_SEC_PROP_ASID_SHIFT              0
+#define NIC0_QM0_ARB_MSG_AWUSER_NON_SEC_PROP_ASID_MASK               0x3FF
+#define NIC0_QM0_ARB_MSG_AWUSER_NON_SEC_PROP_MMBP_SHIFT              10
+#define NIC0_QM0_ARB_MSG_AWUSER_NON_SEC_PROP_MMBP_MASK               0x400
+
+/* NIC0_QM0_ARB_BASE_LO */
+#define NIC0_QM0_ARB_BASE_LO_VAL_SHIFT                               0
+#define NIC0_QM0_ARB_BASE_LO_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_ARB_BASE_HI */
+#define NIC0_QM0_ARB_BASE_HI_VAL_SHIFT                               0
+#define NIC0_QM0_ARB_BASE_HI_VAL_MASK                                0xFFFFFFFF
+
+/* NIC0_QM0_ARB_STATE_STS */
+#define NIC0_QM0_ARB_STATE_STS_VAL_SHIFT                             0
+#define NIC0_QM0_ARB_STATE_STS_VAL_MASK                              0xFFFFFFFF
+
+/* NIC0_QM0_ARB_CHOISE_FULLNESS_STS */
+#define NIC0_QM0_ARB_CHOISE_FULLNESS_STS_VAL_SHIFT                   0
+#define NIC0_QM0_ARB_CHOISE_FULLNESS_STS_VAL_MASK                    0x7F
+
+/* NIC0_QM0_ARB_MSG_STS */
+#define NIC0_QM0_ARB_MSG_STS_FULL_SHIFT                              0
+#define NIC0_QM0_ARB_MSG_STS_FULL_MASK                               0x1
+#define NIC0_QM0_ARB_MSG_STS_NO_INFLIGHT_SHIFT                       1
+#define NIC0_QM0_ARB_MSG_STS_NO_INFLIGHT_MASK                        0x2
+
+/* NIC0_QM0_ARB_SLV_CHOISE_Q_HEAD */
+#define NIC0_QM0_ARB_SLV_CHOISE_Q_HEAD_VAL_SHIFT                     0
+#define NIC0_QM0_ARB_SLV_CHOISE_Q_HEAD_VAL_MASK                      0x3
+
+/* NIC0_QM0_ARB_ERR_CAUSE */
+#define NIC0_QM0_ARB_ERR_CAUSE_CHOISE_OVF_SHIFT                      0
+#define NIC0_QM0_ARB_ERR_CAUSE_CHOISE_OVF_MASK                       0x1
+#define NIC0_QM0_ARB_ERR_CAUSE_CHOISE_WDT_SHIFT                      1
+#define NIC0_QM0_ARB_ERR_CAUSE_CHOISE_WDT_MASK                       0x2
+#define NIC0_QM0_ARB_ERR_CAUSE_AXI_LBW_ERR_SHIFT                     2
+#define NIC0_QM0_ARB_ERR_CAUSE_AXI_LBW_ERR_MASK                      0x4
+
+/* NIC0_QM0_ARB_ERR_MSG_EN */
+#define NIC0_QM0_ARB_ERR_MSG_EN_CHOISE_OVF_SHIFT                     0
+#define NIC0_QM0_ARB_ERR_MSG_EN_CHOISE_OVF_MASK                      0x1
+#define NIC0_QM0_ARB_ERR_MSG_EN_CHOISE_WDT_SHIFT                     1
+#define NIC0_QM0_ARB_ERR_MSG_EN_CHOISE_WDT_MASK                      0x2
+#define NIC0_QM0_ARB_ERR_MSG_EN_AXI_LBW_ERR_SHIFT                    2
+#define NIC0_QM0_ARB_ERR_MSG_EN_AXI_LBW_ERR_MASK                     0x4
+
+/* NIC0_QM0_ARB_ERR_STS_DRP */
+#define NIC0_QM0_ARB_ERR_STS_DRP_VAL_SHIFT                           0
+#define NIC0_QM0_ARB_ERR_STS_DRP_VAL_MASK                            0x3
+
+/* NIC0_QM0_ARB_MST_CRED_STS */
+#define NIC0_QM0_ARB_MST_CRED_STS_VAL_SHIFT                          0
+#define NIC0_QM0_ARB_MST_CRED_STS_VAL_MASK                           0x7F
+
+/* NIC0_QM0_CGM_CFG */
+#define NIC0_QM0_CGM_CFG_IDLE_TH_SHIFT                               0
+#define NIC0_QM0_CGM_CFG_IDLE_TH_MASK                                0xFFF
+#define NIC0_QM0_CGM_CFG_G2F_TH_SHIFT                                16
+#define NIC0_QM0_CGM_CFG_G2F_TH_MASK                                 0xFF0000
+#define NIC0_QM0_CGM_CFG_CP_IDLE_MASK_SHIFT                          24
+#define NIC0_QM0_CGM_CFG_CP_IDLE_MASK_MASK                           0x1F000000
+#define NIC0_QM0_CGM_CFG_EN_SHIFT                                    31
+#define NIC0_QM0_CGM_CFG_EN_MASK                                     0x80000000
+
+/* NIC0_QM0_CGM_STS */
+#define NIC0_QM0_CGM_STS_ST_SHIFT                                    0
+#define NIC0_QM0_CGM_STS_ST_MASK                                     0x3
+#define NIC0_QM0_CGM_STS_CG_SHIFT                                    4
+#define NIC0_QM0_CGM_STS_CG_MASK                                     0x10
+#define NIC0_QM0_CGM_STS_AGENT_IDLE_SHIFT                            8
+#define NIC0_QM0_CGM_STS_AGENT_IDLE_MASK                             0x100
+#define NIC0_QM0_CGM_STS_AXI_IDLE_SHIFT                              9
+#define NIC0_QM0_CGM_STS_AXI_IDLE_MASK                               0x200
+#define NIC0_QM0_CGM_STS_CP_IDLE_SHIFT                               10
+#define NIC0_QM0_CGM_STS_CP_IDLE_MASK                                0x400
+
+/* NIC0_QM0_CGM_CFG1 */
+#define NIC0_QM0_CGM_CFG1_MASK_TH_SHIFT                              0
+#define NIC0_QM0_CGM_CFG1_MASK_TH_MASK                               0xFF
+
+/* NIC0_QM0_LOCAL_RANGE_BASE */
+#define NIC0_QM0_LOCAL_RANGE_BASE_VAL_SHIFT                          0
+#define NIC0_QM0_LOCAL_RANGE_BASE_VAL_MASK                           0xFFFF
+
+/* NIC0_QM0_LOCAL_RANGE_SIZE */
+#define NIC0_QM0_LOCAL_RANGE_SIZE_VAL_SHIFT                          0
+#define NIC0_QM0_LOCAL_RANGE_SIZE_VAL_MASK                           0xFFFF
+
+/* NIC0_QM0_CSMR_STRICT_PRIO_CFG */
+#define NIC0_QM0_CSMR_STRICT_PRIO_CFG_TYPE_SHIFT                     0
+#define NIC0_QM0_CSMR_STRICT_PRIO_CFG_TYPE_MASK                      0x1
+
+/* NIC0_QM0_HBW_RD_RATE_LIM_CFG_1 */
+#define NIC0_QM0_HBW_RD_RATE_LIM_CFG_1_TOUT_SHIFT                    0
+#define NIC0_QM0_HBW_RD_RATE_LIM_CFG_1_TOUT_MASK                     0xFF
+#define NIC0_QM0_HBW_RD_RATE_LIM_CFG_1_EN_SHIFT                      31
+#define NIC0_QM0_HBW_RD_RATE_LIM_CFG_1_EN_MASK                       0x80000000
+
+/* NIC0_QM0_LBW_WR_RATE_LIM_CFG_0 */
+#define NIC0_QM0_LBW_WR_RATE_LIM_CFG_0_RST_TOKEN_SHIFT               0
+#define NIC0_QM0_LBW_WR_RATE_LIM_CFG_0_RST_TOKEN_MASK                0xFF
+#define NIC0_QM0_LBW_WR_RATE_LIM_CFG_0_SAT_SHIFT                     16
+#define NIC0_QM0_LBW_WR_RATE_LIM_CFG_0_SAT_MASK                      0xFF0000
+
+/* NIC0_QM0_LBW_WR_RATE_LIM_CFG_1 */
+#define NIC0_QM0_LBW_WR_RATE_LIM_CFG_1_TOUT_SHIFT                    0
+#define NIC0_QM0_LBW_WR_RATE_LIM_CFG_1_TOUT_MASK                     0xFF
+#define NIC0_QM0_LBW_WR_RATE_LIM_CFG_1_EN_SHIFT                      31
+#define NIC0_QM0_LBW_WR_RATE_LIM_CFG_1_EN_MASK                       0x80000000
+
+/* NIC0_QM0_HBW_RD_RATE_LIM_CFG_0 */
+#define NIC0_QM0_HBW_RD_RATE_LIM_CFG_0_RST_TOKEN_SHIFT               0
+#define NIC0_QM0_HBW_RD_RATE_LIM_CFG_0_RST_TOKEN_MASK                0xFF
+#define NIC0_QM0_HBW_RD_RATE_LIM_CFG_0_SAT_SHIFT                     16
+#define NIC0_QM0_HBW_RD_RATE_LIM_CFG_0_SAT_MASK                      0xFF0000
+
+/* NIC0_QM0_GLBL_AXCACHE */
+#define NIC0_QM0_GLBL_AXCACHE_AR_SHIFT                               0
+#define NIC0_QM0_GLBL_AXCACHE_AR_MASK                                0xF
+#define NIC0_QM0_GLBL_AXCACHE_AW_SHIFT                               16
+#define NIC0_QM0_GLBL_AXCACHE_AW_MASK                                0xF0000
+
+/* NIC0_QM0_IND_GW_APB_CFG */
+#define NIC0_QM0_IND_GW_APB_CFG_ADDR_SHIFT                           0
+#define NIC0_QM0_IND_GW_APB_CFG_ADDR_MASK                            0x7FFFFFFF
+#define NIC0_QM0_IND_GW_APB_CFG_CMD_SHIFT                            31
+#define NIC0_QM0_IND_GW_APB_CFG_CMD_MASK                             0x80000000
+
+/* NIC0_QM0_IND_GW_APB_WDATA */
+#define NIC0_QM0_IND_GW_APB_WDATA_VAL_SHIFT                          0
+#define NIC0_QM0_IND_GW_APB_WDATA_VAL_MASK                           0xFFFFFFFF
+
+/* NIC0_QM0_IND_GW_APB_RDATA */
+#define NIC0_QM0_IND_GW_APB_RDATA_VAL_SHIFT                          0
+#define NIC0_QM0_IND_GW_APB_RDATA_VAL_MASK                           0xFFFFFFFF
+
+/* NIC0_QM0_IND_GW_APB_STATUS */
+#define NIC0_QM0_IND_GW_APB_STATUS_RDY_SHIFT                         0
+#define NIC0_QM0_IND_GW_APB_STATUS_RDY_MASK                          0x1
+#define NIC0_QM0_IND_GW_APB_STATUS_ERR_SHIFT                         1
+#define NIC0_QM0_IND_GW_APB_STATUS_ERR_MASK                          0x2
+
+/* NIC0_QM0_GLBL_ERR_ADDR_LO */
+#define NIC0_QM0_GLBL_ERR_ADDR_LO_VAL_SHIFT                          0
+#define NIC0_QM0_GLBL_ERR_ADDR_LO_VAL_MASK                           0xFFFFFFFF
+
+/* NIC0_QM0_GLBL_ERR_ADDR_HI */
+#define NIC0_QM0_GLBL_ERR_ADDR_HI_VAL_SHIFT                          0
+#define NIC0_QM0_GLBL_ERR_ADDR_HI_VAL_MASK                           0xFFFFFFFF
+
+/* NIC0_QM0_GLBL_ERR_WDATA */
+#define NIC0_QM0_GLBL_ERR_WDATA_VAL_SHIFT                            0
+#define NIC0_QM0_GLBL_ERR_WDATA_VAL_MASK                             0xFFFFFFFF
+
+/* NIC0_QM0_GLBL_MEM_INIT_BUSY */
+#define NIC0_QM0_GLBL_MEM_INIT_BUSY_RBUF_SHIFT                       0
+#define NIC0_QM0_GLBL_MEM_INIT_BUSY_RBUF_MASK                        0xF
+
+#endif /* ASIC_REG_NIC0_QM0_MASKS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_regs.h
new file mode 100644
index 000000000000..7c97f4041b8e
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC0_QM0_REGS_H_
+#define ASIC_REG_NIC0_QM0_REGS_H_
+
+/*
+ *****************************************
+ *   NIC0_QM0 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC0_QM0_GLBL_CFG0                                         0xCE0000
+
+#define mmNIC0_QM0_GLBL_CFG1                                         0xCE0004
+
+#define mmNIC0_QM0_GLBL_PROT                                         0xCE0008
+
+#define mmNIC0_QM0_GLBL_ERR_CFG                                      0xCE000C
+
+#define mmNIC0_QM0_GLBL_SECURE_PROPS_0                               0xCE0010
+
+#define mmNIC0_QM0_GLBL_SECURE_PROPS_1                               0xCE0014
+
+#define mmNIC0_QM0_GLBL_SECURE_PROPS_2                               0xCE0018
+
+#define mmNIC0_QM0_GLBL_SECURE_PROPS_3                               0xCE001C
+
+#define mmNIC0_QM0_GLBL_SECURE_PROPS_4                               0xCE0020
+
+#define mmNIC0_QM0_GLBL_NON_SECURE_PROPS_0                           0xCE0024
+
+#define mmNIC0_QM0_GLBL_NON_SECURE_PROPS_1                           0xCE0028
+
+#define mmNIC0_QM0_GLBL_NON_SECURE_PROPS_2                           0xCE002C
+
+#define mmNIC0_QM0_GLBL_NON_SECURE_PROPS_3                           0xCE0030
+
+#define mmNIC0_QM0_GLBL_NON_SECURE_PROPS_4                           0xCE0034
+
+#define mmNIC0_QM0_GLBL_STS0                                         0xCE0038
+
+#define mmNIC0_QM0_GLBL_STS1_0                                       0xCE0040
+
+#define mmNIC0_QM0_GLBL_STS1_1                                       0xCE0044
+
+#define mmNIC0_QM0_GLBL_STS1_2                                       0xCE0048
+
+#define mmNIC0_QM0_GLBL_STS1_3                                       0xCE004C
+
+#define mmNIC0_QM0_GLBL_STS1_4                                       0xCE0050
+
+#define mmNIC0_QM0_GLBL_MSG_EN_0                                     0xCE0054
+
+#define mmNIC0_QM0_GLBL_MSG_EN_1                                     0xCE0058
+
+#define mmNIC0_QM0_GLBL_MSG_EN_2                                     0xCE005C
+
+#define mmNIC0_QM0_GLBL_MSG_EN_3                                     0xCE0060
+
+#define mmNIC0_QM0_GLBL_MSG_EN_4                                     0xCE0068
+
+#define mmNIC0_QM0_PQ_BASE_LO_0                                      0xCE0070
+
+#define mmNIC0_QM0_PQ_BASE_LO_1                                      0xCE0074
+
+#define mmNIC0_QM0_PQ_BASE_LO_2                                      0xCE0078
+
+#define mmNIC0_QM0_PQ_BASE_LO_3                                      0xCE007C
+
+#define mmNIC0_QM0_PQ_BASE_HI_0                                      0xCE0080
+
+#define mmNIC0_QM0_PQ_BASE_HI_1                                      0xCE0084
+
+#define mmNIC0_QM0_PQ_BASE_HI_2                                      0xCE0088
+
+#define mmNIC0_QM0_PQ_BASE_HI_3                                      0xCE008C
+
+#define mmNIC0_QM0_PQ_SIZE_0                                         0xCE0090
+
+#define mmNIC0_QM0_PQ_SIZE_1                                         0xCE0094
+
+#define mmNIC0_QM0_PQ_SIZE_2                                         0xCE0098
+
+#define mmNIC0_QM0_PQ_SIZE_3                                         0xCE009C
+
+#define mmNIC0_QM0_PQ_PI_0                                           0xCE00A0
+
+#define mmNIC0_QM0_PQ_PI_1                                           0xCE00A4
+
+#define mmNIC0_QM0_PQ_PI_2                                           0xCE00A8
+
+#define mmNIC0_QM0_PQ_PI_3                                           0xCE00AC
+
+#define mmNIC0_QM0_PQ_CI_0                                           0xCE00B0
+
+#define mmNIC0_QM0_PQ_CI_1                                           0xCE00B4
+
+#define mmNIC0_QM0_PQ_CI_2                                           0xCE00B8
+
+#define mmNIC0_QM0_PQ_CI_3                                           0xCE00BC
+
+#define mmNIC0_QM0_PQ_CFG0_0                                         0xCE00C0
+
+#define mmNIC0_QM0_PQ_CFG0_1                                         0xCE00C4
+
+#define mmNIC0_QM0_PQ_CFG0_2                                         0xCE00C8
+
+#define mmNIC0_QM0_PQ_CFG0_3                                         0xCE00CC
+
+#define mmNIC0_QM0_PQ_CFG1_0                                         0xCE00D0
+
+#define mmNIC0_QM0_PQ_CFG1_1                                         0xCE00D4
+
+#define mmNIC0_QM0_PQ_CFG1_2                                         0xCE00D8
+
+#define mmNIC0_QM0_PQ_CFG1_3                                         0xCE00DC
+
+#define mmNIC0_QM0_PQ_ARUSER_31_11_0                                 0xCE00E0
+
+#define mmNIC0_QM0_PQ_ARUSER_31_11_1                                 0xCE00E4
+
+#define mmNIC0_QM0_PQ_ARUSER_31_11_2                                 0xCE00E8
+
+#define mmNIC0_QM0_PQ_ARUSER_31_11_3                                 0xCE00EC
+
+#define mmNIC0_QM0_PQ_STS0_0                                         0xCE00F0
+
+#define mmNIC0_QM0_PQ_STS0_1                                         0xCE00F4
+
+#define mmNIC0_QM0_PQ_STS0_2                                         0xCE00F8
+
+#define mmNIC0_QM0_PQ_STS0_3                                         0xCE00FC
+
+#define mmNIC0_QM0_PQ_STS1_0                                         0xCE0100
+
+#define mmNIC0_QM0_PQ_STS1_1                                         0xCE0104
+
+#define mmNIC0_QM0_PQ_STS1_2                                         0xCE0108
+
+#define mmNIC0_QM0_PQ_STS1_3                                         0xCE010C
+
+#define mmNIC0_QM0_CQ_CFG0_0                                         0xCE0110
+
+#define mmNIC0_QM0_CQ_CFG0_1                                         0xCE0114
+
+#define mmNIC0_QM0_CQ_CFG0_2                                         0xCE0118
+
+#define mmNIC0_QM0_CQ_CFG0_3                                         0xCE011C
+
+#define mmNIC0_QM0_CQ_CFG0_4                                         0xCE0120
+
+#define mmNIC0_QM0_CQ_CFG1_0                                         0xCE0124
+
+#define mmNIC0_QM0_CQ_CFG1_1                                         0xCE0128
+
+#define mmNIC0_QM0_CQ_CFG1_2                                         0xCE012C
+
+#define mmNIC0_QM0_CQ_CFG1_3                                         0xCE0130
+
+#define mmNIC0_QM0_CQ_CFG1_4                                         0xCE0134
+
+#define mmNIC0_QM0_CQ_ARUSER_31_11_0                                 0xCE0138
+
+#define mmNIC0_QM0_CQ_ARUSER_31_11_1                                 0xCE013C
+
+#define mmNIC0_QM0_CQ_ARUSER_31_11_2                                 0xCE0140
+
+#define mmNIC0_QM0_CQ_ARUSER_31_11_3                                 0xCE0144
+
+#define mmNIC0_QM0_CQ_ARUSER_31_11_4                                 0xCE0148
+
+#define mmNIC0_QM0_CQ_STS0_0                                         0xCE014C
+
+#define mmNIC0_QM0_CQ_STS0_1                                         0xCE0150
+
+#define mmNIC0_QM0_CQ_STS0_2                                         0xCE0154
+
+#define mmNIC0_QM0_CQ_STS0_3                                         0xCE0158
+
+#define mmNIC0_QM0_CQ_STS0_4                                         0xCE015C
+
+#define mmNIC0_QM0_CQ_STS1_0                                         0xCE0160
+
+#define mmNIC0_QM0_CQ_STS1_1                                         0xCE0164
+
+#define mmNIC0_QM0_CQ_STS1_2                                         0xCE0168
+
+#define mmNIC0_QM0_CQ_STS1_3                                         0xCE016C
+
+#define mmNIC0_QM0_CQ_STS1_4                                         0xCE0170
+
+#define mmNIC0_QM0_CQ_PTR_LO_0                                       0xCE0174
+
+#define mmNIC0_QM0_CQ_PTR_HI_0                                       0xCE0178
+
+#define mmNIC0_QM0_CQ_TSIZE_0                                        0xCE017C
+
+#define mmNIC0_QM0_CQ_CTL_0                                          0xCE0180
+
+#define mmNIC0_QM0_CQ_PTR_LO_1                                       0xCE0184
+
+#define mmNIC0_QM0_CQ_PTR_HI_1                                       0xCE0188
+
+#define mmNIC0_QM0_CQ_TSIZE_1                                        0xCE018C
+
+#define mmNIC0_QM0_CQ_CTL_1                                          0xCE0190
+
+#define mmNIC0_QM0_CQ_PTR_LO_2                                       0xCE0194
+
+#define mmNIC0_QM0_CQ_PTR_HI_2                                       0xCE0198
+
+#define mmNIC0_QM0_CQ_TSIZE_2                                        0xCE019C
+
+#define mmNIC0_QM0_CQ_CTL_2                                          0xCE01A0
+
+#define mmNIC0_QM0_CQ_PTR_LO_3                                       0xCE01A4
+
+#define mmNIC0_QM0_CQ_PTR_HI_3                                       0xCE01A8
+
+#define mmNIC0_QM0_CQ_TSIZE_3                                        0xCE01AC
+
+#define mmNIC0_QM0_CQ_CTL_3                                          0xCE01B0
+
+#define mmNIC0_QM0_CQ_PTR_LO_4                                       0xCE01B4
+
+#define mmNIC0_QM0_CQ_PTR_HI_4                                       0xCE01B8
+
+#define mmNIC0_QM0_CQ_TSIZE_4                                        0xCE01BC
+
+#define mmNIC0_QM0_CQ_CTL_4                                          0xCE01C0
+
+#define mmNIC0_QM0_CQ_PTR_LO_STS_0                                   0xCE01C4
+
+#define mmNIC0_QM0_CQ_PTR_LO_STS_1                                   0xCE01C8
+
+#define mmNIC0_QM0_CQ_PTR_LO_STS_2                                   0xCE01CC
+
+#define mmNIC0_QM0_CQ_PTR_LO_STS_3                                   0xCE01D0
+
+#define mmNIC0_QM0_CQ_PTR_LO_STS_4                                   0xCE01D4
+
+#define mmNIC0_QM0_CQ_PTR_HI_STS_0                                   0xCE01D8
+
+#define mmNIC0_QM0_CQ_PTR_HI_STS_1                                   0xCE01DC
+
+#define mmNIC0_QM0_CQ_PTR_HI_STS_2                                   0xCE01E0
+
+#define mmNIC0_QM0_CQ_PTR_HI_STS_3                                   0xCE01E4
+
+#define mmNIC0_QM0_CQ_PTR_HI_STS_4                                   0xCE01E8
+
+#define mmNIC0_QM0_CQ_TSIZE_STS_0                                    0xCE01EC
+
+#define mmNIC0_QM0_CQ_TSIZE_STS_1                                    0xCE01F0
+
+#define mmNIC0_QM0_CQ_TSIZE_STS_2                                    0xCE01F4
+
+#define mmNIC0_QM0_CQ_TSIZE_STS_3                                    0xCE01F8
+
+#define mmNIC0_QM0_CQ_TSIZE_STS_4                                    0xCE01FC
+
+#define mmNIC0_QM0_CQ_CTL_STS_0                                      0xCE0200
+
+#define mmNIC0_QM0_CQ_CTL_STS_1                                      0xCE0204
+
+#define mmNIC0_QM0_CQ_CTL_STS_2                                      0xCE0208
+
+#define mmNIC0_QM0_CQ_CTL_STS_3                                      0xCE020C
+
+#define mmNIC0_QM0_CQ_CTL_STS_4                                      0xCE0210
+
+#define mmNIC0_QM0_CQ_IFIFO_CNT_0                                    0xCE0214
+
+#define mmNIC0_QM0_CQ_IFIFO_CNT_1                                    0xCE0218
+
+#define mmNIC0_QM0_CQ_IFIFO_CNT_2                                    0xCE021C
+
+#define mmNIC0_QM0_CQ_IFIFO_CNT_3                                    0xCE0220
+
+#define mmNIC0_QM0_CQ_IFIFO_CNT_4                                    0xCE0224
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_LO_0                            0xCE0228
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_LO_1                            0xCE022C
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_LO_2                            0xCE0230
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_LO_3                            0xCE0234
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_LO_4                            0xCE0238
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_HI_0                            0xCE023C
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_HI_1                            0xCE0240
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_HI_2                            0xCE0244
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_HI_3                            0xCE0248
+
+#define mmNIC0_QM0_CP_MSG_BASE0_ADDR_HI_4                            0xCE024C
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_LO_0                            0xCE0250
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_LO_1                            0xCE0254
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_LO_2                            0xCE0258
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_LO_3                            0xCE025C
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_LO_4                            0xCE0260
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_HI_0                            0xCE0264
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_HI_1                            0xCE0268
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_HI_2                            0xCE026C
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_HI_3                            0xCE0270
+
+#define mmNIC0_QM0_CP_MSG_BASE1_ADDR_HI_4                            0xCE0274
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_LO_0                            0xCE0278
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_LO_1                            0xCE027C
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_LO_2                            0xCE0280
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_LO_3                            0xCE0284
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_LO_4                            0xCE0288
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_HI_0                            0xCE028C
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_HI_1                            0xCE0290
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_HI_2                            0xCE0294
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_HI_3                            0xCE0298
+
+#define mmNIC0_QM0_CP_MSG_BASE2_ADDR_HI_4                            0xCE029C
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_LO_0                            0xCE02A0
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_LO_1                            0xCE02A4
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_LO_2                            0xCE02A8
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_LO_3                            0xCE02AC
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_LO_4                            0xCE02B0
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_HI_0                            0xCE02B4
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_HI_1                            0xCE02B8
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_HI_2                            0xCE02BC
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_HI_3                            0xCE02C0
+
+#define mmNIC0_QM0_CP_MSG_BASE3_ADDR_HI_4                            0xCE02C4
+
+#define mmNIC0_QM0_CP_LDMA_TSIZE_OFFSET_0                            0xCE02C8
+
+#define mmNIC0_QM0_CP_LDMA_TSIZE_OFFSET_1                            0xCE02CC
+
+#define mmNIC0_QM0_CP_LDMA_TSIZE_OFFSET_2                            0xCE02D0
+
+#define mmNIC0_QM0_CP_LDMA_TSIZE_OFFSET_3                            0xCE02D4
+
+#define mmNIC0_QM0_CP_LDMA_TSIZE_OFFSET_4                            0xCE02D8
+
+#define mmNIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xCE02E0
+
+#define mmNIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xCE02E4
+
+#define mmNIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xCE02E8
+
+#define mmNIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xCE02EC
+
+#define mmNIC0_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xCE02F0
+
+#define mmNIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xCE02F4
+
+#define mmNIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xCE02F8
+
+#define mmNIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xCE02FC
+
+#define mmNIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xCE0300
+
+#define mmNIC0_QM0_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xCE0304
+
+#define mmNIC0_QM0_CP_FENCE0_RDATA_0                                 0xCE0308
+
+#define mmNIC0_QM0_CP_FENCE0_RDATA_1                                 0xCE030C
+
+#define mmNIC0_QM0_CP_FENCE0_RDATA_2                                 0xCE0310
+
+#define mmNIC0_QM0_CP_FENCE0_RDATA_3                                 0xCE0314
+
+#define mmNIC0_QM0_CP_FENCE0_RDATA_4                                 0xCE0318
+
+#define mmNIC0_QM0_CP_FENCE1_RDATA_0                                 0xCE031C
+
+#define mmNIC0_QM0_CP_FENCE1_RDATA_1                                 0xCE0320
+
+#define mmNIC0_QM0_CP_FENCE1_RDATA_2                                 0xCE0324
+
+#define mmNIC0_QM0_CP_FENCE1_RDATA_3                                 0xCE0328
+
+#define mmNIC0_QM0_CP_FENCE1_RDATA_4                                 0xCE032C
+
+#define mmNIC0_QM0_CP_FENCE2_RDATA_0                                 0xCE0330
+
+#define mmNIC0_QM0_CP_FENCE2_RDATA_1                                 0xCE0334
+
+#define mmNIC0_QM0_CP_FENCE2_RDATA_2                                 0xCE0338
+
+#define mmNIC0_QM0_CP_FENCE2_RDATA_3                                 0xCE033C
+
+#define mmNIC0_QM0_CP_FENCE2_RDATA_4                                 0xCE0340
+
+#define mmNIC0_QM0_CP_FENCE3_RDATA_0                                 0xCE0344
+
+#define mmNIC0_QM0_CP_FENCE3_RDATA_1                                 0xCE0348
+
+#define mmNIC0_QM0_CP_FENCE3_RDATA_2                                 0xCE034C
+
+#define mmNIC0_QM0_CP_FENCE3_RDATA_3                                 0xCE0350
+
+#define mmNIC0_QM0_CP_FENCE3_RDATA_4                                 0xCE0354
+
+#define mmNIC0_QM0_CP_FENCE0_CNT_0                                   0xCE0358
+
+#define mmNIC0_QM0_CP_FENCE0_CNT_1                                   0xCE035C
+
+#define mmNIC0_QM0_CP_FENCE0_CNT_2                                   0xCE0360
+
+#define mmNIC0_QM0_CP_FENCE0_CNT_3                                   0xCE0364
+
+#define mmNIC0_QM0_CP_FENCE0_CNT_4                                   0xCE0368
+
+#define mmNIC0_QM0_CP_FENCE1_CNT_0                                   0xCE036C
+
+#define mmNIC0_QM0_CP_FENCE1_CNT_1                                   0xCE0370
+
+#define mmNIC0_QM0_CP_FENCE1_CNT_2                                   0xCE0374
+
+#define mmNIC0_QM0_CP_FENCE1_CNT_3                                   0xCE0378
+
+#define mmNIC0_QM0_CP_FENCE1_CNT_4                                   0xCE037C
+
+#define mmNIC0_QM0_CP_FENCE2_CNT_0                                   0xCE0380
+
+#define mmNIC0_QM0_CP_FENCE2_CNT_1                                   0xCE0384
+
+#define mmNIC0_QM0_CP_FENCE2_CNT_2                                   0xCE0388
+
+#define mmNIC0_QM0_CP_FENCE2_CNT_3                                   0xCE038C
+
+#define mmNIC0_QM0_CP_FENCE2_CNT_4                                   0xCE0390
+
+#define mmNIC0_QM0_CP_FENCE3_CNT_0                                   0xCE0394
+
+#define mmNIC0_QM0_CP_FENCE3_CNT_1                                   0xCE0398
+
+#define mmNIC0_QM0_CP_FENCE3_CNT_2                                   0xCE039C
+
+#define mmNIC0_QM0_CP_FENCE3_CNT_3                                   0xCE03A0
+
+#define mmNIC0_QM0_CP_FENCE3_CNT_4                                   0xCE03A4
+
+#define mmNIC0_QM0_CP_STS_0                                          0xCE03A8
+
+#define mmNIC0_QM0_CP_STS_1                                          0xCE03AC
+
+#define mmNIC0_QM0_CP_STS_2                                          0xCE03B0
+
+#define mmNIC0_QM0_CP_STS_3                                          0xCE03B4
+
+#define mmNIC0_QM0_CP_STS_4                                          0xCE03B8
+
+#define mmNIC0_QM0_CP_CURRENT_INST_LO_0                              0xCE03BC
+
+#define mmNIC0_QM0_CP_CURRENT_INST_LO_1                              0xCE03C0
+
+#define mmNIC0_QM0_CP_CURRENT_INST_LO_2                              0xCE03C4
+
+#define mmNIC0_QM0_CP_CURRENT_INST_LO_3                              0xCE03C8
+
+#define mmNIC0_QM0_CP_CURRENT_INST_LO_4                              0xCE03CC
+
+#define mmNIC0_QM0_CP_CURRENT_INST_HI_0                              0xCE03D0
+
+#define mmNIC0_QM0_CP_CURRENT_INST_HI_1                              0xCE03D4
+
+#define mmNIC0_QM0_CP_CURRENT_INST_HI_2                              0xCE03D8
+
+#define mmNIC0_QM0_CP_CURRENT_INST_HI_3                              0xCE03DC
+
+#define mmNIC0_QM0_CP_CURRENT_INST_HI_4                              0xCE03E0
+
+#define mmNIC0_QM0_CP_BARRIER_CFG_0                                  0xCE03F4
+
+#define mmNIC0_QM0_CP_BARRIER_CFG_1                                  0xCE03F8
+
+#define mmNIC0_QM0_CP_BARRIER_CFG_2                                  0xCE03FC
+
+#define mmNIC0_QM0_CP_BARRIER_CFG_3                                  0xCE0400
+
+#define mmNIC0_QM0_CP_BARRIER_CFG_4                                  0xCE0404
+
+#define mmNIC0_QM0_CP_DBG_0_0                                        0xCE0408
+
+#define mmNIC0_QM0_CP_DBG_0_1                                        0xCE040C
+
+#define mmNIC0_QM0_CP_DBG_0_2                                        0xCE0410
+
+#define mmNIC0_QM0_CP_DBG_0_3                                        0xCE0414
+
+#define mmNIC0_QM0_CP_DBG_0_4                                        0xCE0418
+
+#define mmNIC0_QM0_CP_ARUSER_31_11_0                                 0xCE041C
+
+#define mmNIC0_QM0_CP_ARUSER_31_11_1                                 0xCE0420
+
+#define mmNIC0_QM0_CP_ARUSER_31_11_2                                 0xCE0424
+
+#define mmNIC0_QM0_CP_ARUSER_31_11_3                                 0xCE0428
+
+#define mmNIC0_QM0_CP_ARUSER_31_11_4                                 0xCE042C
+
+#define mmNIC0_QM0_CP_AWUSER_31_11_0                                 0xCE0430
+
+#define mmNIC0_QM0_CP_AWUSER_31_11_1                                 0xCE0434
+
+#define mmNIC0_QM0_CP_AWUSER_31_11_2                                 0xCE0438
+
+#define mmNIC0_QM0_CP_AWUSER_31_11_3                                 0xCE043C
+
+#define mmNIC0_QM0_CP_AWUSER_31_11_4                                 0xCE0440
+
+#define mmNIC0_QM0_ARB_CFG_0                                         0xCE0A00
+
+#define mmNIC0_QM0_ARB_CHOISE_Q_PUSH                                 0xCE0A04
+
+#define mmNIC0_QM0_ARB_WRR_WEIGHT_0                                  0xCE0A08
+
+#define mmNIC0_QM0_ARB_WRR_WEIGHT_1                                  0xCE0A0C
+
+#define mmNIC0_QM0_ARB_WRR_WEIGHT_2                                  0xCE0A10
+
+#define mmNIC0_QM0_ARB_WRR_WEIGHT_3                                  0xCE0A14
+
+#define mmNIC0_QM0_ARB_CFG_1                                         0xCE0A18
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_0                              0xCE0A20
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_1                              0xCE0A24
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_2                              0xCE0A28
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_3                              0xCE0A2C
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_4                              0xCE0A30
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_5                              0xCE0A34
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_6                              0xCE0A38
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_7                              0xCE0A3C
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_8                              0xCE0A40
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_9                              0xCE0A44
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_10                             0xCE0A48
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_11                             0xCE0A4C
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_12                             0xCE0A50
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_13                             0xCE0A54
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_14                             0xCE0A58
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_15                             0xCE0A5C
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_16                             0xCE0A60
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_17                             0xCE0A64
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_18                             0xCE0A68
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_19                             0xCE0A6C
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_20                             0xCE0A70
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_21                             0xCE0A74
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_22                             0xCE0A78
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_23                             0xCE0A7C
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_24                             0xCE0A80
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_25                             0xCE0A84
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_26                             0xCE0A88
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_27                             0xCE0A8C
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_28                             0xCE0A90
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_29                             0xCE0A94
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_30                             0xCE0A98
+
+#define mmNIC0_QM0_ARB_MST_AVAIL_CRED_31                             0xCE0A9C
+
+#define mmNIC0_QM0_ARB_MST_CRED_INC                                  0xCE0AA0
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_0                        0xCE0AA4
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_1                        0xCE0AA8
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_2                        0xCE0AAC
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_3                        0xCE0AB0
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_4                        0xCE0AB4
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_5                        0xCE0AB8
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_6                        0xCE0ABC
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_7                        0xCE0AC0
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_8                        0xCE0AC4
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_9                        0xCE0AC8
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_10                       0xCE0ACC
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_11                       0xCE0AD0
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_12                       0xCE0AD4
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_13                       0xCE0AD8
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_14                       0xCE0ADC
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_15                       0xCE0AE0
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_16                       0xCE0AE4
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_17                       0xCE0AE8
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_18                       0xCE0AEC
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_19                       0xCE0AF0
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_20                       0xCE0AF4
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_21                       0xCE0AF8
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_22                       0xCE0AFC
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_23                       0xCE0B00
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_24                       0xCE0B04
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_25                       0xCE0B08
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_26                       0xCE0B0C
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_27                       0xCE0B10
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_28                       0xCE0B14
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_29                       0xCE0B18
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_30                       0xCE0B1C
+
+#define mmNIC0_QM0_ARB_MST_CHOISE_PUSH_OFST_31                       0xCE0B20
+
+#define mmNIC0_QM0_ARB_SLV_MASTER_INC_CRED_OFST                      0xCE0B28
+
+#define mmNIC0_QM0_ARB_MST_SLAVE_EN                                  0xCE0B2C
+
+#define mmNIC0_QM0_ARB_MST_QUIET_PER                                 0xCE0B34
+
+#define mmNIC0_QM0_ARB_SLV_CHOISE_WDT                                0xCE0B38
+
+#define mmNIC0_QM0_ARB_SLV_ID                                        0xCE0B3C
+
+#define mmNIC0_QM0_ARB_MSG_MAX_INFLIGHT                              0xCE0B44
+
+#define mmNIC0_QM0_ARB_MSG_AWUSER_31_11                              0xCE0B48
+
+#define mmNIC0_QM0_ARB_MSG_AWUSER_SEC_PROP                           0xCE0B4C
+
+#define mmNIC0_QM0_ARB_MSG_AWUSER_NON_SEC_PROP                       0xCE0B50
+
+#define mmNIC0_QM0_ARB_BASE_LO                                       0xCE0B54
+
+#define mmNIC0_QM0_ARB_BASE_HI                                       0xCE0B58
+
+#define mmNIC0_QM0_ARB_STATE_STS                                     0xCE0B80
+
+#define mmNIC0_QM0_ARB_CHOISE_FULLNESS_STS                           0xCE0B84
+
+#define mmNIC0_QM0_ARB_MSG_STS                                       0xCE0B88
+
+#define mmNIC0_QM0_ARB_SLV_CHOISE_Q_HEAD                             0xCE0B8C
+
+#define mmNIC0_QM0_ARB_ERR_CAUSE                                     0xCE0B9C
+
+#define mmNIC0_QM0_ARB_ERR_MSG_EN                                    0xCE0BA0
+
+#define mmNIC0_QM0_ARB_ERR_STS_DRP                                   0xCE0BA8
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_0                                0xCE0BB0
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_1                                0xCE0BB4
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_2                                0xCE0BB8
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_3                                0xCE0BBC
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_4                                0xCE0BC0
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_5                                0xCE0BC4
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_6                                0xCE0BC8
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_7                                0xCE0BCC
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_8                                0xCE0BD0
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_9                                0xCE0BD4
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_10                               0xCE0BD8
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_11                               0xCE0BDC
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_12                               0xCE0BE0
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_13                               0xCE0BE4
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_14                               0xCE0BE8
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_15                               0xCE0BEC
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_16                               0xCE0BF0
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_17                               0xCE0BF4
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_18                               0xCE0BF8
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_19                               0xCE0BFC
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_20                               0xCE0C00
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_21                               0xCE0C04
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_22                               0xCE0C08
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_23                               0xCE0C0C
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_24                               0xCE0C10
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_25                               0xCE0C14
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_26                               0xCE0C18
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_27                               0xCE0C1C
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_28                               0xCE0C20
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_29                               0xCE0C24
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_30                               0xCE0C28
+
+#define mmNIC0_QM0_ARB_MST_CRED_STS_31                               0xCE0C2C
+
+#define mmNIC0_QM0_CGM_CFG                                           0xCE0C70
+
+#define mmNIC0_QM0_CGM_STS                                           0xCE0C74
+
+#define mmNIC0_QM0_CGM_CFG1                                          0xCE0C78
+
+#define mmNIC0_QM0_LOCAL_RANGE_BASE                                  0xCE0C80
+
+#define mmNIC0_QM0_LOCAL_RANGE_SIZE                                  0xCE0C84
+
+#define mmNIC0_QM0_CSMR_STRICT_PRIO_CFG                              0xCE0C90
+
+#define mmNIC0_QM0_HBW_RD_RATE_LIM_CFG_1                             0xCE0C94
+
+#define mmNIC0_QM0_LBW_WR_RATE_LIM_CFG_0                             0xCE0C98
+
+#define mmNIC0_QM0_LBW_WR_RATE_LIM_CFG_1                             0xCE0C9C
+
+#define mmNIC0_QM0_HBW_RD_RATE_LIM_CFG_0                             0xCE0CA0
+
+#define mmNIC0_QM0_GLBL_AXCACHE                                      0xCE0CA4
+
+#define mmNIC0_QM0_IND_GW_APB_CFG                                    0xCE0CB0
+
+#define mmNIC0_QM0_IND_GW_APB_WDATA                                  0xCE0CB4
+
+#define mmNIC0_QM0_IND_GW_APB_RDATA                                  0xCE0CB8
+
+#define mmNIC0_QM0_IND_GW_APB_STATUS                                 0xCE0CBC
+
+#define mmNIC0_QM0_GLBL_ERR_ADDR_LO                                  0xCE0CD0
+
+#define mmNIC0_QM0_GLBL_ERR_ADDR_HI                                  0xCE0CD4
+
+#define mmNIC0_QM0_GLBL_ERR_WDATA                                    0xCE0CD8
+
+#define mmNIC0_QM0_GLBL_MEM_INIT_BUSY                                0xCE0D00
+
+#endif /* ASIC_REG_NIC0_QM0_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm1_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm1_regs.h
new file mode 100644
index 000000000000..fe96c575b5c6
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm1_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC0_QM1_REGS_H_
+#define ASIC_REG_NIC0_QM1_REGS_H_
+
+/*
+ *****************************************
+ *   NIC0_QM1 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC0_QM1_GLBL_CFG0                                         0xCE2000
+
+#define mmNIC0_QM1_GLBL_CFG1                                         0xCE2004
+
+#define mmNIC0_QM1_GLBL_PROT                                         0xCE2008
+
+#define mmNIC0_QM1_GLBL_ERR_CFG                                      0xCE200C
+
+#define mmNIC0_QM1_GLBL_SECURE_PROPS_0                               0xCE2010
+
+#define mmNIC0_QM1_GLBL_SECURE_PROPS_1                               0xCE2014
+
+#define mmNIC0_QM1_GLBL_SECURE_PROPS_2                               0xCE2018
+
+#define mmNIC0_QM1_GLBL_SECURE_PROPS_3                               0xCE201C
+
+#define mmNIC0_QM1_GLBL_SECURE_PROPS_4                               0xCE2020
+
+#define mmNIC0_QM1_GLBL_NON_SECURE_PROPS_0                           0xCE2024
+
+#define mmNIC0_QM1_GLBL_NON_SECURE_PROPS_1                           0xCE2028
+
+#define mmNIC0_QM1_GLBL_NON_SECURE_PROPS_2                           0xCE202C
+
+#define mmNIC0_QM1_GLBL_NON_SECURE_PROPS_3                           0xCE2030
+
+#define mmNIC0_QM1_GLBL_NON_SECURE_PROPS_4                           0xCE2034
+
+#define mmNIC0_QM1_GLBL_STS0                                         0xCE2038
+
+#define mmNIC0_QM1_GLBL_STS1_0                                       0xCE2040
+
+#define mmNIC0_QM1_GLBL_STS1_1                                       0xCE2044
+
+#define mmNIC0_QM1_GLBL_STS1_2                                       0xCE2048
+
+#define mmNIC0_QM1_GLBL_STS1_3                                       0xCE204C
+
+#define mmNIC0_QM1_GLBL_STS1_4                                       0xCE2050
+
+#define mmNIC0_QM1_GLBL_MSG_EN_0                                     0xCE2054
+
+#define mmNIC0_QM1_GLBL_MSG_EN_1                                     0xCE2058
+
+#define mmNIC0_QM1_GLBL_MSG_EN_2                                     0xCE205C
+
+#define mmNIC0_QM1_GLBL_MSG_EN_3                                     0xCE2060
+
+#define mmNIC0_QM1_GLBL_MSG_EN_4                                     0xCE2068
+
+#define mmNIC0_QM1_PQ_BASE_LO_0                                      0xCE2070
+
+#define mmNIC0_QM1_PQ_BASE_LO_1                                      0xCE2074
+
+#define mmNIC0_QM1_PQ_BASE_LO_2                                      0xCE2078
+
+#define mmNIC0_QM1_PQ_BASE_LO_3                                      0xCE207C
+
+#define mmNIC0_QM1_PQ_BASE_HI_0                                      0xCE2080
+
+#define mmNIC0_QM1_PQ_BASE_HI_1                                      0xCE2084
+
+#define mmNIC0_QM1_PQ_BASE_HI_2                                      0xCE2088
+
+#define mmNIC0_QM1_PQ_BASE_HI_3                                      0xCE208C
+
+#define mmNIC0_QM1_PQ_SIZE_0                                         0xCE2090
+
+#define mmNIC0_QM1_PQ_SIZE_1                                         0xCE2094
+
+#define mmNIC0_QM1_PQ_SIZE_2                                         0xCE2098
+
+#define mmNIC0_QM1_PQ_SIZE_3                                         0xCE209C
+
+#define mmNIC0_QM1_PQ_PI_0                                           0xCE20A0
+
+#define mmNIC0_QM1_PQ_PI_1                                           0xCE20A4
+
+#define mmNIC0_QM1_PQ_PI_2                                           0xCE20A8
+
+#define mmNIC0_QM1_PQ_PI_3                                           0xCE20AC
+
+#define mmNIC0_QM1_PQ_CI_0                                           0xCE20B0
+
+#define mmNIC0_QM1_PQ_CI_1                                           0xCE20B4
+
+#define mmNIC0_QM1_PQ_CI_2                                           0xCE20B8
+
+#define mmNIC0_QM1_PQ_CI_3                                           0xCE20BC
+
+#define mmNIC0_QM1_PQ_CFG0_0                                         0xCE20C0
+
+#define mmNIC0_QM1_PQ_CFG0_1                                         0xCE20C4
+
+#define mmNIC0_QM1_PQ_CFG0_2                                         0xCE20C8
+
+#define mmNIC0_QM1_PQ_CFG0_3                                         0xCE20CC
+
+#define mmNIC0_QM1_PQ_CFG1_0                                         0xCE20D0
+
+#define mmNIC0_QM1_PQ_CFG1_1                                         0xCE20D4
+
+#define mmNIC0_QM1_PQ_CFG1_2                                         0xCE20D8
+
+#define mmNIC0_QM1_PQ_CFG1_3                                         0xCE20DC
+
+#define mmNIC0_QM1_PQ_ARUSER_31_11_0                                 0xCE20E0
+
+#define mmNIC0_QM1_PQ_ARUSER_31_11_1                                 0xCE20E4
+
+#define mmNIC0_QM1_PQ_ARUSER_31_11_2                                 0xCE20E8
+
+#define mmNIC0_QM1_PQ_ARUSER_31_11_3                                 0xCE20EC
+
+#define mmNIC0_QM1_PQ_STS0_0                                         0xCE20F0
+
+#define mmNIC0_QM1_PQ_STS0_1                                         0xCE20F4
+
+#define mmNIC0_QM1_PQ_STS0_2                                         0xCE20F8
+
+#define mmNIC0_QM1_PQ_STS0_3                                         0xCE20FC
+
+#define mmNIC0_QM1_PQ_STS1_0                                         0xCE2100
+
+#define mmNIC0_QM1_PQ_STS1_1                                         0xCE2104
+
+#define mmNIC0_QM1_PQ_STS1_2                                         0xCE2108
+
+#define mmNIC0_QM1_PQ_STS1_3                                         0xCE210C
+
+#define mmNIC0_QM1_CQ_CFG0_0                                         0xCE2110
+
+#define mmNIC0_QM1_CQ_CFG0_1                                         0xCE2114
+
+#define mmNIC0_QM1_CQ_CFG0_2                                         0xCE2118
+
+#define mmNIC0_QM1_CQ_CFG0_3                                         0xCE211C
+
+#define mmNIC0_QM1_CQ_CFG0_4                                         0xCE2120
+
+#define mmNIC0_QM1_CQ_CFG1_0                                         0xCE2124
+
+#define mmNIC0_QM1_CQ_CFG1_1                                         0xCE2128
+
+#define mmNIC0_QM1_CQ_CFG1_2                                         0xCE212C
+
+#define mmNIC0_QM1_CQ_CFG1_3                                         0xCE2130
+
+#define mmNIC0_QM1_CQ_CFG1_4                                         0xCE2134
+
+#define mmNIC0_QM1_CQ_ARUSER_31_11_0                                 0xCE2138
+
+#define mmNIC0_QM1_CQ_ARUSER_31_11_1                                 0xCE213C
+
+#define mmNIC0_QM1_CQ_ARUSER_31_11_2                                 0xCE2140
+
+#define mmNIC0_QM1_CQ_ARUSER_31_11_3                                 0xCE2144
+
+#define mmNIC0_QM1_CQ_ARUSER_31_11_4                                 0xCE2148
+
+#define mmNIC0_QM1_CQ_STS0_0                                         0xCE214C
+
+#define mmNIC0_QM1_CQ_STS0_1                                         0xCE2150
+
+#define mmNIC0_QM1_CQ_STS0_2                                         0xCE2154
+
+#define mmNIC0_QM1_CQ_STS0_3                                         0xCE2158
+
+#define mmNIC0_QM1_CQ_STS0_4                                         0xCE215C
+
+#define mmNIC0_QM1_CQ_STS1_0                                         0xCE2160
+
+#define mmNIC0_QM1_CQ_STS1_1                                         0xCE2164
+
+#define mmNIC0_QM1_CQ_STS1_2                                         0xCE2168
+
+#define mmNIC0_QM1_CQ_STS1_3                                         0xCE216C
+
+#define mmNIC0_QM1_CQ_STS1_4                                         0xCE2170
+
+#define mmNIC0_QM1_CQ_PTR_LO_0                                       0xCE2174
+
+#define mmNIC0_QM1_CQ_PTR_HI_0                                       0xCE2178
+
+#define mmNIC0_QM1_CQ_TSIZE_0                                        0xCE217C
+
+#define mmNIC0_QM1_CQ_CTL_0                                          0xCE2180
+
+#define mmNIC0_QM1_CQ_PTR_LO_1                                       0xCE2184
+
+#define mmNIC0_QM1_CQ_PTR_HI_1                                       0xCE2188
+
+#define mmNIC0_QM1_CQ_TSIZE_1                                        0xCE218C
+
+#define mmNIC0_QM1_CQ_CTL_1                                          0xCE2190
+
+#define mmNIC0_QM1_CQ_PTR_LO_2                                       0xCE2194
+
+#define mmNIC0_QM1_CQ_PTR_HI_2                                       0xCE2198
+
+#define mmNIC0_QM1_CQ_TSIZE_2                                        0xCE219C
+
+#define mmNIC0_QM1_CQ_CTL_2                                          0xCE21A0
+
+#define mmNIC0_QM1_CQ_PTR_LO_3                                       0xCE21A4
+
+#define mmNIC0_QM1_CQ_PTR_HI_3                                       0xCE21A8
+
+#define mmNIC0_QM1_CQ_TSIZE_3                                        0xCE21AC
+
+#define mmNIC0_QM1_CQ_CTL_3                                          0xCE21B0
+
+#define mmNIC0_QM1_CQ_PTR_LO_4                                       0xCE21B4
+
+#define mmNIC0_QM1_CQ_PTR_HI_4                                       0xCE21B8
+
+#define mmNIC0_QM1_CQ_TSIZE_4                                        0xCE21BC
+
+#define mmNIC0_QM1_CQ_CTL_4                                          0xCE21C0
+
+#define mmNIC0_QM1_CQ_PTR_LO_STS_0                                   0xCE21C4
+
+#define mmNIC0_QM1_CQ_PTR_LO_STS_1                                   0xCE21C8
+
+#define mmNIC0_QM1_CQ_PTR_LO_STS_2                                   0xCE21CC
+
+#define mmNIC0_QM1_CQ_PTR_LO_STS_3                                   0xCE21D0
+
+#define mmNIC0_QM1_CQ_PTR_LO_STS_4                                   0xCE21D4
+
+#define mmNIC0_QM1_CQ_PTR_HI_STS_0                                   0xCE21D8
+
+#define mmNIC0_QM1_CQ_PTR_HI_STS_1                                   0xCE21DC
+
+#define mmNIC0_QM1_CQ_PTR_HI_STS_2                                   0xCE21E0
+
+#define mmNIC0_QM1_CQ_PTR_HI_STS_3                                   0xCE21E4
+
+#define mmNIC0_QM1_CQ_PTR_HI_STS_4                                   0xCE21E8
+
+#define mmNIC0_QM1_CQ_TSIZE_STS_0                                    0xCE21EC
+
+#define mmNIC0_QM1_CQ_TSIZE_STS_1                                    0xCE21F0
+
+#define mmNIC0_QM1_CQ_TSIZE_STS_2                                    0xCE21F4
+
+#define mmNIC0_QM1_CQ_TSIZE_STS_3                                    0xCE21F8
+
+#define mmNIC0_QM1_CQ_TSIZE_STS_4                                    0xCE21FC
+
+#define mmNIC0_QM1_CQ_CTL_STS_0                                      0xCE2200
+
+#define mmNIC0_QM1_CQ_CTL_STS_1                                      0xCE2204
+
+#define mmNIC0_QM1_CQ_CTL_STS_2                                      0xCE2208
+
+#define mmNIC0_QM1_CQ_CTL_STS_3                                      0xCE220C
+
+#define mmNIC0_QM1_CQ_CTL_STS_4                                      0xCE2210
+
+#define mmNIC0_QM1_CQ_IFIFO_CNT_0                                    0xCE2214
+
+#define mmNIC0_QM1_CQ_IFIFO_CNT_1                                    0xCE2218
+
+#define mmNIC0_QM1_CQ_IFIFO_CNT_2                                    0xCE221C
+
+#define mmNIC0_QM1_CQ_IFIFO_CNT_3                                    0xCE2220
+
+#define mmNIC0_QM1_CQ_IFIFO_CNT_4                                    0xCE2224
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_LO_0                            0xCE2228
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_LO_1                            0xCE222C
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_LO_2                            0xCE2230
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_LO_3                            0xCE2234
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_LO_4                            0xCE2238
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_HI_0                            0xCE223C
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_HI_1                            0xCE2240
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_HI_2                            0xCE2244
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_HI_3                            0xCE2248
+
+#define mmNIC0_QM1_CP_MSG_BASE0_ADDR_HI_4                            0xCE224C
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_LO_0                            0xCE2250
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_LO_1                            0xCE2254
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_LO_2                            0xCE2258
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_LO_3                            0xCE225C
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_LO_4                            0xCE2260
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_HI_0                            0xCE2264
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_HI_1                            0xCE2268
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_HI_2                            0xCE226C
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_HI_3                            0xCE2270
+
+#define mmNIC0_QM1_CP_MSG_BASE1_ADDR_HI_4                            0xCE2274
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_LO_0                            0xCE2278
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_LO_1                            0xCE227C
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_LO_2                            0xCE2280
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_LO_3                            0xCE2284
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_LO_4                            0xCE2288
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_HI_0                            0xCE228C
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_HI_1                            0xCE2290
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_HI_2                            0xCE2294
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_HI_3                            0xCE2298
+
+#define mmNIC0_QM1_CP_MSG_BASE2_ADDR_HI_4                            0xCE229C
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_LO_0                            0xCE22A0
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_LO_1                            0xCE22A4
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_LO_2                            0xCE22A8
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_LO_3                            0xCE22AC
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_LO_4                            0xCE22B0
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_HI_0                            0xCE22B4
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_HI_1                            0xCE22B8
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_HI_2                            0xCE22BC
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_HI_3                            0xCE22C0
+
+#define mmNIC0_QM1_CP_MSG_BASE3_ADDR_HI_4                            0xCE22C4
+
+#define mmNIC0_QM1_CP_LDMA_TSIZE_OFFSET_0                            0xCE22C8
+
+#define mmNIC0_QM1_CP_LDMA_TSIZE_OFFSET_1                            0xCE22CC
+
+#define mmNIC0_QM1_CP_LDMA_TSIZE_OFFSET_2                            0xCE22D0
+
+#define mmNIC0_QM1_CP_LDMA_TSIZE_OFFSET_3                            0xCE22D4
+
+#define mmNIC0_QM1_CP_LDMA_TSIZE_OFFSET_4                            0xCE22D8
+
+#define mmNIC0_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xCE22E0
+
+#define mmNIC0_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xCE22E4
+
+#define mmNIC0_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xCE22E8
+
+#define mmNIC0_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xCE22EC
+
+#define mmNIC0_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xCE22F0
+
+#define mmNIC0_QM1_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xCE22F4
+
+#define mmNIC0_QM1_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xCE22F8
+
+#define mmNIC0_QM1_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xCE22FC
+
+#define mmNIC0_QM1_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xCE2300
+
+#define mmNIC0_QM1_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xCE2304
+
+#define mmNIC0_QM1_CP_FENCE0_RDATA_0                                 0xCE2308
+
+#define mmNIC0_QM1_CP_FENCE0_RDATA_1                                 0xCE230C
+
+#define mmNIC0_QM1_CP_FENCE0_RDATA_2                                 0xCE2310
+
+#define mmNIC0_QM1_CP_FENCE0_RDATA_3                                 0xCE2314
+
+#define mmNIC0_QM1_CP_FENCE0_RDATA_4                                 0xCE2318
+
+#define mmNIC0_QM1_CP_FENCE1_RDATA_0                                 0xCE231C
+
+#define mmNIC0_QM1_CP_FENCE1_RDATA_1                                 0xCE2320
+
+#define mmNIC0_QM1_CP_FENCE1_RDATA_2                                 0xCE2324
+
+#define mmNIC0_QM1_CP_FENCE1_RDATA_3                                 0xCE2328
+
+#define mmNIC0_QM1_CP_FENCE1_RDATA_4                                 0xCE232C
+
+#define mmNIC0_QM1_CP_FENCE2_RDATA_0                                 0xCE2330
+
+#define mmNIC0_QM1_CP_FENCE2_RDATA_1                                 0xCE2334
+
+#define mmNIC0_QM1_CP_FENCE2_RDATA_2                                 0xCE2338
+
+#define mmNIC0_QM1_CP_FENCE2_RDATA_3                                 0xCE233C
+
+#define mmNIC0_QM1_CP_FENCE2_RDATA_4                                 0xCE2340
+
+#define mmNIC0_QM1_CP_FENCE3_RDATA_0                                 0xCE2344
+
+#define mmNIC0_QM1_CP_FENCE3_RDATA_1                                 0xCE2348
+
+#define mmNIC0_QM1_CP_FENCE3_RDATA_2                                 0xCE234C
+
+#define mmNIC0_QM1_CP_FENCE3_RDATA_3                                 0xCE2350
+
+#define mmNIC0_QM1_CP_FENCE3_RDATA_4                                 0xCE2354
+
+#define mmNIC0_QM1_CP_FENCE0_CNT_0                                   0xCE2358
+
+#define mmNIC0_QM1_CP_FENCE0_CNT_1                                   0xCE235C
+
+#define mmNIC0_QM1_CP_FENCE0_CNT_2                                   0xCE2360
+
+#define mmNIC0_QM1_CP_FENCE0_CNT_3                                   0xCE2364
+
+#define mmNIC0_QM1_CP_FENCE0_CNT_4                                   0xCE2368
+
+#define mmNIC0_QM1_CP_FENCE1_CNT_0                                   0xCE236C
+
+#define mmNIC0_QM1_CP_FENCE1_CNT_1                                   0xCE2370
+
+#define mmNIC0_QM1_CP_FENCE1_CNT_2                                   0xCE2374
+
+#define mmNIC0_QM1_CP_FENCE1_CNT_3                                   0xCE2378
+
+#define mmNIC0_QM1_CP_FENCE1_CNT_4                                   0xCE237C
+
+#define mmNIC0_QM1_CP_FENCE2_CNT_0                                   0xCE2380
+
+#define mmNIC0_QM1_CP_FENCE2_CNT_1                                   0xCE2384
+
+#define mmNIC0_QM1_CP_FENCE2_CNT_2                                   0xCE2388
+
+#define mmNIC0_QM1_CP_FENCE2_CNT_3                                   0xCE238C
+
+#define mmNIC0_QM1_CP_FENCE2_CNT_4                                   0xCE2390
+
+#define mmNIC0_QM1_CP_FENCE3_CNT_0                                   0xCE2394
+
+#define mmNIC0_QM1_CP_FENCE3_CNT_1                                   0xCE2398
+
+#define mmNIC0_QM1_CP_FENCE3_CNT_2                                   0xCE239C
+
+#define mmNIC0_QM1_CP_FENCE3_CNT_3                                   0xCE23A0
+
+#define mmNIC0_QM1_CP_FENCE3_CNT_4                                   0xCE23A4
+
+#define mmNIC0_QM1_CP_STS_0                                          0xCE23A8
+
+#define mmNIC0_QM1_CP_STS_1                                          0xCE23AC
+
+#define mmNIC0_QM1_CP_STS_2                                          0xCE23B0
+
+#define mmNIC0_QM1_CP_STS_3                                          0xCE23B4
+
+#define mmNIC0_QM1_CP_STS_4                                          0xCE23B8
+
+#define mmNIC0_QM1_CP_CURRENT_INST_LO_0                              0xCE23BC
+
+#define mmNIC0_QM1_CP_CURRENT_INST_LO_1                              0xCE23C0
+
+#define mmNIC0_QM1_CP_CURRENT_INST_LO_2                              0xCE23C4
+
+#define mmNIC0_QM1_CP_CURRENT_INST_LO_3                              0xCE23C8
+
+#define mmNIC0_QM1_CP_CURRENT_INST_LO_4                              0xCE23CC
+
+#define mmNIC0_QM1_CP_CURRENT_INST_HI_0                              0xCE23D0
+
+#define mmNIC0_QM1_CP_CURRENT_INST_HI_1                              0xCE23D4
+
+#define mmNIC0_QM1_CP_CURRENT_INST_HI_2                              0xCE23D8
+
+#define mmNIC0_QM1_CP_CURRENT_INST_HI_3                              0xCE23DC
+
+#define mmNIC0_QM1_CP_CURRENT_INST_HI_4                              0xCE23E0
+
+#define mmNIC0_QM1_CP_BARRIER_CFG_0                                  0xCE23F4
+
+#define mmNIC0_QM1_CP_BARRIER_CFG_1                                  0xCE23F8
+
+#define mmNIC0_QM1_CP_BARRIER_CFG_2                                  0xCE23FC
+
+#define mmNIC0_QM1_CP_BARRIER_CFG_3                                  0xCE2400
+
+#define mmNIC0_QM1_CP_BARRIER_CFG_4                                  0xCE2404
+
+#define mmNIC0_QM1_CP_DBG_0_0                                        0xCE2408
+
+#define mmNIC0_QM1_CP_DBG_0_1                                        0xCE240C
+
+#define mmNIC0_QM1_CP_DBG_0_2                                        0xCE2410
+
+#define mmNIC0_QM1_CP_DBG_0_3                                        0xCE2414
+
+#define mmNIC0_QM1_CP_DBG_0_4                                        0xCE2418
+
+#define mmNIC0_QM1_CP_ARUSER_31_11_0                                 0xCE241C
+
+#define mmNIC0_QM1_CP_ARUSER_31_11_1                                 0xCE2420
+
+#define mmNIC0_QM1_CP_ARUSER_31_11_2                                 0xCE2424
+
+#define mmNIC0_QM1_CP_ARUSER_31_11_3                                 0xCE2428
+
+#define mmNIC0_QM1_CP_ARUSER_31_11_4                                 0xCE242C
+
+#define mmNIC0_QM1_CP_AWUSER_31_11_0                                 0xCE2430
+
+#define mmNIC0_QM1_CP_AWUSER_31_11_1                                 0xCE2434
+
+#define mmNIC0_QM1_CP_AWUSER_31_11_2                                 0xCE2438
+
+#define mmNIC0_QM1_CP_AWUSER_31_11_3                                 0xCE243C
+
+#define mmNIC0_QM1_CP_AWUSER_31_11_4                                 0xCE2440
+
+#define mmNIC0_QM1_ARB_CFG_0                                         0xCE2A00
+
+#define mmNIC0_QM1_ARB_CHOISE_Q_PUSH                                 0xCE2A04
+
+#define mmNIC0_QM1_ARB_WRR_WEIGHT_0                                  0xCE2A08
+
+#define mmNIC0_QM1_ARB_WRR_WEIGHT_1                                  0xCE2A0C
+
+#define mmNIC0_QM1_ARB_WRR_WEIGHT_2                                  0xCE2A10
+
+#define mmNIC0_QM1_ARB_WRR_WEIGHT_3                                  0xCE2A14
+
+#define mmNIC0_QM1_ARB_CFG_1                                         0xCE2A18
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_0                              0xCE2A20
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_1                              0xCE2A24
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_2                              0xCE2A28
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_3                              0xCE2A2C
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_4                              0xCE2A30
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_5                              0xCE2A34
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_6                              0xCE2A38
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_7                              0xCE2A3C
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_8                              0xCE2A40
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_9                              0xCE2A44
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_10                             0xCE2A48
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_11                             0xCE2A4C
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_12                             0xCE2A50
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_13                             0xCE2A54
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_14                             0xCE2A58
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_15                             0xCE2A5C
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_16                             0xCE2A60
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_17                             0xCE2A64
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_18                             0xCE2A68
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_19                             0xCE2A6C
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_20                             0xCE2A70
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_21                             0xCE2A74
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_22                             0xCE2A78
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_23                             0xCE2A7C
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_24                             0xCE2A80
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_25                             0xCE2A84
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_26                             0xCE2A88
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_27                             0xCE2A8C
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_28                             0xCE2A90
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_29                             0xCE2A94
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_30                             0xCE2A98
+
+#define mmNIC0_QM1_ARB_MST_AVAIL_CRED_31                             0xCE2A9C
+
+#define mmNIC0_QM1_ARB_MST_CRED_INC                                  0xCE2AA0
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_0                        0xCE2AA4
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_1                        0xCE2AA8
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_2                        0xCE2AAC
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_3                        0xCE2AB0
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_4                        0xCE2AB4
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_5                        0xCE2AB8
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_6                        0xCE2ABC
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_7                        0xCE2AC0
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_8                        0xCE2AC4
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_9                        0xCE2AC8
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_10                       0xCE2ACC
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_11                       0xCE2AD0
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_12                       0xCE2AD4
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_13                       0xCE2AD8
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_14                       0xCE2ADC
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_15                       0xCE2AE0
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_16                       0xCE2AE4
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_17                       0xCE2AE8
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_18                       0xCE2AEC
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_19                       0xCE2AF0
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_20                       0xCE2AF4
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_21                       0xCE2AF8
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_22                       0xCE2AFC
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_23                       0xCE2B00
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_24                       0xCE2B04
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_25                       0xCE2B08
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_26                       0xCE2B0C
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_27                       0xCE2B10
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_28                       0xCE2B14
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_29                       0xCE2B18
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_30                       0xCE2B1C
+
+#define mmNIC0_QM1_ARB_MST_CHOISE_PUSH_OFST_31                       0xCE2B20
+
+#define mmNIC0_QM1_ARB_SLV_MASTER_INC_CRED_OFST                      0xCE2B28
+
+#define mmNIC0_QM1_ARB_MST_SLAVE_EN                                  0xCE2B2C
+
+#define mmNIC0_QM1_ARB_MST_QUIET_PER                                 0xCE2B34
+
+#define mmNIC0_QM1_ARB_SLV_CHOISE_WDT                                0xCE2B38
+
+#define mmNIC0_QM1_ARB_SLV_ID                                        0xCE2B3C
+
+#define mmNIC0_QM1_ARB_MSG_MAX_INFLIGHT                              0xCE2B44
+
+#define mmNIC0_QM1_ARB_MSG_AWUSER_31_11                              0xCE2B48
+
+#define mmNIC0_QM1_ARB_MSG_AWUSER_SEC_PROP                           0xCE2B4C
+
+#define mmNIC0_QM1_ARB_MSG_AWUSER_NON_SEC_PROP                       0xCE2B50
+
+#define mmNIC0_QM1_ARB_BASE_LO                                       0xCE2B54
+
+#define mmNIC0_QM1_ARB_BASE_HI                                       0xCE2B58
+
+#define mmNIC0_QM1_ARB_STATE_STS                                     0xCE2B80
+
+#define mmNIC0_QM1_ARB_CHOISE_FULLNESS_STS                           0xCE2B84
+
+#define mmNIC0_QM1_ARB_MSG_STS                                       0xCE2B88
+
+#define mmNIC0_QM1_ARB_SLV_CHOISE_Q_HEAD                             0xCE2B8C
+
+#define mmNIC0_QM1_ARB_ERR_CAUSE                                     0xCE2B9C
+
+#define mmNIC0_QM1_ARB_ERR_MSG_EN                                    0xCE2BA0
+
+#define mmNIC0_QM1_ARB_ERR_STS_DRP                                   0xCE2BA8
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_0                                0xCE2BB0
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_1                                0xCE2BB4
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_2                                0xCE2BB8
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_3                                0xCE2BBC
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_4                                0xCE2BC0
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_5                                0xCE2BC4
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_6                                0xCE2BC8
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_7                                0xCE2BCC
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_8                                0xCE2BD0
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_9                                0xCE2BD4
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_10                               0xCE2BD8
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_11                               0xCE2BDC
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_12                               0xCE2BE0
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_13                               0xCE2BE4
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_14                               0xCE2BE8
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_15                               0xCE2BEC
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_16                               0xCE2BF0
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_17                               0xCE2BF4
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_18                               0xCE2BF8
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_19                               0xCE2BFC
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_20                               0xCE2C00
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_21                               0xCE2C04
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_22                               0xCE2C08
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_23                               0xCE2C0C
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_24                               0xCE2C10
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_25                               0xCE2C14
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_26                               0xCE2C18
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_27                               0xCE2C1C
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_28                               0xCE2C20
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_29                               0xCE2C24
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_30                               0xCE2C28
+
+#define mmNIC0_QM1_ARB_MST_CRED_STS_31                               0xCE2C2C
+
+#define mmNIC0_QM1_CGM_CFG                                           0xCE2C70
+
+#define mmNIC0_QM1_CGM_STS                                           0xCE2C74
+
+#define mmNIC0_QM1_CGM_CFG1                                          0xCE2C78
+
+#define mmNIC0_QM1_LOCAL_RANGE_BASE                                  0xCE2C80
+
+#define mmNIC0_QM1_LOCAL_RANGE_SIZE                                  0xCE2C84
+
+#define mmNIC0_QM1_CSMR_STRICT_PRIO_CFG                              0xCE2C90
+
+#define mmNIC0_QM1_HBW_RD_RATE_LIM_CFG_1                             0xCE2C94
+
+#define mmNIC0_QM1_LBW_WR_RATE_LIM_CFG_0                             0xCE2C98
+
+#define mmNIC0_QM1_LBW_WR_RATE_LIM_CFG_1                             0xCE2C9C
+
+#define mmNIC0_QM1_HBW_RD_RATE_LIM_CFG_0                             0xCE2CA0
+
+#define mmNIC0_QM1_GLBL_AXCACHE                                      0xCE2CA4
+
+#define mmNIC0_QM1_IND_GW_APB_CFG                                    0xCE2CB0
+
+#define mmNIC0_QM1_IND_GW_APB_WDATA                                  0xCE2CB4
+
+#define mmNIC0_QM1_IND_GW_APB_RDATA                                  0xCE2CB8
+
+#define mmNIC0_QM1_IND_GW_APB_STATUS                                 0xCE2CBC
+
+#define mmNIC0_QM1_GLBL_ERR_ADDR_LO                                  0xCE2CD0
+
+#define mmNIC0_QM1_GLBL_ERR_ADDR_HI                                  0xCE2CD4
+
+#define mmNIC0_QM1_GLBL_ERR_WDATA                                    0xCE2CD8
+
+#define mmNIC0_QM1_GLBL_MEM_INIT_BUSY                                0xCE2D00
+
+#endif /* ASIC_REG_NIC0_QM1_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm0_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm0_regs.h
new file mode 100644
index 000000000000..0d1caf057ad0
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm0_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC1_QM0_REGS_H_
+#define ASIC_REG_NIC1_QM0_REGS_H_
+
+/*
+ *****************************************
+ *   NIC1_QM0 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC1_QM0_GLBL_CFG0                                         0xD20000
+
+#define mmNIC1_QM0_GLBL_CFG1                                         0xD20004
+
+#define mmNIC1_QM0_GLBL_PROT                                         0xD20008
+
+#define mmNIC1_QM0_GLBL_ERR_CFG                                      0xD2000C
+
+#define mmNIC1_QM0_GLBL_SECURE_PROPS_0                               0xD20010
+
+#define mmNIC1_QM0_GLBL_SECURE_PROPS_1                               0xD20014
+
+#define mmNIC1_QM0_GLBL_SECURE_PROPS_2                               0xD20018
+
+#define mmNIC1_QM0_GLBL_SECURE_PROPS_3                               0xD2001C
+
+#define mmNIC1_QM0_GLBL_SECURE_PROPS_4                               0xD20020
+
+#define mmNIC1_QM0_GLBL_NON_SECURE_PROPS_0                           0xD20024
+
+#define mmNIC1_QM0_GLBL_NON_SECURE_PROPS_1                           0xD20028
+
+#define mmNIC1_QM0_GLBL_NON_SECURE_PROPS_2                           0xD2002C
+
+#define mmNIC1_QM0_GLBL_NON_SECURE_PROPS_3                           0xD20030
+
+#define mmNIC1_QM0_GLBL_NON_SECURE_PROPS_4                           0xD20034
+
+#define mmNIC1_QM0_GLBL_STS0                                         0xD20038
+
+#define mmNIC1_QM0_GLBL_STS1_0                                       0xD20040
+
+#define mmNIC1_QM0_GLBL_STS1_1                                       0xD20044
+
+#define mmNIC1_QM0_GLBL_STS1_2                                       0xD20048
+
+#define mmNIC1_QM0_GLBL_STS1_3                                       0xD2004C
+
+#define mmNIC1_QM0_GLBL_STS1_4                                       0xD20050
+
+#define mmNIC1_QM0_GLBL_MSG_EN_0                                     0xD20054
+
+#define mmNIC1_QM0_GLBL_MSG_EN_1                                     0xD20058
+
+#define mmNIC1_QM0_GLBL_MSG_EN_2                                     0xD2005C
+
+#define mmNIC1_QM0_GLBL_MSG_EN_3                                     0xD20060
+
+#define mmNIC1_QM0_GLBL_MSG_EN_4                                     0xD20068
+
+#define mmNIC1_QM0_PQ_BASE_LO_0                                      0xD20070
+
+#define mmNIC1_QM0_PQ_BASE_LO_1                                      0xD20074
+
+#define mmNIC1_QM0_PQ_BASE_LO_2                                      0xD20078
+
+#define mmNIC1_QM0_PQ_BASE_LO_3                                      0xD2007C
+
+#define mmNIC1_QM0_PQ_BASE_HI_0                                      0xD20080
+
+#define mmNIC1_QM0_PQ_BASE_HI_1                                      0xD20084
+
+#define mmNIC1_QM0_PQ_BASE_HI_2                                      0xD20088
+
+#define mmNIC1_QM0_PQ_BASE_HI_3                                      0xD2008C
+
+#define mmNIC1_QM0_PQ_SIZE_0                                         0xD20090
+
+#define mmNIC1_QM0_PQ_SIZE_1                                         0xD20094
+
+#define mmNIC1_QM0_PQ_SIZE_2                                         0xD20098
+
+#define mmNIC1_QM0_PQ_SIZE_3                                         0xD2009C
+
+#define mmNIC1_QM0_PQ_PI_0                                           0xD200A0
+
+#define mmNIC1_QM0_PQ_PI_1                                           0xD200A4
+
+#define mmNIC1_QM0_PQ_PI_2                                           0xD200A8
+
+#define mmNIC1_QM0_PQ_PI_3                                           0xD200AC
+
+#define mmNIC1_QM0_PQ_CI_0                                           0xD200B0
+
+#define mmNIC1_QM0_PQ_CI_1                                           0xD200B4
+
+#define mmNIC1_QM0_PQ_CI_2                                           0xD200B8
+
+#define mmNIC1_QM0_PQ_CI_3                                           0xD200BC
+
+#define mmNIC1_QM0_PQ_CFG0_0                                         0xD200C0
+
+#define mmNIC1_QM0_PQ_CFG0_1                                         0xD200C4
+
+#define mmNIC1_QM0_PQ_CFG0_2                                         0xD200C8
+
+#define mmNIC1_QM0_PQ_CFG0_3                                         0xD200CC
+
+#define mmNIC1_QM0_PQ_CFG1_0                                         0xD200D0
+
+#define mmNIC1_QM0_PQ_CFG1_1                                         0xD200D4
+
+#define mmNIC1_QM0_PQ_CFG1_2                                         0xD200D8
+
+#define mmNIC1_QM0_PQ_CFG1_3                                         0xD200DC
+
+#define mmNIC1_QM0_PQ_ARUSER_31_11_0                                 0xD200E0
+
+#define mmNIC1_QM0_PQ_ARUSER_31_11_1                                 0xD200E4
+
+#define mmNIC1_QM0_PQ_ARUSER_31_11_2                                 0xD200E8
+
+#define mmNIC1_QM0_PQ_ARUSER_31_11_3                                 0xD200EC
+
+#define mmNIC1_QM0_PQ_STS0_0                                         0xD200F0
+
+#define mmNIC1_QM0_PQ_STS0_1                                         0xD200F4
+
+#define mmNIC1_QM0_PQ_STS0_2                                         0xD200F8
+
+#define mmNIC1_QM0_PQ_STS0_3                                         0xD200FC
+
+#define mmNIC1_QM0_PQ_STS1_0                                         0xD20100
+
+#define mmNIC1_QM0_PQ_STS1_1                                         0xD20104
+
+#define mmNIC1_QM0_PQ_STS1_2                                         0xD20108
+
+#define mmNIC1_QM0_PQ_STS1_3                                         0xD2010C
+
+#define mmNIC1_QM0_CQ_CFG0_0                                         0xD20110
+
+#define mmNIC1_QM0_CQ_CFG0_1                                         0xD20114
+
+#define mmNIC1_QM0_CQ_CFG0_2                                         0xD20118
+
+#define mmNIC1_QM0_CQ_CFG0_3                                         0xD2011C
+
+#define mmNIC1_QM0_CQ_CFG0_4                                         0xD20120
+
+#define mmNIC1_QM0_CQ_CFG1_0                                         0xD20124
+
+#define mmNIC1_QM0_CQ_CFG1_1                                         0xD20128
+
+#define mmNIC1_QM0_CQ_CFG1_2                                         0xD2012C
+
+#define mmNIC1_QM0_CQ_CFG1_3                                         0xD20130
+
+#define mmNIC1_QM0_CQ_CFG1_4                                         0xD20134
+
+#define mmNIC1_QM0_CQ_ARUSER_31_11_0                                 0xD20138
+
+#define mmNIC1_QM0_CQ_ARUSER_31_11_1                                 0xD2013C
+
+#define mmNIC1_QM0_CQ_ARUSER_31_11_2                                 0xD20140
+
+#define mmNIC1_QM0_CQ_ARUSER_31_11_3                                 0xD20144
+
+#define mmNIC1_QM0_CQ_ARUSER_31_11_4                                 0xD20148
+
+#define mmNIC1_QM0_CQ_STS0_0                                         0xD2014C
+
+#define mmNIC1_QM0_CQ_STS0_1                                         0xD20150
+
+#define mmNIC1_QM0_CQ_STS0_2                                         0xD20154
+
+#define mmNIC1_QM0_CQ_STS0_3                                         0xD20158
+
+#define mmNIC1_QM0_CQ_STS0_4                                         0xD2015C
+
+#define mmNIC1_QM0_CQ_STS1_0                                         0xD20160
+
+#define mmNIC1_QM0_CQ_STS1_1                                         0xD20164
+
+#define mmNIC1_QM0_CQ_STS1_2                                         0xD20168
+
+#define mmNIC1_QM0_CQ_STS1_3                                         0xD2016C
+
+#define mmNIC1_QM0_CQ_STS1_4                                         0xD20170
+
+#define mmNIC1_QM0_CQ_PTR_LO_0                                       0xD20174
+
+#define mmNIC1_QM0_CQ_PTR_HI_0                                       0xD20178
+
+#define mmNIC1_QM0_CQ_TSIZE_0                                        0xD2017C
+
+#define mmNIC1_QM0_CQ_CTL_0                                          0xD20180
+
+#define mmNIC1_QM0_CQ_PTR_LO_1                                       0xD20184
+
+#define mmNIC1_QM0_CQ_PTR_HI_1                                       0xD20188
+
+#define mmNIC1_QM0_CQ_TSIZE_1                                        0xD2018C
+
+#define mmNIC1_QM0_CQ_CTL_1                                          0xD20190
+
+#define mmNIC1_QM0_CQ_PTR_LO_2                                       0xD20194
+
+#define mmNIC1_QM0_CQ_PTR_HI_2                                       0xD20198
+
+#define mmNIC1_QM0_CQ_TSIZE_2                                        0xD2019C
+
+#define mmNIC1_QM0_CQ_CTL_2                                          0xD201A0
+
+#define mmNIC1_QM0_CQ_PTR_LO_3                                       0xD201A4
+
+#define mmNIC1_QM0_CQ_PTR_HI_3                                       0xD201A8
+
+#define mmNIC1_QM0_CQ_TSIZE_3                                        0xD201AC
+
+#define mmNIC1_QM0_CQ_CTL_3                                          0xD201B0
+
+#define mmNIC1_QM0_CQ_PTR_LO_4                                       0xD201B4
+
+#define mmNIC1_QM0_CQ_PTR_HI_4                                       0xD201B8
+
+#define mmNIC1_QM0_CQ_TSIZE_4                                        0xD201BC
+
+#define mmNIC1_QM0_CQ_CTL_4                                          0xD201C0
+
+#define mmNIC1_QM0_CQ_PTR_LO_STS_0                                   0xD201C4
+
+#define mmNIC1_QM0_CQ_PTR_LO_STS_1                                   0xD201C8
+
+#define mmNIC1_QM0_CQ_PTR_LO_STS_2                                   0xD201CC
+
+#define mmNIC1_QM0_CQ_PTR_LO_STS_3                                   0xD201D0
+
+#define mmNIC1_QM0_CQ_PTR_LO_STS_4                                   0xD201D4
+
+#define mmNIC1_QM0_CQ_PTR_HI_STS_0                                   0xD201D8
+
+#define mmNIC1_QM0_CQ_PTR_HI_STS_1                                   0xD201DC
+
+#define mmNIC1_QM0_CQ_PTR_HI_STS_2                                   0xD201E0
+
+#define mmNIC1_QM0_CQ_PTR_HI_STS_3                                   0xD201E4
+
+#define mmNIC1_QM0_CQ_PTR_HI_STS_4                                   0xD201E8
+
+#define mmNIC1_QM0_CQ_TSIZE_STS_0                                    0xD201EC
+
+#define mmNIC1_QM0_CQ_TSIZE_STS_1                                    0xD201F0
+
+#define mmNIC1_QM0_CQ_TSIZE_STS_2                                    0xD201F4
+
+#define mmNIC1_QM0_CQ_TSIZE_STS_3                                    0xD201F8
+
+#define mmNIC1_QM0_CQ_TSIZE_STS_4                                    0xD201FC
+
+#define mmNIC1_QM0_CQ_CTL_STS_0                                      0xD20200
+
+#define mmNIC1_QM0_CQ_CTL_STS_1                                      0xD20204
+
+#define mmNIC1_QM0_CQ_CTL_STS_2                                      0xD20208
+
+#define mmNIC1_QM0_CQ_CTL_STS_3                                      0xD2020C
+
+#define mmNIC1_QM0_CQ_CTL_STS_4                                      0xD20210
+
+#define mmNIC1_QM0_CQ_IFIFO_CNT_0                                    0xD20214
+
+#define mmNIC1_QM0_CQ_IFIFO_CNT_1                                    0xD20218
+
+#define mmNIC1_QM0_CQ_IFIFO_CNT_2                                    0xD2021C
+
+#define mmNIC1_QM0_CQ_IFIFO_CNT_3                                    0xD20220
+
+#define mmNIC1_QM0_CQ_IFIFO_CNT_4                                    0xD20224
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_LO_0                            0xD20228
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_LO_1                            0xD2022C
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_LO_2                            0xD20230
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_LO_3                            0xD20234
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_LO_4                            0xD20238
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_HI_0                            0xD2023C
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_HI_1                            0xD20240
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_HI_2                            0xD20244
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_HI_3                            0xD20248
+
+#define mmNIC1_QM0_CP_MSG_BASE0_ADDR_HI_4                            0xD2024C
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_LO_0                            0xD20250
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_LO_1                            0xD20254
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_LO_2                            0xD20258
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_LO_3                            0xD2025C
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_LO_4                            0xD20260
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_HI_0                            0xD20264
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_HI_1                            0xD20268
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_HI_2                            0xD2026C
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_HI_3                            0xD20270
+
+#define mmNIC1_QM0_CP_MSG_BASE1_ADDR_HI_4                            0xD20274
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_LO_0                            0xD20278
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_LO_1                            0xD2027C
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_LO_2                            0xD20280
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_LO_3                            0xD20284
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_LO_4                            0xD20288
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_HI_0                            0xD2028C
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_HI_1                            0xD20290
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_HI_2                            0xD20294
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_HI_3                            0xD20298
+
+#define mmNIC1_QM0_CP_MSG_BASE2_ADDR_HI_4                            0xD2029C
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_LO_0                            0xD202A0
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_LO_1                            0xD202A4
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_LO_2                            0xD202A8
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_LO_3                            0xD202AC
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_LO_4                            0xD202B0
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_HI_0                            0xD202B4
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_HI_1                            0xD202B8
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_HI_2                            0xD202BC
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_HI_3                            0xD202C0
+
+#define mmNIC1_QM0_CP_MSG_BASE3_ADDR_HI_4                            0xD202C4
+
+#define mmNIC1_QM0_CP_LDMA_TSIZE_OFFSET_0                            0xD202C8
+
+#define mmNIC1_QM0_CP_LDMA_TSIZE_OFFSET_1                            0xD202CC
+
+#define mmNIC1_QM0_CP_LDMA_TSIZE_OFFSET_2                            0xD202D0
+
+#define mmNIC1_QM0_CP_LDMA_TSIZE_OFFSET_3                            0xD202D4
+
+#define mmNIC1_QM0_CP_LDMA_TSIZE_OFFSET_4                            0xD202D8
+
+#define mmNIC1_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xD202E0
+
+#define mmNIC1_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xD202E4
+
+#define mmNIC1_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xD202E8
+
+#define mmNIC1_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xD202EC
+
+#define mmNIC1_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xD202F0
+
+#define mmNIC1_QM0_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xD202F4
+
+#define mmNIC1_QM0_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xD202F8
+
+#define mmNIC1_QM0_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xD202FC
+
+#define mmNIC1_QM0_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xD20300
+
+#define mmNIC1_QM0_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xD20304
+
+#define mmNIC1_QM0_CP_FENCE0_RDATA_0                                 0xD20308
+
+#define mmNIC1_QM0_CP_FENCE0_RDATA_1                                 0xD2030C
+
+#define mmNIC1_QM0_CP_FENCE0_RDATA_2                                 0xD20310
+
+#define mmNIC1_QM0_CP_FENCE0_RDATA_3                                 0xD20314
+
+#define mmNIC1_QM0_CP_FENCE0_RDATA_4                                 0xD20318
+
+#define mmNIC1_QM0_CP_FENCE1_RDATA_0                                 0xD2031C
+
+#define mmNIC1_QM0_CP_FENCE1_RDATA_1                                 0xD20320
+
+#define mmNIC1_QM0_CP_FENCE1_RDATA_2                                 0xD20324
+
+#define mmNIC1_QM0_CP_FENCE1_RDATA_3                                 0xD20328
+
+#define mmNIC1_QM0_CP_FENCE1_RDATA_4                                 0xD2032C
+
+#define mmNIC1_QM0_CP_FENCE2_RDATA_0                                 0xD20330
+
+#define mmNIC1_QM0_CP_FENCE2_RDATA_1                                 0xD20334
+
+#define mmNIC1_QM0_CP_FENCE2_RDATA_2                                 0xD20338
+
+#define mmNIC1_QM0_CP_FENCE2_RDATA_3                                 0xD2033C
+
+#define mmNIC1_QM0_CP_FENCE2_RDATA_4                                 0xD20340
+
+#define mmNIC1_QM0_CP_FENCE3_RDATA_0                                 0xD20344
+
+#define mmNIC1_QM0_CP_FENCE3_RDATA_1                                 0xD20348
+
+#define mmNIC1_QM0_CP_FENCE3_RDATA_2                                 0xD2034C
+
+#define mmNIC1_QM0_CP_FENCE3_RDATA_3                                 0xD20350
+
+#define mmNIC1_QM0_CP_FENCE3_RDATA_4                                 0xD20354
+
+#define mmNIC1_QM0_CP_FENCE0_CNT_0                                   0xD20358
+
+#define mmNIC1_QM0_CP_FENCE0_CNT_1                                   0xD2035C
+
+#define mmNIC1_QM0_CP_FENCE0_CNT_2                                   0xD20360
+
+#define mmNIC1_QM0_CP_FENCE0_CNT_3                                   0xD20364
+
+#define mmNIC1_QM0_CP_FENCE0_CNT_4                                   0xD20368
+
+#define mmNIC1_QM0_CP_FENCE1_CNT_0                                   0xD2036C
+
+#define mmNIC1_QM0_CP_FENCE1_CNT_1                                   0xD20370
+
+#define mmNIC1_QM0_CP_FENCE1_CNT_2                                   0xD20374
+
+#define mmNIC1_QM0_CP_FENCE1_CNT_3                                   0xD20378
+
+#define mmNIC1_QM0_CP_FENCE1_CNT_4                                   0xD2037C
+
+#define mmNIC1_QM0_CP_FENCE2_CNT_0                                   0xD20380
+
+#define mmNIC1_QM0_CP_FENCE2_CNT_1                                   0xD20384
+
+#define mmNIC1_QM0_CP_FENCE2_CNT_2                                   0xD20388
+
+#define mmNIC1_QM0_CP_FENCE2_CNT_3                                   0xD2038C
+
+#define mmNIC1_QM0_CP_FENCE2_CNT_4                                   0xD20390
+
+#define mmNIC1_QM0_CP_FENCE3_CNT_0                                   0xD20394
+
+#define mmNIC1_QM0_CP_FENCE3_CNT_1                                   0xD20398
+
+#define mmNIC1_QM0_CP_FENCE3_CNT_2                                   0xD2039C
+
+#define mmNIC1_QM0_CP_FENCE3_CNT_3                                   0xD203A0
+
+#define mmNIC1_QM0_CP_FENCE3_CNT_4                                   0xD203A4
+
+#define mmNIC1_QM0_CP_STS_0                                          0xD203A8
+
+#define mmNIC1_QM0_CP_STS_1                                          0xD203AC
+
+#define mmNIC1_QM0_CP_STS_2                                          0xD203B0
+
+#define mmNIC1_QM0_CP_STS_3                                          0xD203B4
+
+#define mmNIC1_QM0_CP_STS_4                                          0xD203B8
+
+#define mmNIC1_QM0_CP_CURRENT_INST_LO_0                              0xD203BC
+
+#define mmNIC1_QM0_CP_CURRENT_INST_LO_1                              0xD203C0
+
+#define mmNIC1_QM0_CP_CURRENT_INST_LO_2                              0xD203C4
+
+#define mmNIC1_QM0_CP_CURRENT_INST_LO_3                              0xD203C8
+
+#define mmNIC1_QM0_CP_CURRENT_INST_LO_4                              0xD203CC
+
+#define mmNIC1_QM0_CP_CURRENT_INST_HI_0                              0xD203D0
+
+#define mmNIC1_QM0_CP_CURRENT_INST_HI_1                              0xD203D4
+
+#define mmNIC1_QM0_CP_CURRENT_INST_HI_2                              0xD203D8
+
+#define mmNIC1_QM0_CP_CURRENT_INST_HI_3                              0xD203DC
+
+#define mmNIC1_QM0_CP_CURRENT_INST_HI_4                              0xD203E0
+
+#define mmNIC1_QM0_CP_BARRIER_CFG_0                                  0xD203F4
+
+#define mmNIC1_QM0_CP_BARRIER_CFG_1                                  0xD203F8
+
+#define mmNIC1_QM0_CP_BARRIER_CFG_2                                  0xD203FC
+
+#define mmNIC1_QM0_CP_BARRIER_CFG_3                                  0xD20400
+
+#define mmNIC1_QM0_CP_BARRIER_CFG_4                                  0xD20404
+
+#define mmNIC1_QM0_CP_DBG_0_0                                        0xD20408
+
+#define mmNIC1_QM0_CP_DBG_0_1                                        0xD2040C
+
+#define mmNIC1_QM0_CP_DBG_0_2                                        0xD20410
+
+#define mmNIC1_QM0_CP_DBG_0_3                                        0xD20414
+
+#define mmNIC1_QM0_CP_DBG_0_4                                        0xD20418
+
+#define mmNIC1_QM0_CP_ARUSER_31_11_0                                 0xD2041C
+
+#define mmNIC1_QM0_CP_ARUSER_31_11_1                                 0xD20420
+
+#define mmNIC1_QM0_CP_ARUSER_31_11_2                                 0xD20424
+
+#define mmNIC1_QM0_CP_ARUSER_31_11_3                                 0xD20428
+
+#define mmNIC1_QM0_CP_ARUSER_31_11_4                                 0xD2042C
+
+#define mmNIC1_QM0_CP_AWUSER_31_11_0                                 0xD20430
+
+#define mmNIC1_QM0_CP_AWUSER_31_11_1                                 0xD20434
+
+#define mmNIC1_QM0_CP_AWUSER_31_11_2                                 0xD20438
+
+#define mmNIC1_QM0_CP_AWUSER_31_11_3                                 0xD2043C
+
+#define mmNIC1_QM0_CP_AWUSER_31_11_4                                 0xD20440
+
+#define mmNIC1_QM0_ARB_CFG_0                                         0xD20A00
+
+#define mmNIC1_QM0_ARB_CHOISE_Q_PUSH                                 0xD20A04
+
+#define mmNIC1_QM0_ARB_WRR_WEIGHT_0                                  0xD20A08
+
+#define mmNIC1_QM0_ARB_WRR_WEIGHT_1                                  0xD20A0C
+
+#define mmNIC1_QM0_ARB_WRR_WEIGHT_2                                  0xD20A10
+
+#define mmNIC1_QM0_ARB_WRR_WEIGHT_3                                  0xD20A14
+
+#define mmNIC1_QM0_ARB_CFG_1                                         0xD20A18
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_0                              0xD20A20
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_1                              0xD20A24
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_2                              0xD20A28
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_3                              0xD20A2C
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_4                              0xD20A30
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_5                              0xD20A34
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_6                              0xD20A38
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_7                              0xD20A3C
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_8                              0xD20A40
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_9                              0xD20A44
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_10                             0xD20A48
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_11                             0xD20A4C
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_12                             0xD20A50
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_13                             0xD20A54
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_14                             0xD20A58
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_15                             0xD20A5C
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_16                             0xD20A60
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_17                             0xD20A64
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_18                             0xD20A68
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_19                             0xD20A6C
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_20                             0xD20A70
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_21                             0xD20A74
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_22                             0xD20A78
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_23                             0xD20A7C
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_24                             0xD20A80
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_25                             0xD20A84
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_26                             0xD20A88
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_27                             0xD20A8C
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_28                             0xD20A90
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_29                             0xD20A94
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_30                             0xD20A98
+
+#define mmNIC1_QM0_ARB_MST_AVAIL_CRED_31                             0xD20A9C
+
+#define mmNIC1_QM0_ARB_MST_CRED_INC                                  0xD20AA0
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_0                        0xD20AA4
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_1                        0xD20AA8
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_2                        0xD20AAC
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_3                        0xD20AB0
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_4                        0xD20AB4
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_5                        0xD20AB8
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_6                        0xD20ABC
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_7                        0xD20AC0
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_8                        0xD20AC4
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_9                        0xD20AC8
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_10                       0xD20ACC
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_11                       0xD20AD0
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_12                       0xD20AD4
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_13                       0xD20AD8
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_14                       0xD20ADC
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_15                       0xD20AE0
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_16                       0xD20AE4
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_17                       0xD20AE8
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_18                       0xD20AEC
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_19                       0xD20AF0
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_20                       0xD20AF4
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_21                       0xD20AF8
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_22                       0xD20AFC
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_23                       0xD20B00
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_24                       0xD20B04
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_25                       0xD20B08
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_26                       0xD20B0C
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_27                       0xD20B10
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_28                       0xD20B14
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_29                       0xD20B18
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_30                       0xD20B1C
+
+#define mmNIC1_QM0_ARB_MST_CHOISE_PUSH_OFST_31                       0xD20B20
+
+#define mmNIC1_QM0_ARB_SLV_MASTER_INC_CRED_OFST                      0xD20B28
+
+#define mmNIC1_QM0_ARB_MST_SLAVE_EN                                  0xD20B2C
+
+#define mmNIC1_QM0_ARB_MST_QUIET_PER                                 0xD20B34
+
+#define mmNIC1_QM0_ARB_SLV_CHOISE_WDT                                0xD20B38
+
+#define mmNIC1_QM0_ARB_SLV_ID                                        0xD20B3C
+
+#define mmNIC1_QM0_ARB_MSG_MAX_INFLIGHT                              0xD20B44
+
+#define mmNIC1_QM0_ARB_MSG_AWUSER_31_11                              0xD20B48
+
+#define mmNIC1_QM0_ARB_MSG_AWUSER_SEC_PROP                           0xD20B4C
+
+#define mmNIC1_QM0_ARB_MSG_AWUSER_NON_SEC_PROP                       0xD20B50
+
+#define mmNIC1_QM0_ARB_BASE_LO                                       0xD20B54
+
+#define mmNIC1_QM0_ARB_BASE_HI                                       0xD20B58
+
+#define mmNIC1_QM0_ARB_STATE_STS                                     0xD20B80
+
+#define mmNIC1_QM0_ARB_CHOISE_FULLNESS_STS                           0xD20B84
+
+#define mmNIC1_QM0_ARB_MSG_STS                                       0xD20B88
+
+#define mmNIC1_QM0_ARB_SLV_CHOISE_Q_HEAD                             0xD20B8C
+
+#define mmNIC1_QM0_ARB_ERR_CAUSE                                     0xD20B9C
+
+#define mmNIC1_QM0_ARB_ERR_MSG_EN                                    0xD20BA0
+
+#define mmNIC1_QM0_ARB_ERR_STS_DRP                                   0xD20BA8
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_0                                0xD20BB0
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_1                                0xD20BB4
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_2                                0xD20BB8
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_3                                0xD20BBC
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_4                                0xD20BC0
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_5                                0xD20BC4
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_6                                0xD20BC8
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_7                                0xD20BCC
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_8                                0xD20BD0
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_9                                0xD20BD4
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_10                               0xD20BD8
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_11                               0xD20BDC
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_12                               0xD20BE0
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_13                               0xD20BE4
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_14                               0xD20BE8
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_15                               0xD20BEC
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_16                               0xD20BF0
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_17                               0xD20BF4
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_18                               0xD20BF8
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_19                               0xD20BFC
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_20                               0xD20C00
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_21                               0xD20C04
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_22                               0xD20C08
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_23                               0xD20C0C
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_24                               0xD20C10
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_25                               0xD20C14
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_26                               0xD20C18
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_27                               0xD20C1C
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_28                               0xD20C20
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_29                               0xD20C24
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_30                               0xD20C28
+
+#define mmNIC1_QM0_ARB_MST_CRED_STS_31                               0xD20C2C
+
+#define mmNIC1_QM0_CGM_CFG                                           0xD20C70
+
+#define mmNIC1_QM0_CGM_STS                                           0xD20C74
+
+#define mmNIC1_QM0_CGM_CFG1                                          0xD20C78
+
+#define mmNIC1_QM0_LOCAL_RANGE_BASE                                  0xD20C80
+
+#define mmNIC1_QM0_LOCAL_RANGE_SIZE                                  0xD20C84
+
+#define mmNIC1_QM0_CSMR_STRICT_PRIO_CFG                              0xD20C90
+
+#define mmNIC1_QM0_HBW_RD_RATE_LIM_CFG_1                             0xD20C94
+
+#define mmNIC1_QM0_LBW_WR_RATE_LIM_CFG_0                             0xD20C98
+
+#define mmNIC1_QM0_LBW_WR_RATE_LIM_CFG_1                             0xD20C9C
+
+#define mmNIC1_QM0_HBW_RD_RATE_LIM_CFG_0                             0xD20CA0
+
+#define mmNIC1_QM0_GLBL_AXCACHE                                      0xD20CA4
+
+#define mmNIC1_QM0_IND_GW_APB_CFG                                    0xD20CB0
+
+#define mmNIC1_QM0_IND_GW_APB_WDATA                                  0xD20CB4
+
+#define mmNIC1_QM0_IND_GW_APB_RDATA                                  0xD20CB8
+
+#define mmNIC1_QM0_IND_GW_APB_STATUS                                 0xD20CBC
+
+#define mmNIC1_QM0_GLBL_ERR_ADDR_LO                                  0xD20CD0
+
+#define mmNIC1_QM0_GLBL_ERR_ADDR_HI                                  0xD20CD4
+
+#define mmNIC1_QM0_GLBL_ERR_WDATA                                    0xD20CD8
+
+#define mmNIC1_QM0_GLBL_MEM_INIT_BUSY                                0xD20D00
+
+#endif /* ASIC_REG_NIC1_QM0_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm1_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm1_regs.h
new file mode 100644
index 000000000000..1b115ee6d6f0
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm1_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC1_QM1_REGS_H_
+#define ASIC_REG_NIC1_QM1_REGS_H_
+
+/*
+ *****************************************
+ *   NIC1_QM1 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC1_QM1_GLBL_CFG0                                         0xD22000
+
+#define mmNIC1_QM1_GLBL_CFG1                                         0xD22004
+
+#define mmNIC1_QM1_GLBL_PROT                                         0xD22008
+
+#define mmNIC1_QM1_GLBL_ERR_CFG                                      0xD2200C
+
+#define mmNIC1_QM1_GLBL_SECURE_PROPS_0                               0xD22010
+
+#define mmNIC1_QM1_GLBL_SECURE_PROPS_1                               0xD22014
+
+#define mmNIC1_QM1_GLBL_SECURE_PROPS_2                               0xD22018
+
+#define mmNIC1_QM1_GLBL_SECURE_PROPS_3                               0xD2201C
+
+#define mmNIC1_QM1_GLBL_SECURE_PROPS_4                               0xD22020
+
+#define mmNIC1_QM1_GLBL_NON_SECURE_PROPS_0                           0xD22024
+
+#define mmNIC1_QM1_GLBL_NON_SECURE_PROPS_1                           0xD22028
+
+#define mmNIC1_QM1_GLBL_NON_SECURE_PROPS_2                           0xD2202C
+
+#define mmNIC1_QM1_GLBL_NON_SECURE_PROPS_3                           0xD22030
+
+#define mmNIC1_QM1_GLBL_NON_SECURE_PROPS_4                           0xD22034
+
+#define mmNIC1_QM1_GLBL_STS0                                         0xD22038
+
+#define mmNIC1_QM1_GLBL_STS1_0                                       0xD22040
+
+#define mmNIC1_QM1_GLBL_STS1_1                                       0xD22044
+
+#define mmNIC1_QM1_GLBL_STS1_2                                       0xD22048
+
+#define mmNIC1_QM1_GLBL_STS1_3                                       0xD2204C
+
+#define mmNIC1_QM1_GLBL_STS1_4                                       0xD22050
+
+#define mmNIC1_QM1_GLBL_MSG_EN_0                                     0xD22054
+
+#define mmNIC1_QM1_GLBL_MSG_EN_1                                     0xD22058
+
+#define mmNIC1_QM1_GLBL_MSG_EN_2                                     0xD2205C
+
+#define mmNIC1_QM1_GLBL_MSG_EN_3                                     0xD22060
+
+#define mmNIC1_QM1_GLBL_MSG_EN_4                                     0xD22068
+
+#define mmNIC1_QM1_PQ_BASE_LO_0                                      0xD22070
+
+#define mmNIC1_QM1_PQ_BASE_LO_1                                      0xD22074
+
+#define mmNIC1_QM1_PQ_BASE_LO_2                                      0xD22078
+
+#define mmNIC1_QM1_PQ_BASE_LO_3                                      0xD2207C
+
+#define mmNIC1_QM1_PQ_BASE_HI_0                                      0xD22080
+
+#define mmNIC1_QM1_PQ_BASE_HI_1                                      0xD22084
+
+#define mmNIC1_QM1_PQ_BASE_HI_2                                      0xD22088
+
+#define mmNIC1_QM1_PQ_BASE_HI_3                                      0xD2208C
+
+#define mmNIC1_QM1_PQ_SIZE_0                                         0xD22090
+
+#define mmNIC1_QM1_PQ_SIZE_1                                         0xD22094
+
+#define mmNIC1_QM1_PQ_SIZE_2                                         0xD22098
+
+#define mmNIC1_QM1_PQ_SIZE_3                                         0xD2209C
+
+#define mmNIC1_QM1_PQ_PI_0                                           0xD220A0
+
+#define mmNIC1_QM1_PQ_PI_1                                           0xD220A4
+
+#define mmNIC1_QM1_PQ_PI_2                                           0xD220A8
+
+#define mmNIC1_QM1_PQ_PI_3                                           0xD220AC
+
+#define mmNIC1_QM1_PQ_CI_0                                           0xD220B0
+
+#define mmNIC1_QM1_PQ_CI_1                                           0xD220B4
+
+#define mmNIC1_QM1_PQ_CI_2                                           0xD220B8
+
+#define mmNIC1_QM1_PQ_CI_3                                           0xD220BC
+
+#define mmNIC1_QM1_PQ_CFG0_0                                         0xD220C0
+
+#define mmNIC1_QM1_PQ_CFG0_1                                         0xD220C4
+
+#define mmNIC1_QM1_PQ_CFG0_2                                         0xD220C8
+
+#define mmNIC1_QM1_PQ_CFG0_3                                         0xD220CC
+
+#define mmNIC1_QM1_PQ_CFG1_0                                         0xD220D0
+
+#define mmNIC1_QM1_PQ_CFG1_1                                         0xD220D4
+
+#define mmNIC1_QM1_PQ_CFG1_2                                         0xD220D8
+
+#define mmNIC1_QM1_PQ_CFG1_3                                         0xD220DC
+
+#define mmNIC1_QM1_PQ_ARUSER_31_11_0                                 0xD220E0
+
+#define mmNIC1_QM1_PQ_ARUSER_31_11_1                                 0xD220E4
+
+#define mmNIC1_QM1_PQ_ARUSER_31_11_2                                 0xD220E8
+
+#define mmNIC1_QM1_PQ_ARUSER_31_11_3                                 0xD220EC
+
+#define mmNIC1_QM1_PQ_STS0_0                                         0xD220F0
+
+#define mmNIC1_QM1_PQ_STS0_1                                         0xD220F4
+
+#define mmNIC1_QM1_PQ_STS0_2                                         0xD220F8
+
+#define mmNIC1_QM1_PQ_STS0_3                                         0xD220FC
+
+#define mmNIC1_QM1_PQ_STS1_0                                         0xD22100
+
+#define mmNIC1_QM1_PQ_STS1_1                                         0xD22104
+
+#define mmNIC1_QM1_PQ_STS1_2                                         0xD22108
+
+#define mmNIC1_QM1_PQ_STS1_3                                         0xD2210C
+
+#define mmNIC1_QM1_CQ_CFG0_0                                         0xD22110
+
+#define mmNIC1_QM1_CQ_CFG0_1                                         0xD22114
+
+#define mmNIC1_QM1_CQ_CFG0_2                                         0xD22118
+
+#define mmNIC1_QM1_CQ_CFG0_3                                         0xD2211C
+
+#define mmNIC1_QM1_CQ_CFG0_4                                         0xD22120
+
+#define mmNIC1_QM1_CQ_CFG1_0                                         0xD22124
+
+#define mmNIC1_QM1_CQ_CFG1_1                                         0xD22128
+
+#define mmNIC1_QM1_CQ_CFG1_2                                         0xD2212C
+
+#define mmNIC1_QM1_CQ_CFG1_3                                         0xD22130
+
+#define mmNIC1_QM1_CQ_CFG1_4                                         0xD22134
+
+#define mmNIC1_QM1_CQ_ARUSER_31_11_0                                 0xD22138
+
+#define mmNIC1_QM1_CQ_ARUSER_31_11_1                                 0xD2213C
+
+#define mmNIC1_QM1_CQ_ARUSER_31_11_2                                 0xD22140
+
+#define mmNIC1_QM1_CQ_ARUSER_31_11_3                                 0xD22144
+
+#define mmNIC1_QM1_CQ_ARUSER_31_11_4                                 0xD22148
+
+#define mmNIC1_QM1_CQ_STS0_0                                         0xD2214C
+
+#define mmNIC1_QM1_CQ_STS0_1                                         0xD22150
+
+#define mmNIC1_QM1_CQ_STS0_2                                         0xD22154
+
+#define mmNIC1_QM1_CQ_STS0_3                                         0xD22158
+
+#define mmNIC1_QM1_CQ_STS0_4                                         0xD2215C
+
+#define mmNIC1_QM1_CQ_STS1_0                                         0xD22160
+
+#define mmNIC1_QM1_CQ_STS1_1                                         0xD22164
+
+#define mmNIC1_QM1_CQ_STS1_2                                         0xD22168
+
+#define mmNIC1_QM1_CQ_STS1_3                                         0xD2216C
+
+#define mmNIC1_QM1_CQ_STS1_4                                         0xD22170
+
+#define mmNIC1_QM1_CQ_PTR_LO_0                                       0xD22174
+
+#define mmNIC1_QM1_CQ_PTR_HI_0                                       0xD22178
+
+#define mmNIC1_QM1_CQ_TSIZE_0                                        0xD2217C
+
+#define mmNIC1_QM1_CQ_CTL_0                                          0xD22180
+
+#define mmNIC1_QM1_CQ_PTR_LO_1                                       0xD22184
+
+#define mmNIC1_QM1_CQ_PTR_HI_1                                       0xD22188
+
+#define mmNIC1_QM1_CQ_TSIZE_1                                        0xD2218C
+
+#define mmNIC1_QM1_CQ_CTL_1                                          0xD22190
+
+#define mmNIC1_QM1_CQ_PTR_LO_2                                       0xD22194
+
+#define mmNIC1_QM1_CQ_PTR_HI_2                                       0xD22198
+
+#define mmNIC1_QM1_CQ_TSIZE_2                                        0xD2219C
+
+#define mmNIC1_QM1_CQ_CTL_2                                          0xD221A0
+
+#define mmNIC1_QM1_CQ_PTR_LO_3                                       0xD221A4
+
+#define mmNIC1_QM1_CQ_PTR_HI_3                                       0xD221A8
+
+#define mmNIC1_QM1_CQ_TSIZE_3                                        0xD221AC
+
+#define mmNIC1_QM1_CQ_CTL_3                                          0xD221B0
+
+#define mmNIC1_QM1_CQ_PTR_LO_4                                       0xD221B4
+
+#define mmNIC1_QM1_CQ_PTR_HI_4                                       0xD221B8
+
+#define mmNIC1_QM1_CQ_TSIZE_4                                        0xD221BC
+
+#define mmNIC1_QM1_CQ_CTL_4                                          0xD221C0
+
+#define mmNIC1_QM1_CQ_PTR_LO_STS_0                                   0xD221C4
+
+#define mmNIC1_QM1_CQ_PTR_LO_STS_1                                   0xD221C8
+
+#define mmNIC1_QM1_CQ_PTR_LO_STS_2                                   0xD221CC
+
+#define mmNIC1_QM1_CQ_PTR_LO_STS_3                                   0xD221D0
+
+#define mmNIC1_QM1_CQ_PTR_LO_STS_4                                   0xD221D4
+
+#define mmNIC1_QM1_CQ_PTR_HI_STS_0                                   0xD221D8
+
+#define mmNIC1_QM1_CQ_PTR_HI_STS_1                                   0xD221DC
+
+#define mmNIC1_QM1_CQ_PTR_HI_STS_2                                   0xD221E0
+
+#define mmNIC1_QM1_CQ_PTR_HI_STS_3                                   0xD221E4
+
+#define mmNIC1_QM1_CQ_PTR_HI_STS_4                                   0xD221E8
+
+#define mmNIC1_QM1_CQ_TSIZE_STS_0                                    0xD221EC
+
+#define mmNIC1_QM1_CQ_TSIZE_STS_1                                    0xD221F0
+
+#define mmNIC1_QM1_CQ_TSIZE_STS_2                                    0xD221F4
+
+#define mmNIC1_QM1_CQ_TSIZE_STS_3                                    0xD221F8
+
+#define mmNIC1_QM1_CQ_TSIZE_STS_4                                    0xD221FC
+
+#define mmNIC1_QM1_CQ_CTL_STS_0                                      0xD22200
+
+#define mmNIC1_QM1_CQ_CTL_STS_1                                      0xD22204
+
+#define mmNIC1_QM1_CQ_CTL_STS_2                                      0xD22208
+
+#define mmNIC1_QM1_CQ_CTL_STS_3                                      0xD2220C
+
+#define mmNIC1_QM1_CQ_CTL_STS_4                                      0xD22210
+
+#define mmNIC1_QM1_CQ_IFIFO_CNT_0                                    0xD22214
+
+#define mmNIC1_QM1_CQ_IFIFO_CNT_1                                    0xD22218
+
+#define mmNIC1_QM1_CQ_IFIFO_CNT_2                                    0xD2221C
+
+#define mmNIC1_QM1_CQ_IFIFO_CNT_3                                    0xD22220
+
+#define mmNIC1_QM1_CQ_IFIFO_CNT_4                                    0xD22224
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_LO_0                            0xD22228
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_LO_1                            0xD2222C
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_LO_2                            0xD22230
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_LO_3                            0xD22234
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_LO_4                            0xD22238
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_HI_0                            0xD2223C
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_HI_1                            0xD22240
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_HI_2                            0xD22244
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_HI_3                            0xD22248
+
+#define mmNIC1_QM1_CP_MSG_BASE0_ADDR_HI_4                            0xD2224C
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_LO_0                            0xD22250
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_LO_1                            0xD22254
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_LO_2                            0xD22258
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_LO_3                            0xD2225C
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_LO_4                            0xD22260
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_HI_0                            0xD22264
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_HI_1                            0xD22268
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_HI_2                            0xD2226C
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_HI_3                            0xD22270
+
+#define mmNIC1_QM1_CP_MSG_BASE1_ADDR_HI_4                            0xD22274
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_LO_0                            0xD22278
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_LO_1                            0xD2227C
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_LO_2                            0xD22280
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_LO_3                            0xD22284
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_LO_4                            0xD22288
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_HI_0                            0xD2228C
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_HI_1                            0xD22290
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_HI_2                            0xD22294
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_HI_3                            0xD22298
+
+#define mmNIC1_QM1_CP_MSG_BASE2_ADDR_HI_4                            0xD2229C
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_LO_0                            0xD222A0
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_LO_1                            0xD222A4
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_LO_2                            0xD222A8
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_LO_3                            0xD222AC
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_LO_4                            0xD222B0
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_HI_0                            0xD222B4
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_HI_1                            0xD222B8
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_HI_2                            0xD222BC
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_HI_3                            0xD222C0
+
+#define mmNIC1_QM1_CP_MSG_BASE3_ADDR_HI_4                            0xD222C4
+
+#define mmNIC1_QM1_CP_LDMA_TSIZE_OFFSET_0                            0xD222C8
+
+#define mmNIC1_QM1_CP_LDMA_TSIZE_OFFSET_1                            0xD222CC
+
+#define mmNIC1_QM1_CP_LDMA_TSIZE_OFFSET_2                            0xD222D0
+
+#define mmNIC1_QM1_CP_LDMA_TSIZE_OFFSET_3                            0xD222D4
+
+#define mmNIC1_QM1_CP_LDMA_TSIZE_OFFSET_4                            0xD222D8
+
+#define mmNIC1_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xD222E0
+
+#define mmNIC1_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xD222E4
+
+#define mmNIC1_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xD222E8
+
+#define mmNIC1_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xD222EC
+
+#define mmNIC1_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xD222F0
+
+#define mmNIC1_QM1_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xD222F4
+
+#define mmNIC1_QM1_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xD222F8
+
+#define mmNIC1_QM1_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xD222FC
+
+#define mmNIC1_QM1_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xD22300
+
+#define mmNIC1_QM1_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xD22304
+
+#define mmNIC1_QM1_CP_FENCE0_RDATA_0                                 0xD22308
+
+#define mmNIC1_QM1_CP_FENCE0_RDATA_1                                 0xD2230C
+
+#define mmNIC1_QM1_CP_FENCE0_RDATA_2                                 0xD22310
+
+#define mmNIC1_QM1_CP_FENCE0_RDATA_3                                 0xD22314
+
+#define mmNIC1_QM1_CP_FENCE0_RDATA_4                                 0xD22318
+
+#define mmNIC1_QM1_CP_FENCE1_RDATA_0                                 0xD2231C
+
+#define mmNIC1_QM1_CP_FENCE1_RDATA_1                                 0xD22320
+
+#define mmNIC1_QM1_CP_FENCE1_RDATA_2                                 0xD22324
+
+#define mmNIC1_QM1_CP_FENCE1_RDATA_3                                 0xD22328
+
+#define mmNIC1_QM1_CP_FENCE1_RDATA_4                                 0xD2232C
+
+#define mmNIC1_QM1_CP_FENCE2_RDATA_0                                 0xD22330
+
+#define mmNIC1_QM1_CP_FENCE2_RDATA_1                                 0xD22334
+
+#define mmNIC1_QM1_CP_FENCE2_RDATA_2                                 0xD22338
+
+#define mmNIC1_QM1_CP_FENCE2_RDATA_3                                 0xD2233C
+
+#define mmNIC1_QM1_CP_FENCE2_RDATA_4                                 0xD22340
+
+#define mmNIC1_QM1_CP_FENCE3_RDATA_0                                 0xD22344
+
+#define mmNIC1_QM1_CP_FENCE3_RDATA_1                                 0xD22348
+
+#define mmNIC1_QM1_CP_FENCE3_RDATA_2                                 0xD2234C
+
+#define mmNIC1_QM1_CP_FENCE3_RDATA_3                                 0xD22350
+
+#define mmNIC1_QM1_CP_FENCE3_RDATA_4                                 0xD22354
+
+#define mmNIC1_QM1_CP_FENCE0_CNT_0                                   0xD22358
+
+#define mmNIC1_QM1_CP_FENCE0_CNT_1                                   0xD2235C
+
+#define mmNIC1_QM1_CP_FENCE0_CNT_2                                   0xD22360
+
+#define mmNIC1_QM1_CP_FENCE0_CNT_3                                   0xD22364
+
+#define mmNIC1_QM1_CP_FENCE0_CNT_4                                   0xD22368
+
+#define mmNIC1_QM1_CP_FENCE1_CNT_0                                   0xD2236C
+
+#define mmNIC1_QM1_CP_FENCE1_CNT_1                                   0xD22370
+
+#define mmNIC1_QM1_CP_FENCE1_CNT_2                                   0xD22374
+
+#define mmNIC1_QM1_CP_FENCE1_CNT_3                                   0xD22378
+
+#define mmNIC1_QM1_CP_FENCE1_CNT_4                                   0xD2237C
+
+#define mmNIC1_QM1_CP_FENCE2_CNT_0                                   0xD22380
+
+#define mmNIC1_QM1_CP_FENCE2_CNT_1                                   0xD22384
+
+#define mmNIC1_QM1_CP_FENCE2_CNT_2                                   0xD22388
+
+#define mmNIC1_QM1_CP_FENCE2_CNT_3                                   0xD2238C
+
+#define mmNIC1_QM1_CP_FENCE2_CNT_4                                   0xD22390
+
+#define mmNIC1_QM1_CP_FENCE3_CNT_0                                   0xD22394
+
+#define mmNIC1_QM1_CP_FENCE3_CNT_1                                   0xD22398
+
+#define mmNIC1_QM1_CP_FENCE3_CNT_2                                   0xD2239C
+
+#define mmNIC1_QM1_CP_FENCE3_CNT_3                                   0xD223A0
+
+#define mmNIC1_QM1_CP_FENCE3_CNT_4                                   0xD223A4
+
+#define mmNIC1_QM1_CP_STS_0                                          0xD223A8
+
+#define mmNIC1_QM1_CP_STS_1                                          0xD223AC
+
+#define mmNIC1_QM1_CP_STS_2                                          0xD223B0
+
+#define mmNIC1_QM1_CP_STS_3                                          0xD223B4
+
+#define mmNIC1_QM1_CP_STS_4                                          0xD223B8
+
+#define mmNIC1_QM1_CP_CURRENT_INST_LO_0                              0xD223BC
+
+#define mmNIC1_QM1_CP_CURRENT_INST_LO_1                              0xD223C0
+
+#define mmNIC1_QM1_CP_CURRENT_INST_LO_2                              0xD223C4
+
+#define mmNIC1_QM1_CP_CURRENT_INST_LO_3                              0xD223C8
+
+#define mmNIC1_QM1_CP_CURRENT_INST_LO_4                              0xD223CC
+
+#define mmNIC1_QM1_CP_CURRENT_INST_HI_0                              0xD223D0
+
+#define mmNIC1_QM1_CP_CURRENT_INST_HI_1                              0xD223D4
+
+#define mmNIC1_QM1_CP_CURRENT_INST_HI_2                              0xD223D8
+
+#define mmNIC1_QM1_CP_CURRENT_INST_HI_3                              0xD223DC
+
+#define mmNIC1_QM1_CP_CURRENT_INST_HI_4                              0xD223E0
+
+#define mmNIC1_QM1_CP_BARRIER_CFG_0                                  0xD223F4
+
+#define mmNIC1_QM1_CP_BARRIER_CFG_1                                  0xD223F8
+
+#define mmNIC1_QM1_CP_BARRIER_CFG_2                                  0xD223FC
+
+#define mmNIC1_QM1_CP_BARRIER_CFG_3                                  0xD22400
+
+#define mmNIC1_QM1_CP_BARRIER_CFG_4                                  0xD22404
+
+#define mmNIC1_QM1_CP_DBG_0_0                                        0xD22408
+
+#define mmNIC1_QM1_CP_DBG_0_1                                        0xD2240C
+
+#define mmNIC1_QM1_CP_DBG_0_2                                        0xD22410
+
+#define mmNIC1_QM1_CP_DBG_0_3                                        0xD22414
+
+#define mmNIC1_QM1_CP_DBG_0_4                                        0xD22418
+
+#define mmNIC1_QM1_CP_ARUSER_31_11_0                                 0xD2241C
+
+#define mmNIC1_QM1_CP_ARUSER_31_11_1                                 0xD22420
+
+#define mmNIC1_QM1_CP_ARUSER_31_11_2                                 0xD22424
+
+#define mmNIC1_QM1_CP_ARUSER_31_11_3                                 0xD22428
+
+#define mmNIC1_QM1_CP_ARUSER_31_11_4                                 0xD2242C
+
+#define mmNIC1_QM1_CP_AWUSER_31_11_0                                 0xD22430
+
+#define mmNIC1_QM1_CP_AWUSER_31_11_1                                 0xD22434
+
+#define mmNIC1_QM1_CP_AWUSER_31_11_2                                 0xD22438
+
+#define mmNIC1_QM1_CP_AWUSER_31_11_3                                 0xD2243C
+
+#define mmNIC1_QM1_CP_AWUSER_31_11_4                                 0xD22440
+
+#define mmNIC1_QM1_ARB_CFG_0                                         0xD22A00
+
+#define mmNIC1_QM1_ARB_CHOISE_Q_PUSH                                 0xD22A04
+
+#define mmNIC1_QM1_ARB_WRR_WEIGHT_0                                  0xD22A08
+
+#define mmNIC1_QM1_ARB_WRR_WEIGHT_1                                  0xD22A0C
+
+#define mmNIC1_QM1_ARB_WRR_WEIGHT_2                                  0xD22A10
+
+#define mmNIC1_QM1_ARB_WRR_WEIGHT_3                                  0xD22A14
+
+#define mmNIC1_QM1_ARB_CFG_1                                         0xD22A18
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_0                              0xD22A20
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_1                              0xD22A24
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_2                              0xD22A28
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_3                              0xD22A2C
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_4                              0xD22A30
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_5                              0xD22A34
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_6                              0xD22A38
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_7                              0xD22A3C
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_8                              0xD22A40
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_9                              0xD22A44
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_10                             0xD22A48
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_11                             0xD22A4C
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_12                             0xD22A50
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_13                             0xD22A54
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_14                             0xD22A58
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_15                             0xD22A5C
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_16                             0xD22A60
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_17                             0xD22A64
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_18                             0xD22A68
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_19                             0xD22A6C
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_20                             0xD22A70
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_21                             0xD22A74
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_22                             0xD22A78
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_23                             0xD22A7C
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_24                             0xD22A80
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_25                             0xD22A84
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_26                             0xD22A88
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_27                             0xD22A8C
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_28                             0xD22A90
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_29                             0xD22A94
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_30                             0xD22A98
+
+#define mmNIC1_QM1_ARB_MST_AVAIL_CRED_31                             0xD22A9C
+
+#define mmNIC1_QM1_ARB_MST_CRED_INC                                  0xD22AA0
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_0                        0xD22AA4
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_1                        0xD22AA8
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_2                        0xD22AAC
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_3                        0xD22AB0
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_4                        0xD22AB4
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_5                        0xD22AB8
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_6                        0xD22ABC
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_7                        0xD22AC0
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_8                        0xD22AC4
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_9                        0xD22AC8
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_10                       0xD22ACC
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_11                       0xD22AD0
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_12                       0xD22AD4
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_13                       0xD22AD8
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_14                       0xD22ADC
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_15                       0xD22AE0
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_16                       0xD22AE4
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_17                       0xD22AE8
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_18                       0xD22AEC
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_19                       0xD22AF0
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_20                       0xD22AF4
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_21                       0xD22AF8
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_22                       0xD22AFC
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_23                       0xD22B00
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_24                       0xD22B04
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_25                       0xD22B08
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_26                       0xD22B0C
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_27                       0xD22B10
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_28                       0xD22B14
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_29                       0xD22B18
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_30                       0xD22B1C
+
+#define mmNIC1_QM1_ARB_MST_CHOISE_PUSH_OFST_31                       0xD22B20
+
+#define mmNIC1_QM1_ARB_SLV_MASTER_INC_CRED_OFST                      0xD22B28
+
+#define mmNIC1_QM1_ARB_MST_SLAVE_EN                                  0xD22B2C
+
+#define mmNIC1_QM1_ARB_MST_QUIET_PER                                 0xD22B34
+
+#define mmNIC1_QM1_ARB_SLV_CHOISE_WDT                                0xD22B38
+
+#define mmNIC1_QM1_ARB_SLV_ID                                        0xD22B3C
+
+#define mmNIC1_QM1_ARB_MSG_MAX_INFLIGHT                              0xD22B44
+
+#define mmNIC1_QM1_ARB_MSG_AWUSER_31_11                              0xD22B48
+
+#define mmNIC1_QM1_ARB_MSG_AWUSER_SEC_PROP                           0xD22B4C
+
+#define mmNIC1_QM1_ARB_MSG_AWUSER_NON_SEC_PROP                       0xD22B50
+
+#define mmNIC1_QM1_ARB_BASE_LO                                       0xD22B54
+
+#define mmNIC1_QM1_ARB_BASE_HI                                       0xD22B58
+
+#define mmNIC1_QM1_ARB_STATE_STS                                     0xD22B80
+
+#define mmNIC1_QM1_ARB_CHOISE_FULLNESS_STS                           0xD22B84
+
+#define mmNIC1_QM1_ARB_MSG_STS                                       0xD22B88
+
+#define mmNIC1_QM1_ARB_SLV_CHOISE_Q_HEAD                             0xD22B8C
+
+#define mmNIC1_QM1_ARB_ERR_CAUSE                                     0xD22B9C
+
+#define mmNIC1_QM1_ARB_ERR_MSG_EN                                    0xD22BA0
+
+#define mmNIC1_QM1_ARB_ERR_STS_DRP                                   0xD22BA8
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_0                                0xD22BB0
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_1                                0xD22BB4
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_2                                0xD22BB8
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_3                                0xD22BBC
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_4                                0xD22BC0
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_5                                0xD22BC4
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_6                                0xD22BC8
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_7                                0xD22BCC
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_8                                0xD22BD0
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_9                                0xD22BD4
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_10                               0xD22BD8
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_11                               0xD22BDC
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_12                               0xD22BE0
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_13                               0xD22BE4
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_14                               0xD22BE8
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_15                               0xD22BEC
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_16                               0xD22BF0
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_17                               0xD22BF4
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_18                               0xD22BF8
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_19                               0xD22BFC
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_20                               0xD22C00
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_21                               0xD22C04
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_22                               0xD22C08
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_23                               0xD22C0C
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_24                               0xD22C10
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_25                               0xD22C14
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_26                               0xD22C18
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_27                               0xD22C1C
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_28                               0xD22C20
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_29                               0xD22C24
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_30                               0xD22C28
+
+#define mmNIC1_QM1_ARB_MST_CRED_STS_31                               0xD22C2C
+
+#define mmNIC1_QM1_CGM_CFG                                           0xD22C70
+
+#define mmNIC1_QM1_CGM_STS                                           0xD22C74
+
+#define mmNIC1_QM1_CGM_CFG1                                          0xD22C78
+
+#define mmNIC1_QM1_LOCAL_RANGE_BASE                                  0xD22C80
+
+#define mmNIC1_QM1_LOCAL_RANGE_SIZE                                  0xD22C84
+
+#define mmNIC1_QM1_CSMR_STRICT_PRIO_CFG                              0xD22C90
+
+#define mmNIC1_QM1_HBW_RD_RATE_LIM_CFG_1                             0xD22C94
+
+#define mmNIC1_QM1_LBW_WR_RATE_LIM_CFG_0                             0xD22C98
+
+#define mmNIC1_QM1_LBW_WR_RATE_LIM_CFG_1                             0xD22C9C
+
+#define mmNIC1_QM1_HBW_RD_RATE_LIM_CFG_0                             0xD22CA0
+
+#define mmNIC1_QM1_GLBL_AXCACHE                                      0xD22CA4
+
+#define mmNIC1_QM1_IND_GW_APB_CFG                                    0xD22CB0
+
+#define mmNIC1_QM1_IND_GW_APB_WDATA                                  0xD22CB4
+
+#define mmNIC1_QM1_IND_GW_APB_RDATA                                  0xD22CB8
+
+#define mmNIC1_QM1_IND_GW_APB_STATUS                                 0xD22CBC
+
+#define mmNIC1_QM1_GLBL_ERR_ADDR_LO                                  0xD22CD0
+
+#define mmNIC1_QM1_GLBL_ERR_ADDR_HI                                  0xD22CD4
+
+#define mmNIC1_QM1_GLBL_ERR_WDATA                                    0xD22CD8
+
+#define mmNIC1_QM1_GLBL_MEM_INIT_BUSY                                0xD22D00
+
+#endif /* ASIC_REG_NIC1_QM1_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm0_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm0_regs.h
new file mode 100644
index 000000000000..a89116a4586f
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm0_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC2_QM0_REGS_H_
+#define ASIC_REG_NIC2_QM0_REGS_H_
+
+/*
+ *****************************************
+ *   NIC2_QM0 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC2_QM0_GLBL_CFG0                                         0xD60000
+
+#define mmNIC2_QM0_GLBL_CFG1                                         0xD60004
+
+#define mmNIC2_QM0_GLBL_PROT                                         0xD60008
+
+#define mmNIC2_QM0_GLBL_ERR_CFG                                      0xD6000C
+
+#define mmNIC2_QM0_GLBL_SECURE_PROPS_0                               0xD60010
+
+#define mmNIC2_QM0_GLBL_SECURE_PROPS_1                               0xD60014
+
+#define mmNIC2_QM0_GLBL_SECURE_PROPS_2                               0xD60018
+
+#define mmNIC2_QM0_GLBL_SECURE_PROPS_3                               0xD6001C
+
+#define mmNIC2_QM0_GLBL_SECURE_PROPS_4                               0xD60020
+
+#define mmNIC2_QM0_GLBL_NON_SECURE_PROPS_0                           0xD60024
+
+#define mmNIC2_QM0_GLBL_NON_SECURE_PROPS_1                           0xD60028
+
+#define mmNIC2_QM0_GLBL_NON_SECURE_PROPS_2                           0xD6002C
+
+#define mmNIC2_QM0_GLBL_NON_SECURE_PROPS_3                           0xD60030
+
+#define mmNIC2_QM0_GLBL_NON_SECURE_PROPS_4                           0xD60034
+
+#define mmNIC2_QM0_GLBL_STS0                                         0xD60038
+
+#define mmNIC2_QM0_GLBL_STS1_0                                       0xD60040
+
+#define mmNIC2_QM0_GLBL_STS1_1                                       0xD60044
+
+#define mmNIC2_QM0_GLBL_STS1_2                                       0xD60048
+
+#define mmNIC2_QM0_GLBL_STS1_3                                       0xD6004C
+
+#define mmNIC2_QM0_GLBL_STS1_4                                       0xD60050
+
+#define mmNIC2_QM0_GLBL_MSG_EN_0                                     0xD60054
+
+#define mmNIC2_QM0_GLBL_MSG_EN_1                                     0xD60058
+
+#define mmNIC2_QM0_GLBL_MSG_EN_2                                     0xD6005C
+
+#define mmNIC2_QM0_GLBL_MSG_EN_3                                     0xD60060
+
+#define mmNIC2_QM0_GLBL_MSG_EN_4                                     0xD60068
+
+#define mmNIC2_QM0_PQ_BASE_LO_0                                      0xD60070
+
+#define mmNIC2_QM0_PQ_BASE_LO_1                                      0xD60074
+
+#define mmNIC2_QM0_PQ_BASE_LO_2                                      0xD60078
+
+#define mmNIC2_QM0_PQ_BASE_LO_3                                      0xD6007C
+
+#define mmNIC2_QM0_PQ_BASE_HI_0                                      0xD60080
+
+#define mmNIC2_QM0_PQ_BASE_HI_1                                      0xD60084
+
+#define mmNIC2_QM0_PQ_BASE_HI_2                                      0xD60088
+
+#define mmNIC2_QM0_PQ_BASE_HI_3                                      0xD6008C
+
+#define mmNIC2_QM0_PQ_SIZE_0                                         0xD60090
+
+#define mmNIC2_QM0_PQ_SIZE_1                                         0xD60094
+
+#define mmNIC2_QM0_PQ_SIZE_2                                         0xD60098
+
+#define mmNIC2_QM0_PQ_SIZE_3                                         0xD6009C
+
+#define mmNIC2_QM0_PQ_PI_0                                           0xD600A0
+
+#define mmNIC2_QM0_PQ_PI_1                                           0xD600A4
+
+#define mmNIC2_QM0_PQ_PI_2                                           0xD600A8
+
+#define mmNIC2_QM0_PQ_PI_3                                           0xD600AC
+
+#define mmNIC2_QM0_PQ_CI_0                                           0xD600B0
+
+#define mmNIC2_QM0_PQ_CI_1                                           0xD600B4
+
+#define mmNIC2_QM0_PQ_CI_2                                           0xD600B8
+
+#define mmNIC2_QM0_PQ_CI_3                                           0xD600BC
+
+#define mmNIC2_QM0_PQ_CFG0_0                                         0xD600C0
+
+#define mmNIC2_QM0_PQ_CFG0_1                                         0xD600C4
+
+#define mmNIC2_QM0_PQ_CFG0_2                                         0xD600C8
+
+#define mmNIC2_QM0_PQ_CFG0_3                                         0xD600CC
+
+#define mmNIC2_QM0_PQ_CFG1_0                                         0xD600D0
+
+#define mmNIC2_QM0_PQ_CFG1_1                                         0xD600D4
+
+#define mmNIC2_QM0_PQ_CFG1_2                                         0xD600D8
+
+#define mmNIC2_QM0_PQ_CFG1_3                                         0xD600DC
+
+#define mmNIC2_QM0_PQ_ARUSER_31_11_0                                 0xD600E0
+
+#define mmNIC2_QM0_PQ_ARUSER_31_11_1                                 0xD600E4
+
+#define mmNIC2_QM0_PQ_ARUSER_31_11_2                                 0xD600E8
+
+#define mmNIC2_QM0_PQ_ARUSER_31_11_3                                 0xD600EC
+
+#define mmNIC2_QM0_PQ_STS0_0                                         0xD600F0
+
+#define mmNIC2_QM0_PQ_STS0_1                                         0xD600F4
+
+#define mmNIC2_QM0_PQ_STS0_2                                         0xD600F8
+
+#define mmNIC2_QM0_PQ_STS0_3                                         0xD600FC
+
+#define mmNIC2_QM0_PQ_STS1_0                                         0xD60100
+
+#define mmNIC2_QM0_PQ_STS1_1                                         0xD60104
+
+#define mmNIC2_QM0_PQ_STS1_2                                         0xD60108
+
+#define mmNIC2_QM0_PQ_STS1_3                                         0xD6010C
+
+#define mmNIC2_QM0_CQ_CFG0_0                                         0xD60110
+
+#define mmNIC2_QM0_CQ_CFG0_1                                         0xD60114
+
+#define mmNIC2_QM0_CQ_CFG0_2                                         0xD60118
+
+#define mmNIC2_QM0_CQ_CFG0_3                                         0xD6011C
+
+#define mmNIC2_QM0_CQ_CFG0_4                                         0xD60120
+
+#define mmNIC2_QM0_CQ_CFG1_0                                         0xD60124
+
+#define mmNIC2_QM0_CQ_CFG1_1                                         0xD60128
+
+#define mmNIC2_QM0_CQ_CFG1_2                                         0xD6012C
+
+#define mmNIC2_QM0_CQ_CFG1_3                                         0xD60130
+
+#define mmNIC2_QM0_CQ_CFG1_4                                         0xD60134
+
+#define mmNIC2_QM0_CQ_ARUSER_31_11_0                                 0xD60138
+
+#define mmNIC2_QM0_CQ_ARUSER_31_11_1                                 0xD6013C
+
+#define mmNIC2_QM0_CQ_ARUSER_31_11_2                                 0xD60140
+
+#define mmNIC2_QM0_CQ_ARUSER_31_11_3                                 0xD60144
+
+#define mmNIC2_QM0_CQ_ARUSER_31_11_4                                 0xD60148
+
+#define mmNIC2_QM0_CQ_STS0_0                                         0xD6014C
+
+#define mmNIC2_QM0_CQ_STS0_1                                         0xD60150
+
+#define mmNIC2_QM0_CQ_STS0_2                                         0xD60154
+
+#define mmNIC2_QM0_CQ_STS0_3                                         0xD60158
+
+#define mmNIC2_QM0_CQ_STS0_4                                         0xD6015C
+
+#define mmNIC2_QM0_CQ_STS1_0                                         0xD60160
+
+#define mmNIC2_QM0_CQ_STS1_1                                         0xD60164
+
+#define mmNIC2_QM0_CQ_STS1_2                                         0xD60168
+
+#define mmNIC2_QM0_CQ_STS1_3                                         0xD6016C
+
+#define mmNIC2_QM0_CQ_STS1_4                                         0xD60170
+
+#define mmNIC2_QM0_CQ_PTR_LO_0                                       0xD60174
+
+#define mmNIC2_QM0_CQ_PTR_HI_0                                       0xD60178
+
+#define mmNIC2_QM0_CQ_TSIZE_0                                        0xD6017C
+
+#define mmNIC2_QM0_CQ_CTL_0                                          0xD60180
+
+#define mmNIC2_QM0_CQ_PTR_LO_1                                       0xD60184
+
+#define mmNIC2_QM0_CQ_PTR_HI_1                                       0xD60188
+
+#define mmNIC2_QM0_CQ_TSIZE_1                                        0xD6018C
+
+#define mmNIC2_QM0_CQ_CTL_1                                          0xD60190
+
+#define mmNIC2_QM0_CQ_PTR_LO_2                                       0xD60194
+
+#define mmNIC2_QM0_CQ_PTR_HI_2                                       0xD60198
+
+#define mmNIC2_QM0_CQ_TSIZE_2                                        0xD6019C
+
+#define mmNIC2_QM0_CQ_CTL_2                                          0xD601A0
+
+#define mmNIC2_QM0_CQ_PTR_LO_3                                       0xD601A4
+
+#define mmNIC2_QM0_CQ_PTR_HI_3                                       0xD601A8
+
+#define mmNIC2_QM0_CQ_TSIZE_3                                        0xD601AC
+
+#define mmNIC2_QM0_CQ_CTL_3                                          0xD601B0
+
+#define mmNIC2_QM0_CQ_PTR_LO_4                                       0xD601B4
+
+#define mmNIC2_QM0_CQ_PTR_HI_4                                       0xD601B8
+
+#define mmNIC2_QM0_CQ_TSIZE_4                                        0xD601BC
+
+#define mmNIC2_QM0_CQ_CTL_4                                          0xD601C0
+
+#define mmNIC2_QM0_CQ_PTR_LO_STS_0                                   0xD601C4
+
+#define mmNIC2_QM0_CQ_PTR_LO_STS_1                                   0xD601C8
+
+#define mmNIC2_QM0_CQ_PTR_LO_STS_2                                   0xD601CC
+
+#define mmNIC2_QM0_CQ_PTR_LO_STS_3                                   0xD601D0
+
+#define mmNIC2_QM0_CQ_PTR_LO_STS_4                                   0xD601D4
+
+#define mmNIC2_QM0_CQ_PTR_HI_STS_0                                   0xD601D8
+
+#define mmNIC2_QM0_CQ_PTR_HI_STS_1                                   0xD601DC
+
+#define mmNIC2_QM0_CQ_PTR_HI_STS_2                                   0xD601E0
+
+#define mmNIC2_QM0_CQ_PTR_HI_STS_3                                   0xD601E4
+
+#define mmNIC2_QM0_CQ_PTR_HI_STS_4                                   0xD601E8
+
+#define mmNIC2_QM0_CQ_TSIZE_STS_0                                    0xD601EC
+
+#define mmNIC2_QM0_CQ_TSIZE_STS_1                                    0xD601F0
+
+#define mmNIC2_QM0_CQ_TSIZE_STS_2                                    0xD601F4
+
+#define mmNIC2_QM0_CQ_TSIZE_STS_3                                    0xD601F8
+
+#define mmNIC2_QM0_CQ_TSIZE_STS_4                                    0xD601FC
+
+#define mmNIC2_QM0_CQ_CTL_STS_0                                      0xD60200
+
+#define mmNIC2_QM0_CQ_CTL_STS_1                                      0xD60204
+
+#define mmNIC2_QM0_CQ_CTL_STS_2                                      0xD60208
+
+#define mmNIC2_QM0_CQ_CTL_STS_3                                      0xD6020C
+
+#define mmNIC2_QM0_CQ_CTL_STS_4                                      0xD60210
+
+#define mmNIC2_QM0_CQ_IFIFO_CNT_0                                    0xD60214
+
+#define mmNIC2_QM0_CQ_IFIFO_CNT_1                                    0xD60218
+
+#define mmNIC2_QM0_CQ_IFIFO_CNT_2                                    0xD6021C
+
+#define mmNIC2_QM0_CQ_IFIFO_CNT_3                                    0xD60220
+
+#define mmNIC2_QM0_CQ_IFIFO_CNT_4                                    0xD60224
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_LO_0                            0xD60228
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_LO_1                            0xD6022C
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_LO_2                            0xD60230
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_LO_3                            0xD60234
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_LO_4                            0xD60238
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_HI_0                            0xD6023C
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_HI_1                            0xD60240
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_HI_2                            0xD60244
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_HI_3                            0xD60248
+
+#define mmNIC2_QM0_CP_MSG_BASE0_ADDR_HI_4                            0xD6024C
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_LO_0                            0xD60250
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_LO_1                            0xD60254
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_LO_2                            0xD60258
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_LO_3                            0xD6025C
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_LO_4                            0xD60260
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_HI_0                            0xD60264
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_HI_1                            0xD60268
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_HI_2                            0xD6026C
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_HI_3                            0xD60270
+
+#define mmNIC2_QM0_CP_MSG_BASE1_ADDR_HI_4                            0xD60274
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_LO_0                            0xD60278
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_LO_1                            0xD6027C
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_LO_2                            0xD60280
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_LO_3                            0xD60284
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_LO_4                            0xD60288
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_HI_0                            0xD6028C
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_HI_1                            0xD60290
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_HI_2                            0xD60294
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_HI_3                            0xD60298
+
+#define mmNIC2_QM0_CP_MSG_BASE2_ADDR_HI_4                            0xD6029C
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_LO_0                            0xD602A0
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_LO_1                            0xD602A4
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_LO_2                            0xD602A8
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_LO_3                            0xD602AC
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_LO_4                            0xD602B0
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_HI_0                            0xD602B4
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_HI_1                            0xD602B8
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_HI_2                            0xD602BC
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_HI_3                            0xD602C0
+
+#define mmNIC2_QM0_CP_MSG_BASE3_ADDR_HI_4                            0xD602C4
+
+#define mmNIC2_QM0_CP_LDMA_TSIZE_OFFSET_0                            0xD602C8
+
+#define mmNIC2_QM0_CP_LDMA_TSIZE_OFFSET_1                            0xD602CC
+
+#define mmNIC2_QM0_CP_LDMA_TSIZE_OFFSET_2                            0xD602D0
+
+#define mmNIC2_QM0_CP_LDMA_TSIZE_OFFSET_3                            0xD602D4
+
+#define mmNIC2_QM0_CP_LDMA_TSIZE_OFFSET_4                            0xD602D8
+
+#define mmNIC2_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xD602E0
+
+#define mmNIC2_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xD602E4
+
+#define mmNIC2_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xD602E8
+
+#define mmNIC2_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xD602EC
+
+#define mmNIC2_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xD602F0
+
+#define mmNIC2_QM0_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xD602F4
+
+#define mmNIC2_QM0_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xD602F8
+
+#define mmNIC2_QM0_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xD602FC
+
+#define mmNIC2_QM0_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xD60300
+
+#define mmNIC2_QM0_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xD60304
+
+#define mmNIC2_QM0_CP_FENCE0_RDATA_0                                 0xD60308
+
+#define mmNIC2_QM0_CP_FENCE0_RDATA_1                                 0xD6030C
+
+#define mmNIC2_QM0_CP_FENCE0_RDATA_2                                 0xD60310
+
+#define mmNIC2_QM0_CP_FENCE0_RDATA_3                                 0xD60314
+
+#define mmNIC2_QM0_CP_FENCE0_RDATA_4                                 0xD60318
+
+#define mmNIC2_QM0_CP_FENCE1_RDATA_0                                 0xD6031C
+
+#define mmNIC2_QM0_CP_FENCE1_RDATA_1                                 0xD60320
+
+#define mmNIC2_QM0_CP_FENCE1_RDATA_2                                 0xD60324
+
+#define mmNIC2_QM0_CP_FENCE1_RDATA_3                                 0xD60328
+
+#define mmNIC2_QM0_CP_FENCE1_RDATA_4                                 0xD6032C
+
+#define mmNIC2_QM0_CP_FENCE2_RDATA_0                                 0xD60330
+
+#define mmNIC2_QM0_CP_FENCE2_RDATA_1                                 0xD60334
+
+#define mmNIC2_QM0_CP_FENCE2_RDATA_2                                 0xD60338
+
+#define mmNIC2_QM0_CP_FENCE2_RDATA_3                                 0xD6033C
+
+#define mmNIC2_QM0_CP_FENCE2_RDATA_4                                 0xD60340
+
+#define mmNIC2_QM0_CP_FENCE3_RDATA_0                                 0xD60344
+
+#define mmNIC2_QM0_CP_FENCE3_RDATA_1                                 0xD60348
+
+#define mmNIC2_QM0_CP_FENCE3_RDATA_2                                 0xD6034C
+
+#define mmNIC2_QM0_CP_FENCE3_RDATA_3                                 0xD60350
+
+#define mmNIC2_QM0_CP_FENCE3_RDATA_4                                 0xD60354
+
+#define mmNIC2_QM0_CP_FENCE0_CNT_0                                   0xD60358
+
+#define mmNIC2_QM0_CP_FENCE0_CNT_1                                   0xD6035C
+
+#define mmNIC2_QM0_CP_FENCE0_CNT_2                                   0xD60360
+
+#define mmNIC2_QM0_CP_FENCE0_CNT_3                                   0xD60364
+
+#define mmNIC2_QM0_CP_FENCE0_CNT_4                                   0xD60368
+
+#define mmNIC2_QM0_CP_FENCE1_CNT_0                                   0xD6036C
+
+#define mmNIC2_QM0_CP_FENCE1_CNT_1                                   0xD60370
+
+#define mmNIC2_QM0_CP_FENCE1_CNT_2                                   0xD60374
+
+#define mmNIC2_QM0_CP_FENCE1_CNT_3                                   0xD60378
+
+#define mmNIC2_QM0_CP_FENCE1_CNT_4                                   0xD6037C
+
+#define mmNIC2_QM0_CP_FENCE2_CNT_0                                   0xD60380
+
+#define mmNIC2_QM0_CP_FENCE2_CNT_1                                   0xD60384
+
+#define mmNIC2_QM0_CP_FENCE2_CNT_2                                   0xD60388
+
+#define mmNIC2_QM0_CP_FENCE2_CNT_3                                   0xD6038C
+
+#define mmNIC2_QM0_CP_FENCE2_CNT_4                                   0xD60390
+
+#define mmNIC2_QM0_CP_FENCE3_CNT_0                                   0xD60394
+
+#define mmNIC2_QM0_CP_FENCE3_CNT_1                                   0xD60398
+
+#define mmNIC2_QM0_CP_FENCE3_CNT_2                                   0xD6039C
+
+#define mmNIC2_QM0_CP_FENCE3_CNT_3                                   0xD603A0
+
+#define mmNIC2_QM0_CP_FENCE3_CNT_4                                   0xD603A4
+
+#define mmNIC2_QM0_CP_STS_0                                          0xD603A8
+
+#define mmNIC2_QM0_CP_STS_1                                          0xD603AC
+
+#define mmNIC2_QM0_CP_STS_2                                          0xD603B0
+
+#define mmNIC2_QM0_CP_STS_3                                          0xD603B4
+
+#define mmNIC2_QM0_CP_STS_4                                          0xD603B8
+
+#define mmNIC2_QM0_CP_CURRENT_INST_LO_0                              0xD603BC
+
+#define mmNIC2_QM0_CP_CURRENT_INST_LO_1                              0xD603C0
+
+#define mmNIC2_QM0_CP_CURRENT_INST_LO_2                              0xD603C4
+
+#define mmNIC2_QM0_CP_CURRENT_INST_LO_3                              0xD603C8
+
+#define mmNIC2_QM0_CP_CURRENT_INST_LO_4                              0xD603CC
+
+#define mmNIC2_QM0_CP_CURRENT_INST_HI_0                              0xD603D0
+
+#define mmNIC2_QM0_CP_CURRENT_INST_HI_1                              0xD603D4
+
+#define mmNIC2_QM0_CP_CURRENT_INST_HI_2                              0xD603D8
+
+#define mmNIC2_QM0_CP_CURRENT_INST_HI_3                              0xD603DC
+
+#define mmNIC2_QM0_CP_CURRENT_INST_HI_4                              0xD603E0
+
+#define mmNIC2_QM0_CP_BARRIER_CFG_0                                  0xD603F4
+
+#define mmNIC2_QM0_CP_BARRIER_CFG_1                                  0xD603F8
+
+#define mmNIC2_QM0_CP_BARRIER_CFG_2                                  0xD603FC
+
+#define mmNIC2_QM0_CP_BARRIER_CFG_3                                  0xD60400
+
+#define mmNIC2_QM0_CP_BARRIER_CFG_4                                  0xD60404
+
+#define mmNIC2_QM0_CP_DBG_0_0                                        0xD60408
+
+#define mmNIC2_QM0_CP_DBG_0_1                                        0xD6040C
+
+#define mmNIC2_QM0_CP_DBG_0_2                                        0xD60410
+
+#define mmNIC2_QM0_CP_DBG_0_3                                        0xD60414
+
+#define mmNIC2_QM0_CP_DBG_0_4                                        0xD60418
+
+#define mmNIC2_QM0_CP_ARUSER_31_11_0                                 0xD6041C
+
+#define mmNIC2_QM0_CP_ARUSER_31_11_1                                 0xD60420
+
+#define mmNIC2_QM0_CP_ARUSER_31_11_2                                 0xD60424
+
+#define mmNIC2_QM0_CP_ARUSER_31_11_3                                 0xD60428
+
+#define mmNIC2_QM0_CP_ARUSER_31_11_4                                 0xD6042C
+
+#define mmNIC2_QM0_CP_AWUSER_31_11_0                                 0xD60430
+
+#define mmNIC2_QM0_CP_AWUSER_31_11_1                                 0xD60434
+
+#define mmNIC2_QM0_CP_AWUSER_31_11_2                                 0xD60438
+
+#define mmNIC2_QM0_CP_AWUSER_31_11_3                                 0xD6043C
+
+#define mmNIC2_QM0_CP_AWUSER_31_11_4                                 0xD60440
+
+#define mmNIC2_QM0_ARB_CFG_0                                         0xD60A00
+
+#define mmNIC2_QM0_ARB_CHOISE_Q_PUSH                                 0xD60A04
+
+#define mmNIC2_QM0_ARB_WRR_WEIGHT_0                                  0xD60A08
+
+#define mmNIC2_QM0_ARB_WRR_WEIGHT_1                                  0xD60A0C
+
+#define mmNIC2_QM0_ARB_WRR_WEIGHT_2                                  0xD60A10
+
+#define mmNIC2_QM0_ARB_WRR_WEIGHT_3                                  0xD60A14
+
+#define mmNIC2_QM0_ARB_CFG_1                                         0xD60A18
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_0                              0xD60A20
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_1                              0xD60A24
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_2                              0xD60A28
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_3                              0xD60A2C
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_4                              0xD60A30
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_5                              0xD60A34
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_6                              0xD60A38
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_7                              0xD60A3C
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_8                              0xD60A40
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_9                              0xD60A44
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_10                             0xD60A48
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_11                             0xD60A4C
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_12                             0xD60A50
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_13                             0xD60A54
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_14                             0xD60A58
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_15                             0xD60A5C
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_16                             0xD60A60
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_17                             0xD60A64
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_18                             0xD60A68
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_19                             0xD60A6C
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_20                             0xD60A70
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_21                             0xD60A74
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_22                             0xD60A78
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_23                             0xD60A7C
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_24                             0xD60A80
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_25                             0xD60A84
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_26                             0xD60A88
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_27                             0xD60A8C
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_28                             0xD60A90
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_29                             0xD60A94
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_30                             0xD60A98
+
+#define mmNIC2_QM0_ARB_MST_AVAIL_CRED_31                             0xD60A9C
+
+#define mmNIC2_QM0_ARB_MST_CRED_INC                                  0xD60AA0
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_0                        0xD60AA4
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_1                        0xD60AA8
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_2                        0xD60AAC
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_3                        0xD60AB0
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_4                        0xD60AB4
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_5                        0xD60AB8
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_6                        0xD60ABC
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_7                        0xD60AC0
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_8                        0xD60AC4
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_9                        0xD60AC8
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_10                       0xD60ACC
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_11                       0xD60AD0
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_12                       0xD60AD4
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_13                       0xD60AD8
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_14                       0xD60ADC
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_15                       0xD60AE0
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_16                       0xD60AE4
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_17                       0xD60AE8
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_18                       0xD60AEC
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_19                       0xD60AF0
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_20                       0xD60AF4
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_21                       0xD60AF8
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_22                       0xD60AFC
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_23                       0xD60B00
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_24                       0xD60B04
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_25                       0xD60B08
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_26                       0xD60B0C
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_27                       0xD60B10
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_28                       0xD60B14
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_29                       0xD60B18
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_30                       0xD60B1C
+
+#define mmNIC2_QM0_ARB_MST_CHOISE_PUSH_OFST_31                       0xD60B20
+
+#define mmNIC2_QM0_ARB_SLV_MASTER_INC_CRED_OFST                      0xD60B28
+
+#define mmNIC2_QM0_ARB_MST_SLAVE_EN                                  0xD60B2C
+
+#define mmNIC2_QM0_ARB_MST_QUIET_PER                                 0xD60B34
+
+#define mmNIC2_QM0_ARB_SLV_CHOISE_WDT                                0xD60B38
+
+#define mmNIC2_QM0_ARB_SLV_ID                                        0xD60B3C
+
+#define mmNIC2_QM0_ARB_MSG_MAX_INFLIGHT                              0xD60B44
+
+#define mmNIC2_QM0_ARB_MSG_AWUSER_31_11                              0xD60B48
+
+#define mmNIC2_QM0_ARB_MSG_AWUSER_SEC_PROP                           0xD60B4C
+
+#define mmNIC2_QM0_ARB_MSG_AWUSER_NON_SEC_PROP                       0xD60B50
+
+#define mmNIC2_QM0_ARB_BASE_LO                                       0xD60B54
+
+#define mmNIC2_QM0_ARB_BASE_HI                                       0xD60B58
+
+#define mmNIC2_QM0_ARB_STATE_STS                                     0xD60B80
+
+#define mmNIC2_QM0_ARB_CHOISE_FULLNESS_STS                           0xD60B84
+
+#define mmNIC2_QM0_ARB_MSG_STS                                       0xD60B88
+
+#define mmNIC2_QM0_ARB_SLV_CHOISE_Q_HEAD                             0xD60B8C
+
+#define mmNIC2_QM0_ARB_ERR_CAUSE                                     0xD60B9C
+
+#define mmNIC2_QM0_ARB_ERR_MSG_EN                                    0xD60BA0
+
+#define mmNIC2_QM0_ARB_ERR_STS_DRP                                   0xD60BA8
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_0                                0xD60BB0
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_1                                0xD60BB4
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_2                                0xD60BB8
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_3                                0xD60BBC
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_4                                0xD60BC0
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_5                                0xD60BC4
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_6                                0xD60BC8
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_7                                0xD60BCC
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_8                                0xD60BD0
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_9                                0xD60BD4
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_10                               0xD60BD8
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_11                               0xD60BDC
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_12                               0xD60BE0
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_13                               0xD60BE4
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_14                               0xD60BE8
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_15                               0xD60BEC
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_16                               0xD60BF0
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_17                               0xD60BF4
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_18                               0xD60BF8
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_19                               0xD60BFC
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_20                               0xD60C00
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_21                               0xD60C04
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_22                               0xD60C08
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_23                               0xD60C0C
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_24                               0xD60C10
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_25                               0xD60C14
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_26                               0xD60C18
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_27                               0xD60C1C
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_28                               0xD60C20
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_29                               0xD60C24
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_30                               0xD60C28
+
+#define mmNIC2_QM0_ARB_MST_CRED_STS_31                               0xD60C2C
+
+#define mmNIC2_QM0_CGM_CFG                                           0xD60C70
+
+#define mmNIC2_QM0_CGM_STS                                           0xD60C74
+
+#define mmNIC2_QM0_CGM_CFG1                                          0xD60C78
+
+#define mmNIC2_QM0_LOCAL_RANGE_BASE                                  0xD60C80
+
+#define mmNIC2_QM0_LOCAL_RANGE_SIZE                                  0xD60C84
+
+#define mmNIC2_QM0_CSMR_STRICT_PRIO_CFG                              0xD60C90
+
+#define mmNIC2_QM0_HBW_RD_RATE_LIM_CFG_1                             0xD60C94
+
+#define mmNIC2_QM0_LBW_WR_RATE_LIM_CFG_0                             0xD60C98
+
+#define mmNIC2_QM0_LBW_WR_RATE_LIM_CFG_1                             0xD60C9C
+
+#define mmNIC2_QM0_HBW_RD_RATE_LIM_CFG_0                             0xD60CA0
+
+#define mmNIC2_QM0_GLBL_AXCACHE                                      0xD60CA4
+
+#define mmNIC2_QM0_IND_GW_APB_CFG                                    0xD60CB0
+
+#define mmNIC2_QM0_IND_GW_APB_WDATA                                  0xD60CB4
+
+#define mmNIC2_QM0_IND_GW_APB_RDATA                                  0xD60CB8
+
+#define mmNIC2_QM0_IND_GW_APB_STATUS                                 0xD60CBC
+
+#define mmNIC2_QM0_GLBL_ERR_ADDR_LO                                  0xD60CD0
+
+#define mmNIC2_QM0_GLBL_ERR_ADDR_HI                                  0xD60CD4
+
+#define mmNIC2_QM0_GLBL_ERR_WDATA                                    0xD60CD8
+
+#define mmNIC2_QM0_GLBL_MEM_INIT_BUSY                                0xD60D00
+
+#endif /* ASIC_REG_NIC2_QM0_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm1_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm1_regs.h
new file mode 100644
index 000000000000..b7f091ddc89c
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm1_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC2_QM1_REGS_H_
+#define ASIC_REG_NIC2_QM1_REGS_H_
+
+/*
+ *****************************************
+ *   NIC2_QM1 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC2_QM1_GLBL_CFG0                                         0xD62000
+
+#define mmNIC2_QM1_GLBL_CFG1                                         0xD62004
+
+#define mmNIC2_QM1_GLBL_PROT                                         0xD62008
+
+#define mmNIC2_QM1_GLBL_ERR_CFG                                      0xD6200C
+
+#define mmNIC2_QM1_GLBL_SECURE_PROPS_0                               0xD62010
+
+#define mmNIC2_QM1_GLBL_SECURE_PROPS_1                               0xD62014
+
+#define mmNIC2_QM1_GLBL_SECURE_PROPS_2                               0xD62018
+
+#define mmNIC2_QM1_GLBL_SECURE_PROPS_3                               0xD6201C
+
+#define mmNIC2_QM1_GLBL_SECURE_PROPS_4                               0xD62020
+
+#define mmNIC2_QM1_GLBL_NON_SECURE_PROPS_0                           0xD62024
+
+#define mmNIC2_QM1_GLBL_NON_SECURE_PROPS_1                           0xD62028
+
+#define mmNIC2_QM1_GLBL_NON_SECURE_PROPS_2                           0xD6202C
+
+#define mmNIC2_QM1_GLBL_NON_SECURE_PROPS_3                           0xD62030
+
+#define mmNIC2_QM1_GLBL_NON_SECURE_PROPS_4                           0xD62034
+
+#define mmNIC2_QM1_GLBL_STS0                                         0xD62038
+
+#define mmNIC2_QM1_GLBL_STS1_0                                       0xD62040
+
+#define mmNIC2_QM1_GLBL_STS1_1                                       0xD62044
+
+#define mmNIC2_QM1_GLBL_STS1_2                                       0xD62048
+
+#define mmNIC2_QM1_GLBL_STS1_3                                       0xD6204C
+
+#define mmNIC2_QM1_GLBL_STS1_4                                       0xD62050
+
+#define mmNIC2_QM1_GLBL_MSG_EN_0                                     0xD62054
+
+#define mmNIC2_QM1_GLBL_MSG_EN_1                                     0xD62058
+
+#define mmNIC2_QM1_GLBL_MSG_EN_2                                     0xD6205C
+
+#define mmNIC2_QM1_GLBL_MSG_EN_3                                     0xD62060
+
+#define mmNIC2_QM1_GLBL_MSG_EN_4                                     0xD62068
+
+#define mmNIC2_QM1_PQ_BASE_LO_0                                      0xD62070
+
+#define mmNIC2_QM1_PQ_BASE_LO_1                                      0xD62074
+
+#define mmNIC2_QM1_PQ_BASE_LO_2                                      0xD62078
+
+#define mmNIC2_QM1_PQ_BASE_LO_3                                      0xD6207C
+
+#define mmNIC2_QM1_PQ_BASE_HI_0                                      0xD62080
+
+#define mmNIC2_QM1_PQ_BASE_HI_1                                      0xD62084
+
+#define mmNIC2_QM1_PQ_BASE_HI_2                                      0xD62088
+
+#define mmNIC2_QM1_PQ_BASE_HI_3                                      0xD6208C
+
+#define mmNIC2_QM1_PQ_SIZE_0                                         0xD62090
+
+#define mmNIC2_QM1_PQ_SIZE_1                                         0xD62094
+
+#define mmNIC2_QM1_PQ_SIZE_2                                         0xD62098
+
+#define mmNIC2_QM1_PQ_SIZE_3                                         0xD6209C
+
+#define mmNIC2_QM1_PQ_PI_0                                           0xD620A0
+
+#define mmNIC2_QM1_PQ_PI_1                                           0xD620A4
+
+#define mmNIC2_QM1_PQ_PI_2                                           0xD620A8
+
+#define mmNIC2_QM1_PQ_PI_3                                           0xD620AC
+
+#define mmNIC2_QM1_PQ_CI_0                                           0xD620B0
+
+#define mmNIC2_QM1_PQ_CI_1                                           0xD620B4
+
+#define mmNIC2_QM1_PQ_CI_2                                           0xD620B8
+
+#define mmNIC2_QM1_PQ_CI_3                                           0xD620BC
+
+#define mmNIC2_QM1_PQ_CFG0_0                                         0xD620C0
+
+#define mmNIC2_QM1_PQ_CFG0_1                                         0xD620C4
+
+#define mmNIC2_QM1_PQ_CFG0_2                                         0xD620C8
+
+#define mmNIC2_QM1_PQ_CFG0_3                                         0xD620CC
+
+#define mmNIC2_QM1_PQ_CFG1_0                                         0xD620D0
+
+#define mmNIC2_QM1_PQ_CFG1_1                                         0xD620D4
+
+#define mmNIC2_QM1_PQ_CFG1_2                                         0xD620D8
+
+#define mmNIC2_QM1_PQ_CFG1_3                                         0xD620DC
+
+#define mmNIC2_QM1_PQ_ARUSER_31_11_0                                 0xD620E0
+
+#define mmNIC2_QM1_PQ_ARUSER_31_11_1                                 0xD620E4
+
+#define mmNIC2_QM1_PQ_ARUSER_31_11_2                                 0xD620E8
+
+#define mmNIC2_QM1_PQ_ARUSER_31_11_3                                 0xD620EC
+
+#define mmNIC2_QM1_PQ_STS0_0                                         0xD620F0
+
+#define mmNIC2_QM1_PQ_STS0_1                                         0xD620F4
+
+#define mmNIC2_QM1_PQ_STS0_2                                         0xD620F8
+
+#define mmNIC2_QM1_PQ_STS0_3                                         0xD620FC
+
+#define mmNIC2_QM1_PQ_STS1_0                                         0xD62100
+
+#define mmNIC2_QM1_PQ_STS1_1                                         0xD62104
+
+#define mmNIC2_QM1_PQ_STS1_2                                         0xD62108
+
+#define mmNIC2_QM1_PQ_STS1_3                                         0xD6210C
+
+#define mmNIC2_QM1_CQ_CFG0_0                                         0xD62110
+
+#define mmNIC2_QM1_CQ_CFG0_1                                         0xD62114
+
+#define mmNIC2_QM1_CQ_CFG0_2                                         0xD62118
+
+#define mmNIC2_QM1_CQ_CFG0_3                                         0xD6211C
+
+#define mmNIC2_QM1_CQ_CFG0_4                                         0xD62120
+
+#define mmNIC2_QM1_CQ_CFG1_0                                         0xD62124
+
+#define mmNIC2_QM1_CQ_CFG1_1                                         0xD62128
+
+#define mmNIC2_QM1_CQ_CFG1_2                                         0xD6212C
+
+#define mmNIC2_QM1_CQ_CFG1_3                                         0xD62130
+
+#define mmNIC2_QM1_CQ_CFG1_4                                         0xD62134
+
+#define mmNIC2_QM1_CQ_ARUSER_31_11_0                                 0xD62138
+
+#define mmNIC2_QM1_CQ_ARUSER_31_11_1                                 0xD6213C
+
+#define mmNIC2_QM1_CQ_ARUSER_31_11_2                                 0xD62140
+
+#define mmNIC2_QM1_CQ_ARUSER_31_11_3                                 0xD62144
+
+#define mmNIC2_QM1_CQ_ARUSER_31_11_4                                 0xD62148
+
+#define mmNIC2_QM1_CQ_STS0_0                                         0xD6214C
+
+#define mmNIC2_QM1_CQ_STS0_1                                         0xD62150
+
+#define mmNIC2_QM1_CQ_STS0_2                                         0xD62154
+
+#define mmNIC2_QM1_CQ_STS0_3                                         0xD62158
+
+#define mmNIC2_QM1_CQ_STS0_4                                         0xD6215C
+
+#define mmNIC2_QM1_CQ_STS1_0                                         0xD62160
+
+#define mmNIC2_QM1_CQ_STS1_1                                         0xD62164
+
+#define mmNIC2_QM1_CQ_STS1_2                                         0xD62168
+
+#define mmNIC2_QM1_CQ_STS1_3                                         0xD6216C
+
+#define mmNIC2_QM1_CQ_STS1_4                                         0xD62170
+
+#define mmNIC2_QM1_CQ_PTR_LO_0                                       0xD62174
+
+#define mmNIC2_QM1_CQ_PTR_HI_0                                       0xD62178
+
+#define mmNIC2_QM1_CQ_TSIZE_0                                        0xD6217C
+
+#define mmNIC2_QM1_CQ_CTL_0                                          0xD62180
+
+#define mmNIC2_QM1_CQ_PTR_LO_1                                       0xD62184
+
+#define mmNIC2_QM1_CQ_PTR_HI_1                                       0xD62188
+
+#define mmNIC2_QM1_CQ_TSIZE_1                                        0xD6218C
+
+#define mmNIC2_QM1_CQ_CTL_1                                          0xD62190
+
+#define mmNIC2_QM1_CQ_PTR_LO_2                                       0xD62194
+
+#define mmNIC2_QM1_CQ_PTR_HI_2                                       0xD62198
+
+#define mmNIC2_QM1_CQ_TSIZE_2                                        0xD6219C
+
+#define mmNIC2_QM1_CQ_CTL_2                                          0xD621A0
+
+#define mmNIC2_QM1_CQ_PTR_LO_3                                       0xD621A4
+
+#define mmNIC2_QM1_CQ_PTR_HI_3                                       0xD621A8
+
+#define mmNIC2_QM1_CQ_TSIZE_3                                        0xD621AC
+
+#define mmNIC2_QM1_CQ_CTL_3                                          0xD621B0
+
+#define mmNIC2_QM1_CQ_PTR_LO_4                                       0xD621B4
+
+#define mmNIC2_QM1_CQ_PTR_HI_4                                       0xD621B8
+
+#define mmNIC2_QM1_CQ_TSIZE_4                                        0xD621BC
+
+#define mmNIC2_QM1_CQ_CTL_4                                          0xD621C0
+
+#define mmNIC2_QM1_CQ_PTR_LO_STS_0                                   0xD621C4
+
+#define mmNIC2_QM1_CQ_PTR_LO_STS_1                                   0xD621C8
+
+#define mmNIC2_QM1_CQ_PTR_LO_STS_2                                   0xD621CC
+
+#define mmNIC2_QM1_CQ_PTR_LO_STS_3                                   0xD621D0
+
+#define mmNIC2_QM1_CQ_PTR_LO_STS_4                                   0xD621D4
+
+#define mmNIC2_QM1_CQ_PTR_HI_STS_0                                   0xD621D8
+
+#define mmNIC2_QM1_CQ_PTR_HI_STS_1                                   0xD621DC
+
+#define mmNIC2_QM1_CQ_PTR_HI_STS_2                                   0xD621E0
+
+#define mmNIC2_QM1_CQ_PTR_HI_STS_3                                   0xD621E4
+
+#define mmNIC2_QM1_CQ_PTR_HI_STS_4                                   0xD621E8
+
+#define mmNIC2_QM1_CQ_TSIZE_STS_0                                    0xD621EC
+
+#define mmNIC2_QM1_CQ_TSIZE_STS_1                                    0xD621F0
+
+#define mmNIC2_QM1_CQ_TSIZE_STS_2                                    0xD621F4
+
+#define mmNIC2_QM1_CQ_TSIZE_STS_3                                    0xD621F8
+
+#define mmNIC2_QM1_CQ_TSIZE_STS_4                                    0xD621FC
+
+#define mmNIC2_QM1_CQ_CTL_STS_0                                      0xD62200
+
+#define mmNIC2_QM1_CQ_CTL_STS_1                                      0xD62204
+
+#define mmNIC2_QM1_CQ_CTL_STS_2                                      0xD62208
+
+#define mmNIC2_QM1_CQ_CTL_STS_3                                      0xD6220C
+
+#define mmNIC2_QM1_CQ_CTL_STS_4                                      0xD62210
+
+#define mmNIC2_QM1_CQ_IFIFO_CNT_0                                    0xD62214
+
+#define mmNIC2_QM1_CQ_IFIFO_CNT_1                                    0xD62218
+
+#define mmNIC2_QM1_CQ_IFIFO_CNT_2                                    0xD6221C
+
+#define mmNIC2_QM1_CQ_IFIFO_CNT_3                                    0xD62220
+
+#define mmNIC2_QM1_CQ_IFIFO_CNT_4                                    0xD62224
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_LO_0                            0xD62228
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_LO_1                            0xD6222C
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_LO_2                            0xD62230
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_LO_3                            0xD62234
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_LO_4                            0xD62238
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_HI_0                            0xD6223C
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_HI_1                            0xD62240
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_HI_2                            0xD62244
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_HI_3                            0xD62248
+
+#define mmNIC2_QM1_CP_MSG_BASE0_ADDR_HI_4                            0xD6224C
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_LO_0                            0xD62250
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_LO_1                            0xD62254
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_LO_2                            0xD62258
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_LO_3                            0xD6225C
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_LO_4                            0xD62260
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_HI_0                            0xD62264
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_HI_1                            0xD62268
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_HI_2                            0xD6226C
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_HI_3                            0xD62270
+
+#define mmNIC2_QM1_CP_MSG_BASE1_ADDR_HI_4                            0xD62274
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_LO_0                            0xD62278
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_LO_1                            0xD6227C
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_LO_2                            0xD62280
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_LO_3                            0xD62284
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_LO_4                            0xD62288
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_HI_0                            0xD6228C
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_HI_1                            0xD62290
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_HI_2                            0xD62294
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_HI_3                            0xD62298
+
+#define mmNIC2_QM1_CP_MSG_BASE2_ADDR_HI_4                            0xD6229C
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_LO_0                            0xD622A0
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_LO_1                            0xD622A4
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_LO_2                            0xD622A8
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_LO_3                            0xD622AC
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_LO_4                            0xD622B0
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_HI_0                            0xD622B4
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_HI_1                            0xD622B8
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_HI_2                            0xD622BC
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_HI_3                            0xD622C0
+
+#define mmNIC2_QM1_CP_MSG_BASE3_ADDR_HI_4                            0xD622C4
+
+#define mmNIC2_QM1_CP_LDMA_TSIZE_OFFSET_0                            0xD622C8
+
+#define mmNIC2_QM1_CP_LDMA_TSIZE_OFFSET_1                            0xD622CC
+
+#define mmNIC2_QM1_CP_LDMA_TSIZE_OFFSET_2                            0xD622D0
+
+#define mmNIC2_QM1_CP_LDMA_TSIZE_OFFSET_3                            0xD622D4
+
+#define mmNIC2_QM1_CP_LDMA_TSIZE_OFFSET_4                            0xD622D8
+
+#define mmNIC2_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xD622E0
+
+#define mmNIC2_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xD622E4
+
+#define mmNIC2_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xD622E8
+
+#define mmNIC2_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xD622EC
+
+#define mmNIC2_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xD622F0
+
+#define mmNIC2_QM1_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xD622F4
+
+#define mmNIC2_QM1_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xD622F8
+
+#define mmNIC2_QM1_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xD622FC
+
+#define mmNIC2_QM1_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xD62300
+
+#define mmNIC2_QM1_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xD62304
+
+#define mmNIC2_QM1_CP_FENCE0_RDATA_0                                 0xD62308
+
+#define mmNIC2_QM1_CP_FENCE0_RDATA_1                                 0xD6230C
+
+#define mmNIC2_QM1_CP_FENCE0_RDATA_2                                 0xD62310
+
+#define mmNIC2_QM1_CP_FENCE0_RDATA_3                                 0xD62314
+
+#define mmNIC2_QM1_CP_FENCE0_RDATA_4                                 0xD62318
+
+#define mmNIC2_QM1_CP_FENCE1_RDATA_0                                 0xD6231C
+
+#define mmNIC2_QM1_CP_FENCE1_RDATA_1                                 0xD62320
+
+#define mmNIC2_QM1_CP_FENCE1_RDATA_2                                 0xD62324
+
+#define mmNIC2_QM1_CP_FENCE1_RDATA_3                                 0xD62328
+
+#define mmNIC2_QM1_CP_FENCE1_RDATA_4                                 0xD6232C
+
+#define mmNIC2_QM1_CP_FENCE2_RDATA_0                                 0xD62330
+
+#define mmNIC2_QM1_CP_FENCE2_RDATA_1                                 0xD62334
+
+#define mmNIC2_QM1_CP_FENCE2_RDATA_2                                 0xD62338
+
+#define mmNIC2_QM1_CP_FENCE2_RDATA_3                                 0xD6233C
+
+#define mmNIC2_QM1_CP_FENCE2_RDATA_4                                 0xD62340
+
+#define mmNIC2_QM1_CP_FENCE3_RDATA_0                                 0xD62344
+
+#define mmNIC2_QM1_CP_FENCE3_RDATA_1                                 0xD62348
+
+#define mmNIC2_QM1_CP_FENCE3_RDATA_2                                 0xD6234C
+
+#define mmNIC2_QM1_CP_FENCE3_RDATA_3                                 0xD62350
+
+#define mmNIC2_QM1_CP_FENCE3_RDATA_4                                 0xD62354
+
+#define mmNIC2_QM1_CP_FENCE0_CNT_0                                   0xD62358
+
+#define mmNIC2_QM1_CP_FENCE0_CNT_1                                   0xD6235C
+
+#define mmNIC2_QM1_CP_FENCE0_CNT_2                                   0xD62360
+
+#define mmNIC2_QM1_CP_FENCE0_CNT_3                                   0xD62364
+
+#define mmNIC2_QM1_CP_FENCE0_CNT_4                                   0xD62368
+
+#define mmNIC2_QM1_CP_FENCE1_CNT_0                                   0xD6236C
+
+#define mmNIC2_QM1_CP_FENCE1_CNT_1                                   0xD62370
+
+#define mmNIC2_QM1_CP_FENCE1_CNT_2                                   0xD62374
+
+#define mmNIC2_QM1_CP_FENCE1_CNT_3                                   0xD62378
+
+#define mmNIC2_QM1_CP_FENCE1_CNT_4                                   0xD6237C
+
+#define mmNIC2_QM1_CP_FENCE2_CNT_0                                   0xD62380
+
+#define mmNIC2_QM1_CP_FENCE2_CNT_1                                   0xD62384
+
+#define mmNIC2_QM1_CP_FENCE2_CNT_2                                   0xD62388
+
+#define mmNIC2_QM1_CP_FENCE2_CNT_3                                   0xD6238C
+
+#define mmNIC2_QM1_CP_FENCE2_CNT_4                                   0xD62390
+
+#define mmNIC2_QM1_CP_FENCE3_CNT_0                                   0xD62394
+
+#define mmNIC2_QM1_CP_FENCE3_CNT_1                                   0xD62398
+
+#define mmNIC2_QM1_CP_FENCE3_CNT_2                                   0xD6239C
+
+#define mmNIC2_QM1_CP_FENCE3_CNT_3                                   0xD623A0
+
+#define mmNIC2_QM1_CP_FENCE3_CNT_4                                   0xD623A4
+
+#define mmNIC2_QM1_CP_STS_0                                          0xD623A8
+
+#define mmNIC2_QM1_CP_STS_1                                          0xD623AC
+
+#define mmNIC2_QM1_CP_STS_2                                          0xD623B0
+
+#define mmNIC2_QM1_CP_STS_3                                          0xD623B4
+
+#define mmNIC2_QM1_CP_STS_4                                          0xD623B8
+
+#define mmNIC2_QM1_CP_CURRENT_INST_LO_0                              0xD623BC
+
+#define mmNIC2_QM1_CP_CURRENT_INST_LO_1                              0xD623C0
+
+#define mmNIC2_QM1_CP_CURRENT_INST_LO_2                              0xD623C4
+
+#define mmNIC2_QM1_CP_CURRENT_INST_LO_3                              0xD623C8
+
+#define mmNIC2_QM1_CP_CURRENT_INST_LO_4                              0xD623CC
+
+#define mmNIC2_QM1_CP_CURRENT_INST_HI_0                              0xD623D0
+
+#define mmNIC2_QM1_CP_CURRENT_INST_HI_1                              0xD623D4
+
+#define mmNIC2_QM1_CP_CURRENT_INST_HI_2                              0xD623D8
+
+#define mmNIC2_QM1_CP_CURRENT_INST_HI_3                              0xD623DC
+
+#define mmNIC2_QM1_CP_CURRENT_INST_HI_4                              0xD623E0
+
+#define mmNIC2_QM1_CP_BARRIER_CFG_0                                  0xD623F4
+
+#define mmNIC2_QM1_CP_BARRIER_CFG_1                                  0xD623F8
+
+#define mmNIC2_QM1_CP_BARRIER_CFG_2                                  0xD623FC
+
+#define mmNIC2_QM1_CP_BARRIER_CFG_3                                  0xD62400
+
+#define mmNIC2_QM1_CP_BARRIER_CFG_4                                  0xD62404
+
+#define mmNIC2_QM1_CP_DBG_0_0                                        0xD62408
+
+#define mmNIC2_QM1_CP_DBG_0_1                                        0xD6240C
+
+#define mmNIC2_QM1_CP_DBG_0_2                                        0xD62410
+
+#define mmNIC2_QM1_CP_DBG_0_3                                        0xD62414
+
+#define mmNIC2_QM1_CP_DBG_0_4                                        0xD62418
+
+#define mmNIC2_QM1_CP_ARUSER_31_11_0                                 0xD6241C
+
+#define mmNIC2_QM1_CP_ARUSER_31_11_1                                 0xD62420
+
+#define mmNIC2_QM1_CP_ARUSER_31_11_2                                 0xD62424
+
+#define mmNIC2_QM1_CP_ARUSER_31_11_3                                 0xD62428
+
+#define mmNIC2_QM1_CP_ARUSER_31_11_4                                 0xD6242C
+
+#define mmNIC2_QM1_CP_AWUSER_31_11_0                                 0xD62430
+
+#define mmNIC2_QM1_CP_AWUSER_31_11_1                                 0xD62434
+
+#define mmNIC2_QM1_CP_AWUSER_31_11_2                                 0xD62438
+
+#define mmNIC2_QM1_CP_AWUSER_31_11_3                                 0xD6243C
+
+#define mmNIC2_QM1_CP_AWUSER_31_11_4                                 0xD62440
+
+#define mmNIC2_QM1_ARB_CFG_0                                         0xD62A00
+
+#define mmNIC2_QM1_ARB_CHOISE_Q_PUSH                                 0xD62A04
+
+#define mmNIC2_QM1_ARB_WRR_WEIGHT_0                                  0xD62A08
+
+#define mmNIC2_QM1_ARB_WRR_WEIGHT_1                                  0xD62A0C
+
+#define mmNIC2_QM1_ARB_WRR_WEIGHT_2                                  0xD62A10
+
+#define mmNIC2_QM1_ARB_WRR_WEIGHT_3                                  0xD62A14
+
+#define mmNIC2_QM1_ARB_CFG_1                                         0xD62A18
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_0                              0xD62A20
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_1                              0xD62A24
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_2                              0xD62A28
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_3                              0xD62A2C
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_4                              0xD62A30
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_5                              0xD62A34
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_6                              0xD62A38
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_7                              0xD62A3C
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_8                              0xD62A40
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_9                              0xD62A44
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_10                             0xD62A48
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_11                             0xD62A4C
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_12                             0xD62A50
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_13                             0xD62A54
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_14                             0xD62A58
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_15                             0xD62A5C
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_16                             0xD62A60
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_17                             0xD62A64
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_18                             0xD62A68
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_19                             0xD62A6C
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_20                             0xD62A70
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_21                             0xD62A74
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_22                             0xD62A78
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_23                             0xD62A7C
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_24                             0xD62A80
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_25                             0xD62A84
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_26                             0xD62A88
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_27                             0xD62A8C
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_28                             0xD62A90
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_29                             0xD62A94
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_30                             0xD62A98
+
+#define mmNIC2_QM1_ARB_MST_AVAIL_CRED_31                             0xD62A9C
+
+#define mmNIC2_QM1_ARB_MST_CRED_INC                                  0xD62AA0
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_0                        0xD62AA4
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_1                        0xD62AA8
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_2                        0xD62AAC
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_3                        0xD62AB0
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_4                        0xD62AB4
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_5                        0xD62AB8
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_6                        0xD62ABC
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_7                        0xD62AC0
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_8                        0xD62AC4
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_9                        0xD62AC8
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_10                       0xD62ACC
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_11                       0xD62AD0
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_12                       0xD62AD4
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_13                       0xD62AD8
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_14                       0xD62ADC
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_15                       0xD62AE0
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_16                       0xD62AE4
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_17                       0xD62AE8
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_18                       0xD62AEC
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_19                       0xD62AF0
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_20                       0xD62AF4
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_21                       0xD62AF8
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_22                       0xD62AFC
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_23                       0xD62B00
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_24                       0xD62B04
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_25                       0xD62B08
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_26                       0xD62B0C
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_27                       0xD62B10
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_28                       0xD62B14
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_29                       0xD62B18
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_30                       0xD62B1C
+
+#define mmNIC2_QM1_ARB_MST_CHOISE_PUSH_OFST_31                       0xD62B20
+
+#define mmNIC2_QM1_ARB_SLV_MASTER_INC_CRED_OFST                      0xD62B28
+
+#define mmNIC2_QM1_ARB_MST_SLAVE_EN                                  0xD62B2C
+
+#define mmNIC2_QM1_ARB_MST_QUIET_PER                                 0xD62B34
+
+#define mmNIC2_QM1_ARB_SLV_CHOISE_WDT                                0xD62B38
+
+#define mmNIC2_QM1_ARB_SLV_ID                                        0xD62B3C
+
+#define mmNIC2_QM1_ARB_MSG_MAX_INFLIGHT                              0xD62B44
+
+#define mmNIC2_QM1_ARB_MSG_AWUSER_31_11                              0xD62B48
+
+#define mmNIC2_QM1_ARB_MSG_AWUSER_SEC_PROP                           0xD62B4C
+
+#define mmNIC2_QM1_ARB_MSG_AWUSER_NON_SEC_PROP                       0xD62B50
+
+#define mmNIC2_QM1_ARB_BASE_LO                                       0xD62B54
+
+#define mmNIC2_QM1_ARB_BASE_HI                                       0xD62B58
+
+#define mmNIC2_QM1_ARB_STATE_STS                                     0xD62B80
+
+#define mmNIC2_QM1_ARB_CHOISE_FULLNESS_STS                           0xD62B84
+
+#define mmNIC2_QM1_ARB_MSG_STS                                       0xD62B88
+
+#define mmNIC2_QM1_ARB_SLV_CHOISE_Q_HEAD                             0xD62B8C
+
+#define mmNIC2_QM1_ARB_ERR_CAUSE                                     0xD62B9C
+
+#define mmNIC2_QM1_ARB_ERR_MSG_EN                                    0xD62BA0
+
+#define mmNIC2_QM1_ARB_ERR_STS_DRP                                   0xD62BA8
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_0                                0xD62BB0
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_1                                0xD62BB4
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_2                                0xD62BB8
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_3                                0xD62BBC
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_4                                0xD62BC0
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_5                                0xD62BC4
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_6                                0xD62BC8
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_7                                0xD62BCC
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_8                                0xD62BD0
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_9                                0xD62BD4
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_10                               0xD62BD8
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_11                               0xD62BDC
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_12                               0xD62BE0
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_13                               0xD62BE4
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_14                               0xD62BE8
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_15                               0xD62BEC
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_16                               0xD62BF0
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_17                               0xD62BF4
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_18                               0xD62BF8
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_19                               0xD62BFC
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_20                               0xD62C00
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_21                               0xD62C04
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_22                               0xD62C08
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_23                               0xD62C0C
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_24                               0xD62C10
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_25                               0xD62C14
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_26                               0xD62C18
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_27                               0xD62C1C
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_28                               0xD62C20
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_29                               0xD62C24
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_30                               0xD62C28
+
+#define mmNIC2_QM1_ARB_MST_CRED_STS_31                               0xD62C2C
+
+#define mmNIC2_QM1_CGM_CFG                                           0xD62C70
+
+#define mmNIC2_QM1_CGM_STS                                           0xD62C74
+
+#define mmNIC2_QM1_CGM_CFG1                                          0xD62C78
+
+#define mmNIC2_QM1_LOCAL_RANGE_BASE                                  0xD62C80
+
+#define mmNIC2_QM1_LOCAL_RANGE_SIZE                                  0xD62C84
+
+#define mmNIC2_QM1_CSMR_STRICT_PRIO_CFG                              0xD62C90
+
+#define mmNIC2_QM1_HBW_RD_RATE_LIM_CFG_1                             0xD62C94
+
+#define mmNIC2_QM1_LBW_WR_RATE_LIM_CFG_0                             0xD62C98
+
+#define mmNIC2_QM1_LBW_WR_RATE_LIM_CFG_1                             0xD62C9C
+
+#define mmNIC2_QM1_HBW_RD_RATE_LIM_CFG_0                             0xD62CA0
+
+#define mmNIC2_QM1_GLBL_AXCACHE                                      0xD62CA4
+
+#define mmNIC2_QM1_IND_GW_APB_CFG                                    0xD62CB0
+
+#define mmNIC2_QM1_IND_GW_APB_WDATA                                  0xD62CB4
+
+#define mmNIC2_QM1_IND_GW_APB_RDATA                                  0xD62CB8
+
+#define mmNIC2_QM1_IND_GW_APB_STATUS                                 0xD62CBC
+
+#define mmNIC2_QM1_GLBL_ERR_ADDR_LO                                  0xD62CD0
+
+#define mmNIC2_QM1_GLBL_ERR_ADDR_HI                                  0xD62CD4
+
+#define mmNIC2_QM1_GLBL_ERR_WDATA                                    0xD62CD8
+
+#define mmNIC2_QM1_GLBL_MEM_INIT_BUSY                                0xD62D00
+
+#endif /* ASIC_REG_NIC2_QM1_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm0_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm0_regs.h
new file mode 100644
index 000000000000..4712cc62b009
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm0_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC3_QM0_REGS_H_
+#define ASIC_REG_NIC3_QM0_REGS_H_
+
+/*
+ *****************************************
+ *   NIC3_QM0 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC3_QM0_GLBL_CFG0                                         0xDA0000
+
+#define mmNIC3_QM0_GLBL_CFG1                                         0xDA0004
+
+#define mmNIC3_QM0_GLBL_PROT                                         0xDA0008
+
+#define mmNIC3_QM0_GLBL_ERR_CFG                                      0xDA000C
+
+#define mmNIC3_QM0_GLBL_SECURE_PROPS_0                               0xDA0010
+
+#define mmNIC3_QM0_GLBL_SECURE_PROPS_1                               0xDA0014
+
+#define mmNIC3_QM0_GLBL_SECURE_PROPS_2                               0xDA0018
+
+#define mmNIC3_QM0_GLBL_SECURE_PROPS_3                               0xDA001C
+
+#define mmNIC3_QM0_GLBL_SECURE_PROPS_4                               0xDA0020
+
+#define mmNIC3_QM0_GLBL_NON_SECURE_PROPS_0                           0xDA0024
+
+#define mmNIC3_QM0_GLBL_NON_SECURE_PROPS_1                           0xDA0028
+
+#define mmNIC3_QM0_GLBL_NON_SECURE_PROPS_2                           0xDA002C
+
+#define mmNIC3_QM0_GLBL_NON_SECURE_PROPS_3                           0xDA0030
+
+#define mmNIC3_QM0_GLBL_NON_SECURE_PROPS_4                           0xDA0034
+
+#define mmNIC3_QM0_GLBL_STS0                                         0xDA0038
+
+#define mmNIC3_QM0_GLBL_STS1_0                                       0xDA0040
+
+#define mmNIC3_QM0_GLBL_STS1_1                                       0xDA0044
+
+#define mmNIC3_QM0_GLBL_STS1_2                                       0xDA0048
+
+#define mmNIC3_QM0_GLBL_STS1_3                                       0xDA004C
+
+#define mmNIC3_QM0_GLBL_STS1_4                                       0xDA0050
+
+#define mmNIC3_QM0_GLBL_MSG_EN_0                                     0xDA0054
+
+#define mmNIC3_QM0_GLBL_MSG_EN_1                                     0xDA0058
+
+#define mmNIC3_QM0_GLBL_MSG_EN_2                                     0xDA005C
+
+#define mmNIC3_QM0_GLBL_MSG_EN_3                                     0xDA0060
+
+#define mmNIC3_QM0_GLBL_MSG_EN_4                                     0xDA0068
+
+#define mmNIC3_QM0_PQ_BASE_LO_0                                      0xDA0070
+
+#define mmNIC3_QM0_PQ_BASE_LO_1                                      0xDA0074
+
+#define mmNIC3_QM0_PQ_BASE_LO_2                                      0xDA0078
+
+#define mmNIC3_QM0_PQ_BASE_LO_3                                      0xDA007C
+
+#define mmNIC3_QM0_PQ_BASE_HI_0                                      0xDA0080
+
+#define mmNIC3_QM0_PQ_BASE_HI_1                                      0xDA0084
+
+#define mmNIC3_QM0_PQ_BASE_HI_2                                      0xDA0088
+
+#define mmNIC3_QM0_PQ_BASE_HI_3                                      0xDA008C
+
+#define mmNIC3_QM0_PQ_SIZE_0                                         0xDA0090
+
+#define mmNIC3_QM0_PQ_SIZE_1                                         0xDA0094
+
+#define mmNIC3_QM0_PQ_SIZE_2                                         0xDA0098
+
+#define mmNIC3_QM0_PQ_SIZE_3                                         0xDA009C
+
+#define mmNIC3_QM0_PQ_PI_0                                           0xDA00A0
+
+#define mmNIC3_QM0_PQ_PI_1                                           0xDA00A4
+
+#define mmNIC3_QM0_PQ_PI_2                                           0xDA00A8
+
+#define mmNIC3_QM0_PQ_PI_3                                           0xDA00AC
+
+#define mmNIC3_QM0_PQ_CI_0                                           0xDA00B0
+
+#define mmNIC3_QM0_PQ_CI_1                                           0xDA00B4
+
+#define mmNIC3_QM0_PQ_CI_2                                           0xDA00B8
+
+#define mmNIC3_QM0_PQ_CI_3                                           0xDA00BC
+
+#define mmNIC3_QM0_PQ_CFG0_0                                         0xDA00C0
+
+#define mmNIC3_QM0_PQ_CFG0_1                                         0xDA00C4
+
+#define mmNIC3_QM0_PQ_CFG0_2                                         0xDA00C8
+
+#define mmNIC3_QM0_PQ_CFG0_3                                         0xDA00CC
+
+#define mmNIC3_QM0_PQ_CFG1_0                                         0xDA00D0
+
+#define mmNIC3_QM0_PQ_CFG1_1                                         0xDA00D4
+
+#define mmNIC3_QM0_PQ_CFG1_2                                         0xDA00D8
+
+#define mmNIC3_QM0_PQ_CFG1_3                                         0xDA00DC
+
+#define mmNIC3_QM0_PQ_ARUSER_31_11_0                                 0xDA00E0
+
+#define mmNIC3_QM0_PQ_ARUSER_31_11_1                                 0xDA00E4
+
+#define mmNIC3_QM0_PQ_ARUSER_31_11_2                                 0xDA00E8
+
+#define mmNIC3_QM0_PQ_ARUSER_31_11_3                                 0xDA00EC
+
+#define mmNIC3_QM0_PQ_STS0_0                                         0xDA00F0
+
+#define mmNIC3_QM0_PQ_STS0_1                                         0xDA00F4
+
+#define mmNIC3_QM0_PQ_STS0_2                                         0xDA00F8
+
+#define mmNIC3_QM0_PQ_STS0_3                                         0xDA00FC
+
+#define mmNIC3_QM0_PQ_STS1_0                                         0xDA0100
+
+#define mmNIC3_QM0_PQ_STS1_1                                         0xDA0104
+
+#define mmNIC3_QM0_PQ_STS1_2                                         0xDA0108
+
+#define mmNIC3_QM0_PQ_STS1_3                                         0xDA010C
+
+#define mmNIC3_QM0_CQ_CFG0_0                                         0xDA0110
+
+#define mmNIC3_QM0_CQ_CFG0_1                                         0xDA0114
+
+#define mmNIC3_QM0_CQ_CFG0_2                                         0xDA0118
+
+#define mmNIC3_QM0_CQ_CFG0_3                                         0xDA011C
+
+#define mmNIC3_QM0_CQ_CFG0_4                                         0xDA0120
+
+#define mmNIC3_QM0_CQ_CFG1_0                                         0xDA0124
+
+#define mmNIC3_QM0_CQ_CFG1_1                                         0xDA0128
+
+#define mmNIC3_QM0_CQ_CFG1_2                                         0xDA012C
+
+#define mmNIC3_QM0_CQ_CFG1_3                                         0xDA0130
+
+#define mmNIC3_QM0_CQ_CFG1_4                                         0xDA0134
+
+#define mmNIC3_QM0_CQ_ARUSER_31_11_0                                 0xDA0138
+
+#define mmNIC3_QM0_CQ_ARUSER_31_11_1                                 0xDA013C
+
+#define mmNIC3_QM0_CQ_ARUSER_31_11_2                                 0xDA0140
+
+#define mmNIC3_QM0_CQ_ARUSER_31_11_3                                 0xDA0144
+
+#define mmNIC3_QM0_CQ_ARUSER_31_11_4                                 0xDA0148
+
+#define mmNIC3_QM0_CQ_STS0_0                                         0xDA014C
+
+#define mmNIC3_QM0_CQ_STS0_1                                         0xDA0150
+
+#define mmNIC3_QM0_CQ_STS0_2                                         0xDA0154
+
+#define mmNIC3_QM0_CQ_STS0_3                                         0xDA0158
+
+#define mmNIC3_QM0_CQ_STS0_4                                         0xDA015C
+
+#define mmNIC3_QM0_CQ_STS1_0                                         0xDA0160
+
+#define mmNIC3_QM0_CQ_STS1_1                                         0xDA0164
+
+#define mmNIC3_QM0_CQ_STS1_2                                         0xDA0168
+
+#define mmNIC3_QM0_CQ_STS1_3                                         0xDA016C
+
+#define mmNIC3_QM0_CQ_STS1_4                                         0xDA0170
+
+#define mmNIC3_QM0_CQ_PTR_LO_0                                       0xDA0174
+
+#define mmNIC3_QM0_CQ_PTR_HI_0                                       0xDA0178
+
+#define mmNIC3_QM0_CQ_TSIZE_0                                        0xDA017C
+
+#define mmNIC3_QM0_CQ_CTL_0                                          0xDA0180
+
+#define mmNIC3_QM0_CQ_PTR_LO_1                                       0xDA0184
+
+#define mmNIC3_QM0_CQ_PTR_HI_1                                       0xDA0188
+
+#define mmNIC3_QM0_CQ_TSIZE_1                                        0xDA018C
+
+#define mmNIC3_QM0_CQ_CTL_1                                          0xDA0190
+
+#define mmNIC3_QM0_CQ_PTR_LO_2                                       0xDA0194
+
+#define mmNIC3_QM0_CQ_PTR_HI_2                                       0xDA0198
+
+#define mmNIC3_QM0_CQ_TSIZE_2                                        0xDA019C
+
+#define mmNIC3_QM0_CQ_CTL_2                                          0xDA01A0
+
+#define mmNIC3_QM0_CQ_PTR_LO_3                                       0xDA01A4
+
+#define mmNIC3_QM0_CQ_PTR_HI_3                                       0xDA01A8
+
+#define mmNIC3_QM0_CQ_TSIZE_3                                        0xDA01AC
+
+#define mmNIC3_QM0_CQ_CTL_3                                          0xDA01B0
+
+#define mmNIC3_QM0_CQ_PTR_LO_4                                       0xDA01B4
+
+#define mmNIC3_QM0_CQ_PTR_HI_4                                       0xDA01B8
+
+#define mmNIC3_QM0_CQ_TSIZE_4                                        0xDA01BC
+
+#define mmNIC3_QM0_CQ_CTL_4                                          0xDA01C0
+
+#define mmNIC3_QM0_CQ_PTR_LO_STS_0                                   0xDA01C4
+
+#define mmNIC3_QM0_CQ_PTR_LO_STS_1                                   0xDA01C8
+
+#define mmNIC3_QM0_CQ_PTR_LO_STS_2                                   0xDA01CC
+
+#define mmNIC3_QM0_CQ_PTR_LO_STS_3                                   0xDA01D0
+
+#define mmNIC3_QM0_CQ_PTR_LO_STS_4                                   0xDA01D4
+
+#define mmNIC3_QM0_CQ_PTR_HI_STS_0                                   0xDA01D8
+
+#define mmNIC3_QM0_CQ_PTR_HI_STS_1                                   0xDA01DC
+
+#define mmNIC3_QM0_CQ_PTR_HI_STS_2                                   0xDA01E0
+
+#define mmNIC3_QM0_CQ_PTR_HI_STS_3                                   0xDA01E4
+
+#define mmNIC3_QM0_CQ_PTR_HI_STS_4                                   0xDA01E8
+
+#define mmNIC3_QM0_CQ_TSIZE_STS_0                                    0xDA01EC
+
+#define mmNIC3_QM0_CQ_TSIZE_STS_1                                    0xDA01F0
+
+#define mmNIC3_QM0_CQ_TSIZE_STS_2                                    0xDA01F4
+
+#define mmNIC3_QM0_CQ_TSIZE_STS_3                                    0xDA01F8
+
+#define mmNIC3_QM0_CQ_TSIZE_STS_4                                    0xDA01FC
+
+#define mmNIC3_QM0_CQ_CTL_STS_0                                      0xDA0200
+
+#define mmNIC3_QM0_CQ_CTL_STS_1                                      0xDA0204
+
+#define mmNIC3_QM0_CQ_CTL_STS_2                                      0xDA0208
+
+#define mmNIC3_QM0_CQ_CTL_STS_3                                      0xDA020C
+
+#define mmNIC3_QM0_CQ_CTL_STS_4                                      0xDA0210
+
+#define mmNIC3_QM0_CQ_IFIFO_CNT_0                                    0xDA0214
+
+#define mmNIC3_QM0_CQ_IFIFO_CNT_1                                    0xDA0218
+
+#define mmNIC3_QM0_CQ_IFIFO_CNT_2                                    0xDA021C
+
+#define mmNIC3_QM0_CQ_IFIFO_CNT_3                                    0xDA0220
+
+#define mmNIC3_QM0_CQ_IFIFO_CNT_4                                    0xDA0224
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_LO_0                            0xDA0228
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_LO_1                            0xDA022C
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_LO_2                            0xDA0230
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_LO_3                            0xDA0234
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_LO_4                            0xDA0238
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_HI_0                            0xDA023C
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_HI_1                            0xDA0240
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_HI_2                            0xDA0244
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_HI_3                            0xDA0248
+
+#define mmNIC3_QM0_CP_MSG_BASE0_ADDR_HI_4                            0xDA024C
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_LO_0                            0xDA0250
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_LO_1                            0xDA0254
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_LO_2                            0xDA0258
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_LO_3                            0xDA025C
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_LO_4                            0xDA0260
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_HI_0                            0xDA0264
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_HI_1                            0xDA0268
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_HI_2                            0xDA026C
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_HI_3                            0xDA0270
+
+#define mmNIC3_QM0_CP_MSG_BASE1_ADDR_HI_4                            0xDA0274
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_LO_0                            0xDA0278
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_LO_1                            0xDA027C
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_LO_2                            0xDA0280
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_LO_3                            0xDA0284
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_LO_4                            0xDA0288
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_HI_0                            0xDA028C
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_HI_1                            0xDA0290
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_HI_2                            0xDA0294
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_HI_3                            0xDA0298
+
+#define mmNIC3_QM0_CP_MSG_BASE2_ADDR_HI_4                            0xDA029C
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_LO_0                            0xDA02A0
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_LO_1                            0xDA02A4
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_LO_2                            0xDA02A8
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_LO_3                            0xDA02AC
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_LO_4                            0xDA02B0
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_HI_0                            0xDA02B4
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_HI_1                            0xDA02B8
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_HI_2                            0xDA02BC
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_HI_3                            0xDA02C0
+
+#define mmNIC3_QM0_CP_MSG_BASE3_ADDR_HI_4                            0xDA02C4
+
+#define mmNIC3_QM0_CP_LDMA_TSIZE_OFFSET_0                            0xDA02C8
+
+#define mmNIC3_QM0_CP_LDMA_TSIZE_OFFSET_1                            0xDA02CC
+
+#define mmNIC3_QM0_CP_LDMA_TSIZE_OFFSET_2                            0xDA02D0
+
+#define mmNIC3_QM0_CP_LDMA_TSIZE_OFFSET_3                            0xDA02D4
+
+#define mmNIC3_QM0_CP_LDMA_TSIZE_OFFSET_4                            0xDA02D8
+
+#define mmNIC3_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xDA02E0
+
+#define mmNIC3_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xDA02E4
+
+#define mmNIC3_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xDA02E8
+
+#define mmNIC3_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xDA02EC
+
+#define mmNIC3_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xDA02F0
+
+#define mmNIC3_QM0_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xDA02F4
+
+#define mmNIC3_QM0_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xDA02F8
+
+#define mmNIC3_QM0_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xDA02FC
+
+#define mmNIC3_QM0_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xDA0300
+
+#define mmNIC3_QM0_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xDA0304
+
+#define mmNIC3_QM0_CP_FENCE0_RDATA_0                                 0xDA0308
+
+#define mmNIC3_QM0_CP_FENCE0_RDATA_1                                 0xDA030C
+
+#define mmNIC3_QM0_CP_FENCE0_RDATA_2                                 0xDA0310
+
+#define mmNIC3_QM0_CP_FENCE0_RDATA_3                                 0xDA0314
+
+#define mmNIC3_QM0_CP_FENCE0_RDATA_4                                 0xDA0318
+
+#define mmNIC3_QM0_CP_FENCE1_RDATA_0                                 0xDA031C
+
+#define mmNIC3_QM0_CP_FENCE1_RDATA_1                                 0xDA0320
+
+#define mmNIC3_QM0_CP_FENCE1_RDATA_2                                 0xDA0324
+
+#define mmNIC3_QM0_CP_FENCE1_RDATA_3                                 0xDA0328
+
+#define mmNIC3_QM0_CP_FENCE1_RDATA_4                                 0xDA032C
+
+#define mmNIC3_QM0_CP_FENCE2_RDATA_0                                 0xDA0330
+
+#define mmNIC3_QM0_CP_FENCE2_RDATA_1                                 0xDA0334
+
+#define mmNIC3_QM0_CP_FENCE2_RDATA_2                                 0xDA0338
+
+#define mmNIC3_QM0_CP_FENCE2_RDATA_3                                 0xDA033C
+
+#define mmNIC3_QM0_CP_FENCE2_RDATA_4                                 0xDA0340
+
+#define mmNIC3_QM0_CP_FENCE3_RDATA_0                                 0xDA0344
+
+#define mmNIC3_QM0_CP_FENCE3_RDATA_1                                 0xDA0348
+
+#define mmNIC3_QM0_CP_FENCE3_RDATA_2                                 0xDA034C
+
+#define mmNIC3_QM0_CP_FENCE3_RDATA_3                                 0xDA0350
+
+#define mmNIC3_QM0_CP_FENCE3_RDATA_4                                 0xDA0354
+
+#define mmNIC3_QM0_CP_FENCE0_CNT_0                                   0xDA0358
+
+#define mmNIC3_QM0_CP_FENCE0_CNT_1                                   0xDA035C
+
+#define mmNIC3_QM0_CP_FENCE0_CNT_2                                   0xDA0360
+
+#define mmNIC3_QM0_CP_FENCE0_CNT_3                                   0xDA0364
+
+#define mmNIC3_QM0_CP_FENCE0_CNT_4                                   0xDA0368
+
+#define mmNIC3_QM0_CP_FENCE1_CNT_0                                   0xDA036C
+
+#define mmNIC3_QM0_CP_FENCE1_CNT_1                                   0xDA0370
+
+#define mmNIC3_QM0_CP_FENCE1_CNT_2                                   0xDA0374
+
+#define mmNIC3_QM0_CP_FENCE1_CNT_3                                   0xDA0378
+
+#define mmNIC3_QM0_CP_FENCE1_CNT_4                                   0xDA037C
+
+#define mmNIC3_QM0_CP_FENCE2_CNT_0                                   0xDA0380
+
+#define mmNIC3_QM0_CP_FENCE2_CNT_1                                   0xDA0384
+
+#define mmNIC3_QM0_CP_FENCE2_CNT_2                                   0xDA0388
+
+#define mmNIC3_QM0_CP_FENCE2_CNT_3                                   0xDA038C
+
+#define mmNIC3_QM0_CP_FENCE2_CNT_4                                   0xDA0390
+
+#define mmNIC3_QM0_CP_FENCE3_CNT_0                                   0xDA0394
+
+#define mmNIC3_QM0_CP_FENCE3_CNT_1                                   0xDA0398
+
+#define mmNIC3_QM0_CP_FENCE3_CNT_2                                   0xDA039C
+
+#define mmNIC3_QM0_CP_FENCE3_CNT_3                                   0xDA03A0
+
+#define mmNIC3_QM0_CP_FENCE3_CNT_4                                   0xDA03A4
+
+#define mmNIC3_QM0_CP_STS_0                                          0xDA03A8
+
+#define mmNIC3_QM0_CP_STS_1                                          0xDA03AC
+
+#define mmNIC3_QM0_CP_STS_2                                          0xDA03B0
+
+#define mmNIC3_QM0_CP_STS_3                                          0xDA03B4
+
+#define mmNIC3_QM0_CP_STS_4                                          0xDA03B8
+
+#define mmNIC3_QM0_CP_CURRENT_INST_LO_0                              0xDA03BC
+
+#define mmNIC3_QM0_CP_CURRENT_INST_LO_1                              0xDA03C0
+
+#define mmNIC3_QM0_CP_CURRENT_INST_LO_2                              0xDA03C4
+
+#define mmNIC3_QM0_CP_CURRENT_INST_LO_3                              0xDA03C8
+
+#define mmNIC3_QM0_CP_CURRENT_INST_LO_4                              0xDA03CC
+
+#define mmNIC3_QM0_CP_CURRENT_INST_HI_0                              0xDA03D0
+
+#define mmNIC3_QM0_CP_CURRENT_INST_HI_1                              0xDA03D4
+
+#define mmNIC3_QM0_CP_CURRENT_INST_HI_2                              0xDA03D8
+
+#define mmNIC3_QM0_CP_CURRENT_INST_HI_3                              0xDA03DC
+
+#define mmNIC3_QM0_CP_CURRENT_INST_HI_4                              0xDA03E0
+
+#define mmNIC3_QM0_CP_BARRIER_CFG_0                                  0xDA03F4
+
+#define mmNIC3_QM0_CP_BARRIER_CFG_1                                  0xDA03F8
+
+#define mmNIC3_QM0_CP_BARRIER_CFG_2                                  0xDA03FC
+
+#define mmNIC3_QM0_CP_BARRIER_CFG_3                                  0xDA0400
+
+#define mmNIC3_QM0_CP_BARRIER_CFG_4                                  0xDA0404
+
+#define mmNIC3_QM0_CP_DBG_0_0                                        0xDA0408
+
+#define mmNIC3_QM0_CP_DBG_0_1                                        0xDA040C
+
+#define mmNIC3_QM0_CP_DBG_0_2                                        0xDA0410
+
+#define mmNIC3_QM0_CP_DBG_0_3                                        0xDA0414
+
+#define mmNIC3_QM0_CP_DBG_0_4                                        0xDA0418
+
+#define mmNIC3_QM0_CP_ARUSER_31_11_0                                 0xDA041C
+
+#define mmNIC3_QM0_CP_ARUSER_31_11_1                                 0xDA0420
+
+#define mmNIC3_QM0_CP_ARUSER_31_11_2                                 0xDA0424
+
+#define mmNIC3_QM0_CP_ARUSER_31_11_3                                 0xDA0428
+
+#define mmNIC3_QM0_CP_ARUSER_31_11_4                                 0xDA042C
+
+#define mmNIC3_QM0_CP_AWUSER_31_11_0                                 0xDA0430
+
+#define mmNIC3_QM0_CP_AWUSER_31_11_1                                 0xDA0434
+
+#define mmNIC3_QM0_CP_AWUSER_31_11_2                                 0xDA0438
+
+#define mmNIC3_QM0_CP_AWUSER_31_11_3                                 0xDA043C
+
+#define mmNIC3_QM0_CP_AWUSER_31_11_4                                 0xDA0440
+
+#define mmNIC3_QM0_ARB_CFG_0                                         0xDA0A00
+
+#define mmNIC3_QM0_ARB_CHOISE_Q_PUSH                                 0xDA0A04
+
+#define mmNIC3_QM0_ARB_WRR_WEIGHT_0                                  0xDA0A08
+
+#define mmNIC3_QM0_ARB_WRR_WEIGHT_1                                  0xDA0A0C
+
+#define mmNIC3_QM0_ARB_WRR_WEIGHT_2                                  0xDA0A10
+
+#define mmNIC3_QM0_ARB_WRR_WEIGHT_3                                  0xDA0A14
+
+#define mmNIC3_QM0_ARB_CFG_1                                         0xDA0A18
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_0                              0xDA0A20
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_1                              0xDA0A24
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_2                              0xDA0A28
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_3                              0xDA0A2C
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_4                              0xDA0A30
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_5                              0xDA0A34
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_6                              0xDA0A38
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_7                              0xDA0A3C
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_8                              0xDA0A40
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_9                              0xDA0A44
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_10                             0xDA0A48
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_11                             0xDA0A4C
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_12                             0xDA0A50
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_13                             0xDA0A54
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_14                             0xDA0A58
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_15                             0xDA0A5C
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_16                             0xDA0A60
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_17                             0xDA0A64
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_18                             0xDA0A68
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_19                             0xDA0A6C
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_20                             0xDA0A70
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_21                             0xDA0A74
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_22                             0xDA0A78
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_23                             0xDA0A7C
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_24                             0xDA0A80
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_25                             0xDA0A84
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_26                             0xDA0A88
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_27                             0xDA0A8C
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_28                             0xDA0A90
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_29                             0xDA0A94
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_30                             0xDA0A98
+
+#define mmNIC3_QM0_ARB_MST_AVAIL_CRED_31                             0xDA0A9C
+
+#define mmNIC3_QM0_ARB_MST_CRED_INC                                  0xDA0AA0
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_0                        0xDA0AA4
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_1                        0xDA0AA8
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_2                        0xDA0AAC
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_3                        0xDA0AB0
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_4                        0xDA0AB4
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_5                        0xDA0AB8
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_6                        0xDA0ABC
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_7                        0xDA0AC0
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_8                        0xDA0AC4
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_9                        0xDA0AC8
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_10                       0xDA0ACC
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_11                       0xDA0AD0
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_12                       0xDA0AD4
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_13                       0xDA0AD8
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_14                       0xDA0ADC
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_15                       0xDA0AE0
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_16                       0xDA0AE4
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_17                       0xDA0AE8
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_18                       0xDA0AEC
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_19                       0xDA0AF0
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_20                       0xDA0AF4
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_21                       0xDA0AF8
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_22                       0xDA0AFC
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_23                       0xDA0B00
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_24                       0xDA0B04
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_25                       0xDA0B08
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_26                       0xDA0B0C
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_27                       0xDA0B10
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_28                       0xDA0B14
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_29                       0xDA0B18
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_30                       0xDA0B1C
+
+#define mmNIC3_QM0_ARB_MST_CHOISE_PUSH_OFST_31                       0xDA0B20
+
+#define mmNIC3_QM0_ARB_SLV_MASTER_INC_CRED_OFST                      0xDA0B28
+
+#define mmNIC3_QM0_ARB_MST_SLAVE_EN                                  0xDA0B2C
+
+#define mmNIC3_QM0_ARB_MST_QUIET_PER                                 0xDA0B34
+
+#define mmNIC3_QM0_ARB_SLV_CHOISE_WDT                                0xDA0B38
+
+#define mmNIC3_QM0_ARB_SLV_ID                                        0xDA0B3C
+
+#define mmNIC3_QM0_ARB_MSG_MAX_INFLIGHT                              0xDA0B44
+
+#define mmNIC3_QM0_ARB_MSG_AWUSER_31_11                              0xDA0B48
+
+#define mmNIC3_QM0_ARB_MSG_AWUSER_SEC_PROP                           0xDA0B4C
+
+#define mmNIC3_QM0_ARB_MSG_AWUSER_NON_SEC_PROP                       0xDA0B50
+
+#define mmNIC3_QM0_ARB_BASE_LO                                       0xDA0B54
+
+#define mmNIC3_QM0_ARB_BASE_HI                                       0xDA0B58
+
+#define mmNIC3_QM0_ARB_STATE_STS                                     0xDA0B80
+
+#define mmNIC3_QM0_ARB_CHOISE_FULLNESS_STS                           0xDA0B84
+
+#define mmNIC3_QM0_ARB_MSG_STS                                       0xDA0B88
+
+#define mmNIC3_QM0_ARB_SLV_CHOISE_Q_HEAD                             0xDA0B8C
+
+#define mmNIC3_QM0_ARB_ERR_CAUSE                                     0xDA0B9C
+
+#define mmNIC3_QM0_ARB_ERR_MSG_EN                                    0xDA0BA0
+
+#define mmNIC3_QM0_ARB_ERR_STS_DRP                                   0xDA0BA8
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_0                                0xDA0BB0
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_1                                0xDA0BB4
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_2                                0xDA0BB8
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_3                                0xDA0BBC
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_4                                0xDA0BC0
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_5                                0xDA0BC4
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_6                                0xDA0BC8
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_7                                0xDA0BCC
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_8                                0xDA0BD0
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_9                                0xDA0BD4
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_10                               0xDA0BD8
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_11                               0xDA0BDC
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_12                               0xDA0BE0
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_13                               0xDA0BE4
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_14                               0xDA0BE8
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_15                               0xDA0BEC
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_16                               0xDA0BF0
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_17                               0xDA0BF4
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_18                               0xDA0BF8
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_19                               0xDA0BFC
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_20                               0xDA0C00
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_21                               0xDA0C04
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_22                               0xDA0C08
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_23                               0xDA0C0C
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_24                               0xDA0C10
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_25                               0xDA0C14
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_26                               0xDA0C18
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_27                               0xDA0C1C
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_28                               0xDA0C20
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_29                               0xDA0C24
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_30                               0xDA0C28
+
+#define mmNIC3_QM0_ARB_MST_CRED_STS_31                               0xDA0C2C
+
+#define mmNIC3_QM0_CGM_CFG                                           0xDA0C70
+
+#define mmNIC3_QM0_CGM_STS                                           0xDA0C74
+
+#define mmNIC3_QM0_CGM_CFG1                                          0xDA0C78
+
+#define mmNIC3_QM0_LOCAL_RANGE_BASE                                  0xDA0C80
+
+#define mmNIC3_QM0_LOCAL_RANGE_SIZE                                  0xDA0C84
+
+#define mmNIC3_QM0_CSMR_STRICT_PRIO_CFG                              0xDA0C90
+
+#define mmNIC3_QM0_HBW_RD_RATE_LIM_CFG_1                             0xDA0C94
+
+#define mmNIC3_QM0_LBW_WR_RATE_LIM_CFG_0                             0xDA0C98
+
+#define mmNIC3_QM0_LBW_WR_RATE_LIM_CFG_1                             0xDA0C9C
+
+#define mmNIC3_QM0_HBW_RD_RATE_LIM_CFG_0                             0xDA0CA0
+
+#define mmNIC3_QM0_GLBL_AXCACHE                                      0xDA0CA4
+
+#define mmNIC3_QM0_IND_GW_APB_CFG                                    0xDA0CB0
+
+#define mmNIC3_QM0_IND_GW_APB_WDATA                                  0xDA0CB4
+
+#define mmNIC3_QM0_IND_GW_APB_RDATA                                  0xDA0CB8
+
+#define mmNIC3_QM0_IND_GW_APB_STATUS                                 0xDA0CBC
+
+#define mmNIC3_QM0_GLBL_ERR_ADDR_LO                                  0xDA0CD0
+
+#define mmNIC3_QM0_GLBL_ERR_ADDR_HI                                  0xDA0CD4
+
+#define mmNIC3_QM0_GLBL_ERR_WDATA                                    0xDA0CD8
+
+#define mmNIC3_QM0_GLBL_MEM_INIT_BUSY                                0xDA0D00
+
+#endif /* ASIC_REG_NIC3_QM0_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm1_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm1_regs.h
new file mode 100644
index 000000000000..7fa040f65004
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm1_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC3_QM1_REGS_H_
+#define ASIC_REG_NIC3_QM1_REGS_H_
+
+/*
+ *****************************************
+ *   NIC3_QM1 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC3_QM1_GLBL_CFG0                                         0xDA2000
+
+#define mmNIC3_QM1_GLBL_CFG1                                         0xDA2004
+
+#define mmNIC3_QM1_GLBL_PROT                                         0xDA2008
+
+#define mmNIC3_QM1_GLBL_ERR_CFG                                      0xDA200C
+
+#define mmNIC3_QM1_GLBL_SECURE_PROPS_0                               0xDA2010
+
+#define mmNIC3_QM1_GLBL_SECURE_PROPS_1                               0xDA2014
+
+#define mmNIC3_QM1_GLBL_SECURE_PROPS_2                               0xDA2018
+
+#define mmNIC3_QM1_GLBL_SECURE_PROPS_3                               0xDA201C
+
+#define mmNIC3_QM1_GLBL_SECURE_PROPS_4                               0xDA2020
+
+#define mmNIC3_QM1_GLBL_NON_SECURE_PROPS_0                           0xDA2024
+
+#define mmNIC3_QM1_GLBL_NON_SECURE_PROPS_1                           0xDA2028
+
+#define mmNIC3_QM1_GLBL_NON_SECURE_PROPS_2                           0xDA202C
+
+#define mmNIC3_QM1_GLBL_NON_SECURE_PROPS_3                           0xDA2030
+
+#define mmNIC3_QM1_GLBL_NON_SECURE_PROPS_4                           0xDA2034
+
+#define mmNIC3_QM1_GLBL_STS0                                         0xDA2038
+
+#define mmNIC3_QM1_GLBL_STS1_0                                       0xDA2040
+
+#define mmNIC3_QM1_GLBL_STS1_1                                       0xDA2044
+
+#define mmNIC3_QM1_GLBL_STS1_2                                       0xDA2048
+
+#define mmNIC3_QM1_GLBL_STS1_3                                       0xDA204C
+
+#define mmNIC3_QM1_GLBL_STS1_4                                       0xDA2050
+
+#define mmNIC3_QM1_GLBL_MSG_EN_0                                     0xDA2054
+
+#define mmNIC3_QM1_GLBL_MSG_EN_1                                     0xDA2058
+
+#define mmNIC3_QM1_GLBL_MSG_EN_2                                     0xDA205C
+
+#define mmNIC3_QM1_GLBL_MSG_EN_3                                     0xDA2060
+
+#define mmNIC3_QM1_GLBL_MSG_EN_4                                     0xDA2068
+
+#define mmNIC3_QM1_PQ_BASE_LO_0                                      0xDA2070
+
+#define mmNIC3_QM1_PQ_BASE_LO_1                                      0xDA2074
+
+#define mmNIC3_QM1_PQ_BASE_LO_2                                      0xDA2078
+
+#define mmNIC3_QM1_PQ_BASE_LO_3                                      0xDA207C
+
+#define mmNIC3_QM1_PQ_BASE_HI_0                                      0xDA2080
+
+#define mmNIC3_QM1_PQ_BASE_HI_1                                      0xDA2084
+
+#define mmNIC3_QM1_PQ_BASE_HI_2                                      0xDA2088
+
+#define mmNIC3_QM1_PQ_BASE_HI_3                                      0xDA208C
+
+#define mmNIC3_QM1_PQ_SIZE_0                                         0xDA2090
+
+#define mmNIC3_QM1_PQ_SIZE_1                                         0xDA2094
+
+#define mmNIC3_QM1_PQ_SIZE_2                                         0xDA2098
+
+#define mmNIC3_QM1_PQ_SIZE_3                                         0xDA209C
+
+#define mmNIC3_QM1_PQ_PI_0                                           0xDA20A0
+
+#define mmNIC3_QM1_PQ_PI_1                                           0xDA20A4
+
+#define mmNIC3_QM1_PQ_PI_2                                           0xDA20A8
+
+#define mmNIC3_QM1_PQ_PI_3                                           0xDA20AC
+
+#define mmNIC3_QM1_PQ_CI_0                                           0xDA20B0
+
+#define mmNIC3_QM1_PQ_CI_1                                           0xDA20B4
+
+#define mmNIC3_QM1_PQ_CI_2                                           0xDA20B8
+
+#define mmNIC3_QM1_PQ_CI_3                                           0xDA20BC
+
+#define mmNIC3_QM1_PQ_CFG0_0                                         0xDA20C0
+
+#define mmNIC3_QM1_PQ_CFG0_1                                         0xDA20C4
+
+#define mmNIC3_QM1_PQ_CFG0_2                                         0xDA20C8
+
+#define mmNIC3_QM1_PQ_CFG0_3                                         0xDA20CC
+
+#define mmNIC3_QM1_PQ_CFG1_0                                         0xDA20D0
+
+#define mmNIC3_QM1_PQ_CFG1_1                                         0xDA20D4
+
+#define mmNIC3_QM1_PQ_CFG1_2                                         0xDA20D8
+
+#define mmNIC3_QM1_PQ_CFG1_3                                         0xDA20DC
+
+#define mmNIC3_QM1_PQ_ARUSER_31_11_0                                 0xDA20E0
+
+#define mmNIC3_QM1_PQ_ARUSER_31_11_1                                 0xDA20E4
+
+#define mmNIC3_QM1_PQ_ARUSER_31_11_2                                 0xDA20E8
+
+#define mmNIC3_QM1_PQ_ARUSER_31_11_3                                 0xDA20EC
+
+#define mmNIC3_QM1_PQ_STS0_0                                         0xDA20F0
+
+#define mmNIC3_QM1_PQ_STS0_1                                         0xDA20F4
+
+#define mmNIC3_QM1_PQ_STS0_2                                         0xDA20F8
+
+#define mmNIC3_QM1_PQ_STS0_3                                         0xDA20FC
+
+#define mmNIC3_QM1_PQ_STS1_0                                         0xDA2100
+
+#define mmNIC3_QM1_PQ_STS1_1                                         0xDA2104
+
+#define mmNIC3_QM1_PQ_STS1_2                                         0xDA2108
+
+#define mmNIC3_QM1_PQ_STS1_3                                         0xDA210C
+
+#define mmNIC3_QM1_CQ_CFG0_0                                         0xDA2110
+
+#define mmNIC3_QM1_CQ_CFG0_1                                         0xDA2114
+
+#define mmNIC3_QM1_CQ_CFG0_2                                         0xDA2118
+
+#define mmNIC3_QM1_CQ_CFG0_3                                         0xDA211C
+
+#define mmNIC3_QM1_CQ_CFG0_4                                         0xDA2120
+
+#define mmNIC3_QM1_CQ_CFG1_0                                         0xDA2124
+
+#define mmNIC3_QM1_CQ_CFG1_1                                         0xDA2128
+
+#define mmNIC3_QM1_CQ_CFG1_2                                         0xDA212C
+
+#define mmNIC3_QM1_CQ_CFG1_3                                         0xDA2130
+
+#define mmNIC3_QM1_CQ_CFG1_4                                         0xDA2134
+
+#define mmNIC3_QM1_CQ_ARUSER_31_11_0                                 0xDA2138
+
+#define mmNIC3_QM1_CQ_ARUSER_31_11_1                                 0xDA213C
+
+#define mmNIC3_QM1_CQ_ARUSER_31_11_2                                 0xDA2140
+
+#define mmNIC3_QM1_CQ_ARUSER_31_11_3                                 0xDA2144
+
+#define mmNIC3_QM1_CQ_ARUSER_31_11_4                                 0xDA2148
+
+#define mmNIC3_QM1_CQ_STS0_0                                         0xDA214C
+
+#define mmNIC3_QM1_CQ_STS0_1                                         0xDA2150
+
+#define mmNIC3_QM1_CQ_STS0_2                                         0xDA2154
+
+#define mmNIC3_QM1_CQ_STS0_3                                         0xDA2158
+
+#define mmNIC3_QM1_CQ_STS0_4                                         0xDA215C
+
+#define mmNIC3_QM1_CQ_STS1_0                                         0xDA2160
+
+#define mmNIC3_QM1_CQ_STS1_1                                         0xDA2164
+
+#define mmNIC3_QM1_CQ_STS1_2                                         0xDA2168
+
+#define mmNIC3_QM1_CQ_STS1_3                                         0xDA216C
+
+#define mmNIC3_QM1_CQ_STS1_4                                         0xDA2170
+
+#define mmNIC3_QM1_CQ_PTR_LO_0                                       0xDA2174
+
+#define mmNIC3_QM1_CQ_PTR_HI_0                                       0xDA2178
+
+#define mmNIC3_QM1_CQ_TSIZE_0                                        0xDA217C
+
+#define mmNIC3_QM1_CQ_CTL_0                                          0xDA2180
+
+#define mmNIC3_QM1_CQ_PTR_LO_1                                       0xDA2184
+
+#define mmNIC3_QM1_CQ_PTR_HI_1                                       0xDA2188
+
+#define mmNIC3_QM1_CQ_TSIZE_1                                        0xDA218C
+
+#define mmNIC3_QM1_CQ_CTL_1                                          0xDA2190
+
+#define mmNIC3_QM1_CQ_PTR_LO_2                                       0xDA2194
+
+#define mmNIC3_QM1_CQ_PTR_HI_2                                       0xDA2198
+
+#define mmNIC3_QM1_CQ_TSIZE_2                                        0xDA219C
+
+#define mmNIC3_QM1_CQ_CTL_2                                          0xDA21A0
+
+#define mmNIC3_QM1_CQ_PTR_LO_3                                       0xDA21A4
+
+#define mmNIC3_QM1_CQ_PTR_HI_3                                       0xDA21A8
+
+#define mmNIC3_QM1_CQ_TSIZE_3                                        0xDA21AC
+
+#define mmNIC3_QM1_CQ_CTL_3                                          0xDA21B0
+
+#define mmNIC3_QM1_CQ_PTR_LO_4                                       0xDA21B4
+
+#define mmNIC3_QM1_CQ_PTR_HI_4                                       0xDA21B8
+
+#define mmNIC3_QM1_CQ_TSIZE_4                                        0xDA21BC
+
+#define mmNIC3_QM1_CQ_CTL_4                                          0xDA21C0
+
+#define mmNIC3_QM1_CQ_PTR_LO_STS_0                                   0xDA21C4
+
+#define mmNIC3_QM1_CQ_PTR_LO_STS_1                                   0xDA21C8
+
+#define mmNIC3_QM1_CQ_PTR_LO_STS_2                                   0xDA21CC
+
+#define mmNIC3_QM1_CQ_PTR_LO_STS_3                                   0xDA21D0
+
+#define mmNIC3_QM1_CQ_PTR_LO_STS_4                                   0xDA21D4
+
+#define mmNIC3_QM1_CQ_PTR_HI_STS_0                                   0xDA21D8
+
+#define mmNIC3_QM1_CQ_PTR_HI_STS_1                                   0xDA21DC
+
+#define mmNIC3_QM1_CQ_PTR_HI_STS_2                                   0xDA21E0
+
+#define mmNIC3_QM1_CQ_PTR_HI_STS_3                                   0xDA21E4
+
+#define mmNIC3_QM1_CQ_PTR_HI_STS_4                                   0xDA21E8
+
+#define mmNIC3_QM1_CQ_TSIZE_STS_0                                    0xDA21EC
+
+#define mmNIC3_QM1_CQ_TSIZE_STS_1                                    0xDA21F0
+
+#define mmNIC3_QM1_CQ_TSIZE_STS_2                                    0xDA21F4
+
+#define mmNIC3_QM1_CQ_TSIZE_STS_3                                    0xDA21F8
+
+#define mmNIC3_QM1_CQ_TSIZE_STS_4                                    0xDA21FC
+
+#define mmNIC3_QM1_CQ_CTL_STS_0                                      0xDA2200
+
+#define mmNIC3_QM1_CQ_CTL_STS_1                                      0xDA2204
+
+#define mmNIC3_QM1_CQ_CTL_STS_2                                      0xDA2208
+
+#define mmNIC3_QM1_CQ_CTL_STS_3                                      0xDA220C
+
+#define mmNIC3_QM1_CQ_CTL_STS_4                                      0xDA2210
+
+#define mmNIC3_QM1_CQ_IFIFO_CNT_0                                    0xDA2214
+
+#define mmNIC3_QM1_CQ_IFIFO_CNT_1                                    0xDA2218
+
+#define mmNIC3_QM1_CQ_IFIFO_CNT_2                                    0xDA221C
+
+#define mmNIC3_QM1_CQ_IFIFO_CNT_3                                    0xDA2220
+
+#define mmNIC3_QM1_CQ_IFIFO_CNT_4                                    0xDA2224
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_LO_0                            0xDA2228
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_LO_1                            0xDA222C
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_LO_2                            0xDA2230
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_LO_3                            0xDA2234
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_LO_4                            0xDA2238
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_HI_0                            0xDA223C
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_HI_1                            0xDA2240
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_HI_2                            0xDA2244
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_HI_3                            0xDA2248
+
+#define mmNIC3_QM1_CP_MSG_BASE0_ADDR_HI_4                            0xDA224C
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_LO_0                            0xDA2250
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_LO_1                            0xDA2254
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_LO_2                            0xDA2258
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_LO_3                            0xDA225C
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_LO_4                            0xDA2260
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_HI_0                            0xDA2264
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_HI_1                            0xDA2268
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_HI_2                            0xDA226C
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_HI_3                            0xDA2270
+
+#define mmNIC3_QM1_CP_MSG_BASE1_ADDR_HI_4                            0xDA2274
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_LO_0                            0xDA2278
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_LO_1                            0xDA227C
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_LO_2                            0xDA2280
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_LO_3                            0xDA2284
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_LO_4                            0xDA2288
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_HI_0                            0xDA228C
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_HI_1                            0xDA2290
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_HI_2                            0xDA2294
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_HI_3                            0xDA2298
+
+#define mmNIC3_QM1_CP_MSG_BASE2_ADDR_HI_4                            0xDA229C
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_LO_0                            0xDA22A0
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_LO_1                            0xDA22A4
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_LO_2                            0xDA22A8
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_LO_3                            0xDA22AC
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_LO_4                            0xDA22B0
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_HI_0                            0xDA22B4
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_HI_1                            0xDA22B8
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_HI_2                            0xDA22BC
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_HI_3                            0xDA22C0
+
+#define mmNIC3_QM1_CP_MSG_BASE3_ADDR_HI_4                            0xDA22C4
+
+#define mmNIC3_QM1_CP_LDMA_TSIZE_OFFSET_0                            0xDA22C8
+
+#define mmNIC3_QM1_CP_LDMA_TSIZE_OFFSET_1                            0xDA22CC
+
+#define mmNIC3_QM1_CP_LDMA_TSIZE_OFFSET_2                            0xDA22D0
+
+#define mmNIC3_QM1_CP_LDMA_TSIZE_OFFSET_3                            0xDA22D4
+
+#define mmNIC3_QM1_CP_LDMA_TSIZE_OFFSET_4                            0xDA22D8
+
+#define mmNIC3_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xDA22E0
+
+#define mmNIC3_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xDA22E4
+
+#define mmNIC3_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xDA22E8
+
+#define mmNIC3_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xDA22EC
+
+#define mmNIC3_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xDA22F0
+
+#define mmNIC3_QM1_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xDA22F4
+
+#define mmNIC3_QM1_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xDA22F8
+
+#define mmNIC3_QM1_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xDA22FC
+
+#define mmNIC3_QM1_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xDA2300
+
+#define mmNIC3_QM1_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xDA2304
+
+#define mmNIC3_QM1_CP_FENCE0_RDATA_0                                 0xDA2308
+
+#define mmNIC3_QM1_CP_FENCE0_RDATA_1                                 0xDA230C
+
+#define mmNIC3_QM1_CP_FENCE0_RDATA_2                                 0xDA2310
+
+#define mmNIC3_QM1_CP_FENCE0_RDATA_3                                 0xDA2314
+
+#define mmNIC3_QM1_CP_FENCE0_RDATA_4                                 0xDA2318
+
+#define mmNIC3_QM1_CP_FENCE1_RDATA_0                                 0xDA231C
+
+#define mmNIC3_QM1_CP_FENCE1_RDATA_1                                 0xDA2320
+
+#define mmNIC3_QM1_CP_FENCE1_RDATA_2                                 0xDA2324
+
+#define mmNIC3_QM1_CP_FENCE1_RDATA_3                                 0xDA2328
+
+#define mmNIC3_QM1_CP_FENCE1_RDATA_4                                 0xDA232C
+
+#define mmNIC3_QM1_CP_FENCE2_RDATA_0                                 0xDA2330
+
+#define mmNIC3_QM1_CP_FENCE2_RDATA_1                                 0xDA2334
+
+#define mmNIC3_QM1_CP_FENCE2_RDATA_2                                 0xDA2338
+
+#define mmNIC3_QM1_CP_FENCE2_RDATA_3                                 0xDA233C
+
+#define mmNIC3_QM1_CP_FENCE2_RDATA_4                                 0xDA2340
+
+#define mmNIC3_QM1_CP_FENCE3_RDATA_0                                 0xDA2344
+
+#define mmNIC3_QM1_CP_FENCE3_RDATA_1                                 0xDA2348
+
+#define mmNIC3_QM1_CP_FENCE3_RDATA_2                                 0xDA234C
+
+#define mmNIC3_QM1_CP_FENCE3_RDATA_3                                 0xDA2350
+
+#define mmNIC3_QM1_CP_FENCE3_RDATA_4                                 0xDA2354
+
+#define mmNIC3_QM1_CP_FENCE0_CNT_0                                   0xDA2358
+
+#define mmNIC3_QM1_CP_FENCE0_CNT_1                                   0xDA235C
+
+#define mmNIC3_QM1_CP_FENCE0_CNT_2                                   0xDA2360
+
+#define mmNIC3_QM1_CP_FENCE0_CNT_3                                   0xDA2364
+
+#define mmNIC3_QM1_CP_FENCE0_CNT_4                                   0xDA2368
+
+#define mmNIC3_QM1_CP_FENCE1_CNT_0                                   0xDA236C
+
+#define mmNIC3_QM1_CP_FENCE1_CNT_1                                   0xDA2370
+
+#define mmNIC3_QM1_CP_FENCE1_CNT_2                                   0xDA2374
+
+#define mmNIC3_QM1_CP_FENCE1_CNT_3                                   0xDA2378
+
+#define mmNIC3_QM1_CP_FENCE1_CNT_4                                   0xDA237C
+
+#define mmNIC3_QM1_CP_FENCE2_CNT_0                                   0xDA2380
+
+#define mmNIC3_QM1_CP_FENCE2_CNT_1                                   0xDA2384
+
+#define mmNIC3_QM1_CP_FENCE2_CNT_2                                   0xDA2388
+
+#define mmNIC3_QM1_CP_FENCE2_CNT_3                                   0xDA238C
+
+#define mmNIC3_QM1_CP_FENCE2_CNT_4                                   0xDA2390
+
+#define mmNIC3_QM1_CP_FENCE3_CNT_0                                   0xDA2394
+
+#define mmNIC3_QM1_CP_FENCE3_CNT_1                                   0xDA2398
+
+#define mmNIC3_QM1_CP_FENCE3_CNT_2                                   0xDA239C
+
+#define mmNIC3_QM1_CP_FENCE3_CNT_3                                   0xDA23A0
+
+#define mmNIC3_QM1_CP_FENCE3_CNT_4                                   0xDA23A4
+
+#define mmNIC3_QM1_CP_STS_0                                          0xDA23A8
+
+#define mmNIC3_QM1_CP_STS_1                                          0xDA23AC
+
+#define mmNIC3_QM1_CP_STS_2                                          0xDA23B0
+
+#define mmNIC3_QM1_CP_STS_3                                          0xDA23B4
+
+#define mmNIC3_QM1_CP_STS_4                                          0xDA23B8
+
+#define mmNIC3_QM1_CP_CURRENT_INST_LO_0                              0xDA23BC
+
+#define mmNIC3_QM1_CP_CURRENT_INST_LO_1                              0xDA23C0
+
+#define mmNIC3_QM1_CP_CURRENT_INST_LO_2                              0xDA23C4
+
+#define mmNIC3_QM1_CP_CURRENT_INST_LO_3                              0xDA23C8
+
+#define mmNIC3_QM1_CP_CURRENT_INST_LO_4                              0xDA23CC
+
+#define mmNIC3_QM1_CP_CURRENT_INST_HI_0                              0xDA23D0
+
+#define mmNIC3_QM1_CP_CURRENT_INST_HI_1                              0xDA23D4
+
+#define mmNIC3_QM1_CP_CURRENT_INST_HI_2                              0xDA23D8
+
+#define mmNIC3_QM1_CP_CURRENT_INST_HI_3                              0xDA23DC
+
+#define mmNIC3_QM1_CP_CURRENT_INST_HI_4                              0xDA23E0
+
+#define mmNIC3_QM1_CP_BARRIER_CFG_0                                  0xDA23F4
+
+#define mmNIC3_QM1_CP_BARRIER_CFG_1                                  0xDA23F8
+
+#define mmNIC3_QM1_CP_BARRIER_CFG_2                                  0xDA23FC
+
+#define mmNIC3_QM1_CP_BARRIER_CFG_3                                  0xDA2400
+
+#define mmNIC3_QM1_CP_BARRIER_CFG_4                                  0xDA2404
+
+#define mmNIC3_QM1_CP_DBG_0_0                                        0xDA2408
+
+#define mmNIC3_QM1_CP_DBG_0_1                                        0xDA240C
+
+#define mmNIC3_QM1_CP_DBG_0_2                                        0xDA2410
+
+#define mmNIC3_QM1_CP_DBG_0_3                                        0xDA2414
+
+#define mmNIC3_QM1_CP_DBG_0_4                                        0xDA2418
+
+#define mmNIC3_QM1_CP_ARUSER_31_11_0                                 0xDA241C
+
+#define mmNIC3_QM1_CP_ARUSER_31_11_1                                 0xDA2420
+
+#define mmNIC3_QM1_CP_ARUSER_31_11_2                                 0xDA2424
+
+#define mmNIC3_QM1_CP_ARUSER_31_11_3                                 0xDA2428
+
+#define mmNIC3_QM1_CP_ARUSER_31_11_4                                 0xDA242C
+
+#define mmNIC3_QM1_CP_AWUSER_31_11_0                                 0xDA2430
+
+#define mmNIC3_QM1_CP_AWUSER_31_11_1                                 0xDA2434
+
+#define mmNIC3_QM1_CP_AWUSER_31_11_2                                 0xDA2438
+
+#define mmNIC3_QM1_CP_AWUSER_31_11_3                                 0xDA243C
+
+#define mmNIC3_QM1_CP_AWUSER_31_11_4                                 0xDA2440
+
+#define mmNIC3_QM1_ARB_CFG_0                                         0xDA2A00
+
+#define mmNIC3_QM1_ARB_CHOISE_Q_PUSH                                 0xDA2A04
+
+#define mmNIC3_QM1_ARB_WRR_WEIGHT_0                                  0xDA2A08
+
+#define mmNIC3_QM1_ARB_WRR_WEIGHT_1                                  0xDA2A0C
+
+#define mmNIC3_QM1_ARB_WRR_WEIGHT_2                                  0xDA2A10
+
+#define mmNIC3_QM1_ARB_WRR_WEIGHT_3                                  0xDA2A14
+
+#define mmNIC3_QM1_ARB_CFG_1                                         0xDA2A18
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_0                              0xDA2A20
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_1                              0xDA2A24
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_2                              0xDA2A28
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_3                              0xDA2A2C
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_4                              0xDA2A30
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_5                              0xDA2A34
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_6                              0xDA2A38
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_7                              0xDA2A3C
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_8                              0xDA2A40
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_9                              0xDA2A44
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_10                             0xDA2A48
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_11                             0xDA2A4C
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_12                             0xDA2A50
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_13                             0xDA2A54
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_14                             0xDA2A58
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_15                             0xDA2A5C
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_16                             0xDA2A60
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_17                             0xDA2A64
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_18                             0xDA2A68
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_19                             0xDA2A6C
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_20                             0xDA2A70
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_21                             0xDA2A74
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_22                             0xDA2A78
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_23                             0xDA2A7C
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_24                             0xDA2A80
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_25                             0xDA2A84
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_26                             0xDA2A88
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_27                             0xDA2A8C
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_28                             0xDA2A90
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_29                             0xDA2A94
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_30                             0xDA2A98
+
+#define mmNIC3_QM1_ARB_MST_AVAIL_CRED_31                             0xDA2A9C
+
+#define mmNIC3_QM1_ARB_MST_CRED_INC                                  0xDA2AA0
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_0                        0xDA2AA4
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_1                        0xDA2AA8
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_2                        0xDA2AAC
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_3                        0xDA2AB0
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_4                        0xDA2AB4
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_5                        0xDA2AB8
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_6                        0xDA2ABC
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_7                        0xDA2AC0
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_8                        0xDA2AC4
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_9                        0xDA2AC8
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_10                       0xDA2ACC
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_11                       0xDA2AD0
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_12                       0xDA2AD4
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_13                       0xDA2AD8
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_14                       0xDA2ADC
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_15                       0xDA2AE0
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_16                       0xDA2AE4
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_17                       0xDA2AE8
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_18                       0xDA2AEC
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_19                       0xDA2AF0
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_20                       0xDA2AF4
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_21                       0xDA2AF8
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_22                       0xDA2AFC
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_23                       0xDA2B00
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_24                       0xDA2B04
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_25                       0xDA2B08
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_26                       0xDA2B0C
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_27                       0xDA2B10
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_28                       0xDA2B14
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_29                       0xDA2B18
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_30                       0xDA2B1C
+
+#define mmNIC3_QM1_ARB_MST_CHOISE_PUSH_OFST_31                       0xDA2B20
+
+#define mmNIC3_QM1_ARB_SLV_MASTER_INC_CRED_OFST                      0xDA2B28
+
+#define mmNIC3_QM1_ARB_MST_SLAVE_EN                                  0xDA2B2C
+
+#define mmNIC3_QM1_ARB_MST_QUIET_PER                                 0xDA2B34
+
+#define mmNIC3_QM1_ARB_SLV_CHOISE_WDT                                0xDA2B38
+
+#define mmNIC3_QM1_ARB_SLV_ID                                        0xDA2B3C
+
+#define mmNIC3_QM1_ARB_MSG_MAX_INFLIGHT                              0xDA2B44
+
+#define mmNIC3_QM1_ARB_MSG_AWUSER_31_11                              0xDA2B48
+
+#define mmNIC3_QM1_ARB_MSG_AWUSER_SEC_PROP                           0xDA2B4C
+
+#define mmNIC3_QM1_ARB_MSG_AWUSER_NON_SEC_PROP                       0xDA2B50
+
+#define mmNIC3_QM1_ARB_BASE_LO                                       0xDA2B54
+
+#define mmNIC3_QM1_ARB_BASE_HI                                       0xDA2B58
+
+#define mmNIC3_QM1_ARB_STATE_STS                                     0xDA2B80
+
+#define mmNIC3_QM1_ARB_CHOISE_FULLNESS_STS                           0xDA2B84
+
+#define mmNIC3_QM1_ARB_MSG_STS                                       0xDA2B88
+
+#define mmNIC3_QM1_ARB_SLV_CHOISE_Q_HEAD                             0xDA2B8C
+
+#define mmNIC3_QM1_ARB_ERR_CAUSE                                     0xDA2B9C
+
+#define mmNIC3_QM1_ARB_ERR_MSG_EN                                    0xDA2BA0
+
+#define mmNIC3_QM1_ARB_ERR_STS_DRP                                   0xDA2BA8
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_0                                0xDA2BB0
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_1                                0xDA2BB4
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_2                                0xDA2BB8
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_3                                0xDA2BBC
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_4                                0xDA2BC0
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_5                                0xDA2BC4
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_6                                0xDA2BC8
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_7                                0xDA2BCC
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_8                                0xDA2BD0
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_9                                0xDA2BD4
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_10                               0xDA2BD8
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_11                               0xDA2BDC
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_12                               0xDA2BE0
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_13                               0xDA2BE4
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_14                               0xDA2BE8
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_15                               0xDA2BEC
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_16                               0xDA2BF0
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_17                               0xDA2BF4
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_18                               0xDA2BF8
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_19                               0xDA2BFC
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_20                               0xDA2C00
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_21                               0xDA2C04
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_22                               0xDA2C08
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_23                               0xDA2C0C
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_24                               0xDA2C10
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_25                               0xDA2C14
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_26                               0xDA2C18
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_27                               0xDA2C1C
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_28                               0xDA2C20
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_29                               0xDA2C24
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_30                               0xDA2C28
+
+#define mmNIC3_QM1_ARB_MST_CRED_STS_31                               0xDA2C2C
+
+#define mmNIC3_QM1_CGM_CFG                                           0xDA2C70
+
+#define mmNIC3_QM1_CGM_STS                                           0xDA2C74
+
+#define mmNIC3_QM1_CGM_CFG1                                          0xDA2C78
+
+#define mmNIC3_QM1_LOCAL_RANGE_BASE                                  0xDA2C80
+
+#define mmNIC3_QM1_LOCAL_RANGE_SIZE                                  0xDA2C84
+
+#define mmNIC3_QM1_CSMR_STRICT_PRIO_CFG                              0xDA2C90
+
+#define mmNIC3_QM1_HBW_RD_RATE_LIM_CFG_1                             0xDA2C94
+
+#define mmNIC3_QM1_LBW_WR_RATE_LIM_CFG_0                             0xDA2C98
+
+#define mmNIC3_QM1_LBW_WR_RATE_LIM_CFG_1                             0xDA2C9C
+
+#define mmNIC3_QM1_HBW_RD_RATE_LIM_CFG_0                             0xDA2CA0
+
+#define mmNIC3_QM1_GLBL_AXCACHE                                      0xDA2CA4
+
+#define mmNIC3_QM1_IND_GW_APB_CFG                                    0xDA2CB0
+
+#define mmNIC3_QM1_IND_GW_APB_WDATA                                  0xDA2CB4
+
+#define mmNIC3_QM1_IND_GW_APB_RDATA                                  0xDA2CB8
+
+#define mmNIC3_QM1_IND_GW_APB_STATUS                                 0xDA2CBC
+
+#define mmNIC3_QM1_GLBL_ERR_ADDR_LO                                  0xDA2CD0
+
+#define mmNIC3_QM1_GLBL_ERR_ADDR_HI                                  0xDA2CD4
+
+#define mmNIC3_QM1_GLBL_ERR_WDATA                                    0xDA2CD8
+
+#define mmNIC3_QM1_GLBL_MEM_INIT_BUSY                                0xDA2D00
+
+#endif /* ASIC_REG_NIC3_QM1_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm0_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm0_regs.h
new file mode 100644
index 000000000000..99d5319672dd
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm0_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC4_QM0_REGS_H_
+#define ASIC_REG_NIC4_QM0_REGS_H_
+
+/*
+ *****************************************
+ *   NIC4_QM0 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC4_QM0_GLBL_CFG0                                         0xDE0000
+
+#define mmNIC4_QM0_GLBL_CFG1                                         0xDE0004
+
+#define mmNIC4_QM0_GLBL_PROT                                         0xDE0008
+
+#define mmNIC4_QM0_GLBL_ERR_CFG                                      0xDE000C
+
+#define mmNIC4_QM0_GLBL_SECURE_PROPS_0                               0xDE0010
+
+#define mmNIC4_QM0_GLBL_SECURE_PROPS_1                               0xDE0014
+
+#define mmNIC4_QM0_GLBL_SECURE_PROPS_2                               0xDE0018
+
+#define mmNIC4_QM0_GLBL_SECURE_PROPS_3                               0xDE001C
+
+#define mmNIC4_QM0_GLBL_SECURE_PROPS_4                               0xDE0020
+
+#define mmNIC4_QM0_GLBL_NON_SECURE_PROPS_0                           0xDE0024
+
+#define mmNIC4_QM0_GLBL_NON_SECURE_PROPS_1                           0xDE0028
+
+#define mmNIC4_QM0_GLBL_NON_SECURE_PROPS_2                           0xDE002C
+
+#define mmNIC4_QM0_GLBL_NON_SECURE_PROPS_3                           0xDE0030
+
+#define mmNIC4_QM0_GLBL_NON_SECURE_PROPS_4                           0xDE0034
+
+#define mmNIC4_QM0_GLBL_STS0                                         0xDE0038
+
+#define mmNIC4_QM0_GLBL_STS1_0                                       0xDE0040
+
+#define mmNIC4_QM0_GLBL_STS1_1                                       0xDE0044
+
+#define mmNIC4_QM0_GLBL_STS1_2                                       0xDE0048
+
+#define mmNIC4_QM0_GLBL_STS1_3                                       0xDE004C
+
+#define mmNIC4_QM0_GLBL_STS1_4                                       0xDE0050
+
+#define mmNIC4_QM0_GLBL_MSG_EN_0                                     0xDE0054
+
+#define mmNIC4_QM0_GLBL_MSG_EN_1                                     0xDE0058
+
+#define mmNIC4_QM0_GLBL_MSG_EN_2                                     0xDE005C
+
+#define mmNIC4_QM0_GLBL_MSG_EN_3                                     0xDE0060
+
+#define mmNIC4_QM0_GLBL_MSG_EN_4                                     0xDE0068
+
+#define mmNIC4_QM0_PQ_BASE_LO_0                                      0xDE0070
+
+#define mmNIC4_QM0_PQ_BASE_LO_1                                      0xDE0074
+
+#define mmNIC4_QM0_PQ_BASE_LO_2                                      0xDE0078
+
+#define mmNIC4_QM0_PQ_BASE_LO_3                                      0xDE007C
+
+#define mmNIC4_QM0_PQ_BASE_HI_0                                      0xDE0080
+
+#define mmNIC4_QM0_PQ_BASE_HI_1                                      0xDE0084
+
+#define mmNIC4_QM0_PQ_BASE_HI_2                                      0xDE0088
+
+#define mmNIC4_QM0_PQ_BASE_HI_3                                      0xDE008C
+
+#define mmNIC4_QM0_PQ_SIZE_0                                         0xDE0090
+
+#define mmNIC4_QM0_PQ_SIZE_1                                         0xDE0094
+
+#define mmNIC4_QM0_PQ_SIZE_2                                         0xDE0098
+
+#define mmNIC4_QM0_PQ_SIZE_3                                         0xDE009C
+
+#define mmNIC4_QM0_PQ_PI_0                                           0xDE00A0
+
+#define mmNIC4_QM0_PQ_PI_1                                           0xDE00A4
+
+#define mmNIC4_QM0_PQ_PI_2                                           0xDE00A8
+
+#define mmNIC4_QM0_PQ_PI_3                                           0xDE00AC
+
+#define mmNIC4_QM0_PQ_CI_0                                           0xDE00B0
+
+#define mmNIC4_QM0_PQ_CI_1                                           0xDE00B4
+
+#define mmNIC4_QM0_PQ_CI_2                                           0xDE00B8
+
+#define mmNIC4_QM0_PQ_CI_3                                           0xDE00BC
+
+#define mmNIC4_QM0_PQ_CFG0_0                                         0xDE00C0
+
+#define mmNIC4_QM0_PQ_CFG0_1                                         0xDE00C4
+
+#define mmNIC4_QM0_PQ_CFG0_2                                         0xDE00C8
+
+#define mmNIC4_QM0_PQ_CFG0_3                                         0xDE00CC
+
+#define mmNIC4_QM0_PQ_CFG1_0                                         0xDE00D0
+
+#define mmNIC4_QM0_PQ_CFG1_1                                         0xDE00D4
+
+#define mmNIC4_QM0_PQ_CFG1_2                                         0xDE00D8
+
+#define mmNIC4_QM0_PQ_CFG1_3                                         0xDE00DC
+
+#define mmNIC4_QM0_PQ_ARUSER_31_11_0                                 0xDE00E0
+
+#define mmNIC4_QM0_PQ_ARUSER_31_11_1                                 0xDE00E4
+
+#define mmNIC4_QM0_PQ_ARUSER_31_11_2                                 0xDE00E8
+
+#define mmNIC4_QM0_PQ_ARUSER_31_11_3                                 0xDE00EC
+
+#define mmNIC4_QM0_PQ_STS0_0                                         0xDE00F0
+
+#define mmNIC4_QM0_PQ_STS0_1                                         0xDE00F4
+
+#define mmNIC4_QM0_PQ_STS0_2                                         0xDE00F8
+
+#define mmNIC4_QM0_PQ_STS0_3                                         0xDE00FC
+
+#define mmNIC4_QM0_PQ_STS1_0                                         0xDE0100
+
+#define mmNIC4_QM0_PQ_STS1_1                                         0xDE0104
+
+#define mmNIC4_QM0_PQ_STS1_2                                         0xDE0108
+
+#define mmNIC4_QM0_PQ_STS1_3                                         0xDE010C
+
+#define mmNIC4_QM0_CQ_CFG0_0                                         0xDE0110
+
+#define mmNIC4_QM0_CQ_CFG0_1                                         0xDE0114
+
+#define mmNIC4_QM0_CQ_CFG0_2                                         0xDE0118
+
+#define mmNIC4_QM0_CQ_CFG0_3                                         0xDE011C
+
+#define mmNIC4_QM0_CQ_CFG0_4                                         0xDE0120
+
+#define mmNIC4_QM0_CQ_CFG1_0                                         0xDE0124
+
+#define mmNIC4_QM0_CQ_CFG1_1                                         0xDE0128
+
+#define mmNIC4_QM0_CQ_CFG1_2                                         0xDE012C
+
+#define mmNIC4_QM0_CQ_CFG1_3                                         0xDE0130
+
+#define mmNIC4_QM0_CQ_CFG1_4                                         0xDE0134
+
+#define mmNIC4_QM0_CQ_ARUSER_31_11_0                                 0xDE0138
+
+#define mmNIC4_QM0_CQ_ARUSER_31_11_1                                 0xDE013C
+
+#define mmNIC4_QM0_CQ_ARUSER_31_11_2                                 0xDE0140
+
+#define mmNIC4_QM0_CQ_ARUSER_31_11_3                                 0xDE0144
+
+#define mmNIC4_QM0_CQ_ARUSER_31_11_4                                 0xDE0148
+
+#define mmNIC4_QM0_CQ_STS0_0                                         0xDE014C
+
+#define mmNIC4_QM0_CQ_STS0_1                                         0xDE0150
+
+#define mmNIC4_QM0_CQ_STS0_2                                         0xDE0154
+
+#define mmNIC4_QM0_CQ_STS0_3                                         0xDE0158
+
+#define mmNIC4_QM0_CQ_STS0_4                                         0xDE015C
+
+#define mmNIC4_QM0_CQ_STS1_0                                         0xDE0160
+
+#define mmNIC4_QM0_CQ_STS1_1                                         0xDE0164
+
+#define mmNIC4_QM0_CQ_STS1_2                                         0xDE0168
+
+#define mmNIC4_QM0_CQ_STS1_3                                         0xDE016C
+
+#define mmNIC4_QM0_CQ_STS1_4                                         0xDE0170
+
+#define mmNIC4_QM0_CQ_PTR_LO_0                                       0xDE0174
+
+#define mmNIC4_QM0_CQ_PTR_HI_0                                       0xDE0178
+
+#define mmNIC4_QM0_CQ_TSIZE_0                                        0xDE017C
+
+#define mmNIC4_QM0_CQ_CTL_0                                          0xDE0180
+
+#define mmNIC4_QM0_CQ_PTR_LO_1                                       0xDE0184
+
+#define mmNIC4_QM0_CQ_PTR_HI_1                                       0xDE0188
+
+#define mmNIC4_QM0_CQ_TSIZE_1                                        0xDE018C
+
+#define mmNIC4_QM0_CQ_CTL_1                                          0xDE0190
+
+#define mmNIC4_QM0_CQ_PTR_LO_2                                       0xDE0194
+
+#define mmNIC4_QM0_CQ_PTR_HI_2                                       0xDE0198
+
+#define mmNIC4_QM0_CQ_TSIZE_2                                        0xDE019C
+
+#define mmNIC4_QM0_CQ_CTL_2                                          0xDE01A0
+
+#define mmNIC4_QM0_CQ_PTR_LO_3                                       0xDE01A4
+
+#define mmNIC4_QM0_CQ_PTR_HI_3                                       0xDE01A8
+
+#define mmNIC4_QM0_CQ_TSIZE_3                                        0xDE01AC
+
+#define mmNIC4_QM0_CQ_CTL_3                                          0xDE01B0
+
+#define mmNIC4_QM0_CQ_PTR_LO_4                                       0xDE01B4
+
+#define mmNIC4_QM0_CQ_PTR_HI_4                                       0xDE01B8
+
+#define mmNIC4_QM0_CQ_TSIZE_4                                        0xDE01BC
+
+#define mmNIC4_QM0_CQ_CTL_4                                          0xDE01C0
+
+#define mmNIC4_QM0_CQ_PTR_LO_STS_0                                   0xDE01C4
+
+#define mmNIC4_QM0_CQ_PTR_LO_STS_1                                   0xDE01C8
+
+#define mmNIC4_QM0_CQ_PTR_LO_STS_2                                   0xDE01CC
+
+#define mmNIC4_QM0_CQ_PTR_LO_STS_3                                   0xDE01D0
+
+#define mmNIC4_QM0_CQ_PTR_LO_STS_4                                   0xDE01D4
+
+#define mmNIC4_QM0_CQ_PTR_HI_STS_0                                   0xDE01D8
+
+#define mmNIC4_QM0_CQ_PTR_HI_STS_1                                   0xDE01DC
+
+#define mmNIC4_QM0_CQ_PTR_HI_STS_2                                   0xDE01E0
+
+#define mmNIC4_QM0_CQ_PTR_HI_STS_3                                   0xDE01E4
+
+#define mmNIC4_QM0_CQ_PTR_HI_STS_4                                   0xDE01E8
+
+#define mmNIC4_QM0_CQ_TSIZE_STS_0                                    0xDE01EC
+
+#define mmNIC4_QM0_CQ_TSIZE_STS_1                                    0xDE01F0
+
+#define mmNIC4_QM0_CQ_TSIZE_STS_2                                    0xDE01F4
+
+#define mmNIC4_QM0_CQ_TSIZE_STS_3                                    0xDE01F8
+
+#define mmNIC4_QM0_CQ_TSIZE_STS_4                                    0xDE01FC
+
+#define mmNIC4_QM0_CQ_CTL_STS_0                                      0xDE0200
+
+#define mmNIC4_QM0_CQ_CTL_STS_1                                      0xDE0204
+
+#define mmNIC4_QM0_CQ_CTL_STS_2                                      0xDE0208
+
+#define mmNIC4_QM0_CQ_CTL_STS_3                                      0xDE020C
+
+#define mmNIC4_QM0_CQ_CTL_STS_4                                      0xDE0210
+
+#define mmNIC4_QM0_CQ_IFIFO_CNT_0                                    0xDE0214
+
+#define mmNIC4_QM0_CQ_IFIFO_CNT_1                                    0xDE0218
+
+#define mmNIC4_QM0_CQ_IFIFO_CNT_2                                    0xDE021C
+
+#define mmNIC4_QM0_CQ_IFIFO_CNT_3                                    0xDE0220
+
+#define mmNIC4_QM0_CQ_IFIFO_CNT_4                                    0xDE0224
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_LO_0                            0xDE0228
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_LO_1                            0xDE022C
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_LO_2                            0xDE0230
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_LO_3                            0xDE0234
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_LO_4                            0xDE0238
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_HI_0                            0xDE023C
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_HI_1                            0xDE0240
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_HI_2                            0xDE0244
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_HI_3                            0xDE0248
+
+#define mmNIC4_QM0_CP_MSG_BASE0_ADDR_HI_4                            0xDE024C
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_LO_0                            0xDE0250
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_LO_1                            0xDE0254
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_LO_2                            0xDE0258
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_LO_3                            0xDE025C
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_LO_4                            0xDE0260
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_HI_0                            0xDE0264
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_HI_1                            0xDE0268
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_HI_2                            0xDE026C
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_HI_3                            0xDE0270
+
+#define mmNIC4_QM0_CP_MSG_BASE1_ADDR_HI_4                            0xDE0274
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_LO_0                            0xDE0278
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_LO_1                            0xDE027C
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_LO_2                            0xDE0280
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_LO_3                            0xDE0284
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_LO_4                            0xDE0288
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_HI_0                            0xDE028C
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_HI_1                            0xDE0290
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_HI_2                            0xDE0294
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_HI_3                            0xDE0298
+
+#define mmNIC4_QM0_CP_MSG_BASE2_ADDR_HI_4                            0xDE029C
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_LO_0                            0xDE02A0
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_LO_1                            0xDE02A4
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_LO_2                            0xDE02A8
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_LO_3                            0xDE02AC
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_LO_4                            0xDE02B0
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_HI_0                            0xDE02B4
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_HI_1                            0xDE02B8
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_HI_2                            0xDE02BC
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_HI_3                            0xDE02C0
+
+#define mmNIC4_QM0_CP_MSG_BASE3_ADDR_HI_4                            0xDE02C4
+
+#define mmNIC4_QM0_CP_LDMA_TSIZE_OFFSET_0                            0xDE02C8
+
+#define mmNIC4_QM0_CP_LDMA_TSIZE_OFFSET_1                            0xDE02CC
+
+#define mmNIC4_QM0_CP_LDMA_TSIZE_OFFSET_2                            0xDE02D0
+
+#define mmNIC4_QM0_CP_LDMA_TSIZE_OFFSET_3                            0xDE02D4
+
+#define mmNIC4_QM0_CP_LDMA_TSIZE_OFFSET_4                            0xDE02D8
+
+#define mmNIC4_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xDE02E0
+
+#define mmNIC4_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xDE02E4
+
+#define mmNIC4_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xDE02E8
+
+#define mmNIC4_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xDE02EC
+
+#define mmNIC4_QM0_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xDE02F0
+
+#define mmNIC4_QM0_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xDE02F4
+
+#define mmNIC4_QM0_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xDE02F8
+
+#define mmNIC4_QM0_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xDE02FC
+
+#define mmNIC4_QM0_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xDE0300
+
+#define mmNIC4_QM0_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xDE0304
+
+#define mmNIC4_QM0_CP_FENCE0_RDATA_0                                 0xDE0308
+
+#define mmNIC4_QM0_CP_FENCE0_RDATA_1                                 0xDE030C
+
+#define mmNIC4_QM0_CP_FENCE0_RDATA_2                                 0xDE0310
+
+#define mmNIC4_QM0_CP_FENCE0_RDATA_3                                 0xDE0314
+
+#define mmNIC4_QM0_CP_FENCE0_RDATA_4                                 0xDE0318
+
+#define mmNIC4_QM0_CP_FENCE1_RDATA_0                                 0xDE031C
+
+#define mmNIC4_QM0_CP_FENCE1_RDATA_1                                 0xDE0320
+
+#define mmNIC4_QM0_CP_FENCE1_RDATA_2                                 0xDE0324
+
+#define mmNIC4_QM0_CP_FENCE1_RDATA_3                                 0xDE0328
+
+#define mmNIC4_QM0_CP_FENCE1_RDATA_4                                 0xDE032C
+
+#define mmNIC4_QM0_CP_FENCE2_RDATA_0                                 0xDE0330
+
+#define mmNIC4_QM0_CP_FENCE2_RDATA_1                                 0xDE0334
+
+#define mmNIC4_QM0_CP_FENCE2_RDATA_2                                 0xDE0338
+
+#define mmNIC4_QM0_CP_FENCE2_RDATA_3                                 0xDE033C
+
+#define mmNIC4_QM0_CP_FENCE2_RDATA_4                                 0xDE0340
+
+#define mmNIC4_QM0_CP_FENCE3_RDATA_0                                 0xDE0344
+
+#define mmNIC4_QM0_CP_FENCE3_RDATA_1                                 0xDE0348
+
+#define mmNIC4_QM0_CP_FENCE3_RDATA_2                                 0xDE034C
+
+#define mmNIC4_QM0_CP_FENCE3_RDATA_3                                 0xDE0350
+
+#define mmNIC4_QM0_CP_FENCE3_RDATA_4                                 0xDE0354
+
+#define mmNIC4_QM0_CP_FENCE0_CNT_0                                   0xDE0358
+
+#define mmNIC4_QM0_CP_FENCE0_CNT_1                                   0xDE035C
+
+#define mmNIC4_QM0_CP_FENCE0_CNT_2                                   0xDE0360
+
+#define mmNIC4_QM0_CP_FENCE0_CNT_3                                   0xDE0364
+
+#define mmNIC4_QM0_CP_FENCE0_CNT_4                                   0xDE0368
+
+#define mmNIC4_QM0_CP_FENCE1_CNT_0                                   0xDE036C
+
+#define mmNIC4_QM0_CP_FENCE1_CNT_1                                   0xDE0370
+
+#define mmNIC4_QM0_CP_FENCE1_CNT_2                                   0xDE0374
+
+#define mmNIC4_QM0_CP_FENCE1_CNT_3                                   0xDE0378
+
+#define mmNIC4_QM0_CP_FENCE1_CNT_4                                   0xDE037C
+
+#define mmNIC4_QM0_CP_FENCE2_CNT_0                                   0xDE0380
+
+#define mmNIC4_QM0_CP_FENCE2_CNT_1                                   0xDE0384
+
+#define mmNIC4_QM0_CP_FENCE2_CNT_2                                   0xDE0388
+
+#define mmNIC4_QM0_CP_FENCE2_CNT_3                                   0xDE038C
+
+#define mmNIC4_QM0_CP_FENCE2_CNT_4                                   0xDE0390
+
+#define mmNIC4_QM0_CP_FENCE3_CNT_0                                   0xDE0394
+
+#define mmNIC4_QM0_CP_FENCE3_CNT_1                                   0xDE0398
+
+#define mmNIC4_QM0_CP_FENCE3_CNT_2                                   0xDE039C
+
+#define mmNIC4_QM0_CP_FENCE3_CNT_3                                   0xDE03A0
+
+#define mmNIC4_QM0_CP_FENCE3_CNT_4                                   0xDE03A4
+
+#define mmNIC4_QM0_CP_STS_0                                          0xDE03A8
+
+#define mmNIC4_QM0_CP_STS_1                                          0xDE03AC
+
+#define mmNIC4_QM0_CP_STS_2                                          0xDE03B0
+
+#define mmNIC4_QM0_CP_STS_3                                          0xDE03B4
+
+#define mmNIC4_QM0_CP_STS_4                                          0xDE03B8
+
+#define mmNIC4_QM0_CP_CURRENT_INST_LO_0                              0xDE03BC
+
+#define mmNIC4_QM0_CP_CURRENT_INST_LO_1                              0xDE03C0
+
+#define mmNIC4_QM0_CP_CURRENT_INST_LO_2                              0xDE03C4
+
+#define mmNIC4_QM0_CP_CURRENT_INST_LO_3                              0xDE03C8
+
+#define mmNIC4_QM0_CP_CURRENT_INST_LO_4                              0xDE03CC
+
+#define mmNIC4_QM0_CP_CURRENT_INST_HI_0                              0xDE03D0
+
+#define mmNIC4_QM0_CP_CURRENT_INST_HI_1                              0xDE03D4
+
+#define mmNIC4_QM0_CP_CURRENT_INST_HI_2                              0xDE03D8
+
+#define mmNIC4_QM0_CP_CURRENT_INST_HI_3                              0xDE03DC
+
+#define mmNIC4_QM0_CP_CURRENT_INST_HI_4                              0xDE03E0
+
+#define mmNIC4_QM0_CP_BARRIER_CFG_0                                  0xDE03F4
+
+#define mmNIC4_QM0_CP_BARRIER_CFG_1                                  0xDE03F8
+
+#define mmNIC4_QM0_CP_BARRIER_CFG_2                                  0xDE03FC
+
+#define mmNIC4_QM0_CP_BARRIER_CFG_3                                  0xDE0400
+
+#define mmNIC4_QM0_CP_BARRIER_CFG_4                                  0xDE0404
+
+#define mmNIC4_QM0_CP_DBG_0_0                                        0xDE0408
+
+#define mmNIC4_QM0_CP_DBG_0_1                                        0xDE040C
+
+#define mmNIC4_QM0_CP_DBG_0_2                                        0xDE0410
+
+#define mmNIC4_QM0_CP_DBG_0_3                                        0xDE0414
+
+#define mmNIC4_QM0_CP_DBG_0_4                                        0xDE0418
+
+#define mmNIC4_QM0_CP_ARUSER_31_11_0                                 0xDE041C
+
+#define mmNIC4_QM0_CP_ARUSER_31_11_1                                 0xDE0420
+
+#define mmNIC4_QM0_CP_ARUSER_31_11_2                                 0xDE0424
+
+#define mmNIC4_QM0_CP_ARUSER_31_11_3                                 0xDE0428
+
+#define mmNIC4_QM0_CP_ARUSER_31_11_4                                 0xDE042C
+
+#define mmNIC4_QM0_CP_AWUSER_31_11_0                                 0xDE0430
+
+#define mmNIC4_QM0_CP_AWUSER_31_11_1                                 0xDE0434
+
+#define mmNIC4_QM0_CP_AWUSER_31_11_2                                 0xDE0438
+
+#define mmNIC4_QM0_CP_AWUSER_31_11_3                                 0xDE043C
+
+#define mmNIC4_QM0_CP_AWUSER_31_11_4                                 0xDE0440
+
+#define mmNIC4_QM0_ARB_CFG_0                                         0xDE0A00
+
+#define mmNIC4_QM0_ARB_CHOISE_Q_PUSH                                 0xDE0A04
+
+#define mmNIC4_QM0_ARB_WRR_WEIGHT_0                                  0xDE0A08
+
+#define mmNIC4_QM0_ARB_WRR_WEIGHT_1                                  0xDE0A0C
+
+#define mmNIC4_QM0_ARB_WRR_WEIGHT_2                                  0xDE0A10
+
+#define mmNIC4_QM0_ARB_WRR_WEIGHT_3                                  0xDE0A14
+
+#define mmNIC4_QM0_ARB_CFG_1                                         0xDE0A18
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_0                              0xDE0A20
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_1                              0xDE0A24
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_2                              0xDE0A28
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_3                              0xDE0A2C
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_4                              0xDE0A30
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_5                              0xDE0A34
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_6                              0xDE0A38
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_7                              0xDE0A3C
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_8                              0xDE0A40
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_9                              0xDE0A44
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_10                             0xDE0A48
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_11                             0xDE0A4C
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_12                             0xDE0A50
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_13                             0xDE0A54
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_14                             0xDE0A58
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_15                             0xDE0A5C
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_16                             0xDE0A60
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_17                             0xDE0A64
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_18                             0xDE0A68
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_19                             0xDE0A6C
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_20                             0xDE0A70
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_21                             0xDE0A74
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_22                             0xDE0A78
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_23                             0xDE0A7C
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_24                             0xDE0A80
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_25                             0xDE0A84
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_26                             0xDE0A88
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_27                             0xDE0A8C
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_28                             0xDE0A90
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_29                             0xDE0A94
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_30                             0xDE0A98
+
+#define mmNIC4_QM0_ARB_MST_AVAIL_CRED_31                             0xDE0A9C
+
+#define mmNIC4_QM0_ARB_MST_CRED_INC                                  0xDE0AA0
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_0                        0xDE0AA4
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_1                        0xDE0AA8
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_2                        0xDE0AAC
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_3                        0xDE0AB0
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_4                        0xDE0AB4
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_5                        0xDE0AB8
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_6                        0xDE0ABC
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_7                        0xDE0AC0
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_8                        0xDE0AC4
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_9                        0xDE0AC8
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_10                       0xDE0ACC
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_11                       0xDE0AD0
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_12                       0xDE0AD4
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_13                       0xDE0AD8
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_14                       0xDE0ADC
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_15                       0xDE0AE0
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_16                       0xDE0AE4
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_17                       0xDE0AE8
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_18                       0xDE0AEC
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_19                       0xDE0AF0
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_20                       0xDE0AF4
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_21                       0xDE0AF8
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_22                       0xDE0AFC
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_23                       0xDE0B00
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_24                       0xDE0B04
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_25                       0xDE0B08
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_26                       0xDE0B0C
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_27                       0xDE0B10
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_28                       0xDE0B14
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_29                       0xDE0B18
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_30                       0xDE0B1C
+
+#define mmNIC4_QM0_ARB_MST_CHOISE_PUSH_OFST_31                       0xDE0B20
+
+#define mmNIC4_QM0_ARB_SLV_MASTER_INC_CRED_OFST                      0xDE0B28
+
+#define mmNIC4_QM0_ARB_MST_SLAVE_EN                                  0xDE0B2C
+
+#define mmNIC4_QM0_ARB_MST_QUIET_PER                                 0xDE0B34
+
+#define mmNIC4_QM0_ARB_SLV_CHOISE_WDT                                0xDE0B38
+
+#define mmNIC4_QM0_ARB_SLV_ID                                        0xDE0B3C
+
+#define mmNIC4_QM0_ARB_MSG_MAX_INFLIGHT                              0xDE0B44
+
+#define mmNIC4_QM0_ARB_MSG_AWUSER_31_11                              0xDE0B48
+
+#define mmNIC4_QM0_ARB_MSG_AWUSER_SEC_PROP                           0xDE0B4C
+
+#define mmNIC4_QM0_ARB_MSG_AWUSER_NON_SEC_PROP                       0xDE0B50
+
+#define mmNIC4_QM0_ARB_BASE_LO                                       0xDE0B54
+
+#define mmNIC4_QM0_ARB_BASE_HI                                       0xDE0B58
+
+#define mmNIC4_QM0_ARB_STATE_STS                                     0xDE0B80
+
+#define mmNIC4_QM0_ARB_CHOISE_FULLNESS_STS                           0xDE0B84
+
+#define mmNIC4_QM0_ARB_MSG_STS                                       0xDE0B88
+
+#define mmNIC4_QM0_ARB_SLV_CHOISE_Q_HEAD                             0xDE0B8C
+
+#define mmNIC4_QM0_ARB_ERR_CAUSE                                     0xDE0B9C
+
+#define mmNIC4_QM0_ARB_ERR_MSG_EN                                    0xDE0BA0
+
+#define mmNIC4_QM0_ARB_ERR_STS_DRP                                   0xDE0BA8
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_0                                0xDE0BB0
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_1                                0xDE0BB4
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_2                                0xDE0BB8
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_3                                0xDE0BBC
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_4                                0xDE0BC0
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_5                                0xDE0BC4
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_6                                0xDE0BC8
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_7                                0xDE0BCC
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_8                                0xDE0BD0
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_9                                0xDE0BD4
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_10                               0xDE0BD8
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_11                               0xDE0BDC
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_12                               0xDE0BE0
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_13                               0xDE0BE4
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_14                               0xDE0BE8
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_15                               0xDE0BEC
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_16                               0xDE0BF0
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_17                               0xDE0BF4
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_18                               0xDE0BF8
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_19                               0xDE0BFC
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_20                               0xDE0C00
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_21                               0xDE0C04
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_22                               0xDE0C08
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_23                               0xDE0C0C
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_24                               0xDE0C10
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_25                               0xDE0C14
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_26                               0xDE0C18
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_27                               0xDE0C1C
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_28                               0xDE0C20
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_29                               0xDE0C24
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_30                               0xDE0C28
+
+#define mmNIC4_QM0_ARB_MST_CRED_STS_31                               0xDE0C2C
+
+#define mmNIC4_QM0_CGM_CFG                                           0xDE0C70
+
+#define mmNIC4_QM0_CGM_STS                                           0xDE0C74
+
+#define mmNIC4_QM0_CGM_CFG1                                          0xDE0C78
+
+#define mmNIC4_QM0_LOCAL_RANGE_BASE                                  0xDE0C80
+
+#define mmNIC4_QM0_LOCAL_RANGE_SIZE                                  0xDE0C84
+
+#define mmNIC4_QM0_CSMR_STRICT_PRIO_CFG                              0xDE0C90
+
+#define mmNIC4_QM0_HBW_RD_RATE_LIM_CFG_1                             0xDE0C94
+
+#define mmNIC4_QM0_LBW_WR_RATE_LIM_CFG_0                             0xDE0C98
+
+#define mmNIC4_QM0_LBW_WR_RATE_LIM_CFG_1                             0xDE0C9C
+
+#define mmNIC4_QM0_HBW_RD_RATE_LIM_CFG_0                             0xDE0CA0
+
+#define mmNIC4_QM0_GLBL_AXCACHE                                      0xDE0CA4
+
+#define mmNIC4_QM0_IND_GW_APB_CFG                                    0xDE0CB0
+
+#define mmNIC4_QM0_IND_GW_APB_WDATA                                  0xDE0CB4
+
+#define mmNIC4_QM0_IND_GW_APB_RDATA                                  0xDE0CB8
+
+#define mmNIC4_QM0_IND_GW_APB_STATUS                                 0xDE0CBC
+
+#define mmNIC4_QM0_GLBL_ERR_ADDR_LO                                  0xDE0CD0
+
+#define mmNIC4_QM0_GLBL_ERR_ADDR_HI                                  0xDE0CD4
+
+#define mmNIC4_QM0_GLBL_ERR_WDATA                                    0xDE0CD8
+
+#define mmNIC4_QM0_GLBL_MEM_INIT_BUSY                                0xDE0D00
+
+#endif /* ASIC_REG_NIC4_QM0_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm1_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm1_regs.h
new file mode 100644
index 000000000000..34b21b21da52
--- /dev/null
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm1_regs.h
@@ -0,0 +1,834 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_NIC4_QM1_REGS_H_
+#define ASIC_REG_NIC4_QM1_REGS_H_
+
+/*
+ *****************************************
+ *   NIC4_QM1 (Prototype: QMAN)
+ *****************************************
+ */
+
+#define mmNIC4_QM1_GLBL_CFG0                                         0xDE2000
+
+#define mmNIC4_QM1_GLBL_CFG1                                         0xDE2004
+
+#define mmNIC4_QM1_GLBL_PROT                                         0xDE2008
+
+#define mmNIC4_QM1_GLBL_ERR_CFG                                      0xDE200C
+
+#define mmNIC4_QM1_GLBL_SECURE_PROPS_0                               0xDE2010
+
+#define mmNIC4_QM1_GLBL_SECURE_PROPS_1                               0xDE2014
+
+#define mmNIC4_QM1_GLBL_SECURE_PROPS_2                               0xDE2018
+
+#define mmNIC4_QM1_GLBL_SECURE_PROPS_3                               0xDE201C
+
+#define mmNIC4_QM1_GLBL_SECURE_PROPS_4                               0xDE2020
+
+#define mmNIC4_QM1_GLBL_NON_SECURE_PROPS_0                           0xDE2024
+
+#define mmNIC4_QM1_GLBL_NON_SECURE_PROPS_1                           0xDE2028
+
+#define mmNIC4_QM1_GLBL_NON_SECURE_PROPS_2                           0xDE202C
+
+#define mmNIC4_QM1_GLBL_NON_SECURE_PROPS_3                           0xDE2030
+
+#define mmNIC4_QM1_GLBL_NON_SECURE_PROPS_4                           0xDE2034
+
+#define mmNIC4_QM1_GLBL_STS0                                         0xDE2038
+
+#define mmNIC4_QM1_GLBL_STS1_0                                       0xDE2040
+
+#define mmNIC4_QM1_GLBL_STS1_1                                       0xDE2044
+
+#define mmNIC4_QM1_GLBL_STS1_2                                       0xDE2048
+
+#define mmNIC4_QM1_GLBL_STS1_3                                       0xDE204C
+
+#define mmNIC4_QM1_GLBL_STS1_4                                       0xDE2050
+
+#define mmNIC4_QM1_GLBL_MSG_EN_0                                     0xDE2054
+
+#define mmNIC4_QM1_GLBL_MSG_EN_1                                     0xDE2058
+
+#define mmNIC4_QM1_GLBL_MSG_EN_2                                     0xDE205C
+
+#define mmNIC4_QM1_GLBL_MSG_EN_3                                     0xDE2060
+
+#define mmNIC4_QM1_GLBL_MSG_EN_4                                     0xDE2068
+
+#define mmNIC4_QM1_PQ_BASE_LO_0                                      0xDE2070
+
+#define mmNIC4_QM1_PQ_BASE_LO_1                                      0xDE2074
+
+#define mmNIC4_QM1_PQ_BASE_LO_2                                      0xDE2078
+
+#define mmNIC4_QM1_PQ_BASE_LO_3                                      0xDE207C
+
+#define mmNIC4_QM1_PQ_BASE_HI_0                                      0xDE2080
+
+#define mmNIC4_QM1_PQ_BASE_HI_1                                      0xDE2084
+
+#define mmNIC4_QM1_PQ_BASE_HI_2                                      0xDE2088
+
+#define mmNIC4_QM1_PQ_BASE_HI_3                                      0xDE208C
+
+#define mmNIC4_QM1_PQ_SIZE_0                                         0xDE2090
+
+#define mmNIC4_QM1_PQ_SIZE_1                                         0xDE2094
+
+#define mmNIC4_QM1_PQ_SIZE_2                                         0xDE2098
+
+#define mmNIC4_QM1_PQ_SIZE_3                                         0xDE209C
+
+#define mmNIC4_QM1_PQ_PI_0                                           0xDE20A0
+
+#define mmNIC4_QM1_PQ_PI_1                                           0xDE20A4
+
+#define mmNIC4_QM1_PQ_PI_2                                           0xDE20A8
+
+#define mmNIC4_QM1_PQ_PI_3                                           0xDE20AC
+
+#define mmNIC4_QM1_PQ_CI_0                                           0xDE20B0
+
+#define mmNIC4_QM1_PQ_CI_1                                           0xDE20B4
+
+#define mmNIC4_QM1_PQ_CI_2                                           0xDE20B8
+
+#define mmNIC4_QM1_PQ_CI_3                                           0xDE20BC
+
+#define mmNIC4_QM1_PQ_CFG0_0                                         0xDE20C0
+
+#define mmNIC4_QM1_PQ_CFG0_1                                         0xDE20C4
+
+#define mmNIC4_QM1_PQ_CFG0_2                                         0xDE20C8
+
+#define mmNIC4_QM1_PQ_CFG0_3                                         0xDE20CC
+
+#define mmNIC4_QM1_PQ_CFG1_0                                         0xDE20D0
+
+#define mmNIC4_QM1_PQ_CFG1_1                                         0xDE20D4
+
+#define mmNIC4_QM1_PQ_CFG1_2                                         0xDE20D8
+
+#define mmNIC4_QM1_PQ_CFG1_3                                         0xDE20DC
+
+#define mmNIC4_QM1_PQ_ARUSER_31_11_0                                 0xDE20E0
+
+#define mmNIC4_QM1_PQ_ARUSER_31_11_1                                 0xDE20E4
+
+#define mmNIC4_QM1_PQ_ARUSER_31_11_2                                 0xDE20E8
+
+#define mmNIC4_QM1_PQ_ARUSER_31_11_3                                 0xDE20EC
+
+#define mmNIC4_QM1_PQ_STS0_0                                         0xDE20F0
+
+#define mmNIC4_QM1_PQ_STS0_1                                         0xDE20F4
+
+#define mmNIC4_QM1_PQ_STS0_2                                         0xDE20F8
+
+#define mmNIC4_QM1_PQ_STS0_3                                         0xDE20FC
+
+#define mmNIC4_QM1_PQ_STS1_0                                         0xDE2100
+
+#define mmNIC4_QM1_PQ_STS1_1                                         0xDE2104
+
+#define mmNIC4_QM1_PQ_STS1_2                                         0xDE2108
+
+#define mmNIC4_QM1_PQ_STS1_3                                         0xDE210C
+
+#define mmNIC4_QM1_CQ_CFG0_0                                         0xDE2110
+
+#define mmNIC4_QM1_CQ_CFG0_1                                         0xDE2114
+
+#define mmNIC4_QM1_CQ_CFG0_2                                         0xDE2118
+
+#define mmNIC4_QM1_CQ_CFG0_3                                         0xDE211C
+
+#define mmNIC4_QM1_CQ_CFG0_4                                         0xDE2120
+
+#define mmNIC4_QM1_CQ_CFG1_0                                         0xDE2124
+
+#define mmNIC4_QM1_CQ_CFG1_1                                         0xDE2128
+
+#define mmNIC4_QM1_CQ_CFG1_2                                         0xDE212C
+
+#define mmNIC4_QM1_CQ_CFG1_3                                         0xDE2130
+
+#define mmNIC4_QM1_CQ_CFG1_4                                         0xDE2134
+
+#define mmNIC4_QM1_CQ_ARUSER_31_11_0                                 0xDE2138
+
+#define mmNIC4_QM1_CQ_ARUSER_31_11_1                                 0xDE213C
+
+#define mmNIC4_QM1_CQ_ARUSER_31_11_2                                 0xDE2140
+
+#define mmNIC4_QM1_CQ_ARUSER_31_11_3                                 0xDE2144
+
+#define mmNIC4_QM1_CQ_ARUSER_31_11_4                                 0xDE2148
+
+#define mmNIC4_QM1_CQ_STS0_0                                         0xDE214C
+
+#define mmNIC4_QM1_CQ_STS0_1                                         0xDE2150
+
+#define mmNIC4_QM1_CQ_STS0_2                                         0xDE2154
+
+#define mmNIC4_QM1_CQ_STS0_3                                         0xDE2158
+
+#define mmNIC4_QM1_CQ_STS0_4                                         0xDE215C
+
+#define mmNIC4_QM1_CQ_STS1_0                                         0xDE2160
+
+#define mmNIC4_QM1_CQ_STS1_1                                         0xDE2164
+
+#define mmNIC4_QM1_CQ_STS1_2                                         0xDE2168
+
+#define mmNIC4_QM1_CQ_STS1_3                                         0xDE216C
+
+#define mmNIC4_QM1_CQ_STS1_4                                         0xDE2170
+
+#define mmNIC4_QM1_CQ_PTR_LO_0                                       0xDE2174
+
+#define mmNIC4_QM1_CQ_PTR_HI_0                                       0xDE2178
+
+#define mmNIC4_QM1_CQ_TSIZE_0                                        0xDE217C
+
+#define mmNIC4_QM1_CQ_CTL_0                                          0xDE2180
+
+#define mmNIC4_QM1_CQ_PTR_LO_1                                       0xDE2184
+
+#define mmNIC4_QM1_CQ_PTR_HI_1                                       0xDE2188
+
+#define mmNIC4_QM1_CQ_TSIZE_1                                        0xDE218C
+
+#define mmNIC4_QM1_CQ_CTL_1                                          0xDE2190
+
+#define mmNIC4_QM1_CQ_PTR_LO_2                                       0xDE2194
+
+#define mmNIC4_QM1_CQ_PTR_HI_2                                       0xDE2198
+
+#define mmNIC4_QM1_CQ_TSIZE_2                                        0xDE219C
+
+#define mmNIC4_QM1_CQ_CTL_2                                          0xDE21A0
+
+#define mmNIC4_QM1_CQ_PTR_LO_3                                       0xDE21A4
+
+#define mmNIC4_QM1_CQ_PTR_HI_3                                       0xDE21A8
+
+#define mmNIC4_QM1_CQ_TSIZE_3                                        0xDE21AC
+
+#define mmNIC4_QM1_CQ_CTL_3                                          0xDE21B0
+
+#define mmNIC4_QM1_CQ_PTR_LO_4                                       0xDE21B4
+
+#define mmNIC4_QM1_CQ_PTR_HI_4                                       0xDE21B8
+
+#define mmNIC4_QM1_CQ_TSIZE_4                                        0xDE21BC
+
+#define mmNIC4_QM1_CQ_CTL_4                                          0xDE21C0
+
+#define mmNIC4_QM1_CQ_PTR_LO_STS_0                                   0xDE21C4
+
+#define mmNIC4_QM1_CQ_PTR_LO_STS_1                                   0xDE21C8
+
+#define mmNIC4_QM1_CQ_PTR_LO_STS_2                                   0xDE21CC
+
+#define mmNIC4_QM1_CQ_PTR_LO_STS_3                                   0xDE21D0
+
+#define mmNIC4_QM1_CQ_PTR_LO_STS_4                                   0xDE21D4
+
+#define mmNIC4_QM1_CQ_PTR_HI_STS_0                                   0xDE21D8
+
+#define mmNIC4_QM1_CQ_PTR_HI_STS_1                                   0xDE21DC
+
+#define mmNIC4_QM1_CQ_PTR_HI_STS_2                                   0xDE21E0
+
+#define mmNIC4_QM1_CQ_PTR_HI_STS_3                                   0xDE21E4
+
+#define mmNIC4_QM1_CQ_PTR_HI_STS_4                                   0xDE21E8
+
+#define mmNIC4_QM1_CQ_TSIZE_STS_0                                    0xDE21EC
+
+#define mmNIC4_QM1_CQ_TSIZE_STS_1                                    0xDE21F0
+
+#define mmNIC4_QM1_CQ_TSIZE_STS_2                                    0xDE21F4
+
+#define mmNIC4_QM1_CQ_TSIZE_STS_3                                    0xDE21F8
+
+#define mmNIC4_QM1_CQ_TSIZE_STS_4                                    0xDE21FC
+
+#define mmNIC4_QM1_CQ_CTL_STS_0                                      0xDE2200
+
+#define mmNIC4_QM1_CQ_CTL_STS_1                                      0xDE2204
+
+#define mmNIC4_QM1_CQ_CTL_STS_2                                      0xDE2208
+
+#define mmNIC4_QM1_CQ_CTL_STS_3                                      0xDE220C
+
+#define mmNIC4_QM1_CQ_CTL_STS_4                                      0xDE2210
+
+#define mmNIC4_QM1_CQ_IFIFO_CNT_0                                    0xDE2214
+
+#define mmNIC4_QM1_CQ_IFIFO_CNT_1                                    0xDE2218
+
+#define mmNIC4_QM1_CQ_IFIFO_CNT_2                                    0xDE221C
+
+#define mmNIC4_QM1_CQ_IFIFO_CNT_3                                    0xDE2220
+
+#define mmNIC4_QM1_CQ_IFIFO_CNT_4                                    0xDE2224
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_LO_0                            0xDE2228
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_LO_1                            0xDE222C
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_LO_2                            0xDE2230
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_LO_3                            0xDE2234
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_LO_4                            0xDE2238
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_HI_0                            0xDE223C
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_HI_1                            0xDE2240
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_HI_2                            0xDE2244
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_HI_3                            0xDE2248
+
+#define mmNIC4_QM1_CP_MSG_BASE0_ADDR_HI_4                            0xDE224C
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_LO_0                            0xDE2250
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_LO_1                            0xDE2254
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_LO_2                            0xDE2258
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_LO_3                            0xDE225C
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_LO_4                            0xDE2260
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_HI_0                            0xDE2264
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_HI_1                            0xDE2268
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_HI_2                            0xDE226C
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_HI_3                            0xDE2270
+
+#define mmNIC4_QM1_CP_MSG_BASE1_ADDR_HI_4                            0xDE2274
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_LO_0                            0xDE2278
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_LO_1                            0xDE227C
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_LO_2                            0xDE2280
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_LO_3                            0xDE2284
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_LO_4                            0xDE2288
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_HI_0                            0xDE228C
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_HI_1                            0xDE2290
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_HI_2                            0xDE2294
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_HI_3                            0xDE2298
+
+#define mmNIC4_QM1_CP_MSG_BASE2_ADDR_HI_4                            0xDE229C
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_LO_0                            0xDE22A0
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_LO_1                            0xDE22A4
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_LO_2                            0xDE22A8
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_LO_3                            0xDE22AC
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_LO_4                            0xDE22B0
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_HI_0                            0xDE22B4
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_HI_1                            0xDE22B8
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_HI_2                            0xDE22BC
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_HI_3                            0xDE22C0
+
+#define mmNIC4_QM1_CP_MSG_BASE3_ADDR_HI_4                            0xDE22C4
+
+#define mmNIC4_QM1_CP_LDMA_TSIZE_OFFSET_0                            0xDE22C8
+
+#define mmNIC4_QM1_CP_LDMA_TSIZE_OFFSET_1                            0xDE22CC
+
+#define mmNIC4_QM1_CP_LDMA_TSIZE_OFFSET_2                            0xDE22D0
+
+#define mmNIC4_QM1_CP_LDMA_TSIZE_OFFSET_3                            0xDE22D4
+
+#define mmNIC4_QM1_CP_LDMA_TSIZE_OFFSET_4                            0xDE22D8
+
+#define mmNIC4_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_0                      0xDE22E0
+
+#define mmNIC4_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_1                      0xDE22E4
+
+#define mmNIC4_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_2                      0xDE22E8
+
+#define mmNIC4_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_3                      0xDE22EC
+
+#define mmNIC4_QM1_CP_LDMA_SRC_BASE_LO_OFFSET_4                      0xDE22F0
+
+#define mmNIC4_QM1_CP_LDMA_DST_BASE_LO_OFFSET_0                      0xDE22F4
+
+#define mmNIC4_QM1_CP_LDMA_DST_BASE_LO_OFFSET_1                      0xDE22F8
+
+#define mmNIC4_QM1_CP_LDMA_DST_BASE_LO_OFFSET_2                      0xDE22FC
+
+#define mmNIC4_QM1_CP_LDMA_DST_BASE_LO_OFFSET_3                      0xDE2300
+
+#define mmNIC4_QM1_CP_LDMA_DST_BASE_LO_OFFSET_4                      0xDE2304
+
+#define mmNIC4_QM1_CP_FENCE0_RDATA_0                                 0xDE2308
+
+#define mmNIC4_QM1_CP_FENCE0_RDATA_1                                 0xDE230C
+
+#define mmNIC4_QM1_CP_FENCE0_RDATA_2                                 0xDE2310
+
+#define mmNIC4_QM1_CP_FENCE0_RDATA_3                                 0xDE2314
+
+#define mmNIC4_QM1_CP_FENCE0_RDATA_4                                 0xDE2318
+
+#define mmNIC4_QM1_CP_FENCE1_RDATA_0                                 0xDE231C
+
+#define mmNIC4_QM1_CP_FENCE1_RDATA_1                                 0xDE2320
+
+#define mmNIC4_QM1_CP_FENCE1_RDATA_2                                 0xDE2324
+
+#define mmNIC4_QM1_CP_FENCE1_RDATA_3                                 0xDE2328
+
+#define mmNIC4_QM1_CP_FENCE1_RDATA_4                                 0xDE232C
+
+#define mmNIC4_QM1_CP_FENCE2_RDATA_0                                 0xDE2330
+
+#define mmNIC4_QM1_CP_FENCE2_RDATA_1                                 0xDE2334
+
+#define mmNIC4_QM1_CP_FENCE2_RDATA_2                                 0xDE2338
+
+#define mmNIC4_QM1_CP_FENCE2_RDATA_3                                 0xDE233C
+
+#define mmNIC4_QM1_CP_FENCE2_RDATA_4                                 0xDE2340
+
+#define mmNIC4_QM1_CP_FENCE3_RDATA_0                                 0xDE2344
+
+#define mmNIC4_QM1_CP_FENCE3_RDATA_1                                 0xDE2348
+
+#define mmNIC4_QM1_CP_FENCE3_RDATA_2                                 0xDE234C
+
+#define mmNIC4_QM1_CP_FENCE3_RDATA_3                                 0xDE2350
+
+#define mmNIC4_QM1_CP_FENCE3_RDATA_4                                 0xDE2354
+
+#define mmNIC4_QM1_CP_FENCE0_CNT_0                                   0xDE2358
+
+#define mmNIC4_QM1_CP_FENCE0_CNT_1                                   0xDE235C
+
+#define mmNIC4_QM1_CP_FENCE0_CNT_2                                   0xDE2360
+
+#define mmNIC4_QM1_CP_FENCE0_CNT_3                                   0xDE2364
+
+#define mmNIC4_QM1_CP_FENCE0_CNT_4                                   0xDE2368
+
+#define mmNIC4_QM1_CP_FENCE1_CNT_0                                   0xDE236C
+
+#define mmNIC4_QM1_CP_FENCE1_CNT_1                                   0xDE2370
+
+#define mmNIC4_QM1_CP_FENCE1_CNT_2                                   0xDE2374
+
+#define mmNIC4_QM1_CP_FENCE1_CNT_3                                   0xDE2378
+
+#define mmNIC4_QM1_CP_FENCE1_CNT_4                                   0xDE237C
+
+#define mmNIC4_QM1_CP_FENCE2_CNT_0                                   0xDE2380
+
+#define mmNIC4_QM1_CP_FENCE2_CNT_1                                   0xDE2384
+
+#define mmNIC4_QM1_CP_FENCE2_CNT_2                                   0xDE2388
+
+#define mmNIC4_QM1_CP_FENCE2_CNT_3                                   0xDE238C
+
+#define mmNIC4_QM1_CP_FENCE2_CNT_4                                   0xDE2390
+
+#define mmNIC4_QM1_CP_FENCE3_CNT_0                                   0xDE2394
+
+#define mmNIC4_QM1_CP_FENCE3_CNT_1                                   0xDE2398
+
+#define mmNIC4_QM1_CP_FENCE3_CNT_2                                   0xDE239C
+
+#define mmNIC4_QM1_CP_FENCE3_CNT_3                                   0xDE23A0
+
+#define mmNIC4_QM1_CP_FENCE3_CNT_4                                   0xDE23A4
+
+#define mmNIC4_QM1_CP_STS_0                                          0xDE23A8
+
+#define mmNIC4_QM1_CP_STS_1                                          0xDE23AC
+
+#define mmNIC4_QM1_CP_STS_2                                          0xDE23B0
+
+#define mmNIC4_QM1_CP_STS_3                                          0xDE23B4
+
+#define mmNIC4_QM1_CP_STS_4                                          0xDE23B8
+
+#define mmNIC4_QM1_CP_CURRENT_INST_LO_0                              0xDE23BC
+
+#define mmNIC4_QM1_CP_CURRENT_INST_LO_1                              0xDE23C0
+
+#define mmNIC4_QM1_CP_CURRENT_INST_LO_2                              0xDE23C4
+
+#define mmNIC4_QM1_CP_CURRENT_INST_LO_3                              0xDE23C8
+
+#define mmNIC4_QM1_CP_CURRENT_INST_LO_4                              0xDE23CC
+
+#define mmNIC4_QM1_CP_CURRENT_INST_HI_0                              0xDE23D0
+
+#define mmNIC4_QM1_CP_CURRENT_INST_HI_1                              0xDE23D4
+
+#define mmNIC4_QM1_CP_CURRENT_INST_HI_2                              0xDE23D8
+
+#define mmNIC4_QM1_CP_CURRENT_INST_HI_3                              0xDE23DC
+
+#define mmNIC4_QM1_CP_CURRENT_INST_HI_4                              0xDE23E0
+
+#define mmNIC4_QM1_CP_BARRIER_CFG_0                                  0xDE23F4
+
+#define mmNIC4_QM1_CP_BARRIER_CFG_1                                  0xDE23F8
+
+#define mmNIC4_QM1_CP_BARRIER_CFG_2                                  0xDE23FC
+
+#define mmNIC4_QM1_CP_BARRIER_CFG_3                                  0xDE2400
+
+#define mmNIC4_QM1_CP_BARRIER_CFG_4                                  0xDE2404
+
+#define mmNIC4_QM1_CP_DBG_0_0                                        0xDE2408
+
+#define mmNIC4_QM1_CP_DBG_0_1                                        0xDE240C
+
+#define mmNIC4_QM1_CP_DBG_0_2                                        0xDE2410
+
+#define mmNIC4_QM1_CP_DBG_0_3                                        0xDE2414
+
+#define mmNIC4_QM1_CP_DBG_0_4                                        0xDE2418
+
+#define mmNIC4_QM1_CP_ARUSER_31_11_0                                 0xDE241C
+
+#define mmNIC4_QM1_CP_ARUSER_31_11_1                                 0xDE2420
+
+#define mmNIC4_QM1_CP_ARUSER_31_11_2                                 0xDE2424
+
+#define mmNIC4_QM1_CP_ARUSER_31_11_3                                 0xDE2428
+
+#define mmNIC4_QM1_CP_ARUSER_31_11_4                                 0xDE242C
+
+#define mmNIC4_QM1_CP_AWUSER_31_11_0                                 0xDE2430
+
+#define mmNIC4_QM1_CP_AWUSER_31_11_1                                 0xDE2434
+
+#define mmNIC4_QM1_CP_AWUSER_31_11_2                                 0xDE2438
+
+#define mmNIC4_QM1_CP_AWUSER_31_11_3                                 0xDE243C
+
+#define mmNIC4_QM1_CP_AWUSER_31_11_4                                 0xDE2440
+
+#define mmNIC4_QM1_ARB_CFG_0                                         0xDE2A00
+
+#define mmNIC4_QM1_ARB_CHOISE_Q_PUSH                                 0xDE2A04
+
+#define mmNIC4_QM1_ARB_WRR_WEIGHT_0                                  0xDE2A08
+
+#define mmNIC4_QM1_ARB_WRR_WEIGHT_1                                  0xDE2A0C
+
+#define mmNIC4_QM1_ARB_WRR_WEIGHT_2                                  0xDE2A10
+
+#define mmNIC4_QM1_ARB_WRR_WEIGHT_3                                  0xDE2A14
+
+#define mmNIC4_QM1_ARB_CFG_1                                         0xDE2A18
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_0                              0xDE2A20
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_1                              0xDE2A24
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_2                              0xDE2A28
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_3                              0xDE2A2C
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_4                              0xDE2A30
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_5                              0xDE2A34
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_6                              0xDE2A38
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_7                              0xDE2A3C
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_8                              0xDE2A40
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_9                              0xDE2A44
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_10                             0xDE2A48
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_11                             0xDE2A4C
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_12                             0xDE2A50
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_13                             0xDE2A54
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_14                             0xDE2A58
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_15                             0xDE2A5C
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_16                             0xDE2A60
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_17                             0xDE2A64
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_18                             0xDE2A68
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_19                             0xDE2A6C
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_20                             0xDE2A70
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_21                             0xDE2A74
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_22                             0xDE2A78
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_23                             0xDE2A7C
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_24                             0xDE2A80
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_25                             0xDE2A84
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_26                             0xDE2A88
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_27                             0xDE2A8C
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_28                             0xDE2A90
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_29                             0xDE2A94
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_30                             0xDE2A98
+
+#define mmNIC4_QM1_ARB_MST_AVAIL_CRED_31                             0xDE2A9C
+
+#define mmNIC4_QM1_ARB_MST_CRED_INC                                  0xDE2AA0
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_0                        0xDE2AA4
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_1                        0xDE2AA8
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_2                        0xDE2AAC
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_3                        0xDE2AB0
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_4                        0xDE2AB4
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_5                        0xDE2AB8
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_6                        0xDE2ABC
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_7                        0xDE2AC0
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_8                        0xDE2AC4
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_9                        0xDE2AC8
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_10                       0xDE2ACC
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_11                       0xDE2AD0
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_12                       0xDE2AD4
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_13                       0xDE2AD8
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_14                       0xDE2ADC
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_15                       0xDE2AE0
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_16                       0xDE2AE4
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_17                       0xDE2AE8
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_18                       0xDE2AEC
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_19                       0xDE2AF0
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_20                       0xDE2AF4
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_21                       0xDE2AF8
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_22                       0xDE2AFC
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_23                       0xDE2B00
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_24                       0xDE2B04
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_25                       0xDE2B08
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_26                       0xDE2B0C
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_27                       0xDE2B10
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_28                       0xDE2B14
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_29                       0xDE2B18
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_30                       0xDE2B1C
+
+#define mmNIC4_QM1_ARB_MST_CHOISE_PUSH_OFST_31                       0xDE2B20
+
+#define mmNIC4_QM1_ARB_SLV_MASTER_INC_CRED_OFST                      0xDE2B28
+
+#define mmNIC4_QM1_ARB_MST_SLAVE_EN                                  0xDE2B2C
+
+#define mmNIC4_QM1_ARB_MST_QUIET_PER                                 0xDE2B34
+
+#define mmNIC4_QM1_ARB_SLV_CHOISE_WDT                                0xDE2B38
+
+#define mmNIC4_QM1_ARB_SLV_ID                                        0xDE2B3C
+
+#define mmNIC4_QM1_ARB_MSG_MAX_INFLIGHT                              0xDE2B44
+
+#define mmNIC4_QM1_ARB_MSG_AWUSER_31_11                              0xDE2B48
+
+#define mmNIC4_QM1_ARB_MSG_AWUSER_SEC_PROP                           0xDE2B4C
+
+#define mmNIC4_QM1_ARB_MSG_AWUSER_NON_SEC_PROP                       0xDE2B50
+
+#define mmNIC4_QM1_ARB_BASE_LO                                       0xDE2B54
+
+#define mmNIC4_QM1_ARB_BASE_HI                                       0xDE2B58
+
+#define mmNIC4_QM1_ARB_STATE_STS                                     0xDE2B80
+
+#define mmNIC4_QM1_ARB_CHOISE_FULLNESS_STS                           0xDE2B84
+
+#define mmNIC4_QM1_ARB_MSG_STS                                       0xDE2B88
+
+#define mmNIC4_QM1_ARB_SLV_CHOISE_Q_HEAD                             0xDE2B8C
+
+#define mmNIC4_QM1_ARB_ERR_CAUSE                                     0xDE2B9C
+
+#define mmNIC4_QM1_ARB_ERR_MSG_EN                                    0xDE2BA0
+
+#define mmNIC4_QM1_ARB_ERR_STS_DRP                                   0xDE2BA8
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_0                                0xDE2BB0
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_1                                0xDE2BB4
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_2                                0xDE2BB8
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_3                                0xDE2BBC
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_4                                0xDE2BC0
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_5                                0xDE2BC4
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_6                                0xDE2BC8
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_7                                0xDE2BCC
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_8                                0xDE2BD0
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_9                                0xDE2BD4
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_10                               0xDE2BD8
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_11                               0xDE2BDC
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_12                               0xDE2BE0
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_13                               0xDE2BE4
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_14                               0xDE2BE8
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_15                               0xDE2BEC
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_16                               0xDE2BF0
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_17                               0xDE2BF4
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_18                               0xDE2BF8
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_19                               0xDE2BFC
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_20                               0xDE2C00
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_21                               0xDE2C04
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_22                               0xDE2C08
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_23                               0xDE2C0C
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_24                               0xDE2C10
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_25                               0xDE2C14
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_26                               0xDE2C18
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_27                               0xDE2C1C
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_28                               0xDE2C20
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_29                               0xDE2C24
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_30                               0xDE2C28
+
+#define mmNIC4_QM1_ARB_MST_CRED_STS_31                               0xDE2C2C
+
+#define mmNIC4_QM1_CGM_CFG                                           0xDE2C70
+
+#define mmNIC4_QM1_CGM_STS                                           0xDE2C74
+
+#define mmNIC4_QM1_CGM_CFG1                                          0xDE2C78
+
+#define mmNIC4_QM1_LOCAL_RANGE_BASE                                  0xDE2C80
+
+#define mmNIC4_QM1_LOCAL_RANGE_SIZE                                  0xDE2C84
+
+#define mmNIC4_QM1_CSMR_STRICT_PRIO_CFG                              0xDE2C90
+
+#define mmNIC4_QM1_HBW_RD_RATE_LIM_CFG_1                             0xDE2C94
+
+#define mmNIC4_QM1_LBW_WR_RATE_LIM_CFG_0                             0xDE2C98
+
+#define mmNIC4_QM1_LBW_WR_RATE_LIM_CFG_1                             0xDE2C9C
+
+#define mmNIC4_QM1_HBW_RD_RATE_LIM_CFG_0                             0xDE2CA0
+
+#define mmNIC4_QM1_GLBL_AXCACHE                                      0xDE2CA4
+
+#define mmNIC4_QM1_IND_GW_APB_CFG                                    0xDE2CB0
+
+#define mmNIC4_QM1_IND_GW_APB_WDATA                                  0xDE2CB4
+
+#define mmNIC4_QM1_IND_GW_APB_RDATA                                  0xDE2CB8
+
+#define mmNIC4_QM1_IND_GW_APB_STATUS                                 0xDE2CBC
+
+#define mmNIC4_QM1_GLBL_ERR_ADDR_LO                                  0xDE2CD0
+
+#define mmNIC4_QM1_GLBL_ERR_ADDR_HI                                  0xDE2CD4
+
+#define mmNIC4_QM1_GLBL_ERR_WDATA                                    0xDE2CD8
+
+#define mmNIC4_QM1_GLBL_MEM_INIT_BUSY                                0xDE2D00
+
+#endif /* ASIC_REG_NIC4_QM1_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index f395721060bd..67540be99e7a 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -41,6 +41,11 @@
 	(FIELD_PREP(TPC0_QM_GLBL_CFG0_CQF_EN_MASK, 0x1F)) | \
 	(FIELD_PREP(TPC0_QM_GLBL_CFG0_CP_EN_MASK, 0x1F)))
 
+#define NIC_QMAN_ENABLE		(\
+	(FIELD_PREP(NIC0_QM0_GLBL_CFG0_PQF_EN_MASK, 0xF)) | \
+	(FIELD_PREP(NIC0_QM0_GLBL_CFG0_CQF_EN_MASK, 0xF)) | \
+	(FIELD_PREP(NIC0_QM0_GLBL_CFG0_CP_EN_MASK, 0xF)))
+
 #define QMAN_UPPER_CP_CGM_PWR_GATE_EN	(\
 	(FIELD_PREP(DMA0_QM_CGM_CFG_IDLE_TH_MASK, 0x20)) | \
 	(FIELD_PREP(DMA0_QM_CGM_CFG_G2F_TH_MASK, 0xA)) | \
@@ -93,6 +98,16 @@
 	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0x1F)) | \
 	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)))
 
+#define NIC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
+	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
+	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_CQF_ERR_MSG_EN_MASK, 0xF)) | \
+	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_CP_ERR_MSG_EN_MASK, 0xF)))
+
+#define NIC_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
+	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0xF)))
+
 #define QMAN_CGM1_PWR_GATE_EN	(FIELD_PREP(DMA0_QM_CGM_CFG1_MASK_TH_MASK, 0xA))
 
 /* RESET registers configuration */
-- 
2.17.1

