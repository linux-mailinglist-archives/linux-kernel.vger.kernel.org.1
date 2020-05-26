Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D6519CA8A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 21:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbgDBTuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 15:50:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729123AbgDBTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:50:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032JWrC0115294;
        Thu, 2 Apr 2020 15:50:01 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022r1rvpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 15:50:01 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032JnWB7028574;
        Thu, 2 Apr 2020 19:50:00 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 301x77ba54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 19:50:00 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 032JnxMv54198576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Apr 2020 19:49:59 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 906D9AE05F;
        Thu,  2 Apr 2020 19:49:59 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3A4AE05C;
        Thu,  2 Apr 2020 19:49:58 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.31.233])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Apr 2020 19:49:58 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Subject: [PATCH v7 2/5] soc: aspeed: Add XDMA Engine Driver
Date:   Thu,  2 Apr 2020 14:49:52 -0500
Message-Id: <20200402194955.16643-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200402194955.16643-1-eajames@linux.ibm.com>
References: <20200402194955.16643-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_09:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=3 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
DMA operations between the SOC (acting as a BMC) and a host processor
in a server.

This commit adds a driver to control the XDMA engine and adds functions
to initialize the hardware and memory and start DMA operations.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffrey <andrew@aj.id.au>
---
Changes since v6:
 - Switch to use a chunk of reserved memory from the devicetree rather than
   simply reading the address and size
 - Add PCI-E root complex reset
 - Fix buffer overrun in aspeed_xdma_start
 - Switch to usleep_range with a smaller time than the old msleep(10) because
   that time is for toggling the clock, which we don't do during reset and
   should be done by the clock driver anyway
 - Set some additional bit in the SCU necessary for XDMA to work
 - Refactor probe error handling near the end

 MAINTAINERS                      |   2 +
 drivers/soc/aspeed/Kconfig       |   8 +
 drivers/soc/aspeed/Makefile      |   1 +
 drivers/soc/aspeed/aspeed-xdma.c | 840 +++++++++++++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h |  38 ++
 5 files changed, 889 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 619a2d559ce2..96aad6b2e624 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2776,6 +2776,8 @@ M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
+F:	drivers/soc/aspeed/aspeed-xdma.c
+F:	include/uapi/linux/aspeed-xdma.h
 
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index 323e177aa74d..2a6c16f9e50b 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -29,4 +29,12 @@ config ASPEED_P2A_CTRL
 	  ioctl()s, the driver also provides an interface for userspace mappings to
 	  a pre-defined region.
 
