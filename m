Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFB2C7E28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgK3GVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:21:34 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62882 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgK3GVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:21:34 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AU683wQ014038;
        Sun, 29 Nov 2020 22:20:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=HZNK9ozdIfNzKt+a1n9uxggTzwzLND7lY4nsDf/icrM=;
 b=XMbCo7mFdT/hq5w17TpCX338LbosgIzUa27zz9/Mh0Zqh4tTQo5KqtgcdqDovwnNOMNm
 8A/voXIHc7HHtUgw2bHZzSCJFw2ZlT9J4gTk4A4wy0GOa8CXPU9ed/LdFPRAaZCK81X0
 aGESCrDl+NJzaB4YIW1nqWJZLFEAt1rmt4qFA81058SWV4rKc7KOSMQR+n/LuDVXFT0k
 uLRpgIMAmnR1gyKQkiku81wDI9drNvW0RR0G1rRt5pBLhkvdfHnHXMsEN/E5o9C+sCTp
 LL4DndvLsYijQfMpsqQ4bpH7v/E8b7h8OsqH2gBaCCY11tGadb9hdBfpLVLctGUkLVNd 5g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02v21u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 22:20:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M63XfRVeH8g/FAdPp8fTqpsiNSjf4Vuj6F1VDaW1yDclwxrjzzcV9WkaDUgv6sQIon/Jzy4BIEE7hR80LV38s8kaOXKI/rORKfA/I3cdbgeuaX0xNRxrGYJIoyTY1MjCzo0xTs8ann/yrqzP9C6/moYBNA2lwb4LbZ27xORg7AD2PJr0ib9X3J5yRrUJkjUn4RURxYLIwdh48d/mQbEtdMbloobrKQNCRefNNVXgo5bkPWOaS21BfoUCqQh6Pl4AqogOEbHCXlyCkOW9ksn5PZnqcAASTOARemvimj16FsynuY5CP6TY+Gj/o7JIHw6F/X0vuWDHseUsG+74H2cWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZNK9ozdIfNzKt+a1n9uxggTzwzLND7lY4nsDf/icrM=;
 b=jvSnfQnKUX0LAQFA1I1CAn9IQi9s0VTYWCvE4jte693D9h33pGRPzX582ZJXep7oYJwk+t4THTTSjWuX1hGjQwe7+W/eP8U45I4Dr+wFziNpCAUvft+aD7vJx72wU3X4oAfcpf/8BhvD4HePxN2U3BW6XrIyPIDqjsWT+A/vtyhCcEbLRPADgHQS1Ak7gRcTetClXL0U+wmrC88Yjt0KDad3nPvc5vU7hw1dsNTeRZk6sq/xxY7cfU/Ne9LluEHAiWWePK32pFrqVgQHD/aNOtjHiqhIEMHRgkqtFV2l/ex24S1LlNSCJDZeLt44hIIw7lAuDc7gFRpJS7JEinyLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZNK9ozdIfNzKt+a1n9uxggTzwzLND7lY4nsDf/icrM=;
 b=XjmcbaILVTct7rD74d/zuOrePKw3JE4UuZpvvBIhBHb9B43plJAZwJwV4FX5T0L3gAAfMWwbc1M4z8g7HCn3fie1Yer9NwAoLrfTEgPKlnPGEmZZEUcHywPnyWKsFe+8wisyHRIcbOZRlH0Cw561SxrDy8xWbodm9gy7fiytj9g=
Received: from BN6PR03CA0014.namprd03.prod.outlook.com (2603:10b6:404:23::24)
 by BYAPR07MB4277.namprd07.prod.outlook.com (2603:10b6:a02:ca::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 06:20:41 +0000
Received: from BN8NAM12FT052.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:23:cafe::14) by BN6PR03CA0014.outlook.office365.com
 (2603:10b6:404:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 06:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT052.mail.protection.outlook.com (10.13.182.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Mon, 30 Nov 2020 06:20:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0AU6KaJV027887
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sun, 29 Nov 2020 22:20:37 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 30 Nov 2020 07:20:35 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Nov 2020 07:20:35 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6KZwZ004295;
        Mon, 30 Nov 2020 07:20:35 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AU6KZ6t004294;
        Mon, 30 Nov 2020 07:20:35 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v10 7/7] i3c: master: mastership handover, defslvs processing in cdns controller driver
Date:   Mon, 30 Nov 2020 07:20:33 +0100
Message-ID: <1606717233-4259-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb981c67-1474-455c-1e2b-08d894f80e8c
X-MS-TrafficTypeDiagnostic: BYAPR07MB4277:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4277178FE44E3ADF40D26B04C1F50@BYAPR07MB4277.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsun7+1+ECuYEzly61PFE6UMwNDnI5qlc0LJIrtBG9/qI5VJrPzO9Jqxs/9K9sYW9DgONqNvz5MWKkQzFPSJ5qvJ3BZUPIyZfxJwWl/jGnALN3DXM8RDIeVY7NVKwnZTDz7v4FAdWRHW/8F8wJ/M8ayMk7kj2NKeaUp9oJcMKanaIwCJnnhavkRvisGLHV3gQMa7skMhOyQ+BzltS3qsYe8C/mISLsunvFZf5F8Md33cOUerJfZ/r57q2gakZCWMFCvJXVljbtkr2gVnd7Ul3hqGWLbta8fmUCv0IsXNkioI79NRpH6+dq6YDfVo6hqi+zjxlV1n9eG1WdobxSo/7t6E258rX6KS1XN9q1MSTi+BkqorwtYTBQraMvqJ2/2FhxPooQQnYLptjVFs+Xjt1nzs/WUPaStc+Z8cbtOHuYs=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36092001)(46966005)(82740400003)(47076004)(2906002)(107886003)(82310400003)(356005)(83380400001)(70206006)(70586007)(30864003)(36756003)(81166007)(5660300002)(110136005)(336012)(426003)(86362001)(478600001)(316002)(42186006)(4326008)(186003)(8676002)(2616005)(8936002)(54906003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 06:20:38.7830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb981c67-1474-455c-1e2b-08d894f80e8c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT052.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4277
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_01:2020-11-26,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300041
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

