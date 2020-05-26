Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5A1B1849
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 23:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgDTVVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 17:21:22 -0400
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:64815
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbgDTVVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:21:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJNqAEK2RLUvdTuPsSUY10TMfWuGVBuWtPaCzdSaiu1l6VC517F/5djElE9JDqJfuT6soGB51h9aMQtlBcA+WRfCDFs12nZF23z5+dgsGsbvaI8QAxISvjQ/ph5ZAEOEslff8QSuA3owedEshSc37+Pj3hufojBHxOM2dcYrcfSm9g8N13ojQH5cc6PKgeXrmpZKWT8OU5d/tjHM6uF6DZyDttRMUdy3ZT047wObRN6cFFC6lxYRk/CfuUi7H/wlFyzooXdF2vaUjL7volVfNJO0er01oumU52/OHADVRiUZoMyDjCMYwQBPr/s1UvxL6defFOAmFnfqlNDhR78bxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgF2QJq1iBoCWzdnndLftVRaDvHRPxqIe5Xsc1potw0=;
 b=fmestkz5EkRMztEPDQf+j1Eu5MIzsL6VbkTHO3VmS813kRL7iXfdOVcxAvRANjsJkovBkAc6K5Q8qMVBPxC4yPEm/IpQjyv4Cu6Yw0LXhH6696LOeMfhcjknXM1CnhU0SPgGmsk5oc4RHGdk7kcKacljWSQVhAAt0vOBz/JAC0SXKJmKWfqU7ttvnEKL69C7XXi1ra+RtIff+6UeyKjxHWr1xmpkUVlw/7Igcn26uuXToT1tF2L89ZHL06zISpn5bYApIwdB5F4y19z/dW45cfM/UmgdZMoh7PcnW/8WSSNbG3U+l6O5KtCs9MxRzCwpLP4j/4tJfCOnFLqPq4tfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgF2QJq1iBoCWzdnndLftVRaDvHRPxqIe5Xsc1potw0=;
 b=MVLWJf6vJrMqnhDWIsl+5GiQZZXGSqy5EQ4za5wQJXzcSHv2rjvmzVx3IqPEnTk30sMBRhc9lDMFUL6DLlQ3PWWRO8D/E8qTYLBi/HekyILTnCBJeNqDqAtWQr1S1tvCL+b4GhuaExQqC+FUcbd5Afv/3ihMCsTERbGIDVekVMQ=
Received: from BL0PR02CA0108.namprd02.prod.outlook.com (2603:10b6:208:51::49)
 by DM5PR02MB2764.namprd02.prod.outlook.com (2603:10b6:3:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 21:21:13 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::cc) by BL0PR02CA0108.outlook.office365.com
 (2603:10b6:208:51::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 21:21:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 21:21:12
 +0000
Received: from [149.199.38.66] (port=60267 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <venkateshwar.rao.gannavarapu@xilinx.com>)
        id 1jQdpt-0007rj-93; Mon, 20 Apr 2020 14:20:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <venkateshwar.rao.gannavarapu@xilinx.com>)
        id 1jQdqq-0003Iv-AZ; Mon, 20 Apr 2020 14:21:12 -0700
Received: from [172.23.62.221] (helo=xhdrdevl201.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <venkateshwar.rao.gannavarapu@xilinx.com>)
        id 1jQdqm-0003FI-KK; Mon, 20 Apr 2020 14:21:09 -0700
From:   Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>
To:     hyun.kwon@xilinx.com, laurent.pinchart@ideasonboard.com,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        sandipk@xilinx.com, vgannava@xilinx.com,
        Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>
