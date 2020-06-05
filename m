Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797681EFC2F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgFEPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgFEPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:07:40 -0400
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Jun 2020 08:07:40 PDT
Received: from gaireg.de (gaireg.de [IPv6:2a03:4000:9:30::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06DAC08C5C2;
        Fri,  5 Jun 2020 08:07:40 -0700 (PDT)
Received: from tyr.bvd.indurad.x (unknown [194.8.217.178])
        by gaireg.de (Postfix) with ESMTPSA id D235C6A774E5;
        Fri,  5 Jun 2020 16:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gaireg.de; s=mail;
        t=1591369083; bh=at3sSlZvH4UsehI1oWFk8XESC8Y4Pf9dlbAMy8oNaps=;
        h=From:To:Cc:Subject:Date;
        b=yyocm+GDlU5JjRzWJcdgxzWKJWFpjfoEvorCdUe+Widox+nBvCMavW0ZGllRYpgCY
         pw2cbQ/TIuRO7O3iYcHAcBXH/tvDhP0Hsg8ChrCPj/sNF890aHp9OjD7fGW8ZrXm5i
         MN1BDdPyzagdhcL2ZqmyddAZUB6HC8aJ3lUs+ySc=
From:   =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
To:     Laxman Dewangan <ldewangan@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
Subject: [PATCH] serial: serial-tegra: reduce irq-latency after rx errors
Date:   Fri,  5 Jun 2020 16:57:14 +0200
Message-Id: <20200605145714.9964-1-gaireg@gaireg.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since dev_err() calls can lead to synchronous writes to another serial
console these calls can provide significant latency during irq-handling
in tegra_uart_isr(). With this latency another interrupt is likely to
apper during handling of the first interrupt, which might lock up the
kernel completely.

These errors are reported to the error counters so converting the
dev_err() to dev_dbg() is appropriate.

Signed-off-by: Randolph Maaßen <gaireg@gaireg.de>
---
 drivers/tty/serial/serial-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 8de8bac9c6c7..d3fef5ab289a 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -439,16 +439,16 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
 			/* Overrrun error */
 			flag = TTY_OVERRUN;
 			tup->uport.icount.overrun++;
-			dev_err(tup->uport.dev, "Got overrun errors\n");
+			dev_dbg(tup->uport.dev, "Got overrun errors\n");
 		} else if (lsr & UART_LSR_PE) {
 			/* Parity error */
 			flag = TTY_PARITY;
 			tup->uport.icount.parity++;
-			dev_err(tup->uport.dev, "Got Parity errors\n");
+			dev_dbg(tup->uport.dev, "Got Parity errors\n");
 		} else if (lsr & UART_LSR_FE) {
 			flag = TTY_FRAME;
 			tup->uport.icount.frame++;
-			dev_err(tup->uport.dev, "Got frame errors\n");
+			dev_dbg(tup->uport.dev, "Got frame errors\n");
 		} else if (lsr & UART_LSR_BI) {
 			/*
 			 * Break error
-- 
2.11.0

