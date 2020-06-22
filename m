Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439C320394E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgFVO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgFVO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70950C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:27:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so8477788pfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwFsGBHaAVO/O+/Qurpo2lVEh+kEhysHr8M/+K/fxoc=;
        b=A0H4lXeSqd1TcxTG4LkROpY5Ka7b89dAFnokSllDR68dqft5Eb3Sn+vycp/qtrhYPY
         Zg19eLNhtlN0dlmyu1JXx/lZTscE50s/df/wBFUmF5h0/CYagKoI7JXYmu8c/LiH9aWW
         c51dblKL90Tzo4xj50Bfq6fyy9fWKaJKxiwUejKcV6chfaeKNl6slT2CtykiK81hqv4d
         2yLtdAYPMo8a6blB1QahexeTWQd6h0+I/PgnWrAhNe34KueKPg9k3NcquzAXJeYN77gJ
         MO2fh80EBgSVbP51lQ9PRKP9SD5h4V1Varsf+rDfhLRjJwdFtwfECRh2Xk9zwBi2IGHW
         azbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwFsGBHaAVO/O+/Qurpo2lVEh+kEhysHr8M/+K/fxoc=;
        b=EL0YnlGYCnjffI8ZcAlqgPBuRMyz3zun3DvFvR7vEwHcHeqNLphiD9epuJ+jCZ0Yk0
         PEFpmHyzcegqyNwoBK2QLnPC+N/po8g3VPJ/rL3XdIH1vlc2ufHQI4paTl9TZThmC9Oh
         QZNgteMnAcRc0jpi53EQwG0+upDSMLmicBLKgufwszGvtEjc4EtRCZ4dSgzebs5Rp2rV
         g4AhS+/W2qJi7PTuqSOc4B6b0UKUNLowMZs1D0Wl49Dtt5KohvqxLkn2zRppaBVSJkAr
         1/I3OnfGM7VfQJCZEJ315AeFPTL66G3x65r65dk9cdeLMPqT1D41GCkEwInfBe8S0o21
         m2Mg==
X-Gm-Message-State: AOAM530qqrJ1rDt+a00wYjdv0/CYe8rT5BwdbzDM9WL6+PNOEwsvcx1J
        DDhEAUwPLqOXs9n//QMsAWgD7A==
X-Google-Smtp-Source: ABdhPJxGh0TYex4nPoXDAnP2VnSgxXNcHKtzTjFNB4KOkRhgrpCJ6SxFNH3mr4sruco8M3DapOiqzg==
X-Received: by 2002:a63:d318:: with SMTP id b24mr12063898pgg.403.1592836050027;
        Mon, 22 Jun 2020 07:27:30 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:29 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 2/7] tty: serial: Add poll_get_irq() to the polling interface
Date:   Mon, 22 Jun 2020 19:56:19 +0530
Message-Id: <1592835984-28613-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Add new API: poll_get_irq() to the polling interface in order for user
of polling interface to retrieve allocated IRQ corresponding to
underlying serial device.

Although, serial interface still works in polling mode but interrupt
associated with serial device can be leveraged for special purposes like
debugger(kgdb) entry.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/serial_core.c | 18 ++++++++++++++++++
 include/linux/serial_core.h      |  1 +
 include/linux/tty_driver.h       |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 66a5e2f..1bb033c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2470,6 +2470,23 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
 	port->ops->poll_put_char(port, ch);
 	uart_port_deref(port);
 }
+
+static int uart_poll_get_irq(struct tty_driver *driver, int line)
+{
+	struct uart_driver *drv = driver->driver_state;
+	struct uart_state *state = drv->state + line;
+	struct uart_port *port;
+	int ret = -ENODEV;
+
+	port = uart_port_ref(state);
+	if (port && port->ops->poll_get_irq) {
+		ret = port->ops->poll_get_irq(port);
+		uart_port_deref(port);
+	}
+
+	return ret;
+}
+
 #endif
 
 static const struct tty_operations uart_ops = {
@@ -2505,6 +2522,7 @@ static const struct tty_operations uart_ops = {
 	.poll_init	= uart_poll_init,
 	.poll_get_char	= uart_poll_get_char,
 	.poll_put_char	= uart_poll_put_char,
+	.poll_get_irq	= uart_poll_get_irq,
 #endif
 };
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 92f5eba..8b132e6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -78,6 +78,7 @@ struct uart_ops {
 	int		(*poll_init)(struct uart_port *);
 	void		(*poll_put_char)(struct uart_port *, unsigned char);
 	int		(*poll_get_char)(struct uart_port *);
+	int		(*poll_get_irq)(struct uart_port *);
 #endif
 };
 
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 3584462..d6da5c5 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -295,6 +295,7 @@ struct tty_operations {
 	int (*poll_init)(struct tty_driver *driver, int line, char *options);
 	int (*poll_get_char)(struct tty_driver *driver, int line);
 	void (*poll_put_char)(struct tty_driver *driver, int line, char ch);
+	int (*poll_get_irq)(struct tty_driver *driver, int line);
 #endif
 	int (*proc_show)(struct seq_file *, void *);
 } __randomize_layout;
-- 
2.7.4

