Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4882C71F0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgK1Vua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:30 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:22564 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732909AbgK1SQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:16:26 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ASElvix027063;
        Sat, 28 Nov 2020 06:49:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=HZNK9ozdIfNzKt+a1n9uxggTzwzLND7lY4nsDf/icrM=;
 b=sW5Po4tpj0lRs+rqSVc4Bo9uOz/qTqnH165qs40PneOeuJpOTPSc0yxJGRzdcG0JI6GB
 BRJv+xeLfDBqi6C5iATxFuWvFob5iNfqQ4/rCSFOp3kJ+l3k6czyjvK8g0QxEDqIlHtT
 6YF9FjryqVRrXqwv/XPb4QWfyHcTWidjdoRetcIFhabGnRhOLExXw25sicFyqb+HoyiW
 /T3c8Fs9xchinAf+/AY7vpguojRYyS5ue/Vp5yezGMYR4Tn/at3veeuYoMTmu3ZuwVB8
 1PSpAtNYdg5ILYPdopH3qC9VOK16g5JiD1Wsr5+RGIpZwwvKBG646U6brpq3ZfpOVegu lQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02rf7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 06:49:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNhDwm8yWu2pU8siP0/n+2tcX5/Z6MDMd0t6TPMQ7GWlJhsqjRbCPAwQgkjdgM0sn8OEqdDlVQSUy/oZDL9BQktF9STNeuXRst1Xy6SF9c37wwvo1Tk7vMiA9zLnTwOf4xy7pqTXSG9ePDWZvJKIkDKiF60KloJSgXEA7Lvto2vhtcepEGjr1MdQZenGZhNaHUNE1TTb6DICMCPvauNVxrsK7P2Eebcdzo4fclyczVb1LU4bel+hgMUtruNoQ5+1MMYRDOoz40CWcnNHxBZwimc4FPderWpylI2jAq08pUhyWu+fgvr+R3fcUrciFvxCnyNDkx+WDN4V0Lbm72X3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZNK9ozdIfNzKt+a1n9uxggTzwzLND7lY4nsDf/icrM=;
 b=iqiImrwGnK/q1l0q4mL8Yd7xdxUKLbSGQIetXF6sTm/LKZ35q6POIPRTpCxh6Joau8fiKwxLCnSck72vfejNe2Y5uXFbCHqT6OgVKpbYI3/k9f6D0OanqWDYNElGpxllYArqnouYBX0UZf+UCvD/Z4Vzl1N7bnwVjm6M/IqRLLCpZzJrSYkUuPPhNDv7fbrYzXYUCXqCu8m3u1A6fT06mc+ZtUDoVz6eX2el3eWWWk+weNhXXAlIDNpc+KockAO1mfQgUDtq88flzbGzZmMb2wJkFlLDvq41hYUhOLzcYHreDiCjB8a/lhrMBz/DZCvF54yNXxZaz6XE3ChJPjPZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZNK9ozdIfNzKt+a1n9uxggTzwzLND7lY4nsDf/icrM=;
 b=w8E3P85FJtSn9cFIAuO1MJyFvvrqB2EmtnM0X5NU2KXXjusBEPx/kz8DI3ZDnt97k4EDyAXbHn8odPfZG98/yccYgv+f8YNh5WM5s3CzzN+hNXoIsZH2E7WRx3KL545IUGdFtiqpZAWR7e6u9GtoQeMzsAfzrvCCNluViBgdJog=
