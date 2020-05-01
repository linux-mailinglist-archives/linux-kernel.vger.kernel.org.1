Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3041C0BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgEABjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 21:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgEABjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:39:22 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6537C035494;
        Thu, 30 Apr 2020 18:39:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so943236pfc.0;
        Thu, 30 Apr 2020 18:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JPiPW3RsEi9O9rZXYt6ktq8vAB0cHXP2ySdxLOyO2kU=;
        b=nv1QPz0V0Avjg8hbiC+MrN8KAVAL3B/mLx/JR8uOQzu3vqTWvkr3dzarnOH6sNnlV9
         TM3H44n3O39Mh0SHL+tGqHf+rnZN9g1EfNP5L6OXJI3MA2y8OJQPfWY5BvSsVIyVAnX9
         z1SCozgjnb+FkTy2IoVHXPN23/WeGVNyG1Mai1n68WkRw/NZV9gHRSUaxl2BShu3EL0J
         3lt4+iHIj6ZEpYLOVMLtN5E2Tl0r11pxxOovD8D7NT1G2Hsk9saNYIWw9RBkBeemZm07
         X6wryxVQokoatew78lbtWHVHTPBv4ts6huzZ6Afg5Igtco3oIhv6P9x7jVJFSS7wJhJF
         v78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JPiPW3RsEi9O9rZXYt6ktq8vAB0cHXP2ySdxLOyO2kU=;
        b=G+dhPsp8accNjInfQLgV9iRuMAnukT4o8IYwmIDTBN+XhJGfkwpiydNNJJOpsbqhaL
         igjhe29zyQR+VxwqFIDQM7XyoB4qvhjhEflgNsvGrxLwc2aqPcD/vdYhH0lnokMwMabU
         cae8kUicH9jJ8hH1aZ0/0IMsIamm9XAsehB7I7pYlyMdwBUfg0YJuGeQaNabYqgCUA4y
         ZR6MCaq0RNvV8XV6dHlWsu4AH8ShJdFnITW46yFuUXR3Jw24cAqBKveNhBwbj96CShs0
         2YULduMve6P8orpyMzSeN+6iqGXCzd4wRsZ2/n7F9Sx6OeK75DRcqc0MB/8P/QPyA61L
         4eQw==
X-Gm-Message-State: AGi0Pua3gXgMiiVqg7aSihtBD8VKOxEP28uJ1OcbGPVnAjRu5FSQ9Vgh
        GZn/EZCHm4cmrFeyYKDBd7sN7VnT
X-Google-Smtp-Source: APiQypKaM2jRqDAUG7t5M2NNnM6fZh8ysX9uDUDBnpsP9Q2FDhmbjRBvl82TXDrN/H8023/V2EyCcw==
X-Received: by 2002:a62:3812:: with SMTP id f18mr1705997pfa.173.1588297161564;
        Thu, 30 Apr 2020 18:39:21 -0700 (PDT)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y8sm876836pfg.216.2020.04.30.18.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 18:39:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     zou_wei@huawei.com, Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM63XX ARM
        ARCHITECTURE),
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM63XX
        ARM ARCHITECTURE)
Subject: [PATCH] Revert "tty: serial: bcm63xx: fix missing clk_put() in bcm63xx_uart"
Date:   Thu, 30 Apr 2020 18:39:04 -0700
Message-Id: <20200501013904.1394-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 580d952e44de5509c69c8f9346180ecaa78ebeec ("tty:
serial: bcm63xx: fix missing clk_put() in bcm63xx_uart") because we
should not be doing a clk_put() if we were not successful in getting a
valid clock reference via clk_get() in the first place.

Fixes: 580d952e44de ("tty: serial: bcm63xx: fix missing clk_put() in bcm63xx_uart")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index ed0aa5c0d9b7..5674da2b76f0 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -843,10 +843,8 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(clk) && pdev->dev.of_node)
 		clk = of_clk_get(pdev->dev.of_node, 0);
 
-	if (IS_ERR(clk)) {
-		clk_put(clk);
+	if (IS_ERR(clk))
 		return -ENODEV;
-	}
 
 	port->iotype = UPIO_MEM;
 	port->irq = res_irq->start;
-- 
2.17.1

