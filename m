Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45962B4AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgKPQSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:18:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46658 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbgKPQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:18:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id v144so25852735lfa.13;
        Mon, 16 Nov 2020 08:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0FJkXiFsz+KFBu5z88+ao7r0d/sqnZhNOz3o7fzTz0=;
        b=ZvZD/K9uddy3kj0mRcOuOgmMxm3OGuoJGA4bBw4nswnH2nWccPXnTyr3bqh3Fu5TR1
         ng8x0NYAE/kf+Sjft3Fbwd4HeE7/NW6ITakq+OzX5bQv88bP/eugDgJZz+97D3Lkix2Q
         YTpnN7m34Nh5lkQ229qqeFLlXe5ue7RYDzC/CDOr444Lf/zcpQ1LYYYIrcLTpdoBhNc6
         OIGFevganB301n4zHm5x43ZjWxDWqt3wX7RsbY/bZ2fva1iXUKn+/CW/aKiiHkE3CgLY
         16XXTdOD0lfhbEqxO6F9d4zSxlfEfDm3282vNtNl3KMAEr4DYIN35FNrECvYOGFNdHhr
         IYTA==
X-Gm-Message-State: AOAM530/8EzhSlpAMdgzE6o4m2p4OUlh/Pkf6JyBFlTi/HzW283hBAgd
        KMeltbEyAIp8EGph7wwvwinUQG383g9SJA==
X-Google-Smtp-Source: ABdhPJxxG82FP4/YuzYEeHt3HP9vc8g4EQSvp6zZJeUdOYULWNaBwK3eSSp0KuIMWnr4WrJwylna6Q==
X-Received: by 2002:a19:110:: with SMTP id 16mr32808lfb.557.1605543522595;
        Mon, 16 Nov 2020 08:18:42 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id b76sm2774563lfg.13.2020.11.16.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:18:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kehDH-0007fq-TC; Mon, 16 Nov 2020 17:18:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Sheng Long Wang <shenglong.wang.ext@siemens.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/6] USB: serial: cp210x: set terminal settings on open
Date:   Mon, 16 Nov 2020 17:18:23 +0100
Message-Id: <20201116161826.29417-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116161826.29417-1-johan@kernel.org>
References: <20201116161826.29417-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other drivers cp210x have been retrieving the current terminal
settings from the device on open and reflecting those in termios.

Due to how set_termios() used to be implemented, this saved a few
control requests on open but has instead caused problems like broken
flow control and has required adding workarounds for swapped
line-control in cp2108 and line-speed initialisation on cp2104.

This unusual implementation also complicates adding new features for no
good reason.

Rip out the corresponding code and the above mentioned workarounds and
instead initialise the terminal settings unconditionally on open.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 289 +-----------------------------------
 1 file changed, 6 insertions(+), 283 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index ad134e517849..bb9c3d7ccaee 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -31,9 +31,6 @@
  */
 static int cp210x_open(struct tty_struct *tty, struct usb_serial_port *);
 static void cp210x_close(struct usb_serial_port *);