Received: from BN6PR2001CA0014.namprd20.prod.outlook.com
 (2603:10b6:404:b4::24) by CH2PR07MB7239.namprd07.prod.outlook.com
 (2603:10b6:610:ac::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Sat, 28 Nov
 2020 14:49:03 +0000
Received: from BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::96) by BN6PR2001CA0014.outlook.office365.com
 (2603:10b6:404:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sat, 28 Nov 2020 14:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT065.mail.protection.outlook.com (10.13.182.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Sat, 28 Nov 2020 14:49:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0ASEmxhT004515
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 28 Nov 2020 06:49:00 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 28 Nov 2020 15:48:58 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 28 Nov 2020 15:48:58 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ASEmw0q021528;
        Sat, 28 Nov 2020 15:48:58 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ASEmwlf021527;
        Sat, 28 Nov 2020 15:48:58 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v9 7/7] i3c: master: mastership handover, defslvs processing in cdns controller driver
Date:   Sat, 28 Nov 2020 15:48:57 +0100
Message-ID: <1606574937-21492-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75b0aa0f-93a4-41bf-4269-08d893acbf43
X-MS-TrafficTypeDiagnostic: CH2PR07MB7239:
X-Microsoft-Antispam-PRVS: <CH2PR07MB7239BD08AE36783847AB7F23C1F70@CH2PR07MB7239.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1uqgJKYKqWX89vt18wD9s03xxExmlyytcFc8mbVUrAtTUsKcR48wf8JWGsY/s4/DOstRM1+lken6TtzT27n9VwjxCvbklRw3dWOj19S7nKUVbR+HBqCPhnxHCF5vozx/b3N7i3ihAP4+H5ccp0QodgoxdtsugmvzTBopsHKeF3VVLlxt5qPjQekvAiGQIN95x75SMRgwCyDu9Z6MLp34WzaSP7BEcn7tC8yp74bzqwUgMimM9CZmCWoE3Kt2xR7S00S/73HnPJGYDhahwGJKp+5jFKk/tzKHnHP+K/nBeBDdlyMgO7O0X/5+0/uBpehMDmblPq/kekemRSagf7KL+SsOXwinhFzG0SFTn00RAwEgifkXk060G0BVTTuc9s6NXnV3ciBhHBcrFFdN923x4Pc5OXctZmovGr6lEAEIpg=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36092001)(46966005)(5660300002)(107886003)(86362001)(82310400003)(8936002)(316002)(82740400003)(336012)(36756003)(36906005)(8676002)(2616005)(4326008)(2906002)(26005)(70206006)(186003)(30864003)(426003)(54906003)(42186006)(110136005)(47076004)(7636003)(83380400001)(478600001)(70586007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 14:49:02.3510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b0aa0f-93a4-41bf-4269-08d893acbf43
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB7239
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_09:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011280090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added I3C bus mastership handover and DEFSLVS message handling
code to Cadence's I3C master controller driver.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master/i3c-master-cdns.c |  329 +++++++++++++++++++++++++++++++---
 1 files changed, 306 insertions(+), 23 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index f1d6d68..ff07862 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -160,6 +160,7 @@
 #define SLV_IMR				0x48
 #define SLV_ICR				0x4c
 #define SLV_ISR				0x50
+#define SLV_INT_DEFSLVS			BIT(21)
 #define SLV_INT_TM			BIT(20)
 #define SLV_INT_ERROR			BIT(19)
 #define SLV_INT_EVENT_UP		BIT(18)
@@ -192,7 +193,7 @@
 #define SLV_STATUS1_HJ_DIS		BIT(18)
 #define SLV_STATUS1_MR_DIS		BIT(17)
 #define SLV_STATUS1_PROT_ERR		BIT(16)
-#define SLV_STATUS1_DA(x)		(((s) & GENMASK(15, 9)) >> 9)
+#define SLV_STATUS1_DA(s)		(((s) & GENMASK(15, 9)) >> 9)
 #define SLV_STATUS1_HAS_DA		BIT(8)
 #define SLV_STATUS1_DDR_RX_FULL		BIT(7)
 #define SLV_STATUS1_DDR_TX_FULL		BIT(6)
@@ -397,6 +398,9 @@ struct cdns_i3c_data {
 
 struct cdns_i3c_master {
 	struct work_struct hj_work;
+	struct work_struct mr_yield_work;
+	struct work_struct defslvs_work;
+	struct completion mr_done;
 	struct i3c_master_controller base;
 	u32 free_rr_slots;
 	unsigned int maxdevs;
@@ -416,6 +420,7 @@ struct cdns_i3c_master {
 	struct cdns_i3c_master_caps caps;
 	unsigned long i3c_scl_lim;
 	const struct cdns_i3c_data *devdata;
+	u8 mr_addr;
 };
 
 static inline struct cdns_i3c_master *
@@ -1182,10 +1187,6 @@ static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
 
 	cdns_i3c_master_upd_i3c_scl_lim(master);
 
-	/* Unmask Hot-Join and Mastership request interrupts. */
-	i3c_master_enec_locked(m, I3C_BROADCAST_ADDR,
-			       I3C_CCC_EVENT_HJ | I3C_CCC_EVENT_MR);
-
 	return 0;
 }
 
@@ -1208,21 +1209,21 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
 	unsigned long pres_step, sysclk_rate, max_i2cfreq;
 	struct i3c_bus *bus = i3c_master_get_bus(m);
-	u32 ctrl, prescl0, prescl1, pres, low;
+	u32 ctrl, prescl0, prescl1, pres, low, bus_mode;
 	struct i3c_device_info info = { };
 	int ret, ncycles;
 
 	switch (bus->mode) {
 	case I3C_BUS_MODE_PURE:
-		ctrl = CTRL_PURE_BUS_MODE;
+		bus_mode = CTRL_PURE_BUS_MODE;
 		break;
 
 	case I3C_BUS_MODE_MIXED_FAST:
-		ctrl = CTRL_MIXED_FAST_BUS_MODE;
+		bus_mode = CTRL_MIXED_FAST_BUS_MODE;
 		break;
 
 	case I3C_BUS_MODE_MIXED_SLOW:
-		ctrl = CTRL_MIXED_SLOW_BUS_MODE;
+		bus_mode = CTRL_MIXED_SLOW_BUS_MODE;
 		break;
 
 	default:
@@ -1253,7 +1254,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
 
 	prescl0 |= PRESCL_CTRL0_I2C(pres);
-	writel(prescl0, master->regs + PRESCL_CTRL0);
 
 	/* Calculate OD and PP low. */
 	pres_step = 1000000000 / (bus->scl_rate.i3c * 4);
@@ -1261,7 +1261,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ncycles < 0)
 		ncycles = 0;
 	prescl1 = PRESCL_CTRL1_OD_LOW(ncycles);
-	writel(prescl1, master->regs + PRESCL_CTRL1);
 
 	/* Get an address for the master. */
 	ret = i3c_master_get_free_addr(m, 0);
@@ -1279,13 +1278,21 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
+	ctrl = readl(master->regs + CTRL);
+	if (ctrl & CTRL_DEV_EN)
+		cdns_i3c_master_disable(master);
+	writel(prescl0, master->regs + PRESCL_CTRL0);
+	writel(prescl1, master->regs + PRESCL_CTRL1);
+	ctrl &= ~CTRL_BUS_MODE_MASK;
+	ctrl |= bus_mode | CTRL_HALT_EN | CTRL_MCS_EN;
 	/*
 	 * Enable Hot-Join, and, when a Hot-Join request happens, disable all
 	 * events coming from this device.
 	 *
 	 * We will issue ENTDAA afterwards from the threaded IRQ handler.
 	 */
-	ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC | CTRL_HALT_EN | CTRL_MCS_EN;
+	if (!m->secondary)
+		ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC;
 
 	/*
 	 * Configure data hold delay based on device-specific data.
@@ -1358,6 +1365,7 @@ static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
 
 static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 {
+	struct i3c_dev_desc *dev;
 	u32 status0;
 
 	writel(MST_INT_IBIR_THR, master->regs + MST_ICR);
@@ -1379,6 +1387,14 @@ static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 
 		case IBIR_TYPE_MR:
 			WARN_ON(IBIR_XFER_BYTES(ibir) || (ibir & IBIR_ERROR));
+			if (ibir & IBIR_ACKED) {
+				dev = master->ibi.slots[IBIR_SLVID(ibir)];
+				master->mr_addr = dev->info.dyn_addr;
+				queue_work(master->base.wq,
+					   &master->mr_yield_work);
+			}
+			break;
+
 		default:
 			break;
 		}
@@ -1390,16 +1406,42 @@ static irqreturn_t cdns_i3c_master_interrupt(int irq, void *data)
 	struct cdns_i3c_master *master = data;
 	u32 status;
 
-	status = readl(master->regs + MST_ISR);
-	if (!(status & readl(master->regs + MST_IMR)))
-		return IRQ_NONE;
+	if (master->base.this &&
+	    master->base.this == master->base.bus.cur_master) {
+		status = readl(master->regs + MST_ISR);
+		if (!(status & readl(master->regs + MST_IMR)))
+			return IRQ_NONE;
+
+		spin_lock(&master->xferqueue.lock);
+		cdns_i3c_master_end_xfer_locked(master, status);
+		spin_unlock(&master->xferqueue.lock);
+
+		if (status & MST_INT_IBIR_THR)
+			cnds_i3c_master_demux_ibis(master);
+
+		if (status & MST_INT_MR_DONE) {
+			writel(FLUSH_RX_FIFO | FLUSH_TX_FIFO,
+			       master->regs + FLUSH_CTRL);
+			writel(MST_INT_MR_DONE, master->regs + MST_ICR);
+		}
+	} else {
+		status = (readl(master->regs + SLV_ISR) &
+			  readl(master->regs + SLV_IMR));
+
+		if (!status)
+			return IRQ_NONE;
+
+		if (status & SLV_INT_MR_DONE) {
+			writel(FLUSH_RX_FIFO | FLUSH_TX_FIFO,
+			       master->regs + FLUSH_CTRL);
+			complete(&master->mr_done);
+		}
 
-	spin_lock(&master->xferqueue.lock);
-	cdns_i3c_master_end_xfer_locked(master, status);
-	spin_unlock(&master->xferqueue.lock);
+		if (status & SLV_INT_DEFSLVS)
+			queue_work(master->base.wq, &master->defslvs_work);
 
-	if (status & MST_INT_IBIR_THR)
-		cnds_i3c_master_demux_ibis(master);
+		writel(status, master->regs + SLV_ICR);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1523,6 +1565,106 @@ static void cdns_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
 	i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 }
 
+static int cdns_i3c_master_find_ibi_slot(struct cdns_i3c_master *master,
+					 struct i3c_dev_desc *dev,
+					 s16 *slot)
+{
+	unsigned long flags;
+	unsigned int i;
+	int ret = -ENOENT;
+
+	spin_lock_irqsave(&master->ibi.lock, flags);
+	for (i = 0; i < master->ibi.num_slots; i++) {
+		if (master->ibi.slots[i] == dev) {
+			*slot = i;
+			ret = 0;
+			break;
+		}
+	}
+
+	if (ret) {
+		for (i = 0; i < master->ibi.num_slots; i++) {
+			if (!master->ibi.slots[i]) {
+				master->ibi.slots[i] = dev;
+				*slot = i;
+				ret = 0;
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&master->ibi.lock, flags);
+
+	return ret;
+}
+
+static int cdns_i3c_request_mastership(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	int status;
+
+	status = readl(master->regs + MST_STATUS0);
+	if (status & MST_STATUS0_MASTER_MODE)
+		return 0;
+
+	status = readl(master->regs + SLV_STATUS1);
+	if (!(status & SLV_STATUS1_HAS_DA))
+		return -EACCES;
+
+	if (status & SLV_STATUS1_MR_DIS)
+		return -EACCES;
+
+	writel(readl(master->regs + CTRL) | CTRL_MST_INIT | CTRL_MST_ACK,
+	       master->regs + CTRL);
+
+	init_completion(&master->mr_done);
+	if (!wait_for_completion_timeout(&master->mr_done,
+					 msecs_to_jiffies(1000)))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void
+cdns_i3c_master_enable_mastership_events(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	struct cdns_i3c_i2c_dev_data *data;
+	struct i3c_dev_desc *i3cdev;
+	unsigned long flags;
+	u32 sircfg, sirmap;
+	int ret;
+
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) !=
+		    I3C_BCR_I3C_MASTER ||
+		    m->this == i3cdev)
+			continue;
+
+		data = i3c_dev_get_master_data(i3cdev);
+		if (!data)
+			continue;
+
+		ret = cdns_i3c_master_find_ibi_slot(master, i3cdev, &data->ibi);
+		if (ret)
+			continue;
+
+		spin_lock_irqsave(&master->ibi.lock, flags);
+		sirmap = readl(master->regs + SIR_MAP_DEV_REG(data->ibi));
+		sirmap &= ~SIR_MAP_DEV_CONF_MASK(data->ibi);
+		sircfg = SIR_MAP_DEV_ROLE(i3cdev->info.bcr >> 6) |
+			SIR_MAP_DEV_DA(i3cdev->info.dyn_addr) |
+			SIR_MAP_DEV_PL(i3cdev->info.max_ibi_len) |
+			SIR_MAP_DEV_ACK;
+
+		if (i3cdev->info.bcr & I3C_BCR_MAX_DATA_SPEED_LIM)
+			sircfg |= SIR_MAP_DEV_SLOW;
+
+		sirmap |= SIR_MAP_DEV_CONF(data->ibi, sircfg);
+		writel(sirmap, master->regs + SIR_MAP_DEV_REG(data->ibi));
+		spin_unlock_irqrestore(&master->ibi.lock, flags);
+	}
+}
+
 static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.bus_init = cdns_i3c_master_bus_init,
 	.bus_cleanup = cdns_i3c_master_bus_cleanup,
@@ -1541,6 +1683,8 @@ static void cdns_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
 	.request_ibi = cdns_i3c_master_request_ibi,
 	.free_ibi = cdns_i3c_master_free_ibi,
 	.recycle_ibi_slot = cdns_i3c_master_recycle_ibi_slot,
+	.request_mastership = cdns_i3c_request_mastership,
+	.enable_mr_events = cdns_i3c_master_enable_mastership_events,
 };
 
 static void cdns_i3c_master_hj(struct work_struct *work)
@@ -1561,9 +1705,134 @@ static void cdns_i3c_master_hj(struct work_struct *work)
 	{ /* sentinel */ },
 };
 
