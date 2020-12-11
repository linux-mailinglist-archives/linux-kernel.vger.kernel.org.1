Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33762D6CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394706AbgLKA6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394682AbgLKA60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:58:26 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:57:46 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2so5879044pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MTuxwf9KusT/ntlnVCF0gMBlWlskbWARxkaUDrHOkdo=;
        b=ra/WyZQoH+AGVlTrKDauhvPdiS00/pxJvs9pj4d37efoZQNZVc+YC1W+GtSV7wDQMv
         3Mvpwy7tvnA3/aqi6p8jyeGn0RiTWUQzE26nqhAEyR6TfToOa6tfqR/WnOi+SIx2rSjl
         /Ps0Va+qa275/zgoJ4ATYKXWrjKpbYdpMxcm7iLqoC+1WKuYLh4B3j95Cz1dvR3hEXEw
         AqPD+8q9+w7dwHS9riwHOjGYOsr05T3IFKZkynpELZtrlObf0jCMlMw/2M4ICCJQGYxr
         d5hGfjj7Q2LHqEf0FebkxA0WQ+JAXOeSrNEh8ZScYqFJn8LIUmGoyRRvZHSe6LWnB/dn
         EVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MTuxwf9KusT/ntlnVCF0gMBlWlskbWARxkaUDrHOkdo=;
        b=hbzKrVJlSiv0X2PBkuwUsi+uHGbk1ix3f97csxbEs9zG4BuQcrlfkQh344e7tQL6Ht
         diShJ2MD7T0LAAed+qkW2ABo4NZGlkGuFBro3xF7qMPoI8GqjNXw5XvtV6nmq9QRK6Na
         ExswiXcmIh/mXA6Iewy/IEtcSF7Nwyzzv8LxZtn13bglvuAS30dCexSMLT1SVgliSUar
         drKoc85AyU3AhE+OfJtJ3FvuGt+e+0R7CEdlQrh17nmap2QMCR31guU5sXdCHskaFnPf
         /wVBTj9iJvSQ+QtqQ0QkKzF7cyd8tVjhIpHdNMJhCSwftKSVoPB5V7NktZEPz+8fhZFl
         IVmw==
X-Gm-Message-State: AOAM533ziKKjsRG75qHtnUxgZbtj96Z551QMngg1yfGWYta8ue13F5Ej
        558d+8L1CodIRVEBjh7Rj3B0SUeKwWzH/Myt
X-Google-Smtp-Source: ABdhPJzfz9YK0z5xQjgX+uIRBOh+PmftuTdjF5WTgFEIpGyktmdOqbLubqsI53pFf5YA0q7+42Rq2g==
X-Received: by 2002:a65:518a:: with SMTP id h10mr9153953pgq.340.1607648265788;
        Thu, 10 Dec 2020 16:57:45 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x6sm6829532pgr.20.2020.12.10.16.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 16:57:45 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support)
Subject: [PATCH] tty: serial: meson: enable console as module
Date:   Thu, 10 Dec 2020 16:57:44 -0800
Message-Id: <20201211005744.12855-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable serial driver to be built as a module.  To do so, init the
console support on driver/module load instead of using
console_initcall().

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Yes, I'm well aware that having the serial console as a module makes
devices hard to debug, so I'm not changing any default behavior.  The
goal is just to enable building as a module for environments where
serial debug is not available or needed.

 drivers/tty/serial/Kconfig      | 2 +-
 drivers/tty/serial/meson_uart.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 1044fc387691..c3fa78e63357 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -206,7 +206,7 @@ config SERIAL_MESON
 
 config SERIAL_MESON_CONSOLE
 	bool "Support for console on meson"
-	depends on SERIAL_MESON=y
+	depends on SERIAL_MESON
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index d2c08b760f83..69eeef9edfa5 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -604,7 +604,6 @@ static int __init meson_serial_console_init(void)
 	register_console(&meson_serial_console);
 	return 0;
 }
-console_initcall(meson_serial_console_init);
 
 static void meson_serial_early_console_write(struct console *co,
 					     const char *s,
@@ -634,6 +633,9 @@ OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
+static int __init meson_serial_console_init(void) {
+	return 0;
+}
 #define MESON_SERIAL_CONSOLE	NULL
 #endif
 
@@ -824,6 +826,10 @@ static int __init meson_uart_init(void)
 {
 	int ret;
 
+	ret = meson_serial_console_init();
+	if (ret)
+		return ret;
+	
 	ret = uart_register_driver(&meson_uart_driver);
 	if (ret)
 		return ret;
-- 
2.29.2

