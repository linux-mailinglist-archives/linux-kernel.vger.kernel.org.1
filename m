Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B992A1CD276
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEKHTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 03:19:20 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36304 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgEKHTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:19:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A9E17201518;
        Mon, 11 May 2020 09:19:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80C27200AD7;
        Mon, 11 May 2020 09:19:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5F904402E1;
        Mon, 11 May 2020 15:19:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] tty: serial: imx: Add return value check for platform_get_irq()
Date:   Mon, 11 May 2020 15:09:56 +0800
Message-Id: <1589180996-618-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RX irq is required, so add return value check for platform_get_irq().

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f4d6810..f4023d9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2252,6 +2252,8 @@ static int imx_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	rxirq = platform_get_irq(pdev, 0);
+	if (rxirq < 0)
+		return rxirq;
 	txirq = platform_get_irq_optional(pdev, 1);
 	rtsirq = platform_get_irq_optional(pdev, 2);
 
-- 
2.7.4

