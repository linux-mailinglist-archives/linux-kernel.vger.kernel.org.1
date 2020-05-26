Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF661C9BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 22:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgEGUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728661AbgEGUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:09:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AADC05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:09:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so2505983plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ge9qVeZ6Sa/y96gJ6Jk9u3E4Kz4lx6NVyIi7/3LHaI=;
        b=K828kQ9Bf24lU5VSRMJc+kYe23Ey+7LkfXnC4YTM4gE7nw2Pqv+GWa9rqLJ2+asjVk
         0JpKro8McrB2zZAy2B65s+qE0USayvLQ4yTzlRthlpahUTp3g6ZJ86jsOw3pFXABjEcR
         UF1mrCMg8fHuuGBD6w2dibHoKKSjbHG2L2g/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Ge9qVeZ6Sa/y96gJ6Jk9u3E4Kz4lx6NVyIi7/3LHaI=;
        b=DOGze8LSC9qKMZya4pWEW71/FGlHV6ccNAN3q+FX/3iCZoKAQIgDd7ZRdnV/KXx0AW
         kWSV22pMN8cD+MEkXa+NAVcuVhO/6Fzdoj0nYV0ZEG9RajgcvLVBA+mqQtUBhSIvQnJz
         jVPEeL6/qRL0MJ8L08CVTtOM7YcWudacit4hpd4vJalsSWsV62pE92FSSn2PlidpcvkN
         gE78MK79guuzjlnBAN2n2flczz1UCbpTSFweE0ya5yPq6ahKPPUvGwEokIOvUvGQldlt
         lhOebn+miFzAnfX6IJII15G+xWP/4FKVNUZJthvvFf+DdMGUTLNXC9DwvoW30rawYQRP
         ylXQ==
X-Gm-Message-State: AGi0PubXUOcTbaqHE4+NDKiLrjdX1+1l8aFAb8Ba43ls8o2cXdqr0Ubi
        OFMiBmGco3uh/PZ8l8isy6e17g==
X-Google-Smtp-Source: APiQypIicNa0yEdTic4RD6ZtQEeDZ7CayDCtOmRdXjxrurqIBU7AMvAJI3HsVyWRutt74nvSNyF5bw==
X-Received: by 2002:a17:90a:284e:: with SMTP id p14mr1995555pjf.10.1588882155168;
        Thu, 07 May 2020 13:09:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d203sm5547601pfd.79.2020.05.07.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:09:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/12] serial: 8250_early: Support kgdboc_earlycon
Date:   Thu,  7 May 2020 13:08:49 -0700
Message-Id: <20200507130644.v4.11.I8f668556c244776523320a95b09373a86eda11b7@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200507200850.60646-1-dianders@chromium.org>
References: <20200507200850.60646-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the read() function in the early console driver.  With
recent kgdb patches this allows you to use kgdb to debug fairly early
into the system boot.

We only bother implementing this if polling is enabled since kgdb
can't be enabled without that.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v4: None
Changes in v3:
- Renamed earlycon_kgdboc to kgdboc_earlycon.

Changes in v2: None

 drivers/tty/serial/8250/8250_early.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 5cd8c36c8fcc..70d7826788f5 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -109,6 +109,28 @@ static void early_serial8250_write(struct console *console,
 	uart_console_write(port, s, count, serial_putc);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int early_serial8250_read(struct console *console,
+				 char *s, unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
+	unsigned int status;
+	int num_read = 0;
+
+	while (num_read < count) {
+		status = serial8250_early_in(port, UART_LSR);
+		if (!(status & UART_LSR_DR))
+			break;
+		s[num_read++] = serial8250_early_in(port, UART_RX);
+	}
+
+	return num_read;
+}
+#else
+#define early_serial8250_read NULL
+#endif
+
 static void __init init_port(struct earlycon_device *device)
 {
 	struct uart_port *port = &device->port;
@@ -149,6 +171,7 @@ int __init early_serial8250_setup(struct earlycon_device *device,
 		init_port(device);
 
 	device->con->write = early_serial8250_write;
+	device->con->read = early_serial8250_read;
 	return 0;
 }
 EARLYCON_DECLARE(uart8250, early_serial8250_setup);
-- 
2.26.2.645.ge9eca65c58-goog

