Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97602D97D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438810AbgLNMEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:04:48 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:7080 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731381AbgLNMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:04:47 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BEC1uOD015068;
        Mon, 14 Dec 2020 04:03:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=en0zMDjdhzecp4VSNSawR62ogxRwVWqXCaHTDb6ys3A=;
 b=fzodkwrN7Kp3xes3ijkXnzASjo0IDwHMUKrbRGahxQfQiFG4+p+rAPc807uNNWfUU6gA
 BV2tyhVSoaDdz8BYmIQepYM6fGl43p9R+lmYkSI9mnU0ucZpoNzMaFfQWm0Vbq7m3V1P
 +INBqrDD9bMSbFY6RhbY/yKmJsTUcNDyQm2M6jQoOsIOVDoIMq7uz0aUyG6aaUXKQ+0t
 po55sCAqsOIBZcjn+6X2YXKTYwufHUh/z4eqz7179lwj1LZJNZ9XqbVUHWSgt9wwS2/A
 ndbCoRn8z99g7Jrm5PBAbRRb+Km8s6b6/YOHN04i2ZcL1DgrEARuJhkHt+e4S3vBbWsN jQ== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35cua24ra0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 04:03:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAMoKYCvVWjLtGxMYzD5cTmXBsj299PU+4k4HH2cMboySLsV2fCEj/2rG47Z5GFTNOYN7lRwfIOb5PYX6sHeEPdhv501Z54g43/P18CecB2ZgbNbC9kLxioE9aJ9IyueY6THUKC4DdE+GVSwlzd/j/qLKi4oRkym8WBsfaN420L7e0cTZNdU3pigyZFs/OtF2q2dcRjaJowaOy9r+VPAH+RaJZVdC2/kbF+gjeFbmhGliQbIsqW/4H0Vud9hePBVdCdinhD8ggRZAojf+T38U5VdDqcCYtRC75xelLYzpREQsht1x7DwfiNpJhZaXsLL+GHm/3OxLZwG3LqWLtTi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en0zMDjdhzecp4VSNSawR62ogxRwVWqXCaHTDb6ys3A=;
 b=Kxu8QQOodm+Ia728uC1omChVMhf5iBULODWgmrXA+NuA1NL0xR8gBYCxiL9KorO2R/aISKPMY2+zkMk5Wq/rwKZVBOiPL4uksBG+4oX/9/VZzu8B3YEbfCX/XWb6S1bP/AAubImTQ3e8n+6cTy+ci5Aiz1c9VauzYJMDYrz6O6OHiNXPDF+b4oHDYjxhvK8j5AjITsdu31TYTXkczRNnLtPApI/7GcxvM5Pjt6ncXeaojkEvCpWJA0d3pdbmanbO/KVAdNO6ghZhGgFMlbVVnAKqEplZvTPgH0+ZeYIYA/Tr7sk4VwTg/ar/VpXYrlYnybZpNkcd98+HIbWDE5gpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en0zMDjdhzecp4VSNSawR62ogxRwVWqXCaHTDb6ys3A=;
 b=z2h0ScfKNoQKDJ1IWd/28vmsBt0h8rqT4EY+gD+1OqTfmNvUFpIRkN1pIKAYwymDFHwhNVkeFug4hIxSBvB7rDrJTiM6N7H8+0H5WMb2ijyZnc/qOrPoD13wCeqawjyPyNHjBKxBHBjF3MPndVce6wnK1LHwX+j5VK1Np51ze/g=
