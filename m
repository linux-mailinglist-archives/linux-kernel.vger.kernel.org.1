Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3682E9308
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhADKEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:04:14 -0500
Received: from m12-17.163.com ([220.181.12.17]:53790 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbhADKEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=MuaJIJIZkSnlrvxxT1
        lnc8GSSu+6TdfSthdVvcurFis=; b=Qg/2bnSsFSeWUfZVa3ZQsF+Z9XbodGy82U
        zKA9a1w7uZUCqlKc28uVdxk9Ys9yl3FljTYtYngvSXblA9TGbF4I5mnHIamhgf3b
        nCtQkbPMWbxh3VVabvlKSsbNp9N2rxfVIpDX5Vy61PyKCayk/FtC0JVzQ3HezDlw
        xnBlyOs7Y=
Received: from localhost.localdomain (unknown [47.108.51.96])
        by smtp13 (Coremail) with SMTP id EcCowACnVrOt4_JfYfD7dg--.5930S4;
        Mon, 04 Jan 2021 17:45:17 +0800 (CST)
From:   Sheng Long Wang <china_shenglong@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: [PATCH v7] usb-serial:cp210x: add support to software flow control
Date:   Mon,  4 Jan 2021 17:45:02 +0800
Message-Id: <20210104094502.3942-1-china_shenglong@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowACnVrOt4_JfYfD7dg--.5930S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF45Jw18Jr45GF1rXr48Crg_yoW7AF48pF
        y8trWFyFWDXa1agF4FyF4UuF98uan3XFyvyFW3Cwsaka13Jw45KF1xKa4Yyr1UArW8Jry5
        AwsIvFyDuF43ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jXb18UUUUU=
X-Originating-IP: [47.108.51.96]
X-CM-SenderInfo: xfkl0tpbvkv0xjor0wi6rwjhhfrp/xtbBzQ4Qsl0CO8TDyQAAsL
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
- It adjusts the patch based on the last usb-next branch
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

Changes in v7:
- Fix:
  * Rebase work code branch on cp210x-termios branch.

  * Support for software flow control to the new cp210x_set_flow_control()
    function.

  * Modify cp210x_set_chars() parameter 'void *buf' take a pointer to
    a struct special_chars (not void *).

  * Drop cp210x_get_chars() function.
---
 drivers/usb/serial/cp210x.c | 86 +++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..bc84834cc416 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -408,6 +408,15 @@ struct cp210x_comm_status {
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
@@ -619,6 +628,38 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
 	return result;
 }
 
+
+static int cp210x_set_chars(struct usb_serial_port *port, struct cp210x_special_chars *buf)
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
@@ -1087,9 +1128,12 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct cp210x_flow_ctl flow_ctl;
+	struct cp210x_special_chars special_chars;
+	unsigned int iflag, old_iflag;
 	u32 flow_repl;
 	u32 ctl_hs;
 	int ret;
+	int result = 0;
 
 	if (old_termios && C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS))
 		return;
@@ -1126,6 +1170,48 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 
 	cp210x_write_reg_block(port, CP210X_SET_FLOW, &flow_ctl,
 			sizeof(flow_ctl));
+
+	iflag = tty->termios.c_iflag;
+	old_iflag = old_termios->c_iflag;
+	if (((iflag & IXOFF) != (old_iflag & IXOFF)) ||
+		((iflag & IXON) != (old_iflag & IXON))) {
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
+		dev_err(&port->dev, "failed to set software flow control: %d\n", result);
+
 }
 
 static void cp210x_set_termios(struct tty_struct *tty,
-- 
2.17.1


