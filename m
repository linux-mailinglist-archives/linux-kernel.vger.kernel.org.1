Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BDB1B689D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 01:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgDWXQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 19:16:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50010 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbgDWXQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:16:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E0D431A019D;
        Fri, 24 Apr 2020 01:16:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B2531A01BF;
        Fri, 24 Apr 2020 01:16:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C26AF40246;
        Fri, 24 Apr 2020 07:16:10 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ben.dooks@codethink.co.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] firmware: imx: MU IRQ group number should be 7
Date:   Fri, 24 Apr 2020 07:07:11 +0800
Message-Id: <1587683231-18468-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
References: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MU IRQ group number should be 7 instead of 4.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index d9dcc20..66fef88 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -14,7 +14,7 @@
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
-#define IMX_SC_IRQ_NUM_GROUP	4
+#define IMX_SC_IRQ_NUM_GROUP	7
 
 static u32 mu_resource_id;
 
-- 
2.7.4