Received: from CO2PR04CA0064.namprd04.prod.outlook.com (2603:10b6:102:1::32)
 by BYAPR07MB5717.namprd07.prod.outlook.com (2603:10b6:a03:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Mon, 14 Dec
 2020 12:03:57 +0000
Received: from MW2NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::57) by CO2PR04CA0064.outlook.office365.com
 (2603:10b6:102:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Mon, 14 Dec 2020 12:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT026.mail.protection.outlook.com (10.13.180.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.10 via Frontend Transport; Mon, 14 Dec 2020 12:03:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0BEC3sNk014676
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 04:03:55 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 14 Dec 2020 13:03:53 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 14 Dec 2020 13:03:53 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BEC3rb7026392;
        Mon, 14 Dec 2020 13:03:53 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BEC3rMk026390;
        Mon, 14 Dec 2020 13:03:53 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Date:   Mon, 14 Dec 2020 13:03:44 +0100
Message-ID: <20201214120344.26344-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd2cc49-fe01-4d83-5c21-08d8a0285570
X-MS-TrafficTypeDiagnostic: BYAPR07MB5717:
X-Microsoft-Antispam-PRVS: <BYAPR07MB57179DE1DA703012D7FF6CB4DDC70@BYAPR07MB5717.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pv35rWbb6Ursd54masGpERCawiHDXr88ips0C0t3qz3uYf45snd4+GQTpi1sh1sm5Pdq2JofDVX4K3R4Om6Yhb9JZq8qn+YeLnQY8q2sIxCwKmRf6EP9jd2Fc+1p8DXMy6PrcNYDBG9zaI5LAWE0QNPaEy+ZTb5J2KTi+3OVpoVHBoGUpAJO//WwQOPf1nPOZA7CUcZHtmg5LGecgauabK3Kjl/TlLWtl3B4RcPM5qSJ5wjIDHvMniyCwUul32vgGu9MVezfXr2orRaO6r4eisnV0xC91oh2JWgoTNfTJiLByZZLadR2fzS8A+ygglcdu2x0RkKW8J4cURuxiiKq2DqwOIGgc4nD8q07bFnOCpn+4IQU6veeB3bJPKd5AntVAulPORfWM3eWAg8JQFvWCNfaXeYEoe3NE6rotmPvnp0=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(36092001)(46966005)(36906005)(30864003)(70586007)(426003)(86362001)(5660300002)(6666004)(42186006)(26005)(2906002)(8676002)(83380400001)(36756003)(186003)(107886003)(508600001)(4326008)(336012)(70206006)(2616005)(54906003)(47076004)(1076003)(7636003)(82310400003)(356005)(8936002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 12:03:56.4568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd2cc49-fe01-4d83-5c21-08d8a0285570
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5717
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_05:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch fixes all sparse warnings in cdsnp driver.

It fixes the following warnings:
cdnsp-ring.c:1441: warning: incorrect type in assignment
cdnsp-ring.c:1444: warning: restricted __le32 degrades to integer
cdnsp-ring.c:2200: warning: dubious: x | !y
cdnsp-gadget.c:501: warning: incorrect type in assignment
cdnsp-gadget.c:504: warning: restricted __le32 degrades to integer
cdnsp-gadget.c:507: warning: restricted __le32 degrades to integer
cdnsp-gadget.c:508: warning: restricted __le32 degrades to integer
cdnsp-gadget.c:509: warning: invalid assignment: |=
cdnsp-gadget.c:510: warning: cast from restricted __le32
cdnsp-gadget.c:558: warning: incorrect type in assignment
cdnsp-gadget.c:561: warning: restricted __le32 degrades to integer
cdnsp-gadget.c:570: warning: restricted __le32 degrades to integer
cdnsp-gadget.c:1571: warning: incorrect type in argument 1
cdnsp-gadget.c:1602: warning: restricted __le32 degrades to integer
cdnsp-gadget.c:1760: warning: incorrect type in assignment
cdnsp-gadget.c:1762: warning: incorrect type in assignment
cdnsp-gadget.c:1763: warning: incorrect type in assignment
cdnsp-gadget.c:1764: warning: incorrect type in assignment
cdnsp-gadget.c:1765: warning: incorrect type in assignment
cdnsp-gadget.c:1766: warning: incorrect type in assignment
cdnsp-gadget.c:1767: warning: incorrect type in assignment
cdnsp-gadget.c:458: warning: cast truncates bits from constant value
                    (ffffffff07ffffff becomes 7ffffff)
cdnsp-gadget.c:666: warning: cast truncates bits from constant value
                    (ffffffff07ffffff becomes 7ffffff)
cdnsp-mem.c:762: warning: incorrect type in assignment
cdnsp-mem.c:763: warning: incorrect type in assignment
cdnsp-mem.c:928: warning: cast from restricted __le16
cdnsp-mem.c:1187: warning: incorrect type in assignment
cdnsp-mem.c:1191: warning: incorrect type in assignment
cdnsp-ep0.c:142: warning: incorrect type in assignment
cdnsp-ep0.c:144: warning: restricted __le32 degrades to integer
cdnsp-ep0.c:147: warning: restricted __le32 degrades to integer
cdnsp-ep0.c:148: warning: restricted __le32 degrades to integer
cdnsp-ep0.c:179: warning: incorrect type in argument 1
cdnsp-ep0.c:311: warning: incorrect type in argument 1
cdnsp-ep0.c:469: warning: incorrect type in assignment
cdnsp-trace.h:611:1: warning: cast from restricted __le32

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/usb/cdns3/cdnsp-debug.h  |  2 +-
 drivers/usb/cdns3/cdnsp-ep0.c    | 13 ++++++-------
 drivers/usb/cdns3/cdnsp-gadget.c | 24 +++++++++---------------
 drivers/usb/cdns3/cdnsp-gadget.h | 13 +++++++------
 drivers/usb/cdns3/cdnsp-mem.c    | 11 ++++++-----
 drivers/usb/cdns3/cdnsp-ring.c   |  4 ++--
 drivers/usb/cdns3/cdnsp-trace.h  |  2 +-
 7 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
index d6345d4d2911..a8776df2d4e0 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -414,7 +414,7 @@ static inline const char *cdnsp_decode_slot_context(u32 info, u32 info2,
 		s = "UNKNOWN speed";
 	}
 
-	ret = sprintf(str, "%s Ctx Entries %ld",
+	ret = sprintf(str, "%s Ctx Entries %d",
 		      s, (info & LAST_CTX_MASK) >> 27);
 
 	ret += sprintf(str + ret, " [Intr %ld] Addr %ld State %s",
diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index d55b59ed7381..e2b1bcb3f80e 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -137,10 +137,8 @@ int cdnsp_status_stage(struct cdnsp_device *pdev)
 	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
 }
 
-static int cdnsp_w_index_to_ep_index(__le32  wIndex)
+static int cdnsp_w_index_to_ep_index(u16 wIndex)
 {
-	wIndex = le32_to_cpu(wIndex);
-
 	if (!(wIndex & USB_ENDPOINT_NUMBER_MASK))
 		return 0;
 
@@ -176,7 +174,8 @@ static int cdnsp_ep0_handle_status(struct cdnsp_device *pdev,
 		 */
 		return cdnsp_ep0_delegate_req(pdev, ctrl);
 	case USB_RECIP_ENDPOINT:
-		pep = &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
+		ep_sts = cdnsp_w_index_to_ep_index(le16_to_cpu(ctrl->wIndex));
+		pep = &pdev->eps[ep_sts];
 		ep_sts = GET_EP_CTX_STATE(pep->out_ctx);
 
 		/* check if endpoint is stalled */
@@ -305,10 +304,10 @@ static int cdnsp_ep0_handle_feature_endpoint(struct cdnsp_device *pdev,
 					     int set)
 {
 	struct cdnsp_ep *pep;
-	u32 wValue;
+	u16 wValue;
 
 	wValue = le16_to_cpu(ctrl->wValue);
-	pep = &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
+	pep = &pdev->eps[cdnsp_w_index_to_ep_index(le16_to_cpu(ctrl->wIndex))];
 
 	switch (wValue) {
 	case USB_ENDPOINT_HALT:
@@ -435,7 +434,7 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 {
 	struct usb_ctrlrequest *ctrl = &pdev->setup;
 	int ret = 0;
-	__le16 len;
+	u16 len;
 
 	trace_cdnsp_ctrl_req(ctrl);
 
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 1668f72fdf30..f28f1508f049 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -491,7 +491,7 @@ static void cdnsp_invalidate_ep_events(struct cdnsp_device *pdev,
 	struct cdnsp_segment *segment;
 	union cdnsp_trb *event;
 	u32 cycle_state;
-	__le32  data;
+	u32  data;
 
 	event = pdev->event_ring->dequeue;
 	segment = pdev->event_ring->deq_seg;
@@ -527,9 +527,9 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
 	dma_addr_t cmd_deq_dma;
 	union cdnsp_trb *event;
 	u32 cycle_state;
-	__le32  flags;
 	int ret, val;
 	u64 cmd_dma;
+	u32  flags;
 
 	cmd_trb = pdev->cmd.command_trb;
 	pdev->cmd.status = 0;
@@ -1568,7 +1568,7 @@ static void cdnsp_get_ep_buffering(struct cdnsp_device *pdev,
 		return;
 	}
 
-	endpoints = HCS_ENDPOINTS(readl(&pdev->hcs_params1)) / 2;
+	endpoints = HCS_ENDPOINTS(pdev->hcs_params1) / 2;
 
 	/* Set to XBUF_TX_TAG_MASK_0 register. */
 	reg += XBUF_TX_CMD_OFFSET + (endpoints * 2 + 2) * sizeof(u32);
@@ -1754,22 +1754,16 @@ void cdnsp_irq_reset(struct cdnsp_device *pdev)
 static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
 {
 	void __iomem *reg = &pdev->cap_regs->hc_capbase;
-	struct cdnsp_rev_cap *rev_cap;
 
 	reg += cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
-	rev_cap = reg;
-
-	pdev->rev_cap.ctrl_revision = readl(&rev_cap->ctrl_revision);
-	pdev->rev_cap.rtl_revision = readl(&rev_cap->rtl_revision);
-	pdev->rev_cap.ep_supported = readl(&rev_cap->ep_supported);
-	pdev->rev_cap.ext_cap = readl(&rev_cap->ext_cap);
-	pdev->rev_cap.rx_buff_size = readl(&rev_cap->rx_buff_size);
-	pdev->rev_cap.tx_buff_size = readl(&rev_cap->tx_buff_size);
+	pdev->rev_cap  = reg;
 
 	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
-		 pdev->rev_cap.ctrl_revision, pdev->rev_cap.rtl_revision,
-		 pdev->rev_cap.ep_supported, pdev->rev_cap.rx_buff_size,
-		 pdev->rev_cap.tx_buff_size);
+		 readl(&pdev->rev_cap->ctrl_revision),
+		 readl(&pdev->rev_cap->rtl_revision),
+		 readl(&pdev->rev_cap->ep_supported),
+		 readl(&pdev->rev_cap->rx_buff_size),
+		 readl(&pdev->rev_cap->tx_buff_size));
 }
 
 static int cdnsp_gen_setup(struct cdnsp_device *pdev)
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 8eb1b85a08b4..6bbb26548c04 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -493,11 +493,12 @@ struct cdnsp_3xport_cap {
 #define CDNSP_VER_1 0x00000000
 #define CDNSP_VER_2 0x10000000
 
-#define CDNSP_IF_EP_EXIST(pdev, ep_num, dir) ((pdev)->rev_cap.ep_supported & \
-			  (BIT(ep_num) << ((dir) ? 0 : 16)))
+#define CDNSP_IF_EP_EXIST(pdev, ep_num, dir) \
+			 (readl(&(pdev)->rev_cap->ep_supported) & \
+			 (BIT(ep_num) << ((dir) ? 0 : 16)))
 
 /**
- * struct cdnsp_rev_cap - controller capabilities .
+ * struct cdnsp_rev_cap - controller capabilities.
  * @ext_cap: Header for RTL Revision Extended Capability.
  * @rtl_revision: RTL revision.
  * @rx_buff_size: Rx buffer sizes.
@@ -594,7 +595,7 @@ struct cdnsp_slot_ctx {
 #define DEV_SPEED		GENMASK(23, 20)
 #define GET_DEV_SPEED(n)	(((n) & DEV_SPEED) >> 20)
 /* Index of the last valid endpoint context in this device context - 27:31. */
-#define LAST_CTX_MASK		GENMASK(31, 27)
+#define LAST_CTX_MASK		((unsigned int)GENMASK(31, 27))
 #define LAST_CTX(p)		((p) << 27)
 #define LAST_CTX_TO_EP_NUM(p)	(((p) >> 27) - 1)
 #define SLOT_FLAG		BIT(0)
@@ -1351,9 +1352,9 @@ struct cdnsp_port {
  * @ir_set: Current interrupter register set.
  * @port20_regs: Port 2.0 Peripheral Configuration Registers.
  * @port3x_regs: USB3.x Port Peripheral Configuration Registers.
+ * @rev_cap: Controller Capabilities Registers.
  * @hcs_params1: Cached register copies of read-only HCSPARAMS1
  * @hcc_params: Cached register copies of read-only HCCPARAMS1
- * @rev_cap: Controller capability.
  * @setup: Temporary buffer for setup packet.
  * @ep0_preq: Internal allocated request used during enumeration.
  * @ep0_stage: ep0 stage during enumeration process.
@@ -1402,12 +1403,12 @@ struct cdnsp_device {
 	struct	cdnsp_intr_reg __iomem *ir_set;
 	struct cdnsp_20port_cap __iomem *port20_regs;
 	struct cdnsp_3xport_cap __iomem *port3x_regs;
+	struct cdnsp_rev_cap __iomem *rev_cap;
 
 	/* Cached register copies of read-only CDNSP data */
 	__u32 hcs_params1;
 	__u32 hcs_params3;
 	__u32 hcc_params;
-	struct cdnsp_rev_cap rev_cap;
 	/* Lock used in interrupt thread context. */
 	spinlock_t lock;
 	struct usb_ctrlrequest setup;
diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index 4c7d77fb097e..7a84e928710e 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -759,8 +759,9 @@ int cdnsp_setup_addressable_priv_dev(struct cdnsp_device *pdev)
 
 	port = DEV_PORT(pdev->active_port->port_num);
 	slot_ctx->dev_port |= cpu_to_le32(port);
-	slot_ctx->dev_state = (pdev->device_address & DEV_ADDR_MASK);
-	ep0_ctx->tx_info = EP_AVG_TRB_LENGTH(0x8);
+	slot_ctx->dev_state = cpu_to_le32((pdev->device_address &
+					   DEV_ADDR_MASK));
+	ep0_ctx->tx_info = cpu_to_le32(EP_AVG_TRB_LENGTH(0x8));
 	ep0_ctx->ep_info2 = cpu_to_le32(EP_TYPE(CTRL_EP));
 	ep0_ctx->ep_info2 |= cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3) |
 					 max_packets);
@@ -925,7 +926,7 @@ static u32 cdnsp_get_max_esit_payload(struct usb_gadget *g,
 	/* SuperSpeedPlus Isoc ep sending over 48k per EIST. */
 	if (g->speed >= USB_SPEED_SUPER_PLUS &&
 	    USB_SS_SSP_ISOC_COMP(pep->endpoint.desc->bmAttributes))
-		return le32_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
+		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
 	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit */
 	else if (g->speed >= USB_SPEED_SUPER)
 		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
@@ -1184,11 +1185,11 @@ static int cdnsp_setup_port_arrays(struct cdnsp_device *pdev)
 
 	trace_cdnsp_init("Found USB 2.0 ports and  USB 3.0 ports.");
 
-	pdev->usb2_port.regs = (struct cdnsp_port_regs *)
+	pdev->usb2_port.regs = (struct cdnsp_port_regs __iomem *)
 			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
 				(pdev->usb2_port.port_num - 1));
 
-	pdev->usb3_port.regs = (struct cdnsp_port_regs *)
+	pdev->usb3_port.regs = (struct cdnsp_port_regs __iomem *)
 			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
 				(pdev->usb3_port.port_num - 1));
 
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index 874d9ff5406c..e15e13ba27dc 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -1432,7 +1432,7 @@ static bool cdnsp_handle_event(struct cdnsp_device *pdev)
 	unsigned int comp_code;
 	union cdnsp_trb *event;
 	bool update_ptrs = true;
-	__le32 cycle_bit;
+	u32 cycle_bit;
 	int ret = 0;
 	u32 flags;
 
@@ -2198,7 +2198,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device *pdev,
 	 * inverted in the first TDs isoc TRB.
 	 */
 	field = TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
-		!start_cycle | TRB_SIA | TRB_TBC(burst_count);
+		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
 
 	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
 	for (i = 0; i < trbs_per_td; i++) {
diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp-trace.h
index b68e282464d2..a9de1daadf07 100644
--- a/drivers/usb/cdns3/cdnsp-trace.h
+++ b/drivers/usb/cdns3/cdnsp-trace.h
@@ -620,7 +620,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_slot_ctx,
 	TP_fast_assign(
 		__entry->info = le32_to_cpu(ctx->dev_info);
 		__entry->info2 = le32_to_cpu(ctx->dev_port);
-		__entry->int_target = le64_to_cpu(ctx->int_target);
+		__entry->int_target = le32_to_cpu(ctx->int_target);
 		__entry->state = le32_to_cpu(ctx->dev_state);
 	),
 	TP_printk("%s", cdnsp_decode_slot_context(__entry->info,
-- 
2.17.1