+static void cdns_i3c_master_yield(struct work_struct *work)
+{
+	struct cdns_i3c_master *master = container_of(work,
+						      struct cdns_i3c_master,
+						      mr_yield_work);
+
+	i3c_master_yield_bus(&master->base, master->mr_addr);
+}
+
+static void cdns_i3c_sec_master_defslvs(struct work_struct *work)
+{
+	struct cdns_i3c_master *master = container_of(work,
+						      struct cdns_i3c_master,
+						      defslvs_work);
+	struct i3c_master_controller *m = &master->base;
+	struct i3c_ccc_dev_desc *desc;
+	struct cdns_i3c_i2c_dev_data *data;
+	struct i2c_dev_desc *i2cdev;
+	u32 devs, val, rr, slot;
+	u32 r0, r1, r2;
+	u8 saddr;
+
+	devs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
+	master->free_rr_slots = GENMASK(master->maxdevs, 1) & ~devs;
+
+	/*
+	 * We chose to ignore I2C devices received from
+	 * main master and use I2C device info from boardinfo.
+	 * Since I2C device from boardinfo are already
+	 * registered during bus_init, we just use same slot
+	 * and if any I3C device is received in DEFSLVS in that
+	 * place, just move that I3C device to other free slot.
+	 * If there is no free slot, then such I3C devices
+	 * are ignored.
+	 * Master controller driver can chose how to handle I2C
+	 * devices in DEFSLVS and pass only I3C devices list to
+	 * I3C core DEFSVLS processing to handle hotplug and
+	 * I3C device address changes.
+	 */
+	for (slot = 0; slot < master->maxdevs; slot++) {
+		if (!(devs & BIT(slot)))
+			continue;
+
+		val = readl(master->regs + DEV_ID_RR0(slot));
+		if (!(val & DEV_ID_RR0_IS_I3C)) {
+			writel(readl(master->regs + DEVS_CTRL) |
+				DEVS_CTRL_DEV_CLR(slot),
+				master->regs + DEVS_CTRL);
+			master->free_rr_slots |= BIT(slot);
+		}
+	}
+
+	val = 0;
+	devs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
+	i3c_bus_for_each_i2cdev(&m->bus, i2cdev) {
+		data = i2c_dev_get_master_data(i2cdev);
+		if (devs & BIT(data->id)) {
+			rr = readl(master->regs + DEV_ID_RR0(data->id));
+			saddr = DEV_ID_RR0_GET_DEV_ADDR(rr);
+			if (saddr != i2cdev->boardinfo->base.addr) {
+				r0 = readl(master->regs + DEV_ID_RR0(data->id));
+				r1 = readl(master->regs + DEV_ID_RR1(data->id));
+				r2 = readl(master->regs + DEV_ID_RR2(data->id));
+				slot = ffs(master->free_rr_slots) - 1;
+				if (slot > 0) {
+					writel(r0,
+					       master->regs + DEV_ID_RR0(slot));
+					writel(r1,
+					       master->regs + DEV_ID_RR1(slot));
+					writel(r2,
+					       master->regs + DEV_ID_RR2(slot));
+					writel(readl(master->regs + DEVS_CTRL) |
+					       DEVS_CTRL_DEV_ACTIVE(slot),
+					       master->regs + DEVS_CTRL);
+					master->free_rr_slots &= ~BIT(slot);
+				}
+			} else {
+				continue;
+			}
+		}
+		writel(readl(master->regs + DEVS_CTRL) |
+		       DEVS_CTRL_DEV_CLR(data->id),
+		       master->regs + DEVS_CTRL);
+		writel(readl(master->regs + DEVS_CTRL) |
+		       DEVS_CTRL_DEV_ACTIVE(data->id),
+		       master->regs + DEVS_CTRL);
+		writel(prepare_rr0_dev_address(i2cdev->boardinfo->base.addr) |
+		       (i2cdev->boardinfo->base.flags & I2C_CLIENT_TEN ?
+			DEV_ID_RR0_LVR_EXT_ADDR : 0),
+			master->regs + DEV_ID_RR0(data->id));
+		writel(i2cdev->boardinfo->lvr,
+		       master->regs + DEV_ID_RR2(data->id));
+		master->free_rr_slots &= ~BIT(data->id);
+	}
+
+	master->base.defslvs_data.ndevs = 0;
+	desc = master->base.defslvs_data.devs;
+	devs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
+
+	for (slot = 0; slot < master->maxdevs; slot++) {
+		if (!(devs & BIT(slot)))
+			continue;
+
+		val = readl(master->regs + DEV_ID_RR0(slot));
+		if (val & DEV_ID_RR0_IS_I3C) {
+			memset(desc, 0, sizeof(struct i3c_ccc_dev_desc));
+			rr = readl(master->regs + DEV_ID_RR0(slot));
+			desc->dyn_addr = DEV_ID_RR0_GET_DEV_ADDR(rr);
+			rr = readl(master->regs + DEV_ID_RR2(slot));
+			desc->dcr = rr;
+			desc->bcr = rr >> 8;
+			master->base.defslvs_data.ndevs++;
+			desc++;
+		}
+	}
+
+	val = readl(master->regs + SLV_STATUS1);
+	if (!(val & SLV_STATUS1_HAS_DA) ||
+	    i3c_master_process_defslvs(m, SLV_STATUS1_DA(val))) {
+		queue_work(master->base.wq, work);
+		return;
+	}
+}
+
 static int cdns_i3c_master_probe(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master;
+	bool secondary;
 	int ret, irq;
 	u32 val;
 
@@ -1607,6 +1876,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	spin_lock_init(&master->xferqueue.lock);
 	INIT_LIST_HEAD(&master->xferqueue.list);
 
+	INIT_WORK(&master->mr_yield_work, cdns_i3c_master_yield);
 	INIT_WORK(&master->hj_work, cdns_i3c_master_hj);
 	writel(0xffffffff, master->regs + MST_IDR);
 	writel(0xffffffff, master->regs + SLV_IDR);
@@ -1618,6 +1888,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	val = readl(master->regs + CONF_STATUS0);
+	secondary = (val & CONF_STATUS0_SEC_MASTER) ? true : false;
 
 	/* Device ID0 is reserved to describe this master. */
 	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
@@ -1640,12 +1911,24 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 		goto err_disable_sysclk;
 	}
 
+	if (secondary)
+		INIT_WORK(&master->defslvs_work, cdns_i3c_sec_master_defslvs);
+
 	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
-	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
+	writel(MST_INT_IBIR_THR | MST_INT_MR_DONE, master->regs + MST_IER);
 	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
 
-	ret = i3c_primary_master_register(&master->base, &pdev->dev,
-					  &cdns_i3c_master_ops);
+	if (secondary) {
+		ret = i3c_secondary_master_register(&master->base, &pdev->dev,
+						    &cdns_i3c_master_ops);
+		if (!ret)
+			writel(SLV_INT_DEFSLVS | SLV_INT_MR_DONE,
+			       master->regs + SLV_IER);
+	} else {
+		ret = i3c_primary_master_register(&master->base, &pdev->dev,
+						  &cdns_i3c_master_ops);
+	}
+
 	if (ret)
 		goto err_disable_sysclk;
 
-- 
1.7.1