+config ASPEED_XDMA
+	tristate "Aspeed XDMA Engine Driver"
+	depends on SOC_ASPEED && REGMAP && MFD_SYSCON && HAS_DMA
+	help
+	  Enable support for the Aspeed XDMA Engine found on the Aspeed AST2XXX
+	  SOCs. The XDMA engine can perform automatic PCI DMA operations
+	  between the AST2XXX (acting as a BMC) and a host processor.
+
 endmenu
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b64be47f2b1f..977b046dfb73 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)	+= aspeed-p2a-ctrl.o
+obj-$(CONFIG_ASPEED_XDMA)	+= aspeed-xdma.o
diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
new file mode 100644
index 000000000000..bc746b262de7
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -0,0 +1,840 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright IBM Corp 2019
+
+#include <linux/aspeed-xdma.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/fs.h>
+#include <linux/genalloc.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#define DEVICE_NAME				"aspeed-xdma"
+
+#define SCU_AST2600_MISC_CTRL			0x0c0
+#define  SCU_AST2600_MISC_CTRL_XDMA_BMC		 BIT(8)
+
+#define SCU_AST2500_PCIE_CONF			0x180
+#define SCU_AST2600_PCIE_CONF			0xc20
+#define  SCU_PCIE_CONF_VGA_EN			 BIT(0)
+#define  SCU_PCIE_CONF_VGA_EN_MMIO		 BIT(1)
+#define  SCU_PCIE_CONF_VGA_EN_LPC		 BIT(2)
+#define  SCU_PCIE_CONF_VGA_EN_MSI		 BIT(3)
+#define  SCU_PCIE_CONF_VGA_EN_MCTP		 BIT(4)
+#define  SCU_PCIE_CONF_VGA_EN_IRQ		 BIT(5)
+#define  SCU_PCIE_CONF_VGA_EN_DMA		 BIT(6)
+#define  SCU_PCIE_CONF_BMC_EN			 BIT(8)
+#define  SCU_PCIE_CONF_BMC_EN_MMIO		 BIT(9)
+#define  SCU_PCIE_CONF_BMC_EN_MSI		 BIT(11)
+#define  SCU_PCIE_CONF_BMC_EN_MCTP		 BIT(12)
+#define  SCU_PCIE_CONF_BMC_EN_IRQ		 BIT(13)
+#define  SCU_PCIE_CONF_BMC_EN_DMA		 BIT(14)
+
+#define SCU_AST2500_BMC_CLASS_REV		0x19c
+#define SCU_AST2600_BMC_CLASS_REV		0xc68
+#define  SCU_BMC_CLASS_REV_XDMA			 0xff000001
+
+#define XDMA_CMDQ_SIZE				PAGE_SIZE
+#define XDMA_NUM_CMDS				\
+	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
+
+/* Aspeed specification requires 100us after disabling the reset */
+#define XDMA_ENGINE_SETUP_TIME_MAX_US          1000
+#define XDMA_ENGINE_SETUP_TIME_MIN_US          100
+
+#define XDMA_CMD_AST2500_PITCH_SHIFT		3
+#define XDMA_CMD_AST2500_PITCH_BMC		GENMASK_ULL(62, 51)
+#define XDMA_CMD_AST2500_PITCH_HOST		GENMASK_ULL(46, 35)
+#define XDMA_CMD_AST2500_PITCH_UPSTREAM		BIT_ULL(31)
+#define XDMA_CMD_AST2500_PITCH_ADDR		GENMASK_ULL(29, 4)
+#define XDMA_CMD_AST2500_PITCH_ID		BIT_ULL(0)
+#define XDMA_CMD_AST2500_CMD_IRQ_EN		BIT_ULL(31)
+#define XDMA_CMD_AST2500_CMD_LINE_NO		GENMASK_ULL(27, 16)
+#define XDMA_CMD_AST2500_CMD_IRQ_BMC		BIT_ULL(15)
+#define XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT	4
+#define XDMA_CMD_AST2500_CMD_LINE_SIZE		\
+	GENMASK_ULL(14, XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT)
+#define XDMA_CMD_AST2500_CMD_ID			BIT_ULL(1)
+
+#define XDMA_CMD_AST2600_PITCH_BMC		GENMASK_ULL(62, 48)
+#define XDMA_CMD_AST2600_PITCH_HOST		GENMASK_ULL(46, 32)
+#define XDMA_CMD_AST2600_PITCH_ADDR		GENMASK_ULL(30, 0)
+#define XDMA_CMD_AST2600_CMD_64_EN		BIT_ULL(40)
+#define XDMA_CMD_AST2600_CMD_IRQ_BMC		BIT_ULL(37)
+#define XDMA_CMD_AST2600_CMD_IRQ_HOST		BIT_ULL(36)
+#define XDMA_CMD_AST2600_CMD_UPSTREAM		BIT_ULL(32)
+#define XDMA_CMD_AST2600_CMD_LINE_NO		GENMASK_ULL(27, 16)
+#define XDMA_CMD_AST2600_CMD_LINE_SIZE		GENMASK_ULL(14, 0)
+#define XDMA_CMD_AST2600_CMD_MULTILINE_SIZE	GENMASK_ULL(14, 12)
+
+#define XDMA_AST2500_QUEUE_ENTRY_SIZE		4
+#define XDMA_AST2500_HOST_CMDQ_ADDR0		0x00
+#define XDMA_AST2500_HOST_CMDQ_ENDP		0x04
+#define XDMA_AST2500_HOST_CMDQ_WRITEP		0x08
+#define XDMA_AST2500_HOST_CMDQ_READP		0x0c
+#define XDMA_AST2500_BMC_CMDQ_ADDR		0x10
+#define XDMA_AST2500_BMC_CMDQ_ENDP		0x14
+#define XDMA_AST2500_BMC_CMDQ_WRITEP		0x18
+#define XDMA_AST2500_BMC_CMDQ_READP		0x1c
+#define  XDMA_BMC_CMDQ_READP_RESET		 0xee882266
+#define XDMA_AST2500_CTRL			0x20
+#define  XDMA_AST2500_CTRL_US_COMP		 BIT(4)
+#define  XDMA_AST2500_CTRL_DS_COMP		 BIT(5)
+#define  XDMA_AST2500_CTRL_DS_DIRTY		 BIT(6)
+#define  XDMA_AST2500_CTRL_DS_SIZE_256		 BIT(17)
+#define  XDMA_AST2500_CTRL_DS_TIMEOUT		 BIT(28)
+#define  XDMA_AST2500_CTRL_DS_CHECK_ID		 BIT(29)
+#define XDMA_AST2500_STATUS			0x24
+#define  XDMA_AST2500_STATUS_US_COMP		 BIT(4)
+#define  XDMA_AST2500_STATUS_DS_COMP		 BIT(5)
+#define  XDMA_AST2500_STATUS_DS_DIRTY		 BIT(6)
+#define XDMA_AST2500_INPRG_DS_CMD1		0x38
+#define XDMA_AST2500_INPRG_DS_CMD2		0x3c
+#define XDMA_AST2500_INPRG_US_CMD00		0x40
+#define XDMA_AST2500_INPRG_US_CMD01		0x44
+#define XDMA_AST2500_INPRG_US_CMD10		0x48
+#define XDMA_AST2500_INPRG_US_CMD11		0x4c
+#define XDMA_AST2500_INPRG_US_CMD20		0x50
+#define XDMA_AST2500_INPRG_US_CMD21		0x54
+#define XDMA_AST2500_HOST_CMDQ_ADDR1		0x60
+#define XDMA_AST2500_VGA_CMDQ_ADDR0		0x64
+#define XDMA_AST2500_VGA_CMDQ_ENDP		0x68
+#define XDMA_AST2500_VGA_CMDQ_WRITEP		0x6c
+#define XDMA_AST2500_VGA_CMDQ_READP		0x70
+#define XDMA_AST2500_VGA_CMD_STATUS		0x74
+#define XDMA_AST2500_VGA_CMDQ_ADDR1		0x78
+
+#define XDMA_AST2600_QUEUE_ENTRY_SIZE		2
+#define XDMA_AST2600_HOST_CMDQ_ADDR0		0x00
+#define XDMA_AST2600_HOST_CMDQ_ADDR1		0x04
+#define XDMA_AST2600_HOST_CMDQ_ENDP		0x08
+#define XDMA_AST2600_HOST_CMDQ_WRITEP		0x0c
+#define XDMA_AST2600_HOST_CMDQ_READP		0x10
+#define XDMA_AST2600_BMC_CMDQ_ADDR		0x14
+#define XDMA_AST2600_BMC_CMDQ_ENDP		0x18
+#define XDMA_AST2600_BMC_CMDQ_WRITEP		0x1c
+#define XDMA_AST2600_BMC_CMDQ_READP		0x20
+#define XDMA_AST2600_VGA_CMDQ_ADDR0		0x24
+#define XDMA_AST2600_VGA_CMDQ_ADDR1		0x28
+#define XDMA_AST2600_VGA_CMDQ_ENDP		0x2c
+#define XDMA_AST2600_VGA_CMDQ_WRITEP		0x30
+#define XDMA_AST2600_VGA_CMDQ_READP		0x34
+#define XDMA_AST2600_CTRL			0x38
+#define  XDMA_AST2600_CTRL_US_COMP		 BIT(16)
+#define  XDMA_AST2600_CTRL_DS_COMP		 BIT(17)
+#define  XDMA_AST2600_CTRL_DS_DIRTY		 BIT(18)
+#define  XDMA_AST2600_CTRL_DS_SIZE_256		 BIT(20)
+#define XDMA_AST2600_STATUS			0x3c
+#define  XDMA_AST2600_STATUS_US_COMP		 BIT(16)
+#define  XDMA_AST2600_STATUS_DS_COMP		 BIT(17)
+#define  XDMA_AST2600_STATUS_DS_DIRTY		 BIT(18)
+#define XDMA_AST2600_INPRG_DS_CMD00		0x40
+#define XDMA_AST2600_INPRG_DS_CMD01		0x44
+#define XDMA_AST2600_INPRG_DS_CMD10		0x48
+#define XDMA_AST2600_INPRG_DS_CMD11		0x4c
+#define XDMA_AST2600_INPRG_DS_CMD20		0x50
+#define XDMA_AST2600_INPRG_DS_CMD21		0x54
+#define XDMA_AST2600_INPRG_US_CMD00		0x60
+#define XDMA_AST2600_INPRG_US_CMD01		0x64
+#define XDMA_AST2600_INPRG_US_CMD10		0x68
+#define XDMA_AST2600_INPRG_US_CMD11		0x6c
+#define XDMA_AST2600_INPRG_US_CMD20		0x70
+#define XDMA_AST2600_INPRG_US_CMD21		0x74
+
+struct aspeed_xdma_cmd {
+	u64 host_addr;
+	u64 pitch;
+	u64 cmd;
+	u64 reserved;
+};
+
+struct aspeed_xdma_regs {
+	u8 bmc_cmdq_addr;
+	u8 bmc_cmdq_endp;
+	u8 bmc_cmdq_writep;
+	u8 bmc_cmdq_readp;
+	u8 control;
+	u8 status;
+};
+
+struct aspeed_xdma_status_bits {
+	u32 us_comp;
+	u32 ds_comp;
+	u32 ds_dirty;
+};
+
+struct aspeed_xdma;
+
+struct aspeed_xdma_chip {
+	u32 control;
+	u32 scu_bmc_class;
+	u32 scu_misc_ctrl;
+	u32 scu_pcie_conf;
+	unsigned int queue_entry_size;
+	struct aspeed_xdma_regs regs;
+	struct aspeed_xdma_status_bits status_bits;
+	unsigned int (*set_cmd)(struct aspeed_xdma *ctx,
+				struct aspeed_xdma_cmd cmds[2],
+				struct aspeed_xdma_op *op, u32 bmc_addr);
+};
+
+struct aspeed_xdma_client;
+
+struct aspeed_xdma {
+	const struct aspeed_xdma_chip *chip;
+
+	struct device *dev;
+	void __iomem *base;
+	struct clk *clock;
+	struct reset_control *reset;
+	struct reset_control *reset_rc;
+
+	/* client_lock protects error and in_progress of the client */
+	spinlock_t client_lock;
+	struct aspeed_xdma_client *current_client;
+
+	/* start_lock protects cmd_idx, cmdq, and the state of the engine */
+	struct mutex start_lock;
+	struct aspeed_xdma_cmd *cmdq;
+	bool upstream;
+	unsigned int cmd_idx;
+
+	/* reset_lock protects in_reset and the reset state of the engine */
+	spinlock_t reset_lock;
+	bool in_reset;
+
+	wait_queue_head_t wait;
+	struct work_struct reset_work;
+
+	u32 mem_phys;
+	u32 mem_size;
+	void __iomem *mem_virt;
+	dma_addr_t cmdq_phys;
+	struct gen_pool *pool;
+};
+
+struct aspeed_xdma_client {
+	struct aspeed_xdma *ctx;
+
+	bool error;
+	bool in_progress;
+	void *virt;
+	dma_addr_t phys;
+	u32 size;
+};
+
+static u32 aspeed_xdma_readl(struct aspeed_xdma *ctx, u8 reg)
+{
+	u32 v = readl(ctx->base + reg);
+
+	dev_dbg(ctx->dev, "read %02x[%08x]\n", reg, v);
+	return v;
+}
+
+static void aspeed_xdma_writel(struct aspeed_xdma *ctx, u8 reg, u32 val)
+{
+	writel(val, ctx->base + reg);
+	dev_dbg(ctx->dev, "write %02x[%08x]\n", reg, val);
+}
+
+static void aspeed_xdma_init_eng(struct aspeed_xdma *ctx)
+{
+	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_endp,
+			   ctx->chip->queue_entry_size * XDMA_NUM_CMDS);
+	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_readp,
+			   XDMA_BMC_CMDQ_READP_RESET);
+	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_writep, 0);
+	aspeed_xdma_writel(ctx, ctx->chip->regs.control, ctx->chip->control);
+	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_addr, ctx->cmdq_phys);
+
+	ctx->cmd_idx = 0;
+}
+
+static unsigned int aspeed_xdma_ast2500_set_cmd(struct aspeed_xdma *ctx,
+						struct aspeed_xdma_cmd cmds[2],
+						struct aspeed_xdma_op *op,
+						u32 bmc_addr)
+{
+	unsigned int rc = 1;
+	unsigned int pitch = 1;
+	unsigned int line_no = 1;
+	unsigned int line_size = op->len >>
+		XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
+	u64 cmd = XDMA_CMD_AST2500_CMD_IRQ_EN | XDMA_CMD_AST2500_CMD_IRQ_BMC |
+		XDMA_CMD_AST2500_CMD_ID;
+	u64 cmd_pitch = (op->direction ? XDMA_CMD_AST2500_PITCH_UPSTREAM : 0) |
+		XDMA_CMD_AST2500_PITCH_ID;
+
+	dev_dbg(ctx->dev, "xdma %s ast2500: bmc[%08x] len[%08x] host[%08x]\n",
+		op->direction ? "upstream" : "downstream", bmc_addr, op->len,
+		(u32)op->host_addr);
+
+	if (op->len > XDMA_CMD_AST2500_CMD_LINE_SIZE) {
+		unsigned int rem;
+		unsigned int total;
+
+		line_no = op->len / XDMA_CMD_AST2500_CMD_LINE_SIZE;
+		total = XDMA_CMD_AST2500_CMD_LINE_SIZE * line_no;
+		rem = (op->len - total) >>
+			XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
+		line_size = XDMA_CMD_AST2500_CMD_LINE_SIZE;
+		pitch = line_size >> XDMA_CMD_AST2500_PITCH_SHIFT;
+		line_size >>= XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
+
+		if (rem) {
+			u32 rbmc = bmc_addr + total;
+
+			cmds[1].host_addr = op->host_addr + (u64)total;
+			cmds[1].pitch = cmd_pitch |
+				((u64)rbmc & XDMA_CMD_AST2500_PITCH_ADDR) |
+				FIELD_PREP(XDMA_CMD_AST2500_PITCH_HOST, 1) |
+				FIELD_PREP(XDMA_CMD_AST2500_PITCH_BMC, 1);
+			cmds[1].cmd = cmd |
+				FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_NO, 1) |
+				FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_SIZE,
+					   rem);
+			cmds[1].reserved = 0ULL;
+
+			print_hex_dump_debug("xdma rem ", DUMP_PREFIX_OFFSET,
+					     16, 1, &cmds[1], sizeof(*cmds),
+					     true);
+
+			cmd &= ~(XDMA_CMD_AST2500_CMD_IRQ_EN |
+				 XDMA_CMD_AST2500_CMD_IRQ_BMC);
+
+			rc++;
+		}
+	}
+
+	cmds[0].host_addr = op->host_addr;
+	cmds[0].pitch = cmd_pitch |
+		((u64)bmc_addr & XDMA_CMD_AST2500_PITCH_ADDR) |
+		FIELD_PREP(XDMA_CMD_AST2500_PITCH_HOST, pitch) |
+		FIELD_PREP(XDMA_CMD_AST2500_PITCH_BMC, pitch);
+	cmds[0].cmd = cmd | FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_NO, line_no) |
+		FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_SIZE, line_size);
+	cmds[0].reserved = 0ULL;
+
+	print_hex_dump_debug("xdma cmd ", DUMP_PREFIX_OFFSET, 16, 1, cmds,
+			     sizeof(*cmds), true);
+
+	return rc;
+}
+
+static unsigned int aspeed_xdma_ast2600_set_cmd(struct aspeed_xdma *ctx,
+						struct aspeed_xdma_cmd cmds[2],
+						struct aspeed_xdma_op *op,
+						u32 bmc_addr)
+{
+	unsigned int rc = 1;
+	unsigned int pitch = 1;
+	unsigned int line_no = 1;
+	unsigned int line_size = op->len;
+	u64 cmd = XDMA_CMD_AST2600_CMD_IRQ_BMC |
+		(op->direction ? XDMA_CMD_AST2600_CMD_UPSTREAM : 0);
+
+	if (op->host_addr & 0xffffffff00000000ULL ||
+	    (op->host_addr + (u64)op->len) & 0xffffffff00000000ULL)
+		cmd |= XDMA_CMD_AST2600_CMD_64_EN;
+
+	dev_dbg(ctx->dev, "xdma %s ast2600: bmc[%08x] len[%08x] "
+		"host[%016llx]\n", op->direction ? "upstream" : "downstream",
+		bmc_addr, op->len, op->host_addr);
+
+	if (op->len > XDMA_CMD_AST2600_CMD_LINE_SIZE) {
+		unsigned int rem;
+		unsigned int total;
+
+		line_no = op->len / XDMA_CMD_AST2600_CMD_MULTILINE_SIZE;
+		total = XDMA_CMD_AST2600_CMD_MULTILINE_SIZE * line_no;
+		rem = op->len - total;
+		line_size = XDMA_CMD_AST2600_CMD_MULTILINE_SIZE;
+		pitch = line_size;
+
+		if (rem) {
+			u32 rbmc = bmc_addr + total;
+
+			cmds[1].host_addr = op->host_addr + (u64)total;
+			cmds[1].pitch =
+				((u64)rbmc & XDMA_CMD_AST2600_PITCH_ADDR) |
+				FIELD_PREP(XDMA_CMD_AST2600_PITCH_HOST, 1) |
+				FIELD_PREP(XDMA_CMD_AST2600_PITCH_BMC, 1);
+			cmds[1].cmd = cmd |
+				FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_NO, 1) |
+				FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_SIZE,
+					   rem);
+			cmds[1].reserved = 0ULL;
+
+			print_hex_dump_debug("xdma rem ", DUMP_PREFIX_OFFSET,
+					     16, 1, &cmds[1], sizeof(*cmds),
+					     true);
+
+			cmd &= ~XDMA_CMD_AST2600_CMD_IRQ_BMC;
+
+			rc++;
+		}
+	}
+
+	cmds[0].host_addr = op->host_addr;
+	cmds[0].pitch = ((u64)bmc_addr & XDMA_CMD_AST2600_PITCH_ADDR) |
+		FIELD_PREP(XDMA_CMD_AST2600_PITCH_HOST, pitch) |
+		FIELD_PREP(XDMA_CMD_AST2600_PITCH_BMC, pitch);
+	cmds[0].cmd = cmd | FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_NO, line_no) |
+		FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_SIZE, line_size);
+	cmds[0].reserved = 0ULL;
+
+	print_hex_dump_debug("xdma cmd ", DUMP_PREFIX_OFFSET, 16, 1, cmds,
+			     sizeof(*cmds), true);
+
+	return rc;
+}
+
+static void aspeed_xdma_start(struct aspeed_xdma *ctx,
+			      struct aspeed_xdma_op *op, u32 bmc_addr,
+			      struct aspeed_xdma_client *client)
+{
+	unsigned int i;
+	unsigned long flags;
+	struct aspeed_xdma_cmd cmds[2];
+	unsigned int rc = ctx->chip->set_cmd(ctx, cmds, op, bmc_addr);
+
+	mutex_lock(&ctx->start_lock);
+
+	for (i = 0; i < rc; ++i) {
+		memcpy(&ctx->cmdq[ctx->cmd_idx], &cmds[i],
+		       sizeof(struct aspeed_xdma_cmd));
+		ctx->cmd_idx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
+	}
+
+	ctx->upstream = !!op->direction;
+
+	spin_lock_irqsave(&ctx->client_lock, flags);
+
+	client->error = false;
+	client->in_progress = true;
+	ctx->current_client = client;
+
+	spin_unlock_irqrestore(&ctx->client_lock, flags);
+
+	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_writep,
+			   ctx->cmd_idx * ctx->chip->queue_entry_size);
+
+	mutex_unlock(&ctx->start_lock);
+}
+
+static void aspeed_xdma_done(struct aspeed_xdma *ctx, bool error)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->client_lock, flags);
+
+	if (ctx->current_client) {
+		ctx->current_client->error = error;
+		ctx->current_client->in_progress = false;
+		ctx->current_client = NULL;
+	}
+
+	spin_unlock_irqrestore(&ctx->client_lock, flags);
+
+	wake_up_interruptible_all(&ctx->wait);
+}
+
+static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
+{
+	struct aspeed_xdma *ctx = arg;
+	u32 status = aspeed_xdma_readl(ctx, ctx->chip->regs.status);
+
+	if (status & ctx->chip->status_bits.ds_dirty) {
+		aspeed_xdma_done(ctx, true);
+	} else {
+		if (status & ctx->chip->status_bits.us_comp) {
+			if (ctx->upstream)
+				aspeed_xdma_done(ctx, false);
+		}
+
+		if (status & ctx->chip->status_bits.ds_comp) {
+			if (!ctx->upstream)
+				aspeed_xdma_done(ctx, false);
+		}
+	}
+
+	aspeed_xdma_writel(ctx, ctx->chip->regs.status, status);
+
+	return IRQ_HANDLED;
+}
+
+static void aspeed_xdma_reset(struct aspeed_xdma *ctx)
+{
+	unsigned long flags;
+
+	reset_control_assert(ctx->reset);
+	usleep_range(XDMA_ENGINE_SETUP_TIME_MIN_US,
+		     XDMA_ENGINE_SETUP_TIME_MAX_US);
+	reset_control_deassert(ctx->reset);
+	usleep_range(XDMA_ENGINE_SETUP_TIME_MIN_US,
+		     XDMA_ENGINE_SETUP_TIME_MAX_US);
+
+	aspeed_xdma_init_eng(ctx);
+
+	spin_lock_irqsave(&ctx->reset_lock, flags);
+	ctx->in_reset = false;
+	spin_unlock_irqrestore(&ctx->reset_lock, flags);
+
+	aspeed_xdma_done(ctx, true);
+}
+
+static void aspeed_xdma_reset_work(struct work_struct *work)
+{
+	struct aspeed_xdma *ctx = container_of(work, struct aspeed_xdma,
+					       reset_work);
+
+	/*
+	 * Lock to make sure operations aren't started while the engine is
+	 * in reset.
+	 */
+	mutex_lock(&ctx->start_lock);
+
+	aspeed_xdma_reset(ctx);
+
+	mutex_unlock(&ctx->start_lock);
+}
+
+static irqreturn_t aspeed_xdma_pcie_irq(int irq, void *arg)
+{
+	unsigned long flags;
+	struct aspeed_xdma *ctx = arg;
+
+	dev_dbg(ctx->dev, "PCI-E reset requested.\n");
+
+	spin_lock_irqsave(&ctx->reset_lock, flags);
+	if (ctx->in_reset) {
+		spin_unlock_irqrestore(&ctx->reset_lock, flags);
+		return IRQ_HANDLED;
+	}
+
+	ctx->in_reset = true;
+	spin_unlock_irqrestore(&ctx->reset_lock, flags);
+
+	schedule_work(&ctx->reset_work);
+	return IRQ_HANDLED;
+}
+
+static int aspeed_xdma_init_scu(struct aspeed_xdma *ctx, struct device *dev)
+{
+	struct regmap *scu = syscon_regmap_lookup_by_phandle(dev->of_node,
+							     "aspeed,scu");
+
+	if (!IS_ERR(scu)) {
+		u32 selection;
+		bool pcie_device_bmc = true;
+		const u32 bmc = SCU_PCIE_CONF_BMC_EN |
+			SCU_PCIE_CONF_BMC_EN_MSI | SCU_PCIE_CONF_BMC_EN_IRQ |
+			SCU_PCIE_CONF_BMC_EN_DMA;
+		const u32 vga = SCU_PCIE_CONF_VGA_EN |
+			SCU_PCIE_CONF_VGA_EN_MSI | SCU_PCIE_CONF_VGA_EN_IRQ |
+			SCU_PCIE_CONF_VGA_EN_DMA;
+		const char *pcie = NULL;
+
+		if (!of_property_read_string(dev->of_node, "pcie-device",
+					     &pcie)) {
+			if (!strcmp(pcie, "vga")) {
+				pcie_device_bmc = false;
+			} else if (strcmp(pcie, "bmc")) {
+				dev_err(dev,
+					"Invalid pcie-device property %s.\n",
+					pcie);
+				return -EINVAL;
+			}
+		}
+
+		if (pcie_device_bmc) {
+			selection = bmc;
+			regmap_write(scu, ctx->chip->scu_bmc_class,
+				     SCU_BMC_CLASS_REV_XDMA);
+		} else {
+			selection = vga;
+		}
+
+		regmap_update_bits(scu, ctx->chip->scu_pcie_conf, bmc | vga,
+				   selection);
+
+		if (ctx->chip->scu_misc_ctrl)
+			regmap_update_bits(scu, ctx->chip->scu_misc_ctrl,
+					   SCU_AST2600_MISC_CTRL_XDMA_BMC,
+					   SCU_AST2600_MISC_CTRL_XDMA_BMC);
+	} else {
+		dev_warn(dev, "Unable to configure PCIe: %ld; continuing.\n",
+			 PTR_ERR(scu));
+	}
+
+	return 0;
+}
+
+static int aspeed_xdma_probe(struct platform_device *pdev)
+{
+	int rc;
+	int irq;
+	int pcie_irq;
+	struct aspeed_xdma *ctx;
+	struct reserved_mem *mem;
+	struct device *dev = &pdev->dev;
+	struct device_node *memory_region;
+	const void *md = of_device_get_match_data(dev);
+
+	if (!md)
+		return -ENODEV;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->chip = md;
+	ctx->dev = dev;
+	platform_set_drvdata(pdev, ctx);
+	mutex_init(&ctx->start_lock);
+	INIT_WORK(&ctx->reset_work, aspeed_xdma_reset_work);
+	spin_lock_init(&ctx->client_lock);
+	spin_lock_init(&ctx->reset_lock);
+	init_waitqueue_head(&ctx->wait);
+
+	ctx->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ctx->base)) {
+		dev_err(dev, "Failed to map registers.\n");
+		return PTR_ERR(ctx->base);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Failed to find IRQ.\n");
+		return irq;
+	}
+
+	rc = devm_request_irq(dev, irq, aspeed_xdma_irq, 0, DEVICE_NAME, ctx);
+	if (rc < 0) {
+		dev_err(dev, "Failed to request IRQ %d.\n", irq);
+		return rc;
+	}
+
+	ctx->clock = devm_clk_get(dev, NULL);
+	if (IS_ERR(ctx->clock)) {
+		dev_err(dev, "Failed to request clock.\n");
+		return PTR_ERR(ctx->clock);
+	}
+
+	ctx->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(ctx->reset)) {
+		dev_err(dev, "Failed to request reset control.\n");
+		return PTR_ERR(ctx->reset);
+	}
+
+	ctx->reset_rc = devm_reset_control_get_exclusive(dev, "rc");
+	if (IS_ERR(ctx->reset_rc)) {
+		dev_dbg(dev, "Failed to request reset RC control.\n");
+		ctx->reset_rc = NULL;
+	}
+
+	ctx->pool = devm_gen_pool_create(dev, ilog2(PAGE_SIZE), -1, NULL);
+	if (!ctx->pool) {
+		dev_err(dev, "Failed to setup genalloc pool.\n");
+		return -ENOMEM;
+	}
+
+	memory_region = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!memory_region) {
+		dev_err(dev, "Failed to find memory-region.\n");
+		return -ENOMEM;
+	}
+
+	mem = of_reserved_mem_lookup(memory_region);
+	of_node_put(memory_region);
+	if (!mem) {
+		dev_err(dev, "Failed to find reserved memory.\n");
+		return -ENOMEM;
+	}
+
+	ctx->mem_phys = mem->base;
+	ctx->mem_size = mem->size;
+
+	ctx->mem_virt = devm_ioremap(dev, ctx->mem_phys, ctx->mem_size);
+	if (!ctx->mem_virt) {
+		dev_err(dev, "Failed to map memory space.\n");
+		return -ENOMEM;
+	}
+
+	rc = gen_pool_add_virt(ctx->pool, (unsigned long)ctx->mem_virt,
+			       ctx->mem_phys, ctx->mem_size, -1);
+	if (rc) {
+		dev_err(ctx->dev, "Failed to add memory to genalloc pool.\n");
+		return rc;
+	}
+
+	rc = aspeed_xdma_init_scu(ctx, dev);
+	if (rc)
+		return rc;
+
+	rc = clk_prepare_enable(ctx->clock);
+	if (rc) {
+		dev_err(dev, "Failed to enable the clock.\n");
+		return rc;
+	}
+
+	if (ctx->reset_rc) {
+		rc = reset_control_deassert(ctx->reset_rc);
+		if (rc) {
+			dev_err(dev, "Failed to clear the RC reset.\n");
+			goto err_reset_rc;
+		}
+		usleep_range(XDMA_ENGINE_SETUP_TIME_MIN_US,
+			     XDMA_ENGINE_SETUP_TIME_MAX_US);
+	}
+
+	rc = reset_control_deassert(ctx->reset);
+	if (rc) {
+		dev_err(dev, "Failed to clear the reset.\n");
+		goto err_reset;
+	}
+	usleep_range(XDMA_ENGINE_SETUP_TIME_MIN_US,
+		     XDMA_ENGINE_SETUP_TIME_MAX_US);
+
+	ctx->cmdq = gen_pool_dma_alloc(ctx->pool, XDMA_CMDQ_SIZE,
+				       &ctx->cmdq_phys);
+	if (!ctx->cmdq) {
+		dev_err(ctx->dev, "Failed to genalloc cmdq.\n");
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	aspeed_xdma_init_eng(ctx);
+
+	/*
+	 * This interrupt could fire immediately so only request it once the
+	 * engine and driver are initialized.
+	 */
+	pcie_irq = platform_get_irq(pdev, 1);
+	if (pcie_irq < 0) {
+		dev_warn(dev, "Failed to find PCI-E IRQ.\n");
+	} else {
+		rc = devm_request_irq(dev, pcie_irq, aspeed_xdma_pcie_irq,
+				      IRQF_SHARED, DEVICE_NAME, ctx);
+		if (rc < 0)
+			dev_warn(dev, "Failed to request PCI-E IRQ %d.\n", rc);
+	}
+
+	return 0;
+
+err:
+	reset_control_assert(ctx->reset);
+err_reset:
+	if (ctx->reset_rc)
+		reset_control_assert(ctx->reset_rc);
+err_reset_rc:
+	clk_disable_unprepare(ctx->clock);
+	return rc;
+}
+
+static int aspeed_xdma_remove(struct platform_device *pdev)
+{
+	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
+
+	gen_pool_free(ctx->pool, (unsigned long)ctx->cmdq, XDMA_CMDQ_SIZE);
+
+	reset_control_assert(ctx->reset);
+	if (ctx->reset_rc)
+		reset_control_assert(ctx->reset_rc);
+	clk_disable_unprepare(ctx->clock);
+
+	return 0;
+}
+
+static const struct aspeed_xdma_chip aspeed_ast2500_xdma_chip = {
+	.control = XDMA_AST2500_CTRL_US_COMP | XDMA_AST2500_CTRL_DS_COMP |
+		XDMA_AST2500_CTRL_DS_DIRTY | XDMA_AST2500_CTRL_DS_SIZE_256 |
+		XDMA_AST2500_CTRL_DS_TIMEOUT | XDMA_AST2500_CTRL_DS_CHECK_ID,
+	.scu_bmc_class = SCU_AST2500_BMC_CLASS_REV,
+	.scu_misc_ctrl = 0,
+	.scu_pcie_conf = SCU_AST2500_PCIE_CONF,
+	.queue_entry_size = XDMA_AST2500_QUEUE_ENTRY_SIZE,
+	.regs = {
+		.bmc_cmdq_addr = XDMA_AST2500_BMC_CMDQ_ADDR,
+		.bmc_cmdq_endp = XDMA_AST2500_BMC_CMDQ_ENDP,
+		.bmc_cmdq_writep = XDMA_AST2500_BMC_CMDQ_WRITEP,
+		.bmc_cmdq_readp = XDMA_AST2500_BMC_CMDQ_READP,
+		.control = XDMA_AST2500_CTRL,
+		.status = XDMA_AST2500_STATUS,
+	},
+	.status_bits = {
+		.us_comp = XDMA_AST2500_STATUS_US_COMP,
+		.ds_comp = XDMA_AST2500_STATUS_DS_COMP,
+		.ds_dirty = XDMA_AST2500_STATUS_DS_DIRTY,
+	},
+	.set_cmd = aspeed_xdma_ast2500_set_cmd,
+};
+
+static const struct aspeed_xdma_chip aspeed_ast2600_xdma_chip = {
+	.control = XDMA_AST2600_CTRL_US_COMP | XDMA_AST2600_CTRL_DS_COMP |
+		XDMA_AST2600_CTRL_DS_DIRTY | XDMA_AST2600_CTRL_DS_SIZE_256,
+	.scu_bmc_class = SCU_AST2600_BMC_CLASS_REV,
+	.scu_misc_ctrl = SCU_AST2600_MISC_CTRL,
+	.scu_pcie_conf = SCU_AST2600_PCIE_CONF,
+	.queue_entry_size = XDMA_AST2600_QUEUE_ENTRY_SIZE,
+	.regs = {
+		.bmc_cmdq_addr = XDMA_AST2600_BMC_CMDQ_ADDR,
+		.bmc_cmdq_endp = XDMA_AST2600_BMC_CMDQ_ENDP,
+		.bmc_cmdq_writep = XDMA_AST2600_BMC_CMDQ_WRITEP,
+		.bmc_cmdq_readp = XDMA_AST2600_BMC_CMDQ_READP,
+		.control = XDMA_AST2600_CTRL,
+		.status = XDMA_AST2600_STATUS,
+	},
+	.status_bits = {
+		.us_comp = XDMA_AST2600_STATUS_US_COMP,
+		.ds_comp = XDMA_AST2600_STATUS_DS_COMP,
+		.ds_dirty = XDMA_AST2600_STATUS_DS_DIRTY,
+	},
+	.set_cmd = aspeed_xdma_ast2600_set_cmd,
+};
+
+static const struct of_device_id aspeed_xdma_match[] = {
+	{
+		.compatible = "aspeed,ast2500-xdma",
+		.data = &aspeed_ast2500_xdma_chip,
+	},
+	{
+		.compatible = "aspeed,ast2600-xdma",
+		.data = &aspeed_ast2600_xdma_chip,
+	},
+	{ },
+};
+
+static struct platform_driver aspeed_xdma_driver = {
+	.probe = aspeed_xdma_probe,
+	.remove = aspeed_xdma_remove,
+	.driver = {
+		.name = DEVICE_NAME,
+		.of_match_table = aspeed_xdma_match,
+	},
+};
+
+module_platform_driver(aspeed_xdma_driver);
+
+MODULE_AUTHOR("Eddie James");
+MODULE_DESCRIPTION("Aspeed XDMA Engine Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
new file mode 100644
index 000000000000..2efaa6067c39
--- /dev/null
+++ b/include/uapi/linux/aspeed-xdma.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* Copyright IBM Corp 2019 */
+
+#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
+#define _UAPI_LINUX_ASPEED_XDMA_H_
+
+#include <linux/types.h>
+
+/*
+ * aspeed_xdma_direction
+ *
+ * ASPEED_XDMA_DIRECTION_DOWNSTREAM: transfers data from the host to the BMC
+ *
+ * ASPEED_XDMA_DIRECTION_UPSTREAM: transfers data from the BMC to the host
+ */
+enum aspeed_xdma_direction {
+	ASPEED_XDMA_DIRECTION_DOWNSTREAM = 0,
+	ASPEED_XDMA_DIRECTION_UPSTREAM,
+};
+
+/*
+ * aspeed_xdma_op
+ *
+ * host_addr: the DMA address on the host side, typically configured by PCI
+ *            subsystem
+ *
+ * len: the size of the transfer in bytes
+ *
+ * direction: an enumerator indicating the direction of the DMA operation; see
+ *            enum aspeed_xdma_direction
+ */
+struct aspeed_xdma_op {
+	__u64 host_addr;
+	__u32 len;
+	__u32 direction;
+};
+
+#endif /* _UAPI_LINUX_ASPEED_XDMA_H_ */
-- 
2.24.0

