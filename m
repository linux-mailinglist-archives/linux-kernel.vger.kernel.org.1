Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0226296181
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901259AbgJVPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901246AbgJVPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:13:01 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA1C0613CE;
        Thu, 22 Oct 2020 08:13:01 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t20so2123707edr.11;
        Thu, 22 Oct 2020 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IX8WMs6zObG98t/kvu3EHvgAGHpB35Q/1BzZxNjptvA=;
        b=cN2STobb+g8vomJU+/Zok0/CD1WW4nOwEoj1+sO8DTcXP/Z8K1QmGvUX2Yz82RTf4W
         AWfEADgSaMcmCXj9lmJGzrPv5LIQJEyj4jvJrcoTkJ7MLDbhvPWWHHo5QXVr3anqBQs4
         rhdeIvgEqCYAHubSolkTIzOn78MdzkfvoACwiSavcwIPX+4eJzJCMj926E4fioCgoT+s
         PZgO/hQNpmfhvyB0JPqdycqgDYUWslurOlIXZWXi4kBWBX8kHQUwK+jtKjq6F2ZYtpm3
         e+UvUS/cyVQHAc9DknUyhWelyly/xg4WFkTMfyy6/k2M0V9ZirwnwE066G3+fddSsdCq
         biBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IX8WMs6zObG98t/kvu3EHvgAGHpB35Q/1BzZxNjptvA=;
        b=AZVkFfs25hMGlfEk4kweW2FiYMbf4NI5CHPTclSQJ8EEXLEh1bQiHUfLYK8rmeCux0
         9Ma/s4GEGKiKTJRTXE9QPZ3IJQCR6fphTz+jrhBfRS8u/WHiplB/GLTlMNc+vufKqTGK
         tHlNGuPVSbPlZb3D+uW6xsqYK9IwRepjghNETZXsYBk5ByrkRI07Gqs5XICLUr9eRr5B
         RP2FTrN4wOJTYG1KAwvXupMfzeBmM8KswaJGsxDrG0IM4HjMhafeDdBbkFDJxwSrpyx3
         Oz0Vkgl+0lck5YB4IXYt1L0tbEZ6XetX0k+4esivk9j3JUZYaRm3ZMgvJrIbuPDHmxoi
         2Pqw==
X-Gm-Message-State: AOAM532bXnknMFhCQ6r+uAQ0T8VE3pCvTmXKzFufh1j7VWssl0NnqYvo
        VEZoSWS1iG9isautLZpfrzk=
X-Google-Smtp-Source: ABdhPJw9/aMqMC7fYLyOBUBkykwqzjH6SnS0XQyjjxX3YH+JC9O0iyKuWh17qZSDt/NBIsieSYpjAg==
X-Received: by 2002:aa7:c351:: with SMTP id j17mr275834edr.70.1603379579797;
        Thu, 22 Oct 2020 08:12:59 -0700 (PDT)
Received: from localhost.localdomain ([188.26.174.215])
        by smtp.gmail.com with ESMTPSA id k25sm1049252ejz.93.2020.10.22.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 08:12:59 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] tty: serial: fsl_lpuart: LS1021A has a FIFO size of 32 datawords
Date:   Thu, 22 Oct 2020 18:12:50 +0300
Message-Id: <20201022151250.3236335-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Similar to the workaround applied by Michael Walle in commit
c2f448cff22a ("tty: serial: fsl_lpuart: add LS1028A support"), it turns
out that the LPUARTx_FIFO encoding for fields TXFIFOSIZE and RXFIFOSIZE
is the same for LS1028A as for LS1021A.

The RXFIFOSIZE in the Layerscape SoCs is fixed at this value:
101 Receive FIFO/Buffer depth = 32 datawords.

When Andy Duan wrote the commit in Fixes: below, he assumed that the 101
encoding means 64 datawords. But this is not true for Layerscape. So
that commit broke LS1021A, and this patch is extending the workaround
for LS1028A which appeared in the meantime, to fix that breakage.

When the driver thinks that it has a deeper FIFO than it really has,
getty (user space) output gets truncated.

Many thanks to Michael for suggesting this!

Fixes: f77ebb241ce0 ("tty: serial: fsl_lpuart: correct the FIFO depth size")
Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ff4b88c637d0..bd047e1f9bea 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -314,9 +314,10 @@ MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
 /* Forward declare this for the dma callbacks*/
 static void lpuart_dma_tx_complete(void *arg);
 
-static inline bool is_ls1028a_lpuart(struct lpuart_port *sport)
+static inline bool is_layerscape_lpuart(struct lpuart_port *sport)
 {
-	return sport->devtype == LS1028A_LPUART;
+	return (sport->devtype == LS1021A_LPUART ||
+		sport->devtype == LS1028A_LPUART);
 }
 
 static inline bool is_imx8qxp_lpuart(struct lpuart_port *sport)
@@ -1701,11 +1702,11 @@ static int lpuart32_startup(struct uart_port *port)
 					    UARTFIFO_FIFOSIZE_MASK);
 
 	/*
-	 * The LS1028A has a fixed length of 16 words. Although it supports the
-	 * RX/TXSIZE fields their encoding is different. Eg the reference manual
-	 * states 0b101 is 16 words.
+	 * The LS1021A and LS1028A have a fixed FIFO depth of 16 words.
+	 * Although they support the RX/TXSIZE fields, their encoding is
+	 * different. Eg the reference manual states 0b101 is 16 words.
 	 */
-	if (is_ls1028a_lpuart(sport)) {
+	if (is_layerscape_lpuart(sport)) {
 		sport->rxfifo_size = 16;
 		sport->txfifo_size = 16;
 		sport->port.fifosize = sport->txfifo_size;
-- 
2.25.1

