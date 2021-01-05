Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821D42EAA71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbhAEMEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:04:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:39240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729819AbhAEMED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:04:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1F0FAD89;
        Tue,  5 Jan 2021 12:02:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 06/12] 8250_tegra: clean up tegra_uart_handle_break
Date:   Tue,  5 Jan 2021 13:02:33 +0100
Message-Id: <20210105120239.28031-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* switch "do { A; } while (1)" to "while (1) { A; }"
* switch "if (A) B; else break;" to "if (!A) break; B;"
* remove unused assignment from p->serial_in() to status

Objdump -d shows no difference.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
---
 drivers/tty/serial/8250/8250_tegra.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index c0ffad1572c6..e13ae18b0713 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -26,16 +26,17 @@ static void tegra_uart_handle_break(struct uart_port *p)
 {
 	unsigned int status, tmout = 10000;
 
-	do {
+	while (1) {
 		status = p->serial_in(p, UART_LSR);
-		if (status & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS))
-			status = p->serial_in(p, UART_RX);
-		else
+		if (!(status & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS)))
 			break;
+
+		p->serial_in(p, UART_RX);
+
 		if (--tmout == 0)
 			break;
 		udelay(1);
-	} while (1);
+	}
 }
 
 static int tegra_uart_probe(struct platform_device *pdev)
-- 
2.30.0

