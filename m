Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3642B00B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgKLIAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:00:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:53082 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726337AbgKLH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:59:55 -0500
X-UUID: d49ad390e33948f98614d44f26ba119c-20201112
X-UUID: d49ad390e33948f98614d44f26ba119c-20201112
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 67560328; Thu, 12 Nov 2020 15:59:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Nov 2020 15:59:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 15:59:42 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>, <linux-usb@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 07/11] usb: gadget: bdc: avoid precedence issues
Date:   Thu, 12 Nov 2020 15:59:30 +0800
Message-ID: <1605167974-28502-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1605167974-28502-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1605167974-28502-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 95F7774C3FDDE88B504CA253E1ACD6A8E13B961122FA043DC203E6F10895C8DD2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add () around macro argument to avoid precedence issues

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
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