-static void cp210x_get_termios(struct tty_struct *, struct usb_serial_port *);
-static void cp210x_get_termios_port(struct usb_serial_port *port,
-	tcflag_t *cflagp, unsigned int *baudp);
 static void cp210x_change_speed(struct tty_struct *, struct usb_serial_port *,
 							struct ktermios *);
 static void cp210x_set_termios(struct tty_struct *, struct usb_serial_port *,
@@ -267,7 +264,6 @@ enum cp210x_event_state {
 
 struct cp210x_port_private {
 	u8			bInterfaceNumber;
-	bool			has_swapped_line_ctl;
 	bool			event_mode;
 	enum cp210x_event_state event_state;
 	u8 lsr;
@@ -593,46 +589,6 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
 	return result;
 }
 
-/*
- * Reads any 32-bit CP210X_ register identified by req.
- */
-static int cp210x_read_u32_reg(struct usb_serial_port *port, u8 req, u32 *val)
-{
-	__le32 le32_val;
-	int err;
-
-	err = cp210x_read_reg_block(port, req, &le32_val, sizeof(le32_val));
-	if (err) {
-		/*
-		 * FIXME Some callers don't bother to check for error,
-		 * at least give them consistent junk until they are fixed
-		 */
-		*val = 0;
-		return err;
-	}
-
-	*val = le32_to_cpu(le32_val);
-
-	return 0;
-}
-
-/*
- * Reads any 16-bit CP210X_ register identified by req.
- */
-static int cp210x_read_u16_reg(struct usb_serial_port *port, u8 req, u16 *val)
-{
-	__le16 le16_val;
-	int err;
-
-	err = cp210x_read_reg_block(port, req, &le16_val, sizeof(le16_val));
-	if (err)
-		return err;
-
-	*val = le16_to_cpu(le16_val);
-
-	return 0;
-}
-
 /*
  * Reads any 8-bit CP210X_ register identified by req.
  */
@@ -780,59 +736,6 @@ static int cp210x_write_vendor_block(struct usb_serial *serial, u8 type,
 }
 #endif
 
-/*
- * Detect CP2108 GET_LINE_CTL bug and activate workaround.
- * Write a known good value 0x800, read it back.
- * If it comes back swapped the bug is detected.
- * Preserve the original register value.
- */
-static int cp210x_detect_swapped_line_ctl(struct usb_serial_port *port)
-{
-	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	u16 line_ctl_save;
-	u16 line_ctl_test;
-	int err;
-
-	err = cp210x_read_u16_reg(port, CP210X_GET_LINE_CTL, &line_ctl_save);
-	if (err)
-		return err;
-
-	err = cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, 0x800);
-	if (err)
-		return err;
-
-	err = cp210x_read_u16_reg(port, CP210X_GET_LINE_CTL, &line_ctl_test);
-	if (err)
-		return err;
-
-	if (line_ctl_test == 8) {
-		port_priv->has_swapped_line_ctl = true;
-		line_ctl_save = swab16(line_ctl_save);
-	}
-
-	return cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, line_ctl_save);
-}
-
-/*
- * Must always be called instead of cp210x_read_u16_reg(CP210X_GET_LINE_CTL)
- * to workaround cp2108 bug and get correct value.
- */
-static int cp210x_get_line_ctl(struct usb_serial_port *port, u16 *ctl)
-{
-	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	int err;
-
-	err = cp210x_read_u16_reg(port, CP210X_GET_LINE_CTL, ctl);
-	if (err)
-		return err;
-
-	/* Workaround swapped bytes in 16-bit value from CP210X_GET_LINE_CTL */
-	if (port_priv->has_swapped_line_ctl)
-		*ctl = swab16(*ctl);
-
-	return 0;
-}
-
 static int cp210x_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
@@ -844,16 +747,8 @@ static int cp210x_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return result;
 	}
 
-	/* Configure the termios structure */
-	cp210x_get_termios(tty, port);
-
-	if (tty) {
-		/* The baud rate must be initialised on cp2104 */
-		cp210x_change_speed(tty, port, NULL);
-
-		if (I_INPCK(tty))
-			cp210x_enable_event_mode(port);
-	}
+	if (tty)
+		cp210x_set_termios(tty, port, NULL);
 
 	result = usb_serial_generic_open(tty, port);
 	if (result)
@@ -1032,167 +927,6 @@ static bool cp210x_tx_empty(struct usb_serial_port *port)
 	return !count;
 }
 
