Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC1203952
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgFVO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgFVO1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB4CC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:27:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i4so8711908pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sjUQXgLs8QLSZt9fRiSIf9rP+l/zfeDDFs4yVtYk7Z0=;
        b=QOeLXcXXYJY7Mbx/0GKxWfojZNvqp1+/iUKrhHvJJPT9TVW7hdHXE2t9l97MfMSFpN
         a08ODnr/u8hVAu7RVgm3nwaohgTk6yIAfdCRoM5WfyRsqxQHCEGEzi9wTA/yKOQSDDTn
         EspPlVmFhi6LGov/zu0zVQxHn0TORwdNIp4Tz25YBXpANqqkhTFuF4GxAxBipD+4hDqG
         jmvq8KHWY56pQ4Uhc3UmRVKr91Ozy+VR2DUlvgYbGewgO3jRkY/Dp81cKfOw8z4F75Dm
         Z8nwP0kHFAnNAqtxxXXSBop65W6O3MFJ//0g5Mpc6ZSBKBujqa7snPffto/Uxw5BV9qX
         S9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sjUQXgLs8QLSZt9fRiSIf9rP+l/zfeDDFs4yVtYk7Z0=;
        b=Th7xlWp27r1ELps/z8z96d5cDH4XBpoI6hxueVL6BZ1T8uBmngtfC5rxaLVl9F1ZDh
         OK8JU2SsQ8cx5v684APUw84itP1qP3E0h6Sv05p4uQwMnsTwjm13cilz3wdYoP3yuSzF
         5y2t+K2SQ/jCGZ1IkidbG1tyKwDo24CAnf+7BIYgGS+J0Tpatm/qXlkRFd5A2rERYt2s
         ou3CcJWf6oNS+eW2vK1tlThfd5poXb6b/BF2OzwSJls/dMVwfW+GI17Z2+ZmMvBbQK1z
         cXcWuDJVt7OTv9xOgKB8uCdjMvhc6jSRp/TpkI6mveaJs+eyAp+2DLvkxqV6vXKeGIzn
         Qj3g==
X-Gm-Message-State: AOAM5316NY0KZ4gKE6/dceRfe7+IY+9hXKqNAE2N/AAb9Jv6X5yrPfBO
        bCDJSSzuaSKhgYUg+p6mjppzEA==
X-Google-Smtp-Source: ABdhPJzpaCxkbO/21akB31Cg1TWuLDrphNwsB5izjnAOPjR2mgcdxwifka4NWh+oyQbNDK0xDtgcng==
X-Received: by 2002:a17:90a:d485:: with SMTP id s5mr17596432pju.61.1592836060022;
        Mon, 22 Jun 2020 07:27:40 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 4/7] serial: kgdb_nmi: Add support for interrupt based fallback
Date:   Mon, 22 Jun 2020 19:56:21 +0530
Message-Id: <1592835984-28613-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Add a generic NMI fallback to support kgdb NMI console feature which can
be overridden by arch specific implementation.

This common fallback mechanism utilizes kgdb IO based interrupt in order
to support entry into kgdb if a user types in kgdb_nmi_magic sequence. So
during NMI console init, NMI handler is installed corresponding to kgdb
IO based NMI which is invoked when a character is pending and that can be
cleared by calling @read_char until it returns NO_POLL_CHAR.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/kgdb_nmi.c | 47 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index b32c6b1..2580f39 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -42,9 +42,46 @@ MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
 static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
 static struct console *orig_dbg_cons;
 
+static int kgdb_nmi_poll_one_knock(void);
+
+static irqreturn_t kgdb_handle_nmi(int irq, void *dev_id)
+{
+	int ret;
+
+	if (kgdb_nmi_knock < 0) {
+		kgdb_breakpoint();
+		return IRQ_HANDLED;
+	}
+
+	ret = kgdb_nmi_poll_one_knock();
+	if (ret == NO_POLL_CHAR)
+		return IRQ_NONE;
+
+	while (ret != 1) {
+		ret = kgdb_nmi_poll_one_knock();
+		if (ret == NO_POLL_CHAR)
+			return IRQ_HANDLED;
+	}
+
+	kgdb_breakpoint();
+	return IRQ_HANDLED;
+}
+
 static int kgdb_nmi_console_setup(struct console *co, char *options)
 {
-	arch_kgdb_ops.enable_nmi(1);
+	int res;
+
+	if (arch_kgdb_ops.enable_nmi) {
+		arch_kgdb_ops.enable_nmi(1);
+	} else if (dbg_io_ops->request_nmi) {
+		res = dbg_io_ops->request_nmi(kgdb_handle_nmi, co);
+		if (res) {
+			pr_err("ttyNMI0: Cannot request nmi/irq\n");
+			return res;
+		}
+	} else {
+		return -ENODEV;
+	}
 
 	/* The NMI console uses the dbg_io_ops to issue console messages. To
 	 * avoid duplicate messages during kdb sessions we must inform kdb's
@@ -328,9 +365,6 @@ int kgdb_register_nmi_console(void)
 {
 	int ret;
 
-	if (!arch_kgdb_ops.enable_nmi)
-		return 0;
-
 	kgdb_nmi_tty_driver = alloc_tty_driver(1);
 	if (!kgdb_nmi_tty_driver) {
 		pr_err("%s: cannot allocate tty\n", __func__);
@@ -380,9 +414,8 @@ int kgdb_unregister_nmi_console(void)
 {
 	int ret;
 
-	if (!arch_kgdb_ops.enable_nmi)
-		return 0;
-	arch_kgdb_ops.enable_nmi(0);
+	if (arch_kgdb_ops.enable_nmi)
+		arch_kgdb_ops.enable_nmi(0);
 
 	ret = unregister_console(&kgdb_nmi_console);
 	if (ret)
-- 
2.7.4

