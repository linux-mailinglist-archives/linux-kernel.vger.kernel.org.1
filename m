Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A952BC765
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKVRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 12:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgKVRIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 12:08:44 -0500
Received: from localhost.localdomain (unknown [157.51.147.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 151A020781;
        Sun, 22 Nov 2020 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606064922;
        bh=H89nF4rJxyQw/XcDyeqKuL7YbPVO6wiMOXdYfy3yq6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtvqZkaljR+P0hHCWjTtnHnQJ6OO4kWOOCsyULlN9t4M5qhNDiirDu3qCA4x2npDR
         g9bAPLfB0msWqlylnLUc1wVj6AJurd+HhJzWhHxRemQEe3KY+7Hdk4ilIWHa/JJ/LX
         n93egug4nEsbLf8m7PxwMa3zlUOmVl2EFazSI6k4=
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, angelo.dureghello@timesys.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v5 1/3] usb: serial: Add MaxLinear/Exar USB to Serial driver
Date:   Sun, 22 Nov 2020 22:38:20 +0530
Message-Id: <20201122170822.21715-2-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201122170822.21715-1-mani@kernel.org>
References: <20201122170822.21715-1-mani@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MaxLinear/Exar USB to Serial converters. This driver
only supports XR21V141X series but it can be extended to other series
from Exar as well in future.

This driver is inspired from the initial one submitted by Patong Yang:

https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop

While the initial driver was a custom tty USB driver exposing whole
new serial interface ttyXRUSBn, this version is completely based on USB
serial core thus exposing the interfaces as ttyUSBn. This will avoid
the overhead of exposing a new USB serial interface which the userspace
tools are unaware of.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/usb/serial/Kconfig     |   9 +
 drivers/usb/serial/Makefile    |   1 +
 drivers/usb/serial/xr_serial.c | 599 +++++++++++++++++++++++++++++++++
 3 files changed, 609 insertions(+)
 create mode 100644 drivers/usb/serial/xr_serial.c

diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 4007fa25a8ff..32595acb1d1d 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -644,6 +644,15 @@ config USB_SERIAL_UPD78F0730
 	  To compile this driver as a module, choose M here: the
 	  module will be called upd78f0730.
 
+config USB_SERIAL_XR
+	tristate "USB MaxLinear/Exar USB to Serial driver"
+	help
+	  Say Y here if you want to use MaxLinear/Exar USB to Serial converter
+	  devices.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called xr_serial.
+
 config USB_SERIAL_DEBUG
 	tristate "USB Debugging Device"
 	help
diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
index 2d491e434f11..4f69c2a3aff3 100644
--- a/drivers/usb/serial/Makefile
+++ b/drivers/usb/serial/Makefile
@@ -62,4 +62,5 @@ obj-$(CONFIG_USB_SERIAL_VISOR)			+= visor.o
 obj-$(CONFIG_USB_SERIAL_WISHBONE)		+= wishbone-serial.o
 obj-$(CONFIG_USB_SERIAL_WHITEHEAT)		+= whiteheat.o
 obj-$(CONFIG_USB_SERIAL_XIRCOM)			+= keyspan_pda.o
+obj-$(CONFIG_USB_SERIAL_XR)			+= xr_serial.o
 obj-$(CONFIG_USB_SERIAL_XSENS_MT)		+= xsens_mt.o
diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
new file mode 100644
index 000000000000..e166916554d6
--- /dev/null
+++ b/drivers/usb/serial/xr_serial.c
@@ -0,0 +1,599 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MaxLinear/Exar USB to Serial driver
+ *
+ * Based on the initial driver written by Patong Yang:
+ * https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop
+ *
+ * Copyright (c) 2018 Patong Yang <patong.mxl@gmail.com>
+ * Copyright (c) 2020 Manivannan Sadhasivam <mani@kernel.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/usb.h>
+#include <linux/usb/serial.h>
+
+struct xr_txrx_clk_mask {
+	u16 tx;
+	u16 rx0;
+	u16 rx1;
+};
+
+#define XR_INT_OSC_HZ			48000000U
+#define XR21V141X_MIN_SPEED		46U
+#define XR21V141X_MAX_SPEED		XR_INT_OSC_HZ
+
+/* USB Requests */
+#define XR21V141X_SET_REQ		0
+#define XR21V141X_GET_REQ		1
+
+#define XR21V141X_CLOCK_DIVISOR_0	0x04
+#define XR21V141X_CLOCK_DIVISOR_1	0x05
+#define XR21V141X_CLOCK_DIVISOR_2	0x06
+#define XR21V141X_TX_CLOCK_MASK_0	0x07
+#define XR21V141X_TX_CLOCK_MASK_1	0x08
+#define XR21V141X_RX_CLOCK_MASK_0	0x09
+#define XR21V141X_RX_CLOCK_MASK_1	0x0a
+
+/* XR21V141X register blocks */
+#define XR21V141X_UART_REG_BLOCK	0
+#define XR21V141X_UM_REG_BLOCK		4
+#define XR21V141X_UART_CUSTOM_BLOCK	0x66
+
+/* XR21V141X UART Manager Registers */
+#define XR21V141X_UM_FIFO_ENABLE_REG	0x10
+#define XR21V141X_UM_ENABLE_TX_FIFO	0x01
+#define XR21V141X_UM_ENABLE_RX_FIFO	0x02
+
+#define XR21V141X_UM_RX_FIFO_RESET	0x18
+#define XR21V141X_UM_TX_FIFO_RESET	0x1c
+
+#define XR21V141X_UART_ENABLE_TX	0x1
+#define XR21V141X_UART_ENABLE_RX	0x2
+
+#define XR21V141X_UART_MODE_RI		BIT(0)
+#define XR21V141X_UART_MODE_CD		BIT(1)
+#define XR21V141X_UART_MODE_DSR		BIT(2)
+#define XR21V141X_UART_MODE_DTR		BIT(3)
+#define XR21V141X_UART_MODE_CTS		BIT(4)
+#define XR21V141X_UART_MODE_RTS		BIT(5)
+
+#define XR21V141X_UART_BREAK_ON		0xff
+#define XR21V141X_UART_BREAK_OFF	0
+
+#define XR21V141X_UART_DATA_MASK	GENMASK(3, 0)
+#define XR21V141X_UART_DATA_7		0x7
+#define XR21V141X_UART_DATA_8		0x8
+
+#define XR21V141X_UART_PARITY_MASK	GENMASK(6, 4)
+#define XR21V141X_UART_PARITY_SHIFT	0x4
+#define XR21V141X_UART_PARITY_NONE	0x0
+#define XR21V141X_UART_PARITY_ODD	0x1
+#define XR21V141X_UART_PARITY_EVEN	0x2
+#define XR21V141X_UART_PARITY_MARK	0x3
+#define XR21V141X_UART_PARITY_SPACE	0x4
+
+#define XR21V141X_UART_STOP_MASK	BIT(7)
+#define XR21V141X_UART_STOP_SHIFT	0x7
+#define XR21V141X_UART_STOP_1		0x0
+#define XR21V141X_UART_STOP_2		0x1
+
+#define XR21V141X_UART_FLOW_MODE_NONE	0x0
+#define XR21V141X_UART_FLOW_MODE_HW	0x1
+#define XR21V141X_UART_FLOW_MODE_SW	0x2
+
+#define XR21V141X_UART_MODE_GPIO_MASK	GENMASK(2, 0)
+#define XR21V141X_UART_MODE_RTS_CTS	0x1
+#define XR21V141X_UART_MODE_DTR_DSR	0x2
+#define XR21V141X_UART_MODE_RS485	0x3
+#define XR21V141X_UART_MODE_RS485_ADDR	0x4
+
+#define XR21V141X_REG_ENABLE		0x03
+#define XR21V141X_REG_FORMAT		0x0b
+#define XR21V141X_REG_FLOW_CTRL		0x0c
+#define XR21V141X_REG_XON_CHAR		0x10
+#define XR21V141X_REG_XOFF_CHAR		0x11
+#define XR21V141X_REG_LOOPBACK		0x12
+#define XR21V141X_REG_TX_BREAK		0x14
+#define XR21V141X_REG_RS845_DELAY	0x15
+#define XR21V141X_REG_GPIO_MODE		0x1a
+#define XR21V141X_REG_GPIO_DIR		0x1b
+#define XR21V141X_REG_GPIO_INT_MASK	0x1c
+#define XR21V141X_REG_GPIO_SET		0x1d
+#define XR21V141X_REG_GPIO_CLR		0x1e
+#define XR21V141X_REG_GPIO_STATUS	0x1f
+
+static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg,
+		      u8 val)
+{
+	struct usb_serial *serial = port->serial;
+	int ret;
+
+	ret = usb_control_msg(serial->dev,
+			      usb_sndctrlpipe(serial->dev, 0),
+			      XR21V141X_SET_REQ,
+			      USB_DIR_OUT | USB_TYPE_VENDOR, val,
+			      reg | (block << 8), NULL, 0,
+			      USB_CTRL_SET_TIMEOUT);
+	if (ret < 0) {
+		dev_err(&port->dev, "Failed to set reg 0x%02x: %d\n", reg, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg,
+		      u8 *val)
+{
+	struct usb_serial *serial = port->serial;
+	u8 *dmabuf;
+	int ret;
+
+	dmabuf = kmalloc(1, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	ret = usb_control_msg(serial->dev,
+			      usb_rcvctrlpipe(serial->dev, 0),
+			      XR21V141X_GET_REQ,
+			      USB_DIR_IN | USB_TYPE_VENDOR, 0,
+			      reg | (block << 8), dmabuf, 1,
+			      USB_CTRL_GET_TIMEOUT);
+	if (ret == 1) {
+		*val = *dmabuf;
+		ret = 0;
+	} else {
+		dev_err(&port->dev, "Failed to get reg 0x%02x: %d\n", reg, ret);
+		if (ret >= 0)
+			ret = -EIO;
+	}
+
+	kfree(dmabuf);
+
+	return ret;
+}
+
+static int xr_set_reg_uart(struct usb_serial_port *port, u8 reg, u8 val)
+{
+	return xr_set_reg(port, XR21V141X_UART_REG_BLOCK, reg, val);
+}
+
+static int xr_get_reg_uart(struct usb_serial_port *port, u8 reg, u8 *val)
+{
+	return xr_get_reg(port, XR21V141X_UART_REG_BLOCK, reg, val);
+}
+
+static int xr_set_reg_um(struct usb_serial_port *port, u8 reg, u8 val)
+{
+	return xr_set_reg(port, XR21V141X_UM_REG_BLOCK, reg, val);
+}
+
+/* Tx and Rx clock mask values obtained from section 3.3.4 of datasheet */
+static const struct xr_txrx_clk_mask xr21v141x_txrx_clk_masks[] = {
+	{ 0x000, 0x000, 0x000 },
+	{ 0x000, 0x000, 0x000 },
+	{ 0x100, 0x000, 0x100 },
+	{ 0x020, 0x400, 0x020 },
+	{ 0x010, 0x100, 0x010 },
+	{ 0x208, 0x040, 0x208 },
+	{ 0x104, 0x820, 0x108 },
+	{ 0x844, 0x210, 0x884 },
+	{ 0x444, 0x110, 0x444 },
+	{ 0x122, 0x888, 0x224 },
+	{ 0x912, 0x448, 0x924 },
+	{ 0x492, 0x248, 0x492 },
+	{ 0x252, 0x928, 0x292 },
+	{ 0x94a, 0x4a4, 0xa52 },
+	{ 0x52a, 0xaa4, 0x54a },
+	{ 0xaaa, 0x954, 0x4aa },
+	{ 0xaaa, 0x554, 0xaaa },
+	{ 0x555, 0xad4, 0x5aa },
+	{ 0xb55, 0xab4, 0x55a },
+	{ 0x6b5, 0x5ac, 0xb56 },
+	{ 0x5b5, 0xd6c, 0x6d6 },
+	{ 0xb6d, 0xb6a, 0xdb6 },
+	{ 0x76d, 0x6da, 0xbb6 },
+	{ 0xedd, 0xdda, 0x76e },
+	{ 0xddd, 0xbba, 0xeee },
+	{ 0x7bb, 0xf7a, 0xdde },
+	{ 0xf7b, 0xef6, 0x7de },
+	{ 0xdf7, 0xbf6, 0xf7e },
+	{ 0x7f7, 0xfee, 0xefe },
+	{ 0xfdf, 0xfbe, 0x7fe },
+	{ 0xf7f, 0xefe, 0xffe },
+	{ 0xfff, 0xffe, 0xffd },
+};
+
+static int xr_set_baudrate(struct tty_struct *tty,
+			   struct usb_serial_port *port)
+{
+	u32 divisor, baud, idx;
+	u16 tx_mask, rx_mask;
+	int ret;
+
+	baud = clamp(tty->termios.c_ospeed, XR21V141X_MIN_SPEED,
+		     XR21V141X_MAX_SPEED);
+	divisor = XR_INT_OSC_HZ / baud;
+	idx = ((32 * XR_INT_OSC_HZ) / baud) & 0x1f;
+	tx_mask = xr21v141x_txrx_clk_masks[idx].tx;
+
+	if (divisor & 1)
+		rx_mask = xr21v141x_txrx_clk_masks[idx].rx1;
+	else
+		rx_mask = xr21v141x_txrx_clk_masks[idx].rx0;
+
+	dev_dbg(&port->dev, "Setting baud rate: %u\n", baud);
+	/*
+	 * XR21V141X uses fractional baud rate generator with 48MHz internal
+	 * oscillator and 19-bit programmable divisor. So theoretically it can
+	 * generate most commonly used baud rates with high accuracy.
+	 */
+	ret = xr_set_reg_uart(port, XR21V141X_CLOCK_DIVISOR_0, (divisor & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_CLOCK_DIVISOR_1, ((divisor >>  8) & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_CLOCK_DIVISOR_2, ((divisor >> 16) & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_TX_CLOCK_MASK_0, (tx_mask & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_TX_CLOCK_MASK_1, ((tx_mask >>  8) & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_RX_CLOCK_MASK_0, (rx_mask & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_RX_CLOCK_MASK_1, ((rx_mask >>  8) & 0xff));
+
+	tty_encode_baud_rate(tty, baud, baud);
+
+	return ret;
+}
+
+/*
+ * According to datasheet, below is the recommended sequence for enabling UART
+ * module in XR21V141X:
+ *
+ * Enable Tx FIFO
+ * Enable Tx and Rx
+ * Enable Rx FIFO
+ */
+static int xr_uart_enable(struct usb_serial_port *port)
+{
+	int ret;
+
+	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG, XR21V141X_UM_ENABLE_TX_FIFO);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_REG_ENABLE,
+			      XR21V141X_UART_ENABLE_TX | XR21V141X_UART_ENABLE_RX);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG,
+			    XR21V141X_UM_ENABLE_TX_FIFO | XR21V141X_UM_ENABLE_RX_FIFO);
+
+	if (ret)
+		xr_set_reg_uart(port, XR21V141X_REG_ENABLE, 0);
+
+	return ret;
+}
+
+static int xr_uart_disable(struct usb_serial_port *port)
+{
+	int ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_REG_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG, 0);
+
+	return ret;
+}
+
+static void xr_set_flow_mode(struct tty_struct *tty,
+			     struct usb_serial_port *port)
+{
+	unsigned int cflag = tty->termios.c_cflag;
+	int ret;
+	u8 flow, gpio_mode;
+
+	ret = xr_get_reg_uart(port, XR21V141X_REG_GPIO_MODE, &gpio_mode);
+	if (ret)
+		return;
+
+	if (cflag & CRTSCTS) {
+		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
+
+		/*
+		 * RTS/CTS is the default flow control mode, so set GPIO mode
+		 * for controlling the pins manually by default.
+		 */
+		gpio_mode &= ~XR21V141X_UART_MODE_GPIO_MASK;
+		gpio_mode |= XR21V141X_UART_MODE_RTS_CTS;
+		flow = XR21V141X_UART_FLOW_MODE_HW;
+	} else if (I_IXON(tty)) {
+		u8 start_char = START_CHAR(tty);
+		u8 stop_char = STOP_CHAR(tty);
+
+		dev_dbg(&port->dev, "Enabling sw flow ctrl\n");
+		flow = XR21V141X_UART_FLOW_MODE_SW;
+
+		xr_set_reg_uart(port, XR21V141X_REG_XON_CHAR, start_char);
+		xr_set_reg_uart(port, XR21V141X_REG_XOFF_CHAR, stop_char);
+	} else {
+		dev_dbg(&port->dev, "Disabling flow ctrl\n");
+		flow = XR21V141X_UART_FLOW_MODE_NONE;
+	}
+
+	/*
+	 * As per the datasheet, UART needs to be disabled while writing to
+	 * FLOW_CONTROL register.
+	 */
+	xr_uart_disable(port);
+	xr_set_reg_uart(port, XR21V141X_REG_FLOW_CTRL, flow);
+	xr_uart_enable(port);
+
+	xr_set_reg_uart(port, XR21V141X_REG_GPIO_MODE, gpio_mode);
+}
+
+static int xr_tiocmset_port(struct usb_serial_port *port,
+			    unsigned int set, unsigned int clear)
+{
+	u8 gpio_set = 0;
+	u8 gpio_clr = 0;
+	int ret = 0;
+
+	/* Modem control pins are active low, so set & clr are swapped */
+	if (set & TIOCM_RTS)
+		gpio_clr |= XR21V141X_UART_MODE_RTS;
+	if (set & TIOCM_DTR)
+		gpio_clr |= XR21V141X_UART_MODE_DTR;
+	if (clear & TIOCM_RTS)
+		gpio_set |= XR21V141X_UART_MODE_RTS;
+	if (clear & TIOCM_DTR)
+		gpio_set |= XR21V141X_UART_MODE_DTR;
+
+	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
+	if (gpio_clr)
+		ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_CLR, gpio_clr);
+
+	if (gpio_set)
+		ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_SET, gpio_set);
+
+	return ret;
+}
+
+static int xr_tiocmset(struct tty_struct *tty,
+		       unsigned int set, unsigned int clear)
+{
+	struct usb_serial_port *port = tty->driver_data;
+
+	return xr_tiocmset_port(port, set, clear);
+}
+
+static void xr_dtr_rts(struct usb_serial_port *port, int on)
+{
+	if (on)
+		xr_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
+	else
+		xr_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
+}
+
+static void xr_set_termios(struct tty_struct *tty,
+			   struct usb_serial_port *port,
+			   struct ktermios *old_termios)
+{
+	struct ktermios *termios = &tty->termios;
+	int ret;
+	u8 bits = 0;
+
+	if ((old_termios && tty->termios.c_ospeed != old_termios->c_ospeed) ||
+	    !old_termios)
+		xr_set_baudrate(tty, port);
+
+	switch (C_CSIZE(tty)) {
+	case CS5:
+	fallthrough;
+	case CS6:
+		/* CS5 and CS6 are not supported, so just restore old setting */
+		termios->c_cflag &= ~CSIZE;
+		if (old_termios)
+			termios->c_cflag |= old_termios->c_cflag & CSIZE;
+		else
+			bits |= XR21V141X_UART_DATA_8;
+		break;
+	case CS7:
+		bits |= XR21V141X_UART_DATA_7;
+		break;
+	case CS8:
+	fallthrough;
+	default:
+		bits |= XR21V141X_UART_DATA_8;
+		break;
+	}
+
+	if (C_PARENB(tty)) {
+		if (C_CMSPAR(tty)) {
+			if (C_PARODD(tty))
+				bits |= XR21V141X_UART_PARITY_MARK <<
+					XR21V141X_UART_PARITY_SHIFT;
+			else
+				bits |= XR21V141X_UART_PARITY_SPACE <<
+					XR21V141X_UART_PARITY_SHIFT;
+		} else {
+			if (C_PARODD(tty))
+				bits |= XR21V141X_UART_PARITY_ODD <<
+					XR21V141X_UART_PARITY_SHIFT;
+			else
+				bits |= XR21V141X_UART_PARITY_EVEN <<
+					XR21V141X_UART_PARITY_SHIFT;
+		}
+	}
+
+	if (C_CSTOPB(tty))
+		bits |= XR21V141X_UART_STOP_2 << XR21V141X_UART_STOP_SHIFT;
+	else
+		bits |= XR21V141X_UART_STOP_1 << XR21V141X_UART_STOP_SHIFT;
+
+	ret = xr_set_reg_uart(port, XR21V141X_REG_FORMAT, bits);
+	if (ret)
+		return;
+
+	/* If baud rate is B0, clear DTR and RTS */
+	if (C_BAUD(tty) == B0)
+		xr_dtr_rts(port, 0);
+
+	xr_set_flow_mode(tty, port);
+}
+
+static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
+{
+	int ret;
+
+	ret = xr_uart_enable(port);
+	if (ret) {
+		dev_err(&port->dev, "Failed to enable UART\n");
+		return ret;
+	}
+
+	/* Setup termios */
+	if (tty)
+		xr_set_termios(tty, port, NULL);
+
+	ret = usb_serial_generic_open(tty, port);
+	if (ret) {
+		xr_uart_disable(port);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void xr_close(struct usb_serial_port *port)
+{
+	usb_serial_generic_close(port);
+
+	xr_uart_disable(port);
+}
+
+static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
+{
+	struct usb_device *usb_dev = interface_to_usbdev(serial->interface);
+	struct usb_driver *driver = serial->type->usb_driver;
+	struct usb_interface *control_interface;
+	int ret;
+
+	/* Don't bind to control interface */
+	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
+		return -ENODEV;
+
+	/* But claim the control interface during data interface probe */
+	control_interface = usb_ifnum_to_if(usb_dev, 0);
+	ret = usb_driver_claim_interface(driver, control_interface, NULL);
+	if (ret) {
+		dev_err(&serial->interface->dev, "Can't claim control interface\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int xr_tiocmget(struct tty_struct *tty)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	u8 status;
+	int ret;
+
+	ret = xr_get_reg_uart(port, XR21V141X_REG_GPIO_STATUS, &status);
+	if (ret)
+		return ret;
+
+	/*
+	 * Modem control pins are active low, so reading '0' means it is active
+	 * and '1' means not active.
+	 */
+	ret = ((status & XR21V141X_UART_MODE_DTR) ? 0 : TIOCM_DTR) |
+	      ((status & XR21V141X_UART_MODE_RTS) ? 0 : TIOCM_RTS) |
+	      ((status & XR21V141X_UART_MODE_CTS) ? 0 : TIOCM_CTS) |
+	      ((status & XR21V141X_UART_MODE_DSR) ? 0 : TIOCM_DSR) |
+	      ((status & XR21V141X_UART_MODE_RI) ? 0 : TIOCM_RI) |
+	      ((status & XR21V141X_UART_MODE_CD) ? 0 : TIOCM_CD);
+
+	return ret;
+}
+
+static void xr_break_ctl(struct tty_struct *tty, int break_state)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	u8 state;
+
+	if (break_state == 0)
+		state = XR21V141X_UART_BREAK_OFF;
+	else
+		state = XR21V141X_UART_BREAK_ON;
+
+	dev_dbg(&port->dev, "Turning break %s\n",
+		state == XR21V141X_UART_BREAK_OFF ? "off" : "on");
+	xr_set_reg_uart(port, XR21V141X_REG_TX_BREAK, state);
+}
+
+static int xr_port_probe(struct usb_serial_port *port)
+{
+	return 0;
+}
+
+static int xr_port_remove(struct usb_serial_port *port)
+{
+	return 0;
+}
+
+static const struct usb_device_id id_table[] = {
+	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, id_table);
+
+static struct usb_serial_driver xr_device = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name =	"xr_serial",
+	},
+	.id_table		= id_table,
+	.num_ports		= 1,
+	.open			= xr_open,
+	.close			= xr_close,
+	.break_ctl		= xr_break_ctl,
+	.set_termios		= xr_set_termios,
+	.tiocmget		= xr_tiocmget,
+	.tiocmset		= xr_tiocmset,
+	.probe			= xr_probe,
+	.port_probe		= xr_port_probe,
+	.port_remove		= xr_port_remove,
+	.dtr_rts		= xr_dtr_rts
+};
+
+static struct usb_serial_driver * const serial_drivers[] = {
+	&xr_device, NULL
+};
+
+module_usb_serial_driver(serial_drivers, id_table);
+
+MODULE_AUTHOR("Manivannan Sadhasivam <mani@kernel.org>");
+MODULE_DESCRIPTION("MaxLinear/Exar USB to Serial driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