Subject: [RFC PATCH 2/2] drm: xlnx: driver for Xilinx DSI TX Subsystem
Date:   Tue, 21 Apr 2020 02:50:56 +0530
Message-Id: <1587417656-48078-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587417656-48078-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
References: <1587417656-48078-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(7696005)(5660300002)(26005)(478600001)(30864003)(70586007)(186003)(70206006)(47076004)(316002)(336012)(6666004)(356005)(2906002)(2616005)(82740400003)(8936002)(426003)(8676002)(4326008)(9786002)(81166007)(81156014)(107886003)(36756003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48ad70bd-78fa-4c06-6f22-08d7e570c09c
X-MS-TrafficTypeDiagnostic: DM5PR02MB2764:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2764A77FFF32810CC1D50162B1D40@DM5PR02MB2764.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 03793408BA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCFzW789KcHMZsYPGTRL7TPs1eACC3W9/yKMM4Dt64xiog2MWvwnbhE4wTVJ7Hbkn9xxQjBGLfjeG7yX6rthPhcAgF45t10mrkRmKw3i39F0B40f0i5bfG44W0KK7ldAb4Thz1RuMK8EX1CdeTN+gEUsd6FJFlJTONmpWSEOkSWrvysrzAgDez1+0H6j0ftMTUzGsBgGFmKycBr8pG+06MFF643j/aGS9ktMJQ6K15P/UbLQOYxaaVjYaMxRGRxnqDgwMrmOFYOhHUK0cPvIe0amLGlXBprSM9gVjhCF10vJS25zEjwql9o2O2Reo03LIzR+z46gprzD3x+vK1EJLXFMt2USvAAdcd+hoZ3/dhmr3n3svuTkvc/NuLxOtZvQd/bGjPPDkzvC8/Fp2z4PDdAgxkl2gJV+9B6mH0ThmafdblFReQo64Gr+S818xLPoNeA6v0qzEACMGGBekADixDbpSsrBLzeYBEkDdzJV+h8Pv47OH2i7AtpPVBfWX4zlseWvmiZAx9I+ipJOU67Qzg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 21:21:12.6709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ad70bd-78fa-4c06-6f22-08d7e570c09c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx MIPI DSI Tx Subsystem soft IP is used to display video
data from AXI-4 stream interface.

It supports upto 4 lanes, optional register interface for the DPHY,
multiple RGB color formats, command mode and video mode.
This is a MIPI-DSI host driver and provides DSI bus for panels.
This driver also helps to communicate with its panel using panel
framework.

Signed-off-by: Venkateshwar Rao Gannavarapu <venkateshwar.rao.gannavarapu@x=
ilinx.com>
---
 drivers/gpu/drm/xlnx/Kconfig    |  11 +
 drivers/gpu/drm/xlnx/Makefile   |   2 +
 drivers/gpu/drm/xlnx/xlnx_dsi.c | 755 ++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 768 insertions(+)
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_dsi.c

diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
index aa6cd88..73873cf 100644
--- a/drivers/gpu/drm/xlnx/Kconfig
+++ b/drivers/gpu/drm/xlnx/Kconfig
@@ -11,3 +11,14 @@ config DRM_ZYNQMP_DPSUB
          This is a DRM/KMS driver for ZynqMP DisplayPort controller. Choos=
e
          this option if you have a Xilinx ZynqMP SoC with DisplayPort
          subsystem.
+
+config DRM_XLNX_DSI
+        tristate "Xilinx DRM DSI Subsystem Driver"
+        select DRM_MIPI_DSI
+        select DRM_PANEL
+        select DRM_PANEL_SIMPLE
+        help
+         This enables support for Xilinx MIPI-DSI.
+         This is a DRM/KMS driver for Xilinx programmable DSI controller.
+         Choose this option if you have a Xilinx MIPI DSI-TX controller
+         subsytem.
diff --git a/drivers/gpu/drm/xlnx/Makefile b/drivers/gpu/drm/xlnx/Makefile
index 2b844c6..b7ee6ef 100644
--- a/drivers/gpu/drm/xlnx/Makefile
+++ b/drivers/gpu/drm/xlnx/Makefile
@@ -1,2 +1,4 @@
 zynqmp-dpsub-objs +=3D zynqmp_disp.o zynqmp_dpsub.o zynqmp_dp.o
 obj-$(CONFIG_DRM_ZYNQMP_DPSUB) +=3D zynqmp-dpsub.o
+
+obj-$(CONFIG_DRM_XLNX_DSI) +=3D xlnx_dsi.o
diff --git a/drivers/gpu/drm/xlnx/xlnx_dsi.c b/drivers/gpu/drm/xlnx/xlnx_ds=
i.c
new file mode 100644
index 0000000..b8cae59
--- /dev/null
+++ b/drivers/gpu/drm/xlnx/xlnx_dsi.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx FPGA MIPI DSI Tx Controller driver
+ *
+ * Copyright (C) 2017 - 2019 Xilinx, Inc.
+ *
+ * Authors:
+ * - Saurabh Sengar <saurabhs@xilinx.com>
+ * - Venkateshwar Rao Gannavarapu <venkateshwar.rao.gannavarapu@xilinx.com=
>
+ */
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/phy/phy.h>
+
+#include <video/mipi_display.h>
+#include <video/videomode.h>
+
+/* DSI Tx IP registers */
+#define XDSI_CCR                       0x00
+#define XDSI_CCR_COREENB               BIT(0)
+#define XDSI_CCR_SOFTRST               BIT(1)
+#define XDSI_CCR_CRREADY               BIT(2)
+#define XDSI_CCR_CMDMODE               BIT(3)
+#define XDSI_CCR_DFIFORST              BIT(4)
+#define XDSI_CCR_CMDFIFORST            BIT(5)
+#define XDSI_PCR                       0x04
+#define XDSI_PCR_VIDEOMODE(x)          (((x) & 0x3) << 3)
+#define XDSI_PCR_VIDEOMODE_MASK                (0x3 << 3)
+#define XDSI_PCR_VIDEOMODE_SHIFT       3
+#define XDSI_PCR_BLLPTYPE(x)           ((x) << 5)
+#define XDSI_PCR_BLLPMODE(x)           ((x) << 6)
+#define XDSI_PCR_EOTPENABLE(x)         ((x) << 13)
+#define XDSI_GIER                      0x20
+#define XDSI_ISR                       0x24
+#define XDSI_IER                       0x28
+#define XDSI_STR                       0x2C
+#define XDSI_STR_RDY_SHPKT             BIT(6)
+#define XDSI_STR_RDY_LNGPKT            BIT(7)
+#define XDSI_STR_DFIFO_FULL            BIT(8)
+#define XDSI_STR_DFIFO_EMPTY           BIT(9)
+#define XDSI_STR_WAITFR_DATA           BIT(10)
+#define XDSI_STR_CMD_EXE_PGS           BIT(11)
+#define XDSI_STR_CCMD_PROC             BIT(12)
+#define XDSI_STR_LPKT_MASK             (0x5 << 7)
+#define XDSI_CMD                       0x30
+#define XDSI_CMD_QUEUE_PACKET(x)       ((x) & GENMASK(23, 0))
+#define XDSI_DFR                       0x34
+#define XDSI_TIME1                     0x50
+#define XDSI_TIME1_BLLP_BURST(x)       ((x) & GENMASK(15, 0))
+#define XDSI_TIME1_HSA(x)              (((x) & GENMASK(15, 0)) << 16)
+#define XDSI_TIME2                     0x54
+#define XDSI_TIME2_VACT(x)             ((x) & GENMASK(15, 0))
+#define XDSI_TIME2_HACT(x)             (((x) & GENMASK(15, 0)) << 16)
+#define XDSI_HACT_MULTIPLIER           GENMASK(1, 0)
+#define XDSI_TIME3                     0x58
+#define XDSI_TIME3_HFP(x)              ((x) & GENMASK(15, 0))
+#define XDSI_TIME3_HBP(x)              (((x) & GENMASK(15, 0)) << 16)
+#define XDSI_TIME4                     0x5c
+#define XDSI_TIME4_VFP(x)              ((x) & GENMASK(7, 0))
+#define XDSI_TIME4_VBP(x)              (((x) & GENMASK(7, 0)) << 8)
+#define XDSI_TIME4_VSA(x)              (((x) & GENMASK(7, 0)) << 16)
+#define XDSI_LTIME                     0x60
+#define XDSI_BLLP_TIME                 0x64
+/*
+ * XDSI_NUM_DATA_T represents number of data types in the
+ * enum mipi_dsi_pixel_format in the MIPI DSI part of DRM framework.
+ */
+#define XDSI_NUM_DATA_T                        4
+#define XDSI_VIDEO_MODE_SYNC_PULSE     0x0
+#define XDSI_VIDEO_MODE_SYNC_EVENT     0x1
+#define XDSI_VIDEO_MODE_BURST          0x2
+
+#define XDSI_DPHY_CLK_MIN      197000000000UL
+#define XDSI_DPHY_CLK_MAX      203000000000UL
+#define XDSI_DPHY_CLK_REQ      200000000000UL
+
+/* command timeout in usec */
+#define XDSI_CMD_TIMEOUT_VAL   (3000)
+
+/**
+ * struct xlnx_dsi - Xilinx DSI-TX core
+ * @encoder: DRM encoder structure
+ * @dsi_host: DSI host device
+ * @connector: DRM connector structure
+ * @panel_node: MIPI DSI device panel node
+ * @panel:  DRM panel structure
+ * @dev: device structure
+ * @iomem: Base address of DSI subsystem
+ * @lanes: number of active data lanes supported by DSI controller
+ * @cmdmode: command mode support
+ * @mode_flags: DSI operation mode related flags
+ * @format: pixel format for video mode of DSI controller
+ * @vm: videomode data structure
+ * @mul_factor: multiplication factor for HACT timing parameter
+ * @video_aclk: Video clock
+ * @dphy_clk_200M: 200MHz DPHY clock and AXI Lite clock
+ */
+struct xlnx_dsi {
+       struct drm_encoder encoder;
+       struct mipi_dsi_host dsi_host;
+       struct drm_connector connector;
+       struct device_node *panel_node;
+       struct drm_panel *panel;
+       struct device *dev;
+       void __iomem *iomem;
+       u32 lanes;
+       bool cmdmode;
+       u32 mode_flags;
+       enum mipi_dsi_pixel_format format;
+       struct videomode vm;
+       u32 mul_factor;
+       struct clk *video_aclk;
+       struct clk *dphy_clk_200M;
+};
+
+#define host_to_dsi(host) container_of(host, struct xlnx_dsi, dsi_host)
+#define connector_to_dsi(c) container_of(c, struct xlnx_dsi, connector)
+#define encoder_to_dsi(e) container_of(e, struct xlnx_dsi, encoder)
+
+static inline void xlnx_dsi_writel(void __iomem *base, int offset, u32 val=
)
+{
+       writel(val, base + offset);
+}
+
+static inline u32 xlnx_dsi_readl(void __iomem *base, int offset)
+{
+       return readl(base + offset);
+}
+
+/**
+ * xlnx_dsi_set_display_mode - Configure DSI timing registers
+ * @dsi: xilinx DSI structure
+ *
+ * This function writes the timing parameters of DSI IP which are
+ * retrieved from panel timing values.
+ */
+static void xlnx_dsi_set_display_mode(struct xlnx_dsi *dsi)
+{
+       struct videomode *vm =3D &dsi->vm;
+       u32 reg, video_mode;
+
+       reg =3D xlnx_dsi_readl(dsi->iomem, XDSI_PCR);
+       video_mode =3D (reg & XDSI_PCR_VIDEOMODE_MASK) >>
+                     XDSI_PCR_VIDEOMODE_SHIFT;
+
+       /* configure the HSA value only if non_burst_sync_pluse video mode =
*/
+       if (!video_mode &&
+           (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)) {
+               reg =3D XDSI_TIME1_HSA(vm->hsync_len);
+               xlnx_dsi_writel(dsi->iomem, XDSI_TIME1, reg);
+       }
+
+       reg =3D XDSI_TIME4_VFP(vm->vfront_porch) |
+             XDSI_TIME4_VBP(vm->vback_porch) |
+             XDSI_TIME4_VSA(vm->vsync_len);
+       xlnx_dsi_writel(dsi->iomem, XDSI_TIME4, reg);
+
+       reg =3D XDSI_TIME3_HFP(vm->hfront_porch) |
+             XDSI_TIME3_HBP(vm->hback_porch);
+       xlnx_dsi_writel(dsi->iomem, XDSI_TIME3, reg);
+
+       dev_dbg(dsi->dev, "mul factor for parsed datatype is =3D %d\n",
+               (dsi->mul_factor) / 100);
+       /*
+        * The HACT parameter received from panel timing values should be
+        * divisible by 4. The reason for this is, the word count given as
+        * input to DSI controller is HACT * mul_factor. The mul_factor is
+        * 3, 2.25, 2.25, 2 respectively for RGB888, RGB666_L, RGB666_P and
+        * RGB565.
+        * e.g. for RGB666_L color format and 1080p, the word count is
+        * 1920*2.25 =3D 4320 which is divisible by 4 and it is a valid inp=
ut
+        * to DSI controller. Based on this 2.25 mul factor, we come up wit=
h
+        * the division factor of (XDSI_HACT_MULTIPLIER) as 4 for checking
+        */
+       if ((vm->hactive & XDSI_HACT_MULTIPLIER) !=3D 0)
+               dev_warn(dsi->dev, "Incorrect HACT will be programmed\n");
+
+       reg =3D XDSI_TIME2_HACT((vm->hactive) * (dsi->mul_factor) / 100) |
+             XDSI_TIME2_VACT(vm->vactive);
+       xlnx_dsi_writel(dsi->iomem, XDSI_TIME2, reg);
+
+       dev_dbg(dsi->dev, "LCD size =3D %dx%d\n", vm->hactive, vm->vactive)=
;
+}
+
+/**
+ * xlnx_dsi_set_display_enable - Enables the DSI Tx IP core enable
+ * register bit
+ * @dsi: Xilinx DSI structure
+ *
+ * This function takes the DSI strucure and enables the core enable bit
+ * of core configuration register.
+ */
+static void xlnx_dsi_set_display_enable(struct xlnx_dsi *dsi)
+{
+       u32 reg;
+
+       reg =3D xlnx_dsi_readl(dsi->iomem, XDSI_CCR);
+       reg |=3D XDSI_CCR_COREENB;
+
+       xlnx_dsi_writel(dsi->iomem, XDSI_CCR, reg);
+       dev_dbg(dsi->dev, "MIPI DSI Tx controller is enabled.\n");
+}
+
+/**
+ * xlnx_dsi_set_display_disable - Disable the DSI Tx IP core enable
+ * register bit
+ * @dsi: Xilinx DSI structure
+ *
+ * This function takes the DSI strucure and disables the core enable bit
+ * of core configuration register.
+ */
+static void xlnx_dsi_set_display_disable(struct xlnx_dsi *dsi)
+{
+       u32 reg;
+
+       reg =3D xlnx_dsi_readl(dsi->iomem, XDSI_CCR);
+       reg &=3D ~XDSI_CCR_COREENB;
+
+       xlnx_dsi_writel(dsi->iomem, XDSI_CCR, reg);
+       dev_dbg(dsi->dev, "DSI Tx is disabled. reset regs to default values=
\n");
+}
+
+/**
+ * xlnx_dsi_host_transfer - transfer command to panel
+ * @host: mipi dsi host structure
+ * @msg: mipi dsi msg with type, length and data
+ *
+ * This function is valid only in command mode.
+ * It checks the command fifo empty status and writes into
+ * data or cmd register and waits for the completion status.
+ *
+ * Return:     number of bytes, on success and error number on failure
+ */
+static ssize_t xlnx_dsi_host_transfer(struct mipi_dsi_host *host,
+                                     const struct mipi_dsi_msg *msg)
+{
+       struct xlnx_dsi *dsi =3D host_to_dsi(host);
+       u32 data0, data1, cmd0, status, val;
+       const char *tx_buf =3D msg->tx_buf;
+
+       if (!(xlnx_dsi_readl(dsi->iomem, XDSI_CCR) & (XDSI_CCR_COREENB |
+                                                     XDSI_CCR_CMDMODE))) {
+               dev_err(dsi->dev, "dsi command mode not enabled\n");
+               return -EINVAL;
+       }
+
+       if (msg->type =3D=3D MIPI_DSI_DCS_LONG_WRITE) {
+               status =3D readl_poll_timeout(dsi->iomem + XDSI_STR, val,
+                                           ((val & XDSI_STR_LPKT_MASK) =3D=
=3D
+                                            XDSI_STR_LPKT_MASK), 1,
+                                           XDSI_CMD_TIMEOUT_VAL);
+               if (status) {
+                       dev_err(dsi->dev, "long cmd fifo not empty!\n");
+                       return -ETIMEDOUT;
+               }
+               data0 =3D tx_buf[0] | (tx_buf[1] << 8) | (tx_buf[2] << 16) =
|
+                       (tx_buf[3] << 24);
+               data1 =3D tx_buf[4] | (tx_buf[5] << 8);
+               cmd0 =3D msg->type | (MIPI_DSI_DCS_READ << 8);
+
+               xlnx_dsi_writel(dsi->iomem, XDSI_DFR, data0);
+               xlnx_dsi_writel(dsi->iomem, XDSI_DFR, data1);
+               xlnx_dsi_writel(dsi->iomem, XDSI_CMD, cmd0);
+       } else {
+               data0 =3D tx_buf[0];
+               if (msg->type =3D=3D MIPI_DSI_DCS_SHORT_WRITE_PARAM)
+                       data0 =3D MIPI_DSI_DCS_SHORT_WRITE_PARAM |
+                               (tx_buf[0] << 8) | (tx_buf[1] << 16);
+               else
+                       data0 =3D MIPI_DSI_DCS_SHORT_WRITE | (tx_buf[0] << =
8);
+
+               status =3D readl_poll_timeout(dsi->iomem + XDSI_STR, val,
+                                           ((val & XDSI_STR_RDY_SHPKT) =3D=
=3D
+                                            XDSI_STR_RDY_SHPKT), 1,
+                                           XDSI_CMD_TIMEOUT_VAL);
+               if (status) {
+                       dev_err(dsi->dev, "short cmd fifo not empty\n");
+                       return -ETIMEDOUT;
+               }
+               xlnx_dsi_writel(dsi->iomem, XDSI_CMD, data0);
+       }
+
+       status =3D readl_poll_timeout(dsi->iomem + XDSI_STR, val,
+                                   (!(val & XDSI_STR_CMD_EXE_PGS)), 1,
+                                   XDSI_CMD_TIMEOUT_VAL);
+       if (status) {
+               dev_err(dsi->dev, "cmd time out\n");
+               return -ETIMEDOUT;
+       }
+
+       return msg->tx_len;
+}
+
+static int xlnx_dsi_host_attach(struct mipi_dsi_host *host,
+                               struct mipi_dsi_device *device)
+{
+       u32 panel_lanes;
+       struct xlnx_dsi *dsi =3D host_to_dsi(host);
+
+       panel_lanes =3D device->lanes;
+       dsi->mode_flags =3D device->mode_flags;
+       dsi->panel_node =3D device->dev.of_node;
+
+       if (panel_lanes !=3D dsi->lanes) {
+               dev_err(dsi->dev, "Mismatch of lanes. panel =3D %d, DSI =3D=
 %d\n",
+                       panel_lanes, dsi->lanes);
+               return -EINVAL;
+       }
+
+       if (device->format !=3D dsi->format) {
+               dev_err(dsi->dev, "Mismatch of format. panel =3D %d, DSI =
=3D %d\n",
+                       device->format, dsi->format);
+               return -EINVAL;
+       }
+
+       if (dsi->connector.dev)
+               drm_helper_hpd_irq_event(dsi->connector.dev);
+
+       return 0;
+}
+
+static int xlnx_dsi_host_detach(struct mipi_dsi_host *host,
+                               struct mipi_dsi_device *device)
+{
+       struct xlnx_dsi *dsi =3D host_to_dsi(host);
+
+       if (dsi->panel) {
+               drm_panel_detach(dsi->panel);
+               dsi->panel =3D NULL;
+       }
+
+       if (dsi->connector.dev)
+               drm_helper_hpd_irq_event(dsi->connector.dev);
+
+       return 0;
+}
+
+static const struct mipi_dsi_host_ops xlnx_dsi_ops =3D {
+       .attach =3D xlnx_dsi_host_attach,
+       .detach =3D xlnx_dsi_host_detach,
+       .transfer =3D xlnx_dsi_host_transfer,
+};
+
+static int xlnx_dsi_connector_dpms(struct drm_connector *connector,
+                                  int mode)
+{
+       struct xlnx_dsi *dsi =3D connector_to_dsi(connector);
+       int ret;
+
+       dev_dbg(dsi->dev, "connector dpms state: %d\n", mode);
+
+       switch (mode) {
+       case DRM_MODE_DPMS_ON:
+               ret =3D drm_panel_prepare(dsi->panel);
+               if (ret < 0) {
+                       dev_err(dsi->dev, "DRM panel not found\n");
+                       return ret;
+               }
+
+               ret =3D drm_panel_enable(dsi->panel);
+               if (ret < 0) {
+                       drm_panel_unprepare(dsi->panel);
+                       dev_err(dsi->dev, "DRM panel not enabled\n");
+                       return ret;
+               }
+               break;
+       default:
+               drm_panel_disable(dsi->panel);
+               drm_panel_unprepare(dsi->panel);
+               break;
+       }
+
+       return drm_helper_connector_dpms(connector, mode);
+}
+
+static enum drm_connector_status
+xlnx_dsi_detect(struct drm_connector *connector, bool force)
+{
+       struct xlnx_dsi *dsi =3D connector_to_dsi(connector);
+
+       if (!dsi->panel) {
+               dsi->panel =3D of_drm_find_panel(dsi->panel_node);
+               if (dsi->panel) {
+                       drm_panel_attach(dsi->panel, &dsi->connector);
+                       if (dsi->cmdmode) {
+                               xlnx_dsi_writel(dsi->iomem, XDSI_CCR,
+                                               XDSI_CCR_CMDMODE |
+                                               XDSI_CCR_COREENB);
+                               drm_panel_prepare(dsi->panel);
+                               xlnx_dsi_writel(dsi->iomem, XDSI_CCR, 0);
+                       }
+               }
+       } else if (!dsi->panel_node) {
+               xlnx_dsi_connector_dpms(connector, DRM_MODE_DPMS_OFF);
+               drm_panel_detach(dsi->panel);
+               dsi->panel =3D NULL;
+       }
+
+       if (dsi->panel)
+               return connector_status_connected;
+
+       return connector_status_disconnected;
+}
+
+static void xlnx_dsi_connector_destroy(struct drm_connector *connector)
+{
+       drm_connector_unregister(connector);
+       drm_connector_cleanup(connector);
+       connector->dev =3D NULL;
+}
+
+static const struct drm_connector_funcs xlnx_dsi_connector_funcs =3D {
+       .detect =3D xlnx_dsi_detect,
+       .fill_modes =3D drm_helper_probe_single_connector_modes,
+       .destroy =3D xlnx_dsi_connector_destroy,
+       .reset                  =3D drm_atomic_helper_connector_reset,
+       .atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_s=
tate,
+       .atomic_destroy_state   =3D drm_atomic_helper_connector_destroy_sta=
te,
+       .dpms =3D xlnx_dsi_connector_dpms,
+};
+
+static int xlnx_dsi_get_modes(struct drm_connector *connector)
+{
+       struct xlnx_dsi *dsi =3D connector_to_dsi(connector);
+
+       if (dsi->panel)
+               return drm_panel_get_modes(dsi->panel, connector);
+
+       return 0;
+}
+
+static struct drm_encoder *
+xlnx_dsi_best_encoder(struct drm_connector *connector)
+{
+       return &(connector_to_dsi(connector)->encoder);
+}
+
+static const struct drm_connector_helper_funcs
+xlnx_dsi_connector_helper_funcs =3D {
+       .get_modes =3D xlnx_dsi_get_modes,
+       .best_encoder =3D xlnx_dsi_best_encoder,
+};
+
+static int xlnx_dsi_create_connector(struct drm_encoder *encoder)
+{
+       struct xlnx_dsi *dsi =3D encoder_to_dsi(encoder);
+       struct drm_connector *connector =3D &dsi->connector;
+       struct drm_device *drm =3D encoder->dev;
+       int ret;
+
+       connector->polled =3D DRM_CONNECTOR_POLL_HPD;
+
+       ret =3D drm_connector_init(encoder->dev, connector,
+                                &xlnx_dsi_connector_funcs,
+                                DRM_MODE_CONNECTOR_DSI);
+       if (ret) {
+               dev_err(dsi->dev, "Failed to initialize connector with drm\=
n");
+               return ret;
+       }
+
+       drm_connector_helper_add(connector, &xlnx_dsi_connector_helper_func=
s);
+       drm_connector_attach_encoder(connector, encoder);
+       if (!drm->registered)
+               return 0;
+
+       drm_connector_register(connector);
+
+       return 0;
+}
+
+/**
+ * xlnx_dsi_atomic_mode_set -  derive the DSI timing parameters
+ *
+ * @encoder: pointer to Xilinx DRM encoder
+ * @crtc_state: Pointer to drm core crtc state
+ * @connector_state: DSI connector drm state
+ *
+ * This function derives the DSI IP timing parameters from the timing
+ * values given in the attached panel driver.
+ */
+static void
+xlnx_dsi_atomic_mode_set(struct drm_encoder *encoder,
+                        struct drm_crtc_state *crtc_state,
+                                struct drm_connector_state *connector_stat=
e)
+{
+       struct xlnx_dsi *dsi =3D encoder_to_dsi(encoder);
+       struct videomode *vm =3D &dsi->vm;
+       struct drm_display_mode *m =3D &crtc_state->adjusted_mode;
+
+       vm->hactive =3D m->hdisplay;
+       vm->vactive =3D m->vdisplay;
+       vm->vfront_porch =3D m->vsync_start - m->vdisplay;
+       vm->vback_porch =3D m->vtotal - m->vsync_end;
+       vm->vsync_len =3D m->vsync_end - m->vsync_start;
+       vm->hfront_porch =3D m->hsync_start - m->hdisplay;
+       vm->hback_porch =3D m->htotal - m->hsync_end;
+       vm->hsync_len =3D m->hsync_end - m->hsync_start;
+       xlnx_dsi_set_display_mode(dsi);
+}
+
+static void xlnx_dsi_disable(struct drm_encoder *encoder)
+{
+       struct xlnx_dsi *dsi =3D encoder_to_dsi(encoder);
+
+       xlnx_dsi_set_display_disable(dsi);
+}
+
+static void xlnx_dsi_enable(struct drm_encoder *encoder)
+{
+       struct xlnx_dsi *dsi =3D encoder_to_dsi(encoder);
+
+       xlnx_dsi_set_display_enable(dsi);
+}
+
+static const struct drm_encoder_helper_funcs
+xlnx_dsi_encoder_helper_funcs =3D {
+       .atomic_mode_set =3D xlnx_dsi_atomic_mode_set,
+       .enable =3D xlnx_dsi_enable,
+       .disable =3D xlnx_dsi_disable,
+};
+
+static const struct drm_encoder_funcs xlnx_dsi_encoder_funcs =3D {
+       .destroy =3D drm_encoder_cleanup,
+};
+
+static int xlnx_dsi_parse_dt(struct xlnx_dsi *dsi)
+{
+       struct device *dev =3D dsi->dev;
+       struct device_node *node =3D dev->of_node;
+       int ret;
+       u32 datatype;
+       static const int xdsi_mul_fact[XDSI_NUM_DATA_T] =3D {300, 225, 225,=
 200};
+
+       dsi->dphy_clk_200M =3D devm_clk_get(dev, "dphy_clk_200M");
+       if (IS_ERR(dsi->dphy_clk_200M)) {
+               ret =3D PTR_ERR(dsi->dphy_clk_200M);
+               dev_err(dev, "failed to get dphy_clk_200M %d\n", ret);
+               return ret;
+       }
+
+       dsi->video_aclk =3D devm_clk_get(dev, "s_axis_aclk");
+       if (IS_ERR(dsi->video_aclk)) {
+               ret =3D PTR_ERR(dsi->video_aclk);
+               dev_err(dev, "failed to get video_clk %d\n", ret);
+               return ret;
+       }
+
+       ret =3D of_property_read_u32(node, "xlnx,dsi-num-lanes", &dsi->lane=
s);
+       if (ret < 0) {
+               dev_err(dsi->dev, "missing xlnx,dsi-num-lanes property\n");
+               return ret;
+       }
+       if (dsi->lanes > 4 || dsi->lanes < 1) {
+               dev_err(dsi->dev, "%d lanes : invalid lanes\n", dsi->lanes)=
;
+               return -EINVAL;
+       }
+       ret =3D of_property_read_u32(node, "xlnx,dsi-data-type", &datatype)=
;
+       if (ret < 0) {
+               dev_err(dsi->dev, "missing xlnx,dsi-data-type property\n");
+               return ret;
+       }
+       dsi->format =3D datatype;
+       if (datatype > MIPI_DSI_FMT_RGB565) {
+               dev_err(dsi->dev, "Invalid xlnx,dsi-data-type string\n");
+               return -EINVAL;
+       }
+
+       /*
+        * multiplication factor used for HACT, based on data type.
+        *
+        * e.g. for RGB666_L datatype and 1920x1080 resolution,
+        * the Hact (WC) would be as follows -
+        * 1920 pixels * 18 bits per pixel / 8 bits per byte
+        * =3D 1920 pixels * 2.25 bytes per pixel =3D 4320 bytes.
+        *
+        * Data Type - Multiplication factor
+        * RGB888    - 3
+        * RGB666_L  - 2.25
+-       * RGB666_P  - 2.25
+        * RGB565    - 2
+        *
+        * Since the multiplication factor maybe a floating number,
+        * a 100x multiplication factor is used.
+        */
+       dsi->mul_factor =3D xdsi_mul_fact[datatype];
+
+       dsi->cmdmode =3D of_property_read_bool(node, "xlnx,dsi-cmd-mode");
+
+       dev_dbg(dsi->dev, "DSI controller num lanes =3D %d", dsi->lanes);
+       dev_dbg(dsi->dev, "DSI controller datatype =3D %d\n", datatype);
+       dev_dbg(dsi->dev, "DSI controller cmd mode =3D %d\n", dsi->cmdmode)=
;
+
+       return 0;
+}
+
+static int xlnx_dsi_bind(struct device *dev, struct device *master,
+                        void *data)
+{
+       struct xlnx_dsi *dsi =3D dev_get_drvdata(dev);
+       struct drm_encoder *encoder =3D &dsi->encoder;
+       struct drm_device *drm_dev =3D data;
+       int ret;
+
+       drm_encoder_init(drm_dev, encoder, &xlnx_dsi_encoder_funcs,
+                        DRM_MODE_ENCODER_DSI, NULL);
+       drm_encoder_helper_add(encoder, &xlnx_dsi_encoder_helper_funcs);
+
+       encoder->possible_crtcs =3D 1;
+
+       ret =3D xlnx_dsi_create_connector(encoder);
+       if (ret) {
+               dev_err(dsi->dev, "fail creating connector, ret =3D %d\n", =
ret);
+               drm_encoder_cleanup(encoder);
+               return ret;
+       }
+
+       ret =3D mipi_dsi_host_register(&dsi->dsi_host);
+       if (ret < 0) {
+               dev_err(dsi->dev, "failed to register DSI host: %d\n", ret)=
;
+               xlnx_dsi_connector_destroy(&dsi->connector);
+               drm_encoder_cleanup(encoder);
+               return ret;
+       }
+
+       return 0;
+}
+
+static void xlnx_dsi_unbind(struct device *dev, struct device *master,
+                           void *data)
+{
+       struct xlnx_dsi *dsi =3D dev_get_drvdata(dev);
+
+       xlnx_dsi_disable(&dsi->encoder);
+       mipi_dsi_host_unregister(&dsi->dsi_host);
+}
+
+static const struct component_ops xlnx_dsi_component_ops =3D {
+       .bind   =3D xlnx_dsi_bind,
+       .unbind =3D xlnx_dsi_unbind,
+};
+
+static int xlnx_dsi_probe(struct platform_device *pdev)
+{
+       struct device *dev =3D &pdev->dev;
+       struct resource *res;
+       struct xlnx_dsi *dsi;
+       int ret;
+       unsigned long rate;
+
+       dsi =3D devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
+       if (!dsi)
+               return -ENOMEM;
+
+       dsi->dsi_host.ops =3D &xlnx_dsi_ops;
+       dsi->dsi_host.dev =3D dev;
+       dsi->dev =3D dev;
+
+       ret =3D xlnx_dsi_parse_dt(dsi);
+       if (ret)
+               return ret;
+
+       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       dsi->iomem =3D devm_ioremap_resource(dev, res);
+       if (IS_ERR(dsi->iomem)) {
+               dev_err(dev, "failed to remap io region\n");
+               return PTR_ERR(dsi->iomem);
+       }
+       platform_set_drvdata(pdev, dsi);
+
+       ret =3D clk_set_rate(dsi->dphy_clk_200M, XDSI_DPHY_CLK_REQ);
+       if (ret) {
+               dev_err(dev, "failed to set dphy clk rate %d\n", ret);
+               return ret;
+       }
+
+       ret =3D clk_prepare_enable(dsi->dphy_clk_200M);
+       if (ret) {
+               dev_err(dev, "failed to enable dphy clk %d\n", ret);
+               return ret;
+       }
+
+       rate =3D clk_get_rate(dsi->dphy_clk_200M);
+       if (rate < XDSI_DPHY_CLK_MIN && rate > XDSI_DPHY_CLK_MAX) {
+               dev_err(dev, "Error DPHY clock =3D %lu\n", rate);
+               ret =3D -EINVAL;
+               goto err_disable_dphy_clk;
+       }
+
+       ret =3D clk_prepare_enable(dsi->video_aclk);
+       if (ret) {
+               dev_err(dev, "failed to enable video clk %d\n", ret);
+               goto err_disable_dphy_clk;
+       }
+
+       ret =3D component_add(dev, &xlnx_dsi_component_ops);
+       if (ret < 0)
+               goto err_disable_video_clk;
+
+       return ret;
+
+err_disable_video_clk:
+       clk_disable_unprepare(dsi->video_aclk);
+err_disable_dphy_clk:
+       clk_disable_unprepare(dsi->dphy_clk_200M);
+       return ret;
+}
+
+static int xlnx_dsi_remove(struct platform_device *pdev)
+{
+       struct xlnx_dsi *dsi =3D platform_get_drvdata(pdev);
+
+       component_del(&pdev->dev, &xlnx_dsi_component_ops);
+       clk_disable_unprepare(dsi->video_aclk);
+       clk_disable_unprepare(dsi->dphy_clk_200M);
+
+       return 0;
+}
+
+static const struct of_device_id xlnx_dsi_of_match[] =3D {
+       { .compatible =3D "xlnx-dsi", },
+       { /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, xlnx_dsi_of_match);
+
+static struct platform_driver dsi_driver =3D {
+       .probe =3D xlnx_dsi_probe,
+       .remove =3D xlnx_dsi_remove,
+       .driver =3D {
+               .name =3D "xlnx-dsi",
+               .of_match_table =3D xlnx_dsi_of_match,
+       },
+};
+
+module_platform_driver(dsi_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_DESCRIPTION("Xilinx FPGA MIPI DSI Tx Driver");
+MODULE_LICENSE("GPL v2");
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
