Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F0C28FC65
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393731AbgJPCZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:25:33 -0400
Received: from m12-18.163.com ([220.181.12.18]:50257 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393722AbgJPCZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ACNOSwLeo9rkV9/i8o
        FvJHx5NnDcSRXn99lMNbUKNpY=; b=V7PPrerEHRbOEpN/wkBCk7q2QaBCD+3jiF
        WP4dJWyilew9wDH5NhFP6khOLyCCpvh8931Q0xvlbPIlwIe9VEaTfih2e5dag1/k
        h0Uh+kZeRew0bh+uuY1aCR6UoGaLt0EGxTAq/rnIR+FA+XItYRCPlNgUmwI+N9ho
        Is3yW8/n8=
Received: from localhost.localdomain (unknown [118.113.10.145])
        by smtp14 (Coremail) with SMTP id EsCowACXGsFrBIlfFosDTg--.401S4;
        Fri, 16 Oct 2020 10:24:44 +0800 (CST)
From:   Sheng Long Wang <china_shenglong@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: [PATCH v6] usb-serial:cp210x: add support to software flow control
Date:   Fri, 16 Oct 2020 10:24:28 +0800
Message-Id: <20201016022428.9671-1-china_shenglong@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowACXGsFrBIlfFosDTg--.401S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF45Jw18Jr45GF1rXr48Crg_yoWxWw4UpF
        15trWFyFWDZa1YgF4FyF4UCr98ua1SqFyqyFyak39IyF43Gw4fKF1xKa4Yyr1UAr48Jry5
        trnIyFyDuF1UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfvtAUUUUU=
X-Originating-IP: [118.113.10.145]
X-CM-SenderInfo: xfkl0tpbvkv0xjor0wi6rwjhhfrp/1tbiEwy-slXlywG7rgAAs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Sheng Long <shenglong.wang.ext@siemens.com>

When data is transmitted between two serial ports,
the phenomenon of data loss often occurs. The two kinds
of flow control commonly used in serial communication
are hardware flow control and software flow control.

In serial communication, If you only use RX/TX/GND Pins, you
can't do hardware flow. So we often used software flow control
and prevent data loss. The user sets the software flow control
through the application program, and the application program
sets the software flow control mode for the serial port
chip through the driver.

For the cp210 serial port chip, its driver lacks the
software flow control setting code, so the user cannot set
the software flow control function through the application
program. This adds the missing software flow control.

Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>

Changes in v3:
- fixed code style, It mainly adjusts the code style acccording
  to kernel specification.

Changes in v4:
- It mainly adjusts the patch based on the last usb-next branch
  of the usb-serial.

Changes in v5:
- Fixes:
  * According to the cp210x specification, use usb_control_msg()
    requesttype 'REQTYPE_DEVICE_TO_HOST' is modified to
    'REQTYPE_INTERFACE_TO_HOST' in cp210x_get_chars().

  * If modify IXOFF/IXON has been changed, we can call set software
    flow control code.

  * If the setting software flow control wrong, do not continue
    processing proceed with updating software flow control.

Changes in v6:
- Fix 'result' variable not uninitialized warning in cp210x_set_termios().
---
 drivers/usb/serial/cp210x.c | 128 ++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d0c05aa8a0d6..2d5e31282599 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -412,6 +412,15 @@ struct cp210x_comm_status {
 	u8       bReserved;
 } __packed;
 
+struct cp210x_special_chars {
+	u8	bEofChar;
+	u8	bErrorChar;
+	u8	bBreakChar;
+	u8	bEventChar;
+	u8	bXonChar;
+	u8	bXoffChar;
+};
+
 /*
  * CP210X_PURGE - 16 bits passed in wValue of USB request.
  * SiLabs app note AN571 gives a strange description of the 4 bits:
@@ -675,6 +684,70 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
 	return result;
 }
 
+static int cp210x_get_chars(struct usb_serial_port *port, void *buf)
+{
+	struct usb_serial *serial = port->serial;
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
+	struct cp210x_special_chars *special_chars;
+	void *dmabuf;
+	int result;
+
+	dmabuf = kmemdup(buf, sizeof(*special_chars), GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	result = usb_control_msg(serial->dev,
+				usb_rcvctrlpipe(serial->dev, 0),
+				CP210X_GET_CHARS, REQTYPE_INTERFACE_TO_HOST, 0,
+				port_priv->bInterfaceNumber,
+				dmabuf, sizeof(*special_chars),
+				USB_CTRL_GET_TIMEOUT);
+
+	if (result == sizeof(*special_chars)) {
+		memcpy(buf, dmabuf, sizeof(*special_chars));
+		result = 0;
+	} else {
+		dev_err(&port->dev, "failed to get special chars: %d\n", result);
+		if (result >= 0)
+			result = -EIO;
+	}
+
+	kfree(dmabuf);
+
+	return result;
+}
+
+static int cp210x_set_chars(struct usb_serial_port *port, void *buf)
+{
+	struct usb_serial *serial = port->serial;
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
+	struct cp210x_special_chars *special_chars;
+	void *dmabuf;
+	int result;
+
+	dmabuf = kmemdup(buf, sizeof(*special_chars), GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	result = usb_control_msg(serial->dev,
+				usb_sndctrlpipe(serial->dev, 0),
+				CP210X_SET_CHARS, REQTYPE_HOST_TO_INTERFACE, 0,
+				port_priv->bInterfaceNumber,
+				dmabuf, sizeof(*special_chars), USB_CTRL_SET_TIMEOUT);
+
+	if (result == sizeof(*special_chars)) {
+		result = 0;
+	} else {
+		dev_err(&port->dev, "failed to set special chars: %d\n", result);
+		if (result >= 0)
+			result = -EIO;
+	}
+
+	kfree(dmabuf);
+
+	return result;
+}
+
 /*
  * Writes any 16-bit CP210X_ register (req) whose value is passed
  * entirely in the wValue field of the USB request.
@@ -1356,11 +1429,18 @@ static void cp210x_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct device *dev = &port->dev;
-	unsigned int cflag, old_cflag;
+	unsigned int cflag, old_cflag, iflag, old_iflag;
+	struct cp210x_special_chars special_chars;
+	struct cp210x_flow_ctl flow_ctl;
 	u16 bits;
+	int result = 0;
+	u32 ctl_hs;
+	u32 flow_repl;
 
 	cflag = tty->termios.c_cflag;
+	iflag = tty->termios.c_iflag;
 	old_cflag = old_termios->c_cflag;
+	old_iflag = old_termios->c_iflag;
 
 	if (tty->termios.c_ospeed != old_termios->c_ospeed)
 		cp210x_change_speed(tty, port, old_termios);
@@ -1434,10 +1514,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
 	}
 
 	if ((cflag & CRTSCTS) != (old_cflag & CRTSCTS)) {
-		struct cp210x_flow_ctl flow_ctl;
-		u32 ctl_hs;
-		u32 flow_repl;
-
 		cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
 				sizeof(flow_ctl));
 		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
@@ -1474,6 +1550,48 @@ static void cp210x_set_termios(struct tty_struct *tty,
 				sizeof(flow_ctl));
 	}
 
+	if (((iflag & IXOFF) != (old_iflag & IXOFF)) ||
+		((iflag & IXON) != (old_iflag & IXON))) {
+		result = cp210x_get_chars(port, &special_chars);
+		if (result < 0)
+			goto out;
+
+		special_chars.bXonChar  = START_CHAR(tty);
+		special_chars.bXoffChar = STOP_CHAR(tty);
+
+		result = cp210x_set_chars(port, &special_chars);
+		if (result < 0)
+			goto out;
+
+		result = cp210x_read_reg_block(port,
+					CP210X_GET_FLOW,
+					&flow_ctl,
+					sizeof(flow_ctl));
+		if (result < 0)
+			goto out;
+
+		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
+
+		if (iflag & IXOFF)
+			flow_repl |= CP210X_SERIAL_AUTO_RECEIVE;
+		else
+			flow_repl &= ~CP210X_SERIAL_AUTO_RECEIVE;
+
+		if (iflag & IXON)
+			flow_repl |= CP210X_SERIAL_AUTO_TRANSMIT;
+		else
+			flow_repl &= ~CP210X_SERIAL_AUTO_TRANSMIT;
+
+		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
+		result = cp210x_write_reg_block(port,
+					CP210X_SET_FLOW,
+					&flow_ctl,
+					sizeof(flow_ctl));
+	}
+out:
+	if (result < 0)
+		dev_err(dev, "failed to set software flow control: %d\n", result);
+
 	/*
 	 * Enable event-insertion mode only if input parity checking is
 	 * enabled for now.
-- 
2.17.1


