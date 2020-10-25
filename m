Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA852982DF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417790AbgJYRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:47:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40870 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417743AbgJYRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:46:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id a9so8915762lfc.7;
        Sun, 25 Oct 2020 10:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QfMi3ClKlPdDVMDtR633RD5RCm08X2WBNam9SHBHedk=;
        b=ZK2GE2Rj61LFyfkYpr9oJD9+OyRy40u0ZCQZj01KI8DiPhYNY4qZSI5L901IA9KMFy
         kAh+0mglx7wHdBlobN0tfaEoulfLIl+cOqZ01jqPViEKK0selfwFqKf4lxqIB44s3EXi
         e6nfIVBQPAjePvCBwVBS58+77kDhWJHcPHQtVTF1pI7de/cPz9Vvb0kur9/Pm3SrcY4a
         AIDOvnuQCdukyUMwzj8q2+vWM+PqrK0Wm7HVIJLefIT7IeKJu77bpVsB6W7TcJn5WonI
         YKnphkIHDwCciqwXOgmrGGkVbP9a2pNFJv6VuEseBxuoHHmS63PlPUzjjbE/Z1rKG58B
         KeSA==
X-Gm-Message-State: AOAM530s6POVe1Bcdu7Ev8loV5LMXHbU3KvQWPN6snMnRLf+0AGy8g/d
        SRDD4nZiYWog54mmEGoKN1xUzE1bIjRZyg==
X-Google-Smtp-Source: ABdhPJwYRoT8mWeYWYoRpSepxVWAm21du12FdTMat07W4/e71QLZi3BS43YwB9JIV4BGZtyE3nkyig==
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr3601380lfr.198.1603648001750;
        Sun, 25 Oct 2020 10:46:41 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id s19sm793732lfb.224.2020.10.25.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:46:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6J-0007I7-Gi; Sun, 25 Oct 2020 18:46:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 13/14] USB: serial: keyspan_pda: use BIT() macro
Date:   Sun, 25 Oct 2020 18:45:59 +0100
Message-Id: <20201025174600.27896-14-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the BIT() macro instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 8df7c54d6986..f582e0a3ae56 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -422,13 +422,14 @@ static int keyspan_pda_tiocmget(struct tty_struct *tty)
 	rc = keyspan_pda_get_modem_info(serial, &status);
 	if (rc < 0)
 		return rc;
-	value =
-		((status & (1<<7)) ? TIOCM_DTR : 0) |
-		((status & (1<<6)) ? TIOCM_CAR : 0) |
-		((status & (1<<5)) ? TIOCM_RNG : 0) |
-		((status & (1<<4)) ? TIOCM_DSR : 0) |
-		((status & (1<<3)) ? TIOCM_CTS : 0) |
-		((status & (1<<2)) ? TIOCM_RTS : 0);
+
+	value = ((status & BIT(7)) ? TIOCM_DTR : 0) |
+		((status & BIT(6)) ? TIOCM_CAR : 0) |
+		((status & BIT(5)) ? TIOCM_RNG : 0) |
+		((status & BIT(4)) ? TIOCM_DSR : 0) |
+		((status & BIT(3)) ? TIOCM_CTS : 0) |
+		((status & BIT(2)) ? TIOCM_RTS : 0);
+
 	return value;
 }
 
@@ -445,14 +446,14 @@ static int keyspan_pda_tiocmset(struct tty_struct *tty,
 		return rc;
 
 	if (set & TIOCM_RTS)
-		status |= (1<<2);
+		status |= BIT(2);
 	if (set & TIOCM_DTR)
-		status |= (1<<7);
+		status |= BIT(7);
 
 	if (clear & TIOCM_RTS)
-		status &= ~(1<<2);
+		status &= ~BIT(2);
 	if (clear & TIOCM_DTR)
-		status &= ~(1<<7);
+		status &= ~BIT(7);
 	rc = keyspan_pda_set_modem_info(serial, status);
 	return rc;
 }
@@ -565,7 +566,7 @@ static void keyspan_pda_dtr_rts(struct usb_serial_port *port, int on)
 	struct usb_serial *serial = port->serial;
 
 	if (on)
-		keyspan_pda_set_modem_info(serial, (1 << 7) | (1 << 2));
+		keyspan_pda_set_modem_info(serial, BIT(7) | BIT(2));
 	else
 		keyspan_pda_set_modem_info(serial, 0);
 }
-- 
2.26.2

