Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C162A629F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgKDKx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:53:57 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:35880 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgKDKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:53:56 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.156])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 3E749482D14;
        Wed,  4 Nov 2020 18:53:51 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH 2/2] drivers/tty: delete break after return
Date:   Wed,  4 Nov 2020 02:53:31 -0800
Message-Id: <20201104105331.16654-3-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201104105331.16654-1-bernard@vivo.com>
References: <20201104105331.16654-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0MdGUsfGUIdSB4aVkpNS09PQ0xJSEpOSENVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6PSo6Mz8oNx8qA00ICE9I
        HjoaCTBVSlVKTUtPT0NMSUhKQkxJVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5NWVdZCAFZQUlOQ0s3Bg++
X-HM-Tid: 0a7592e437fa93bakuws3e749482d14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete break after return, which will never run.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/tty/serial/imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1731d9728865..09703079db7b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -320,7 +320,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 	switch (offset) {
 	case UCR1:
 		return sport->ucr1;
-		break;
 	case UCR2:
 		/*
 		 * UCR2_SRST is the only bit in the cached registers that might
@@ -331,16 +330,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 		if (!(sport->ucr2 & UCR2_SRST))
 			sport->ucr2 = readl(sport->port.membase + offset);
 		return sport->ucr2;
-		break;
 	case UCR3:
 		return sport->ucr3;
-		break;
 	case UCR4:
 		return sport->ucr4;
-		break;
 	case UFCR:
 		return sport->ufcr;
-		break;
 	default:
 		return readl(sport->port.membase + offset);
 	}
-- 
2.29.0

