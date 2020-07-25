Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C811722D46E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 05:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGYDr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 23:47:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbgGYDqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:46:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C0E6D647128CF9C716BE;
        Sat, 25 Jul 2020 11:46:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 11:46:40 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 02/10] crypto: hisilicon/zip - unify naming style for functions and macros
Date:   Sat, 25 Jul 2020 11:44:35 +0800
Message-ID: <1595648683-50590-3-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
References: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add prefix 'HZIP' for some macros
2.Add prefix 'hisi_zip' for some functions

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 35 +++++++++++++++++----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 445db04..058f744 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -29,18 +29,18 @@
 #define DECOMP3_ENABLE			BIT(5)
 #define DECOMP4_ENABLE			BIT(6)
 #define DECOMP5_ENABLE			BIT(7)
-#define ALL_COMP_DECOMP_EN		(COMP0_ENABLE | COMP1_ENABLE |	\
+#define HZIP_ALL_COMP_DECOMP_EN		(COMP0_ENABLE | COMP1_ENABLE | \
 					 DECOMP0_ENABLE | DECOMP1_ENABLE | \
 					 DECOMP2_ENABLE | DECOMP3_ENABLE | \
 					 DECOMP4_ENABLE | DECOMP5_ENABLE)
-#define DECOMP_CHECK_ENABLE		BIT(16)
+#define HZIP_DECOMP_CHECK_ENABLE	BIT(16)
 #define HZIP_FSM_MAX_CNT		0x301008

 #define HZIP_PORT_ARCA_CHE_0		0x301040
 #define HZIP_PORT_ARCA_CHE_1		0x301044
 #define HZIP_PORT_AWCA_CHE_0		0x301060
 #define HZIP_PORT_AWCA_CHE_1		0x301064
-#define CACHE_ALL_EN			0xffffffff
+#define HZIP_CACHE_ALL_EN		0xffffffff

 #define HZIP_BD_RUSER_32_63		0x301110
 #define HZIP_SGL_RUSER_32_63		0x30111c
@@ -82,7 +82,7 @@
 #define HZIP_PF_DEF_Q_BASE		0

 #define HZIP_SOFT_CTRL_CNT_CLR_CE	0x301000
-#define SOFT_CTRL_CNT_CLR_CE_BIT	BIT(0)
+#define HZIP_SOFT_CTRL_CNT_CLR_CE_BIT	BIT(0)
 #define HZIP_SOFT_CTRL_ZIP_CONTROL	0x30100C
 #define HZIP_AXI_SHUTDOWN_ENABLE	BIT(14)
 #define HZIP_WR_PORT			BIT(11)
@@ -264,10 +264,10 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 	writel(PEH_AXUSER_CFG_ENABLE, base + QM_PEH_AXUSER_CFG_ENABLE);

 	/* cache */
-	writel(CACHE_ALL_EN, base + HZIP_PORT_ARCA_CHE_0);
-	writel(CACHE_ALL_EN, base + HZIP_PORT_ARCA_CHE_1);
-	writel(CACHE_ALL_EN, base + HZIP_PORT_AWCA_CHE_0);
-	writel(CACHE_ALL_EN, base + HZIP_PORT_AWCA_CHE_1);
+	writel(HZIP_CACHE_ALL_EN, base + HZIP_PORT_ARCA_CHE_0);
+	writel(HZIP_CACHE_ALL_EN, base + HZIP_PORT_ARCA_CHE_1);
+	writel(HZIP_CACHE_ALL_EN, base + HZIP_PORT_AWCA_CHE_0);
+	writel(HZIP_CACHE_ALL_EN, base + HZIP_PORT_AWCA_CHE_1);

 	/* user domain configurations */
 	writel(AXUSER_BASE, base + HZIP_BD_RUSER_32_63);
@@ -283,7 +283,7 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 	}

 	/* let's open all compression/decompression cores */
-	writel(DECOMP_CHECK_ENABLE | ALL_COMP_DECOMP_EN,
+	writel(HZIP_DECOMP_CHECK_ENABLE | HZIP_ALL_COMP_DECOMP_EN,
 	       base + HZIP_CLOCK_GATE_CTRL);

 	/* enable sqc writeback */
@@ -390,7 +390,7 @@ static u32 clear_enable_read(struct ctrl_debug_file *file)
 	struct hisi_qm *qm = file_to_qm(file);

 	return readl(qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE) &
-	       SOFT_CTRL_CNT_CLR_CE_BIT;
+		     HZIP_SOFT_CTRL_CNT_CLR_CE_BIT;
 }

 static int clear_enable_write(struct ctrl_debug_file *file, u32 val)
@@ -402,14 +402,14 @@ static int clear_enable_write(struct ctrl_debug_file *file, u32 val)
 		return -EINVAL;

 	tmp = (readl(qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE) &
-	       ~SOFT_CTRL_CNT_CLR_CE_BIT) | val;
+	       ~HZIP_SOFT_CTRL_CNT_CLR_CE_BIT) | val;
 	writel(tmp, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);

 	return  0;
 }

-static ssize_t ctrl_debug_read(struct file *filp, char __user *buf,
-			       size_t count, loff_t *pos)
+static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
+					size_t count, loff_t *pos)
 {
 	struct ctrl_debug_file *file = filp->private_data;
 	char tbuf[HZIP_BUF_SIZE];
@@ -433,8 +433,9 @@ static ssize_t ctrl_debug_read(struct file *filp, char __user *buf,
 	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
 }

-static ssize_t ctrl_debug_write(struct file *filp, const char __user *buf,
-				size_t count, loff_t *pos)
+static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
+					 const char __user *buf,
+					 size_t count, loff_t *pos)
 {
 	struct ctrl_debug_file *file = filp->private_data;
 	char tbuf[HZIP_BUF_SIZE];
@@ -483,8 +484,8 @@ static ssize_t ctrl_debug_write(struct file *filp, const char __user *buf,
 static const struct file_operations ctrl_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = ctrl_debug_read,
-	.write = ctrl_debug_write,
+	.read = hisi_zip_ctrl_debug_read,
+	.write = hisi_zip_ctrl_debug_write,
 };


--
2.7.4

