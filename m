Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B652A2A66
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgKBMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgKBMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:07:56 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF4C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 04:07:56 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id g12so10611453pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFM6/afG6N6GkffE6RVsA6XQhyhMXSUQ6Tq0CrN9TdE=;
        b=OER6ydD30mEycoQTkeJ2IEiFZdYdh0NneHHHSB7KDLQJaaFrFNIHAk7YS3b99bIBqf
         CY5P3j+LjyDibyo6PH6yMuXRpQ7mGTtlXVUKW7EjBLFMhrrAU0dIKL732N7CSpkrDwSg
         JyBBMOnObcDhu+y53bZi+INnV6NUX6CI2ZIJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFM6/afG6N6GkffE6RVsA6XQhyhMXSUQ6Tq0CrN9TdE=;
        b=OWqgMmUe9j65I/+OO9+nYYDxcVfO6HnYu02JpeHK5Fm1506UWVs1/y0qwJI5Ntep6D
         bsjK0VwE32HP2OOJKMnsbsWTHIOQ5v9vEHcpXowdMDlcbzm6hUOZDAHnYH3HrAuAZM3s
         hxw0UJBUHRiZOno//0SiCPLl7u96OF4zqoJgjTgyOqK7zYr8qYK9MyrQlq9i3W3YnDUo
         aXqR5fPimu0kTclMNpGz6wa3o21sgJVFkJnBWCXjv+czlomBqJYOA90xT4L0tVzhO8pV
         VI2DWBLTsfYXVxPy2v/fxNkgq8749pmuI7KHei7dXJDGn6BcatXfcFMvomAQlIGCUrz/
         U2oA==
X-Gm-Message-State: AOAM5309OqPw0SVruJXIkZ+oLKSpkwiUryb7voH9yS0Y7k44AsmFAC/s
        57EfNn7TfpvfTx8X8U31v1uX8Q==
X-Google-Smtp-Source: ABdhPJwK6F4gpRDNplhBJ76hPT238QfpHnacXB+pi3j8WSLJHBoyl01NGnhMR9ZQeZeIkxPlSSGM+g==
X-Received: by 2002:a17:90b:30d2:: with SMTP id hi18mr5754162pjb.186.1604318875646;
        Mon, 02 Nov 2020 04:07:55 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id h26sm11675226pfq.139.2020.11.02.04.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 04:07:54 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     eddie.huang@mediatek.com, hsinyi@chromium.org,
        Sergey.Semin@baikalelectronics.ru, changqi.hu@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] serial: 8250_mtk: Fix uart_get_baud_rate warning
Date:   Mon,  2 Nov 2020 20:07:49 +0800
Message-Id: <20201102120749.374458-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek 8250 port supports speed higher than uartclk / 16. If the baud
rates in both the new and the old termios setting are higher than
uartclk / 16, the WARN_ON in uart_get_baud_rate() will be triggered.
Passing NULL as the old termios so uart_get_baud_rate() will use
uartclk / 16 - 1 as the new baud rate which will be replaced by the
original baud rate later by tty_termios_encode_baud_rate() in
mtk8250_set_termios().

Fixes: 551e553f0d4a ("serial: 8250_mtk: Fix high-speed baud rates clamping")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 41f4120abdf2..fa876e2c13e5 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -317,7 +317,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	baud = tty_termios_baud_rate(termios);
 
-	serial8250_do_set_termios(port, termios, old);
+	serial8250_do_set_termios(port, termios, NULL);
 
 	tty_termios_encode_baud_rate(termios, baud, baud);
 
-- 
2.29.1.341.ge80a0c044ae-goog

