Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91512B4AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgKPQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:18:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41390 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgKPQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:18:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id v20so20764768ljk.8;
        Mon, 16 Nov 2020 08:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7MXQxs+9OiuUHRVlMAr9XZU2J/NqSLeM5VxTwBPPYAs=;
        b=CKnYAa0lf3bnJvGF11Hsrl4f4rVT6vsY4hDTT1SKsBbX50DRuMuh8iwLoPl03/0J9I
         /pECO7vu9lf5pXqOtaHGB35HJCTC4UDl/Hh2yMgZG70f+VwHwh+9wo7mfdIbgGJCd3eY
         6CPAvyib+2ZmTSkPJa7lXTaKxQ6H/Kvz44TbyRfDmMa4QQ3Ot7Llwa/bswgRlrrrpY7S
         17hA2r7EFjp4kKkEm1xvJHnVM7EUqdsZS2QXZxbhcW5jfJH9h06wPM4OoKJ4/wpfHcj6
         yUXHD+6uVesrH/WT4nymnbYk5FlKXRGRVr7lgp9CpLKbPl32hICSQYVYNSBfswnQz9uI
         JvHw==
X-Gm-Message-State: AOAM5339G7Pj5vIUyGVBEYarQH6h0hCmzfV/KZoNSOnWrL/Ti+RlmgW0
        OO1eZAM9W4lh5EFlMbVpmauXQrYtHP5HIw==
X-Google-Smtp-Source: ABdhPJwFi4vGxlKKCFNEyjFkyzGAdYc999zSVE9oXgmrCcHEiS79AUMU1HoMGBZnBxFL9HsYJwDr7g==
X-Received: by 2002:a2e:96d8:: with SMTP id d24mr46628ljj.151.1605543521581;
        Mon, 16 Nov 2020 08:18:41 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h10sm724214lfc.18.2020.11.16.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:18:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kehDH-0007fl-Pv; Mon, 16 Nov 2020 17:18:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Sheng Long Wang <shenglong.wang.ext@siemens.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/6] USB: serial: cp210x: clean up line-control handling
Date:   Mon, 16 Nov 2020 17:18:22 +0100
Message-Id: <20201116161826.29417-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116161826.29417-1-johan@kernel.org>
References: <20201116161826.29417-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the line-control settings in one request unconditionally instead
of setting the word-length, parity and stop-bit settings separately.

This avoids multiple requests when several settings are changed even if
this scheme could potentially also be used to detect unsupported device
settings. Since all device types but CP2101 appears to support all
settings, let's handle that one specifically and also report back the
unsupported settings properly through termios by clearing the
corresponding bits.

