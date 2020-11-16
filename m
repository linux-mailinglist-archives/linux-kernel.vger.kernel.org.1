Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069CD2B4AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgKPQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:18:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43995 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731853AbgKPQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:18:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id 142so7148846ljj.10;
        Mon, 16 Nov 2020 08:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJ1XEERZAY6S03XKE750mhbDDlnLNwz1luqDFRiL+1s=;
        b=gckgdudIUGDJ/8NPkBIx46hI2aGitDlHWAuLf2/9VLP+xhiGeR6YDGeHdcohHEfAGP
         num20cv0nLJo3yI863De7DsFggO4yRWglE//pFKy9ULUR7EuET74u/30TVBIh99+om+H
         7lTSkHjjEqweVbUeJUZh4rgHWTZiJRtFp/D3OopsiAEPrlsb4a/JjT2aRE2svqGo39YH
         HdWY5ChXAHJfbiNdz24xYTp6N2fYqNhdH+/cSdJWEw+J+qlSQjwHVipiRmmsL+q7mX6u
         S4rfW2cXRua204zEQwzKErkEgNaux0KsyeprrUBddeXeBBiIEGJxswmZloTcKop3Yyvi
         yT3A==
X-Gm-Message-State: AOAM531clj9UZR8QWjhc5icPEyG0jyzk1ALRj+EJ4MF+Id4VS6hSmO91
        RDqWRR8gXXdRyUTD/S84TTAIVafXy8xYDA==
X-Google-Smtp-Source: ABdhPJzfht+xx42TnvR0cNG+9ajpoK83NQ3I1BFJZNnGOU+IOZ1b2lzB6l5TU+lYEPa6M17uwORArQ==
X-Received: by 2002:a2e:6a0f:: with SMTP id f15mr34591ljc.375.1605543523927;
        Mon, 16 Nov 2020 08:18:43 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id b20sm2670513lfc.89.2020.11.16.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:18:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kehDI-0007g4-6x; Mon, 16 Nov 2020 17:18:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Sheng Long Wang <shenglong.wang.ext@siemens.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/6] USB: serial: cp210x: clean up dts_rts
Date:   Mon, 16 Nov 2020 17:18:26 +0100
Message-Id: <20201116161826.29417-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116161826.29417-1-johan@kernel.org>
References: <20201116161826.29417-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up dtr_rts by renaming the port parameter and adding missing
whitespace.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c77fd09b91ce..fbb10dfc56e3 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -46,7 +46,7 @@ static void cp210x_disconnect(struct usb_serial *);
 static void cp210x_release(struct usb_serial *);
 static int cp210x_port_probe(struct usb_serial_port *);
 static int cp210x_port_remove(struct usb_serial_port *);
-static void cp210x_dtr_rts(struct usb_serial_port *p, int on);
+static void cp210x_dtr_rts(struct usb_serial_port *port, int on);
 static void cp210x_process_read_urb(struct urb *urb);
 static void cp210x_enable_event_mode(struct usb_serial_port *port);
 static void cp210x_disable_event_mode(struct usb_serial_port *port);
@@ -1234,12 +1234,12 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 	return cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
 }
 
-static void cp210x_dtr_rts(struct usb_serial_port *p, int on)
+static void cp210x_dtr_rts(struct usb_serial_port *port, int on)
 {
 	if (on)
-		cp210x_tiocmset_port(p, TIOCM_DTR|TIOCM_RTS, 0);
+		cp210x_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
 	else
-		cp210x_tiocmset_port(p, 0, TIOCM_DTR|TIOCM_RTS);
+		cp210x_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
 }
 
 static int cp210x_tiocmget(struct tty_struct *tty)
-- 
2.26.2

