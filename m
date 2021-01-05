Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA4C2EAA6F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbhAEMEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:04:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:39254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbhAEMED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:04:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2F9BADE1;
        Tue,  5 Jan 2021 12:02:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/12] tty: cpm_uart, use port->flags instead of low_latency
Date:   Tue,  5 Jan 2021 13:02:37 +0100
Message-Id: <20210105120239.28031-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only in-kernel user of tty_port::low_latency. Switch this
last one to test uport->flags directly as tty_port::low_latency is going
away in the next patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 3b899cc7e362..58aaa533203b 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -499,8 +499,7 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	pr_debug("CPM uart[%d]:set_termios\n", port->line);
 
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
-	if (baud < HW_BUF_SPD_THRESHOLD ||
-	    (pinfo->port.state && pinfo->port.state->port.low_latency))
+	if (baud < HW_BUF_SPD_THRESHOLD || port->flags & UPF_LOW_LATENCY)
 		pinfo->rx_fifosize = 1;
 	else
 		pinfo->rx_fifosize = RX_BUF_SIZE;
-- 
2.30.0