Also drop the related unnecessary debug printks.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 101 +++++++++++++++---------------------
 1 file changed, 41 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index f1fd109d97d5..ad134e517849 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1364,9 +1364,11 @@ static bool cp210x_termios_change(const struct ktermios *a, const struct ktermio
 static void cp210x_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct cp210x_serial_private *priv = usb_get_serial_data(port->serial);
 	struct device *dev = &port->dev;
 	unsigned int cflag, old_cflag;
 	u16 bits;
+	int ret;
 
 	if (!cp210x_termios_change(&tty->termios, old_termios))
 		return;
@@ -1377,74 +1379,53 @@ static void cp210x_set_termios(struct tty_struct *tty,
 	if (tty->termios.c_ospeed != old_termios->c_ospeed)
 		cp210x_change_speed(tty, port, old_termios);
 
-	/* If the number of data bits is to be updated */
-	if ((cflag & CSIZE) != (old_cflag & CSIZE)) {
-		cp210x_get_line_ctl(port, &bits);
-		bits &= ~BITS_DATA_MASK;
-		switch (cflag & CSIZE) {
-		case CS5:
-			bits |= BITS_DATA_5;
-			dev_dbg(dev, "%s - data bits = 5\n", __func__);
-			break;
-		case CS6:
-			bits |= BITS_DATA_6;
-			dev_dbg(dev, "%s - data bits = 6\n", __func__);
-			break;
-		case CS7:
-			bits |= BITS_DATA_7;
-			dev_dbg(dev, "%s - data bits = 7\n", __func__);
-			break;
-		case CS8:
-		default:
-			bits |= BITS_DATA_8;
-			dev_dbg(dev, "%s - data bits = 8\n", __func__);
-			break;
-		}
-		if (cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits))
-			dev_dbg(dev, "Number of data bits requested not supported by device\n");
+	/* CP2101 only supports CS8, 1 stop bit and non-stick parity. */
+	if (priv->partnum == CP210X_PARTNUM_CP2101) {
+		tty->termios.c_cflag &= ~(CSIZE | CSTOPB | CMSPAR);
+		tty->termios.c_cflag |= CS8;
 	}
 
-	if ((cflag     & (PARENB|PARODD|CMSPAR)) !=
-	    (old_cflag & (PARENB|PARODD|CMSPAR))) {
-		cp210x_get_line_ctl(port, &bits);
-		bits &= ~BITS_PARITY_MASK;
-		if (cflag & PARENB) {
-			if (cflag & CMSPAR) {
-				if (cflag & PARODD) {
-					bits |= BITS_PARITY_MARK;
-					dev_dbg(dev, "%s - parity = MARK\n", __func__);
-				} else {
-					bits |= BITS_PARITY_SPACE;
-					dev_dbg(dev, "%s - parity = SPACE\n", __func__);
-				}
-			} else {
-				if (cflag & PARODD) {
-					bits |= BITS_PARITY_ODD;
-					dev_dbg(dev, "%s - parity = ODD\n", __func__);
-				} else {
-					bits |= BITS_PARITY_EVEN;
-					dev_dbg(dev, "%s - parity = EVEN\n", __func__);
-				}
-			}
-		}
-		if (cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits))
-			dev_dbg(dev, "Parity mode not supported by device\n");
+	bits = 0;
+
+	switch (C_CSIZE(tty)) {
+	case CS5:
+		bits |= BITS_DATA_5;
+		break;
+	case CS6:
+		bits |= BITS_DATA_6;
+		break;
+	case CS7:
+		bits |= BITS_DATA_7;
+		break;
+	case CS8:
+	default:
+		bits |= BITS_DATA_8;
+		break;
 	}
 
-	if ((cflag & CSTOPB) != (old_cflag & CSTOPB)) {
-		cp210x_get_line_ctl(port, &bits);
-		bits &= ~BITS_STOP_MASK;
-		if (cflag & CSTOPB) {
-			bits |= BITS_STOP_2;
-			dev_dbg(dev, "%s - stop bits = 2\n", __func__);
+	if (C_PARENB(tty)) {
+		if (C_CMSPAR(tty)) {
+			if (C_PARODD(tty))
+				bits |= BITS_PARITY_MARK;
+			else
+				bits |= BITS_PARITY_SPACE;
 		} else {
-			bits |= BITS_STOP_1;
-			dev_dbg(dev, "%s - stop bits = 1\n", __func__);
+			if (C_PARODD(tty))
+				bits |= BITS_PARITY_ODD;
+			else
+				bits |= BITS_PARITY_EVEN;
 		}
-		if (cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits))
-			dev_dbg(dev, "Number of stop bits requested not supported by device\n");
 	}
 
+	if (C_CSTOPB(tty))
+		bits |= BITS_STOP_2;
+	else
+		bits |= BITS_STOP_1;
+
+	ret = cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits);
+	if (ret)
+		dev_err(&port->dev, "failed to set line control: %d\n", ret);
+
 	if ((cflag & CRTSCTS) != (old_cflag & CRTSCTS)) {
 		struct cp210x_flow_ctl flow_ctl;
 		u32 ctl_hs;
-- 
2.26.2

