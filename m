Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5032C76CC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 01:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgK2AIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 19:08:05 -0500
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:36192
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgK2AIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 19:08:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka0Zpx8XwwuZaYTAyy+FRJGlp/QTfm3CwHuts985Jmlum0+knZuurrKSE3CBlrpUDnUzM6Pj68AjBBFl1PMdMXDFubjgdNRanCTva0d4COXhWaPe+JWb+sAGXI2wGENBkR+uJ8H2XqxtL4KPNikB235wwbgvNg1vU+Zht8ViwY8tgYYeuRiWkvaW8xeIDkfTr+Ks6c8XtTwY/5uuo7afh5zwkBUZxmTbLJ0yqnhZL+bjopSJbuo1Rfp820c5gPDX1DcTBd1oOQOOU8kJqBad28SAw6aXs354uYnAwMftzAVmt/jwlHE6fMySzBlbeGFUpky6oP6Y9tw+kHKwJix18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5snZh71Ps51lNnU+NPJIGeIeg8jpuO14x6hDMLm7iQU=;
 b=MZDMyaT9gzOGd5uGx79HDipg+fx8jFJwTonNX17pbdikNTSTTxDq4XCQLYMaSA3Zim9YDI5QWSO2/24+Grkhq8MVke6HfgfPMUSOlWuismxbpDihcO73KGN3hY/dsh1CqijncsXZJl+3sWjlxBJejwKKunZ27kErhLD3+3WHDYhuRtdwZD3cd+Z09mctsqBfmRh1PmBfr7+G5Y4bbNYn33bKkMBvSEIxPEQmhrFV0FcqG5yioE1og7DUAmWzIQkgfWalkl2KfYpHVBY1A8TeFM2DxUrBDcOdM3t1BlKjUOJWqsDA3xEjNAnvGVG6z1mDiQcc4O7+QVgaKLxNtOrKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5snZh71Ps51lNnU+NPJIGeIeg8jpuO14x6hDMLm7iQU=;
 b=A1zsHVXaSpbsd3OXPWa1MVuWJi+YiWDgRPRoCn5XtBpJO+l5jKTrPgpRikHN2GspE+2Frk9T712M1SG2kvu4juI6uCvM4ygED/n5vfK0hQOo7rFHDd0Zdausc2y3Kefyx0LK91BEsS49DQiX/PEnqggBLB15HV4IEYGUhu0dabk=
Received: from BL0PR0102CA0020.prod.exchangelabs.com (2603:10b6:207:18::33) by
 BL0PR02MB4530.namprd02.prod.outlook.com (2603:10b6:208:42::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Sun, 29 Nov 2020 00:03:06 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::d0) by BL0PR0102CA0020.outlook.office365.com
 (2603:10b6:207:18::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Sun, 29 Nov 2020 00:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sun, 29 Nov 2020 00:03:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 16:02:39 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 16:02:39 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45056 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjAAp-0004aX-02; Sat, 28 Nov 2020 16:02:39 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 3BF4C600119; Sat, 28 Nov 2020 16:00:45 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo 5/8] fpga: xrt: platform drivers for subsystems in shell partition
Date:   Sat, 28 Nov 2020 16:00:37 -0800
Message-ID: <20201129000040.24777-6-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f89a415e-609b-470a-ec9a-08d893fa25dc
X-MS-TrafficTypeDiagnostic: BL0PR02MB4530:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4530A8D93506EA88E494228FBBF60@BL0PR02MB4530.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syebjrs3ym6aZviouWooNGEEaMgKhC0zXB8r9Q/SyS0hIGPHAG62Oh5HsGOIvhYoI13XCDnll9wl70P1TwwTHxYIS4SbsflDfrUfdvgVE6g5GfAmC6Lby+8IYvmBhPT1t8rnUHfmAiIA4TCfJk3TdCIkhmlT/JsuGoYshLq32fQFjvUXKCzph2IYP9ac2/5Z9WoXupGDAVQ14tXzPqJOo6VQetmuZ6QOFlS0n8Stvn7mY9zSrnp4Z+N2xO3ebxWcATA1DoebOSbS0Kr9ictQ8ZccA5Zxc9QdkOdchKkWooy8H3VXOWGx4iGVPJgOm6IFqiYFUKoNlZHyb/0E954ponLFZMbM8PMvox6VtuigvyFcMMrrg9ggthfFEslnOBm1OERS2/Lakt9TmNs2uP5uJzs9SlNgY9jaqGHslSb+/U1rt+Vuo7qzDMxIIp404s2IV+ZwIya3zyRRomtXzsrOkTQtY2/pKdj6ETJgVxDm/PxA0Icl5Thaxn2dVP4e9rUI
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(46966005)(42186006)(316002)(26005)(6916009)(426003)(336012)(478600001)(36906005)(2616005)(44832011)(8936002)(54906003)(4326008)(8676002)(450100002)(186003)(70206006)(6266002)(82310400003)(2906002)(82740400003)(6666004)(47076004)(5660300002)(7636003)(36756003)(356005)(70586007)(30864003)(1076003)(83380400001)(579004)(559001)(569008);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 00:03:05.7838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89a415e-609b-470a-ec9a-08d893fa25dc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Add platform drivers for HW subsystems found in shell partition.
Each driver implements interfaces defined by xrt-subdev.h. The
driver instances are created by parent partition to manage
subsystem instances discovered by walking device tree. The
platform drivers may populate their own sysfs nodes, create
device nodes if needed and make calls into parent or other
platform drivers. The platform drivers can also send and receive
events.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/alveo/lib/subdevs/xrt-axigate.c  |  298 +++
 drivers/fpga/alveo/lib/subdevs/xrt-calib.c    |  291 +++
 drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c  |  214 ++
 drivers/fpga/alveo/lib/subdevs/xrt-clock.c    |  638 ++++++
 .../fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c   |  343 +++
 drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c |  322 +++
 drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h |  135 ++
 .../fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c  |  320 +++
 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c   |  361 ++++
 .../fpga/alveo/lib/subdevs/xrt-cmc-sensors.c  |  445 ++++
 drivers/fpga/alveo/lib/subdevs/xrt-cmc.c      |  239 +++
 drivers/fpga/alveo/lib/subdevs/xrt-gpio.c     |  198 ++
 drivers/fpga/alveo/lib/subdevs/xrt-icap.c     |  306 +++
 drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c  | 1905 +++++++++++++++++
 .../fpga/alveo/lib/subdevs/xrt-partition.c    |  261 +++
 drivers/fpga/alveo/lib/subdevs/xrt-qspi.c     | 1347 ++++++++++++
 drivers/fpga/alveo/lib/subdevs/xrt-srsr.c     |  322 +++
 drivers/fpga/alveo/lib/subdevs/xrt-test.c     |  274 +++
 drivers/fpga/alveo/lib/subdevs/xrt-ucs.c      |  238 ++
 .../fpga/alveo/lib/subdevs/xrt-vsec-golden.c  |  238 ++
 drivers/fpga/alveo/lib/subdevs/xrt-vsec.c     |  337 +++
 21 files changed, 9032 insertions(+)
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-axigate.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-calib.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-clock.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sensors.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-gpio.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-icap.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-partition.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-qspi.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-srsr.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-test.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-ucs.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-vsec-golden.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-vsec.c

diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-axigate.c b/drivers/fpga/alveo/lib/subdevs/xrt-axigate.c
new file mode 100644
index 000000000000..4b4877a89405
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-axigate.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA AXI Gate Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-axigate.h"
+
+#define XRT_AXIGATE "xrt_axigate"
+
+struct axigate_regs {
+	u32		iag_wr;
+	u32		iag_rvsd;
+	u32		iag_rd;
+} __packed;
+
+struct xrt_axigate {
+	struct platform_device	*pdev;
+	void			*base;
+	struct mutex		gate_lock;
+
+	void			*evt_hdl;
+	const char		*ep_name;
+
+	bool			gate_freezed;
+};
+
+#define reg_rd(g, r)						\
+	ioread32(&((struct axigate_regs *)g->base)->r)
+#define reg_wr(g, v, r)						\
+	iowrite32(v, &((struct axigate_regs *)g->base)->r)
+
+#define freeze_gate(gate)			\
+	do {					\
+		reg_wr(gate, 0, iag_wr);	\
+		ndelay(500);			\
+		reg_rd(gate, iag_rd);		\
+	} while (0)
+
+#define free_gate(gate)				\
+	do {					\
+		reg_wr(gate, 0x2, iag_wr);	\
+		ndelay(500);			\
+		(void) reg_rd(gate, iag_rd);	\
+		reg_wr(gate, 0x3, iag_wr);	\
+		ndelay(500);			\
+		reg_rd(gate, iag_rd);		\
+	} while (0)				\
+
+static int xrt_axigate_epname_idx(struct platform_device *pdev)
+{
+	int			i;
+	int			ret;
+	struct resource		*res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty Resource!");
+		return -EINVAL;
+	}
+
+	for (i = 0; xrt_axigate_epnames[i]; i++) {
+		ret = strncmp(xrt_axigate_epnames[i], res->name,
+			strlen(xrt_axigate_epnames[i]) + 1);
+		if (!ret)
+			break;
+	}
+
+	return (xrt_axigate_epnames[i]) ? i : -EINVAL;
+}
+
+static bool xrt_axigate_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	const char		*ep_name = arg;
+	struct resource		*res;
+
+	if (id != XRT_SUBDEV_AXIGATE)
+		return false;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty Resource!");
+		return false;
+	}
+
+	if (strncmp(res->name, ep_name, strlen(res->name) + 1))
+		return true;
+
+	return false;
+}
+
+static void xrt_axigate_freeze(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	u32			freeze = 0;
+
+	gate = platform_get_drvdata(pdev);
+
+	mutex_lock(&gate->gate_lock);
+	freeze = reg_rd(gate, iag_rd);
+	if (freeze) {		/* gate is opened */
+		xrt_subdev_broadcast_event(pdev, XRT_EVENT_PRE_GATE_CLOSE);
+		freeze_gate(gate);
+	}
+
+	gate->gate_freezed = true;
+	mutex_unlock(&gate->gate_lock);
+
+	xrt_info(pdev, "freeze gate %s", gate->ep_name);
+}
+
+static void xrt_axigate_free(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	u32			freeze;
+
+	gate = platform_get_drvdata(pdev);
+
+	mutex_lock(&gate->gate_lock);
+	freeze = reg_rd(gate, iag_rd);
+	if (!freeze) {		/* gate is closed */
+		free_gate(gate);
+		xrt_subdev_broadcast_event_async(pdev,
+			XRT_EVENT_POST_GATE_OPEN, NULL, NULL);
+		/* xrt_axigate_free() could be called in event cb, thus
+		 * we can not wait for the completes
+		 */
+	}
+
+	gate->gate_freezed = false;
+	mutex_unlock(&gate->gate_lock);
+
+	xrt_info(pdev, "free gate %s", gate->ep_name);
+}
+
+static int
+xrt_axigate_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+	struct platform_device *leaf;
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+	enum xrt_subdev_id id;
+	int instance;
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION:
+		break;
+	default:
+		return XRT_EVENT_CB_CONTINUE;
+	}
+
+	id = esd->xevt_subdev_id;
+	instance = esd->xevt_subdev_instance;
+
+	/*
+	 * higher level axigate instance created,
+	 * make sure the gate is openned. This covers 1RP flow which
+	 * has plp gate as well.
+	 */
+	leaf = xrt_subdev_get_leaf_by_id(pdev, id, instance);
+	if (leaf) {
+		if (xrt_axigate_epname_idx(leaf) >
+		    xrt_axigate_epname_idx(pdev))
+			xrt_axigate_free(pdev);
+		else
+			xrt_subdev_ioctl(leaf, XRT_AXIGATE_FREE, NULL);
+		xrt_subdev_put_leaf(pdev, leaf);
+	}
+
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+static int
+xrt_axigate_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	switch (cmd) {
+	case XRT_AXIGATE_FREEZE:
+		xrt_axigate_freeze(pdev);
+		break;
+	case XRT_AXIGATE_FREE:
+		xrt_axigate_free(pdev);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int xrt_axigate_remove(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+
+	gate = platform_get_drvdata(pdev);
+
+	if (gate->base)
+		iounmap(gate->base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, gate);
+
+	return 0;
+}
+
+static int xrt_axigate_probe(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	struct resource		*res;
+	int			ret;
+
+	gate = devm_kzalloc(&pdev->dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return -ENOMEM;
+
+	gate->pdev = pdev;
+	platform_set_drvdata(pdev, gate);
+
+	xrt_info(pdev, "probing...");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty resource 0");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	gate->base = ioremap(res->start, res->end - res->start + 1);
+	if (!gate->base) {
+		xrt_err(pdev, "map base iomem failed");
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	gate->evt_hdl = xrt_subdev_add_event_cb(pdev,
+		xrt_axigate_leaf_match, (void *)res->name,
+		xrt_axigate_event_cb);
+
+	gate->ep_name = res->name;
+
+	mutex_init(&gate->gate_lock);
+
+	return 0;
+
+failed:
+	xrt_axigate_remove(pdev);
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_axigate_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = "ep_pr_isolate_ulp_00" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = "ep_pr_isolate_plp_00" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_axigate_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_axigate_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_axigate_table[] = {
+	{ XRT_AXIGATE, (kernel_ulong_t)&xrt_axigate_data },
+	{ },
+};
+
+struct platform_driver xrt_axigate_driver = {
+	.driver = {
+		.name = XRT_AXIGATE,
+	},
+	.probe = xrt_axigate_probe,
+	.remove = xrt_axigate_remove,
+	.id_table = xrt_axigate_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-calib.c b/drivers/fpga/alveo/lib/subdevs/xrt-calib.c
new file mode 100644
index 000000000000..55d18b7c4b0f
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-calib.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA memory calibration driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * memory calibration
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+#include <linux/delay.h>
+#include "xrt-xclbin.h"
+#include "xrt-metadata.h"
+#include "xrt-ddr-srsr.h"
+#include "xrt-calib.h"
+
+#define XRT_CALIB	"xrt_calib"
+
+struct calib_cache {
+	struct list_head	link;
+	const char		*ep_name;
+	char			*data;
+	uint32_t		data_size;
+};
+
+struct calib {
+	struct platform_device	*pdev;
+	void			*calib_base;
+	struct mutex		lock;
+	struct list_head	cache_list;
+	uint32_t		cache_num;
+	void			*evt_hdl;
+	enum xrt_calib_results	result;
+};
+
+#define CALIB_DONE(calib)			\
+	(ioread32(calib->calib_base) & BIT(0))
+
+static bool xrt_calib_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	if (id == XRT_SUBDEV_UCS || id == XRT_SUBDEV_SRSR)
+		return true;
+
+	return false;
+}
+
+static void calib_cache_clean_nolock(struct calib *calib)
+{
+	struct calib_cache *cache, *temp;
+
+	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
+		vfree(cache->data);
+		list_del(&cache->link);
+		vfree(cache);
+	}
+	calib->cache_num = 0;
+	mutex_unlock(&calib->lock);
+}
+
+static void calib_cache_clean(struct calib *calib)
+{
+	mutex_lock(&calib->lock);
+	calib_cache_clean_nolock(calib);
+	mutex_unlock(&calib->lock);
+}
+
+static int calib_srsr(struct calib *calib, struct platform_device *srsr_leaf)
+{
+	const char		*ep_name;
+	int			ret;
+	struct calib_cache	*cache = NULL, *temp;
+	struct xrt_srsr_ioctl_calib req = { 0 };
+
+	ret = xrt_subdev_ioctl(srsr_leaf, XRT_SRSR_EP_NAME,
+		(void *)&ep_name);
+	if (ret) {
+		xrt_err(calib->pdev, "failed to get SRSR name %d", ret);
+		goto done;
+	}
+	xrt_info(calib->pdev, "Calibrate SRSR %s", ep_name);
+
+	mutex_lock(&calib->lock);
+	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
+		if (!strncmp(ep_name, cache->ep_name, strlen(ep_name) + 1)) {
+			req.xsic_buf = cache->data;
+			req.xsic_size = cache->data_size;
+			ret = xrt_subdev_ioctl(srsr_leaf,
+				XRT_SRSR_FAST_CALIB, &req);
+			if (ret) {
+				xrt_err(calib->pdev, "Fast calib failed %d",
+					ret);
+				break;
+			}
+			goto done;
+		}
+	}
+
+	if (ret) {
+		/* fall back to full calibration */
+		xrt_info(calib->pdev, "fall back to full calibration");
+		vfree(cache->data);
+		memset(cache, 0, sizeof(*cache));
+	} else {
+		/* First full calibration */
+		cache = vzalloc(sizeof(*cache));
+		if (!cache) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		list_add(&cache->link, &calib->cache_list);
+		calib->cache_num++;
+	}
+
+	req.xsic_buf = &cache->data;
+	ret = xrt_subdev_ioctl(srsr_leaf, XRT_SRSR_CALIB, &req);
+	if (ret) {
+		xrt_err(calib->pdev, "Full calib failed %d", ret);
+		list_del(&cache->link);
+		calib->cache_num--;
+		goto done;
+	}
+	cache->data_size = req.xsic_size;
+
+
+done:
+	mutex_unlock(&calib->lock);
+
+	if (ret && cache) {
+		vfree(cache->data);
+		vfree(cache);
+	}
+	return ret;
+}
+
+static int calib_calibration(struct calib *calib)
+{
+	int i;
+
+	for (i = 0; i < 20; i++) {
+		if (CALIB_DONE(calib))
+			break;
+		msleep(500);
+	}
+
+	if (i == 20) {
+		xrt_err(calib->pdev,
+			"MIG calibration timeout after bitstream download");
+		return -ETIMEDOUT;
+	}
+
+	xrt_info(calib->pdev, "took %dms", i * 500);
+	return 0;
+}
+
+static int xrt_calib_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+	struct platform_device *leaf;
+	int ret;
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION: {
+		if (esd->xevt_subdev_id == XRT_SUBDEV_SRSR) {
+			leaf = xrt_subdev_get_leaf_by_id(pdev,
+				XRT_SUBDEV_SRSR, esd->xevt_subdev_instance);
+			BUG_ON(!leaf);
+			ret = calib_srsr(calib, leaf);
+			xrt_subdev_put_leaf(pdev, leaf);
+			calib->result =
+				ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
+		} else if (esd->xevt_subdev_id == XRT_SUBDEV_UCS) {
+			ret = calib_calibration(calib);
+			calib->result =
+				ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
+		}
+		break;
+	}
+	default:
+		xrt_info(pdev, "ignored event %d", evt);
+		break;
+	}
+
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+int xrt_calib_remove(struct platform_device *pdev)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+
+	xrt_subdev_remove_event_cb(pdev, calib->evt_hdl);
+	calib_cache_clean(calib);
+
+	if (calib->calib_base)
+		iounmap(calib->calib_base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, calib);
+
+	return 0;
+}
+
+int xrt_calib_probe(struct platform_device *pdev)
+{
+	struct calib *calib;
+	struct resource *res;
+	int err = 0;
+
+	calib = devm_kzalloc(&pdev->dev, sizeof(*calib), GFP_KERNEL);
+	if (!calib)
+		return -ENOMEM;
+
+	calib->pdev = pdev;
+	platform_set_drvdata(pdev, calib);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		goto failed;
+
+	calib->calib_base = ioremap(res->start, res->end - res->start + 1);
+	if (!calib->calib_base) {
+		err = -EIO;
+		xrt_err(pdev, "Map iomem failed");
+		goto failed;
+	}
+
+	calib->evt_hdl = xrt_subdev_add_event_cb(pdev, xrt_calib_leaf_match,
+		NULL, xrt_calib_event_cb);
+
+	mutex_init(&calib->lock);
+	INIT_LIST_HEAD(&calib->cache_list);
+
+	return 0;
+
+failed:
+	xrt_calib_remove(pdev);
+	return err;
+}
+
+static int
+xrt_calib_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_CALIB_RESULT: {
+		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
+		*r = calib->result;
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_calib_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = NODE_DDR_CALIB },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_calib_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_calib_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_calib_table[] = {
+	{ XRT_CALIB, (kernel_ulong_t)&xrt_calib_data },
+	{ },
+};
+
+struct platform_driver xrt_calib_driver = {
+	.driver = {
+		.name = XRT_CALIB,
+	},
+	.probe = xrt_calib_probe,
+	.remove = xrt_calib_remove,
+	.id_table = xrt_calib_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c b/drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c
new file mode 100644
index 000000000000..41702f7216f3
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Clock Frequency Counter Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-clkfreq.h"
+
+#define CLKFREQ_ERR(clkfreq, fmt, arg...)   \
+	xrt_err((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_WARN(clkfreq, fmt, arg...)  \
+	xrt_warn((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_INFO(clkfreq, fmt, arg...)  \
+	xrt_info((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_DBG(clkfreq, fmt, arg...)   \
+	xrt_dbg((clkfreq)->pdev, fmt "\n", ##arg)
+
+#define XRT_CLKFREQ		"xrt_clkfreq"
+
+#define OCL_CLKWIZ_STATUS_MASK		0xffff
+
+#define OCL_CLKWIZ_STATUS_MEASURE_START	0x1
+#define OCL_CLKWIZ_STATUS_MEASURE_DONE	0x2
+#define OCL_CLK_FREQ_COUNTER_OFFSET	0x8
+#define OCL_CLK_FREQ_V5_COUNTER_OFFSET	0x10
+#define OCL_CLK_FREQ_V5_CLK0_ENABLED	0x10000
+
+struct clkfreq {
+	struct platform_device	*pdev;
+	void __iomem		*clkfreq_base;
+	const char		*clkfreq_ep_name;
+	struct mutex		clkfreq_lock;
+};
+
+static inline u32 reg_rd(struct clkfreq *clkfreq, u32 offset)
+{
+	return ioread32(clkfreq->clkfreq_base + offset);
+}
+
+static inline void reg_wr(struct clkfreq *clkfreq, u32 val, u32 offset)
+{
+	iowrite32(val, clkfreq->clkfreq_base + offset);
+}
+
+
+static u32 clkfreq_read(struct clkfreq *clkfreq)
+{
+	u32 freq = 0, status;
+	int times = 10;
+
+	mutex_lock(&clkfreq->clkfreq_lock);
+	reg_wr(clkfreq, OCL_CLKWIZ_STATUS_MEASURE_START, 0);
+	while (times != 0) {
+		status = reg_rd(clkfreq, 0);
+		if ((status & OCL_CLKWIZ_STATUS_MASK) ==
+		    OCL_CLKWIZ_STATUS_MEASURE_DONE)
+			break;
+		mdelay(1);
+		times--;
+	};
+	if (times > 0) {
+		freq = (status & OCL_CLK_FREQ_V5_CLK0_ENABLED) ?
+			reg_rd(clkfreq, OCL_CLK_FREQ_V5_COUNTER_OFFSET) :
+			reg_rd(clkfreq, OCL_CLK_FREQ_COUNTER_OFFSET);
+	}
+	mutex_unlock(&clkfreq->clkfreq_lock);
+
+	return freq;
+}
+
+static ssize_t freq_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct clkfreq *clkfreq = platform_get_drvdata(to_platform_device(dev));
+	u32 freq;
+	ssize_t count;
+
+	freq = clkfreq_read(clkfreq);
+	count = snprintf(buf, 64, "%d\n", freq);
+
+	return count;
+}
+static DEVICE_ATTR_RO(freq);
+
+static struct attribute *clkfreq_attrs[] = {
+	&dev_attr_freq.attr,
+	NULL,
+};
+
+static struct attribute_group clkfreq_attr_group = {
+	.attrs = clkfreq_attrs,
+};
+
+static int
+xrt_clkfreq_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct clkfreq		*clkfreq;
+	int			ret = 0;
+
+	clkfreq = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_CLKFREQ_READ: {
+		*(u32 *)arg = clkfreq_read(clkfreq);
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int clkfreq_remove(struct platform_device *pdev)
+{
+	struct clkfreq *clkfreq;
+
+	clkfreq = platform_get_drvdata(pdev);
+	if (!clkfreq) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, clkfreq);
+
+	CLKFREQ_INFO(clkfreq, "successfully removed clkfreq subdev");
+	return 0;
+}
+
+
+
+static int clkfreq_probe(struct platform_device *pdev)
+{
+	struct clkfreq *clkfreq = NULL;
+	struct resource *res;
+	int ret;
+
+	clkfreq = devm_kzalloc(&pdev->dev, sizeof(*clkfreq), GFP_KERNEL);
+	if (!clkfreq)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, clkfreq);
+	clkfreq->pdev = pdev;
+	mutex_init(&clkfreq->clkfreq_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	clkfreq->clkfreq_base = ioremap(res->start, res->end - res->start + 1);
+	if (!clkfreq->clkfreq_base) {
+		CLKFREQ_ERR(clkfreq, "map base %pR failed", res);
+		ret = -EFAULT;
+		goto failed;
+	}
+	clkfreq->clkfreq_ep_name = res->name;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &clkfreq_attr_group);
+	if (ret) {
+		CLKFREQ_ERR(clkfreq, "create clkfreq attrs failed: %d", ret);
+		goto failed;
+	}
+
+	CLKFREQ_INFO(clkfreq, "successfully initialized clkfreq subdev");
+
+	return 0;
+
+failed:
+	clkfreq_remove(pdev);
+	return ret;
+}
+
+
+struct xrt_subdev_endpoints xrt_clkfreq_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .regmap_name = "freq_cnt" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_clkfreq_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_clkfreq_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_clkfreq_table[] = {
+	{ XRT_CLKFREQ, (kernel_ulong_t)&xrt_clkfreq_data },
+	{ },
+};
+
+struct platform_driver xrt_clkfreq_driver = {
+	.driver = {
+		.name = XRT_CLKFREQ,
+	},
+	.probe = clkfreq_probe,
+	.remove = clkfreq_remove,
+	.id_table = xrt_clkfreq_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-clock.c b/drivers/fpga/alveo/lib/subdevs/xrt-clock.c
new file mode 100644
index 000000000000..64ee67d31191
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-clock.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Clock Wizard Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-clock.h"
+#include "xrt-clkfreq.h"
+
+/* CLOCK_MAX_NUM_CLOCKS should be a concept from XCLBIN_ in the future */
+#define	CLOCK_MAX_NUM_CLOCKS		4
+#define	OCL_CLKWIZ_STATUS_OFFSET	0x4
+#define	OCL_CLKWIZ_STATUS_MASK		0xffff
+#define	OCL_CLKWIZ_STATUS_MEASURE_START	0x1
+#define	OCL_CLKWIZ_STATUS_MEASURE_DONE	0x2
+#define	OCL_CLKWIZ_CONFIG_OFFSET(n)	(0x200 + 4 * (n))
+#define	CLOCK_DEFAULT_EXPIRE_SECS	1
+
+#define	CLOCK_ERR(clock, fmt, arg...)	\
+	xrt_err((clock)->pdev, fmt "\n", ##arg)
+#define	CLOCK_WARN(clock, fmt, arg...)	\
+	xrt_warn((clock)->pdev, fmt "\n", ##arg)
+#define	CLOCK_INFO(clock, fmt, arg...)	\
+	xrt_info((clock)->pdev, fmt "\n", ##arg)
+#define	CLOCK_DBG(clock, fmt, arg...)	\
+	xrt_dbg((clock)->pdev, fmt "\n", ##arg)
+
+#define XRT_CLOCK	"xrt_clock"
+
+struct clock {
+	struct platform_device  *pdev;
+	void __iomem		*clock_base;
+	struct mutex		clock_lock;
+
+	const char		*clock_ep_name;
+};
+
+/*
+ * Precomputed table with config0 and config2 register values together with
+ * target frequency. The steps are approximately 5 MHz apart. Table is
+ * generated by wiz.pl.
+ */
+const static struct xmgmt_ocl_clockwiz {
+	/* target frequency */
+	unsigned short ocl;
+	/* config0 register */
+	unsigned long config0;
+	/* config2 register */
+	unsigned int config2;
+} frequency_table[] = {
+	{/*1275.000*/	10.000,		0x02EE0C01,	0x0001F47F},
+	{/*1575.000*/   15.000,		0x02EE0F01,     0x00000069},
+	{/*1600.000*/   20.000,		0x00001001,     0x00000050},
+	{/*1600.000*/   25.000,		0x00001001,     0x00000040},
+	{/*1575.000*/   30.000,		0x02EE0F01,     0x0001F434},
+	{/*1575.000*/   35.000,		0x02EE0F01,     0x0000002D},
+	{/*1600.000*/   40.000,		0x00001001,     0x00000028},
+	{/*1575.000*/   45.000,		0x02EE0F01,     0x00000023},
+	{/*1600.000*/   50.000,		0x00001001,     0x00000020},
+	{/*1512.500*/   55.000,		0x007D0F01,     0x0001F41B},
+	{/*1575.000*/   60.000,		0x02EE0F01,     0x0000FA1A},
+	{/*1462.500*/   65.000,		0x02710E01,     0x0001F416},
+	{/*1575.000*/   70.000,		0x02EE0F01,     0x0001F416},
+	{/*1575.000*/   75.000,		0x02EE0F01,     0x00000015},
+	{/*1600.000*/   80.000,		0x00001001,     0x00000014},
+	{/*1487.500*/   85.000,		0x036B0E01,     0x0001F411},
+	{/*1575.000*/   90.000,		0x02EE0F01,     0x0001F411},
+	{/*1425.000*/   95.000,		0x00FA0E01,     0x0000000F},
+	{/*1600.000*/   100.000,	0x00001001,     0x00000010},
+	{/*1575.000*/   105.000,	0x02EE0F01,     0x0000000F},
+	{/*1512.500*/   110.000,	0x007D0F01,     0x0002EE0D},
+	{/*1437.500*/   115.000,	0x01770E01,     0x0001F40C},
+	{/*1575.000*/   120.000,	0x02EE0F01,     0x00007D0D},
+	{/*1562.500*/   125.000,	0x02710F01,     0x0001F40C},
+	{/*1462.500*/   130.000,	0x02710E01,     0x0000FA0B},
+	{/*1350.000*/   135.000,	0x01F40D01,     0x0000000A},
+	{/*1575.000*/   140.000,	0x02EE0F01,     0x0000FA0B},
+	{/*1450.000*/   145.000,	0x01F40E01,     0x0000000A},
+	{/*1575.000*/   150.000,	0x02EE0F01,     0x0001F40A},
+	{/*1550.000*/   155.000,	0x01F40F01,     0x0000000A},
+	{/*1600.000*/   160.000,	0x00001001,     0x0000000A},
+	{/*1237.500*/   165.000,	0x01770C01,     0x0001F407},
+	{/*1487.500*/   170.000,	0x036B0E01,     0x0002EE08},
+	{/*1575.000*/   175.000,	0x02EE0F01,     0x00000009},
+	{/*1575.000*/   180.000,	0x02EE0F01,     0x0002EE08},
+	{/*1387.500*/   185.000,	0x036B0D01,     0x0001F407},
+	{/*1425.000*/   190.000,	0x00FA0E01,     0x0001F407},
+	{/*1462.500*/   195.000,	0x02710E01,     0x0001F407},
+	{/*1600.000*/   200.000,	0x00001001,     0x00000008},
+	{/*1537.500*/   205.000,        0x01770F01,     0x0001F407},
+	{/*1575.000*/   210.000,        0x02EE0F01,     0x0001F407},
+	{/*1075.000*/   215.000,        0x02EE0A01,     0x00000005},
+	{/*1512.500*/   220.000,        0x007D0F01,     0x00036B06},
+	{/*1575.000*/   225.000,        0x02EE0F01,     0x00000007},
+	{/*1437.500*/   230.000,        0x01770E01,     0x0000FA06},
+	{/*1175.000*/   235.000,        0x02EE0B01,     0x00000005},
+	{/*1500.000*/   240.000,        0x00000F01,     0x0000FA06},
+	{/*1225.000*/   245.000,        0x00FA0C01,     0x00000005},
+	{/*1562.500*/   250.000,        0x02710F01,     0x0000FA06},
+	{/*1275.000*/   255.000,        0x02EE0C01,     0x00000005},
+	{/*1462.500*/   260.000,        0x02710E01,     0x00027105},
+	{/*1325.000*/   265.000,        0x00FA0D01,     0x00000005},
+	{/*1350.000*/   270.000,        0x01F40D01,     0x00000005},
+	{/*1512.500*/   275.000,        0x007D0F01,     0x0001F405},
+	{/*1575.000*/   280.000,        0x02EE0F01,     0x00027105},
+	{/*1425.000*/   285.000,        0x00FA0E01,     0x00000005},
+	{/*1450.000*/   290.000,        0x01F40E01,     0x00000005},
+	{/*1475.000*/   295.000,        0x02EE0E01,     0x00000005},
+	{/*1575.000*/   300.000,        0x02EE0F01,     0x0000FA05},
+	{/*1525.000*/   305.000,        0x00FA0F01,     0x00000005},
+	{/*1550.000*/   310.000,        0x01F40F01,     0x00000005},
+	{/*1575.000*/   315.000,        0x02EE0F01,     0x00000005},
+	{/*1600.000*/   320.000,        0x00001001,     0x00000005},
+	{/*1462.500*/   325.000,        0x02710E01,     0x0001F404},
+	{/*1237.500*/   330.000,        0x01770C01,     0x0002EE03},
+	{/*837.500*/    335.000,        0x01770801,     0x0001F402},
+	{/*1487.500*/   340.000,        0x036B0E01,     0x00017704},
+	{/*862.500*/    345.000,        0x02710801,     0x0001F402},
+	{/*1575.000*/   350.000,        0x02EE0F01,     0x0001F404},
+	{/*887.500*/    355.000,        0x036B0801,     0x0001F402},
+	{/*1575.000*/   360.000,        0x02EE0F01,     0x00017704},
+	{/*912.500*/    365.000,        0x007D0901,     0x0001F402},
+	{/*1387.500*/   370.000,        0x036B0D01,     0x0002EE03},
+	{/*1500.000*/   375.000,        0x00000F01,     0x00000004},
+	{/*1425.000*/   380.000,        0x00FA0E01,     0x0002EE03},
+	{/*962.500*/    385.000,        0x02710901,     0x0001F402},
+	{/*1462.500*/   390.000,        0x02710E01,     0x0002EE03},
+	{/*987.500*/    395.000,        0x036B0901,     0x0001F402},
+	{/*1600.000*/   400.000,        0x00001001,     0x00000004},
+	{/*1012.500*/   405.000,        0x007D0A01,     0x0001F402},
+	{/*1537.500*/   410.000,        0x01770F01,     0x0002EE03},
+	{/*1037.500*/   415.000,        0x01770A01,     0x0001F402},
+	{/*1575.000*/   420.000,        0x02EE0F01,     0x0002EE03},
+	{/*1487.500*/   425.000,        0x036B0E01,     0x0001F403},
+	{/*1075.000*/   430.000,        0x02EE0A01,     0x0001F402},
+	{/*1087.500*/   435.000,        0x036B0A01,     0x0001F402},
+	{/*1375.000*/   440.000,        0x02EE0D01,     0x00007D03},
+	{/*1112.500*/   445.000,        0x007D0B01,     0x0001F402},
+	{/*1575.000*/   450.000,        0x02EE0F01,     0x0001F403},
+	{/*1137.500*/   455.000,        0x01770B01,     0x0001F402},
+	{/*1437.500*/   460.000,        0x01770E01,     0x00007D03},
+	{/*1162.500*/   465.000,        0x02710B01,     0x0001F402},
+	{/*1175.000*/   470.000,        0x02EE0B01,     0x0001F402},
+	{/*1425.000*/   475.000,        0x00FA0E01,     0x00000003},
+	{/*1500.000*/   480.000,        0x00000F01,     0x00007D03},
+	{/*1212.500*/   485.000,        0x007D0C01,     0x0001F402},
+	{/*1225.000*/   490.000,        0x00FA0C01,     0x0001F402},
+	{/*1237.500*/   495.000,        0x01770C01,     0x0001F402},
+	{/*1562.500*/   500.000,        0x02710F01,     0x00007D03},
+	{/*1262.500*/   505.000,        0x02710C01,     0x0001F402},
+	{/*1275.000*/   510.000,        0x02EE0C01,     0x0001F402},
+	{/*1287.500*/   515.000,        0x036B0C01,     0x0001F402},
+	{/*1300.000*/   520.000,        0x00000D01,     0x0001F402},
+	{/*1575.000*/   525.000,        0x02EE0F01,     0x00000003},
+	{/*1325.000*/   530.000,        0x00FA0D01,     0x0001F402},
+	{/*1337.500*/   535.000,        0x01770D01,     0x0001F402},
+	{/*1350.000*/   540.000,        0x01F40D01,     0x0001F402},
+	{/*1362.500*/   545.000,        0x02710D01,     0x0001F402},
+	{/*1512.500*/   550.000,        0x007D0F01,     0x0002EE02},
+	{/*1387.500*/   555.000,        0x036B0D01,     0x0001F402},
+	{/*1400.000*/   560.000,        0x00000E01,     0x0001F402},
+	{/*1412.500*/   565.000,        0x007D0E01,     0x0001F402},
+	{/*1425.000*/   570.000,        0x00FA0E01,     0x0001F402},
+	{/*1437.500*/   575.000,        0x01770E01,     0x0001F402},
+	{/*1450.000*/   580.000,        0x01F40E01,     0x0001F402},
+	{/*1462.500*/   585.000,        0x02710E01,     0x0001F402},
+	{/*1475.000*/   590.000,        0x02EE0E01,     0x0001F402},
+	{/*1487.500*/   595.000,        0x036B0E01,     0x0001F402},
+	{/*1575.000*/   600.000,        0x02EE0F01,     0x00027102},
+	{/*1512.500*/   605.000,        0x007D0F01,     0x0001F402},
+	{/*1525.000*/   610.000,        0x00FA0F01,     0x0001F402},
+	{/*1537.500*/   615.000,        0x01770F01,     0x0001F402},
+	{/*1550.000*/   620.000,        0x01F40F01,     0x0001F402},
+	{/*1562.500*/   625.000,        0x02710F01,     0x0001F402},
+	{/*1575.000*/   630.000,        0x02EE0F01,     0x0001F402},
+	{/*1587.500*/   635.000,        0x036B0F01,     0x0001F402},
+	{/*1600.000*/   640.000,        0x00001001,     0x0001F402},
+	{/*1290.000*/   645.000,        0x01F44005,     0x00000002},
+	{/*1462.500*/   650.000,        0x02710E01,     0x0000FA02}
+};
+
+static inline u32 reg_rd(struct clock *clock, u32 offset)
+{
+	return ioread32(clock->clock_base + offset);
+}
+
+static inline void reg_wr(struct clock *clock, u32 val, u32 offset)
+{
+	iowrite32(val, clock->clock_base + offset);
+}
+
+static u32 find_matching_freq_config(unsigned short freq,
+	const struct xmgmt_ocl_clockwiz *table, int size)
+{
+	u32 start = 0;
+	u32 end = size - 1;
+	u32 idx = size - 1;
+
+	if (freq < table[0].ocl)
+		return 0;
+
+	if (freq > table[size - 1].ocl)
+		return size - 1;
+
+	while (start < end) {
+		if (freq == table[idx].ocl)
+			break;
+		if (freq < table[idx].ocl)
+			end = idx;
+		else
+			start = idx + 1;
+		idx = start + (end - start) / 2;
+	}
+	if (freq < table[idx].ocl)
+		idx--;
+
+	return idx;
+}
+
+static u32 find_matching_freq(u32 freq,
+	const struct xmgmt_ocl_clockwiz *freq_table, int freq_table_size)
+{
+	int idx = find_matching_freq_config(freq, freq_table, freq_table_size);
+
+	return freq_table[idx].ocl;
+}
+
+static inline int clock_wiz_busy(struct clock *clock, int cycle,
+	int interval)
+{
+	u32 val = 0;
+	int count;
+
+	val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	for (count = 0; val != 1 && count < cycle; count++) {
+		mdelay(interval);
+		val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	}
+	if (val != 1) {
+		CLOCK_ERR(clock, "clockwiz is (%u) busy after %d ms",
+			val, cycle * interval);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int get_freq(struct clock *clock, u16 *freq)
+{
+#define XCL_INPUT_FREQ 100
+	const u64 input = XCL_INPUT_FREQ;
+	u32 val;
+	u32 mul0, div0;
+	u32 mul_frac0 = 0;
+	u32 div1;
+	u32 div_frac1 = 0;
+
+	BUG_ON(!mutex_is_locked(&clock->clock_lock));
+
+	val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	if ((val & 0x1) == 0) {
+		CLOCK_ERR(clock, "clockwiz is busy %x", val);
+		*freq = 0;
+		return -EBUSY;
+	}
+
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(0));
+
+	div0 = val & 0xff;
+	mul0 = (val & 0xff00) >> 8;
+	if (val & BIT(26)) {
+		mul_frac0 = val >> 16;
+		mul_frac0 &= 0x3ff;
+	}
+
+	/*
+	 * Multiply both numerator (mul0) and the denominator (div0) with 1000
+	 * to account for fractional portion of multiplier
+	 */
+	mul0 *= 1000;
+	mul0 += mul_frac0;
+	div0 *= 1000;
+
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(2));
+
+	div1 = val & 0xff;
+	if (val & BIT(18)) {
+		div_frac1 = val >> 8;
+		div_frac1 &= 0x3ff;
+	}
+
+	/*
+	 * Multiply both numerator (mul0) and the denominator (div1) with
+	 * 1000 to account for fractional portion of divider
+	 */
+
+	div1 *= 1000;
+	div1 += div_frac1;
+	div0 *= div1;
+	mul0 *= 1000;
+	if (div0 == 0) {
+		CLOCK_ERR(clock, "clockwiz 0 divider");
+		return 0;
+	}
+
+	*freq = (u16)((input * mul0) / div0);
+
+	return 0;
+}
+
+static int set_freq(struct clock *clock, u16 freq)
+{
+	u32 config;
+	int err;
+	u32 idx = 0;
+	u32 val;
+
+	BUG_ON(!mutex_is_locked(&clock->clock_lock));
+
+	idx = find_matching_freq_config(freq, frequency_table,
+		ARRAY_SIZE(frequency_table));
+
+	CLOCK_INFO(clock, "New: %d Mhz", freq);
+	err = clock_wiz_busy(clock, 20, 50);
+	if (err)
+		return -EBUSY;
+
+	config = frequency_table[idx].config0;
+	reg_wr(clock, config, OCL_CLKWIZ_CONFIG_OFFSET(0));
+
+	config = frequency_table[idx].config2;
+	reg_wr(clock, config, OCL_CLKWIZ_CONFIG_OFFSET(2));
+
+	mdelay(10);
+	reg_wr(clock, 7, OCL_CLKWIZ_CONFIG_OFFSET(23));
+
+	mdelay(1);
+	reg_wr(clock, 2, OCL_CLKWIZ_CONFIG_OFFSET(23));
+
+	CLOCK_INFO(clock, "clockwiz waiting for locked signal");
+
+	err = clock_wiz_busy(clock, 100, 100);
+	if (err) {
+		CLOCK_ERR(clock, "clockwiz MMCM/PLL did not lock");
+		/* restore */
+		reg_wr(clock, 4, OCL_CLKWIZ_CONFIG_OFFSET(23));
+		mdelay(10);
+		reg_wr(clock, 0, OCL_CLKWIZ_CONFIG_OFFSET(23));
+		return err;
+	}
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(0));
+	CLOCK_INFO(clock, "clockwiz CONFIG(0) 0x%x", val);
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(2));
+	CLOCK_INFO(clock, "clockwiz CONFIG(2) 0x%x", val);
+
+	return 0;
+}
+
+static int get_freq_counter(struct clock *clock, u32 *freq)
+{
+	const void *cnter;
+	struct platform_device *cnter_leaf;
+	struct platform_device *pdev = clock->pdev;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(clock->pdev);
+	int err = xrt_md_get_prop(DEV(pdev), pdata->xsp_dtb,
+		clock->clock_ep_name, NULL, PROP_CLK_CNT, &cnter, NULL);
+
+	BUG_ON(!mutex_is_locked(&clock->clock_lock));
+
+	if (err) {
+		xrt_err(pdev, "no counter specified");
+		return err;
+	}
+
+	cnter_leaf = xrt_subdev_get_leaf_by_epname(pdev, cnter);
+	if (!cnter_leaf) {
+		xrt_err(pdev, "can't find counter");
+		return -ENOENT;
+	}
+
+	err = xrt_subdev_ioctl(cnter_leaf, XRT_CLKFREQ_READ, freq);
+	if (err)
+		xrt_err(pdev, "can't read counter");
+	xrt_subdev_put_leaf(clock->pdev, cnter_leaf);
+
+	return err;
+}
+
+static int clock_get_freq(struct clock *clock, u16 *freq, u32 *freq_cnter)
+{
+	int err = 0;
+
+	mutex_lock(&clock->clock_lock);
+
+	if (err == 0 && freq)
+		err = get_freq(clock, freq);
+
+	if (err == 0 && freq_cnter)
+		err = get_freq_counter(clock, freq_cnter);
+
+	mutex_unlock(&clock->clock_lock);
+	return err;
+}
+
+static int clock_set_freq(struct clock *clock, u16 freq)
+{
+	int err;
+
+	mutex_lock(&clock->clock_lock);
+	err = set_freq(clock, freq);
+	mutex_unlock(&clock->clock_lock);
+
+	return err;
+}
+
+static int clock_verify_freq(struct clock *clock)
+{
+	int err = 0;
+	u16 freq;
+	u32 lookup_freq, clock_freq_counter, request_in_khz, tolerance;
+
+	mutex_lock(&clock->clock_lock);
+
+	err = get_freq(clock, &freq);
+	if (err) {
+		xrt_err(clock->pdev, "get freq failed, %d", err);
+		goto end;
+	}
+
+	err = get_freq_counter(clock, &clock_freq_counter);
+	if (err) {
+		xrt_err(clock->pdev, "get freq counter failed, %d", err);
+		goto end;
+	}
+
+	lookup_freq = find_matching_freq(freq, frequency_table,
+		ARRAY_SIZE(frequency_table));
+	request_in_khz = lookup_freq * 1000;
+	tolerance = lookup_freq * 50;
+	if (tolerance < abs(clock_freq_counter-request_in_khz)) {
+		CLOCK_ERR(clock,
+		    "set clock(%s) failed, request %ukhz, actual %dkhz",
+		    clock->clock_ep_name, request_in_khz, clock_freq_counter);
+		err = -EDOM;
+	} else {
+		CLOCK_INFO(clock, "verified clock (%s)", clock->clock_ep_name);
+	}
+
+end:
+	mutex_unlock(&clock->clock_lock);
+	return err;
+}
+
+static int clock_init(struct clock *clock)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(clock->pdev);
+	int err = 0;
+	const u16 *freq;
+
+	err = xrt_md_get_prop(DEV(clock->pdev), pdata->xsp_dtb,
+		clock->clock_ep_name, NULL, PROP_CLK_FREQ,
+		(const void **)&freq, NULL);
+	if (err) {
+		xrt_info(clock->pdev, "no default freq");
+		return 0;
+	}
+
+	mutex_lock(&clock->clock_lock);
+	err = set_freq(clock, be16_to_cpu(*freq));
+	mutex_unlock(&clock->clock_lock);
+
+	return err;
+}
+
+static ssize_t freq_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct clock *clock = platform_get_drvdata(to_platform_device(dev));
+	u16 freq = 0;
+	ssize_t count;
+
+	count = clock_get_freq(clock, &freq, NULL);
+	if (count < 0)
+		return count;
+
+	count = snprintf(buf, 64, "%d\n", freq);
+
+	return count;
+}
+static DEVICE_ATTR_RO(freq);
+
+static struct attribute *clock_attrs[] = {
+	&dev_attr_freq.attr,
+	NULL,
+};
+
+static struct attribute_group clock_attr_group = {
+	.attrs = clock_attrs,
+};
+
+static int
+xrt_clock_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct clock		*clock;
+	int			ret = 0;
+
+	clock = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_CLOCK_SET: {
+		u16	freq = (u16)(uintptr_t)arg;
+
+		ret = clock_set_freq(clock, freq);
+		break;
+	}
+	case XRT_CLOCK_VERIFY: {
+		ret = clock_verify_freq(clock);
+		break;
+	}
+	case XRT_CLOCK_GET: {
+		struct xrt_clock_ioctl_get *get =
+			(struct xrt_clock_ioctl_get *)arg;
+
+		ret = clock_get_freq(clock, &get->freq, &get->freq_cnter);
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int clock_remove(struct platform_device *pdev)
+{
+	struct clock *clock;
+
+	clock = platform_get_drvdata(pdev);
+	if (!clock) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, clock);
+
+	CLOCK_INFO(clock, "successfully removed Clock subdev");
+	return 0;
+}
+
+
+
+static int clock_probe(struct platform_device *pdev)
+{
+	struct clock *clock = NULL;
+	struct resource *res;
+	int ret;
+
+	clock = devm_kzalloc(&pdev->dev, sizeof(*clock), GFP_KERNEL);
+	if (!clock)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, clock);
+	clock->pdev = pdev;
+	mutex_init(&clock->clock_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	clock->clock_base = ioremap(res->start, res->end - res->start + 1);
+	if (!clock->clock_base) {
+		CLOCK_ERR(clock, "map base %pR failed", res);
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	clock->clock_ep_name = res->name;
+
+	ret = clock_init(clock);
+	if (ret)
+		goto failed;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &clock_attr_group);
+	if (ret) {
+		CLOCK_ERR(clock, "create clock attrs failed: %d", ret);
+		goto failed;
+	}
+
+	CLOCK_INFO(clock, "successfully initialized Clock subdev");
+
+	return 0;
+
+failed:
+	clock_remove(pdev);
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_clock_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .regmap_name = "clkwiz" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_clock_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_clock_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_clock_table[] = {
+	{ XRT_CLOCK, (kernel_ulong_t)&xrt_clock_data },
+	{ },
+};
+
+struct platform_driver xrt_clock_driver = {
+	.driver = {
+		.name = XRT_CLOCK,
+	},
+	.probe = clock_probe,
+	.remove = clock_remove,
+	.id_table = xrt_clock_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c
new file mode 100644
index 000000000000..ec03ba73c677
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include "xrt-subdev.h"
+#include "xrt-cmc-impl.h"
+#include "xmgmt-main.h"
+#include <linux/xrt/mailbox_proto.h>
+
+enum board_info_key {
+	BDINFO_SN = 0x21,
+	BDINFO_MAC0,
+	BDINFO_MAC1,
+	BDINFO_MAC2,
+	BDINFO_MAC3,
+	BDINFO_REV,
+	BDINFO_NAME,
+	BDINFO_BMC_VER,
+	BDINFO_MAX_PWR,
+	BDINFO_FAN_PRESENCE,
+	BDINFO_CONFIG_MODE,
+	BDINFO_MAC_DYNAMIC = 0x4b,
+};
+
+struct xrt_cmc_bdinfo {
+	struct platform_device *pdev;
+	struct mutex lock;
+	char *bdinfo;
+	size_t bdinfo_sz;
+};
+
+static const char *cmc_parse_board_info(struct xrt_cmc_bdinfo *cmc_bdi,
+	enum board_info_key key, size_t *len)
+{
+	const char *buf = cmc_bdi->bdinfo, *p;
+	u32 sz = cmc_bdi->bdinfo_sz;
+
+	BUG_ON(!mutex_is_locked(&cmc_bdi->lock));
+
+	if (!buf)
+		return NULL;
+
+	for (p = buf; p < buf + sz;) {
+		char k = *(p++);
+		u8 l = *(p++);
+
+		if (k == key) {
+			if (len)
+				*len = l;
+			return p;
+		}
+		p += l;
+	}
+
+	return NULL;
+}
+
+static int cmc_refresh_board_info_nolock(struct xrt_cmc_bdinfo *cmc_bdi)
+{
+	int ret = 0;
+	int gen = -EINVAL;
+	char *bdinfo_raw = NULL;
+	size_t bd_info_sz = cmc_mailbox_max_payload(cmc_bdi->pdev);
+	struct platform_device *pdev = cmc_bdi->pdev;
+	void *newinfo = NULL;
+
+	BUG_ON(!mutex_is_locked(&cmc_bdi->lock));
+
+	bdinfo_raw = vzalloc(bd_info_sz);
+	if (bdinfo_raw == NULL) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	/* Load new info from HW. */
+	gen = cmc_mailbox_acquire(pdev);
+	if (gen < 0) {
+		xrt_err(pdev, "failed to hold mailbox: %d", gen);
+		ret = gen;
+		goto done;
+	}
+	ret = cmc_mailbox_send_packet(pdev, gen, CMC_MBX_PKT_OP_BOARD_INFO,
+		NULL, 0);
+	if (ret) {
+		xrt_err(pdev, "failed to send pkt: %d", ret);
+		goto done;
+	}
+	ret = cmc_mailbox_recv_packet(pdev, gen, bdinfo_raw, &bd_info_sz);
+	if (ret) {
+		xrt_err(pdev, "failed to receive pkt: %d", ret);
+		goto done;
+	}
+
+	newinfo = kmemdup(bdinfo_raw, bd_info_sz, GFP_KERNEL);
+	if (newinfo == NULL) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	kfree(cmc_bdi->bdinfo);
+	cmc_bdi->bdinfo = newinfo;
+	cmc_bdi->bdinfo_sz = bd_info_sz;
+
+done:
+	if (gen >= 0)
+		cmc_mailbox_release(pdev, gen);
+	vfree(bdinfo_raw);
+	return ret;
+}
+
+int cmc_refresh_board_info(struct platform_device *pdev)
+{
+	int ret;
+	struct xrt_cmc_bdinfo *cmc_bdi = cmc_pdev2bdinfo(pdev);
+
+	if (!cmc_bdi)
+		return -ENODEV;
+
+	mutex_lock(&cmc_bdi->lock);
+	ret = cmc_refresh_board_info_nolock(cmc_bdi);
+	mutex_unlock(&cmc_bdi->lock);
+	return ret;
+}
+
+static void cmc_copy_board_info_by_key(struct xrt_cmc_bdinfo *cmc_bdi,
+	enum board_info_key key, void *target)
+{
+	size_t len;
+	const char *info;
+
+	info = cmc_parse_board_info(cmc_bdi, key, &len);
+	if (!info)
+		return;
+	memcpy(target, info, len);
+}
+
+static void cmc_copy_dynamic_mac(struct xrt_cmc_bdinfo *cmc_bdi,
+	u32 *num_mac, void *first_mac)
+{
+	size_t len = 0;
+	const char *info;
+	u16 num = 0;
+
+	info = cmc_parse_board_info(cmc_bdi, BDINFO_MAC_DYNAMIC, &len);
+	if (!info)
+		return;
+
+	if (len != 8) {
+		xrt_err(cmc_bdi->pdev, "dynamic mac data is corrupted.");
+		return;
+	}
+
+	/*
+	 * Byte 0:1 is contiguous mac addresses number in LSB.
+	 * Byte 2:7 is first mac address.
+	 */
+	memcpy(&num, info, 2);
+	*num_mac = le16_to_cpu(num);
+	memcpy(first_mac, info + 2, 6);
+}
+
+static void cmc_copy_expect_bmc(struct xrt_cmc_bdinfo *cmc_bdi, void *expbmc)
+{
+/* Not a real SC version to indicate that SC image does not exist. */
+#define	NONE_BMC_VERSION	"0.0.0"
+	int ret = 0;
+	struct platform_device *pdev = cmc_bdi->pdev;
+	struct platform_device *mgmt_leaf = xrt_subdev_get_leaf_by_id(pdev,
+		XRT_SUBDEV_MGMT_MAIN, PLATFORM_DEVID_NONE);
+	struct xrt_mgmt_main_ioctl_get_axlf_section gs = { XMGMT_BLP, BMC, };
+	struct bmc *bmcsect;
+
+	(void)sprintf(expbmc, "%s", NONE_BMC_VERSION);
+
+	if (mgmt_leaf == NULL) {
+		xrt_err(pdev, "failed to get hold of main");
+		return;
+	}
+
+	ret = xrt_subdev_ioctl(mgmt_leaf, XRT_MGMT_MAIN_GET_AXLF_SECTION, &gs);
+	if (ret == 0) {
+		bmcsect = (struct bmc *)gs.xmmigas_section;
+		memcpy(expbmc, bmcsect->m_version, sizeof(bmcsect->m_version));
+	} else {
+		/*
+		 * no SC section, SC should be fixed, expected SC should be
+		 * the same as on board SC.
+		 */
+		cmc_copy_board_info_by_key(cmc_bdi, BDINFO_BMC_VER, expbmc);
+	}
+	(void) xrt_subdev_put_leaf(pdev, mgmt_leaf);
+}
+
+int cmc_bdinfo_read(struct platform_device *pdev, struct xcl_board_info *bdinfo)
+{
+	struct xrt_cmc_bdinfo *cmc_bdi = cmc_pdev2bdinfo(pdev);
+
+	mutex_lock(&cmc_bdi->lock);
+
+	if (cmc_bdi->bdinfo == NULL) {
+		xrt_err(cmc_bdi->pdev, "board info is not available");
+		mutex_unlock(&cmc_bdi->lock);
+		return -ENOENT;
+	}
+
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_SN, bdinfo->serial_num);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_MAC0, bdinfo->mac_addr0);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_MAC1, bdinfo->mac_addr1);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_MAC2, bdinfo->mac_addr2);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_MAC3, bdinfo->mac_addr3);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_REV, bdinfo->revision);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_NAME, bdinfo->bd_name);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_BMC_VER, bdinfo->bmc_ver);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_MAX_PWR, &bdinfo->max_power);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_FAN_PRESENCE,
+		&bdinfo->fan_presence);
+	cmc_copy_board_info_by_key(cmc_bdi, BDINFO_CONFIG_MODE,
+		&bdinfo->config_mode);
+	cmc_copy_dynamic_mac(cmc_bdi, &bdinfo->mac_contiguous_num,
+		bdinfo->mac_addr_first);
+	cmc_copy_expect_bmc(cmc_bdi, bdinfo->exp_bmc_ver);
+
+	mutex_unlock(&cmc_bdi->lock);
+	return 0;
+}
+
+#define	CMC_BDINFO_STRING_SYSFS_NODE(name, key)				\
+	static ssize_t name##_show(struct device *dev,			\
+		struct device_attribute *attr, char *buf)		\
+	{								\
+		const char *s;						\
+		struct platform_device *pdev = to_platform_device(dev);	\
+		struct xrt_cmc_bdinfo *cmc_bdi = cmc_pdev2bdinfo(pdev);\
+									\
+		mutex_lock(&cmc_bdi->lock);				\
+		s = cmc_parse_board_info(cmc_bdi, key, NULL);		\
+		mutex_unlock(&cmc_bdi->lock);				\
+		return sprintf(buf, "%s\n", s ? s : "");		\
+	}								\
+	static DEVICE_ATTR_RO(name)
+
+CMC_BDINFO_STRING_SYSFS_NODE(bd_name, BDINFO_NAME);
+CMC_BDINFO_STRING_SYSFS_NODE(bmc_ver, BDINFO_BMC_VER);
+
+static struct attribute *cmc_bdinfo_attrs[] = {
+	&dev_attr_bd_name.attr,
+	&dev_attr_bmc_ver.attr,
+	NULL
+};
+
+static ssize_t bdinfo_raw_show(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+{
+	ssize_t ret = 0;
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_cmc_bdinfo *cmc_bdi = cmc_pdev2bdinfo(pdev);
+
+	if (!cmc_bdi || !cmc_bdi->bdinfo_sz)
+		return 0;
+
+	mutex_lock(&cmc_bdi->lock);
+
+	if (off < cmc_bdi->bdinfo_sz) {
+		if (off + count > cmc_bdi->bdinfo_sz)
+			count = cmc_bdi->bdinfo_sz - off;
+		memcpy(buf, cmc_bdi->bdinfo + off, count);
+		ret = count;
+	}
+
+	mutex_unlock(&cmc_bdi->lock);
+	return ret;
+}
+
+static struct bin_attribute bdinfo_raw_attr = {
+	.attr = {
+		.name = "board_info_raw",
+		.mode = 0400
+	},
+	.read = bdinfo_raw_show,
+	.size = 0
+};
+
+static struct bin_attribute *cmc_bdinfo_bin_attrs[] = {
+	&bdinfo_raw_attr,
+	NULL,
+};
+
+static struct attribute_group cmc_bdinfo_attr_group = {
+	.attrs = cmc_bdinfo_attrs,
+	.bin_attrs = cmc_bdinfo_bin_attrs,
+};
+
+void cmc_bdinfo_remove(struct platform_device *pdev)
+{
+	struct xrt_cmc_bdinfo *cmc_bdi = cmc_pdev2bdinfo(pdev);
+
+	if (!cmc_bdi)
+		return;
+
+	sysfs_remove_group(&pdev->dev.kobj, &cmc_bdinfo_attr_group);
+	kfree(cmc_bdi->bdinfo);
+}
+
+int cmc_bdinfo_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl)
+{
+	int ret;
+	struct xrt_cmc_bdinfo *cmc_bdi;
+
+	cmc_bdi = devm_kzalloc(DEV(pdev), sizeof(*cmc_bdi), GFP_KERNEL);
+	if (!cmc_bdi)
+		return -ENOMEM;
+
+	cmc_bdi->pdev = pdev;
+	mutex_init(&cmc_bdi->lock);
+
+	mutex_lock(&cmc_bdi->lock);
+	ret = cmc_refresh_board_info_nolock(cmc_bdi);
+	mutex_unlock(&cmc_bdi->lock);
+	if (ret) {
+		xrt_err(pdev, "failed to load board info: %d", ret);
+		goto fail;
+	}
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &cmc_bdinfo_attr_group);
+	if (ret) {
+		xrt_err(pdev, "create bdinfo attrs failed: %d", ret);
+		goto fail;
+	}
+
+	*hdl = cmc_bdi;
+	return 0;
+
+fail:
+	cmc_bdinfo_remove(pdev);
+	devm_kfree(DEV(pdev), cmc_bdi);
+	return ret;
+}
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c
new file mode 100644
index 000000000000..eeee1296c732
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+#include "xrt-subdev.h"
+#include "xmgmt-main.h"
+#include "xrt-cmc-impl.h"
+
+struct xrt_cmc_ctrl {
+	struct platform_device *pdev;
+	struct cmc_reg_map reg_mutex;
+	struct cmc_reg_map reg_reset;
+	struct cmc_reg_map reg_io;
+	struct cmc_reg_map reg_image;
+	char *firmware;
+	size_t firmware_size;
+	void *evt_hdl;
+};
+
+static inline void
+cmc_mutex_config(struct xrt_cmc_ctrl *cmc_ctrl, u32 val)
+{
+	iowrite32(val, cmc_ctrl->reg_mutex.crm_addr + CMC_REG_MUTEX_CONFIG);
+}
+
+static inline u32
+cmc_mutex_status(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	return ioread32(cmc_ctrl->reg_mutex.crm_addr + CMC_REG_MUTEX_STATUS);
+}
+
+static inline void
+cmc_reset_wr(struct xrt_cmc_ctrl *cmc_ctrl, u32 val)
+{
+	iowrite32(val, cmc_ctrl->reg_reset.crm_addr);
+}
+
+static inline u32
+cmc_reset_rd(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	return ioread32(cmc_ctrl->reg_reset.crm_addr);
+}
+
+static inline void
+cmc_io_wr(struct xrt_cmc_ctrl *cmc_ctrl, u32 off, u32 val)
+{
+	iowrite32(val, cmc_ctrl->reg_io.crm_addr + off);
+}
+
+static inline u32
+cmc_io_rd(struct xrt_cmc_ctrl *cmc_ctrl, u32 off)
+{
+	return ioread32(cmc_ctrl->reg_io.crm_addr + off);
+}
+
+static inline bool cmc_reset_held(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	return cmc_reset_rd(cmc_ctrl) == CMC_RESET_MASK_ON;
+}
+
+static inline bool cmc_ulp_access_allowed(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	return (cmc_mutex_status(cmc_ctrl) & CMC_MUTEX_MASK_GRANT) != 0;
+}
+
+static inline bool cmc_stopped(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	union cmc_status st;
+
+	st.status_val = cmc_io_rd(cmc_ctrl, CMC_REG_IO_STATUS);
+	return st.status.mb_stopped;
+}
+
+static inline bool cmc_ready(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	return (cmc_mutex_status(cmc_ctrl) & CMC_MUTEX_MASK_READY) != 0;
+}
+
+static int cmc_ulp_access(struct xrt_cmc_ctrl *cmc_ctrl, bool granted)
+{
+	const char *opname = granted ? "grant access" : "revoke access";
+
+	cmc_mutex_config(cmc_ctrl, granted ? 1 : 0);
+	CMC_WAIT(cmc_ulp_access_allowed(cmc_ctrl) == granted);
+	if (cmc_ulp_access_allowed(cmc_ctrl) != granted) {
+		xrt_err(cmc_ctrl->pdev, "mutex status is 0x%x after %s",
+			cmc_mutex_status(cmc_ctrl), opname);
+		return -EBUSY;
+	}
+	xrt_info(cmc_ctrl->pdev, "%s operation succeeded", opname);
+	return 0;
+}
+
+static int cmc_stop(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	struct platform_device *pdev = cmc_ctrl->pdev;
+
+	if (cmc_reset_held(cmc_ctrl)) {
+		xrt_info(pdev, "CMC is already in reset state");
+		return 0;
+	}
+
+	if (!cmc_stopped(cmc_ctrl)) {
+		cmc_io_wr(cmc_ctrl, CMC_REG_IO_CONTROL, CMC_CTRL_MASK_STOP);
+		cmc_io_wr(cmc_ctrl, CMC_REG_IO_STOP_CONFIRM, 1);
+		CMC_WAIT(cmc_stopped(cmc_ctrl));
+		if (!cmc_stopped(cmc_ctrl)) {
+			xrt_err(pdev, "failed to stop CMC");
+			return -ETIMEDOUT;
+		}
+	}
+
+	cmc_reset_wr(cmc_ctrl, CMC_RESET_MASK_ON);
+	if (!cmc_reset_held(cmc_ctrl)) {
+		xrt_err(pdev, "failed to hold CMC in reset state");
+		return -EINVAL;
+	}
+
+	xrt_info(pdev, "CMC is successfully stopped");
+	return 0;
+}
+
+static int cmc_load_image(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	struct platform_device *pdev = cmc_ctrl->pdev;
+
+	/* Sanity check the size of the firmware. */
+	if (cmc_ctrl->firmware_size > cmc_ctrl->reg_image.crm_size) {
+		xrt_err(pdev, "CMC firmware image is too big: %ld",
+			cmc_ctrl->firmware_size);
+		return -EINVAL;
+	}
+
+	xrt_memcpy_toio(cmc_ctrl->reg_image.crm_addr,
+		cmc_ctrl->firmware, cmc_ctrl->firmware_size);
+	return 0;
+}
+
+static int cmc_start(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	struct platform_device *pdev = cmc_ctrl->pdev;
+
+	cmc_reset_wr(cmc_ctrl, CMC_RESET_MASK_OFF);
+	if (cmc_reset_held(cmc_ctrl)) {
+		xrt_err(pdev, "failed to release CMC from reset state");
+		return -EINVAL;
+	}
+
+	CMC_WAIT(cmc_ready(cmc_ctrl));
+	if (!cmc_ready(cmc_ctrl)) {
+		xrt_err(pdev, "failed to wait for CMC to be ready");
+		return -ETIMEDOUT;
+	}
+
+	xrt_info(pdev, "Wait for 5 seconds for CMC to connect to SC");
+	ssleep(5);
+
+	xrt_info(pdev, "CMC is ready: version 0x%x, status 0x%x, id 0x%x",
+		cmc_io_rd(cmc_ctrl, CMC_REG_IO_VERSION),
+		cmc_io_rd(cmc_ctrl, CMC_REG_IO_STATUS),
+		cmc_io_rd(cmc_ctrl, CMC_REG_IO_MAGIC));
+
+	return 0;
+}
+
+static int cmc_fetch_firmware(struct xrt_cmc_ctrl *cmc_ctrl)
+{
+	int ret = 0;
+	struct platform_device *pdev = cmc_ctrl->pdev;
+	struct platform_device *mgmt_leaf = xrt_subdev_get_leaf_by_id(pdev,
+		XRT_SUBDEV_MGMT_MAIN, PLATFORM_DEVID_NONE);
+	struct xrt_mgmt_main_ioctl_get_axlf_section gs = {
+		XMGMT_BLP, FIRMWARE,
+	};
+
+	if (mgmt_leaf == NULL)
+		return -ENOENT;
+
+	ret = xrt_subdev_ioctl(mgmt_leaf, XRT_MGMT_MAIN_GET_AXLF_SECTION, &gs);
+	if (ret == 0) {
+		cmc_ctrl->firmware = vmalloc(gs.xmmigas_section_size);
+		if (cmc_ctrl->firmware == NULL) {
+			ret = -ENOMEM;
+		} else {
+			memcpy(cmc_ctrl->firmware, gs.xmmigas_section,
+				gs.xmmigas_section_size);
+			cmc_ctrl->firmware_size = gs.xmmigas_section_size;
+		}
+	} else {
+		xrt_err(pdev, "failed to fetch firmware: %d", ret);
+	}
+	(void) xrt_subdev_put_leaf(pdev, mgmt_leaf);
+
+	return ret;
+}
+
+static ssize_t status_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	struct xrt_cmc_ctrl *cmc_ctrl = dev_get_drvdata(dev);
+	u32 val = cmc_io_rd(cmc_ctrl, CMC_REG_IO_STATUS);
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(status);
+
+static struct attribute *cmc_ctrl_attrs[] = {
+	&dev_attr_status.attr,
+	NULL,
+};
+
+static struct attribute_group cmc_ctrl_attr_group = {
+	.attrs = cmc_ctrl_attrs,
+};
+
+void cmc_ctrl_remove(struct platform_device *pdev)
+{
+	struct xrt_cmc_ctrl *cmc_ctrl =
+		(struct xrt_cmc_ctrl *)cmc_pdev2ctrl(pdev);
+
+	if (!cmc_ctrl)
+		return;
+
+	if (cmc_ctrl->evt_hdl)
+		(void) xrt_subdev_remove_event_cb(pdev, cmc_ctrl->evt_hdl);
+	(void) sysfs_remove_group(&DEV(cmc_ctrl->pdev)->kobj,
+		&cmc_ctrl_attr_group);
+	(void) cmc_ulp_access(cmc_ctrl, false);
+	vfree(cmc_ctrl->firmware);
+	/* We intentionally leave CMC in running state. */
+}
+
+static bool cmc_ctrl_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	/* Only interested in broadcast events. */
+	return false;
+}
+
+static int cmc_ctrl_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+	struct xrt_cmc_ctrl *cmc_ctrl =
+		(struct xrt_cmc_ctrl *)cmc_pdev2ctrl(pdev);
+
+	switch (evt) {
+	case XRT_EVENT_PRE_GATE_CLOSE:
+		(void) cmc_ulp_access(cmc_ctrl, false);
+		break;
+	case XRT_EVENT_POST_GATE_OPEN:
+		(void) cmc_ulp_access(cmc_ctrl, true);
+		break;
+	default:
+		xrt_info(pdev, "ignored event %d", evt);
+		break;
+	}
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+int cmc_ctrl_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl)
+{
+	struct xrt_cmc_ctrl *cmc_ctrl;
+	int ret = 0;
+
+	cmc_ctrl = devm_kzalloc(DEV(pdev), sizeof(*cmc_ctrl), GFP_KERNEL);
+	if (!cmc_ctrl)
+		return -ENOMEM;
+
+	cmc_ctrl->pdev = pdev;
+
+	/* Obtain register maps we need to start/stop CMC. */
+	cmc_ctrl->reg_mutex = regmaps[IO_MUTEX];
+	cmc_ctrl->reg_reset = regmaps[IO_GPIO];
+	cmc_ctrl->reg_io = regmaps[IO_REG];
+	cmc_ctrl->reg_image = regmaps[IO_IMAGE_MGMT];
+
+	/* Get firmware image from xmgmt-main leaf. */
+	ret = cmc_fetch_firmware(cmc_ctrl);
+	if (ret)
+		goto done;
+
+	/* Load firmware. */
+
+	ret = cmc_ulp_access(cmc_ctrl, false);
+	if (ret)
+		goto done;
+
+	ret = cmc_stop(cmc_ctrl);
+	if (ret)
+		goto done;
+
+	ret = cmc_load_image(cmc_ctrl);
+	if (ret)
+		goto done;
+
+	ret = cmc_start(cmc_ctrl);
+	if (ret)
+		goto done;
+
+	ret  = sysfs_create_group(&DEV(pdev)->kobj, &cmc_ctrl_attr_group);
+	if (ret)
+		xrt_err(pdev, "failed to create sysfs nodes: %d", ret);
+
+	cmc_ctrl->evt_hdl = xrt_subdev_add_event_cb(pdev,
+		cmc_ctrl_leaf_match, NULL, cmc_ctrl_event_cb);
+
+	*hdl = cmc_ctrl;
+	return 0;
+
+done:
+	(void) cmc_ctrl_remove(pdev);
+	devm_kfree(DEV(pdev), cmc_ctrl);
+	return ret;
+}
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h
new file mode 100644
index 000000000000..9454dc948a41
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_CMC_IMPL_H_
+#define	_XRT_CMC_IMPL_H_
+
+#include "linux/delay.h"
+#include "xrt-subdev.h"
+#include <linux/xrt/mailbox_proto.h>
+
+#define	CMC_MAX_RETRY		150 /* Retry is set to 15s */
+#define	CMC_MAX_RETRY_LONG	(CMC_MAX_RETRY * 4) /* mailbox retry is 1min */
+#define	CMC_RETRY_INTERVAL	100 /* 100ms */
+
+/* Mutex register defines. */
+#define	CMC_REG_MUTEX_CONFIG			0x0
+#define	CMC_REG_MUTEX_STATUS			0x8
+#define	CMC_MUTEX_MASK_GRANT			(0x1 << 0)
+#define	CMC_MUTEX_MASK_READY			(0x1 << 1)
+
+/* Reset register defines. */
+#define	CMC_RESET_MASK_ON			0x0
+#define	CMC_RESET_MASK_OFF			0x1
+
+/* IO register defines. */
+#define	CMC_REG_IO_MAGIC			0x0
+#define	CMC_REG_IO_VERSION			0x4
+#define	CMC_REG_IO_STATUS			0x8
+#define	CMC_REG_IO_ERROR			0xc
+#define	CMC_REG_IO_CONTROL			0x18
+#define	CMC_REG_IO_STOP_CONFIRM			0x1C
+#define	CMC_REG_IO_MBX_OFFSET			0x300
+#define	CMC_REG_IO_MBX_ERROR			0x304
+#define	CMC_REG_IO_CORE_VERSION			0xC4C
+
+#define	CMC_CTRL_MASK_CLR_ERR			(1 << 1)
+#define	CMC_CTRL_MASK_STOP			(1 << 3)
+#define	CMC_CTRL_MASK_MBX_PKT_OWNER		(1 << 5)
+#define	CMC_ERROR_MASK_MBX_ERR			(1 << 26)
+#define	CMC_STATUS_MASK_STOPPED			(1 << 1)
+
+#define	__CMC_WAIT(cond, retries)				\
+	do {							\
+		int retry = 0;					\
+		while (retry++ < retries && !(cond))		\
+			msleep(CMC_RETRY_INTERVAL);		\
+	} while (0)
+#define CMC_WAIT(cond)	__CMC_WAIT(cond, CMC_MAX_RETRY)
+#define CMC_LONG_WAIT(cond)	__CMC_WAIT(cond, CMC_MAX_RETRY_LONG)
+
+union cmc_status {
+	u32 status_val;
+	struct {
+		u32 init_done		: 1;
+		u32 mb_stopped		: 1;
+		u32 reserved0		: 1;
+		u32 watchdog_reset	: 1;
+		u32 reserved1		: 6;
+		u32 power_mode		: 2;
+		u32 reserved2		: 12;
+		u32 sc_comm_ver		: 4;
+		u32 sc_mode		: 3;
+		u32 invalid_sc		: 1;
+	} status;
+};
+
+enum {
+	CMC_MBX_PKT_OP_UNKNOWN = 0,
+	CMC_MBX_PKT_OP_MSP432_SEC_START,
+	CMC_MBX_PKT_OP_MSP432_SEC_DATA,
+	CMC_MBX_PKT_OP_MSP432_IMAGE_END,
+	CMC_MBX_PKT_OP_BOARD_INFO,
+	CMC_MBX_PKT_OP_MSP432_ERASE_FW,
+};
+
+enum {
+	IO_REG = 0,
+	IO_GPIO,
+	IO_IMAGE_MGMT,
+	IO_MUTEX,
+	NUM_IOADDR
+};
+
+struct cmc_reg_map {
+	void __iomem *crm_addr;
+	size_t crm_size;
+};
+
+extern int cmc_ctrl_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl);
+extern void cmc_ctrl_remove(struct platform_device *pdev);
+extern void *cmc_pdev2ctrl(struct platform_device *pdev);
+
+extern int cmc_sensor_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl);
+extern void cmc_sensor_remove(struct platform_device *pdev);
+extern void *cmc_pdev2sensor(struct platform_device *pdev);
+extern void cmc_sensor_read(struct platform_device *pdev, struct xcl_sensor *s);
+
+extern int cmc_mailbox_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl);
+extern void cmc_mailbox_remove(struct platform_device *pdev);
+extern void *cmc_pdev2mbx(struct platform_device *pdev);
+extern int cmc_mailbox_acquire(struct platform_device *pdev);
+extern void cmc_mailbox_release(struct platform_device *pdev, int generation);
+extern size_t cmc_mailbox_max_payload(struct platform_device *pdev);
+extern int cmc_mailbox_send_packet(struct platform_device *pdev, int generation,
+	u8 op, const char *buf, size_t len);
+extern int cmc_mailbox_recv_packet(struct platform_device *pdev, int generation,
+	char *buf, size_t *len);
+
+extern int cmc_bdinfo_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl);
+extern void cmc_bdinfo_remove(struct platform_device *pdev);
+extern void *cmc_pdev2bdinfo(struct platform_device *pdev);
+extern int cmc_refresh_board_info(struct platform_device *pdev);
+extern int cmc_bdinfo_read(struct platform_device *pdev,
+	struct xcl_board_info *bdinfo);
+
+extern int cmc_sc_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl);
+extern void cmc_sc_remove(struct platform_device *pdev);
+extern void *cmc_pdev2sc(struct platform_device *pdev);
+extern int cmc_sc_open(struct inode *inode, struct file *file);
+extern int cmc_sc_close(struct inode *inode, struct file *file);
+extern ssize_t cmc_update_sc_firmware(struct file *file,
+	const char __user *ubuf, size_t n, loff_t *off);
+extern loff_t cmc_sc_llseek(struct file *filp, loff_t off, int whence);
+
+#endif	/* _XRT_CMC_IMPL_H_ */
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c
new file mode 100644
index 000000000000..5912cd9f3e90
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include "xrt-subdev.h"
+#include "xrt-cmc-impl.h"
+
+/* We have a 4k buffer for cmc mailbox */
+#define	CMC_PKT_MAX_SZ	1024 /* In u32 */
+#define	CMC_PKT_MAX_PAYLOAD_SZ	\
+	(CMC_PKT_MAX_SZ - sizeof(struct cmc_pkt_hdr) / sizeof(u32)) /* In u32 */
+#define	CMC_PKT_MAX_PAYLOAD_SZ_IN_BYTES	(CMC_PKT_MAX_PAYLOAD_SZ * sizeof(u32))
+#define	CMC_PKT_SZ(hdr)		\
+	((sizeof(struct cmc_pkt_hdr) + (hdr)->payload_sz + sizeof(u32) - 1) / \
+	sizeof(u32)) /* In u32 */
+
+/* Make sure hdr is multiple of u32 */
+struct cmc_pkt_hdr {
+	u32 payload_sz	: 12;
+	u32 reserved	: 12;
+	u32 op		: 8;
+};
+
+struct cmc_pkt {
+	struct cmc_pkt_hdr hdr;
+	u32 data[CMC_PKT_MAX_PAYLOAD_SZ];
+};
+
+struct xrt_cmc_mbx {
+	struct platform_device *pdev;
+	struct cmc_reg_map reg_io;
+	u32 mbx_offset;
+	struct mutex lock;
+	struct cmc_pkt pkt;
+	struct semaphore sem;
+	int generation;
+};
+
+static inline void
+cmc_io_wr(struct xrt_cmc_mbx *cmc_mbx, u32 off, u32 val)
+{
+	iowrite32(val, cmc_mbx->reg_io.crm_addr + off);
+}
+
+static inline u32
+cmc_io_rd(struct xrt_cmc_mbx *cmc_mbx, u32 off)
+{
+	return ioread32(cmc_mbx->reg_io.crm_addr + off);
+}
+
+static inline bool
+cmc_pkt_host_owned(struct xrt_cmc_mbx *cmc_mbx)
+{
+	return (cmc_io_rd(cmc_mbx, CMC_REG_IO_CONTROL) &
+		CMC_CTRL_MASK_MBX_PKT_OWNER) == 0;
+}
+
+static inline void
+cmc_pkt_control_set(struct xrt_cmc_mbx *cmc_mbx, u32 ctrl)
+{
+	u32 val = cmc_io_rd(cmc_mbx, CMC_REG_IO_CONTROL);
+
+	cmc_io_wr(cmc_mbx, CMC_REG_IO_CONTROL, val | ctrl);
+}
+
+static inline void
+cmc_pkt_notify_device(struct xrt_cmc_mbx *cmc_mbx)
+{
+	cmc_pkt_control_set(cmc_mbx, CMC_CTRL_MASK_MBX_PKT_OWNER);
+}
+
+static inline void
+cmc_pkt_clear_error(struct xrt_cmc_mbx *cmc_mbx)
+{
+	cmc_pkt_control_set(cmc_mbx, CMC_CTRL_MASK_CLR_ERR);
+}
+
+static int cmc_mailbox_wait(struct xrt_cmc_mbx *cmc_mbx)
+{
+	u32 val;
+
+	BUG_ON(!mutex_is_locked(&cmc_mbx->lock));
+
+	CMC_LONG_WAIT(cmc_pkt_host_owned(cmc_mbx));
+	if (!cmc_pkt_host_owned(cmc_mbx)) {
+		xrt_err(cmc_mbx->pdev, "CMC packet error: time'd out");
+		return -ETIMEDOUT;
+	}
+
+	val = cmc_io_rd(cmc_mbx, CMC_REG_IO_ERROR);
+	if (val & CMC_ERROR_MASK_MBX_ERR)
+		val = cmc_io_rd(cmc_mbx, CMC_REG_IO_MBX_ERROR);
+	if (val) {
+		xrt_err(cmc_mbx->pdev, "CMC packet error: %d", val);
+		cmc_pkt_clear_error(cmc_mbx);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int cmc_mailbox_pkt_write(struct xrt_cmc_mbx *cmc_mbx)
+{
+	u32 *pkt = (u32 *)&cmc_mbx->pkt;
+	u32 len = CMC_PKT_SZ(&cmc_mbx->pkt.hdr);
+	int ret = 0;
+	u32 i;
+
+	BUG_ON(!mutex_is_locked(&cmc_mbx->lock));
+
+#ifdef	MBX_PKT_DEBUG
+	xrt_info(cmc_mbx->pdev, "Sending CMC packet: %d DWORDS...", len);
+	xrt_info(cmc_mbx->pdev, "opcode=%d payload_sz=0x%x (0x%x)",
+		cmc_mbx->pkt.hdr.op, cmc_mbx->pkt.hdr.payload_sz, pkt[0]);
+	for (i = 0; i < 16; i++) {// print out first 16 bytes
+		/* Comment out to avoid check patch complaint. */
+		//pr_cont("%02x ", *((u8 *)(cmc_mbx->pkt.data) + i));
+	}
+#endif
+	/* Push pkt data to mailbox on HW. */
+	for (i = 0; i < len; i++) {
+		cmc_io_wr(cmc_mbx,
+			cmc_mbx->mbx_offset + i * sizeof(u32), pkt[i]);
+	}
+
+	/* Notify HW that a pkt is ready for process. */
+	cmc_pkt_notify_device(cmc_mbx);
+	/* Make sure HW is done with the mailbox buffer. */
+	ret = cmc_mailbox_wait(cmc_mbx);
+
+	return ret;
+}
+
+static int cmc_mailbox_pkt_read(struct xrt_cmc_mbx *cmc_mbx)
+{
+	struct cmc_pkt_hdr hdr;
+	u32 *pkt;
+	u32 len;
+	u32 i;
+	int ret = 0;
+
+	BUG_ON(!mutex_is_locked(&cmc_mbx->lock));
+
+	/* Make sure HW is done with the mailbox buffer. */
+	ret = cmc_mailbox_wait(cmc_mbx);
+	if (ret)
+		return ret;
+
+	/* Receive pkt hdr. */
+	pkt = (u32 *)&hdr;
+	len = sizeof(hdr) / sizeof(u32);
+	for (i = 0; i < len; i++) {
+		pkt[i] = cmc_io_rd(cmc_mbx,
+			cmc_mbx->mbx_offset + i * sizeof(u32));
+	}
+
+	pkt = (u32 *)&cmc_mbx->pkt;
+	len = CMC_PKT_SZ(&hdr);
+	if (hdr.payload_sz == 0 || len > CMC_PKT_MAX_SZ) {
+		xrt_err(cmc_mbx->pdev, "read invalid CMC packet");
+		return -EINVAL;
+	}
+
+	/* Load pkt data from mailbox on HW. */
+	for (i = 0; i < len; i++) {
+		pkt[i] = cmc_io_rd(cmc_mbx,
+			cmc_mbx->mbx_offset + i * sizeof(u32));
+	}
+
+	return ret;
+}
+
+int cmc_mailbox_recv_packet(struct platform_device *pdev, int generation,
+	char *buf, size_t *len)
+{
+	int ret;
+	struct xrt_cmc_mbx *cmc_mbx = cmc_pdev2mbx(pdev);
+
+	if (cmc_mbx == NULL)
+		return -EINVAL;
+
+	if (cmc_mbx->generation != generation) {
+		xrt_err(cmc_mbx->pdev, "stale generation number passed in");
+		return -EINVAL;
+	}
+
+	mutex_lock(&cmc_mbx->lock);
+
+	ret = cmc_mailbox_pkt_read(cmc_mbx);
+	if (ret) {
+		mutex_unlock(&cmc_mbx->lock);
+		return ret;
+	}
+	if (cmc_mbx->pkt.hdr.payload_sz > *len) {
+		xrt_err(cmc_mbx->pdev,
+			"packet size (0x%x) exceeds buf size (0x%lx)",
+			cmc_mbx->pkt.hdr.payload_sz, *len);
+		mutex_unlock(&cmc_mbx->lock);
+		return -E2BIG;
+	}
+	memcpy(buf, cmc_mbx->pkt.data, cmc_mbx->pkt.hdr.payload_sz);
+	*len = cmc_mbx->pkt.hdr.payload_sz;
+
+	mutex_unlock(&cmc_mbx->lock);
+	return 0;
+}
+
+int cmc_mailbox_send_packet(struct platform_device *pdev, int generation,
+	u8 op, const char *buf, size_t len)
+{
+	int ret;
+	struct xrt_cmc_mbx *cmc_mbx = cmc_pdev2mbx(pdev);
+
+	if (cmc_mbx == NULL)
+		return -ENODEV;
+
+	if (cmc_mbx->generation != generation) {
+		xrt_err(cmc_mbx->pdev, "stale generation number passed in");
+		return -EINVAL;
+	}
+
+	if (len > CMC_PKT_MAX_PAYLOAD_SZ_IN_BYTES) {
+		xrt_err(cmc_mbx->pdev,
+			"packet size (0x%lx) exceeds max size (0x%lx)",
+			len, CMC_PKT_MAX_PAYLOAD_SZ_IN_BYTES);
+		return -E2BIG;
+	}
+
+	mutex_lock(&cmc_mbx->lock);
+
+	memset(&cmc_mbx->pkt, 0, sizeof(struct cmc_pkt));
+	cmc_mbx->pkt.hdr.op = op;
+	cmc_mbx->pkt.hdr.payload_sz = len;
+	if (buf)
+		memcpy(cmc_mbx->pkt.data, buf, len);
+	ret = cmc_mailbox_pkt_write(cmc_mbx);
+
+	mutex_unlock(&cmc_mbx->lock);
+
+	return ret;
+}
+
+int cmc_mailbox_acquire(struct platform_device *pdev)
+{
+	struct xrt_cmc_mbx *cmc_mbx = cmc_pdev2mbx(pdev);
+
+	if (cmc_mbx == NULL)
+		return -EINVAL;
+
+	if (down_killable(&cmc_mbx->sem)) {
+		xrt_info(cmc_mbx->pdev, "giving up on acquiring CMC mailbox");
+		return -ERESTARTSYS;
+	}
+
+	return cmc_mbx->generation;
+}
+
+void cmc_mailbox_release(struct platform_device *pdev, int generation)
+{
+	struct xrt_cmc_mbx *cmc_mbx = cmc_pdev2mbx(pdev);
+
+	if (cmc_mbx->generation != generation) {
+		xrt_err(cmc_mbx->pdev, "stale generation number passed in");
+		return;
+	}
+
+	/*
+	 * A hold is released, bump up generation number
+	 * to invalidate the previous hold.
+	 */
+	cmc_mbx->generation++;
+	up(&cmc_mbx->sem);
+}
+
+size_t cmc_mailbox_max_payload(struct platform_device *pdev)
+{
+	return CMC_PKT_MAX_PAYLOAD_SZ_IN_BYTES;
+}
+
+void cmc_mailbox_remove(struct platform_device *pdev)
+{
+	/* Nothing to do */
+}
+
+int cmc_mailbox_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl)
+{
+	struct xrt_cmc_mbx *cmc_mbx;
+
+	cmc_mbx = devm_kzalloc(DEV(pdev), sizeof(*cmc_mbx), GFP_KERNEL);
+	if (!cmc_mbx)
+		return -ENOMEM;
+
+	cmc_mbx->pdev = pdev;
+	/* Obtain register maps we need to start/stop CMC. */
+	cmc_mbx->reg_io = regmaps[IO_REG];
+	mutex_init(&cmc_mbx->lock);
+	sema_init(&cmc_mbx->sem, 1);
+	cmc_mbx->mbx_offset = cmc_io_rd(cmc_mbx, CMC_REG_IO_MBX_OFFSET);
+	if (cmc_mbx->mbx_offset == 0) {
+		xrt_err(cmc_mbx->pdev, "CMC mailbox is not available");
+		goto done;
+	} else {
+		xrt_info(cmc_mbx->pdev, "CMC mailbox offset is 0x%x",
+			cmc_mbx->mbx_offset);
+	}
+
+	*hdl = cmc_mbx;
+	return 0;
+done:
+	cmc_mailbox_remove(pdev);
+	devm_kfree(DEV(pdev), cmc_mbx);
+	return -ENODEV;
+}
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c
new file mode 100644
index 000000000000..c5af4f08f4d2
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/uaccess.h>
+#include "xrt-subdev.h"
+#include "xrt-cmc-impl.h"
+
+#define	CMC_CORE_SUPPORT_NOTUPGRADABLE	0x0c010004
+
+enum sc_mode {
+	CMC_SC_UNKNOWN = 0,
+	CMC_SC_NORMAL,
+	CMC_SC_BSL_MODE_UNSYNCED,
+	CMC_SC_BSL_MODE_SYNCED,
+	CMC_SC_BSL_MODE_SYNCED_SC_NOT_UPGRADABLE,
+	CMC_SC_NORMAL_MODE_SC_NOT_UPGRADABLE
+};
+
+struct cmc_pkt_payload_image_end {
+	u32 BSL_jump_addr;
+};
+
+struct cmc_pkt_payload_sector_start {
+	u32 addr;
+	u32 size;
+	u8 data[1];
+};
+
+struct cmc_pkt_payload_sector_data {
+	u8 data[1];
+};
+
+struct xrt_cmc_sc {
+	struct platform_device *pdev;
+	struct cmc_reg_map reg_io;
+	bool sc_fw_erased;
+	int mbx_generation;
+	size_t mbx_max_payload_sz;
+};
+
+static inline void cmc_io_wr(struct xrt_cmc_sc *cmc_sc, u32 off, u32 val)
+{
+	iowrite32(val, cmc_sc->reg_io.crm_addr + off);
+}
+
+static inline u32 cmc_io_rd(struct xrt_cmc_sc *cmc_sc, u32 off)
+{
+	return ioread32(cmc_sc->reg_io.crm_addr + off);
+}
+
+static bool is_sc_ready(struct xrt_cmc_sc *cmc_sc, bool quiet)
+{
+	union cmc_status st;
+
+	st.status_val = cmc_io_rd(cmc_sc, CMC_REG_IO_STATUS);
+	if (st.status.sc_mode == CMC_SC_NORMAL)
+		return true;
+
+	if (!quiet) {
+		xrt_err(cmc_sc->pdev, "SC is not ready, state=%d",
+			st.status.sc_mode);
+	}
+	return false;
+}
+
+static bool is_sc_fixed(struct xrt_cmc_sc *cmc_sc)
+{
+	union cmc_status st;
+	u32 cmc_core_version = cmc_io_rd(cmc_sc, CMC_REG_IO_CORE_VERSION);
+
+	st.status_val = cmc_io_rd(cmc_sc, CMC_REG_IO_STATUS);
+
+	if (cmc_core_version >= CMC_CORE_SUPPORT_NOTUPGRADABLE &&
+	    !st.status.invalid_sc &&
+	    (st.status.sc_mode == CMC_SC_BSL_MODE_SYNCED_SC_NOT_UPGRADABLE ||
+	     st.status.sc_mode == CMC_SC_NORMAL_MODE_SC_NOT_UPGRADABLE))
+		return true;
+
+	return false;
+}
+
+static int cmc_erase_sc_firmware(struct xrt_cmc_sc *cmc_sc)
+{
+	int ret = 0;
+
+	if (cmc_sc->sc_fw_erased)
+		return 0;
+
+	xrt_info(cmc_sc->pdev, "erasing SC firmware...");
+	ret = cmc_mailbox_send_packet(cmc_sc->pdev, cmc_sc->mbx_generation,
+		CMC_MBX_PKT_OP_MSP432_ERASE_FW, NULL, 0);
+	if (ret == 0)
+		cmc_sc->sc_fw_erased = true;
+	return ret;
+}
+
+static int cmc_write_sc_firmware_section(struct xrt_cmc_sc *cmc_sc,
+	loff_t start, size_t n, const char *buf)
+{
+	int ret = 0;
+	size_t sz, thissz, pktsize;
+	void *pkt;
+	struct cmc_pkt_payload_sector_start *start_payload;
+	struct cmc_pkt_payload_sector_data *data_payload;
+	u8 pkt_op;
+
+	xrt_info(cmc_sc->pdev, "writing %ld bytes @0x%llx", n, start);
+
+	if (n == 0)
+		return 0;
+
+	BUG_ON(!cmc_sc->sc_fw_erased);
+
+	pkt = vzalloc(cmc_sc->mbx_max_payload_sz);
+	if (!pkt)
+		return -ENOMEM;
+
+	for (sz = 0; ret == 0 && sz < n; sz += thissz) {
+		if (sz == 0) {
+			/* First packet for the section. */
+			pkt_op = CMC_MBX_PKT_OP_MSP432_SEC_START;
+			start_payload = pkt;
+			start_payload->addr = start;
+			start_payload->size = n;
+			thissz = cmc_sc->mbx_max_payload_sz - offsetof(
+				struct cmc_pkt_payload_sector_start, data);
+			thissz = min(thissz, n - sz);
+			memcpy(start_payload->data, buf + sz, thissz);
+			pktsize = thissz + offsetof(
+				struct cmc_pkt_payload_sector_start, data);
+		} else {
+			pkt_op = CMC_MBX_PKT_OP_MSP432_SEC_DATA;
+			data_payload = pkt;
+			thissz = cmc_sc->mbx_max_payload_sz - offsetof(
+				struct cmc_pkt_payload_sector_data, data);
+			thissz = min(thissz, n - sz);
+			memcpy(data_payload->data, buf + sz, thissz);
+			pktsize = thissz + offsetof(
+				struct cmc_pkt_payload_sector_data, data);
+		}
+		ret = cmc_mailbox_send_packet(cmc_sc->pdev,
+			cmc_sc->mbx_generation, pkt_op, pkt, pktsize);
+	}
+
+	return ret;
+}
+
+static int
+cmc_boot_sc(struct xrt_cmc_sc *cmc_sc, u32 jump_addr)
+{
+	int ret = 0;
+	struct cmc_pkt_payload_image_end pkt = { 0 };
+
+	xrt_info(cmc_sc->pdev, "rebooting SC @0x%x", jump_addr);
+
+	BUG_ON(!cmc_sc->sc_fw_erased);
+
+	/* Mark new SC firmware is installed. */
+	cmc_sc->sc_fw_erased = false;
+
+	/* Try booting it up. */
+	pkt.BSL_jump_addr = jump_addr;
+	ret = cmc_mailbox_send_packet(cmc_sc->pdev, cmc_sc->mbx_generation,
+		CMC_MBX_PKT_OP_MSP432_IMAGE_END, (char *)&pkt, sizeof(pkt));
+	if (ret)
+		return ret;
+
+	/* Wait for SC to reboot */
+	CMC_LONG_WAIT(is_sc_ready(cmc_sc, true));
+	if (!is_sc_ready(cmc_sc, false))
+		ret = -ETIMEDOUT;
+
+	return ret;
+}
+
+/*
+ * Write SC firmware image data at specified location.
+ */
+ssize_t cmc_update_sc_firmware(struct file *file,
+	const char __user *ubuf, size_t n, loff_t *off)
+{
+	u32 jump_addr = 0;
+	struct xrt_cmc_sc *cmc_sc = file->private_data;
+	/* Special offset for writing SC's BSL jump address. */
+	const loff_t jump_offset = 0xffffffff;
+	ssize_t ret = 0;
+	u8 *kbuf;
+	bool need_refresh = false;
+
+	/* Sanity check input 'n' */
+	if (n == 0 || n > jump_offset || n > 100 * 1024 * 1024)
+		return -EINVAL;
+
+	kbuf = vmalloc(n);
+	if (kbuf == NULL)
+		return -ENOMEM;
+	if (copy_from_user(kbuf, ubuf, n)) {
+		vfree(kbuf);
+		return -EFAULT;
+	}
+
+	cmc_sc->mbx_generation = cmc_mailbox_acquire(cmc_sc->pdev);
+	if (cmc_sc->mbx_generation < 0) {
+		vfree(kbuf);
+		return -ENODEV;
+	}
+
+	ret = cmc_erase_sc_firmware(cmc_sc);
+	if (ret) {
+		xrt_err(cmc_sc->pdev, "can't erase SC firmware");
+	} else if (*off == jump_offset) {
+		/*
+		 * Write to jump_offset will cause a reboot of SC and jump
+		 * to address that is passed in.
+		 */
+		if (n != sizeof(jump_addr)) {
+			xrt_err(cmc_sc->pdev, "invalid jump addr size");
+			ret = -EINVAL;
+		} else {
+			jump_addr = *(u32 *)kbuf;
+			ret = cmc_boot_sc(cmc_sc, jump_addr);
+			/* Need to reload board info after SC image update */
+			need_refresh = true;
+		}
+	} else {
+		ret = cmc_write_sc_firmware_section(cmc_sc, *off, n, kbuf);
+	}
+
+	cmc_mailbox_release(cmc_sc->pdev, cmc_sc->mbx_generation);
+
+	if (need_refresh)
+		(void) cmc_refresh_board_info(cmc_sc->pdev);
+
+	vfree(kbuf);
+	if (ret) {
+		cmc_sc->sc_fw_erased = false;
+		return ret;
+	}
+
+	*off += n;
+	return n;
+}
+
+/*
+ * Only allow one client at a time.
+ */
+int cmc_sc_open(struct inode *inode, struct file *file)
+{
+	struct platform_device *pdev = xrt_devnode_open_excl(inode);
+
+	file->private_data = cmc_pdev2sc(pdev);
+	return 0;
+}
+
+int cmc_sc_close(struct inode *inode, struct file *file)
+{
+	struct xrt_cmc_sc *cmc_sc = file->private_data;
+
+	if (!cmc_sc)
+		return -EINVAL;
+
+	file->private_data = NULL;
+	xrt_devnode_close(inode);
+	return 0;
+}
+
+loff_t cmc_sc_llseek(struct file *filp, loff_t off, int whence)
+{
+	loff_t npos;
+
+	switch (whence) {
+	case 0: /* SEEK_SET */
+		npos = off;
+		break;
+	case 1: /* SEEK_CUR */
+		npos = filp->f_pos + off;
+		break;
+	case 2: /* SEEK_END: no need to support */
+		return -EINVAL;
+	default: /* should not happen */
+		return -EINVAL;
+	}
+	if (npos < 0)
+		return -EINVAL;
+
+	filp->f_pos = npos;
+	return npos;
+}
+
+static ssize_t sc_is_fixed_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_cmc_sc *cmc_sc = cmc_pdev2sc(pdev);
+
+	return sprintf(buf, "%d\n", is_sc_fixed(cmc_sc));
+}
+static DEVICE_ATTR_RO(sc_is_fixed);
+
+static ssize_t sc_presence_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	return sprintf(buf, "1\n");
+}
+static DEVICE_ATTR_RO(sc_presence);
+
+static struct attribute *cmc_sc_attrs[] = {
+	&dev_attr_sc_is_fixed.attr,
+	&dev_attr_sc_presence.attr,
+	NULL
+};
+
+static struct attribute_group cmc_sc_attr_group = {
+	.attrs = cmc_sc_attrs,
+};
+
+void cmc_sc_remove(struct platform_device *pdev)
+{
+	struct xrt_cmc_sc *cmc_sc = cmc_pdev2sc(pdev);
+
+	if (!cmc_sc)
+		return;
+
+	sysfs_remove_group(&pdev->dev.kobj, &cmc_sc_attr_group);
+}
+
+int cmc_sc_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl)
+{
+	int ret;
+	struct xrt_cmc_sc *cmc_sc;
+
+	cmc_sc = devm_kzalloc(DEV(pdev), sizeof(*cmc_sc), GFP_KERNEL);
+	if (!cmc_sc)
+		return -ENOMEM;
+
+	cmc_sc->pdev = pdev;
+	/* Obtain register maps we need to start/stop CMC. */
+	cmc_sc->reg_io = regmaps[IO_REG];
+	cmc_sc->mbx_max_payload_sz = cmc_mailbox_max_payload(pdev);
+	cmc_sc->mbx_generation = -ENODEV;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &cmc_sc_attr_group);
+	if (ret) {
+		xrt_err(pdev, "create sc attrs failed: %d", ret);
+		goto fail;
+	}
+
+	*hdl = cmc_sc;
+	return 0;
+
+fail:
+	cmc_sc_remove(pdev);
+	devm_kfree(DEV(pdev), cmc_sc);
+	return ret;
+}
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-cmc-sensors.c b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-sensors.c
new file mode 100644
index 000000000000..c76f6d1ed3b4
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-cmc-sensors.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include "xmgmt-main.h"
+#include "xrt-cmc-impl.h"
+
+#define	CMC_12V_PEX_REG			0x20
+#define	CMC_3V3_PEX_REG			0x2C
+#define	CMC_3V3_AUX_REG			0x38
+#define	CMC_12V_AUX_REG			0x44
+#define	CMC_DDR4_VPP_BTM_REG		0x50
+#define	CMC_SYS_5V5_REG			0x5C
+#define	CMC_VCC1V2_TOP_REG		0x68
+#define	CMC_VCC1V8_REG			0x74
+#define	CMC_VCC0V85_REG			0x80
+#define	CMC_DDR4_VPP_TOP_REG		0x8C
+#define	CMC_MGT0V9AVCC_REG		0x98
+#define	CMC_12V_SW_REG			0xA4
+#define	CMC_MGTAVTT_REG			0xB0
+#define	CMC_VCC1V2_BTM_REG		0xBC
+#define	CMC_12V_PEX_I_IN_REG		0xC8
+#define	CMC_12V_AUX_I_IN_REG		0xD4
+#define	CMC_VCCINT_V_REG		0xE0
+#define	CMC_VCCINT_I_REG		0xEC
+#define	CMC_FPGA_TEMP			0xF8
+#define	CMC_FAN_TEMP_REG		0x104
+#define	CMC_DIMM_TEMP0_REG		0x110
+#define	CMC_DIMM_TEMP1_REG		0x11C
+#define	CMC_DIMM_TEMP2_REG		0x128
+#define	CMC_DIMM_TEMP3_REG		0x134
+#define	CMC_FAN_SPEED_REG		0x164
+#define	CMC_SE98_TEMP0_REG		0x140
+#define	CMC_SE98_TEMP1_REG		0x14C
+#define	CMC_SE98_TEMP2_REG		0x158
+#define	CMC_CAGE_TEMP0_REG		0x170
+#define	CMC_CAGE_TEMP1_REG		0x17C
+#define	CMC_CAGE_TEMP2_REG		0x188
+#define	CMC_CAGE_TEMP3_REG		0x194
+#define	CMC_HBM_TEMP_REG		0x260
+#define	CMC_VCC3V3_REG			0x26C
+#define	CMC_3V3_PEX_I_REG		0x278
+#define	CMC_VCC0V85_I_REG		0x284
+#define	CMC_HBM_1V2_REG			0x290
+#define	CMC_VPP2V5_REG			0x29C
+#define	CMC_VCCINT_BRAM_REG		0x2A8
+#define	CMC_HBM_TEMP2_REG		0x2B4
+#define	CMC_12V_AUX1_REG                0x2C0
+#define	CMC_VCCINT_TEMP_REG             0x2CC
+#define	CMC_3V3_AUX_I_REG               0x2F0
+#define	CMC_HOST_MSG_OFFSET_REG		0x300
+#define	CMC_HOST_MSG_ERROR_REG		0x304
+#define	CMC_HOST_MSG_HEADER_REG		0x308
+#define	CMC_VCC1V2_I_REG                0x314
+#define	CMC_V12_IN_I_REG                0x320
+#define	CMC_V12_IN_AUX0_I_REG           0x32C
+#define	CMC_V12_IN_AUX1_I_REG           0x338
+#define	CMC_VCCAUX_REG                  0x344
+#define	CMC_VCCAUX_PMC_REG              0x350
+#define	CMC_VCCRAM_REG                  0x35C
+#define	XMC_CORE_VERSION_REG		0xC4C
+#define	XMC_OEM_ID_REG                  0xC50
+
+struct xrt_cmc_sensor {
+	struct platform_device *pdev;
+	struct cmc_reg_map reg_io;
+	struct device *hwmon_dev;
+	const char *name;
+};
+
+static inline u32
+cmc_reg_rd(struct xrt_cmc_sensor *cmc_sensor, u32 off)
+{
+	return ioread32(cmc_sensor->reg_io.crm_addr + off);
+}
+
+enum sensor_val_kind {
+	SENSOR_MAX,
+	SENSOR_AVG,
+	SENSOR_INS,
+};
+
+#define	READ_SENSOR(cmc_sensor, off, val_kind)	\
+	(cmc_reg_rd(cmc_sensor, off + sizeof(u32) * val_kind))
+
+/*
+ * Defining sysfs nodes for HWMON.
+ */
+
+#define	HWMON_INDEX(sensor, val_kind)	(sensor | (val_kind << 24))
+#define	HWMON_INDEX2SENSOR(index)	(index & 0xffffff)
+#define	HWMON_INDEX2VAL_KIND(index)	((index & ~0xffffff) >> 24)
+
+/* For voltage and current */
+static ssize_t hwmon_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	struct xrt_cmc_sensor *cmc_sensor = dev_get_drvdata(dev);
+	int index = to_sensor_dev_attr(da)->index;
+	u32 val = READ_SENSOR(cmc_sensor, HWMON_INDEX2SENSOR(index),
+		HWMON_INDEX2VAL_KIND(index));
+
+	return sprintf(buf, "%d\n", val);
+}
+#define	HWMON_VOLT_CURR_GROUP(type, id) hwmon_##type##id##_attrgroup
+#define	HWMON_VOLT_CURR_SYSFS_NODE(type, id, name, sensor)		\
+	static ssize_t type##id##_label(struct device *dev,		\
+		struct device_attribute *attr, char *buf)		\
+	{								\
+		return sprintf(buf, "%s\n", name);			\
+	}								\
+	static SENSOR_DEVICE_ATTR(type##id##_max, 0444, hwmon_show,	\
+		NULL, HWMON_INDEX(sensor, SENSOR_MAX));			\
+	static SENSOR_DEVICE_ATTR(type##id##_average, 0444, hwmon_show,	\
+		NULL, HWMON_INDEX(sensor, SENSOR_AVG));			\
+	static SENSOR_DEVICE_ATTR(type##id##_input, 0444, hwmon_show,	\
+		NULL, HWMON_INDEX(sensor, SENSOR_INS));			\
+	static SENSOR_DEVICE_ATTR(type##id##_label, 0444, type##id##_label,    \
+		NULL, HWMON_INDEX(sensor, SENSOR_INS));			\
+	static struct attribute *hwmon_##type##id##_attributes[] = {	\
+		&sensor_dev_attr_##type##id##_max.dev_attr.attr,	\
+		&sensor_dev_attr_##type##id##_average.dev_attr.attr,	\
+		&sensor_dev_attr_##type##id##_input.dev_attr.attr,	\
+		&sensor_dev_attr_##type##id##_label.dev_attr.attr,	\
+		NULL							\
+	};								\
+	static const struct attribute_group HWMON_VOLT_CURR_GROUP(type, id) = {\
+		.attrs = hwmon_##type##id##_attributes,			\
+	}
+
+/* For fan speed. */
+#define	HWMON_FAN_SPEED_GROUP(id) hwmon_fan##id##_attrgroup
+#define	HWMON_FAN_SPEED_SYSFS_NODE(id, name, sensor)			\
+	static ssize_t fan##id##_label(struct device *dev,		\
+		struct device_attribute *attr, char *buf)		\
+	{								\
+		return sprintf(buf, "%s\n", name);			\
+	}								\
+	static SENSOR_DEVICE_ATTR(fan##id##_input, 0444, hwmon_show,	\
+		NULL, HWMON_INDEX(sensor, SENSOR_INS));			\
+	static SENSOR_DEVICE_ATTR(fan##id##_label, 0444, fan##id##_label,      \
+		NULL, HWMON_INDEX(sensor, SENSOR_INS));			\
+	static struct attribute *hwmon_fan##id##_attributes[] = {	\
+		&sensor_dev_attr_fan##id##_input.dev_attr.attr,		\
+		&sensor_dev_attr_fan##id##_label.dev_attr.attr,		\
+		NULL							\
+	};								\
+	static const struct attribute_group HWMON_FAN_SPEED_GROUP(id) = {      \
+		.attrs = hwmon_fan##id##_attributes,			\
+	}
+
+/* For temperature */
+static ssize_t hwmon_temp_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	struct xrt_cmc_sensor *cmc_sensor = dev_get_drvdata(dev);
+	int index = to_sensor_dev_attr(da)->index;
+	u32 val = READ_SENSOR(cmc_sensor, HWMON_INDEX2SENSOR(index),
+		HWMON_INDEX2VAL_KIND(index));
+
+	return sprintf(buf, "%d\n", val * 1000);
+}
+#define	HWMON_TEMPERATURE_GROUP(id) hwmon_temp##id##_attrgroup
+#define	HWMON_TEMPERATURE_SYSFS_NODE(id, name, sensor)			\
+	static ssize_t temp##id##_label(struct device *dev,		\
+		struct device_attribute *attr, char *buf)		\
+	{								\
+		return sprintf(buf, "%s\n", name);			\
+	}								\
+	static SENSOR_DEVICE_ATTR(temp##id##_highest, 0444, hwmon_temp_show,   \
+		NULL, HWMON_INDEX(sensor, SENSOR_MAX));			\
+	static SENSOR_DEVICE_ATTR(temp##id##_input, 0444, hwmon_temp_show,     \
+		NULL, HWMON_INDEX(sensor, SENSOR_INS));			\
+	static SENSOR_DEVICE_ATTR(temp##id##_label, 0444, temp##id##_label,    \
+		NULL, HWMON_INDEX(sensor, SENSOR_INS));			\
+	static struct attribute *hwmon_temp##id##_attributes[] = {	\
+		&sensor_dev_attr_temp##id##_highest.dev_attr.attr,	\
+		&sensor_dev_attr_temp##id##_input.dev_attr.attr,	\
+		&sensor_dev_attr_temp##id##_label.dev_attr.attr,	\
+		NULL							\
+	};								\
+	static const struct attribute_group HWMON_TEMPERATURE_GROUP(id) = {    \
+		.attrs = hwmon_temp##id##_attributes,			\
+	}
+
+/* For power */
+uint64_t cmc_get_power(struct xrt_cmc_sensor *cmc_sensor,
+	enum sensor_val_kind kind)
+{
+	u32 v_pex, v_aux, v_3v3, c_pex, c_aux, c_3v3;
+	u64 val = 0;
+
+	v_pex = READ_SENSOR(cmc_sensor, CMC_12V_PEX_REG, kind);
+	v_aux = READ_SENSOR(cmc_sensor, CMC_12V_AUX_REG, kind);
+	v_3v3 = READ_SENSOR(cmc_sensor, CMC_3V3_PEX_REG, kind);
+	c_pex = READ_SENSOR(cmc_sensor, CMC_12V_PEX_I_IN_REG, kind);
+	c_aux = READ_SENSOR(cmc_sensor, CMC_12V_AUX_I_IN_REG, kind);
+	c_3v3 = READ_SENSOR(cmc_sensor, CMC_3V3_PEX_I_REG, kind);
+
+	val = (u64)v_pex * c_pex + (u64)v_aux * c_aux + (u64)v_3v3 * c_3v3;
+
+	return val;
+}
+static ssize_t hwmon_power_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	struct xrt_cmc_sensor *cmc_sensor = dev_get_drvdata(dev);
+	int index = to_sensor_dev_attr(da)->index;
+	u64 val = cmc_get_power(cmc_sensor, HWMON_INDEX2VAL_KIND(index));
+
+	return sprintf(buf, "%lld\n", val);
+}
+#define	HWMON_POWER_GROUP(id) hwmon_power##id##_attrgroup
+#define	HWMON_POWER_SYSFS_NODE(id, name)				\
+	static ssize_t power##id##_label(struct device *dev,		\
+		struct device_attribute *attr, char *buf)		\
+	{								\
+		return sprintf(buf, "%s\n", name);			\
+	}								\
+	static SENSOR_DEVICE_ATTR(power##id##_average, 0444, hwmon_power_show,\
+		NULL, HWMON_INDEX(0, SENSOR_MAX));			\
+	static SENSOR_DEVICE_ATTR(power##id##_input, 0444, hwmon_power_show,  \
+		NULL, HWMON_INDEX(0, SENSOR_INS));			\
+	static SENSOR_DEVICE_ATTR(power##id##_label, 0444, power##id##_label, \
+		NULL, HWMON_INDEX(0, SENSOR_INS));			\
+	static struct attribute *hwmon_power##id##_attributes[] = {	\
+		&sensor_dev_attr_power##id##_average.dev_attr.attr,	\
+		&sensor_dev_attr_power##id##_input.dev_attr.attr,	\
+		&sensor_dev_attr_power##id##_label.dev_attr.attr,	\
+		NULL							\
+	};								\
+	static const struct attribute_group HWMON_POWER_GROUP(id) = {	\
+		.attrs = hwmon_power##id##_attributes,			\
+	}
+
+HWMON_VOLT_CURR_SYSFS_NODE(in, 0, "12V PEX", CMC_12V_PEX_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 1, "12V AUX", CMC_12V_AUX_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 2, "3V3 PEX", CMC_3V3_PEX_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 3, "3V3 AUX", CMC_3V3_AUX_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 4, "5V5 SYS", CMC_SYS_5V5_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 5, "1V2 TOP", CMC_VCC1V2_TOP_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 6, "1V2 BTM", CMC_VCC1V2_BTM_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 7, "1V8 TOP", CMC_VCC1V8_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 8, "12V SW", CMC_12V_SW_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 9, "VCC INT", CMC_VCCINT_V_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 10, "0V9 MGT", CMC_MGT0V9AVCC_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 11, "0V85", CMC_VCC0V85_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 12, "MGT VTT", CMC_MGTAVTT_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 13, "DDR VPP BOTTOM", CMC_DDR4_VPP_BTM_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 14, "DDR VPP TOP", CMC_DDR4_VPP_TOP_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 15, "VCC 3V3", CMC_VCC3V3_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 16, "1V2 HBM", CMC_HBM_1V2_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 17, "2V5 VPP", CMC_VPP2V5_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(in, 18, "VCC INT BRAM", CMC_VCCINT_BRAM_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(curr, 1, "12V PEX Current", CMC_12V_PEX_I_IN_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(curr, 2, "12V AUX Current", CMC_12V_AUX_I_IN_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(curr, 3, "VCC INT Current", CMC_VCCINT_I_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(curr, 4, "3V3 PEX Current", CMC_3V3_PEX_I_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(curr, 5, "VCC 0V85 Current", CMC_VCC0V85_I_REG);
+HWMON_VOLT_CURR_SYSFS_NODE(curr, 6, "3V3 AUX Current", CMC_3V3_AUX_I_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(1, "PCB TOP FRONT", CMC_SE98_TEMP0_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(2, "PCB TOP REAR", CMC_SE98_TEMP1_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(3, "PCB BTM FRONT", CMC_SE98_TEMP2_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(4, "FPGA TEMP", CMC_FPGA_TEMP);
+HWMON_TEMPERATURE_SYSFS_NODE(5, "TCRIT TEMP", CMC_FAN_TEMP_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(6, "DIMM0 TEMP", CMC_DIMM_TEMP0_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(7, "DIMM1 TEMP", CMC_DIMM_TEMP1_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(8, "DIMM2 TEMP", CMC_DIMM_TEMP2_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(9, "DIMM3 TEMP", CMC_DIMM_TEMP3_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(10, "HBM TEMP", CMC_HBM_TEMP_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(11, "QSPF 0", CMC_CAGE_TEMP0_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(12, "QSPF 1", CMC_CAGE_TEMP1_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(13, "QSPF 2", CMC_CAGE_TEMP2_REG);
+HWMON_TEMPERATURE_SYSFS_NODE(14, "QSPF 3", CMC_CAGE_TEMP3_REG);
+HWMON_FAN_SPEED_SYSFS_NODE(1, "FAN SPEED", CMC_FAN_SPEED_REG);
+HWMON_POWER_SYSFS_NODE(1, "POWER");
+
+static const struct attribute_group *hwmon_cmc_attrgroups[] = {
+	&HWMON_VOLT_CURR_GROUP(in, 0),
+	&HWMON_VOLT_CURR_GROUP(in, 1),
+	&HWMON_VOLT_CURR_GROUP(in, 2),
+	&HWMON_VOLT_CURR_GROUP(in, 3),
+	&HWMON_VOLT_CURR_GROUP(in, 4),
+	&HWMON_VOLT_CURR_GROUP(in, 5),
+	&HWMON_VOLT_CURR_GROUP(in, 6),
+	&HWMON_VOLT_CURR_GROUP(in, 7),
+	&HWMON_VOLT_CURR_GROUP(in, 8),
+	&HWMON_VOLT_CURR_GROUP(in, 9),
+	&HWMON_VOLT_CURR_GROUP(in, 10),
+	&HWMON_VOLT_CURR_GROUP(in, 11),
+	&HWMON_VOLT_CURR_GROUP(in, 12),
+	&HWMON_VOLT_CURR_GROUP(in, 13),
+	&HWMON_VOLT_CURR_GROUP(in, 14),
+	&HWMON_VOLT_CURR_GROUP(in, 15),
+	&HWMON_VOLT_CURR_GROUP(in, 16),
+	&HWMON_VOLT_CURR_GROUP(in, 17),
+	&HWMON_VOLT_CURR_GROUP(in, 18),
+	&HWMON_VOLT_CURR_GROUP(curr, 1),
+	&HWMON_VOLT_CURR_GROUP(curr, 2),
+	&HWMON_VOLT_CURR_GROUP(curr, 3),
+	&HWMON_VOLT_CURR_GROUP(curr, 4),
+	&HWMON_VOLT_CURR_GROUP(curr, 5),
+	&HWMON_VOLT_CURR_GROUP(curr, 6),
+	&HWMON_TEMPERATURE_GROUP(1),
+	&HWMON_TEMPERATURE_GROUP(2),
+	&HWMON_TEMPERATURE_GROUP(3),
+	&HWMON_TEMPERATURE_GROUP(4),
+	&HWMON_TEMPERATURE_GROUP(5),
+	&HWMON_TEMPERATURE_GROUP(6),
+	&HWMON_TEMPERATURE_GROUP(7),
+	&HWMON_TEMPERATURE_GROUP(8),
+	&HWMON_TEMPERATURE_GROUP(9),
+	&HWMON_TEMPERATURE_GROUP(10),
+	&HWMON_TEMPERATURE_GROUP(11),
+	&HWMON_TEMPERATURE_GROUP(12),
+	&HWMON_TEMPERATURE_GROUP(13),
+	&HWMON_TEMPERATURE_GROUP(14),
+	&HWMON_FAN_SPEED_GROUP(1),
+	&HWMON_POWER_GROUP(1),
+	NULL
+};
+
+void cmc_sensor_remove(struct platform_device *pdev)
+{
+	struct xrt_cmc_sensor *cmc_sensor =
+		(struct xrt_cmc_sensor *)cmc_pdev2sensor(pdev);
+
+	BUG_ON(cmc_sensor == NULL);
+	if (cmc_sensor->hwmon_dev)
+		xrt_subdev_unregister_hwmon(pdev, cmc_sensor->hwmon_dev);
+	kfree(cmc_sensor->name);
+}
+
+static const char *cmc_get_vbnv(struct xrt_cmc_sensor *cmc_sensor)
+{
+	int ret;
+	const char *vbnv;
+	struct platform_device *mgmt_leaf =
+		xrt_subdev_get_leaf_by_id(cmc_sensor->pdev,
+		XRT_SUBDEV_MGMT_MAIN, PLATFORM_DEVID_NONE);
+
+	if (mgmt_leaf == NULL)
+		return NULL;
+
+	ret = xrt_subdev_ioctl(mgmt_leaf, XRT_MGMT_MAIN_GET_VBNV, &vbnv);
+	(void) xrt_subdev_put_leaf(cmc_sensor->pdev, mgmt_leaf);
+	if (ret)
+		return NULL;
+	return vbnv;
+}
+
+int cmc_sensor_probe(struct platform_device *pdev,
+	struct cmc_reg_map *regmaps, void **hdl)
+{
+	struct xrt_cmc_sensor *cmc_sensor;
+	const char *vbnv;
+
+	cmc_sensor = devm_kzalloc(DEV(pdev), sizeof(*cmc_sensor), GFP_KERNEL);
+	if (!cmc_sensor)
+		return -ENOMEM;
+
+	cmc_sensor->pdev = pdev;
+	/* Obtain register maps we need to read sensor values. */
+	cmc_sensor->reg_io = regmaps[IO_REG];
+
+	cmc_sensor->name = cmc_get_vbnv(cmc_sensor);
+	vbnv = cmc_sensor->name ? cmc_sensor->name : "golden-image";
+	/*
+	 * Make a parent call to ask root to register. If we register using
+	 * platform device, we'll be treated as ISA device, not PCI device.
+	 */
+	cmc_sensor->hwmon_dev = xrt_subdev_register_hwmon(pdev,
+		vbnv, cmc_sensor, hwmon_cmc_attrgroups);
+	if (cmc_sensor->hwmon_dev == NULL)
+		xrt_err(pdev, "failed to create HWMON device");
+
+	*hdl = cmc_sensor;
+	return 0;
+}
+
+void cmc_sensor_read(struct platform_device *pdev, struct xcl_sensor *s)
+{
+#define	READ_INST_SENSOR(off)	READ_SENSOR(cmc_sensor, off, SENSOR_INS)
+	struct xrt_cmc_sensor *cmc_sensor =
+		(struct xrt_cmc_sensor *)cmc_pdev2sensor(pdev);
+
+	s->vol_12v_pex = READ_INST_SENSOR(CMC_12V_PEX_REG);
+	s->vol_12v_aux = READ_INST_SENSOR(CMC_12V_AUX_REG);
+	s->cur_12v_pex = READ_INST_SENSOR(CMC_12V_PEX_I_IN_REG);
+	s->cur_12v_aux = READ_INST_SENSOR(CMC_12V_AUX_I_IN_REG);
+	s->vol_3v3_pex = READ_INST_SENSOR(CMC_3V3_PEX_REG);
+	s->vol_3v3_aux = READ_INST_SENSOR(CMC_3V3_AUX_REG);
+	s->cur_3v3_aux = READ_INST_SENSOR(CMC_3V3_AUX_I_REG);
+	s->ddr_vpp_btm = READ_INST_SENSOR(CMC_DDR4_VPP_BTM_REG);
+	s->sys_5v5 = READ_INST_SENSOR(CMC_SYS_5V5_REG);
+	s->top_1v2 = READ_INST_SENSOR(CMC_VCC1V2_TOP_REG);
+	s->vol_1v8 = READ_INST_SENSOR(CMC_VCC1V8_REG);
+	s->vol_0v85 = READ_INST_SENSOR(CMC_VCC0V85_REG);
+	s->ddr_vpp_top = READ_INST_SENSOR(CMC_DDR4_VPP_TOP_REG);
+	s->mgt0v9avcc = READ_INST_SENSOR(CMC_MGT0V9AVCC_REG);
+	s->vol_12v_sw = READ_INST_SENSOR(CMC_12V_SW_REG);
+	s->mgtavtt = READ_INST_SENSOR(CMC_MGTAVTT_REG);
+	s->vcc1v2_btm = READ_INST_SENSOR(CMC_VCC1V2_BTM_REG);
+	s->fpga_temp = READ_INST_SENSOR(CMC_FPGA_TEMP);
+	s->fan_temp = READ_INST_SENSOR(CMC_FAN_TEMP_REG);
+	s->fan_rpm = READ_INST_SENSOR(CMC_FAN_SPEED_REG);
+	s->dimm_temp0 = READ_INST_SENSOR(CMC_DIMM_TEMP0_REG);
+	s->dimm_temp1 = READ_INST_SENSOR(CMC_DIMM_TEMP1_REG);
+	s->dimm_temp2 = READ_INST_SENSOR(CMC_DIMM_TEMP2_REG);
+	s->dimm_temp3 = READ_INST_SENSOR(CMC_DIMM_TEMP3_REG);
+	s->vccint_vol = READ_INST_SENSOR(CMC_VCCINT_V_REG);
+	s->vccint_curr = READ_INST_SENSOR(CMC_VCCINT_I_REG);
+	s->se98_temp0 = READ_INST_SENSOR(CMC_SE98_TEMP0_REG);
+	s->se98_temp1 = READ_INST_SENSOR(CMC_SE98_TEMP1_REG);
+	s->se98_temp2 = READ_INST_SENSOR(CMC_SE98_TEMP2_REG);
+	s->cage_temp0 = READ_INST_SENSOR(CMC_CAGE_TEMP0_REG);
+	s->cage_temp1 = READ_INST_SENSOR(CMC_CAGE_TEMP1_REG);
+	s->cage_temp2 = READ_INST_SENSOR(CMC_CAGE_TEMP2_REG);
+	s->cage_temp3 = READ_INST_SENSOR(CMC_CAGE_TEMP3_REG);
+	s->hbm_temp0 = READ_INST_SENSOR(CMC_HBM_TEMP_REG);
+	s->cur_3v3_pex = READ_INST_SENSOR(CMC_3V3_PEX_I_REG);
+	s->cur_0v85 = READ_INST_SENSOR(CMC_VCC0V85_I_REG);
+	s->vol_3v3_vcc = READ_INST_SENSOR(CMC_VCC3V3_REG);
+	s->vol_1v2_hbm = READ_INST_SENSOR(CMC_HBM_1V2_REG);
+	s->vol_2v5_vpp = READ_INST_SENSOR(CMC_VPP2V5_REG);
+	s->vccint_bram = READ_INST_SENSOR(CMC_VCCINT_BRAM_REG);
+	s->version = cmc_reg_rd(cmc_sensor, XMC_CORE_VERSION_REG);
+	s->oem_id = cmc_reg_rd(cmc_sensor, XMC_OEM_ID_REG);
+	s->vccint_temp = READ_INST_SENSOR(CMC_VCCINT_TEMP_REG);
+	s->vol_12v_aux1 = READ_INST_SENSOR(CMC_12V_AUX1_REG);
+	s->vol_vcc1v2_i = READ_INST_SENSOR(CMC_VCC1V2_I_REG);
+	s->vol_v12_in_i = READ_INST_SENSOR(CMC_V12_IN_I_REG);
+	s->vol_v12_in_aux0_i = READ_INST_SENSOR(CMC_V12_IN_AUX0_I_REG);
+	s->vol_v12_in_aux1_i = READ_INST_SENSOR(CMC_V12_IN_AUX1_I_REG);
+	s->vol_vccaux = READ_INST_SENSOR(CMC_VCCAUX_REG);
+	s->vol_vccaux_pmc = READ_INST_SENSOR(CMC_VCCAUX_PMC_REG);
+	s->vol_vccram = READ_INST_SENSOR(CMC_VCCRAM_REG);
+}
+
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-cmc.c b/drivers/fpga/alveo/lib/subdevs/xrt-cmc.c
new file mode 100644
index 000000000000..476c91650cfd
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-cmc.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA CMC Leaf Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-cmc-impl.h"
+#include "xrt-cmc.h"
+#include <linux/xrt/mailbox_proto.h>
+
+#define	XRT_CMC "xrt_cmc"
+
+static struct xrt_iores_map cmc_iores_id_map[] = {
+	{ NODE_CMC_REG, IO_REG},
+	{ NODE_CMC_RESET, IO_GPIO},
+	{ NODE_CMC_FW_MEM, IO_IMAGE_MGMT},
+	{ NODE_CMC_MUTEX, IO_MUTEX},
+};
+
+struct xrt_cmc {
+	struct platform_device *pdev;
+	struct cmc_reg_map regs[NUM_IOADDR];
+	void *ctrl_hdl;
+	void *sensor_hdl;
+	void *mbx_hdl;
+	void *bdinfo_hdl;
+	void *sc_hdl;
+};
+
+void *cmc_pdev2sc(struct platform_device *pdev)
+{
+	struct xrt_cmc *cmc = platform_get_drvdata(pdev);
+
+	return cmc->sc_hdl;
+}
+
+void *cmc_pdev2bdinfo(struct platform_device *pdev)
+{
+	struct xrt_cmc *cmc = platform_get_drvdata(pdev);
+
+	return cmc->bdinfo_hdl;
+}
+
+void *cmc_pdev2ctrl(struct platform_device *pdev)
+{
+	struct xrt_cmc *cmc = platform_get_drvdata(pdev);
+
+	return cmc->ctrl_hdl;
+}
+
+void *cmc_pdev2sensor(struct platform_device *pdev)
+{
+	struct xrt_cmc *cmc = platform_get_drvdata(pdev);
+
+	return cmc->sensor_hdl;
+}
+
+void *cmc_pdev2mbx(struct platform_device *pdev)
+{
+	struct xrt_cmc *cmc = platform_get_drvdata(pdev);
+
+	return cmc->mbx_hdl;
+}
+
+static int cmc_map_io(struct xrt_cmc *cmc, struct resource *res)
+{
+	int	id;
+
+	id = xrt_md_res_name2id(cmc_iores_id_map, ARRAY_SIZE(cmc_iores_id_map),
+		res->name);
+	if (id < 0) {
+		xrt_err(cmc->pdev, "resource %s ignored", res->name);
+		return -EINVAL;
+	}
+	if (cmc->regs[id].crm_addr) {
+		xrt_err(cmc->pdev, "resource %s already mapped", res->name);
+		return -EINVAL;
+	}
+	cmc->regs[id].crm_addr = ioremap(res->start, res->end - res->start + 1);
+	if (!cmc->regs[id].crm_addr) {
+		xrt_err(cmc->pdev, "resource %s map failed", res->name);
+		return -EIO;
+	}
+	cmc->regs[id].crm_size = res->end - res->start + 1;
+
+	return 0;
+}
+
+static int cmc_remove(struct platform_device *pdev)
+{
+	int i;
+	struct xrt_cmc *cmc = platform_get_drvdata(pdev);
+
+	xrt_info(pdev, "leaving...");
+
+	cmc_sc_remove(pdev);
+	cmc_bdinfo_remove(pdev);
+	cmc_mailbox_remove(pdev);
+	cmc_sensor_remove(pdev);
+	cmc_ctrl_remove(pdev);
+
+	for (i = 0; i < NUM_IOADDR; i++) {
+		if (cmc->regs[i].crm_addr == NULL)
+			continue;
+		iounmap(cmc->regs[i].crm_addr);
+	}
+
+	return 0;
+}
+
+static int cmc_probe(struct platform_device *pdev)
+{
+	struct xrt_cmc *cmc;
+	struct resource *res;
+	int i = 0;
+	int ret = 0;
+
+	xrt_info(pdev, "probing...");
+
+	cmc = devm_kzalloc(DEV(pdev), sizeof(*cmc), GFP_KERNEL);
+	if (!cmc)
+		return -ENOMEM;
+
+	cmc->pdev = pdev;
+	platform_set_drvdata(pdev, cmc);
+
+	for (i = 0; ; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
+		(void) cmc_map_io(cmc, res);
+	}
+	for (i = 0; i < NUM_IOADDR; i++) {
+		if (cmc->regs[i].crm_addr == NULL)
+			break;
+	}
+	if (i != NUM_IOADDR) {
+		xrt_err(cmc->pdev, "not all needed resources are found");
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = cmc_ctrl_probe(cmc->pdev, cmc->regs, &cmc->ctrl_hdl);
+	if (ret)
+		goto done;
+
+	/* Non-critical part of init can fail. */
+	(void) cmc_sensor_probe(cmc->pdev, cmc->regs, &cmc->sensor_hdl);
+	(void) cmc_mailbox_probe(cmc->pdev, cmc->regs, &cmc->mbx_hdl);
+	(void) cmc_bdinfo_probe(cmc->pdev, cmc->regs, &cmc->bdinfo_hdl);
+	(void) cmc_sc_probe(cmc->pdev, cmc->regs, &cmc->sc_hdl);
+
+	return 0;
+
+done:
+	(void) cmc_remove(pdev);
+	return ret;
+}
+
+static int
+xrt_cmc_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_cmc *cmc = platform_get_drvdata(pdev);
+	int ret = -ENOENT;
+
+	switch (cmd) {
+	case XRT_CMC_READ_BOARD_INFO: {
+		struct xcl_board_info *i = (struct xcl_board_info *)arg;
+
+		if (cmc->bdinfo_hdl)
+			ret = cmc_bdinfo_read(pdev, i);
+		break;
+	}
+	case XRT_CMC_READ_SENSORS: {
+		struct xcl_sensor *s = (struct xcl_sensor *)arg;
+
+		if (cmc->sensor_hdl) {
+			cmc_sensor_read(pdev, s);
+			ret = 0;
+		}
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_cmc_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []) {
+			{ .ep_name = NODE_CMC_REG },
+			{ .ep_name = NODE_CMC_RESET },
+			{ .ep_name = NODE_CMC_MUTEX },
+			{ .ep_name = NODE_CMC_FW_MEM },
+			{ NULL },
+		},
+		.xse_min_ep = 4,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_cmc_data = {
+	.xsd_file_ops = {
+		.xsf_ops = {
+			.owner = THIS_MODULE,
+			.open = cmc_sc_open,
+			.release = cmc_sc_close,
+			.llseek = cmc_sc_llseek,
+			.write = cmc_update_sc_firmware,
+		},
+		.xsf_dev_name = "cmc",
+	},
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_cmc_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id cmc_id_table[] = {
+	{ XRT_CMC, (kernel_ulong_t)&xrt_cmc_data },
+	{ },
+};
+
+struct platform_driver xrt_cmc_driver = {
+	.driver	= {
+		.name    = XRT_CMC,
+	},
+	.probe   = cmc_probe,
+	.remove  = cmc_remove,
+	.id_table = cmc_id_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-gpio.c b/drivers/fpga/alveo/lib/subdevs/xrt-gpio.c
new file mode 100644
index 000000000000..72c9c4ab970f
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-gpio.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA GPIO Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-gpio.h"
+
+#define XRT_GPIO "xrt_gpio"
+
+struct xrt_name_id {
+	char *ep_name;
+	int id;
+};
+
+static struct xrt_name_id name_id[XRT_GPIO_MAX] = {
+	{ NODE_BLP_ROM, XRT_GPIO_ROM_UUID },
+	{ NODE_GOLDEN_VER, XRT_GPIO_GOLDEN_VER },
+};
+
+struct xrt_gpio {
+	struct platform_device	*pdev;
+	void		__iomem *base_addrs[XRT_GPIO_MAX];
+	ulong			sizes[XRT_GPIO_MAX];
+};
+
+static int xrt_gpio_name2id(struct xrt_gpio *gpio, const char *name)
+{
+	int	i;
+
+	for (i = 0; i < XRT_GPIO_MAX && name_id[i].ep_name; i++) {
+		if (!strncmp(name_id[i].ep_name, name,
+		    strlen(name_id[i].ep_name) + 1))
+			return name_id[i].id;
+	}
+
+	return -EINVAL;
+}
+
+static int
+xrt_gpio_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_gpio	*gpio;
+	int			ret = 0;
+
+	gpio = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_GPIO_READ: {
+		struct xrt_gpio_ioctl_rw	*rw_arg = arg;
+		u32				*p_src, *p_dst, i;
+
+		if (rw_arg->xgir_len & 0x3) {
+			xrt_err(pdev, "invalid len %d", rw_arg->xgir_len);
+			return -EINVAL;
+		}
+
+		if (rw_arg->xgir_id >= XRT_GPIO_MAX) {
+			xrt_err(pdev, "invalid id %d", rw_arg->xgir_id);
+			return -EINVAL;
+		}
+
+		p_src = gpio->base_addrs[rw_arg->xgir_id];
+		if (!p_src) {
+			xrt_err(pdev, "io not found, id %d",
+				rw_arg->xgir_id);
+			return -EINVAL;
+		}
+		if (rw_arg->xgir_offset + rw_arg->xgir_len >
+		    gpio->sizes[rw_arg->xgir_id]) {
+			xrt_err(pdev, "invalid argument, off %d, len %d",
+				rw_arg->xgir_offset, rw_arg->xgir_len);
+			return -EINVAL;
+		}
+		p_dst = rw_arg->xgir_buf;
+		for (i = 0; i < rw_arg->xgir_len / sizeof(u32); i++) {
+			u32 val = ioread32(p_src + rw_arg->xgir_offset + i);
+
+			memcpy(p_dst + i, &val, sizeof(u32));
+		}
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_gpio_remove(struct platform_device *pdev)
+{
+	struct xrt_gpio	*gpio;
+	int			i;
+
+	gpio = platform_get_drvdata(pdev);
+
+	for (i = 0; i < XRT_GPIO_MAX; i++) {
+		if (gpio->base_addrs[i])
+			iounmap(gpio->base_addrs[i]);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, gpio);
+
+	return 0;
+}
+
+static int xrt_gpio_probe(struct platform_device *pdev)
+{
+	struct xrt_gpio	*gpio;
+	int			i, id, ret = 0;
+	struct resource		*res;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	gpio->pdev = pdev;
+	platform_set_drvdata(pdev, gpio);
+
+	xrt_info(pdev, "probing...");
+	for (i = 0, res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	    res;
+	    res = platform_get_resource(pdev, IORESOURCE_MEM, ++i)) {
+		id = xrt_gpio_name2id(gpio, res->name);
+		if (id < 0) {
+			xrt_err(pdev, "ep %s not found", res->name);
+			continue;
+		}
+		gpio->base_addrs[id] = ioremap(res->start,
+			res->end - res->start + 1);
+		if (!gpio->base_addrs[id]) {
+			xrt_err(pdev, "map base failed %pR", res);
+			ret = -EIO;
+			goto failed;
+		}
+		gpio->sizes[id] = res->end - res->start + 1;
+	}
+
+failed:
+	if (ret)
+		xrt_gpio_remove(pdev);
+
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_gpio_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			/* add name if ep is in same partition */
+			{ .ep_name = NODE_BLP_ROM },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = NODE_GOLDEN_VER },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	/* adding ep bundle generates gpio device instance */
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_gpio_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_gpio_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_gpio_table[] = {
+	{ XRT_GPIO, (kernel_ulong_t)&xrt_gpio_data },
+	{ },
+};
+
+struct platform_driver xrt_gpio_driver = {
+	.driver = {
+		.name = XRT_GPIO,
+	},
+	.probe = xrt_gpio_probe,
+	.remove = xrt_gpio_remove,
+	.id_table = xrt_gpio_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-icap.c b/drivers/fpga/alveo/lib/subdevs/xrt-icap.c
new file mode 100644
index 000000000000..636429d665c3
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-icap.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA ICAP Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-icap.h"
+#include "xrt-xclbin.h"
+
+#define XRT_ICAP "xrt_icap"
+
+#define	ICAP_ERR(icap, fmt, arg...)	\
+	xrt_err((icap)->pdev, fmt "\n", ##arg)
+#define	ICAP_WARN(icap, fmt, arg...)	\
+	xrt_warn((icap)->pdev, fmt "\n", ##arg)
+#define	ICAP_INFO(icap, fmt, arg...)	\
+	xrt_info((icap)->pdev, fmt "\n", ##arg)
+#define	ICAP_DBG(icap, fmt, arg...)	\
+	xrt_dbg((icap)->pdev, fmt "\n", ##arg)
+
+/*
+ * AXI-HWICAP IP register layout
+ */
+struct icap_reg {
+	u32	ir_rsvd1[7];
+	u32	ir_gier;
+	u32	ir_isr;
+	u32	ir_rsvd2;
+	u32	ir_ier;
+	u32	ir_rsvd3[53];
+	u32	ir_wf;
+	u32	ir_rf;
+	u32	ir_sz;
+	u32	ir_cr;
+	u32	ir_sr;
+	u32	ir_wfv;
+	u32	ir_rfo;
+	u32	ir_asr;
+} __packed;
+
+struct icap {
+	struct platform_device	*pdev;
+	struct icap_reg		*icap_regs;
+	struct mutex		icap_lock;
+
+	unsigned int		idcode;
+};
+
+static inline u32 reg_rd(void __iomem *reg)
+{
+	if (!reg)
+		return -1;
+
+	return ioread32(reg);
+}
+
+static inline void reg_wr(void __iomem *reg, u32 val)
+{
+	if (!reg)
+		return;
+
+	iowrite32(val, reg);
+}
+
+static int wait_for_done(struct icap *icap)
+{
+	u32	w;
+	int	i = 0;
+
+	BUG_ON(!mutex_is_locked(&icap->icap_lock));
+	for (i = 0; i < 10; i++) {
+		udelay(5);
+		w = reg_rd(&icap->icap_regs->ir_sr);
+		ICAP_INFO(icap, "XHWICAP_SR: %x", w);
+		if (w & 0x5)
+			return 0;
+	}
+
+	ICAP_ERR(icap, "bitstream download timeout");
+	return -ETIMEDOUT;
+}
+
+static int icap_write(struct icap *icap, const u32 *word_buf, int size)
+{
+	int i;
+	u32 value = 0;
+
+	for (i = 0; i < size; i++) {
+		value = be32_to_cpu(word_buf[i]);
+		reg_wr(&icap->icap_regs->ir_wf, value);
+	}
+
+	reg_wr(&icap->icap_regs->ir_cr, 0x1);
+
+	for (i = 0; i < 20; i++) {
+		value = reg_rd(&icap->icap_regs->ir_cr);
+		if ((value & 0x1) == 0)
+			return 0;
+		ndelay(50);
+	}
+
+	ICAP_ERR(icap, "writing %d dwords timeout", size);
+	return -EIO;
+}
+
+static int bitstream_helper(struct icap *icap, const u32 *word_buffer,
+	u32 word_count)
+{
+	u32 remain_word;
+	u32 word_written = 0;
+	int wr_fifo_vacancy = 0;
+	int err = 0;
+
+	BUG_ON(!mutex_is_locked(&icap->icap_lock));
+	for (remain_word = word_count; remain_word > 0;
+		remain_word -= word_written, word_buffer += word_written) {
+		wr_fifo_vacancy = reg_rd(&icap->icap_regs->ir_wfv);
+		if (wr_fifo_vacancy <= 0) {
+			ICAP_ERR(icap, "no vacancy: %d", wr_fifo_vacancy);
+			err = -EIO;
+			break;
+		}
+		word_written = (wr_fifo_vacancy < remain_word) ?
+			wr_fifo_vacancy : remain_word;
+		if (icap_write(icap, word_buffer, word_written) != 0) {
+			ICAP_ERR(icap, "write failed remain %d, written %d",
+					remain_word, word_written);
+			err = -EIO;
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int icap_download(struct icap *icap, const char *buffer,
+	unsigned long length)
+{
+	u32	numCharsRead = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+	u32	byte_read;
+	int	err = 0;
+
+	mutex_lock(&icap->icap_lock);
+	for (byte_read = 0; byte_read < length; byte_read += numCharsRead) {
+		numCharsRead = length - byte_read;
+		if (numCharsRead > DMA_HWICAP_BITFILE_BUFFER_SIZE)
+			numCharsRead = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+
+		err = bitstream_helper(icap, (u32 *)buffer,
+			numCharsRead / sizeof(u32));
+		if (err)
+			goto failed;
+		buffer += numCharsRead;
+	}
+
+	err = wait_for_done(icap);
+
+failed:
+	mutex_unlock(&icap->icap_lock);
+
+	return err;
+}
+
+/*
+ * Run the following sequence of canned commands to obtain IDCODE of the FPGA
+ */
+static void icap_probe_chip(struct icap *icap)
+{
+	u32 w;
+
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	reg_wr(&icap->icap_regs->ir_gier, 0x0);
+	w = reg_rd(&icap->icap_regs->ir_wfv);
+	reg_wr(&icap->icap_regs->ir_wf, 0xffffffff);
+	reg_wr(&icap->icap_regs->ir_wf, 0xaa995566);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x28018001);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	reg_wr(&icap->icap_regs->ir_cr, 0x1);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	reg_wr(&icap->icap_regs->ir_sz, 0x1);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	reg_wr(&icap->icap_regs->ir_cr, 0x2);
+	w = reg_rd(&icap->icap_regs->ir_rfo);
+	icap->idcode = reg_rd(&icap->icap_regs->ir_rf);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+}
+
+static int
+xrt_icap_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_icap_ioctl_wr	*wr_arg = arg;
+	struct icap			*icap;
+	int				ret = 0;
+
+	icap = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_ICAP_WRITE:
+		ret = icap_download(icap, wr_arg->xiiw_bit_data,
+				wr_arg->xiiw_data_len);
+		break;
+	case XRT_ICAP_IDCODE:
+		*(u64 *)arg = icap->idcode;
+		break;
+	default:
+		ICAP_ERR(icap, "unknown command %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_icap_remove(struct platform_device *pdev)
+{
+	struct icap	*icap;
+
+	icap = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, icap);
+
+	return 0;
+}
+
+static int xrt_icap_probe(struct platform_device *pdev)
+{
+	struct icap	*icap;
+	int			ret = 0;
+	struct resource		*res;
+
+	icap = devm_kzalloc(&pdev->dev, sizeof(*icap), GFP_KERNEL);
+	if (!icap)
+		return -ENOMEM;
+
+	icap->pdev = pdev;
+	platform_set_drvdata(pdev, icap);
+	mutex_init(&icap->icap_lock);
+
+	xrt_info(pdev, "probing");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res != NULL) {
+		icap->icap_regs = ioremap(res->start,
+			res->end - res->start + 1);
+		if (!icap->icap_regs) {
+			xrt_err(pdev, "map base failed %pR", res);
+			ret = -EIO;
+			goto failed;
+		}
+	}
+
+	icap_probe_chip(icap);
+failed:
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_icap_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = NODE_FPGA_CONFIG },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_icap_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_icap_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_icap_table[] = {
+	{ XRT_ICAP, (kernel_ulong_t)&xrt_icap_data },
+	{ },
+};
+
+struct platform_driver xrt_icap_driver = {
+	.driver = {
+		.name = XRT_ICAP,
+	},
+	.probe = xrt_icap_probe,
+	.remove = xrt_icap_remove,
+	.id_table = xrt_icap_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c b/drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c
new file mode 100644
index 000000000000..3d1b9bcb29b5
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c
@@ -0,0 +1,1905 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Mailbox IP Leaf Driver
+ *
+ * Copyright (C) 2016-2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+/**
+ * DOC: Statement of Theory
+ *
+ * This is the mailbox sub-device driver added to xrt drivers so that user pf
+ * and mgmt pf can send and receive messages of arbitrary length to / from its
+ * peer. The driver is written based on the spec of PG114 document
+ * (https://www.xilinx.com/support/documentation/ip_documentation/mailbox/v2_1/
+ * pg114-mailbox.pdf). The HW provides one TX channel and one RX channel, which
+ * operate completely independent of each other. Data can be pushed into or read
+ * from a channel in DWORD unit as a FIFO.
+ *
+ *
+ * Packet layer
+ *
+ * The driver implemented two transport layers - packet and message layer (see
+ * below). A packet is a fixed size chunk of data that can be sent through TX
+ * channel or retrieved from RX channel. The driver will not attempt to send
+ * next packet until the previous one is read by peer. Similarly, the driver
+ * will not attempt to read the data from HW until a full packet has been
+ * written to HW by peer.
+ *
+ * Interrupt is not enabled and driver will poll the HW periodically to see if
+ * FIFO is ready for reading or writing. When there is outstanding msg to be
+ * sent or received, driver will poll at high frequency. Otherwise, driver polls
+ * HW at very low frequency so that it will not consume much CPU cycles.
+ *
+ * A packet is defined as struct mailbox_pkt. There are mainly two types of
+ * packets: start-of-msg and msg-body packets. Both can carry end-of-msg flag to
+ * indicate that the packet is the last one in the current msg.
+ *
+ * The start-of-msg packet contains some meta data related to the entire msg,
+ * such as msg ID, msg flags and msg size. Strictly speaking, these info belongs
+ * to the msg layer, but it helps the receiving end to prepare buffer for the
+ * incoming msg payload after seeing the 1st packet instead of the whole msg.
+ * It is an optimization for msg receiving.
+ *
+ * The body-of-msg packet contains only msg payload.
+ *
+ *
+ * Message layer
+ *
+ * A message is a data buffer of arbitrary length. The driver will break a
+ * message into multiple packets and transmit them to the peer, which, in turn,
+ * will assemble them into a full message before it's delivered to upper layer
+ * for further processing. One message requires at least one packet to be
+ * transferred to the peer (a start-of-msg packet with end-of-msg flag).
+ *
+ * Each message has a unique temporary u64 ID (see communication model below
+ * for more detail). The ID shows up in start-of-msg packet only. So, at packet
+ * layer, there is an assumption that adjacent packets belong to the same
+ * message unless the next one is another start-of-msg packet. So, at message
+ * layer, the driver will not attempt to send the next message until the
+ * transmitting of current one is done. I.E., we implement a FIFO for message
+ * TX channel. All messages are sent by driver in the order of received from
+ * upper layer. We can implement msgs of different priority later, if needed.
+ *
+ * On the RX side, there is no certain order for receiving messages. It's up to
+ * the peer to decide which message gets enqueued into its own TX queue first,
+ * which will be received first on the other side.
+ *
+ * A TX message is considered as time'd out when it's transmit is not done
+ * within 1 seconds. An RX msg is considered as time'd out 20 seconds after the
+ * corresponding TX one has been sent out. There is no retry after msg time'd
+ * out. The error will be simply propagated back to the upper layer.
+ *
+ * A msg is defined as struct mailbox_msg. It carrys a flag indicating that if
+ * it's a msg of request or response msg. A response msg must have a big enough
+ * msg buffer sitting in the receiver's RX queue waiting for it. A request msg
+ * does not have a waiting msg buffer.
+ *
+ *
+ * Communication layer
+ *
+ * At the highest layer, the driver implements a request-response communication
+ * model. Three types of msgs can be sent/received in this model:
+ *
+ * - A request msg which requires a response.
+ * - A notification msg which does not require a response.
+ * - A response msg which is used to respond a request.
+ *
+ * The OP code of the request determines whether it's a request or notification.
+ *
+ * A request buffer or response buffer will be wrapped with a single msg. This
+ * means that a session contains at most 2 msgs and the msg ID serves as the
+ * session ID.
+ *
+ * A request or notification msg will automatically be assigned a msg ID when
+ * it's enqueued into TX channel for transmitting. A response msg must match a
+ * request msg by msg ID, or it'll be silently dropped. A communication session
+ * starts with a request and finishes with 0 or 1 reponse, always.
+ *
+ * Currently, the driver implements one kernel thread for RX channel (RX thread)
+ * , one for TX channel (TX thread) and one thread for processing incoming
+ * request (REQ thread).
+ *
+ * The RX thread is responsible for receiving incoming msgs. If it's a request
+ * or notification msg, it'll punt it to REQ thread for processing, which, in
+ * turn, will call the callback provided by mgmt pf driver or user pf driver to
+ * further process it. If it's a response, it'll simply wake up the waiting
+ * thread.
+ *
+ * The TX thread is responsible for sending out msgs. When it's done, the TX
+ * thread will simply wake up the waiting thread.
+ *
+ *
+ * Software communication channel
+ *
+ * A msg can be sent or received through HW mailbox channel or through a daemon
+ * implemented in user land (software communication daemon). The daemon waiting
+ * for sending msg from user pf to mgmt pf is called MPD. The other one is MSD,
+ * which is responsible for sending msg from mgmt pf to user pf.
+ *
+ * Each mailbox subdevice driver creates a device node under /dev. A daemon
+ * (MPD or MSD) can block and wait in the read() interface waiting for fetching
+ * out-going msg sent to peer. Or it can block and wait in the poll()/select()
+ * interface and will be woken up when there is an out-going msg ready to be
+ * sent. Then it can fetch the msg via read() interface. It's entirely up to the
+ * daemon to process the msg. It may pass it through to the peer or handle it
+ * completely in its own way.
+ *
+ * If the daemon wants to pass a msg (request or response) to a mailbox driver,
+ * it can do so by calling write() driver interface. It may block and wait until
+ * the previous msg is consumed by the RX thread before it can finish
+ * transmiting its own msg and return back to user land.
+ *
+ *
+ * Communication protocols
+ *
+ * As indicated above, the packet layer and msg layer communication protocol is
+ * defined as struct mailbox_pkt and struct mailbox_msg respectively in this
+ * file. The protocol for communicating at communication layer is defined in
+ * mailbox_proto.h.
+ *
+ * The software communication channel communicates at communication layer only,
+ * which sees only request and response buffers. It should only implement the
+ * protocol defined in mailbox_proto.h.
+ *
+ * The current protocol defined at communication layer followed a rule as below:
+ * All requests initiated from user pf requires a response and all requests from
+ * mgmt pf does not require a response. This should avoid any possible deadlock
+ * derived from each side blocking and waiting for response from the peer.
+ *
+ * The overall architecture can be shown as below::
+ *
+ *             +----------+      +----------+            +----------+
+ *             [ Req/Resp ]  <---[SW Channel]---->       [ Req/Resp ]
+ *       +-----+----------+      +----------+      +-----+----------+
+ *       [ Msg | Req/Resp ]                        [ Msg | Req/Resp ]
+ *       +---+-+------+---+      +----------+      +---+-+-----+----+
+ *       [Pkt]...[]...[Pkt]  <---[HW Channel]----> [Pkt]...[]...[Pkt]
+ *       +---+        +---+      +----------+      +---+        +---+
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/list.h>
+#include <linux/poll.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/ioctl.h>
+#include <linux/delay.h>
+#include <linux/crc32c.h>
+#include <linux/xrt/mailbox_transport.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-mailbox.h"
+#include "xmgmt-main.h"
+
+#define	FLAG_STI	(1 << 0)
+#define	FLAG_RTI	(1 << 1)
+
+#define	STATUS_EMPTY	(1 << 0)
+#define	STATUS_FULL	(1 << 1)
+#define	STATUS_STA	(1 << 2)
+#define	STATUS_RTA	(1 << 3)
+#define	STATUS_VALID	(STATUS_EMPTY|STATUS_FULL|STATUS_STA|STATUS_RTA)
+
+#define	MBX_ERR(mbx, fmt, arg...) xrt_err(mbx->mbx_pdev, fmt "\n", ##arg)
+#define	MBX_WARN(mbx, fmt, arg...) xrt_warn(mbx->mbx_pdev, fmt "\n", ##arg)
+#define	MBX_INFO(mbx, fmt, arg...) xrt_info(mbx->mbx_pdev, fmt "\n", ##arg)
+#define	MBX_DBG(mbx, fmt, arg...) xrt_dbg(mbx->mbx_pdev, fmt "\n", ##arg)
+
+#define	MAILBOX_TTL_TIMER	(HZ / 10) /* in jiffies */
+#define	MAILBOX_SEC2TTL(s)	((s) * HZ / MAILBOX_TTL_TIMER)
+#define	MSG_MAX_TTL		INT_MAX /* used to disable TTL checking */
+
+#define	INVALID_MSG_ID		((u64)-1)
+
+#define	MAX_MSG_QUEUE_LEN	5
+#define	MAX_REQ_MSG_SZ		(1024 * 1024)
+
+#define MBX_SW_ONLY(mbx) ((mbx)->mbx_regs == NULL)
+/*
+ * Mailbox IP register layout
+ */
+struct mailbox_reg {
+	u32			mbr_wrdata;
+	u32			mbr_resv1;
+	u32			mbr_rddata;
+	u32			mbr_resv2;
+	u32			mbr_status;
+	u32			mbr_error;
+	u32			mbr_sit;
+	u32			mbr_rit;
+	u32			mbr_is;
+	u32			mbr_ie;
+	u32			mbr_ip;
+	u32			mbr_ctrl;
+} __packed;
+
+/*
+ * A message transport by mailbox.
+ */
+#define MSG_FLAG_RESPONSE	(1 << 0)
+#define MSG_FLAG_REQUEST	(1 << 1)
+struct mailbox_msg {
+	struct list_head	mbm_list;
+	struct mailbox_channel	*mbm_ch;
+	u64			mbm_req_id;
+	char			*mbm_data;
+	size_t			mbm_len;
+	int			mbm_error;
+	struct completion	mbm_complete;
+	mailbox_msg_cb_t	mbm_cb;
+	void			*mbm_cb_arg;
+	u32			mbm_flags;
+	atomic_t		mbm_ttl;
+	bool			mbm_chan_sw;
+
+	/* Statistics for debugging. */
+	u64			mbm_num_pkts;
+	u64			mbm_start_ts;
+	u64			mbm_end_ts;
+};
+
+/* Mailbox communication channel state. */
+#define MBXCS_BIT_READY		0
+#define MBXCS_BIT_STOP		1
+#define MBXCS_BIT_TICK		2
+
+enum mailbox_chan_type {
+	MBXCT_RX,
+	MBXCT_TX
+};
+
+struct mailbox_channel;
+typedef	bool (*chan_func_t)(struct mailbox_channel *ch);
+struct mailbox_channel {
+	struct mailbox		*mbc_parent;
+	enum mailbox_chan_type	mbc_type;
+
+	struct workqueue_struct	*mbc_wq;
+	struct work_struct	mbc_work;
+	struct completion	mbc_worker;
+	chan_func_t		mbc_tran;
+	unsigned long		mbc_state;
+
+	struct mutex		mbc_mutex;
+	struct list_head	mbc_msgs;
+
+	struct mailbox_msg	*mbc_cur_msg;
+	int			mbc_bytes_done;
+	struct mailbox_pkt	mbc_packet;
+
+	/*
+	 * Software channel settings
+	 */
+	wait_queue_head_t	sw_chan_wq;
+	struct mutex		sw_chan_mutex;
+	void			*sw_chan_buf;
+	size_t			sw_chan_buf_sz;
+	uint64_t		sw_chan_msg_id;
+	uint64_t		sw_chan_msg_flags;
+
+	atomic_t		sw_num_pending_msg;
+};
+
+/*
+ * The mailbox softstate.
+ */
+struct mailbox {
+	struct platform_device	*mbx_pdev;
+	struct timer_list	mbx_poll_timer;
+	struct mailbox_reg	*mbx_regs;
+
+	struct mailbox_channel	mbx_rx;
+	struct mailbox_channel	mbx_tx;
+
+	/* For listening to peer's request. */
+	mailbox_msg_cb_t	mbx_listen_cb;
+	void			*mbx_listen_cb_arg;
+	struct mutex		mbx_listen_cb_lock;
+	struct workqueue_struct	*mbx_listen_wq;
+	struct work_struct	mbx_listen_worker;
+
+	/*
+	 * For testing basic intr and mailbox comm functionality via sysfs.
+	 * No locking protection, use with care.
+	 */
+	struct mailbox_pkt	mbx_tst_pkt;
+
+	/* Req list for all incoming request message */
+	struct completion	mbx_comp;
+	struct mutex		mbx_lock;
+	struct list_head	mbx_req_list;
+	uint32_t		mbx_req_cnt;
+	bool			mbx_listen_stop;
+
+	bool			mbx_peer_dead;
+	uint64_t		mbx_opened;
+};
+
+static inline const char *reg2name(struct mailbox *mbx, u32 *reg)
+{
+	static const char * const reg_names[] = {
+		"wrdata",
+		"reserved1",
+		"rddata",
+		"reserved2",
+		"status",
+		"error",
+		"sit",
+		"rit",
+		"is",
+		"ie",
+		"ip",
+		"ctrl"
+	};
+
+	return reg_names[((uintptr_t)reg -
+		(uintptr_t)mbx->mbx_regs) / sizeof(u32)];
+}
+
+static inline u32 mailbox_reg_rd(struct mailbox *mbx, u32 *reg)
+{
+	u32 val = ioread32(reg);
+
+#ifdef	MAILBOX_REG_DEBUG
+	MBX_DBG(mbx, "REG_RD(%s)=0x%x", reg2name(mbx, reg), val);
+#endif
+	return val;
+}
+
+static inline void mailbox_reg_wr(struct mailbox *mbx, u32 *reg, u32 val)
+{
+#ifdef	MAILBOX_REG_DEBUG
+	MBX_DBG(mbx, "REG_WR(%s, 0x%x)", reg2name(mbx, reg), val);
+#endif
+	iowrite32(val, reg);
+}
+
+static inline void reset_pkt(struct mailbox_pkt *pkt)
+{
+	pkt->hdr.type = PKT_INVALID;
+}
+
+static inline bool valid_pkt(struct mailbox_pkt *pkt)
+{
+	return (pkt->hdr.type != PKT_INVALID);
+}
+
+static inline bool is_rx_chan(struct mailbox_channel *ch)
+{
+	return ch->mbc_type == MBXCT_RX;
+}
+
+static inline char *ch_name(struct mailbox_channel *ch)
+{
+	return is_rx_chan(ch) ? "RX" : "TX";
+}
+
+static bool is_rx_msg(struct mailbox_msg *msg)
+{
+	return is_rx_chan(msg->mbm_ch);
+}
+
+static void chan_tick(struct mailbox_channel *ch)
+{
+	mutex_lock(&ch->mbc_mutex);
+
+	set_bit(MBXCS_BIT_TICK, &ch->mbc_state);
+	complete(&ch->mbc_worker);
+
+	mutex_unlock(&ch->mbc_mutex);
+}
+
+static void mailbox_poll_timer(struct timer_list *t)
+{
+	struct mailbox *mbx = from_timer(mbx, t, mbx_poll_timer);
+
+	chan_tick(&mbx->mbx_tx);
+	chan_tick(&mbx->mbx_rx);
+
+	/* We're a periodic timer. */
+	mutex_lock(&mbx->mbx_lock);
+	mod_timer(&mbx->mbx_poll_timer, jiffies + MAILBOX_TTL_TIMER);
+	mutex_unlock(&mbx->mbx_lock);
+}
+
+static void free_msg(struct mailbox_msg *msg)
+{
+	vfree(msg);
+}
+
+static void msg_done(struct mailbox_msg *msg, int err)
+{
+	struct mailbox_channel *ch = msg->mbm_ch;
+	struct mailbox *mbx = ch->mbc_parent;
+	u64 elapsed = (msg->mbm_end_ts - msg->mbm_start_ts) / 1000; /* in us. */
+
+	MBX_INFO(ch->mbc_parent,
+		"msg(id=0x%llx sz=%ldB crc=0x%x): %s %lldpkts in %lldus: %d",
+		msg->mbm_req_id, msg->mbm_len,
+		crc32c_le(~0, msg->mbm_data, msg->mbm_len),
+		ch_name(ch), msg->mbm_num_pkts, elapsed, err);
+
+	msg->mbm_error = err;
+
+	if (msg->mbm_cb) {
+		msg->mbm_cb(msg->mbm_cb_arg, msg->mbm_data, msg->mbm_len,
+			msg->mbm_req_id, msg->mbm_error, msg->mbm_chan_sw);
+		free_msg(msg);
+		return;
+	}
+
+	if (is_rx_msg(msg) && (msg->mbm_flags & MSG_FLAG_REQUEST)) {
+		if (err) {
+			MBX_WARN(mbx, "Time'd out receiving full req message");
+			free_msg(msg);
+		} else if (mbx->mbx_req_cnt >= MAX_MSG_QUEUE_LEN) {
+			MBX_WARN(mbx, "Too many pending req messages, dropped");
+			free_msg(msg);
+		} else {
+			mutex_lock(&ch->mbc_parent->mbx_lock);
+			list_add_tail(&msg->mbm_list,
+				&ch->mbc_parent->mbx_req_list);
+			mbx->mbx_req_cnt++;
+			mutex_unlock(&ch->mbc_parent->mbx_lock);
+			complete(&ch->mbc_parent->mbx_comp);
+		}
+	} else {
+		complete(&msg->mbm_complete);
+	}
+}
+
+static void reset_sw_ch(struct mailbox_channel *ch)
+{
+	BUG_ON(!mutex_is_locked(&ch->sw_chan_mutex));
+
+	vfree(ch->sw_chan_buf);
+	ch->sw_chan_buf = NULL;
+	ch->sw_chan_buf_sz = 0;
+	ch->sw_chan_msg_flags = 0;
+	ch->sw_chan_msg_id = 0;
+	atomic_dec_if_positive(&ch->sw_num_pending_msg);
+}
+
+static void reset_hw_ch(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+
+	if (!mbx->mbx_regs)
+		return;
+
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_ctrl,
+		is_rx_chan(ch) ? 0x2 : 0x1);
+}
+
+static void chan_msg_done(struct mailbox_channel *ch, int err)
+{
+	if (!ch->mbc_cur_msg)
+		return;
+
+	ch->mbc_cur_msg->mbm_end_ts = ktime_get_ns();
+	if (err) {
+		if (ch->mbc_cur_msg->mbm_chan_sw) {
+			mutex_lock(&ch->sw_chan_mutex);
+			reset_sw_ch(ch);
+			mutex_unlock(&ch->sw_chan_mutex);
+		} else {
+			reset_hw_ch(ch);
+		}
+	}
+
+	msg_done(ch->mbc_cur_msg, err);
+	ch->mbc_cur_msg = NULL;
+	ch->mbc_bytes_done = 0;
+}
+
+void timeout_msg(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_msg *msg = NULL;
+	struct list_head *pos, *n;
+	struct list_head l = LIST_HEAD_INIT(l);
+
+	/* Check outstanding msg first. */
+	msg = ch->mbc_cur_msg;
+	if (msg) {
+		if (atomic_dec_if_positive(&msg->mbm_ttl) < 0) {
+			MBX_WARN(mbx, "found outstanding msg time'd out");
+			if (!mbx->mbx_peer_dead) {
+				MBX_WARN(mbx, "peer becomes dead");
+				/* Peer is not active any more. */
+				mbx->mbx_peer_dead = true;
+			}
+			chan_msg_done(ch, -ETIMEDOUT);
+		}
+	}
+
+	mutex_lock(&ch->mbc_mutex);
+
+	list_for_each_safe(pos, n, &ch->mbc_msgs) {
+		msg = list_entry(pos, struct mailbox_msg, mbm_list);
+		if (atomic_dec_if_positive(&msg->mbm_ttl) < 0) {
+			list_del(&msg->mbm_list);
+			list_add_tail(&msg->mbm_list, &l);
+		}
+	}
+
+	mutex_unlock(&ch->mbc_mutex);
+
+	if (!list_empty(&l))
+		MBX_ERR(mbx, "found awaiting msg time'd out");
+
+	list_for_each_safe(pos, n, &l) {
+		msg = list_entry(pos, struct mailbox_msg, mbm_list);
+		list_del(&msg->mbm_list);
+		msg_done(msg, -ETIMEDOUT);
+	}
+}
+
+static void msg_timer_on(struct mailbox_msg *msg, u32 ttl)
+{
+	atomic_set(&msg->mbm_ttl, MAILBOX_SEC2TTL(ttl));
+}
+
+/*
+ * Reset TTL for outstanding msg. Next portion of the msg is expected to
+ * arrive or go out before it times out.
+ */
+static void outstanding_msg_ttl_reset(struct mailbox_channel *ch)
+{
+	struct mailbox_msg *msg = ch->mbc_cur_msg;
+
+	if (!msg)
+		return;
+
+	// outstanding msg will time out if no progress is made within 1 second.
+	msg_timer_on(msg, 1);
+}
+
+static void handle_timer_event(struct mailbox_channel *ch)
+{
+	if (!test_bit(MBXCS_BIT_TICK, &ch->mbc_state))
+		return;
+	timeout_msg(ch);
+	clear_bit(MBXCS_BIT_TICK, &ch->mbc_state);
+}
+
+static void chan_worker(struct work_struct *work)
+{
+	struct mailbox_channel *ch =
+		container_of(work, struct mailbox_channel, mbc_work);
+	struct mailbox *mbx = ch->mbc_parent;
+	bool progress;
+
+	while (!test_bit(MBXCS_BIT_STOP, &ch->mbc_state)) {
+		if (ch->mbc_cur_msg) {
+			// fast poll (1000/s) to finish outstanding msg
+			usleep_range(1000, 2000);
+		} else {
+			// Wait for next poll timer trigger
+			wait_for_completion_interruptible(&ch->mbc_worker);
+		}
+
+		progress = ch->mbc_tran(ch);
+		if (progress) {
+			outstanding_msg_ttl_reset(ch);
+			if (mbx->mbx_peer_dead) {
+				MBX_INFO(mbx, "peer becomes active");
+				mbx->mbx_peer_dead = false;
+			}
+		}
+
+		handle_timer_event(ch);
+	}
+}
+
+static inline u32 mailbox_chk_err(struct mailbox *mbx)
+{
+	u32 val = mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_error);
+
+	/* Ignore bad register value after firewall is tripped. */
+	if (val == 0xffffffff)
+		val = 0;
+
+	/* Error should not be seen, shout when found. */
+	if (val)
+		MBX_ERR(mbx, "mailbox error detected, error=0x%x", val);
+	return val;
+}
+
+static int chan_msg_enqueue(struct mailbox_channel *ch, struct mailbox_msg *msg)
+{
+	int rv = 0;
+
+	MBX_DBG(ch->mbc_parent, "%s enqueuing msg, id=0x%llx",
+		ch_name(ch), msg->mbm_req_id);
+
+	BUG_ON(msg->mbm_req_id == INVALID_MSG_ID);
+
+	mutex_lock(&ch->mbc_mutex);
+	if (test_bit(MBXCS_BIT_STOP, &ch->mbc_state)) {
+		rv = -ESHUTDOWN;
+	} else {
+		list_add_tail(&msg->mbm_list, &ch->mbc_msgs);
+		msg->mbm_ch = ch;
+	}
+	mutex_unlock(&ch->mbc_mutex);
+
+	return rv;
+}
+
+static struct mailbox_msg *chan_msg_dequeue(struct mailbox_channel *ch,
+	u64 req_id)
+{
+	struct mailbox_msg *msg = NULL;
+	struct list_head *pos;
+
+	mutex_lock(&ch->mbc_mutex);
+
+	/* Take the first msg. */
+	if (req_id == INVALID_MSG_ID) {
+		msg = list_first_entry_or_null(&ch->mbc_msgs,
+		struct mailbox_msg, mbm_list);
+	/* Take the msg w/ specified ID. */
+	} else {
+		list_for_each(pos, &ch->mbc_msgs) {
+			struct mailbox_msg *temp;
+
+			temp = list_entry(pos, struct mailbox_msg, mbm_list);
+			if (temp->mbm_req_id == req_id) {
+				msg = temp;
+				break;
+			}
+		}
+	}
+
+	if (msg) {
+		MBX_DBG(ch->mbc_parent, "%s dequeued msg, id=0x%llx",
+			ch_name(ch), msg->mbm_req_id);
+		list_del(&msg->mbm_list);
+	}
+
+	mutex_unlock(&ch->mbc_mutex);
+	return msg;
+}
+
+static struct mailbox_msg *alloc_msg(void *buf, size_t len)
+{
+	char *newbuf = NULL;
+	struct mailbox_msg *msg = NULL;
+	/* Give MB*2 secs as time to live */
+
+	if (!buf) {
+		msg = vzalloc(sizeof(struct mailbox_msg) + len);
+		if (!msg)
+			return NULL;
+		newbuf = ((char *)msg) + sizeof(struct mailbox_msg);
+	} else {
+		msg = vzalloc(sizeof(struct mailbox_msg));
+		if (!msg)
+			return NULL;
+		newbuf = buf;
+	}
+
+	INIT_LIST_HEAD(&msg->mbm_list);
+	msg->mbm_data = newbuf;
+	msg->mbm_len = len;
+	atomic_set(&msg->mbm_ttl, MSG_MAX_TTL);
+	msg->mbm_chan_sw = false;
+	init_completion(&msg->mbm_complete);
+
+	return msg;
+}
+
+static void chan_fini(struct mailbox_channel *ch)
+{
+	struct mailbox_msg *msg;
+
+	if (!ch->mbc_parent)
+		return;
+
+	/*
+	 * Holding mutex to ensure no new msg is enqueued after
+	 * flag is set.
+	 */
+	mutex_lock(&ch->mbc_mutex);
+	set_bit(MBXCS_BIT_STOP, &ch->mbc_state);
+	mutex_unlock(&ch->mbc_mutex);
+
+	if (ch->mbc_wq) {
+		complete(&ch->mbc_worker);
+		cancel_work_sync(&ch->mbc_work);
+		destroy_workqueue(ch->mbc_wq);
+	}
+
+	mutex_lock(&ch->sw_chan_mutex);
+	if (ch->sw_chan_buf != NULL)
+		vfree(ch->sw_chan_buf);
+	mutex_unlock(&ch->sw_chan_mutex);
+
+	msg = ch->mbc_cur_msg;
+	if (msg)
+		chan_msg_done(ch, -ESHUTDOWN);
+
+	while ((msg = chan_msg_dequeue(ch, INVALID_MSG_ID)) != NULL)
+		msg_done(msg, -ESHUTDOWN);
+
+	mutex_destroy(&ch->mbc_mutex);
+	mutex_destroy(&ch->sw_chan_mutex);
+	ch->mbc_parent = NULL;
+}
+
+static int chan_init(struct mailbox *mbx, enum mailbox_chan_type type,
+	struct mailbox_channel *ch, chan_func_t fn)
+{
+	ch->mbc_parent = mbx;
+	ch->mbc_type = type;
+	ch->mbc_tran = fn;
+	INIT_LIST_HEAD(&ch->mbc_msgs);
+	init_completion(&ch->mbc_worker);
+	mutex_init(&ch->mbc_mutex);
+	mutex_init(&ch->sw_chan_mutex);
+
+	init_waitqueue_head(&ch->sw_chan_wq);
+	atomic_set(&ch->sw_num_pending_msg, 0);
+	ch->mbc_cur_msg = NULL;
+	ch->mbc_bytes_done = 0;
+
+	/* Reset pkt buffer. */
+	reset_pkt(&ch->mbc_packet);
+	/* Reset HW channel. */
+	reset_hw_ch(ch);
+	/* Reset SW channel. */
+	mutex_lock(&ch->sw_chan_mutex);
+	reset_sw_ch(ch);
+	mutex_unlock(&ch->sw_chan_mutex);
+
+	/* One thread for one channel. */
+	ch->mbc_wq =
+		create_singlethread_workqueue(dev_name(&mbx->mbx_pdev->dev));
+	if (!ch->mbc_wq) {
+		chan_fini(ch);
+		return -ENOMEM;
+	}
+	INIT_WORK(&ch->mbc_work, chan_worker);
+
+	/* Kick off channel thread, all initialization should be done by now. */
+	clear_bit(MBXCS_BIT_STOP, &ch->mbc_state);
+	set_bit(MBXCS_BIT_READY, &ch->mbc_state);
+	queue_work(ch->mbc_wq, &ch->mbc_work);
+	return 0;
+}
+
+static void listen_wq_fini(struct mailbox *mbx)
+{
+	BUG_ON(mbx == NULL);
+
+	if (mbx->mbx_listen_wq != NULL) {
+		mbx->mbx_listen_stop = true;
+		complete(&mbx->mbx_comp);
+		cancel_work_sync(&mbx->mbx_listen_worker);
+		destroy_workqueue(mbx->mbx_listen_wq);
+		mbx->mbx_listen_wq = NULL;
+	}
+}
+
+static void chan_recv_pkt(struct mailbox_channel *ch)
+{
+	int i, retry = 10;
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+
+	BUG_ON(valid_pkt(pkt));
+
+	/* Picking up a packet from HW. */
+	for (i = 0; i < PACKET_SIZE; i++) {
+		while ((mailbox_reg_rd(mbx,
+			&mbx->mbx_regs->mbr_status) & STATUS_EMPTY) &&
+			(retry-- > 0))
+			msleep(100);
+
+		*(((u32 *)pkt) + i) =
+			mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_rddata);
+	}
+	if ((mailbox_chk_err(mbx) & STATUS_EMPTY) != 0)
+		reset_pkt(pkt);
+	else
+		MBX_DBG(mbx, "received pkt: type=0x%x", pkt->hdr.type);
+}
+
+static void chan_send_pkt(struct mailbox_channel *ch)
+{
+	int i;
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+
+	BUG_ON(!valid_pkt(pkt));
+
+	MBX_DBG(mbx, "sending pkt: type=0x%x", pkt->hdr.type);
+
+	/* Pushing a packet into HW. */
+	for (i = 0; i < PACKET_SIZE; i++) {
+		mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_wrdata,
+			*(((u32 *)pkt) + i));
+	}
+
+	reset_pkt(pkt);
+	if (ch->mbc_cur_msg)
+		ch->mbc_bytes_done += ch->mbc_packet.hdr.payload_size;
+
+	BUG_ON((mailbox_chk_err(mbx) & STATUS_FULL) != 0);
+}
+
+static int chan_pkt2msg(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	void *msg_data, *pkt_data;
+	struct mailbox_msg *msg = ch->mbc_cur_msg;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+	size_t cnt = pkt->hdr.payload_size;
+	u32 type = (pkt->hdr.type & PKT_TYPE_MASK);
+
+	BUG_ON(((type != PKT_MSG_START) && (type != PKT_MSG_BODY)) || !msg);
+
+	if (type == PKT_MSG_START) {
+		msg->mbm_req_id = pkt->body.msg_start.msg_req_id;
+		BUG_ON(msg->mbm_len < pkt->body.msg_start.msg_size);
+		msg->mbm_len = pkt->body.msg_start.msg_size;
+		pkt_data = pkt->body.msg_start.payload;
+	} else {
+		pkt_data = pkt->body.msg_body.payload;
+	}
+
+	if (cnt > msg->mbm_len - ch->mbc_bytes_done) {
+		MBX_ERR(mbx, "invalid mailbox packet size");
+		return -EBADMSG;
+	}
+
+	msg_data = msg->mbm_data + ch->mbc_bytes_done;
+	(void) memcpy(msg_data, pkt_data, cnt);
+	ch->mbc_bytes_done += cnt;
+	msg->mbm_num_pkts++;
+
+	reset_pkt(pkt);
+	return 0;
+}
+
+/* Prepare outstanding msg for receiving incoming msg. */
+static void dequeue_rx_msg(struct mailbox_channel *ch,
+	u32 flags, u64 id, size_t sz)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_msg *msg = NULL;
+	int err = 0;
+
+	if (ch->mbc_cur_msg)
+		return;
+
+	if (flags & MSG_FLAG_RESPONSE) {
+		msg = chan_msg_dequeue(ch, id);
+		if (!msg) {
+			MBX_ERR(mbx, "Failed to find msg (id 0x%llx)", id);
+		} else if (msg->mbm_len < sz) {
+			MBX_ERR(mbx, "Response (id 0x%llx) is too big: %lu",
+				id, sz);
+			err = -EMSGSIZE;
+		}
+	} else if (flags & MSG_FLAG_REQUEST) {
+		if (sz < MAX_REQ_MSG_SZ)
+			msg = alloc_msg(NULL, sz);
+		if (msg) {
+			msg->mbm_req_id = id;
+			msg->mbm_ch = ch;
+			msg->mbm_flags = flags;
+		} else {
+			MBX_ERR(mbx, "req msg len %luB is too big", sz);
+		}
+	} else {
+		/* Not a request or response? */
+		MBX_ERR(mbx, "Invalid incoming msg flags: 0x%x", flags);
+	}
+
+	if (msg) {
+		msg->mbm_start_ts = ktime_get_ns();
+		msg->mbm_num_pkts = 0;
+		ch->mbc_cur_msg = msg;
+	}
+
+	/* Fail received msg now on error. */
+	if (err)
+		chan_msg_done(ch, err);
+}
+
+static bool do_sw_rx(struct mailbox_channel *ch)
+{
+	u32 flags = 0;
+	u64 id = 0;
+	size_t len = 0;
+
+	/*
+	 * Don't receive new msg when a msg is being received from HW
+	 * for simplicity.
+	 */
+	if (ch->mbc_cur_msg)
+		return false;
+
+	mutex_lock(&ch->sw_chan_mutex);
+
+	flags = ch->sw_chan_msg_flags;
+	id = ch->sw_chan_msg_id;
+	len = ch->sw_chan_buf_sz;
+
+	mutex_unlock(&ch->sw_chan_mutex);
+
+	/* Nothing to receive. */
+	if (id == 0)
+		return false;
+
+	/* Prepare outstanding msg. */
+	dequeue_rx_msg(ch, flags, id, len);
+
+	mutex_lock(&ch->sw_chan_mutex);
+
+	BUG_ON(id != ch->sw_chan_msg_id);
+
+	if (ch->mbc_cur_msg) {
+		ch->mbc_cur_msg->mbm_chan_sw = true;
+		memcpy(ch->mbc_cur_msg->mbm_data,
+			ch->sw_chan_buf, ch->sw_chan_buf_sz);
+	}
+
+	/* Done with sw msg. */
+	reset_sw_ch(ch);
+
+	mutex_unlock(&ch->sw_chan_mutex);
+
+	wake_up_interruptible(&ch->sw_chan_wq);
+
+	chan_msg_done(ch, 0);
+
+	return true;
+}
+
+static bool do_hw_rx(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+	u32 type;
+	bool eom = false, read_hw = false;
+	u32 st = mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_status);
+	bool progress = false;
+
+	/* Check if a packet is ready for reading. */
+	if (st & ~STATUS_VALID) {
+		/* Device is still being reset or firewall tripped. */
+		read_hw = false;
+	} else {
+		read_hw = ((st & STATUS_RTA) != 0);
+	}
+
+	if (!read_hw)
+		return progress;
+
+	chan_recv_pkt(ch);
+	type = pkt->hdr.type & PKT_TYPE_MASK;
+	eom = ((pkt->hdr.type & PKT_TYPE_MSG_END) != 0);
+
+	switch (type) {
+	case PKT_TEST:
+		(void) memcpy(&mbx->mbx_tst_pkt, &ch->mbc_packet,
+			sizeof(struct mailbox_pkt));
+		reset_pkt(pkt);
+		break;
+	case PKT_MSG_START:
+		if (ch->mbc_cur_msg) {
+			MBX_ERR(mbx, "Received partial msg (id 0x%llx)",
+				ch->mbc_cur_msg->mbm_req_id);
+			chan_msg_done(ch, -EBADMSG);
+		}
+		/* Prepare outstanding msg. */
+		dequeue_rx_msg(ch, pkt->body.msg_start.msg_flags,
+			pkt->body.msg_start.msg_req_id,
+			pkt->body.msg_start.msg_size);
+		if (!ch->mbc_cur_msg) {
+			MBX_ERR(mbx, "got unexpected msg start pkt");
+			reset_pkt(pkt);
+		}
+		break;
+	case PKT_MSG_BODY:
+		if (!ch->mbc_cur_msg) {
+			MBX_ERR(mbx, "got unexpected msg body pkt");
+			reset_pkt(pkt);
+		}
+		break;
+	default:
+		MBX_ERR(mbx, "invalid mailbox pkt type");
+		reset_pkt(pkt);
+		break;
+	}
+
+	if (valid_pkt(pkt)) {
+		int err = chan_pkt2msg(ch);
+
+		if (err || eom)
+			chan_msg_done(ch, err);
+		progress = true;
+	}
+
+	return progress;
+}
+
+/*
+ * Worker for RX channel.
+ */
+static bool chan_do_rx(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	bool progress = false;
+
+	progress = do_sw_rx(ch);
+	if (!MBX_SW_ONLY(mbx))
+		progress |= do_hw_rx(ch);
+
+	return progress;
+}
+
+static void chan_msg2pkt(struct mailbox_channel *ch)
+{
+	size_t cnt = 0;
+	size_t payload_off = 0;
+	void *msg_data, *pkt_data;
+	struct mailbox_msg *msg = ch->mbc_cur_msg;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+	bool is_start = (ch->mbc_bytes_done == 0);
+	bool is_eom = false;
+
+	if (is_start) {
+		payload_off = offsetof(struct mailbox_pkt,
+			body.msg_start.payload);
+	} else {
+		payload_off = offsetof(struct mailbox_pkt,
+			body.msg_body.payload);
+	}
+	cnt = PACKET_SIZE * sizeof(u32) - payload_off;
+	if (cnt >= msg->mbm_len - ch->mbc_bytes_done) {
+		cnt = msg->mbm_len - ch->mbc_bytes_done;
+		is_eom = true;
+	}
+
+	pkt->hdr.type = is_start ? PKT_MSG_START : PKT_MSG_BODY;
+	pkt->hdr.type |= is_eom ? PKT_TYPE_MSG_END : 0;
+	pkt->hdr.payload_size = cnt;
+
+	if (is_start) {
+		pkt->body.msg_start.msg_req_id = msg->mbm_req_id;
+		pkt->body.msg_start.msg_size = msg->mbm_len;
+		pkt->body.msg_start.msg_flags = msg->mbm_flags;
+		pkt_data = pkt->body.msg_start.payload;
+	} else {
+		pkt_data = pkt->body.msg_body.payload;
+	}
+	msg_data = msg->mbm_data + ch->mbc_bytes_done;
+	(void) memcpy(pkt_data, msg_data, cnt);
+}
+
+static void do_sw_tx(struct mailbox_channel *ch)
+{
+	mutex_lock(&ch->sw_chan_mutex);
+
+	BUG_ON(ch->mbc_cur_msg == NULL || !ch->mbc_cur_msg->mbm_chan_sw);
+	BUG_ON(ch->sw_chan_msg_id != 0);
+
+	ch->sw_chan_buf = vmalloc(ch->mbc_cur_msg->mbm_len);
+	if (!ch->sw_chan_buf) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		return;
+	}
+
+	ch->sw_chan_buf_sz = ch->mbc_cur_msg->mbm_len;
+	ch->sw_chan_msg_id = ch->mbc_cur_msg->mbm_req_id;
+	ch->sw_chan_msg_flags = ch->mbc_cur_msg->mbm_flags;
+	(void) memcpy(ch->sw_chan_buf, ch->mbc_cur_msg->mbm_data,
+		ch->sw_chan_buf_sz);
+	ch->mbc_bytes_done = ch->mbc_cur_msg->mbm_len;
+
+	/* Notify sw tx channel handler. */
+	atomic_inc(&ch->sw_num_pending_msg);
+
+	mutex_unlock(&ch->sw_chan_mutex);
+	wake_up_interruptible(&ch->sw_chan_wq);
+}
+
+static void do_hw_tx(struct mailbox_channel *ch)
+{
+	BUG_ON(ch->mbc_cur_msg == NULL || ch->mbc_cur_msg->mbm_chan_sw);
+	chan_msg2pkt(ch);
+	chan_send_pkt(ch);
+}
+
+/* Prepare outstanding msg for sending outgoing msg. */
+static void dequeue_tx_msg(struct mailbox_channel *ch)
+{
+	if (ch->mbc_cur_msg)
+		return;
+
+	ch->mbc_cur_msg = chan_msg_dequeue(ch, INVALID_MSG_ID);
+	if (ch->mbc_cur_msg) {
+		ch->mbc_cur_msg->mbm_start_ts = ktime_get_ns();
+		ch->mbc_cur_msg->mbm_num_pkts = 0;
+	}
+}
+
+/* Check if HW TX channel is ready for next msg. */
+static bool tx_hw_chan_ready(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	u32 st;
+
+	st = mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_status);
+	return ((st != 0xffffffff) && ((st & STATUS_STA) != 0));
+}
+
+/* Check if SW TX channel is ready for next msg. */
+static bool tx_sw_chan_ready(struct mailbox_channel *ch)
+{
+	bool ready;
+
+	mutex_lock(&ch->sw_chan_mutex);
+	ready = (ch->sw_chan_msg_id == 0);
+	mutex_unlock(&ch->sw_chan_mutex);
+	return ready;
+}
+
+/*
+ * Worker for TX channel.
+ */
+static bool chan_do_tx(struct mailbox_channel *ch)
+{
+	struct mailbox_msg *curmsg = ch->mbc_cur_msg;
+	bool progress = false;
+
+	/* Check if current outstanding msg is fully sent. */
+	if (curmsg) {
+		bool done = curmsg->mbm_chan_sw ? tx_sw_chan_ready(ch) :
+			tx_hw_chan_ready(ch);
+		if (done) {
+			curmsg->mbm_num_pkts++;
+			if (curmsg->mbm_len == ch->mbc_bytes_done)
+				chan_msg_done(ch, 0);
+			progress = true;
+		}
+	}
+
+	dequeue_tx_msg(ch);
+	curmsg = ch->mbc_cur_msg;
+
+	/* Send the next msg out. */
+	if (curmsg) {
+		if (curmsg->mbm_chan_sw) {
+			if (tx_sw_chan_ready(ch)) {
+				do_sw_tx(ch);
+				progress = true;
+			}
+		} else {
+			if (tx_hw_chan_ready(ch)) {
+				do_hw_tx(ch);
+				progress = true;
+			}
+		}
+	}
+
+	return progress;
+}
+
+static ssize_t mailbox_ctl_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	u32 *reg = (u32 *)mbx->mbx_regs;
+	int r, n;
+	int nreg = sizeof(struct mailbox_reg) / sizeof(u32);
+
+	if (MBX_SW_ONLY(mbx))
+		return 0;
+
+	for (r = 0, n = 0; r < nreg; r++, reg++) {
+		/* Non-status registers. */
+		if ((reg == &mbx->mbx_regs->mbr_resv1)		||
+			(reg == &mbx->mbx_regs->mbr_wrdata)	||
+			(reg == &mbx->mbx_regs->mbr_rddata)	||
+			(reg == &mbx->mbx_regs->mbr_resv2))
+			continue;
+		/* Write-only status register. */
+		if (reg == &mbx->mbx_regs->mbr_ctrl) {
+			n += sprintf(buf + n, "%02ld %10s = --",
+				r * sizeof(u32), reg2name(mbx, reg));
+		/* Read-able status register. */
+		} else {
+			n += sprintf(buf + n, "%02ld %10s = 0x%08x",
+				r * sizeof(u32), reg2name(mbx, reg),
+				mailbox_reg_rd(mbx, reg));
+		}
+	}
+
+	return n;
+}
+static ssize_t mailbox_ctl_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	u32 off, val;
+	int nreg = sizeof(struct mailbox_reg) / sizeof(u32);
+	u32 *reg = (u32 *)mbx->mbx_regs;
+
+	if (MBX_SW_ONLY(mbx))
+		return count;
+
+	if (sscanf(buf, "%d:%d", &off, &val) != 2 || (off % sizeof(u32)) ||
+		off >= nreg * sizeof(u32)) {
+		MBX_ERR(mbx, "input should be < reg_offset:reg_val>");
+		return -EINVAL;
+	}
+	reg += off / sizeof(u32);
+
+	mailbox_reg_wr(mbx, reg, val);
+	return count;
+}
+/* HW register level debugging i/f. */
+static DEVICE_ATTR_RW(mailbox_ctl);
+
+static ssize_t mailbox_pkt_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	struct mailbox_pkt *pkt = &mbx->mbx_tst_pkt;
+	u32 sz = pkt->hdr.payload_size;
+
+	if (MBX_SW_ONLY(mbx))
+		return -ENODEV;
+
+	if (!valid_pkt(pkt))
+		return -ENOENT;
+
+	(void) memcpy(buf, pkt->body.data, sz);
+	reset_pkt(pkt);
+
+	return sz;
+}
+static ssize_t mailbox_pkt_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	struct mailbox_pkt *pkt = &mbx->mbx_tst_pkt;
+	size_t maxlen = sizeof(mbx->mbx_tst_pkt.body.data);
+
+	if (MBX_SW_ONLY(mbx))
+		return -ENODEV;
+
+	if (count > maxlen) {
+		MBX_ERR(mbx, "max input length is %ld", maxlen);
+		return 0;
+	}
+
+	(void) memcpy(pkt->body.data, buf, count);
+	pkt->hdr.payload_size = count;
+	pkt->hdr.type = PKT_TEST;
+
+	/* Sending test pkt. */
+	(void) memcpy(&mbx->mbx_tx.mbc_packet, &mbx->mbx_tst_pkt,
+		sizeof(struct mailbox_pkt));
+	reset_pkt(&mbx->mbx_tst_pkt);
+	chan_send_pkt(&mbx->mbx_tx);
+	return count;
+}
+/* Packet test i/f. */
+static DEVICE_ATTR_RW(mailbox_pkt);
+
+static struct attribute *mailbox_attrs[] = {
+	&dev_attr_mailbox_ctl.attr,
+	&dev_attr_mailbox_pkt.attr,
+	NULL,
+};
+
+static const struct attribute_group mailbox_attrgroup = {
+	.attrs = mailbox_attrs,
+};
+
+/*
+ * Msg will be sent to peer and reply will be received.
+ */
+static int mailbox_request(struct platform_device *pdev, void *req,
+	size_t reqlen, void *resp, size_t *resplen, bool sw_ch, u32 resp_ttl)
+{
+	int rv = -ENOMEM;
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	struct mailbox_msg *reqmsg = NULL, *respmsg = NULL;
+
+	/* If peer is not alive, no point sending req and waiting for resp. */
+	if (mbx->mbx_peer_dead)
+		return -ENOTCONN;
+
+	reqmsg = alloc_msg(req, reqlen);
+	if (!reqmsg)
+		goto fail;
+	reqmsg->mbm_chan_sw = sw_ch;
+	reqmsg->mbm_req_id = (uintptr_t)reqmsg->mbm_data;
+	reqmsg->mbm_flags |= MSG_FLAG_REQUEST;
+
+	respmsg = alloc_msg(resp, *resplen);
+	if (!respmsg)
+		goto fail;
+	/* Only interested in response w/ same ID. */
+	respmsg->mbm_req_id = reqmsg->mbm_req_id;
+	respmsg->mbm_chan_sw = sw_ch;
+
+	/* Always enqueue RX msg before TX one to avoid race. */
+	rv = chan_msg_enqueue(&mbx->mbx_rx, respmsg);
+	if (rv)
+		goto fail;
+	rv = chan_msg_enqueue(&mbx->mbx_tx, reqmsg);
+	if (rv) {
+		respmsg = chan_msg_dequeue(&mbx->mbx_rx, reqmsg->mbm_req_id);
+		goto fail;
+	}
+
+	/* Wait for req to be sent. */
+	wait_for_completion(&reqmsg->mbm_complete);
+	rv = reqmsg->mbm_error;
+	if (rv) {
+		(void) chan_msg_dequeue(&mbx->mbx_rx, reqmsg->mbm_req_id);
+		goto fail;
+	}
+	free_msg(reqmsg);
+
+	/* Start timer and wait for resp to be received. */
+	msg_timer_on(respmsg, resp_ttl);
+	wait_for_completion(&respmsg->mbm_complete);
+	rv = respmsg->mbm_error;
+	if (rv == 0)
+		*resplen = respmsg->mbm_len;
+
+	free_msg(respmsg);
+	return rv;
+
+fail:
+	if (reqmsg)
+		free_msg(reqmsg);
+	if (respmsg)
+		free_msg(respmsg);
+	return rv;
+}
+
+/*
+ * Posting notification or response to peer.
+ */
+static int mailbox_post(struct platform_device *pdev,
+	u64 reqid, void *buf, size_t len, bool sw_ch)
+{
+	int rv = 0;
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	struct mailbox_msg *msg = NULL;
+
+	/* If peer is not alive, no point posting a msg. */
+	if (mbx->mbx_peer_dead)
+		return -ENOTCONN;
+
+	msg = alloc_msg(NULL, len);
+	if (!msg)
+		return -ENOMEM;
+
+	(void) memcpy(msg->mbm_data, buf, len);
+	msg->mbm_chan_sw = sw_ch;
+	msg->mbm_req_id = reqid ? reqid : (uintptr_t)msg->mbm_data;
+	msg->mbm_flags |= reqid ? MSG_FLAG_RESPONSE : MSG_FLAG_REQUEST;
+
+	rv = chan_msg_enqueue(&mbx->mbx_tx, msg);
+	if (rv == 0) {
+		wait_for_completion(&msg->mbm_complete);
+		rv = msg->mbm_error;
+	}
+
+	if (rv)
+		MBX_ERR(mbx, "failed to post msg, err=%d", rv);
+	free_msg(msg);
+	return rv;
+}
+
+static void process_request(struct mailbox *mbx, struct mailbox_msg *msg)
+{
+	/* Call client's registered callback to process request. */
+	mutex_lock(&mbx->mbx_listen_cb_lock);
+
+	if (mbx->mbx_listen_cb) {
+		mbx->mbx_listen_cb(mbx->mbx_listen_cb_arg, msg->mbm_data,
+			msg->mbm_len, msg->mbm_req_id, msg->mbm_error,
+			msg->mbm_chan_sw);
+	} else {
+		MBX_INFO(mbx, "msg dropped, no listener");
+	}
+
+	mutex_unlock(&mbx->mbx_listen_cb_lock);
+}
+
+/*
+ * Wait for request from peer.
+ */
+static void mailbox_recv_request(struct work_struct *work)
+{
+	struct mailbox_msg *msg = NULL;
+	struct mailbox *mbx =
+		container_of(work, struct mailbox, mbx_listen_worker);
+
+	while (!mbx->mbx_listen_stop) {
+		/* Only interested in request msg. */
+		(void) wait_for_completion_interruptible(&mbx->mbx_comp);
+
+		mutex_lock(&mbx->mbx_lock);
+
+		while ((msg = list_first_entry_or_null(&mbx->mbx_req_list,
+			struct mailbox_msg, mbm_list)) != NULL) {
+			list_del(&msg->mbm_list);
+			mbx->mbx_req_cnt--;
+			mutex_unlock(&mbx->mbx_lock);
+
+			/* Process msg without holding mutex. */
+			process_request(mbx, msg);
+			free_msg(msg);
+
+			mutex_lock(&mbx->mbx_lock);
+		}
+
+		mutex_unlock(&mbx->mbx_lock);
+	}
+
+	/* Drain all msg before quit. */
+	mutex_lock(&mbx->mbx_lock);
+	while ((msg = list_first_entry_or_null(&mbx->mbx_req_list,
+		struct mailbox_msg, mbm_list)) != NULL) {
+		list_del(&msg->mbm_list);
+		free_msg(msg);
+	}
+	mutex_unlock(&mbx->mbx_lock);
+}
+
+static int mailbox_listen(struct platform_device *pdev,
+	mailbox_msg_cb_t cb, void *cbarg)
+{
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+
+	mutex_lock(&mbx->mbx_listen_cb_lock);
+
+	mbx->mbx_listen_cb_arg = cbarg;
+	mbx->mbx_listen_cb = cb;
+
+	mutex_unlock(&mbx->mbx_listen_cb_lock);
+
+	return 0;
+}
+
+static int mailbox_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	MBX_INFO(mbx, "handling IOCTL cmd: %d", cmd);
+
+	switch (cmd) {
+	case XRT_MAILBOX_POST: {
+		struct xrt_mailbox_ioctl_post *post =
+			(struct xrt_mailbox_ioctl_post *)arg;
+
+		ret = mailbox_post(pdev, post->xmip_req_id, post->xmip_data,
+			post->xmip_data_size, post->xmip_sw_ch);
+		break;
+	}
+	case XRT_MAILBOX_REQUEST: {
+		struct xrt_mailbox_ioctl_request *req =
+			(struct xrt_mailbox_ioctl_request *)arg;
+
+		ret = mailbox_request(pdev, req->xmir_req, req->xmir_req_size,
+			req->xmir_resp, &req->xmir_resp_size, req->xmir_sw_ch,
+			req->xmir_resp_ttl);
+		break;
+	}
+	case XRT_MAILBOX_LISTEN: {
+		struct xrt_mailbox_ioctl_listen *listen =
+			(struct xrt_mailbox_ioctl_listen *)arg;
+
+		ret = mailbox_listen(pdev,
+			listen->xmil_cb, listen->xmil_cb_arg);
+		break;
+	}
+	default:
+		MBX_ERR(mbx, "unknown cmd: %d", cmd);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static void mailbox_stop(struct mailbox *mbx)
+{
+	/* Tear down all threads. */
+	del_timer_sync(&mbx->mbx_poll_timer);
+	chan_fini(&mbx->mbx_tx);
+	chan_fini(&mbx->mbx_rx);
+	listen_wq_fini(mbx);
+	BUG_ON(!(list_empty(&mbx->mbx_req_list)));
+}
+
+static int mailbox_start(struct mailbox *mbx)
+{
+	int ret;
+
+	mbx->mbx_req_cnt = 0;
+	mbx->mbx_peer_dead = false;
+	mbx->mbx_opened = 0;
+	mbx->mbx_listen_stop = false;
+
+	/* Dedicated thread for listening to peer request. */
+	mbx->mbx_listen_wq =
+		create_singlethread_workqueue(dev_name(&mbx->mbx_pdev->dev));
+	if (!mbx->mbx_listen_wq) {
+		MBX_ERR(mbx, "failed to create request-listen work queue");
+		ret = -ENOMEM;
+		goto out;
+	}
+	INIT_WORK(&mbx->mbx_listen_worker, mailbox_recv_request);
+	queue_work(mbx->mbx_listen_wq, &mbx->mbx_listen_worker);
+
+	/* Set up communication channels. */
+	ret = chan_init(mbx, MBXCT_RX, &mbx->mbx_rx, chan_do_rx);
+	if (ret != 0) {
+		MBX_ERR(mbx, "failed to init rx channel");
+		goto out;
+	}
+	ret = chan_init(mbx, MBXCT_TX, &mbx->mbx_tx, chan_do_tx);
+	if (ret != 0) {
+		MBX_ERR(mbx, "failed to init tx channel");
+		goto out;
+	}
+
+	/* Only see status change when we have full packet sent or received. */
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_rit, PACKET_SIZE - 1);
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_sit, 0);
+
+	/* Disable both TX / RX intrs. We only do polling. */
+	if (!MBX_SW_ONLY(mbx))
+		mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_ie, 0x0);
+	timer_setup(&mbx->mbx_poll_timer, mailbox_poll_timer, 0);
+	mod_timer(&mbx->mbx_poll_timer, jiffies + MAILBOX_TTL_TIMER);
+
+out:
+	return ret;
+}
+
+static int mailbox_open(struct inode *inode, struct file *file)
+{
+	/*
+	 * Only allow one open from daemon. Mailbox msg can only be polled
+	 * by one daemon.
+	 */
+	struct platform_device *pdev = xrt_devnode_open_excl(inode);
+	struct mailbox *mbx = NULL;
+
+	if (!pdev)
+		return -ENXIO;
+
+	mbx = platform_get_drvdata(pdev);
+	if (!mbx)
+		return -ENXIO;
+
+	/*
+	 * Indicates that mpd/msd is up and running, assuming msd/mpd
+	 * is the only user of the software mailbox
+	 */
+	mutex_lock(&mbx->mbx_lock);
+	mbx->mbx_opened++;
+	mutex_unlock(&mbx->mbx_lock);
+
+	file->private_data = mbx;
+	return 0;
+}
+
+/*
+ * Called when the device goes from used to unused.
+ */
+static int mailbox_close(struct inode *inode, struct file *file)
+{
+	struct mailbox *mbx = file->private_data;
+
+	mutex_lock(&mbx->mbx_lock);
+	mbx->mbx_opened--;
+	mutex_unlock(&mbx->mbx_lock);
+	xrt_devnode_close(inode);
+	return 0;
+}
+
+/*
+ * Software channel TX handler. Msg goes out to peer.
+ *
+ * We either read the entire msg out or nothing and return error. Partial read
+ * is not supported.
+ */
+static ssize_t
+mailbox_read(struct file *file, char __user *buf, size_t n, loff_t *ignd)
+{
+	struct mailbox *mbx = file->private_data;
+	struct mailbox_channel *ch = &mbx->mbx_tx;
+	struct xcl_sw_chan args = { 0 };
+
+	if (n < sizeof(struct xcl_sw_chan)) {
+		MBX_ERR(mbx, "Software TX buf has no room for header");
+		return -EINVAL;
+	}
+
+	/* Wait until tx worker has something to transmit to peer. */
+	if (wait_event_interruptible(ch->sw_chan_wq,
+		atomic_read(&ch->sw_num_pending_msg) > 0) == -ERESTARTSYS) {
+		MBX_ERR(mbx, "Software TX channel handler is interrupted");
+		return -ERESTARTSYS;
+	}
+
+	/* We have something to send, do it now. */
+
+	mutex_lock(&ch->sw_chan_mutex);
+
+	/* Nothing to do. Someone is ahead of us and did the job? */
+	if (ch->sw_chan_msg_id == 0) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		MBX_ERR(mbx, "Software TX channel is empty");
+		return 0;
+	}
+
+	/* Copy header to user. */
+	args.id = ch->sw_chan_msg_id;
+	args.sz = ch->sw_chan_buf_sz;
+	args.flags = ch->sw_chan_msg_flags;
+	if (copy_to_user(buf, &args, sizeof(struct xcl_sw_chan)) != 0) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		return -EFAULT;
+	}
+
+	/*
+	 * Buffer passed in is too small for payload, return EMSGSIZE to ask
+	 * for a bigger one.
+	 */
+	if (ch->sw_chan_buf_sz > (n - sizeof(struct xcl_sw_chan))) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		/*
+		 * This error occurs when daemons try to query the size
+		 * of the msg. Show it as info to avoid flushing sytem console.
+		 */
+		MBX_INFO(mbx, "Software TX msg is too big");
+		return -EMSGSIZE;
+	}
+
+	/* Copy payload to user. */
+	if (copy_to_user(((struct xcl_sw_chan *)buf)->data,
+		ch->sw_chan_buf, ch->sw_chan_buf_sz) != 0) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		return -EFAULT;
+	}
+
+	/* Mark that job is done and we're ready for next TX msg. */
+	reset_sw_ch(ch);
+
+	mutex_unlock(&ch->sw_chan_mutex);
+	return args.sz + sizeof(struct xcl_sw_chan);
+}
+
+/*
+ * Software channel RX handler. Msg comes in from peer.
+ *
+ * We either receive the entire msg or nothing and return error. Partial write
+ * is not supported.
+ */
+static ssize_t
+mailbox_write(struct file *file, const char __user *buf, size_t n, loff_t *ignd)
+{
+	struct mailbox *mbx = file->private_data;
+	struct mailbox_channel *ch = &mbx->mbx_rx;
+	struct xcl_sw_chan args = { 0 };
+	void *payload = NULL;
+
+	if (n < sizeof(struct xcl_sw_chan)) {
+		MBX_ERR(mbx, "Software RX msg has invalid header");
+		return -EINVAL;
+	}
+
+	/* Wait until rx worker is ready for receiving next msg from peer. */
+	if (wait_event_interruptible(ch->sw_chan_wq,
+		atomic_read(&ch->sw_num_pending_msg) == 0) == -ERESTARTSYS) {
+		MBX_ERR(mbx, "Software RX channel handler is interrupted");
+		return -ERESTARTSYS;
+	}
+
+	/* Rx worker is ready to receive msg, do it now. */
+
+	mutex_lock(&ch->sw_chan_mutex);
+
+	/* No room for us. Someone is ahead of us and is using the channel? */
+	if (ch->sw_chan_msg_id != 0) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		MBX_ERR(mbx, "Software RX channel is busy");
+		return -EBUSY;
+	}
+
+	/* Copy header from user. */
+	if (copy_from_user(&args, buf, sizeof(struct xcl_sw_chan)) != 0) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		return -EFAULT;
+	}
+	if (args.id == 0 || args.sz == 0) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		MBX_ERR(mbx, "Software RX msg has malformed header");
+		return -EINVAL;
+	}
+
+	/* Copy payload from user. */
+	if (n < args.sz + sizeof(struct xcl_sw_chan)) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		MBX_ERR(mbx, "Software RX msg has invalid payload");
+		return -EINVAL;
+	}
+	payload = vmalloc(args.sz);
+	if (payload == NULL) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		return -ENOMEM;
+	}
+	if (copy_from_user(payload, ((struct xcl_sw_chan *)buf)->data,
+		args.sz) != 0) {
+		mutex_unlock(&ch->sw_chan_mutex);
+		vfree(payload);
+		return -EFAULT;
+	}
+
+	/* Set up received msg and notify rx worker. */
+	ch->sw_chan_buf_sz = args.sz;
+	ch->sw_chan_msg_id = args.id;
+	ch->sw_chan_msg_flags = args.flags;
+	ch->sw_chan_buf = payload;
+
+	atomic_inc(&ch->sw_num_pending_msg);
+
+	mutex_unlock(&ch->sw_chan_mutex);
+
+	return args.sz + sizeof(struct xcl_sw_chan);
+}
+
+static uint mailbox_poll(struct file *file, poll_table *wait)
+{
+	struct mailbox *mbx = file->private_data;
+	struct mailbox_channel *ch = &mbx->mbx_tx;
+	int counter;
+
+	poll_wait(file, &ch->sw_chan_wq, wait);
+	counter = atomic_read(&ch->sw_num_pending_msg);
+
+	MBX_DBG(mbx, "%s: %d", __func__, counter);
+	if (counter == 0)
+		return 0;
+	return POLLIN;
+}
+
+static int mailbox_remove(struct platform_device *pdev)
+{
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+
+	BUG_ON(mbx == NULL);
+
+	/* Stop accessing from sysfs node. */
+	sysfs_remove_group(&pdev->dev.kobj, &mailbox_attrgroup);
+
+	mailbox_stop(mbx);
+
+	if (mbx->mbx_regs)
+		iounmap(mbx->mbx_regs);
+
+	MBX_INFO(mbx, "mailbox cleaned up successfully");
+
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static int mailbox_probe(struct platform_device *pdev)
+{
+	struct mailbox *mbx = NULL;
+	struct resource *res;
+	int ret;
+
+	mbx = devm_kzalloc(DEV(pdev), sizeof(struct mailbox), GFP_KERNEL);
+	if (!mbx)
+		return -ENOMEM;
+
+	mbx->mbx_pdev = pdev;
+	platform_set_drvdata(pdev, mbx);
+
+	init_completion(&mbx->mbx_comp);
+	mutex_init(&mbx->mbx_lock);
+	mutex_init(&mbx->mbx_listen_cb_lock);
+	INIT_LIST_HEAD(&mbx->mbx_req_list);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res != NULL) {
+		mbx->mbx_regs = ioremap(res->start, res->end - res->start + 1);
+		if (!mbx->mbx_regs) {
+			MBX_ERR(mbx, "failed to map in registers");
+			ret = -EIO;
+			goto failed;
+		}
+	}
+
+	ret = mailbox_start(mbx);
+	if (ret)
+		goto failed;
+
+	/* Enable access thru sysfs node. */
+	ret = sysfs_create_group(&pdev->dev.kobj, &mailbox_attrgroup);
+	if (ret != 0) {
+		MBX_ERR(mbx, "failed to init sysfs");
+		goto failed;
+	}
+
+	MBX_INFO(mbx, "successfully initialized");
+	return 0;
+
+failed:
+	mailbox_remove(pdev);
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_mailbox_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{ .ep_name = NODE_MAILBOX_VSEC},
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata mailbox_drvdata = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = mailbox_leaf_ioctl,
+	},
+	.xsd_file_ops = {
+		.xsf_ops = {
+			.owner = THIS_MODULE,
+			.open = mailbox_open,
+			.release = mailbox_close,
+			.read = mailbox_read,
+			.write = mailbox_write,
+			.poll = mailbox_poll,
+		},
+		.xsf_dev_name = "mailbox",
+	},
+};
+
+#define	XRT_MAILBOX	"xrt_mailbox"
+
+struct platform_device_id mailbox_id_table[] = {
+	{ XRT_MAILBOX, (kernel_ulong_t)&mailbox_drvdata },
+	{ },
+};
+
+struct platform_driver xrt_mailbox_driver = {
+	.probe		= mailbox_probe,
+	.remove		= mailbox_remove,
+	.driver		= {
+		.name	= XRT_MAILBOX,
+	},
+	.id_table = mailbox_id_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-partition.c b/drivers/fpga/alveo/lib/subdevs/xrt-partition.c
new file mode 100644
index 000000000000..eb2418a0bfb1
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-partition.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Partition Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-partition.h"
+#include "xrt-metadata.h"
+#include "../xrt-main.h"
+
+#define	XRT_PART "xrt_partition"
+
+struct xrt_partition {
+	struct platform_device *pdev;
+	struct xrt_subdev_pool leaves;
+	bool leaves_created;
+	struct mutex lock;
+};
+
+static int xrt_part_parent_cb(struct device *dev, void *parg,
+	u32 cmd, void *arg)
+{
+	int rc;
+	struct platform_device *pdev =
+		container_of(dev, struct platform_device, dev);
+	struct xrt_partition *xp = (struct xrt_partition *)parg;
+
+	switch (cmd) {
+	case XRT_PARENT_GET_LEAF_HOLDERS: {
+		struct xrt_parent_ioctl_get_holders *holders =
+			(struct xrt_parent_ioctl_get_holders *)arg;
+		rc = xrt_subdev_pool_get_holders(&xp->leaves,
+			holders->xpigh_pdev, holders->xpigh_holder_buf,
+			holders->xpigh_holder_buf_len);
+		break;
+	}
+	default:
+		/* Forward parent call to root. */
+		rc = xrt_subdev_parent_ioctl(pdev, cmd, arg);
+		break;
+	}
+
+	return rc;
+}
+
+static int xrt_part_create_leaves(struct xrt_partition *xp)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xp->pdev);
+	enum xrt_subdev_id did;
+	struct xrt_subdev_endpoints *eps = NULL;
+	int ep_count = 0, i, ret = 0, failed = 0;
+	long mlen;
+	char *dtb, *part_dtb = NULL;
+	const char *ep_name;
+
+
+	mutex_lock(&xp->lock);
+
+	if (xp->leaves_created) {
+		mutex_unlock(&xp->lock);
+		return -EEXIST;
+	}
+
+	xrt_info(xp->pdev, "bringing up leaves...");
+
+	/* Create all leaves based on dtb. */
+	if (!pdata)
+		goto bail;
+
+	mlen = xrt_md_size(DEV(xp->pdev), pdata->xsp_dtb);
+	if (mlen <= 0) {
+		xrt_err(xp->pdev, "invalid dtb, len %ld", mlen);
+		goto bail;
+	}
+
+	part_dtb = vmalloc(mlen);
+	if (!part_dtb)
+		goto bail;
+
+	memcpy(part_dtb, pdata->xsp_dtb, mlen);
+	for (did = 0; did < XRT_SUBDEV_NUM;) {
+		eps = eps ? eps + 1 : xrt_drv_get_endpoints(did);
+		if (!eps || !eps->xse_names) {
+			did++;
+			eps = NULL;
+			continue;
+		}
+		ret = xrt_md_create(DEV(xp->pdev), &dtb);
+		if (ret) {
+			xrt_err(xp->pdev, "create md failed, drv %s",
+				xrt_drv_name(did));
+			failed++;
+			continue;
+		}
+		for (i = 0; eps->xse_names[i].ep_name ||
+		    eps->xse_names[i].regmap_name; i++) {
+			if (!eps->xse_names[i].ep_name) {
+				ret = xrt_md_get_compatible_epname(
+					DEV(xp->pdev), part_dtb,
+					eps->xse_names[i].regmap_name,
+					&ep_name);
+				if (ret)
+					continue;
+			} else
+				ep_name = (char *)eps->xse_names[i].ep_name;
+			ret = xrt_md_copy_endpoint(DEV(xp->pdev),
+				dtb, part_dtb, ep_name,
+				(char *)eps->xse_names[i].regmap_name, NULL);
+			if (ret)
+				continue;
+			xrt_md_del_endpoint(DEV(xp->pdev), part_dtb, ep_name,
+				(char *)eps->xse_names[i].regmap_name);
+			ep_count++;
+		}
+		if (ep_count >= eps->xse_min_ep) {
+			ret = xrt_subdev_pool_add(&xp->leaves, did,
+				xrt_part_parent_cb, xp, dtb);
+			eps = NULL;
+			if (ret < 0) {
+				failed++;
+				xrt_err(xp->pdev, "failed to create %s: %d",
+					xrt_drv_name(did), ret);
+			}
+		} else if (ep_count > 0) {
+			xrt_md_copy_all_eps(DEV(xp->pdev), part_dtb, dtb);
+		}
+		vfree(dtb);
+		ep_count = 0;
+	}
+
+	xp->leaves_created = true;
+
+bail:
+	mutex_unlock(&xp->lock);
+
+	if (part_dtb)
+		vfree(part_dtb);
+
+	return failed == 0 ? 0 : -ECHILD;
+}
+
+static int xrt_part_remove_leaves(struct xrt_partition *xp)
+{
+	int rc;
+
+	mutex_lock(&xp->lock);
+
+	if (!xp->leaves_created) {
+		mutex_unlock(&xp->lock);
+		return 0;
+	}
+
+	xrt_info(xp->pdev, "tearing down leaves...");
+	rc = xrt_subdev_pool_fini(&xp->leaves);
+	xp->leaves_created = false;
+
+	mutex_unlock(&xp->lock);
+
+	return rc;
+}
+
+static int xrt_part_probe(struct platform_device *pdev)
+{
+	struct xrt_partition *xp;
+
+	xrt_info(pdev, "probing...");
+
+	xp = devm_kzalloc(&pdev->dev, sizeof(*xp), GFP_KERNEL);
+	if (!xp)
+		return -ENOMEM;
+
+	xp->pdev = pdev;
+	mutex_init(&xp->lock);
+	xrt_subdev_pool_init(DEV(pdev), &xp->leaves);
+	platform_set_drvdata(pdev, xp);
+
+	return 0;
+}
+
+static int xrt_part_remove(struct platform_device *pdev)
+{
+	struct xrt_partition *xp = platform_get_drvdata(pdev);
+
+	xrt_info(pdev, "leaving...");
+	return xrt_part_remove_leaves(xp);
+}
+
+static int xrt_part_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	int rc = 0;
+	struct xrt_partition *xp = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_PARTITION_GET_LEAF: {
+		struct xrt_parent_ioctl_get_leaf *get_leaf =
+			(struct xrt_parent_ioctl_get_leaf *)arg;
+
+		rc = xrt_subdev_pool_get(&xp->leaves, get_leaf->xpigl_match_cb,
+			get_leaf->xpigl_match_arg, DEV(get_leaf->xpigl_pdev),
+			&get_leaf->xpigl_leaf);
+		break;
+	}
+	case XRT_PARTITION_PUT_LEAF: {
+		struct xrt_parent_ioctl_put_leaf *put_leaf =
+			(struct xrt_parent_ioctl_put_leaf *)arg;
+
+		rc = xrt_subdev_pool_put(&xp->leaves, put_leaf->xpipl_leaf,
+			DEV(put_leaf->xpipl_pdev));
+		break;
+	}
+	case XRT_PARTITION_INIT_CHILDREN:
+		rc = xrt_part_create_leaves(xp);
+		break;
+	case XRT_PARTITION_FINI_CHILDREN:
+		rc = xrt_part_remove_leaves(xp);
+		break;
+	case XRT_PARTITION_EVENT: {
+		struct xrt_partition_ioctl_event *evt =
+			(struct xrt_partition_ioctl_event *)arg;
+		struct xrt_parent_ioctl_evt_cb *cb = evt->xpie_cb;
+
+		rc = xrt_subdev_pool_event(&xp->leaves, cb->xevt_pdev,
+			cb->xevt_match_cb, cb->xevt_match_arg, cb->xevt_cb,
+			evt->xpie_evt);
+		break;
+	}
+	default:
+		xrt_err(pdev, "unknown IOCTL cmd %d", cmd);
+		rc = -EINVAL;
+		break;
+	}
+	return rc;
+}
+
+struct xrt_subdev_drvdata xrt_part_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_part_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_part_id_table[] = {
+	{ XRT_PART, (kernel_ulong_t)&xrt_part_data },
+	{ },
+};
+
+struct platform_driver xrt_partition_driver = {
+	.driver	= {
+		.name    = XRT_PART,
+	},
+	.probe   = xrt_part_probe,
+	.remove  = xrt_part_remove,
+	.id_table = xrt_part_id_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-qspi.c b/drivers/fpga/alveo/lib/subdevs/xrt-qspi.c
new file mode 100644
index 000000000000..c8ae5c386983
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-qspi.c
@@ -0,0 +1,1347 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA QSPI flash controller Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-flash.h"
+
+#define	XRT_QSPI "xrt_qspi"
+
+/* Status write command */
+#define QSPI_CMD_STATUSREG_WRITE		0x01
+/* Page Program command */
+#define QSPI_CMD_PAGE_PROGRAM			0x02
+/* Random read command */
+#define QSPI_CMD_RANDOM_READ			0x03
+/* Status read command */
+#define QSPI_CMD_STATUSREG_READ			0x05
+/* Enable flash write */
+#define QSPI_CMD_WRITE_ENABLE			0x06
+/* 4KB Subsector Erase command */
+#define QSPI_CMD_4KB_SUBSECTOR_ERASE		0x20
+/* Quad Input Fast Program */
+#define QSPI_CMD_QUAD_WRITE			0x32
+/* Extended quad input fast program */
+#define QSPI_CMD_EXT_QUAD_WRITE			0x38
+/* Dual Output Fast Read */
+#define QSPI_CMD_DUAL_READ			0x3B
+/* Clear flag register */
+#define QSPI_CMD_CLEAR_FLAG_REGISTER		0x50
+/* 32KB Subsector Erase command */
+#define QSPI_CMD_32KB_SUBSECTOR_ERASE		0x52
+/* Enhanced volatile configuration register write command */
+#define QSPI_CMD_ENH_VOLATILE_CFGREG_WRITE	0x61
+/* Enhanced volatile configuration register read command */
+#define QSPI_CMD_ENH_VOLATILE_CFGREG_READ	0x65
+/* Quad Output Fast Read */
+#define QSPI_CMD_QUAD_READ			0x6B
+/* Status flag read command */
+#define QSPI_CMD_FLAG_STATUSREG_READ		0x70
+/* Volatile configuration register write command */
+#define QSPI_CMD_VOLATILE_CFGREG_WRITE		0x81
+/* Volatile configuration register read command */
+#define QSPI_CMD_VOLATILE_CFGREG_READ		0x85
+/* Read ID Code */
+#define QSPI_CMD_IDCODE_READ			0x9F
+/* Non volatile configuration register write command */
+#define QSPI_CMD_NON_VOLATILE_CFGREG_WRITE	0xB1
+/* Non volatile configuration register read command */
+#define QSPI_CMD_NON_VOLATILE_CFGREG_READ	0xB5
+/* Dual IO Fast Read */
+#define QSPI_CMD_DUAL_IO_READ			0xBB
+/* Enhanced volatile configuration register write command */
+#define QSPI_CMD_EXTENDED_ADDRESS_REG_WRITE	0xC5
+/* Bulk Erase command */
+#define QSPI_CMD_BULK_ERASE			0xC7
+/* Enhanced volatile configuration register read command */
+#define QSPI_CMD_EXTENDED_ADDRESS_REG_READ	0xC8
+/* Sector Erase command */
+#define QSPI_CMD_SECTOR_ERASE			0xD8
+/* Quad IO Fast Read */
+#define QSPI_CMD_QUAD_IO_READ			0xEB
+
+#define	QSPI_ERR(flash, fmt, arg...)	xrt_err((flash)->pdev, fmt, ##arg)
+#define	QSPI_WARN(flash, fmt, arg...)	xrt_warn((flash)->pdev, fmt, ##arg)
+#define	QSPI_INFO(flash, fmt, arg...)	xrt_info((flash)->pdev, fmt, ##arg)
+#define	QSPI_DBG(flash, fmt, arg...)	xrt_dbg((flash)->pdev, fmt, ##arg)
+
+/*
+ * QSPI control reg bits.
+ */
+#define QSPI_CR_LOOPBACK		(1 << 0)
+#define QSPI_CR_ENABLED			(1 << 1)
+#define QSPI_CR_MASTER_MODE		(1 << 2)
+#define QSPI_CR_CLK_POLARITY		(1 << 3)
+#define QSPI_CR_CLK_PHASE		(1 << 4)
+#define QSPI_CR_TXFIFO_RESET		(1 << 5)
+#define QSPI_CR_RXFIFO_RESET		(1 << 6)
+#define QSPI_CR_MANUAL_SLAVE_SEL	(1 << 7)
+#define QSPI_CR_TRANS_INHIBIT		(1 << 8)
+#define QSPI_CR_LSB_FIRST		(1 << 9)
+#define QSPI_CR_INIT_STATE		(QSPI_CR_TRANS_INHIBIT		| \
+					QSPI_CR_MANUAL_SLAVE_SEL	| \
+					QSPI_CR_RXFIFO_RESET		| \
+					QSPI_CR_TXFIFO_RESET		| \
+					QSPI_CR_ENABLED			| \
+					QSPI_CR_MASTER_MODE)
+
+/*
+ * QSPI status reg bits.
+ */
+#define QSPI_SR_RX_EMPTY		(1 << 0)
+#define QSPI_SR_RX_FULL			(1 << 1)
+#define QSPI_SR_TX_EMPTY		(1 << 2)
+#define QSPI_SR_TX_FULL			(1 << 3)
+#define QSPI_SR_MODE_ERR		(1 << 4)
+#define QSPI_SR_SLAVE_MODE		(1 << 5)
+#define QSPI_SR_CPOL_CPHA_ERR		(1 << 6)
+#define QSPI_SR_SLAVE_MODE_ERR		(1 << 7)
+#define QSPI_SR_MSB_ERR			(1 << 8)
+#define QSPI_SR_LOOPBACK_ERR		(1 << 9)
+#define QSPI_SR_CMD_ERR			(1 << 10)
+#define QSPI_SR_ERRS			(QSPI_SR_CMD_ERR	|	\
+					QSPI_SR_LOOPBACK_ERR	|	\
+					QSPI_SR_MSB_ERR		|	\
+					QSPI_SR_SLAVE_MODE_ERR	|	\
+					QSPI_SR_CPOL_CPHA_ERR	|	\
+					QSPI_SR_MODE_ERR)
+
+#define	MAX_NUM_OF_SLAVES	2
+#define	SLAVE_NONE		(-1)
+#define SLAVE_SELECT_NONE	((1 << MAX_NUM_OF_SLAVES) - 1)
+
+/*
+ * We support erasing flash memory at three page unit. Page read-modify-write
+ * is done at smallest page unit.
+ */
+#define	QSPI_LARGE_PAGE_SIZE	(32UL * 1024)
+#define	QSPI_HUGE_PAGE_SIZE	(64UL * 1024)
+#define	QSPI_PAGE_SIZE		(4UL * 1024)
+#define	QSPI_PAGE_MASK		(QSPI_PAGE_SIZE - 1)
+#define	QSPI_PAGE_ALIGN(off)	((off) & ~QSPI_PAGE_MASK)
+#define	QSPI_PAGE_OFFSET(off)	((off) & QSPI_PAGE_MASK)
+static inline size_t QSPI_PAGE_ROUNDUP(loff_t offset)
+{
+	if (QSPI_PAGE_OFFSET(offset))
+		return round_up(offset, QSPI_PAGE_SIZE);
+	return offset + QSPI_PAGE_SIZE;
+}
+
+/*
+ * Wait for condition to be true for at most 1 second.
+ * Return true, if time'd out, false otherwise.
+ */
+#define QSPI_BUSY_WAIT(condition)					\
+({									\
+	const int interval = 5; /* in microsec */			\
+	int retry = 1000 * 1000 / interval; /* wait for 1 second */	\
+	while (retry && !(condition)) {					\
+		udelay(interval);					\
+		retry--;						\
+	}								\
+	(retry == 0);							\
+})
+
+static size_t micron_code2sectors(u8 code)
+{
+	size_t max_sectors = 0;
+
+	switch (code) {
+	case 0x17:
+		max_sectors = 1;
+		break;
+	case 0x18:
+		max_sectors = 1;
+		break;
+	case 0x19:
+		max_sectors = 2;
+		break;
+	case 0x20:
+		max_sectors = 4;
+		break;
+	case 0x21:
+		max_sectors = 8;
+		break;
+	case 0x22:
+		max_sectors = 16;
+		break;
+	default:
+		break;
+	}
+	return max_sectors;
+}
+
+static size_t macronix_code2sectors(u8 code)
+{
+	if (code < 0x38 || code > 0x3c)
+		return 0;
+	return (1 << (code - 0x38));
+}
+
+static u8 macronix_write_cmd(void)
+{
+	return QSPI_CMD_PAGE_PROGRAM;
+}
+
+static u8 micron_write_cmd(void)
+{
+	return QSPI_CMD_QUAD_WRITE;
+}
+
+/*
+ * Flash memory vendor specific operations.
+ */
+static struct qspi_flash_vendor {
+	u8 vendor_id;
+	const char *vendor_name;
+	size_t (*code2sectors)(u8 code);
+	u8 (*write_cmd)(void);
+} vendors[] = {
+	{ 0x20, "micron", micron_code2sectors, micron_write_cmd },
+	{ 0xc2, "macronix", macronix_code2sectors, macronix_write_cmd },
+};
+
+struct qspi_flash_addr {
+	u8 slave;
+	u8 sector;
+	u8 addr_lo;
+	u8 addr_mid;
+	u8 addr_hi;
+};
+
+/*
+ * QSPI flash controller IP register layout
+ */
+struct qspi_reg {
+	u32	qspi_padding1[16];
+	u32	qspi_reset;
+	u32	qspi_padding2[7];
+	u32	qspi_ctrl;
+	u32	qspi_status;
+	u32	qspi_tx;
+	u32	qspi_rx;
+	u32	qspi_slave;
+	u32	qspi_tx_fifo;
+	u32	qspi_rx_fifo;
+} __packed;
+
+struct xrt_qspi {
+	struct platform_device	*pdev;
+	struct resource *res;
+	struct mutex io_lock;
+	size_t flash_size;
+	u8 *io_buf;
+	struct qspi_reg *qspi_regs;
+	size_t qspi_fifo_depth;
+	u8 qspi_curr_sector;
+	struct qspi_flash_vendor *vendor;
+	int qspi_curr_slave;
+};
+
+static inline const char *reg2name(struct xrt_qspi *flash, u32 *reg)
+{
+	static const char * const reg_names[] = {
+		"qspi_ctrl",
+		"qspi_status",
+		"qspi_tx",
+		"qspi_rx",
+		"qspi_slave",
+		"qspi_tx_fifo",
+		"qspi_rx_fifo",
+	};
+	size_t off = (uintptr_t)reg - (uintptr_t)flash->qspi_regs;
+
+	if (off == offsetof(struct qspi_reg, qspi_reset))
+		return "qspi_reset";
+	if (off < offsetof(struct qspi_reg, qspi_ctrl))
+		return "padding";
+	off -= offsetof(struct qspi_reg, qspi_ctrl);
+	return reg_names[off / sizeof(u32)];
+}
+
+static inline u32 qspi_reg_rd(struct xrt_qspi *flash, u32 *reg)
+{
+	u32 val = ioread32(reg);
+
+	QSPI_DBG(flash, "REG_RD(%s)=0x%x", reg2name(flash, reg), val);
+	return val;
+}
+
+static inline void qspi_reg_wr(struct xrt_qspi *flash, u32 *reg, u32 val)
+{
+	QSPI_DBG(flash, "REG_WR(%s,0x%x)", reg2name(flash, reg), val);
+	iowrite32(val, reg);
+}
+
+static inline u32 qspi_get_status(struct xrt_qspi *flash)
+{
+	return qspi_reg_rd(flash, &flash->qspi_regs->qspi_status);
+}
+
+static inline u32 qspi_get_ctrl(struct xrt_qspi *flash)
+{
+	return qspi_reg_rd(flash, &flash->qspi_regs->qspi_ctrl);
+}
+
+static inline void qspi_set_ctrl(struct xrt_qspi *flash, u32 ctrl)
+{
+	qspi_reg_wr(flash, &flash->qspi_regs->qspi_ctrl, ctrl);
+}
+
+static inline void qspi_activate_slave(struct xrt_qspi *flash, int index)
+{
+	u32 slave_reg;
+
+	if (index == SLAVE_NONE)
+		slave_reg = SLAVE_SELECT_NONE;
+	else
+		slave_reg = ~(1 << index);
+	qspi_reg_wr(flash, &flash->qspi_regs->qspi_slave, slave_reg);
+}
+
+/*
+ * Pull one byte from flash RX fifo.
+ * So far, only 8-bit data width is supported.
+ */
+static inline u8 qspi_read8(struct xrt_qspi *flash)
+{
+	return (u8)qspi_reg_rd(flash, &flash->qspi_regs->qspi_rx);
+}
+
+/*
+ * Push one byte to flash TX fifo.
+ * So far, only 8-bit data width is supported.
+ */
+static inline void qspi_send8(struct xrt_qspi *flash, u8 val)
+{
+	qspi_reg_wr(flash, &flash->qspi_regs->qspi_tx, val);
+}
+
+static inline bool qspi_has_err(struct xrt_qspi *flash)
+{
+	u32 status = qspi_get_status(flash);
+
+	if (!(status & QSPI_SR_ERRS))
+		return false;
+
+	QSPI_ERR(flash, "QSPI error status: 0x%x", status);
+	return true;
+}
+
+/*
+ * Caller should make sure the flash controller has exactly
+ * len bytes in the fifo. It's an error if we pull out less.
+ */
+static int qspi_rx(struct xrt_qspi *flash, u8 *buf, size_t len)
+{
+	size_t cnt;
+	u8 c;
+
+	for (cnt = 0; cnt < len; cnt++) {
+		if ((qspi_get_status(flash) & QSPI_SR_RX_EMPTY) != 0)
+			return -EINVAL;
+
+		c = qspi_read8(flash);
+
+		if (buf)
+			buf[cnt] = c;
+	}
+
+	if ((qspi_get_status(flash) & QSPI_SR_RX_EMPTY) == 0) {
+		QSPI_ERR(flash, "failed to drain RX fifo");
+		return -EINVAL;
+	}
+
+	if (qspi_has_err(flash))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Caller should make sure the fifo is large enough to host len bytes.
+ */
+static int qspi_tx(struct xrt_qspi *flash, u8 *buf, size_t len)
+{
+	u32 ctrl = qspi_get_ctrl(flash);
+	int i;
+
+	BUG_ON(len > flash->qspi_fifo_depth);
+
+	/* Stop transfering to the flash. */
+	qspi_set_ctrl(flash, ctrl | QSPI_CR_TRANS_INHIBIT);
+
+	/* Fill out the FIFO. */
+	for (i = 0; i < len; i++)
+		qspi_send8(flash, buf[i]);
+
+	/* Start transfering to the flash. */
+	qspi_set_ctrl(flash, ctrl & ~QSPI_CR_TRANS_INHIBIT);
+
+	/* Waiting for FIFO to become empty again. */
+	if (QSPI_BUSY_WAIT(qspi_get_status(flash) &
+		(QSPI_SR_TX_EMPTY | QSPI_SR_ERRS))) {
+		if (qspi_has_err(flash)) {
+			QSPI_ERR(flash, "QSPI write failed");
+		} else {
+			QSPI_ERR(flash, "QSPI write timeout, status: 0x%x",
+				qspi_get_status(flash));
+		}
+		return -ETIMEDOUT;
+	}
+
+	/* Always stop transfering to the flash after we finish. */
+	qspi_set_ctrl(flash, ctrl | QSPI_CR_TRANS_INHIBIT);
+
+	if (qspi_has_err(flash))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Reset both RX and TX FIFO.
+ */
+static int qspi_reset_fifo(struct xrt_qspi *flash)
+{
+	const u32 status_fifo_mask = QSPI_SR_TX_FULL | QSPI_SR_RX_FULL |
+		QSPI_SR_TX_EMPTY | QSPI_SR_RX_EMPTY;
+	u32 fifo_status = qspi_get_status(flash) & status_fifo_mask;
+
+	if (fifo_status == (QSPI_SR_TX_EMPTY | QSPI_SR_RX_EMPTY))
+		return 0;
+
+	qspi_set_ctrl(flash, qspi_get_ctrl(flash) | QSPI_CR_TXFIFO_RESET |
+		QSPI_CR_RXFIFO_RESET);
+
+	if (QSPI_BUSY_WAIT((qspi_get_status(flash) & status_fifo_mask) ==
+		(QSPI_SR_TX_EMPTY | QSPI_SR_RX_EMPTY))) {
+		QSPI_ERR(flash, "failed to reset FIFO, status: 0x%x",
+			qspi_get_status(flash));
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static int qspi_transaction(struct xrt_qspi *flash,
+	u8 *buf, size_t len, bool need_output)
+{
+	int ret = 0;
+
+	/* Reset both the TX and RX fifo before starting transaction. */
+	ret = qspi_reset_fifo(flash);
+	if (ret)
+		return ret;
+
+	/* The slave index should be within range. */
+	if (flash->qspi_curr_slave >= MAX_NUM_OF_SLAVES)
+		return -EINVAL;
+	qspi_activate_slave(flash, flash->qspi_curr_slave);
+
+	ret = qspi_tx(flash, buf, len);
+	if (ret)
+		return ret;
+
+	if (need_output) {
+		ret = qspi_rx(flash, buf, len);
+	} else {
+		/* Needs to drain the FIFO even when the data is not wanted. */
+		(void) qspi_rx(flash, NULL, len);
+	}
+
+	/* Always need to reset slave select register after each transaction */
+	qspi_activate_slave(flash, SLAVE_NONE);
+
+	return ret;
+}
+
+static size_t qspi_get_fifo_depth(struct xrt_qspi *flash)
+{
+	size_t depth = 0;
+	u32 ctrl;
+
+	/* Reset TX fifo. */
+	if (qspi_reset_fifo(flash))
+		return depth;
+
+	/* Stop transfering to flash. */
+	ctrl = qspi_get_ctrl(flash);
+	qspi_set_ctrl(flash, ctrl | QSPI_CR_TRANS_INHIBIT);
+
+	/*
+	 * Find out fifo depth by keep pushing data to QSPI until
+	 * the fifo is full. We can choose to send any data. But
+	 * sending 0 seems to cause error, so pick a non-zero one.
+	 */
+	while (!(qspi_get_status(flash) & (QSPI_SR_TX_FULL | QSPI_SR_ERRS))) {
+		qspi_send8(flash, 1);
+		depth++;
+	}
+
+	/* Make sure flash is still in good shape. */
+	if (qspi_has_err(flash))
+		return 0;
+
+	/* Reset RX/TX fifo and restore ctrl since we just touched them. */
+	qspi_set_ctrl(flash, ctrl);
+	(void) qspi_reset_fifo(flash);
+
+	return depth;
+}
+
+/*
+ * Exec flash IO command on specified slave.
+ */
+static inline int qspi_exec_io_cmd(struct xrt_qspi *flash,
+	size_t len, bool output_needed)
+{
+	char *buf = flash->io_buf;
+
+	return qspi_transaction(flash, buf, len, output_needed);
+}
+
+/* Test if flash memory is ready. */
+static bool qspi_is_ready(struct xrt_qspi *flash)
+{
+	/*
+	 * Reading flash device status input needs a dummy byte
+	 * after cmd byte. The output is in the 2nd byte.
+	 */
+	u8 cmd[2] = { QSPI_CMD_STATUSREG_READ, };
+	int ret = qspi_transaction(flash, cmd, sizeof(cmd), true);
+
+	if (ret || (cmd[1] & 0x1)) // flash device is busy
+		return false;
+
+	return true;
+}
+
+static int qspi_enable_write(struct xrt_qspi *flash)
+{
+	u8 cmd = QSPI_CMD_WRITE_ENABLE;
+	int ret = qspi_transaction(flash, &cmd, 1, false);
+
+	if (ret)
+		QSPI_ERR(flash, "Failed to enable flash write: %d", ret);
+	return ret;
+}
+
+static int qspi_set_sector(struct xrt_qspi *flash, u8 sector)
+{
+	int ret = 0;
+	u8 cmd[] = { QSPI_CMD_EXTENDED_ADDRESS_REG_WRITE, sector };
+
+	if (sector == flash->qspi_curr_sector)
+		return 0;
+
+	QSPI_DBG(flash, "setting sector to %d", sector);
+
+	ret = qspi_enable_write(flash);
+	if (ret)
+		return ret;
+
+	ret = qspi_transaction(flash, cmd, sizeof(cmd), false);
+	if (ret) {
+		QSPI_ERR(flash, "Failed to set sector %d: %d", sector, ret);
+		return ret;
+	}
+
+	flash->qspi_curr_sector = sector;
+	return ret;
+}
+
+/* For 24 bit addressing. */
+static inline void qspi_offset2faddr(loff_t addr, struct qspi_flash_addr *faddr)
+{
+	faddr->slave = (u8)(addr >> 56);
+	faddr->sector = (u8)(addr >> 24);
+	faddr->addr_lo = (u8)(addr);
+	faddr->addr_mid = (u8)(addr >> 8);
+	faddr->addr_hi = (u8)(addr >> 16);
+}
+
+static inline loff_t qspi_faddr2offset(struct qspi_flash_addr *faddr)
+{
+	loff_t off = 0;
+
+	off |= faddr->sector;
+	off <<= 8;
+	off |= faddr->addr_hi;
+	off <<= 8;
+	off |= faddr->addr_mid;
+	off <<= 8;
+	off |= faddr->addr_lo;
+	off |= ((u64)faddr->slave) << 56;
+	return off;
+}
+
+/* IO cmd starts with op code followed by address. */
+static inline int
+qspi_setup_io_cmd_header(struct xrt_qspi *flash,
+	u8 op, struct qspi_flash_addr *faddr, size_t *header_len)
+{
+	int ret = 0;
+
+	/* Set sector (the high byte of a 32-bit address), if needed. */
+	ret = qspi_set_sector(flash, faddr->sector);
+	if (ret == 0) {
+		/* The rest of address bytes are in cmd. */
+		flash->io_buf[0] = op;
+		flash->io_buf[1] = faddr->addr_hi;
+		flash->io_buf[2] = faddr->addr_mid;
+		flash->io_buf[3] = faddr->addr_lo;
+		*header_len = 4;
+	}
+	return ret;
+}
+
+static bool qspi_wait_until_ready(struct xrt_qspi *flash)
+{
+	if (QSPI_BUSY_WAIT(qspi_is_ready(flash))) {
+		QSPI_ERR(flash, "QSPI flash device is not ready");
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Do one FIFO read from flash.
+ * @cnt contains bytes actually read on successful return.
+ */
+static int qspi_fifo_rd(struct xrt_qspi *flash,
+	loff_t off, u8 *buf, size_t *cnt)
+{
+	/* For read cmd, we need to exclude a few more dummy bytes in FIFO. */
+	const size_t read_dummy_len = 4;
+
+	int ret;
+	struct qspi_flash_addr faddr;
+	size_t header_len, total_len, payload_len;
+
+	/* Should not cross page bundary. */
+	BUG_ON(off + *cnt > QSPI_PAGE_ROUNDUP(off));
+	qspi_offset2faddr(off, &faddr);
+
+	ret = qspi_setup_io_cmd_header(flash,
+		QSPI_CMD_QUAD_READ, &faddr, &header_len);
+	if (ret)
+		return ret;
+
+	/* Figure out length of IO for this read. */
+
+	/*
+	 * One read should not be more than one fifo depth, so that we don't
+	 * overrun flash->io_buf.
+	 * The first header_len + read_dummy_len bytes in output buffer are
+	 * always garbage, need to make room for them. What a wonderful memory
+	 * controller!!
+	 */
+	payload_len = min(*cnt,
+		flash->qspi_fifo_depth - header_len - read_dummy_len);
+	total_len = payload_len + header_len + read_dummy_len;
+
+	QSPI_DBG(flash, "reading %ld bytes @0x%llx", payload_len, off);
+
+	/* Now do the read. */
+
+	/*
+	 * You tell the memory controller how many bytes you want to read
+	 * by writing that many bytes to it. How hard would it be to just
+	 * add one more integer to specify the length in the input cmd?!
+	 */
+	ret = qspi_exec_io_cmd(flash, total_len, true);
+	if (ret)
+		return ret;
+
+	/* Copy out the output. Skip the garbage part. */
+	memcpy(buf, &flash->io_buf[header_len + read_dummy_len], payload_len);
+	*cnt = payload_len;
+	return 0;
+}
+
+/*
+ * Do one FIFO write to flash. Assuming erase is already done.
+ * @cnt contains bytes actually written on successful return.
+ */
+static int qspi_fifo_wr(struct xrt_qspi *flash,
+	loff_t off, u8 *buf, size_t *cnt)
+{
+	/*
+	 * For write cmd, we can't write more than write_max_len bytes in one
+	 * IO request even though we have larger fifo. Otherwise, writes will
+	 * randomly fail.
+	 */
+	const size_t write_max_len = 128UL;
+
+	int ret;
+	struct qspi_flash_addr faddr;
+	size_t header_len, total_len, payload_len;
+
+	qspi_offset2faddr(off, &faddr);
+
+	ret = qspi_setup_io_cmd_header(flash,
+		flash->vendor->write_cmd(), &faddr, &header_len);
+	if (ret)
+		return ret;
+
+	/* Figure out length of IO for this write. */
+
+	/*
+	 * One IO should not be more than one fifo depth, so that we don't
+	 * overrun flash->io_buf. And we don't go beyond the write_max_len;
+	 */
+	payload_len = min(*cnt, flash->qspi_fifo_depth - header_len);
+	payload_len = min(payload_len, write_max_len);
+	total_len = payload_len + header_len;
+
+	QSPI_DBG(flash, "writing %ld bytes @0x%llx", payload_len, off);
+
+	/* Copy in payload after header. */
+	memcpy(&flash->io_buf[header_len], buf, payload_len);
+
+	/* Now do the write. */
+
+	ret = qspi_enable_write(flash);
+	if (ret)
+		return ret;
+	ret = qspi_exec_io_cmd(flash, total_len, false);
+	if (ret)
+		return ret;
+	if (!qspi_wait_until_ready(flash))
+		return -EINVAL;
+
+	*cnt = payload_len;
+	return 0;
+}
+
+/*
+ * Load/store the whole buf of data from/to flash memory.
+ */
+static int qspi_buf_rdwr(struct xrt_qspi *flash,
+	u8 *buf, loff_t off, size_t len, bool write)
+{
+	int ret = 0;
+	size_t n, curlen;
+
+	for (n = 0; ret == 0 && n < len; n += curlen) {
+		curlen = len - n;
+		if (write)
+			ret = qspi_fifo_wr(flash, off + n, &buf[n], &curlen);
+		else
+			ret = qspi_fifo_rd(flash, off + n, &buf[n], &curlen);
+	}
+
+	/*
+	 * Yield CPU after every buf IO so that Linux does not complain
+	 * about CPU soft lockup.
+	 */
+	schedule();
+	return ret;
+}
+
+static u8 qspi_erase_cmd(size_t pagesz)
+{
+	u8 cmd = 0;
+	const size_t onek = 1024;
+
+	BUG_ON(!IS_ALIGNED(pagesz, onek));
+	switch (pagesz / onek) {
+	case 4:
+		cmd = QSPI_CMD_4KB_SUBSECTOR_ERASE;
+		break;
+	case 32:
+		cmd = QSPI_CMD_32KB_SUBSECTOR_ERASE;
+		break;
+	case 64:
+		cmd = QSPI_CMD_SECTOR_ERASE;
+		break;
+	default:
+		BUG_ON(1);
+		break;
+	}
+	return cmd;
+}
+
+/*
+ * Erase one flash page.
+ */
+static int qspi_page_erase(struct xrt_qspi *flash, loff_t off, size_t pagesz)
+{
+	int ret = 0;
+	struct qspi_flash_addr faddr;
+	size_t cmdlen;
+	u8 cmd = qspi_erase_cmd(pagesz);
+
+	QSPI_DBG(flash, "Erasing 0x%lx bytes @0x%llx with cmd=0x%x",
+		pagesz, off, (u32)cmd);
+
+	BUG_ON(!IS_ALIGNED(off, pagesz));
+	qspi_offset2faddr(off, &faddr);
+
+	if (!qspi_wait_until_ready(flash))
+		return -EINVAL;
+
+	ret = qspi_setup_io_cmd_header(flash, cmd, &faddr, &cmdlen);
+	if (ret)
+		return ret;
+
+	ret = qspi_enable_write(flash);
+	if (ret)
+		return ret;
+
+	ret = qspi_exec_io_cmd(flash, cmdlen, false);
+	if (ret) {
+		QSPI_ERR(flash, "Failed to erase 0x%lx bytes @0x%llx",
+			pagesz, off);
+		return ret;
+	}
+
+	if (!qspi_wait_until_ready(flash))
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool is_valid_offset(struct xrt_qspi *flash, loff_t off)
+{
+	struct qspi_flash_addr faddr;
+
+	qspi_offset2faddr(off, &faddr);
+	/*
+	 * Assuming all flash are of the same size, we use
+	 * offset into flash 0 to perform boundary check.
+	 */
+	faddr.slave = 0;
+	return qspi_faddr2offset(&faddr) < flash->flash_size;
+}
+
+static int
+qspi_do_read(struct xrt_qspi *flash, char *kbuf, size_t n, loff_t off)
+{
+	u8 *page = NULL;
+	size_t cnt = 0;
+	struct qspi_flash_addr faddr;
+	int ret = 0;
+
+	page = vmalloc(QSPI_PAGE_SIZE);
+	if (page == NULL)
+		return -ENOMEM;
+
+	mutex_lock(&flash->io_lock);
+
+	qspi_offset2faddr(off, &faddr);
+	flash->qspi_curr_slave = faddr.slave;
+
+	if (!qspi_wait_until_ready(flash))
+		ret = -EINVAL;
+
+	while (ret == 0 && cnt < n) {
+		loff_t thisoff = off + cnt;
+		size_t thislen = min(n - cnt,
+			QSPI_PAGE_ROUNDUP(thisoff) - (size_t)thisoff);
+		char *thisbuf = &page[QSPI_PAGE_OFFSET(thisoff)];
+
+		ret = qspi_buf_rdwr(flash, thisbuf, thisoff, thislen, false);
+		if (ret)
+			break;
+
+		memcpy(&kbuf[cnt], thisbuf, thislen);
+		cnt += thislen;
+	}
+
+	mutex_unlock(&flash->io_lock);
+	vfree(page);
+	return ret;
+}
+
+/*
+ * Read flash memory page by page into user buf.
+ */
+static ssize_t
+qspi_read(struct file *file, char __user *ubuf, size_t n, loff_t *off)
+{
+	struct xrt_qspi *flash = file->private_data;
+	char *kbuf = NULL;
+	int ret = 0;
+
+	QSPI_INFO(flash, "reading %ld bytes @0x%llx", n, *off);
+
+	if (n == 0 || !is_valid_offset(flash, *off)) {
+		QSPI_ERR(flash, "Can't read: out of boundary");
+		return 0;
+	}
+	n = min(n, flash->flash_size - (size_t)*off);
+	kbuf = vmalloc(n);
+	if (kbuf == NULL)
+		return -ENOMEM;
+
+	ret = qspi_do_read(flash, kbuf, n, *off);
+	if (ret == 0) {
+		if (copy_to_user(ubuf, kbuf, n) != 0)
+			ret = -EFAULT;
+	}
+	vfree(kbuf);
+
+	if (ret)
+		return ret;
+
+	*off += n;
+	return n;
+}
+
+/* Read request from other parts of driver. */
+static int qspi_kernel_read(struct platform_device *pdev,
+	char *buf, size_t n, loff_t off)
+{
+	struct xrt_qspi *flash = platform_get_drvdata(pdev);
+
+	QSPI_INFO(flash, "kernel reading %ld bytes @0x%llx", n, off);
+	return qspi_do_read(flash, buf, n, off);
+}
+
+/*
+ * Write a page. Perform read-modify-write as needed.
+ * @cnt contains actual bytes copied from user on successful return.
+ */
+static int qspi_page_rmw(struct xrt_qspi *flash,
+	const char __user *ubuf, u8 *kbuf, loff_t off, size_t *cnt)
+{
+	loff_t thisoff = QSPI_PAGE_ALIGN(off);
+	size_t front = QSPI_PAGE_OFFSET(off);
+	size_t mid = min(*cnt, QSPI_PAGE_SIZE - front);
+	size_t last = QSPI_PAGE_SIZE - front - mid;
+	u8 *thiskbuf = kbuf;
+	int ret;
+
+	if (front) {
+		ret = qspi_buf_rdwr(flash, thiskbuf, thisoff, front, false);
+		if (ret)
+			return ret;
+	}
+	thisoff += front;
+	thiskbuf += front;
+	if (copy_from_user(thiskbuf, ubuf, mid) != 0)
+		return -EFAULT;
+	*cnt = mid;
+	thisoff += mid;
+	thiskbuf += mid;
+	if (last) {
+		ret = qspi_buf_rdwr(flash, thiskbuf, thisoff, last, false);
+		if (ret)
+			return ret;
+	}
+
+	ret = qspi_page_erase(flash, QSPI_PAGE_ALIGN(off), QSPI_PAGE_SIZE);
+	if (ret == 0) {
+		ret = qspi_buf_rdwr(flash, kbuf, QSPI_PAGE_ALIGN(off),
+			QSPI_PAGE_SIZE, true);
+	}
+	return ret;
+}
+
+static inline size_t qspi_get_page_io_size(loff_t off, size_t sz)
+{
+	if (IS_ALIGNED(off, QSPI_HUGE_PAGE_SIZE) &&
+		sz >= QSPI_HUGE_PAGE_SIZE)
+		return QSPI_HUGE_PAGE_SIZE;
+	if (IS_ALIGNED(off, QSPI_LARGE_PAGE_SIZE) &&
+		sz >= QSPI_LARGE_PAGE_SIZE)
+		return QSPI_LARGE_PAGE_SIZE;
+	if (IS_ALIGNED(off, QSPI_PAGE_SIZE) &&
+		sz >= QSPI_PAGE_SIZE)
+		return QSPI_PAGE_SIZE;
+
+	return 0; // can't do full page IO
+}
+
+/*
+ * Try to erase and write full (large/huge) page.
+ * @cnt contains actual bytes copied from user on successful return.
+ * Needs to fallback to RMW, if not possible.
+ */
+static int qspi_page_wr(struct xrt_qspi *flash,
+	const char __user *ubuf, u8 *kbuf, loff_t off, size_t *cnt)
+{
+	int ret;
+	size_t thislen = qspi_get_page_io_size(off, *cnt);
+
+	if (thislen == 0)
+		return -EOPNOTSUPP;
+
+	*cnt = thislen;
+
+	if (copy_from_user(kbuf, ubuf, thislen) != 0)
+		return -EFAULT;
+
+	ret = qspi_page_erase(flash, off, thislen);
+	if (ret == 0)
+		ret = qspi_buf_rdwr(flash, kbuf, off, thislen, true);
+	return ret;
+}
+
+/*
+ * Write to flash memory page by page from user buf.
+ */
+static ssize_t
+qspi_write(struct file *file, const char __user *buf, size_t n, loff_t *off)
+{
+	struct xrt_qspi *flash = file->private_data;
+	u8 *page = NULL;
+	size_t cnt = 0;
+	int ret = 0;
+	struct qspi_flash_addr faddr;
+
+	QSPI_INFO(flash, "writing %ld bytes @0x%llx", n, *off);
+
+	if (n == 0 || !is_valid_offset(flash, *off)) {
+		QSPI_ERR(flash, "Can't write: out of boundary");
+		return -ENOSPC;
+	}
+	n = min(n, flash->flash_size - (size_t)*off);
+
+	page = vmalloc(QSPI_HUGE_PAGE_SIZE);
+	if (page == NULL)
+		return -ENOMEM;
+
+	mutex_lock(&flash->io_lock);
+
+	qspi_offset2faddr(*off, &faddr);
+	flash->qspi_curr_slave = faddr.slave;
+
+	if (!qspi_wait_until_ready(flash))
+		ret = -EINVAL;
+	while (ret == 0 && cnt < n) {
+		loff_t thisoff = *off + cnt;
+		const char *thisbuf = buf + cnt;
+		size_t thislen = n - cnt;
+
+		/* Try write full page. */
+		ret = qspi_page_wr(flash, thisbuf, page, thisoff, &thislen);
+		if (ret) {
+			/* Fallback to RMW. */
+			if (ret == -EOPNOTSUPP) {
+				ret = qspi_page_rmw(flash, thisbuf, page,
+					thisoff, &thislen);
+			}
+			if (ret)
+				break;
+		}
+		cnt += thislen;
+	}
+	mutex_unlock(&flash->io_lock);
+
+	vfree(page);
+	if (ret)
+		return ret;
+
+	*off += n;
+	return n;
+}
+
+static loff_t
+qspi_llseek(struct file *filp, loff_t off, int whence)
+{
+	loff_t npos;
+
+	switch (whence) {
+	case 0: /* SEEK_SET */
+		npos = off;
+		break;
+	case 1: /* SEEK_CUR */
+		npos = filp->f_pos + off;
+		break;
+	case 2: /* SEEK_END: no need to support */
+		return -EINVAL;
+	default: /* should not happen */
+		return -EINVAL;
+	}
+	if (npos < 0)
+		return -EINVAL;
+
+	filp->f_pos = npos;
+	return npos;
+}
+
+/*
+ * Only allow one client at a time.
+ */
+static int qspi_open(struct inode *inode, struct file *file)
+{
+	struct xrt_qspi *flash;
+	struct platform_device *pdev = xrt_devnode_open_excl(inode);
+
+	if (!pdev)
+		return -EBUSY;
+
+	flash = platform_get_drvdata(pdev);
+	file->private_data = flash;
+	return 0;
+}
+
+static int qspi_close(struct inode *inode, struct file *file)
+{
+	struct xrt_qspi *flash = file->private_data;
+
+	if (!flash)
+		return -EINVAL;
+
+	file->private_data = NULL;
+	xrt_devnode_close(inode);
+	return 0;
+}
+
+static ssize_t flash_type_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	/* We support only QSPI flash controller. */
+	return sprintf(buf, "spi\n");
+}
+static DEVICE_ATTR_RO(flash_type);
+
+static ssize_t size_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xrt_qspi *flash = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%ld\n", flash->flash_size);
+}
+static DEVICE_ATTR_RO(size);
+
+static struct attribute *qspi_attrs[] = {
+	&dev_attr_flash_type.attr,
+	&dev_attr_size.attr,
+	NULL,
+};
+
+static struct attribute_group qspi_attr_group = {
+	.attrs = qspi_attrs,
+};
+
+static int qspi_remove(struct platform_device *pdev)
+{
+	struct xrt_qspi *flash = platform_get_drvdata(pdev);
+
+	if (!flash)
+		return -EINVAL;
+	platform_set_drvdata(pdev, NULL);
+
+	(void) sysfs_remove_group(&DEV(flash->pdev)->kobj, &qspi_attr_group);
+
+	if (flash->io_buf)
+		vfree(flash->io_buf);
+
+	if (flash->qspi_regs)
+		iounmap(flash->qspi_regs);
+
+	mutex_destroy(&flash->io_lock);
+	return 0;
+}
+
+static int qspi_get_ID(struct xrt_qspi *flash)
+{
+	int i;
+	struct qspi_flash_vendor *vendor = NULL;
+	/*
+	 * Reading flash device vendor ID. Vendor ID is in cmd[1], max vector
+	 * number is in cmd[3] from output.
+	 */
+	u8 cmd[5] = { QSPI_CMD_IDCODE_READ, };
+	int ret = qspi_transaction(flash, cmd, sizeof(cmd), true);
+
+	if (ret) {
+		QSPI_ERR(flash, "Can't get flash memory ID, err: %d", ret);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(vendors); i++) {
+		if (cmd[1] == vendors[i].vendor_id) {
+			vendor = &vendors[i];
+			break;
+		}
+	}
+
+	/* Find out flash vendor and size. */
+	if (vendor == NULL) {
+		QSPI_ERR(flash, "Unknown flash vendor: %d", cmd[1]);
+		return -EINVAL;
+	}
+	flash->vendor = vendor;
+
+	flash->flash_size = vendor->code2sectors(cmd[3]) * (16 * 1024 * 1024);
+	if (flash->flash_size == 0) {
+		QSPI_ERR(flash, "Unknown flash memory size code: %d", cmd[3]);
+		return -EINVAL;
+	}
+	QSPI_INFO(flash, "Flash vendor: %s, size: %ldMB",
+		vendor->vendor_name, flash->flash_size / 1024 / 1024);
+
+	return 0;
+}
+
+static int qspi_controller_probe(struct xrt_qspi *flash)
+{
+	int ret;
+
+	/* Probing on first flash only. */
+	flash->qspi_curr_slave = 0;
+
+	qspi_set_ctrl(flash, QSPI_CR_INIT_STATE);
+
+	/* Find out fifo depth before any read/write operations. */
+	flash->qspi_fifo_depth = qspi_get_fifo_depth(flash);
+	if (flash->qspi_fifo_depth == 0)
+		return -EINVAL;
+	QSPI_DBG(flash, "QSPI FIFO depth is: %ld", flash->qspi_fifo_depth);
+
+	if (!qspi_wait_until_ready(flash))
+		return -EINVAL;
+
+	/* Update flash vendor. */
+	ret = qspi_get_ID(flash);
+	if (ret)
+		return ret;
+
+	flash->qspi_curr_sector = 0xff;
+
+	return 0;
+}
+
+static int qspi_probe(struct platform_device *pdev)
+{
+	struct xrt_qspi *flash;
+	int ret;
+
+	flash = devm_kzalloc(DEV(pdev), sizeof(*flash), GFP_KERNEL);
+	if (!flash)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, flash);
+	flash->pdev = pdev;
+
+	mutex_init(&flash->io_lock);
+
+	flash->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!flash->res) {
+		ret = -EINVAL;
+		QSPI_ERR(flash, "empty resource");
+		goto error;
+	}
+
+	flash->qspi_regs = ioremap(flash->res->start,
+		flash->res->end - flash->res->start + 1);
+	if (!flash->qspi_regs) {
+		ret = -ENOMEM;
+		QSPI_ERR(flash, "failed to map resource");
+		goto error;
+	}
+
+	ret = qspi_controller_probe(flash);
+	if (ret)
+		goto error;
+
+	flash->io_buf = vmalloc(flash->qspi_fifo_depth);
+	if (flash->io_buf == NULL) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret  = sysfs_create_group(&DEV(pdev)->kobj, &qspi_attr_group);
+	if (ret)
+		QSPI_ERR(flash, "failed to create sysfs nodes");
+
+	return 0;
+
+error:
+	QSPI_ERR(flash, "probing failed");
+	qspi_remove(pdev);
+	return ret;
+}
+
+static size_t qspi_get_size(struct platform_device *pdev)
+{
+	struct xrt_qspi *flash = platform_get_drvdata(pdev);
+
+	return flash->flash_size;
+}
+
+static int
+qspi_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_qspi *flash = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	QSPI_INFO(flash, "handling IOCTL cmd: %d", cmd);
+
+	switch (cmd) {
+	case XRT_FLASH_GET_SIZE: {
+		size_t *sz = (size_t *)arg;
+		*sz = qspi_get_size(pdev);
+		break;
+	}
+	case XRT_FLASH_READ: {
+		struct xrt_flash_ioctl_read *rd =
+			(struct xrt_flash_ioctl_read *)arg;
+		ret = qspi_kernel_read(pdev,
+			rd->xfir_buf, rd->xfir_size, rd->xfir_offset);
+		break;
+	}
+	default:
+		QSPI_ERR(flash, "unknown flash IOCTL cmd: %d", cmd);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_qspi_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{
+				.ep_name = NODE_FLASH_VSEC,
+			},
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata qspi_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = qspi_leaf_ioctl,
+	},
+	.xsd_file_ops = {
+		.xsf_ops = {
+			.owner = THIS_MODULE,
+			.open = qspi_open,
+			.release = qspi_close,
+			.read = qspi_read,
+			.write = qspi_write,
+			.llseek = qspi_llseek,
+		},
+		.xsf_dev_name = "flash",
+	},
+};
+
+static const struct platform_device_id qspi_id_table[] = {
+	{ XRT_QSPI, (kernel_ulong_t)&qspi_data },
+	{ },
+};
+
+struct platform_driver xrt_qspi_driver = {
+	.driver	= {
+		.name    = XRT_QSPI,
+	},
+	.probe   = qspi_probe,
+	.remove  = qspi_remove,
+	.id_table = qspi_id_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-srsr.c b/drivers/fpga/alveo/lib/subdevs/xrt-srsr.c
new file mode 100644
index 000000000000..150b82990ecb
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-srsr.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo DDR SRSR Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-ddr-srsr.h"
+
+#define XRT_DDR_SRSR "xrt_ddr_srsr"
+
+#define	REG_STATUS_OFFSET		0x00000000
+#define	REG_CTRL_OFFSET			0x00000004
+#define	REG_CALIB_OFFSET		0x00000008
+#define	REG_XSDB_RAM_BASE		0x00004000
+
+#define	FULL_CALIB_TIMEOUT		100
+#define	FAST_CALIB_TIMEOUT		15
+
+#define	CTRL_BIT_SYS_RST		0x00000001
+#define	CTRL_BIT_XSDB_SELECT		0x00000010
+#define	CTRL_BIT_MEM_INIT_SKIP		0x00000020
+#define	CTRL_BIT_RESTORE_EN		0x00000040
+#define	CTRL_BIT_RESTORE_COMPLETE	0x00000080
+#define	CTRL_BIT_SREF_REQ		0x00000100
+
+#define	STATUS_BIT_CALIB_COMPLETE	0x00000001
+#define	STATUS_BIT_SREF_ACK		0x00000100
+
+struct xrt_ddr_srsr {
+	void __iomem		*base;
+	struct platform_device	*pdev;
+	struct mutex		lock;
+	const char		*ep_name;
+};
+
+#define reg_rd(g, offset)	ioread32(g->base + offset)
+#define reg_wr(g, val, offset)	iowrite32(val, g->base + offset)
+
+static ssize_t status_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	u32 status = 1;
+
+	return sprintf(buf, "0x%x\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
+static struct attribute *xrt_ddr_srsr_attributes[] = {
+	&dev_attr_status.attr,
+	NULL
+};
+
+static const struct attribute_group xrt_ddr_srsr_attrgroup = {
+	.attrs = xrt_ddr_srsr_attributes,
+};
+
+static int srsr_full_calib(struct xrt_ddr_srsr *srsr,
+	char **data, u32 *data_len)
+{
+	int i = 0, err = -ETIMEDOUT;
+	u32 val, sz_lo, sz_hi;
+	u32 *cache = NULL;
+
+	mutex_lock(&srsr->lock);
+	reg_wr(srsr, CTRL_BIT_SYS_RST, REG_CTRL_OFFSET);
+	reg_wr(srsr, 0x0, REG_CTRL_OFFSET);
+
+
+	/* Safe to say, full calibration should finish in 2000ms*/
+	for (; i < FULL_CALIB_TIMEOUT; ++i) {
+		val = reg_rd(srsr, REG_STATUS_OFFSET);
+		if (val & STATUS_BIT_CALIB_COMPLETE) {
+			err = 0;
+			break;
+		}
+		msleep(20);
+	}
+
+	if (err) {
+		xrt_err(srsr->pdev, "Calibration timeout");
+		goto failed;
+	}
+
+	xrt_info(srsr->pdev, "calibrate time %dms", i * FULL_CALIB_TIMEOUT);
+
+	/* END_ADDR0/1 provides the end address for a given memory
+	 * configuration
+	 * END_ADDR 0 is lower 9 bits, the other one is higher 9 bits
+	 * E.g. sz_lo = 0x155,     0'b 1 0101 0101
+	 *      sz_hi = 0x5    0'b 0101
+	 *                     0'b 01011 0101 0101
+	 *                   =  0xB55
+	 * and the total size is 0xB55+1
+	 * Check the value, it should not excess predefined XSDB range
+	 */
+	sz_lo = reg_rd(srsr, REG_XSDB_RAM_BASE+4);
+	sz_hi = reg_rd(srsr, REG_XSDB_RAM_BASE+8);
+
+	*data_len = (((sz_hi << 9) | sz_lo) + 1) * sizeof(uint32_t);
+	if (*data_len >= 0x4000) {
+		xrt_err(srsr->pdev, "Invalid data size 0x%x", *data_len);
+		err = -EINVAL;
+		goto failed;
+	}
+
+	cache = vzalloc(*data_len);
+	if (!cache) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = -ETIMEDOUT;
+	reg_wr(srsr, CTRL_BIT_SREF_REQ, REG_CTRL_OFFSET);
+	for ( ; i < FULL_CALIB_TIMEOUT; ++i) {
+		val = reg_rd(srsr, REG_STATUS_OFFSET);
+		if (val == (STATUS_BIT_SREF_ACK|STATUS_BIT_CALIB_COMPLETE)) {
+			err = 0;
+			break;
+		}
+		msleep(20);
+	}
+	if (err) {
+		xrt_err(srsr->pdev, "request data timeout");
+		goto failed;
+	}
+	xrt_info(srsr->pdev, "req data time %dms", i * FULL_CALIB_TIMEOUT);
+
+	reg_wr(srsr, CTRL_BIT_SREF_REQ | CTRL_BIT_XSDB_SELECT, REG_CTRL_OFFSET);
+
+	for (i = 0; i < *data_len / sizeof(u32); ++i) {
+		val = reg_rd(srsr, REG_XSDB_RAM_BASE + i * 4);
+		*(cache + i) = val;
+	}
+	*data = (char *)cache;
+
+	mutex_unlock(&srsr->lock);
+
+	return 0;
+
+failed:
+	mutex_unlock(&srsr->lock);
+	vfree(cache);
+
+	return err;
+}
+
+static int srsr_fast_calib(struct xrt_ddr_srsr *srsr, char *data,
+	u32 data_size, bool retention)
+{
+	int i = 0, err = -ETIMEDOUT;
+	u32 val, write_val = CTRL_BIT_RESTORE_EN | CTRL_BIT_XSDB_SELECT;
+
+	mutex_lock(&srsr->lock);
+	if (retention)
+		write_val |= CTRL_BIT_MEM_INIT_SKIP;
+
+	reg_wr(srsr, write_val, REG_CTRL_OFFSET);
+
+	msleep(20);
+	for (i = 0; i < data_size / sizeof(u32); ++i) {
+		val = *((u32 *)data + i);
+		reg_wr(srsr, val, REG_XSDB_RAM_BASE+i*4);
+	}
+
+	write_val = CTRL_BIT_RESTORE_EN | CTRL_BIT_RESTORE_COMPLETE;
+	if (retention)
+		write_val |= CTRL_BIT_MEM_INIT_SKIP;
+
+	reg_wr(srsr, write_val, REG_CTRL_OFFSET);
+
+	/* Safe to say, fast calibration should finish in 300ms*/
+	for (i = 0; i < FAST_CALIB_TIMEOUT; ++i) {
+		val = reg_rd(srsr, REG_STATUS_OFFSET);
+		if (val & STATUS_BIT_CALIB_COMPLETE) {
+			err = 0;
+			break;
+		}
+		msleep(20);
+	}
+	if (err)
+		xrt_err(srsr->pdev, "timed out");
+	else
+		xrt_info(srsr->pdev, "time %dms", i * FAST_CALIB_TIMEOUT);
+
+	reg_wr(srsr, CTRL_BIT_RESTORE_COMPLETE, REG_CTRL_OFFSET);
+	val = reg_rd(srsr, REG_CTRL_OFFSET);
+
+	mutex_lock(&srsr->lock);
+
+	return err;
+}
+
+static int
+xrt_srsr_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_ddr_srsr *srsr = platform_get_drvdata(pdev);
+	struct xrt_srsr_ioctl_calib *req = arg;
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_SRSR_CALIB:
+		ret = srsr_full_calib(srsr, (char **)req->xsic_buf,
+			&req->xsic_size);
+		break;
+	case XRT_SRSR_FAST_CALIB:
+		ret = srsr_fast_calib(srsr, req->xsic_buf, req->xsic_size,
+			req->xsic_retention);
+		break;
+	case XRT_SRSR_EP_NAME:
+		*(const char **)arg = srsr->ep_name;
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_srsr_probe(struct platform_device *pdev)
+{
+	struct xrt_ddr_srsr *srsr;
+	struct resource *res;
+	int err = 0;
+
+	srsr = devm_kzalloc(&pdev->dev, sizeof(*srsr), GFP_KERNEL);
+	if (!srsr)
+		return -ENOMEM;
+
+	srsr->pdev = pdev;
+	platform_set_drvdata(pdev, srsr);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		goto failed;
+
+	xrt_info(pdev, "IO start: 0x%llx, end: 0x%llx",
+		res->start, res->end);
+
+	srsr->ep_name = res->name;
+	srsr->base = ioremap(res->start, res->end - res->start + 1);
+	if (!srsr->base) {
+		err = -EIO;
+		xrt_err(pdev, "Map iomem failed");
+		goto failed;
+	}
+	mutex_init(&srsr->lock);
+
+	err = sysfs_create_group(&pdev->dev.kobj, &xrt_ddr_srsr_attrgroup);
+	if (err)
+		goto create_xrt_ddr_srsr_failed;
+
+	return 0;
+
+create_xrt_ddr_srsr_failed:
+	platform_set_drvdata(pdev, NULL);
+failed:
+	return err;
+}
+
+static int xrt_srsr_remove(struct platform_device *pdev)
+{
+	struct xrt_ddr_srsr *srsr = platform_get_drvdata(pdev);
+
+	if (!srsr) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	sysfs_remove_group(&pdev->dev.kobj, &xrt_ddr_srsr_attrgroup);
+
+	if (srsr->base)
+		iounmap(srsr->base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, srsr);
+
+	return 0;
+}
+
+struct xrt_subdev_endpoints xrt_srsr_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .regmap_name = REGMAP_DDR_SRSR },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_srsr_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_srsr_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_srsr_table[] = {
+	{ XRT_DDR_SRSR, (kernel_ulong_t)&xrt_srsr_data },
+	{ },
+};
+
+struct platform_driver xrt_ddr_srsr_driver = {
+	.driver = {
+		.name = XRT_DDR_SRSR,
+	},
+	.probe = xrt_srsr_probe,
+	.remove = xrt_srsr_remove,
+	.id_table = xrt_srsr_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-test.c b/drivers/fpga/alveo/lib/subdevs/xrt-test.c
new file mode 100644
index 000000000000..10a940adf493
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-test.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Test Leaf Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/delay.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+
+#define	XRT_TEST "xrt_test"
+
+struct xrt_test {
+	struct platform_device *pdev;
+	struct platform_device *leaf;
+	void *evt_hdl;
+};
+
+static bool xrt_test_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	int myid = (int)(uintptr_t)arg;
+	return id == XRT_SUBDEV_TEST && pdev->id != myid;
+}
+
+static ssize_t hold_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_test *xt = platform_get_drvdata(pdev);
+	struct platform_device *leaf;
+
+	leaf = xrt_subdev_get_leaf(pdev, xrt_test_leaf_match,
+		(void *)(uintptr_t)pdev->id);
+	if (leaf)
+		xt->leaf = leaf;
+	return count;
+}
+static DEVICE_ATTR_WO(hold);
+
+static ssize_t release_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_test *xt = platform_get_drvdata(pdev);
+
+	if (xt->leaf)
+		(void) xrt_subdev_put_leaf(pdev, xt->leaf);
+	return count;
+}
+static DEVICE_ATTR_WO(release);
+
+static struct attribute *xrt_test_attrs[] = {
+	&dev_attr_hold.attr,
+	&dev_attr_release.attr,
+	NULL,
+};
+
+static const struct attribute_group xrt_test_attrgroup = {
+	.attrs = xrt_test_attrs,
+};
+
+static void xrt_test_async_evt_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg, bool success)
+{
+	xrt_info(pdev, "async broadcast event (%d) is %s", evt,
+		success ? "successful" : "failed");
+}
+
+static int xrt_test_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+	struct platform_device *leaf;
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION:
+		break;
+	default:
+		xrt_info(pdev, "ignored event %d", evt);
+		return XRT_EVENT_CB_CONTINUE;
+	}
+
+	leaf = xrt_subdev_get_leaf_by_id(pdev, esd->xevt_subdev_id,
+		esd->xevt_subdev_instance);
+	if (leaf) {
+		(void) xrt_subdev_ioctl(leaf, 1, NULL);
+		(void) xrt_subdev_put_leaf(pdev, leaf);
+	}
+
+	/* Broadcast event. */
+	if (pdev->id == 1) {
+		xrt_subdev_broadcast_event_async(pdev, XRT_EVENT_TEST,
+			xrt_test_async_evt_cb, NULL);
+	}
+
+	xrt_info(pdev, "processed event %d for (%d, %d)",
+		evt, esd->xevt_subdev_id, esd->xevt_subdev_instance);
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+static int xrt_test_create_metadata(struct xrt_test *xt, char **root_dtb)
+{
+	char *dtb = NULL;
+	struct xrt_md_endpoint ep = { .ep_name = NODE_TEST };
+	int ret;
+
+	ret = xrt_md_create(DEV(xt->pdev), &dtb);
+	if (ret) {
+		xrt_err(xt->pdev, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+
+	ret = xrt_md_add_endpoint(DEV(xt->pdev), dtb, &ep);
+	if (ret) {
+		xrt_err(xt->pdev, "add test node failed, ret %d", ret);
+		goto failed;
+	}
+
+	*root_dtb = dtb;
+	return 0;
+
+failed:
+	vfree(dtb);
+	return ret;
+}
+
+static int xrt_test_probe(struct platform_device *pdev)
+{
+	struct xrt_test *xt;
+	char *dtb = NULL;
+
+	xrt_info(pdev, "probing...");
+
+	xt = devm_kzalloc(DEV(pdev), sizeof(*xt), GFP_KERNEL);
+	if (!xt)
+		return -ENOMEM;
+
+	xt->pdev = pdev;
+	platform_set_drvdata(pdev, xt);
+
+	/* Ready to handle req thru sysfs nodes. */
+	if (sysfs_create_group(&DEV(pdev)->kobj, &xrt_test_attrgroup))
+		xrt_err(pdev, "failed to create sysfs group");
+
+	/* Add event callback to wait for the peer instance. */
+	xt->evt_hdl = xrt_subdev_add_event_cb(pdev, xrt_test_leaf_match,
+		(void *)(uintptr_t)pdev->id, xrt_test_event_cb);
+
+	/* Trigger partition creation, only when this is the first instance. */
+	if (pdev->id == 0) {
+		(void) xrt_test_create_metadata(xt, &dtb);
+		if (dtb)
+			(void) xrt_subdev_create_partition(pdev, dtb);
+		vfree(dtb);
+	} else {
+		xrt_subdev_broadcast_event(pdev, XRT_EVENT_TEST);
+	}
+
+	/* After we return here, we'll get inter-leaf calls. */
+	return 0;
+}
+
+static int xrt_test_remove(struct platform_device *pdev)
+{
+	struct xrt_test *xt = platform_get_drvdata(pdev);
+
+	/* By now, partition driver should prevent any inter-leaf call. */
+
+	xrt_info(pdev, "leaving...");
+
+	(void) xrt_subdev_remove_event_cb(pdev, xt->evt_hdl);
+
+	(void) sysfs_remove_group(&DEV(pdev)->kobj, &xrt_test_attrgroup);
+	/* By now, no more access thru sysfs nodes. */
+
+	/* Clean up can safely be done now. */
+	return 0;
+}
+
+static int
+xrt_test_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	xrt_info(pdev, "handling IOCTL cmd: %d", cmd);
+	return 0;
+}
+
+static int xrt_test_open(struct inode *inode, struct file *file)
+{
+	struct platform_device *pdev = xrt_devnode_open(inode);
+
+	/* Device may have gone already when we get here. */
+	if (!pdev)
+		return -ENODEV;
+
+	xrt_info(pdev, "opened");
+	file->private_data = platform_get_drvdata(pdev);
+	return 0;
+}
+
+static ssize_t
+xrt_test_read(struct file *file, char __user *ubuf, size_t n, loff_t *off)
+{
+	int i;
+	struct xrt_test *xt = file->private_data;
+
+	for (i = 0; i < 10; i++) {
+		xrt_info(xt->pdev, "reading...");
+		ssleep(1);
+	}
+	return 0;
+}
+
+static int xrt_test_close(struct inode *inode, struct file *file)
+{
+	struct xrt_test *xt = file->private_data;
+
+	xrt_devnode_close(inode);
+
+	xrt_info(xt->pdev, "closed");
+	return 0;
+}
+
+/* Link to device tree nodes. */
+struct xrt_subdev_endpoints xrt_test_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{ .ep_name = NODE_TEST },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+/*
+ * Callbacks registered with parent driver infrastructure.
+ */
+struct xrt_subdev_drvdata xrt_test_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_test_leaf_ioctl,
+	},
+	.xsd_file_ops = {
+		.xsf_ops = {
+			.owner = THIS_MODULE,
+			.open = xrt_test_open,
+			.release = xrt_test_close,
+			.read = xrt_test_read,
+		},
+		.xsf_mode = XRT_SUBDEV_FILE_MULTI_INST,
+	},
+};
+
+static const struct platform_device_id xrt_test_id_table[] = {
+	{ XRT_TEST, (kernel_ulong_t)&xrt_test_data },
+	{ },
+};
+
+/*
+ * Callbacks registered with Linux's platform driver infrastructure.
+ */
+struct platform_driver xrt_test_driver = {
+	.driver	= {
+		.name    = XRT_TEST,
+	},
+	.probe   = xrt_test_probe,
+	.remove  = xrt_test_remove,
+	.id_table = xrt_test_id_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-ucs.c b/drivers/fpga/alveo/lib/subdevs/xrt-ucs.c
new file mode 100644
index 000000000000..849a9b780e0b
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-ucs.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA UCS Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-ucs.h"
+#include "xrt-clock.h"
+
+#define UCS_ERR(ucs, fmt, arg...)   \
+	xrt_err((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_WARN(ucs, fmt, arg...)  \
+	xrt_warn((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_INFO(ucs, fmt, arg...)  \
+	xrt_info((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_DBG(ucs, fmt, arg...)   \
+	xrt_dbg((ucs)->pdev, fmt "\n", ##arg)
+
+
+#define XRT_UCS		"xrt_ucs"
+
+#define CHANNEL1_OFFSET			0
+#define CHANNEL2_OFFSET			8
+
+#define CLK_MAX_VALUE			6400
+
+struct ucs_control_status_ch1 {
+	unsigned int shutdown_clocks_latched:1;
+	unsigned int reserved1:15;
+	unsigned int clock_throttling_average:14;
+	unsigned int reserved2:2;
+};
+
+
+struct xrt_ucs {
+	struct platform_device	*pdev;
+	void __iomem		*ucs_base;
+	struct mutex		ucs_lock;
+	void			*evt_hdl;
+};
+
+static inline u32 reg_rd(struct xrt_ucs *ucs, u32 offset)
+{
+	return ioread32(ucs->ucs_base + offset);
+}
+
+static inline void reg_wr(struct xrt_ucs *ucs, u32 val, u32 offset)
+{
+	iowrite32(val, ucs->ucs_base + offset);
+}
+
+static bool xrt_ucs_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	if (id == XRT_SUBDEV_CLOCK)
+		return true;
+
+	return false;
+}
+
+static int xrt_ucs_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+
+	struct xrt_ucs		*ucs;
+	struct platform_device	*leaf;
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+
+	ucs = platform_get_drvdata(pdev);
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION:
+		break;
+	default:
+		xrt_info(pdev, "ignored event %d", evt);
+		return XRT_EVENT_CB_CONTINUE;
+	}
+
+	leaf = xrt_subdev_get_leaf_by_id(pdev,
+		XRT_SUBDEV_CLOCK, esd->xevt_subdev_instance);
+	BUG_ON(!leaf);
+	xrt_subdev_ioctl(leaf, XRT_CLOCK_VERIFY, NULL);
+	xrt_subdev_put_leaf(pdev, leaf);
+
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+static void ucs_check(struct xrt_ucs *ucs, bool *latched)
+{
+	struct ucs_control_status_ch1 *ucs_status_ch1;
+	u32 status;
+
+	mutex_lock(&ucs->ucs_lock);
+	status = reg_rd(ucs, CHANNEL1_OFFSET);
+	ucs_status_ch1 = (struct ucs_control_status_ch1 *)&status;
+	if (ucs_status_ch1->shutdown_clocks_latched) {
+		UCS_ERR(ucs, "Critical temperature or power event, kernel clocks have been stopped, run 'xbutil valiate -q' to continue. See AR 73398 for more details.");
+		/* explicitly indicate reset should be latched */
+		*latched = true;
+	} else if (ucs_status_ch1->clock_throttling_average >
+	    CLK_MAX_VALUE) {
+		UCS_ERR(ucs, "kernel clocks %d exceeds expected maximum value %d.",
+			ucs_status_ch1->clock_throttling_average,
+			CLK_MAX_VALUE);
+	} else if (ucs_status_ch1->clock_throttling_average) {
+		UCS_ERR(ucs, "kernel clocks throttled at %d%%.",
+			(ucs_status_ch1->clock_throttling_average /
+			 (CLK_MAX_VALUE / 100)));
+	}
+	mutex_unlock(&ucs->ucs_lock);
+}
+
+static void ucs_enable(struct xrt_ucs *ucs)
+{
+	reg_wr(ucs, 1, CHANNEL2_OFFSET);
+}
+
+static int
+xrt_ucs_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_ucs		*ucs;
+	int			ret = 0;
+
+	ucs = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_UCS_CHECK: {
+		ucs_check(ucs, (bool *)arg);
+		break;
+	}
+	case XRT_UCS_ENABLE:
+		ucs_enable(ucs);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ucs_remove(struct platform_device *pdev)
+{
+	struct xrt_ucs *ucs;
+
+	ucs = platform_get_drvdata(pdev);
+	if (!ucs) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	xrt_subdev_remove_event_cb(pdev, ucs->evt_hdl);
+	if (ucs->ucs_base)
+		iounmap(ucs->ucs_base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, ucs);
+
+	return 0;
+}
+
+
+
+static int ucs_probe(struct platform_device *pdev)
+{
+	struct xrt_ucs *ucs = NULL;
+	struct resource *res;
+	int ret;
+
+	ucs = devm_kzalloc(&pdev->dev, sizeof(*ucs), GFP_KERNEL);
+	if (!ucs)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ucs);
+	ucs->pdev = pdev;
+	mutex_init(&ucs->ucs_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ucs->ucs_base = ioremap(res->start, res->end - res->start + 1);
+	if (!ucs->ucs_base) {
+		UCS_ERR(ucs, "map base %pR failed", res);
+		ret = -EFAULT;
+		goto failed;
+	}
+	ucs_enable(ucs);
+	ucs->evt_hdl = xrt_subdev_add_event_cb(pdev, xrt_ucs_leaf_match,
+		NULL, xrt_ucs_event_cb);
+
+	return 0;
+
+failed:
+	ucs_remove(pdev);
+	return ret;
+}
+
+
+struct xrt_subdev_endpoints xrt_ucs_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = NODE_UCS_CONTROL_STATUS },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_ucs_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_ucs_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_ucs_table[] = {
+	{ XRT_UCS, (kernel_ulong_t)&xrt_ucs_data },
+	{ },
+};
+
+struct platform_driver xrt_ucs_driver = {
+	.driver = {
+		.name = XRT_UCS,
+	},
+	.probe = ucs_probe,
+	.remove = ucs_remove,
+	.id_table = xrt_ucs_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-vsec-golden.c b/drivers/fpga/alveo/lib/subdevs/xrt-vsec-golden.c
new file mode 100644
index 000000000000..27e6ae3c539f
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-vsec-golden.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA VSEC Driver for golden image
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Max Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/platform_device.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-gpio.h"
+
+#define XRT_VSEC_GOLDEN "xrt_vsec_golden"
+
+/*
+ * Global static table listing all known devices we need to bring up
+ * on all golden images that we need to support.
+ */
+static struct xrt_golden_endpoint {
+	unsigned short vendor;
+	unsigned short device;
+	struct xrt_md_endpoint ep;
+	const char *board_name;
+} vsec_golden_eps[] = {
+	{
+		.vendor = 0x10ee,
+		.device = 0xd020,
+		.ep = {
+			.ep_name = NODE_FLASH_VSEC,
+			.bar_off = 0x1f50000,
+			.size = 4096
+		},
+		.board_name = "u50",
+	},
+};
+
+/* Version of golden image is read from same location for all Alveo cards. */
+static struct xrt_md_endpoint xrt_golden_ver_endpoint = {
+	.ep_name = NODE_GOLDEN_VER,
+	.bar_off = 0x131008,
+	.size = 4
+};
+
+struct xrt_vsec {
+	struct platform_device	*pdev;
+	char			*metadata;
+	unsigned short		vendor;
+	unsigned short		device;
+	const char		*bdname;
+};
+
+static int xrt_vsec_get_golden_ver(struct xrt_vsec *vsec)
+{
+	struct platform_device *gpio_leaf;
+	struct platform_device *pdev = vsec->pdev;
+	struct xrt_gpio_ioctl_rw gpio_arg = { 0 };
+	int err, ver;
+
+	gpio_leaf = xrt_subdev_get_leaf_by_epname(pdev, NODE_GOLDEN_VER);
+	if (!gpio_leaf) {
+		xrt_err(pdev, "can not get %s", NODE_GOLDEN_VER);
+		return -EINVAL;
+	}
+
+	gpio_arg.xgir_id = XRT_GPIO_GOLDEN_VER;
+	gpio_arg.xgir_buf = &ver;
+	gpio_arg.xgir_len = sizeof(ver);
+	gpio_arg.xgir_offset = 0;
+	err = xrt_subdev_ioctl(gpio_leaf, XRT_GPIO_READ, &gpio_arg);
+	(void) xrt_subdev_put_leaf(pdev, gpio_leaf);
+	if (err) {
+		xrt_err(pdev, "can't get golden image version: %d", err);
+		return err;
+	}
+
+	return ver;
+}
+
+static int xrt_vsec_add_node(struct xrt_vsec *vsec,
+	struct xrt_md_endpoint *dev)
+{
+	int ret;
+
+	xrt_info(vsec->pdev, "add ep %s", dev->ep_name);
+	ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, dev);
+	if (ret)
+		xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
+	return ret;
+}
+
+static int xrt_vsec_add_all_nodes(struct xrt_vsec *vsec)
+{
+	int i;
+	int rc = -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_golden_eps); i++) {
+		struct xrt_golden_endpoint *ep = &vsec_golden_eps[i];
+
+		if (vsec->vendor == ep->vendor && vsec->device == ep->device) {
+			rc = xrt_vsec_add_node(vsec, &ep->ep);
+			if (rc)
+				break;
+		}
+	}
+
+	if (rc == 0)
+		rc = xrt_vsec_add_node(vsec, &xrt_golden_ver_endpoint);
+
+	return rc;
+}
+
+static int xrt_vsec_create_metadata(struct xrt_vsec *vsec)
+{
+	int ret;
+
+	ret = xrt_md_create(&vsec->pdev->dev, &vsec->metadata);
+	if (ret) {
+		xrt_err(vsec->pdev, "create metadata failed");
+		return ret;
+	}
+
+	ret = xrt_vsec_add_all_nodes(vsec);
+	if (ret) {
+		vfree(vsec->metadata);
+		vsec->metadata = NULL;
+	}
+	return ret;
+}
+
+static ssize_t VBNV_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_vsec *vsec = platform_get_drvdata(pdev);
+
+	return sprintf(buf, "xilinx_%s_GOLDEN_%d\n", vsec->bdname,
+		xrt_vsec_get_golden_ver(vsec));
+}
+static DEVICE_ATTR_RO(VBNV);
+
+static struct attribute *vsec_attrs[] = {
+	&dev_attr_VBNV.attr,
+	NULL,
+};
+
+static const struct attribute_group vsec_attrgroup = {
+	.attrs = vsec_attrs,
+};
+
+static int xrt_vsec_remove(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+
+	xrt_info(pdev, "leaving...");
+	(void) sysfs_remove_group(&DEV(pdev)->kobj, &vsec_attrgroup);
+	vsec = platform_get_drvdata(pdev);
+	vfree(vsec->metadata);
+	return 0;
+}
+
+static int xrt_vsec_probe(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+	int			ret = 0;
+	int			i;
+
+	xrt_info(pdev, "probing...");
+
+	vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
+	if (!vsec)
+		return -ENOMEM;
+
+	vsec->pdev = pdev;
+	xrt_subdev_get_parent_id(pdev, &vsec->vendor, &vsec->device,
+		NULL, NULL);
+	platform_set_drvdata(pdev, vsec);
+
+	ret = xrt_vsec_create_metadata(vsec);
+	if (ret) {
+		xrt_err(pdev, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+	ret = xrt_subdev_create_partition(pdev, vsec->metadata);
+	if (ret < 0)
+		xrt_err(pdev, "create partition failed, ret %d", ret);
+	else
+		ret = 0;
+
+	/* Cache golden board name. */
+	for (i = 0; i < ARRAY_SIZE(vsec_golden_eps); i++) {
+		struct xrt_golden_endpoint *ep = &vsec_golden_eps[i];
+
+		if (vsec->vendor == ep->vendor && vsec->device == ep->device) {
+			vsec->bdname = ep->board_name;
+			break;
+		}
+	}
+
+	if (sysfs_create_group(&DEV(pdev)->kobj, &vsec_attrgroup))
+		xrt_err(pdev, "failed to create sysfs group");
+
+failed:
+	if (ret)
+		xrt_vsec_remove(pdev);
+
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_vsec_golden_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{ .ep_name = NODE_VSEC_GOLDEN },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_vsec_data = {
+};
+
+static const struct platform_device_id xrt_vsec_table[] = {
+	{ XRT_VSEC_GOLDEN, (kernel_ulong_t)&xrt_vsec_data },
+	{ },
+};
+
+struct platform_driver xrt_vsec_golden_driver = {
+	.driver = {
+		.name = XRT_VSEC_GOLDEN,
+	},
+	.probe = xrt_vsec_probe,
+	.remove = xrt_vsec_remove,
+	.id_table = xrt_vsec_table,
+};
diff --git a/drivers/fpga/alveo/lib/subdevs/xrt-vsec.c b/drivers/fpga/alveo/lib/subdevs/xrt-vsec.c
new file mode 100644
index 000000000000..c9a3f258fceb
--- /dev/null
+++ b/drivers/fpga/alveo/lib/subdevs/xrt-vsec.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA VSEC Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/platform_device.h>
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+
+#define XRT_VSEC "xrt_vsec"
+
+#define VSEC_TYPE_UUID		0x50
+#define VSEC_TYPE_FLASH		0x51
+#define VSEC_TYPE_PLATINFO	0x52
+#define VSEC_TYPE_MAILBOX	0x53
+#define VSEC_TYPE_END		0xff
+
+#define VSEC_UUID_LEN		16
+
+struct xrt_vsec_header {
+	u32		format;
+	u32		length;
+	u32		entry_sz;
+	u32		rsvd;
+} __packed;
+
+#define head_rd(g, r)			\
+	ioread32(&((struct xrt_vsec_header *)g->base)->r)
+
+#define GET_BAR(entry)	((entry->bar_rev >> 4) & 0xf)
+#define GET_BAR_OFF(entry)	(entry->off_lo | ((u64)entry->off_hi << 16))
+#define GET_REV(entry)	(entry->bar_rev & 0xf)
+
+struct xrt_vsec_entry {
+	u8		type;
+	u8		bar_rev;
+	u16		off_lo;
+	u32		off_hi;
+	u8		ver_type;
+	u8		minor;
+	u8		major;
+	u8		rsvd0;
+	u32		rsvd1;
+} __packed;
+
+#define read_entry(g, i, e)					\
+	do {							\
+		u32 *p = (u32 *)(g->base +			\
+			sizeof(struct xrt_vsec_header) +	\
+			i * sizeof(struct xrt_vsec_entry));	\
+		u32 off;					\
+		for (off = 0;					\
+		    off < sizeof(struct xrt_vsec_entry) / 4;	\
+		    off++)					\
+			*((u32 *)(e) + off) = ioread32(p + off);\
+	} while (0)
+
+struct vsec_device {
+	u8		type;
+	char		*ep_name;
+	ulong		size;
+	char		*regmap;
+};
+
+static struct vsec_device vsec_devs[] = {
+	{
+		.type = VSEC_TYPE_UUID,
+		.ep_name = NODE_BLP_ROM,
+		.size = VSEC_UUID_LEN,
+		.regmap = "vsec-uuid",
+	},
+	{
+		.type = VSEC_TYPE_FLASH,
+		.ep_name = NODE_FLASH_VSEC,
+		.size = 4096,
+		.regmap = "vsec-flash",
+	},
+	{
+		.type = VSEC_TYPE_PLATINFO,
+		.ep_name = NODE_PLAT_INFO,
+		.size = 4,
+		.regmap = "vsec-platinfo",
+	},
+	{
+		.type = VSEC_TYPE_MAILBOX,
+		.ep_name = NODE_MAILBOX_VSEC,
+		.size = 48,
+		.regmap = "vsec-mbx",
+	},
+};
+
+struct xrt_vsec {
+	struct platform_device	*pdev;
+	void			*base;
+	ulong			length;
+
+	char			*metadata;
+	char			uuid[VSEC_UUID_LEN];
+};
+
+static char *type2epname(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].ep_name);
+	}
+
+	return NULL;
+}
+
+static ulong type2size(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].size);
+	}
+
+	return 0;
+}
+
+static char *type2regmap(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].regmap);
+	}
+
+	return NULL;
+}
+
+static int xrt_vsec_add_node(struct xrt_vsec *vsec,
+	void *md_blob, struct xrt_vsec_entry *p_entry)
+{
+	struct xrt_md_endpoint ep;
+	char regmap_ver[64];
+	int ret;
+
+	if (!type2epname(p_entry->type))
+		return -EINVAL;
+
+	/*
+	 * VSEC may have more than 1 mailbox instance for the card
+	 * which has more than 1 physical function.
+	 * This is not supported for now. Assuming only one mailbox
+	 */
+
+	snprintf(regmap_ver, sizeof(regmap_ver) - 1, "%d-%d.%d.%d",
+		p_entry->ver_type, p_entry->major, p_entry->minor,
+		GET_REV(p_entry));
+	ep.ep_name = type2epname(p_entry->type);
+	ep.bar = GET_BAR(p_entry);
+	ep.bar_off = GET_BAR_OFF(p_entry);
+	ep.size = type2size(p_entry->type);
+	ep.regmap = type2regmap(p_entry->type);
+	ep.regmap_ver = regmap_ver;
+	ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, &ep);
+	if (ret) {
+		xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
+		goto failed;
+	}
+
+failed:
+	return ret;
+}
+
+static int xrt_vsec_create_metadata(struct xrt_vsec *vsec)
+{
+	struct xrt_vsec_entry entry;
+	int i, ret;
+
+	ret = xrt_md_create(&vsec->pdev->dev, &vsec->metadata);
+	if (ret) {
+		xrt_err(vsec->pdev, "create metadata failed");
+		return ret;
+	}
+
+	for (i = 0; i * sizeof(entry) < vsec->length -
+	    sizeof(struct xrt_vsec_header); i++) {
+		read_entry(vsec, i, &entry);
+		xrt_vsec_add_node(vsec, vsec->metadata, &entry);
+	}
+
+	return 0;
+}
+
+static int xrt_vsec_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	return 0;
+}
+
+static int xrt_vsec_mapio(struct xrt_vsec *vsec)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->pdev);
+	const u32 *bar;
+	const u64 *bar_off;
+	struct resource *res = NULL;
+	ulong addr;
+	int ret;
+
+	if (!pdata || xrt_md_size(DEV(vsec->pdev), pdata->xsp_dtb) <= 0) {
+		xrt_err(vsec->pdev, "empty metadata");
+		return -EINVAL;
+	}
+
+	ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, NODE_VSEC,
+		NULL, PROP_BAR_IDX, (const void **)&bar, NULL);
+	if (ret) {
+		xrt_err(vsec->pdev, "failed to get bar idx, ret %d", ret);
+		return -EINVAL;
+	}
+
+	ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, NODE_VSEC,
+		NULL, PROP_OFFSET, (const void **)&bar_off, NULL);
+	if (ret) {
+		xrt_err(vsec->pdev, "failed to get bar off, ret %d", ret);
+		return -EINVAL;
+	}
+
+	xrt_info(vsec->pdev, "Map vsec at bar %d, offset 0x%llx",
+		be32_to_cpu(*bar), be64_to_cpu(*bar_off));
+
+	xrt_subdev_get_barres(vsec->pdev, &res, be32_to_cpu(*bar));
+	if (!res) {
+		xrt_err(vsec->pdev, "failed to get bar addr");
+		return -EINVAL;
+	}
+
+	addr = res->start + (ulong)be64_to_cpu(*bar_off);
+
+	vsec->base = ioremap(addr, sizeof(struct xrt_vsec_header));
+	if (!vsec->base) {
+		xrt_err(vsec->pdev, "Map header failed");
+		return -EIO;
+	}
+
+	vsec->length = head_rd(vsec, length);
+	iounmap(vsec->base);
+	vsec->base = ioremap(addr, vsec->length);
+	if (!vsec->base) {
+		xrt_err(vsec->pdev, "map failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int xrt_vsec_remove(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+
+	vsec = platform_get_drvdata(pdev);
+
+	if (vsec->base) {
+		iounmap(vsec->base);
+		vsec->base = NULL;
+	}
+
+	vfree(vsec->metadata);
+
+	return 0;
+}
+
+static int xrt_vsec_probe(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+	int			ret = 0;
+
+	vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
+	if (!vsec)
+		return -ENOMEM;
+
+	vsec->pdev = pdev;
+	platform_set_drvdata(pdev, vsec);
+
+	ret = xrt_vsec_mapio(vsec);
+	if (ret)
+		goto failed;
+
+	ret = xrt_vsec_create_metadata(vsec);
+	if (ret) {
+		xrt_err(pdev, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+	ret = xrt_subdev_create_partition(pdev, vsec->metadata);
+	if (ret < 0)
+		xrt_err(pdev, "create partition failed, ret %d", ret);
+	else
+		ret = 0;
+
+failed:
+	if (ret)
+		xrt_vsec_remove(pdev);
+
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_vsec_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{ .ep_name = NODE_VSEC },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_vsec_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_vsec_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_vsec_table[] = {
+	{ XRT_VSEC, (kernel_ulong_t)&xrt_vsec_data },
+	{ },
+};
+
+struct platform_driver xrt_vsec_driver = {
+	.driver = {
+		.name = XRT_VSEC,
+	},
+	.probe = xrt_vsec_probe,
+	.remove = xrt_vsec_remove,
+	.id_table = xrt_vsec_table,
+};
-- 
2.17.1

