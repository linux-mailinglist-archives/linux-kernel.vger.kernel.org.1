Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B592F41F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbhAMCnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:43:41 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:12359 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728202AbhAMCnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:43:41 -0500
X-UUID: 9027630945e14e959559cd249516d4ff-20210113
X-UUID: 9027630945e14e959559cd249516d4ff-20210113
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1459941216; Wed, 13 Jan 2021 10:42:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Jan 2021 10:42:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 10:42:50 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH RESEND v4 07/11] usb: gadget: bdc: avoid precedence issues
Date:   Wed, 13 Jan 2021 10:42:24 +0800
Message-ID: <1610505748-30616-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B6437FDFDDFC5E1C745B534E6C0F55840DBB23BF299E7A0F550817720EC730072000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add () around macro argument to avoid precedence issues

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
v4 resend: base on kernel 5.11-rc1
v4: no changes, but rebase on kernel 5.10-rc1
v3: add acked-by Florian
v2: add Cc Florian
---
 drivers/usb/gadget/udc/bdc/bdc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index 658abeff59d4..f8d595804258 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -86,20 +86,20 @@
 #define BDC_EPSTS5	0x74
 #define BDC_EPSTS6	0x78
 #define BDC_EPSTS7	0x7c
-#define BDC_SRRBAL(n)	(0x200 + (n * 0x10))
-#define BDC_SRRBAH(n)	(0x204 + (n * 0x10))
-#define BDC_SRRINT(n)	(0x208 + (n * 0x10))
-#define BDC_INTCTLS(n)	(0x20c + (n * 0x10))
+#define BDC_SRRBAL(n)	(0x200 + ((n) * 0x10))
+#define BDC_SRRBAH(n)	(0x204 + ((n) * 0x10))
+#define BDC_SRRINT(n)	(0x208 + ((n) * 0x10))
+#define BDC_INTCTLS(n)	(0x20c + ((n) * 0x10))
 
 /* Extended capability regs */
 #define BDC_FSCNOC	0xcd4
 #define BDC_FSCNIC	0xce4
-#define NUM_NCS(p)	(p >> 28)
+#define NUM_NCS(p)	((p) >> 28)
 
 /* Register bit fields and Masks */
 /* BDC Configuration 0 */
 #define BDC_PGS(p)	(((p) & (0x7 << 8)) >> 8)
-#define BDC_SPB(p)	(p & 0x7)
+#define BDC_SPB(p)	((p) & 0x7)
 
 /* BDC Capability1 */
 #define BDC_P64		(1 << 0)
@@ -113,7 +113,7 @@
 #define BDC_CMD_DVC	0x1
 #define BDC_CMD_CWS		(0x1 << 5)
 #define BDC_CMD_CST(p)		(((p) & (0xf << 6))>>6)
-#define BDC_CMD_EPN(p)		((p & 0x1f) << 10)
+#define BDC_CMD_EPN(p)		(((p) & 0x1f) << 10)
 #define BDC_SUB_CMD_ADD		(0x1 << 17)
 #define BDC_SUB_CMD_FWK		(0x4 << 17)
 /* Reset sequence number */
@@ -163,7 +163,7 @@
 #define BDC_SPEED_HS	0x3
 #define BDC_SPEED_SS	0x4
 
-#define BDC_PST(p)	(p & 0xf)
+#define BDC_PST(p)	((p) & 0xf)
 #define BDC_PST_MASK	0xf
 
 /* USPPMS */
@@ -228,7 +228,7 @@
 /* status report defines */
 #define SR_XSF		0
 #define SR_USPC		4
-#define SR_BD_LEN(p)    (p & 0xffffff)
+#define SR_BD_LEN(p)    ((p) & 0xffffff)
 
 #define XSF_SUCC	0x1
 #define XSF_SHORT	0x3
-- 
2.18.0