-/*
- * cp210x_get_termios
- * Reads the baud rate, data bits, parity, stop bits and flow control mode
- * from the device, corrects any unsupported values, and configures the
- * termios structure to reflect the state of the device
- */
-static void cp210x_get_termios(struct tty_struct *tty,
-	struct usb_serial_port *port)
-{
-	unsigned int baud;
-
-	if (tty) {
-		cp210x_get_termios_port(tty->driver_data,
-			&tty->termios.c_cflag, &baud);
-		tty_encode_baud_rate(tty, baud, baud);
-	} else {
-		tcflag_t cflag;
-		cflag = 0;
-		cp210x_get_termios_port(port, &cflag, &baud);
-	}
-}
-
-/*
- * cp210x_get_termios_port
- * This is the heart of cp210x_get_termios which always uses a &usb_serial_port.
- */
-static void cp210x_get_termios_port(struct usb_serial_port *port,
-	tcflag_t *cflagp, unsigned int *baudp)
-{
-	struct device *dev = &port->dev;
-	tcflag_t cflag;
-	struct cp210x_flow_ctl flow_ctl;
-	u32 baud;
-	u16 bits;
-	u32 ctl_hs;
-	u32 flow_repl;
-
-	cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
-
-	dev_dbg(dev, "%s - baud rate = %d\n", __func__, baud);
-	*baudp = baud;
-
-	cflag = *cflagp;
-
-	cp210x_get_line_ctl(port, &bits);
-	cflag &= ~CSIZE;
-	switch (bits & BITS_DATA_MASK) {
-	case BITS_DATA_5:
-		dev_dbg(dev, "%s - data bits = 5\n", __func__);
-		cflag |= CS5;
-		break;
-	case BITS_DATA_6:
-		dev_dbg(dev, "%s - data bits = 6\n", __func__);
-		cflag |= CS6;
-		break;
-	case BITS_DATA_7:
-		dev_dbg(dev, "%s - data bits = 7\n", __func__);
-		cflag |= CS7;
-		break;
-	case BITS_DATA_8:
-		dev_dbg(dev, "%s - data bits = 8\n", __func__);
-		cflag |= CS8;
-		break;
-	case BITS_DATA_9:
-		dev_dbg(dev, "%s - data bits = 9 (not supported, using 8 data bits)\n", __func__);
-		cflag |= CS8;
-		bits &= ~BITS_DATA_MASK;
-		bits |= BITS_DATA_8;
-		cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits);
-		break;
-	default:
-		dev_dbg(dev, "%s - Unknown number of data bits, using 8\n", __func__);
-		cflag |= CS8;
-		bits &= ~BITS_DATA_MASK;
-		bits |= BITS_DATA_8;
-		cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits);
-		break;
-	}
-
-	switch (bits & BITS_PARITY_MASK) {
-	case BITS_PARITY_NONE:
-		dev_dbg(dev, "%s - parity = NONE\n", __func__);
-		cflag &= ~PARENB;
-		break;
-	case BITS_PARITY_ODD:
-		dev_dbg(dev, "%s - parity = ODD\n", __func__);
-		cflag |= (PARENB|PARODD);
-		break;
-	case BITS_PARITY_EVEN:
-		dev_dbg(dev, "%s - parity = EVEN\n", __func__);
-		cflag &= ~PARODD;
-		cflag |= PARENB;
-		break;
-	case BITS_PARITY_MARK:
-		dev_dbg(dev, "%s - parity = MARK\n", __func__);
-		cflag |= (PARENB|PARODD|CMSPAR);
-		break;
-	case BITS_PARITY_SPACE:
-		dev_dbg(dev, "%s - parity = SPACE\n", __func__);
-		cflag &= ~PARODD;
-		cflag |= (PARENB|CMSPAR);
-		break;
-	default:
-		dev_dbg(dev, "%s - Unknown parity mode, disabling parity\n", __func__);
-		cflag &= ~PARENB;
-		bits &= ~BITS_PARITY_MASK;
-		cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits);
-		break;
-	}
-
-	cflag &= ~CSTOPB;
-	switch (bits & BITS_STOP_MASK) {
-	case BITS_STOP_1:
-		dev_dbg(dev, "%s - stop bits = 1\n", __func__);
-		break;
-	case BITS_STOP_1_5:
-		dev_dbg(dev, "%s - stop bits = 1.5 (not supported, using 1 stop bit)\n", __func__);
-		bits &= ~BITS_STOP_MASK;
-		cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits);
-		break;
-	case BITS_STOP_2:
-		dev_dbg(dev, "%s - stop bits = 2\n", __func__);
-		cflag |= CSTOPB;
-		break;
-	default:
-		dev_dbg(dev, "%s - Unknown number of stop bits, using 1 stop bit\n", __func__);
-		bits &= ~BITS_STOP_MASK;
-		cp210x_write_u16_reg(port, CP210X_SET_LINE_CTL, bits);
-		break;
-	}
-
-	cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
-			sizeof(flow_ctl));
-	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
-	if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
-		dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);
-		/*
-		 * When the port is closed, the CP210x hardware disables
-		 * auto-RTS and RTS is deasserted but it leaves auto-CTS when
-		 * in hardware flow control mode. When re-opening the port, if
-		 * auto-CTS is enabled on the cp210x, then auto-RTS must be
-		 * re-enabled in the driver.
-		 */
-		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
-		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
-		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
-		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
-		cp210x_write_reg_block(port,
-				CP210X_SET_FLOW,
-				&flow_ctl,
-				sizeof(flow_ctl));
-
-		cflag |= CRTSCTS;
-	} else {
-		dev_dbg(dev, "%s - flow control = NONE\n", __func__);
-		cflag &= ~CRTSCTS;
-	}
-
-	*cflagp = cflag;
-}
-
 struct cp210x_rate {
 	speed_t rate;
 	speed_t high;
@@ -1366,17 +1100,13 @@ static void cp210x_set_termios(struct tty_struct *tty,
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(port->serial);
 	struct device *dev = &port->dev;
-	unsigned int cflag, old_cflag;
 	u16 bits;
 	int ret;
 
-	if (!cp210x_termios_change(&tty->termios, old_termios))
+	if (old_termios && !cp210x_termios_change(&tty->termios, old_termios))
 		return;
 
-	cflag = tty->termios.c_cflag;
-	old_cflag = old_termios->c_cflag;
-
-	if (tty->termios.c_ospeed != old_termios->c_ospeed)
+	if (!old_termios || tty->termios.c_ospeed != old_termios->c_ospeed)
 		cp210x_change_speed(tty, port, old_termios);
 
 	/* CP2101 only supports CS8, 1 stop bit and non-stick parity. */
@@ -1426,7 +1156,7 @@ static void cp210x_set_termios(struct tty_struct *tty,
 	if (ret)
 		dev_err(&port->dev, "failed to set line control: %d\n", ret);
 
-	if ((cflag & CRTSCTS) != (old_cflag & CRTSCTS)) {
+	if (!old_termios || C_CRTSCTS(tty) != (old_termios->c_cflag & CRTSCTS)) {
 		struct cp210x_flow_ctl flow_ctl;
 		u32 ctl_hs;
 		u32 flow_repl;
@@ -1443,7 +1173,7 @@ static void cp210x_set_termios(struct tty_struct *tty,
 		ctl_hs &= ~CP210X_SERIAL_DSR_SENSITIVITY;
 		ctl_hs &= ~CP210X_SERIAL_DTR_MASK;
 		ctl_hs |= CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_ACTIVE);
-		if (cflag & CRTSCTS) {
+		if (C_CRTSCTS(tty)) {
 			ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
 
 			flow_repl &= ~CP210X_SERIAL_RTS_MASK;
@@ -1979,7 +1709,6 @@ static int cp210x_port_probe(struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv;
-	int ret;
 
 	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
 	if (!port_priv)
@@ -1989,12 +1718,6 @@ static int cp210x_port_probe(struct usb_serial_port *port)
 
 	usb_set_serial_port_data(port, port_priv);
 
-	ret = cp210x_detect_swapped_line_ctl(port);
-	if (ret) {
-		kfree(port_priv);
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.26.2

