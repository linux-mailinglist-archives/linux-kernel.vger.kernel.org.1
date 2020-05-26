Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7A19D37F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 11:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390600AbgDCJYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 05:24:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37919 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390554AbgDCJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id f6so6897514wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UaJ/lm5B5irKRGuIGTcEW0nphrhQofKG2JxuS3fPTck=;
        b=f28+6tql43/Og7YGE8QTKNY9YPKkmPSkA+oKKSYv9PYyJk6WLaNxmW+YlH3qxlDr/Y
         NwnNRpNUWshiEO1F2NA9HHwJlKRUO8nEh+aOlZmS+LrNiLbjIT7ufQZHrX4TvhpHfZkI
         eM6vAJMjRTP2Yw1s7oqpT7/+9L3SokP2UXtfrN9ctVvWISHTB8D+4nQeNDu4HxTCuetr
         t9dBAJLDPx6kxzJNAhM9musdk4HAzpV7+ks6Zk9I3tASV6va7WiUVtiVT29gQvATkI6G
         MbVaLSngt0wG/uPQh8uWWdtqvbBBp397PfEIF8+UldkSINWALAXe/VGA9pJGvL5pD4vy
         neAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UaJ/lm5B5irKRGuIGTcEW0nphrhQofKG2JxuS3fPTck=;
        b=H3NqPIgLZW2q5Cb6pmIHMBZGsrLqTARHUaGecRdOigw1W5ES0F9t/5hMXNO0A6Iljy
         XWDMoxK+4qukB3Cb21vFU0HkUABs03Lue37FIG7BIccsKpxosNV9bAfxQpD4Mw+2Jwwl
         RJyx8y3iUlvaZjOslMUX2l1ACXsUMeADA44i2d0kJlZz0GGJ7cxgxar3bG4wP/VNn9/O
         NsxK8Dkflpzmc/34SINvhWotl13Esa+fSD7YQzScV3x2zD6BFrU7uLhpIGRcTsosNTzp
         vGl1Nnrb+hm8ApoHNRCET479v6fukClXPRjE9gBIWqLj+HRIhPHLpfYfOFDm/M0tZl68
         CCyQ==
X-Gm-Message-State: AGi0PuZWQwrgmrhiTzeYILJksIGwf9KQEFQ9a98p/s1zfg62RjTtfL6y
        tGvzpMFWp3rCzHlH+3m4s2lkDw==
X-Google-Smtp-Source: APiQypKIfR0UUqDSY/h923iNyVZubvQ21RncjnJGFJLtdFqhHyi/SNSGNn8LFm3qvKctOPC0FGERzw==
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr8070012wmf.118.1585905886912;
        Fri, 03 Apr 2020 02:24:46 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z3sm10332947wma.22.2020.04.03.02.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:46 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 3/7] Revert "serial: uartps: Fix error path when alloc failed"
Date:   Fri,  3 Apr 2020 11:24:32 +0200
Message-Id: <46cd7f039db847c08baa6508edd7854f7c8ff80f.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 32cf21ac4edd6c0d5b9614368a83bcdc68acb031.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4e3fefa70b56..412bfc51f546 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1542,10 +1542,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
 					 GFP_KERNEL);
-	if (!cdns_uart_console) {
-		rc = -ENOMEM;
-		goto err_out_id;
-	}
+	if (!cdns_uart_console)
+		return -ENOMEM;
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));
-- 
2.26.0

