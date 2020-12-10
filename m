Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503082D5A62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgLJMWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:22:19 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:46298 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLJMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:22:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 6C49D123B02;
        Thu, 10 Dec 2020 13:21:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607602890;
        bh=9F8C8JZxcUCvjH6aGMIinIIrySkmYyXrUTaGc0pmwLQ=;
        h=Date:From:To:Subject:From;
        b=auUv2cyHKwhSsJQ700KmPxsiS7iFuxMeAyM6U7oNvKxGk51WWHsAQMHt42cJHlNNR
         VfGHaRO6Fh66VPEaitEo60ghOuhiuhnWNrxIoKhtFc6C7b3dNnPT793zLvzv2C3Ngw
         SLMyLnmWtYENBIE0xPBBqC4jDvimNxBoZ5eNT0w0KK26UZdiQt0vAZTO8yLh5IMkK1
         9xUioEKA9mz0/sueNn+suAAC+IrcNTyyMKHYdRDKGmfsCTy8fVjSd2YctWDF73MUki
         XGcPL95fKWgJnLki4USBY9TtNCLmZSwHSdHINnqq97Z6JZ/p3ZCA6VavTMQOxGzrDl
         pHFS3ph9M+xbA==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0hfHEHoLf3Jr; Thu, 10 Dec 2020 13:21:02 +0100 (CET)
Received: from dincontrollerdev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 28C53123AFF;
        Thu, 10 Dec 2020 13:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607602862;
        bh=9F8C8JZxcUCvjH6aGMIinIIrySkmYyXrUTaGc0pmwLQ=;
        h=Date:From:To:Subject:From;
        b=dtKamJjmKkP2uyBI2SYUT3zHyZs6bf95xHT0SqwF5Dq9D6OkkAxJjMhFKEj4vjoHR
         5QGHV8oqSzvEMfkvpv+ZP8KCZMJzw0GXuXC20lSZJhRPy5Rv0lYNq7EUQvBCDOCM8w
         ZkKMEwPcSHY9rdWpOzYDlJ7ivcAEE3+22dXHCEOiwuGLiwJLL11UzerEfBhPiE6yZe
         QYhKNNTR8T4VaTz/bdoyFFH0iOzjp2h6elokasmkRJfyD8V83GJ3Ub5cO0r+RGkDNl
         SSPTdG9bPAudgaDNARQKf9swa4a65aSNaeXj4aqaPXf5tjcA6ajP0Kvi1YPaLkHXse
         cTl5+f57Lkxlg==
Date:   Thu, 10 Dec 2020 12:20:59 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Rob Herring' <robh+dt@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?'J=F3zsef_Horv=E1th'?= <info@ministro.hu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v1 1/2] Staging: silabs si4455 serial driver: fix directory
 structure and coding style
Message-ID: <20201210122057.GA31782@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix: coding style
fix: error checking
remove: doc silabs,si4455.txt

Signed-off-by: József Horváth <info@ministro.hu>
---
 .../bindings/staging/serial/silabs,si4455.txt |  39 -
 MAINTAINERS                                   |   7 +
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/tty/serial/Kconfig                    |   8 +
 drivers/tty/serial/Makefile                   |   1 +
 .../{staging/si4455 => tty/serial}/si4455.c   | 956 ++++++++----------
 .../si4455 => tty/serial}/si4455_api.h        |   0
 8 files changed, 419 insertions(+), 595 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
 rename drivers/{staging/si4455 => tty/serial}/si4455.c (57%)
 rename drivers/{staging/si4455 => tty/serial}/si4455_api.h (100%)

diff --git a/Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt b/Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
deleted file mode 100644
index abd659b7b952..000000000000
--- a/Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-* Silicon Labs Si4455 EASY-TO-USE, LOW-CURRENT OOK/(G)FSK SUB-GHZ TRANSCEIVER
-
-Required properties:
-- compatible: Should be one of the following:
-  - "silabs,si4455" for Silicon Labs Si4455-B1A or Si4455-C2A (driver automatically detects the part info),
-  - "silabs,si4455b1a" for Silicon Labs Si4455-B1A,
-  - "silabs,si4455c2a" for Silicon Labs Si4455-C2A,
-- reg: SPI chip select number.
-- interrupts: Specifies the interrupt source of the parent interrupt
-  controller. The format of the interrupt specifier depends on the
-  parent interrupt controller.
-- clocks: phandle to the IC source clock (only external clock source supported).
-- spi-max-frequency: maximum clock frequency on SPI port
-- shdn-gpios: gpio pin for SDN
-
-Example:
-
-/ {
-	clocks {
-                si4455_1_2_osc: si4455_1_2_osc {
-                        compatible = "fixed-clock";
-                        #clock-cells = <0>;
-                        clock-frequency  = <30000000>;
-                };
-	};
-};
-
-&spi0 {
-	si4455: si4455@0 {
-		compatible = "silabs,si4455";
-		reg = <0>;
-		clocks = <&si4455_1_2_osc>;
-		interrupt-parent = <&gpio>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-                shdn-gpios = <&gpio 26 1>;
-                status = "okay";
-                spi-max-frequency = <3000000>;
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ac5688db43a..a29bc17d446d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15934,6 +15934,13 @@ S:	Maintained
 F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
+SILICON LABS SI4455 SERIAL DRIVER
+M:	József Horváth <info@ministro.hu>
+S:	Maintained
+F:	Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
+F:	drivers/tty/serial/si4455.c
+F:	drivers/tty/serial/si4455_api.h
+
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 S:	Supported
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 2cf0c9bfe878..9b7cb7c5766a 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -118,6 +118,4 @@ source "drivers/staging/wfx/Kconfig"
 
 source "drivers/staging/hikey9xx/Kconfig"
 
-source "drivers/staging/si4455/Kconfig"
-
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 043c63287bc6..38226737c9f3 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -49,4 +49,3 @@ obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_WIMAX)		+= wimax/
 obj-$(CONFIG_WFX)		+= wfx/
 obj-y				+= hikey9xx/
-obj-$(CONFIG_SERIAL_SI4455)	+= si4455/
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 28f22e58639c..560aa311cd03 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1583,6 +1583,14 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  receives all kernel messages and warnings and which allows logins in
 	  single user mode).
 
+config SERIAL_SI4455
+	tristate "Si4455 support"
+	depends on SPI
+	select SERIAL_CORE
+	help
+	  This driver is for Silicon Labs's Si4455 Sub-GHz transciver.
+	  Say 'Y' here if you wish to use it as serial port.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index caf167f0c10a..94f8a727b2a1 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -96,3 +96,4 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
 
 obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
+obj-$(CONFIG_SERIAL_SI4455) += si4455.o
diff --git a/drivers/staging/si4455/si4455.c b/drivers/tty/serial/si4455.c
similarity index 57%
rename from drivers/staging/si4455/si4455.c
rename to drivers/tty/serial/si4455.c
index 15f45f19ffdb..4f74b1e1a36f 100644
--- a/drivers/staging/si4455/si4455.c
+++ b/drivers/tty/serial/si4455.c
@@ -22,7 +22,7 @@
 #include "si4455_api.h"
 
 #define PORT_SI4455						1096
-#define SI4455_NAME						"si4455"
+#define SI4455_NAME						"Si4455"
 #define SI4455_MAJOR						432
 #define SI4455_MINOR						567
 #define SI4455_UART_NRMAX					1
@@ -43,80 +43,80 @@
 #define SI4455_CMD_ID_WRITE_TX_FIFO				0x66
 #define SI4455_CMD_ID_START_RX					0x32
 #define SI4455_CMD_ARG_COUNT_START_RX				8
-#define SI4455_CMD_START_RX_ARG_RXTIMEOUT_STATE_ENUM_RX		8
-#define SI4455_CMD_START_RX_ARG_RXVALID_STATE_ENUM_RX		8
-#define SI4455_CMD_START_RX_ARG_RXINVALID_STATE_ENUM_RX		8
+#define SI4455_CMD_START_RX_RXTIMEOUT_STATE_RX			8
+#define SI4455_CMD_START_RX_RXVALID_STATE_RX			8
+#define SI4455_CMD_START_RX_RXINVALID_STATE_RX			8
 #define SI4455_CMD_ID_START_TX					0x31
 #define SI4455_CMD_ARG_COUNT_START_TX				5
 #define SI4455_CMD_ID_CHANGE_STATE				0x34
 #define SI4455_CMD_ARG_COUNT_CHANGE_STATE			2
-#define SI4455_CMD_CHANGE_STATE_ARG_NEW_STATE_ENUM_READY	3
-#define SI4455_CMD_GET_CHIP_STATUS_REP_CMD_ERROR_PEND_MASK	0x08
-#define SI4455_CMD_GET_CHIP_STATUS_REP_CMD_ERROR_PEND_BIT	0x08
-#define SI4455_CMD_GET_INT_STATUS_REP_PACKET_SENT_PEND_BIT	0x20
-#define SI4455_CMD_GET_INT_STATUS_REP_PACKET_RX_PEND_BIT	0x10
-#define SI4455_CMD_GET_INT_STATUS_REP_CRC_ERROR_BIT		0x08
+#define SI4455_CMD_CHANGE_STATE_STATE_READY			3
+#define SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_MASK		0x08
+#define SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_BIT		0x08
+#define SI4455_CMD_GET_INT_STATUS_PACKET_SENT_PEND_BIT		0x20
+#define SI4455_CMD_GET_INT_STATUS_PACKET_RX_PEND_BIT		0x10
+#define SI4455_CMD_GET_INT_STATUS_CRC_ERROR_BIT			0x08
 #define SI4455_CMD_ID_GET_MODEM_STATUS				0x22
 #define SI4455_CMD_ARG_COUNT_GET_MODEM_STATUS			2
 #define SI4455_CMD_REPLY_COUNT_GET_MODEM_STATUS			8
 
 struct si4455_part_info {
-	u8				CHIPREV;
-	u16				PART;
-	u8				PBUILD;
-	u16				ID;
-	u8				CUSTOMER;
-	u8				ROMID;
-	u8				BOND;
+	u8 CHIPREV;
+	u16 PART;
+	u8 PBUILD;
+	u16 ID;
+	u8 CUSTOMER;
+	u8 ROMID;
+	u8 BOND;
 };
 
 struct si4455_int_status {
-	u8				INT_PEND;
-	u8				INT_STATUS;
-	u8				PH_PEND;
-	u8				PH_STATUS;
-	u8				MODEM_PEND;
-	u8				MODEM_STATUS;
-	u8				CHIP_PEND;
-	u8				CHIP_STATUS;
+	u8 INT_PEND;
+	u8 INT_STATUS;
+	u8 PH_PEND;
+	u8 PH_STATUS;
+	u8 MODEM_PEND;
+	u8 MODEM_STATUS;
+	u8 CHIP_PEND;
+	u8 CHIP_STATUS;
 };
 
 struct si4455_modem_status {
-	u8				MODEM_PEND;
-	u8				MODEM_STATUS;
-	u8				CURR_RSSI;
-	u8				LATCH_RSSI;
-	u8				ANT1_RSSI;
-	u8				ANT2_RSSI;
-	u16			AFC_FREQ_OFFSET;
+	u8 MODEM_PEND;
+	u8 MODEM_STATUS;
+	u8 CURR_RSSI;
+	u8 LATCH_RSSI;
+	u8 ANT1_RSSI;
+	u8 ANT2_RSSI;
+	u16 AFC_FREQ_OFFSET;
 };
 
 struct si4455_fifo_info {
-	u8				RX_FIFO_COUNT;
-	u8				TX_FIFO_SPACE;
+	u8 RX_FIFO_COUNT;
+	u8 TX_FIFO_SPACE;
 };
 
 struct si4455_one {
-	struct uart_port		port;
-	struct work_struct		tx_work;
+	struct uart_port port;
+	struct work_struct tx_work;
 };
 
 struct si4455_port {
-	struct mutex			mutex;
-	int				power_count;
-	struct gpio_desc		*shdn_gpio;
-	struct si4455_part_info		part_info;
-	struct si4455_modem_status	modem_status;
-	struct si4455_iocbuff		configuration;
-	struct si4455_iocbuff		patch;
-	u32				tx_channel;
-	u32				rx_channel;
-	u32				package_size;
-	bool				configured;
-	bool				tx_pending;
-	bool				rx_pending;
-	u32				current_rssi;
-	struct si4455_one		one;
+	struct mutex mutex; /* For syncing access to device */
+	int power_count;
+	struct gpio_desc *shdn_gpio;
+	struct si4455_part_info part_info;
+	struct si4455_modem_status modem_status;
+	struct si4455_iocbuff configuration;
+	struct si4455_iocbuff patch;
+	u32 tx_channel;
+	u32 rx_channel;
+	u32 package_size;
+	bool configured;
+	bool tx_pending;
+	bool rx_pending;
+	u32 current_rssi;
+	struct si4455_one one;
 };
 
 static struct uart_driver si4455_uart = {
@@ -132,81 +132,60 @@ static struct uart_driver si4455_uart = {
 	.nr			= SI4455_UART_NRMAX,
 };
 
-static int si4455_get_response(struct uart_port *port,
-				int length,
-				u8 *data);
-static int si4455_send_command(struct uart_port *port,
-				int length,
-				u8 *data);
-static int si4455_send_command_get_response(struct uart_port *port,
-						int outLength,
-						u8 *outData,
-						int inLength,
-						u8 *inData);
-static int si4455_read_data(struct uart_port *port,
-				u8 command,
-				int pollCts,
-				int length,
-				u8 *data);
-static int si4455_write_data(struct uart_port *port,
-				u8 command,
-				int pollCts,
-				int length,
-				u8 *data);
-static int si4455_poll_cts(struct uart_port *port);
-static void si4455_set_power(struct si4455_port *priv,
-				int on);
-static int si4455_get_part_info(struct uart_port *port,
-				struct si4455_part_info *result);
-
 static int si4455_get_response(struct uart_port *port,
 				int length,
 				u8 *data)
 {
-	int ret = -EIO;
-	u8 dataOut[] = { SI4455_CMD_ID_READ_CMD_BUFF };
-	u8 *dataIn = devm_kzalloc(port->dev, 1 + length, GFP_KERNEL);
-	struct spi_transfer xfer[] = {
-		{
-			.tx_buf = dataOut,
-			.len = sizeof(dataOut),
-		}, {
-			.rx_buf = dataIn,
-			.len = 1 + length,
-		}
-	};
-	int errCnt = 10000;
+	int ret;
+	u8 data_out[] = { SI4455_CMD_ID_READ_CMD_BUFF };
+	u8 *data_in = NULL;
+	struct spi_transfer xfer[2];
+	int err = 10000;
 
-	while (errCnt > 0) {
-		dataOut[0] = SI4455_CMD_ID_READ_CMD_BUFF;
+	data_in = kzalloc(1 + length, GFP_KERNEL);
+	if (!data_in)
+		return -ENOMEM;
+
+	memset(&xfer, 0x00, sizeof(xfer));
+	xfer[0].tx_buf = data_out;
+	xfer[0].len = sizeof(data_out);
+	xfer[1].rx_buf = data_in;
+	xfer[1].len = 1 + length;
+
+	while (--err > 0) {
+		data_out[0] = SI4455_CMD_ID_READ_CMD_BUFF;
 		ret = spi_sync_transfer(to_spi_device(port->dev),
 					xfer,
 					ARRAY_SIZE(xfer));
-		if (ret == 0) {
-			if (dataIn[0] == 0xFF) {
-				if ((length > 0) && (data != NULL)) {
-					memcpy(data, &dataIn[1], length);
-				} else {
-					if (length > 0)
-						ret = -EINVAL;
-				}
-				break;
+		if (ret) {
+			dev_err(port->dev, "%s: spi_sync_transfer error(%i)", __func__, ret);
+			break;
+		}
+
+		if (data_in[0] == 0xFF) {
+			if (length > 0 && data) {
+				memcpy(data, &data_in[1], length);
+			} else {
+				if (length > 0)
+					ret = -EINVAL;
 			}
-			usleep_range(100, 200);
-		} else {
 			break;
 		}
-		errCnt--;
+		usleep_range(100, 200);
 	}
-	if (errCnt == 0) {
-		dev_err(port->dev, "si4455_poll_cts:errCnt==%i", errCnt);
+	if (err == 0) {
+		dev_err(port->dev, "%s:err==%i", __func__, err);
 		ret = -EIO;
 	}
-	if (dataIn != NULL)
-		devm_kfree(port->dev, dataIn);
+	kfree(data_in);
 	return ret;
 }
 
+static int si4455_poll_cts(struct uart_port *port)
+{
+	return si4455_get_response(port, 0, NULL);
+}
+
 static int si4455_send_command(struct uart_port *port,
 				int length,
 				u8 *data)
@@ -214,134 +193,118 @@ static int si4455_send_command(struct uart_port *port,
 	int ret;
 
 	ret = si4455_poll_cts(port);
-	if (ret == 0) {
-		ret = spi_write(to_spi_device(port->dev), data, length);
-		if (ret) {
-			dev_err(port->dev,
-				"%s: spi_write error(%i)",
-				__func__,
-				ret);
-		}
-	} else {
-		dev_err(port->dev,
-			"%s: si4455_poll_cts error(%i)",
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_poll_cts error(%i)",
 			__func__,
 			ret);
+		return ret;
+	}
+	ret = spi_write(to_spi_device(port->dev), data, length);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: spi_write error(%i)", __func__, ret);
 	}
 	return ret;
 }
 
 static int si4455_send_command_get_response(struct uart_port *port,
-						int outLength,
-						u8 *outData,
-						int inLength,
-						u8 *inData)
+						int out_length,
+						u8 *data_out,
+						int in_length,
+						u8 *data_in)
 {
 	int ret;
 
-	ret = si4455_send_command(port, outLength, outData);
-	if (!ret) {
-		ret = si4455_get_response(port, inLength, inData);
-	} else {
-		dev_err(port->dev,
-			"%s: si4455_send_command error(%i)",
-			__func__,
-			ret);
+	ret = si4455_send_command(port, out_length, data_out);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_send_command error(%i)",
+			__func__, ret);
+		return ret;
 	}
+
+	ret = si4455_get_response(port, in_length, data_in);
+
 	return ret;
 }
 
 static int si4455_read_data(struct uart_port *port,
 				u8 command,
-				int pollCts,
+				int poll,
 				int length,
 				u8 *data)
 {
 	int ret = 0;
-	u8 dataOut[] = { command };
+	u8 data_out[] = { command };
 	struct spi_transfer xfer[] = {
 		{
-			.tx_buf = dataOut,
-			.len = sizeof(dataOut),
+			.tx_buf = data_out,
+			.len = sizeof(data_out),
 		}, {
 			.rx_buf = data,
 			.len = length,
 		}
 	};
 
-	if (pollCts)
+	if (poll) {
 		ret = si4455_poll_cts(port);
+		if (ret)
+			return ret;
+	}
 
-	if (ret == 0) {
-		ret = spi_sync_transfer(to_spi_device(port->dev),
-					xfer,
-					ARRAY_SIZE(xfer));
-		if (ret) {
-			dev_err(port->dev,
-				"%s: spi_sync_transfer error(%i)",
-				__func__,
-				ret);
-		}
+	ret = spi_sync_transfer(to_spi_device(port->dev),
+				xfer,
+				ARRAY_SIZE(xfer));
+	if (ret) {
+		dev_err(port->dev, "%s: spi_sync_transfer error(%i)",
+			__func__,
+			ret);
 	}
 	return ret;
 }
 
 static int si4455_write_data(struct uart_port *port,
 				u8 command,
-				int pollCts,
+				int poll,
 				int length,
 				u8 *data)
 {
 	int ret = 0;
-	u8 *dataOut = NULL;
+	u8 *data_out;
 
-	if (pollCts)
+	if (poll) {
 		ret = si4455_poll_cts(port);
+		if (ret)
+			return ret;
+	}
 
-	if (ret == 0) {
-		dataOut = devm_kzalloc(port->dev, 1 + length, GFP_KERNEL);
-		if (dataOut != NULL) {
-			dataOut[0] = command;
-			memcpy(&dataOut[1], data, length);
-			ret = spi_write(to_spi_device(port->dev),
-					dataOut,
-					1 + length);
-			if (ret) {
-				dev_err(port->dev,
-					"%s: spi_write error(%i)",
-					__func__,
-					ret);
-			}
-		} else {
-			dev_err(port->dev,
-				"%s: devm_kzalloc error",
-				__func__);
-			ret = -ENOMEM;
-		}
+	data_out = kzalloc(1 + length, GFP_KERNEL);
+	if (!data_out)
+		return -ENOMEM;
+
+	data_out[0] = command;
+	memcpy(&data_out[1], data, length);
+	ret = spi_write(to_spi_device(port->dev), data_out, 1 + length);
+	if (ret) {
+		dev_err(port->dev, "%s: spi_write error(%i)",
+			__func__, ret);
 	}
-	if (dataOut != NULL)
-		devm_kfree(port->dev, dataOut);
+	kfree(data_out);
 
 	return ret;
 }
 
-static int si4455_poll_cts(struct uart_port *port)
-{
-	return si4455_get_response(port, 0, NULL);
-}
-
 static void si4455_set_power(struct si4455_port *priv,
 				int on)
 {
-	if (priv->shdn_gpio) {
-		if (on) {
-			gpiod_direction_output(priv->shdn_gpio, 0);
-			usleep_range(4000, 5000);
-			gpiod_set_value(priv->shdn_gpio, 1);
-			usleep_range(4000, 5000);
-		} else {
-			gpiod_direction_output(priv->shdn_gpio, 0);
-		}
+	if (!priv->shdn_gpio)
+		return;
+	if (on) {
+		gpiod_direction_output(priv->shdn_gpio, 0);
+		usleep_range(4000, 5000);
+		gpiod_set_value(priv->shdn_gpio, 1);
+		usleep_range(4000, 5000);
+	} else {
+		gpiod_direction_output(priv->shdn_gpio, 0);
 	}
 }
 
@@ -363,27 +326,23 @@ static int si4455_get_part_info(struct uart_port *port,
 				struct si4455_part_info *result)
 {
 	int ret;
-	u8 dataOut[] = { SI4455_CMD_ID_PART_INFO };
-	u8 dataIn[SI4455_CMD_REPLY_COUNT_PART_INFO];
-
-	ret = si4455_send_command_get_response(port,
-						sizeof(dataOut),
-						dataOut,
-						sizeof(dataIn),
-						dataIn);
-	if (ret == 0) {
-		result->CHIPREV = dataIn[0];
-		memcpy(&result->PART, &dataIn[1], sizeof(result->PART));
-		result->PBUILD = dataIn[3];
-		memcpy(&result->ID, &dataIn[4], sizeof(result->ID));
-		result->CUSTOMER = dataIn[6];
-		result->ROMID = dataIn[7];
-		result->BOND = dataIn[8];
-	} else {
+	u8 data_out[] = { SI4455_CMD_ID_PART_INFO };
+	u8 data_in[SI4455_CMD_REPLY_COUNT_PART_INFO];
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
 		dev_err(port->dev,
 			"%s: si4455_send_command_get_response error(%i)",
-			__func__,
-			ret);
+			__func__, ret);
+	} else {
+		result->CHIPREV = data_in[0];
+		memcpy(&result->PART, &data_in[1], sizeof(result->PART));
+		result->PBUILD = data_in[3];
+		memcpy(&result->ID, &data_in[4], sizeof(result->ID));
+		result->CUSTOMER = data_in[6];
+		result->ROMID = data_in[7];
+		result->BOND = data_in[8];
 	}
 	return ret;
 }
@@ -395,33 +354,29 @@ static int si4455_get_int_status(struct uart_port *port,
 					struct si4455_int_status *result)
 {
 	int ret;
-	u8 dataOut[] = {
+	u8 data_out[] = {
 		SI4455_CMD_ID_GET_INT_STATUS,
 		phClear,
 		modemClear,
 		chipClear
 	};
-	u8 dataIn[SI4455_CMD_REPLY_COUNT_GET_INT_STATUS];
+	u8 data_in[SI4455_CMD_REPLY_COUNT_GET_INT_STATUS];
 
-	ret = si4455_send_command_get_response(port,
-						sizeof(dataOut),
-						dataOut,
-						sizeof(dataIn),
-						dataIn);
-	if (ret == 0) {
-		result->INT_PEND       = dataIn[0];
-		result->INT_STATUS     = dataIn[1];
-		result->PH_PEND        = dataIn[2];
-		result->PH_STATUS      = dataIn[3];
-		result->MODEM_PEND     = dataIn[4];
-		result->MODEM_STATUS   = dataIn[5];
-		result->CHIP_PEND      = dataIn[6];
-		result->CHIP_STATUS    = dataIn[7];
-	} else {
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
 		dev_err(port->dev,
 			"%s: si4455_send_command_get_response error(%i)",
-			__func__,
-			ret);
+			__func__, ret);
+	} else {
+		result->INT_PEND       = data_in[0];
+		result->INT_STATUS     = data_in[1];
+		result->PH_PEND        = data_in[2];
+		result->PH_STATUS      = data_in[3];
+		result->MODEM_PEND     = data_in[4];
+		result->MODEM_STATUS   = data_in[5];
+		result->CHIP_PEND      = data_in[6];
+		result->CHIP_STATUS    = data_in[7];
 	}
 	return ret;
 }
@@ -431,32 +386,27 @@ static int si4455_get_modem_status(struct uart_port *port,
 					struct si4455_modem_status *result)
 {
 	int ret;
-	u8 dataOut[] = {
+	u8 data_out[] = {
 		SI4455_CMD_ID_GET_MODEM_STATUS,
 		modemClear,
 	};
-	u8 dataIn[SI4455_CMD_REPLY_COUNT_GET_MODEM_STATUS];
+	u8 data_in[SI4455_CMD_REPLY_COUNT_GET_MODEM_STATUS];
 
-	ret = si4455_send_command_get_response(port,
-						sizeof(dataOut),
-						dataOut,
-						sizeof(dataIn),
-						dataIn);
-	if (ret == 0) {
-		result->MODEM_PEND      = dataIn[0];
-		result->MODEM_STATUS    = dataIn[1];
-		result->CURR_RSSI       = dataIn[2];
-		result->LATCH_RSSI      = dataIn[3];
-		result->ANT1_RSSI       = dataIn[4];
-		result->ANT2_RSSI       = dataIn[5];
-		memcpy(&result->AFC_FREQ_OFFSET,
-			&dataIn[6],
-			sizeof(result->AFC_FREQ_OFFSET));
-	} else {
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
 		dev_err(port->dev,
 			"%s: si4455_send_command_get_response error(%i)",
-			__func__,
-			ret);
+			__func__, ret);
+	} else {
+		result->MODEM_PEND      = data_in[0];
+		result->MODEM_STATUS    = data_in[1];
+		result->CURR_RSSI       = data_in[2];
+		result->LATCH_RSSI      = data_in[3];
+		result->ANT1_RSSI       = data_in[4];
+		result->ANT2_RSSI       = data_in[5];
+		memcpy(&result->AFC_FREQ_OFFSET,
+		       &data_in[6], sizeof(result->AFC_FREQ_OFFSET));
 	}
 	return ret;
 }
@@ -465,25 +415,21 @@ static int si4455_fifo_info(struct uart_port *port,
 				u8 fifo,
 				struct si4455_fifo_info *result)
 {
-	int ret = 0;
-	u8 dataOut[SI4455_CMD_ARG_COUNT_FIFO_INFO] = {
+	int ret;
+	u8 data_out[SI4455_CMD_ARG_COUNT_FIFO_INFO] = {
 		SI4455_CMD_ID_FIFO_INFO, fifo
 	};
-	u8 dataIn[SI4455_CMD_REPLY_COUNT_FIFO_INFO] = { 0 };
+	u8 data_in[SI4455_CMD_REPLY_COUNT_FIFO_INFO] = { 0 };
 
-	ret = si4455_send_command_get_response(port,
-						sizeof(dataOut),
-						dataOut,
-						sizeof(dataIn),
-						dataIn);
-	if (ret == 0) {
-		result->RX_FIFO_COUNT  = dataIn[0];
-		result->TX_FIFO_SPACE  = dataIn[1];
-	} else {
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
 		dev_err(port->dev,
 			"%s: si4455_send_command_get_response error(%i)",
-			__func__,
-			ret);
+			__func__, ret);
+	} else {
+		result->RX_FIFO_COUNT  = data_in[0];
+		result->TX_FIFO_SPACE  = data_in[1];
 	}
 	return ret;
 }
@@ -492,10 +438,7 @@ static int si4455_read_rx_fifo(struct uart_port *port,
 				int length,
 				u8 *data)
 {
-	return si4455_read_data(port,
-				SI4455_CMD_ID_READ_RX_FIFO,
-				0,
-				length,
+	return si4455_read_data(port, SI4455_CMD_ID_READ_RX_FIFO, 0, length,
 				data);
 }
 
@@ -503,35 +446,31 @@ static int si4455_write_tx_fifo(struct uart_port *port,
 				int length,
 				u8 *data)
 {
-	return si4455_write_data(port,
-					SI4455_CMD_ID_WRITE_TX_FIFO,
-					0,
-					length,
-					data);
+	return si4455_write_data(port, SI4455_CMD_ID_WRITE_TX_FIFO, 0, length,
+				data);
 }
 
 static int si4455_rx(struct uart_port *port,
 			u32 channel,
 			u8 condition,
 			u16 length,
-			u8 nextState1,
-			u8 nextState2,
-			u8 nextState3)
+			u8 next_state1,
+			u8 next_state2,
+			u8 next_state3)
 {
-	u8 dataOut[SI4455_CMD_ARG_COUNT_START_RX];
-
-	dataOut[0] = SI4455_CMD_ID_START_RX;
-	dataOut[1] = channel;
-	dataOut[2] = condition;
-	dataOut[3] = (u8)(length >> 8);
-	dataOut[4] = (u8)(length);
-	dataOut[5] = nextState1;
-	dataOut[6] = nextState2;
-	dataOut[7] = nextState3;
-
-	return si4455_send_command(port,
-					SI4455_CMD_ARG_COUNT_START_RX,
-					dataOut);
+	u8 data_out[SI4455_CMD_ARG_COUNT_START_RX];
+
+	data_out[0] = SI4455_CMD_ID_START_RX;
+	data_out[1] = channel;
+	data_out[2] = condition;
+	data_out[3] = (u8)(length >> 8);
+	data_out[4] = (u8)(length);
+	data_out[5] = next_state1;
+	data_out[6] = next_state2;
+	data_out[7] = next_state3;
+
+	return si4455_send_command(port, SI4455_CMD_ARG_COUNT_START_RX,
+					data_out);
 }
 
 static int si4455_tx(struct uart_port *port,
@@ -539,31 +478,29 @@ static int si4455_tx(struct uart_port *port,
 			u8 condition,
 			u16 length)
 {
-	u8 dataOut[/*6*/ SI4455_CMD_ARG_COUNT_START_TX];
-
-	dataOut[0] = SI4455_CMD_ID_START_TX;
-	dataOut[1] = channel;
-	dataOut[2] = condition;
-	dataOut[3] = (u8)(length >> 8);
-	dataOut[4] = (u8)(length);
-	/*TODO: radioCmd[5] = 0x44; in case of rev c2a*/
-
-	return si4455_send_command(port,
-					/*6*/ SI4455_CMD_ARG_COUNT_START_TX,
-					dataOut);
+	u8 data_out[/*6*/ SI4455_CMD_ARG_COUNT_START_TX];
+
+	data_out[0] = SI4455_CMD_ID_START_TX;
+	data_out[1] = channel;
+	data_out[2] = condition;
+	data_out[3] = (u8)(length >> 8);
+	data_out[4] = (u8)(length);
+	/*TODO: data_out[5] = 0x44; in case of rev c2a*/
+
+	return si4455_send_command(port, /*6*/ SI4455_CMD_ARG_COUNT_START_TX,
+					data_out);
 }
 
 static int si4455_change_state(struct uart_port *port,
-				u8 nextState1)
+				u8 next_state1)
 {
-	u8 dataOut[SI4455_CMD_ARG_COUNT_CHANGE_STATE];
+	u8 data_out[SI4455_CMD_ARG_COUNT_CHANGE_STATE];
 
-	dataOut[0] = SI4455_CMD_ID_CHANGE_STATE;
-	dataOut[1] = (u8)nextState1;
+	data_out[0] = SI4455_CMD_ID_CHANGE_STATE;
+	data_out[1] = (u8)next_state1;
 
-	return si4455_send_command(port,
-					SI4455_CMD_ARG_COUNT_CHANGE_STATE,
-					dataOut);
+	return si4455_send_command(port, SI4455_CMD_ARG_COUNT_CHANGE_STATE,
+					data_out);
 }
 
 static int si4455_begin_tx(struct uart_port *port,
@@ -572,88 +509,66 @@ static int si4455_begin_tx(struct uart_port *port,
 				u8 *data)
 {
 	int ret = 0;
-	struct si4455_int_status intStatus = { 0 };
-	struct si4455_fifo_info fifoInfo = { 0 };
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
 
 	dev_dbg(port->dev, "%s(%u, %u)", __func__, channel, length);
 	if ((length > SI4455_FIFO_SIZE) || (length < 0))
-		ret = -EINVAL;
+		return -EINVAL;
 
-	if (ret == 0) {
-		ret = si4455_change_state(port,
-			SI4455_CMD_CHANGE_STATE_ARG_NEW_STATE_ENUM_READY);
-		if (ret) {
-			dev_err(port->dev,
-				"%s: si4455_change_state error(%i)",
-				__func__,
-				ret);
-			goto end;
-		}
-		ret = si4455_get_int_status(port, 0, 0, 0, &intStatus);
-		if (ret) {
-			dev_err(port->dev,
-				"%s: si4455_get_int_status error(%i)",
-				__func__,
-				ret);
-			goto end;
-		}
-		ret = si4455_fifo_info(port,
-					SI4455_CMD_FIFO_INFO_ARG_TX_BIT,
-					&fifoInfo);
-		if (ret) {
-			dev_err(port->dev,
-				"%s: si4455_fifo_info error(%i)",
-				__func__,
-				ret);
-			goto end;
-		}
-		ret = si4455_write_tx_fifo(port, (u16)length, data);
-		if (ret) {
-			dev_err(port->dev,
-				"%s: si4455_write_tx_fifo error(%i)",
-				__func__,
-				ret);
-			goto end;
-		}
-		ret = si4455_tx(port,
-				(u8)channel,
-				0x30,
-				(u16)length);
-		if (ret) {
-			dev_err(port->dev,
-				"%s: si4455_tx error(%i)",
-				__func__,
-				ret);
-			goto end;
-		}
+	ret = si4455_change_state(port,
+				  SI4455_CMD_CHANGE_STATE_STATE_READY);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_change_state error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_get_int_status error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_fifo_info(port,
+			       SI4455_CMD_FIFO_INFO_ARG_TX_BIT, &fifo_info);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_fifo_info error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_write_tx_fifo(port, (u16)length, data);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_write_tx_fifo error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_tx(port, channel, 0x30, length);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_tx error(%i)",
+			__func__, ret);
+		return ret;
 	}
-end:
 	return ret;
 }
 
 static int si4455_end_tx(struct uart_port *port)
 {
 	int ret = 0;
-	struct si4455_int_status intStatus = { 0 };
+	struct si4455_int_status int_status = { 0 };
 
 	ret = si4455_change_state(port,
-			SI4455_CMD_CHANGE_STATE_ARG_NEW_STATE_ENUM_READY);
+				  SI4455_CMD_CHANGE_STATE_STATE_READY);
 	if (ret) {
-		dev_err(port->dev,
-			"%s: si4455_change_state error(%i)",
-			__func__,
-			ret);
-		goto end;
+		dev_err(port->dev, "%s: si4455_change_state error(%i)",
+			__func__, ret);
+		return ret;
 	}
-	ret = si4455_get_int_status(port, 0, 0, 0, &intStatus);
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
 	if (ret) {
-		dev_err(port->dev,
-			"%s: si4455_get_int_status error(%i)",
-			__func__,
-			ret);
-		goto end;
+		dev_err(port->dev, "%s: si4455_get_int_status error(%i)",
+			__func__, ret);
+		return ret;
 	}
-end:
 	return ret;
 }
 
@@ -662,43 +577,36 @@ static int si4455_begin_rx(struct uart_port *port,
 				u32 length)
 {
 	int ret = 0;
-	struct si4455_int_status intStatus = { 0 };
-	struct si4455_fifo_info fifoInfo = { 0 };
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
 
 	dev_dbg(port->dev, "%s(%u, %u)", __func__, channel, length);
-	ret = si4455_get_int_status(port, 0, 0, 0, &intStatus);
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
 	if (ret) {
-		dev_err(port->dev,
-			"%s: si4455_get_int_status error(%i)",
-			__func__,
-			ret);
-		goto end;
+		dev_err(port->dev, "%s: si4455_get_int_status error(%i)",
+			__func__, ret);
+		return ret;
 	}
 	ret = si4455_fifo_info(port,
 				SI4455_CMD_FIFO_INFO_ARG_RX_BIT,
-				&fifoInfo);
+				&fifo_info);
 	if (ret) {
-		dev_err(port->dev,
-			"%s: si4455_fifo_info error(%i)",
-			__func__,
-			ret);
-		goto end;
+		dev_err(port->dev, "%s: si4455_fifo_info error(%i)",
+			__func__, ret);
+		return ret;
 	}
 	ret = si4455_rx(port,
 			channel,
 			0x00,
 			length,
-			SI4455_CMD_START_RX_ARG_RXTIMEOUT_STATE_ENUM_RX,
-			SI4455_CMD_START_RX_ARG_RXVALID_STATE_ENUM_RX,
-			SI4455_CMD_START_RX_ARG_RXINVALID_STATE_ENUM_RX);
+			SI4455_CMD_START_RX_RXTIMEOUT_STATE_RX,
+			SI4455_CMD_START_RX_RXVALID_STATE_RX,
+			SI4455_CMD_START_RX_RXINVALID_STATE_RX);
 	if (ret) {
-		dev_err(port->dev,
-			"%s: si4455_rx error(%i)",
-			__func__,
-			ret);
-		goto end;
+		dev_err(port->dev, "%s: si4455_rx error(%i)",
+			__func__, ret);
+		return ret;
 	}
-end:
 	return ret;
 }
 
@@ -710,59 +618,53 @@ static int si4455_end_rx(struct uart_port *port,
 }
 
 static int si4455_configure(struct uart_port *port,
-				u8 *configurationData)
+				u8 *configuration_data)
 {
 	int ret = 0;
 	u8 col;
 	u8 response;
-	u8 numOfBytes;
-	struct si4455_int_status intStatus = { 0 };
-	u8 radioCmd[16u];
+	u8 count;
+	struct si4455_int_status int_status = { 0 };
+	u8 radio_cmd[16u];
 
 	/* While cycle as far as the pointer points to a command */
-	while (*configurationData != 0x00) {
+	while (*configuration_data != 0x00) {
 		/* Commands structure in the array:
 		 * --------------------------------
 		 * LEN | <LEN length of data>
 		 */
-		numOfBytes = *configurationData++;
-		dev_dbg(port->dev,
-			"%s: numOfBytes(%u)",
-			__func__,
-			numOfBytes);
-		if (numOfBytes > 16u) {
+		count = *configuration_data++;
+		dev_dbg(port->dev, "%s: count(%u)",
+			__func__, count);
+		if (count > 16u) {
 			/* Initial configuration of Si4x55 */
 			if (SI4455_CMD_ID_WRITE_TX_FIFO
-				 == *configurationData) {
-				if (numOfBytes > 128u) {
+				 == *configuration_data) {
+				if (count > 128u) {
 					/* Number of command bytes exceeds
 					 * maximal allowable length
 					 */
-					dev_err(port->dev,
-						"%s: command length error(%i)",
-						__func__,
-						numOfBytes);
+					dev_err(port->dev, "%s: command length error(%i)",
+						__func__, count);
 					ret = -EINVAL;
 					break;
 				}
 
 				/* Load array to the device */
-				configurationData++;
+				configuration_data++;
 				ret = si4455_write_data(port,
 						SI4455_CMD_ID_WRITE_TX_FIFO,
 						1,
-						numOfBytes - 1,
-						configurationData);
+						count - 1,
+						configuration_data);
 				if (ret) {
-					dev_err(port->dev,
-						"%s: si4455_write_data error(%i)",
-						__func__,
-						ret);
+					dev_err(port->dev, "%s: si4455_write_data error(%i)",
+						__func__, ret);
 					break;
 				}
 
 				/* Point to the next command */
-				configurationData += numOfBytes - 1;
+				configuration_data += count - 1;
 
 				/* Continue command interpreter */
 				continue;
@@ -775,52 +677,41 @@ static int si4455_configure(struct uart_port *port,
 			}
 		}
 
-		for (col = 0u; col < numOfBytes; col++) {
-			radioCmd[col] = *configurationData;
-			configurationData++;
+		for (col = 0u; col < count; col++) {
+			radio_cmd[col] = *configuration_data;
+			configuration_data++;
 		}
 
-		dev_dbg(port->dev,
-			"%s: radioCmd[0](%u)",
-			__func__,
-			radioCmd[0]);
-		ret = si4455_send_command_get_response(port,
-							numOfBytes,
-							radioCmd,
-							1,
-							&response);
+		dev_dbg(port->dev, "%s: radio_cmd[0](%u)", __func__, radio_cmd[0]);
+		ret = si4455_send_command_get_response(port, count, radio_cmd,
+						       1, &response);
 		if (ret) {
 			dev_err(port->dev,
 				"%s: si4455_send_command_get_response error(%i)",
-				__func__,
-				ret);
+				__func__, ret);
 			break;
 		}
 
 		/* Check response byte of EZCONFIG_CHECK command */
-		if (radioCmd[0] == SI4455_CMD_ID_EZCONFIG_CHECK) {
+		if (radio_cmd[0] == SI4455_CMD_ID_EZCONFIG_CHECK) {
 			if (response) {
 				/* Number of command bytes exceeds
 				 * maximal allowable length
 				 */
 				ret = -EIO;
-				dev_err(port->dev,
-					"%s: EZConfig check error(%i)",
-					__func__,
-					radioCmd[0]);
+				dev_err(port->dev, "%s: EZConfig check error(%i)",
+					__func__, radio_cmd[0]);
 				break;
 			}
 		}
 
 		/* Get and clear all interrupts.  An error has occurred... */
-		si4455_get_int_status(port, 0, 0, 0, &intStatus);
-		if (intStatus.CHIP_PEND
-			& SI4455_CMD_GET_CHIP_STATUS_REP_CMD_ERROR_PEND_MASK) {
+		si4455_get_int_status(port, 0, 0, 0, &int_status);
+		if (int_status.CHIP_PEND
+			& SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_MASK) {
 			ret = -EIO;
-			dev_err(port->dev,
-				"%s: chip error(%i)",
-				__func__,
-				intStatus.CHIP_PEND);
+			dev_err(port->dev, "%s: chip error(%i)",
+				__func__, int_status.CHIP_PEND);
 			break;
 		}
 	}
@@ -969,34 +860,34 @@ static irqreturn_t si4455_port_irq(struct si4455_port *s)
 {
 	struct uart_port *port = &s->one.port;
 	irqreturn_t ret = IRQ_NONE;
-	struct si4455_int_status intStatus = { 0 };
-	struct si4455_fifo_info fifoInfo = { 0 };
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
 
 	mutex_lock(&s->mutex);
 	if (s->configured && (s->power_count > 0)) {
-		if (!si4455_get_int_status(port, 0, 0, 0, &intStatus)) {
+		if (!si4455_get_int_status(port, 0, 0, 0, &int_status)) {
 			si4455_get_modem_status(port, 0, &s->modem_status);
-			if (intStatus.CHIP_PEND
-			& SI4455_CMD_GET_CHIP_STATUS_REP_CMD_ERROR_PEND_BIT) {
+			if (int_status.CHIP_PEND
+			    & SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_BIT) {
 				dev_err(port->dev,
 					"%s: CHIP_STATUS:CMD_ERROR_PEND",
 					__func__);
-			} else if (intStatus.PH_PEND
-			& SI4455_CMD_GET_INT_STATUS_REP_PACKET_SENT_PEND_BIT) {
+			} else if (int_status.PH_PEND
+				   & SI4455_CMD_GET_INT_STATUS_PACKET_SENT_PEND_BIT) {
 				dev_dbg(port->dev,
 					"%s: PH_STATUS:PACKET_SENT_PEND",
 					__func__);
 				si4455_handle_tx_pend(s);
-			} else if (intStatus.PH_PEND
-			& SI4455_CMD_GET_INT_STATUS_REP_PACKET_RX_PEND_BIT) {
+			} else if (int_status.PH_PEND
+				   & SI4455_CMD_GET_INT_STATUS_PACKET_RX_PEND_BIT) {
 				dev_dbg(port->dev,
 					"%s: PH_STATUS:PACKET_RX_PEND",
 					__func__);
 				s->current_rssi = s->modem_status.CURR_RSSI;
-				si4455_fifo_info(port, 0, &fifoInfo);
+				si4455_fifo_info(port, 0, &fifo_info);
 				si4455_handle_rx_pend(s);
-			} else if (intStatus.PH_PEND
-			& SI4455_CMD_GET_INT_STATUS_REP_CRC_ERROR_BIT) {
+			} else if (int_status.PH_PEND
+				   & SI4455_CMD_GET_INT_STATUS_CRC_ERROR_BIT) {
 				dev_dbg(port->dev,
 					"%s: PH_STATUS:CRC_ERROR_PEND",
 					__func__);
@@ -1049,12 +940,6 @@ static void si4455_set_mctrl(struct uart_port *port,
 	dev_dbg(port->dev, "%s", __func__);
 }
 
-static void si4455_break_ctl(struct uart_port *port,
-				int break_state)
-{
-	dev_dbg(port->dev, "%s", __func__);
-}
-
 static void si4455_set_termios(struct uart_port *port,
 				struct ktermios *termios,
 				struct ktermios *old)
@@ -1062,14 +947,6 @@ static void si4455_set_termios(struct uart_port *port,
 	dev_dbg(port->dev, "%s", __func__);
 }
 
-static int si4455_rs485_config(struct uart_port *port,
-				struct serial_rs485 *rs485)
-{
-	dev_dbg(port->dev, "%s", __func__);
-
-	return 0;
-}
-
 static int si4455_startup(struct uart_port *port)
 {
 	dev_dbg(port->dev, "%s", __func__);
@@ -1087,21 +964,14 @@ static const char *si4455_type(struct uart_port *port)
 {
 	struct si4455_port *s = dev_get_drvdata(port->dev);
 
-	if (port->type == PORT_SI4455) {
-		if (s->part_info.ROMID == 3)
-			return "SI4455-B1A";
-		else if (s->part_info.ROMID == 6)
-			return "SI4455-C2A";
-
-	}
-	return NULL;
-}
+	if (port->type != PORT_SI4455)
+		return NULL;
+	if (s->part_info.ROMID == 3)
+		return "SI4455-B1A";
+	else if (s->part_info.ROMID == 6)
+		return "SI4455-C2A";
 
-static int si4455_request_port(struct uart_port *port)
-{
-	/* Do nothing */
-	dev_dbg(port->dev, "%s", __func__);
-	return 0;
+	return "SI4455(UNKNOWN-REV)";
 }
 
 static void si4455_config_port(struct uart_port *port,
@@ -1142,93 +1012,77 @@ static int si4455_ioctl(struct uart_port *port,
 			unsigned long arg)
 {
 	struct si4455_port *s = dev_get_drvdata(port->dev);
+	void __user *argp = (void *)arg;
 	int ret = 0;
 
 	dev_dbg(port->dev, "%s(%u)", __func__, cmd);
 	switch (cmd) {
 	case SI4455_IOC_SEZC:
-	memcpy(&s->configuration, (void *)arg, sizeof(s->configuration));
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_SEZC, length(%i)",
-		__func__,
-		cmd,
-		s->configuration.length);
-	ret = si4455_re_configure(port);
+		ret = copy_from_user(&s->configuration, argp, sizeof(s->configuration));
+		if (ret) {
+			dev_err(port->dev, "%s: SI4455_IOC_SEZC: copy_from_user_error(%i)",
+				__func__, ret);
+			return -EIO;
+		}
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_SEZC, length(%i)",
+			__func__, cmd, s->configuration.length);
+		ret = si4455_re_configure(port);
 	break;
 	case SI4455_IOC_CEZC:
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_CEZC",
-		__func__,
-		cmd);
-	memset(&s->configuration, 0x00, sizeof(s->configuration));
-	ret = si4455_re_configure(port);
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_CEZC",
+			__func__, cmd);
+		memset(&s->configuration, 0x00, sizeof(s->configuration));
+		ret = si4455_re_configure(port);
 	break;
 	case SI4455_IOC_SEZP:
-	memcpy(&s->patch, (void *)arg, sizeof(s->patch));
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_SEZP, length(%i)",
-		__func__,
-		cmd,
-		s->configuration.length);
+		ret = copy_from_user(&s->patch, argp, sizeof(s->patch));
+		if (ret) {
+			dev_err(port->dev, "%s: SI4455_IOC_SEZP: copy_from_user_error(%i)",
+				__func__, ret);
+			return -EIO;
+		}
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_SEZP, length(%i)",
+			__func__, cmd, s->configuration.length);
 	break;
 	case SI4455_IOC_CEZP:
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_CEZP",
-		__func__,
-		cmd);
-	memset(&s->patch, 0x00, sizeof(s->patch));
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_CEZP",
+			__func__, cmd);
+		memset(&s->patch, 0x00, sizeof(s->patch));
 	break;
 	case SI4455_IOC_STXC:
-	s->tx_channel = *((u32 *)arg);
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_STXC, tx_channel(%i)",
-		__func__,
-		cmd,
-		s->tx_channel);
+		s->tx_channel = *((u32 *)arg);
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_STXC, tx_channel(%i)",
+			__func__, cmd, s->tx_channel);
 	break;
 	case SI4455_IOC_GTXC:
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_GTXC",
-		__func__,
-		cmd);
-	*((u32 *)arg) = s->tx_channel;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_GTXC",
+			__func__, cmd);
+		*((u32 *)arg) = s->tx_channel;
 	break;
 	case SI4455_IOC_SRXC:
-	s->rx_channel = *((u32 *)arg);
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_SRXC, rx_channel(%i)",
-		__func__,
-		cmd,
-		s->rx_channel);
+		s->rx_channel = *((u32 *)arg);
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_SRXC, rx_channel(%i)",
+			__func__, cmd, s->rx_channel);
 	break;
 	case SI4455_IOC_GRXC:
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_GRXC",
-		__func__,
-		cmd);
-	*((u32 *)arg) = s->rx_channel;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_GRXC",
+			__func__, cmd);
+		*((u32 *)arg) = s->rx_channel;
 	break;
 	case SI4455_IOC_SSIZ:
-	s->package_size = *((u32 *)arg);
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_SSIZ, package_size(%i)",
-		__func__,
-		cmd,
-		s->package_size);
+		s->package_size = *((u32 *)arg);
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_SSIZ, package_size(%i)",
+			__func__, cmd, s->package_size);
 	break;
 	case SI4455_IOC_GSIZ:
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_GSIZ",
-		__func__,
-		cmd);
-	*((u32 *)arg) = s->package_size;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_GSIZ",
+			__func__, cmd);
+		*((u32 *)arg) = s->package_size;
 	break;
 	case SI4455_IOC_GRSSI:
-	dev_dbg(port->dev,
-		"%s(%u): SI4455_IOC_GRSSI",
-		__func__,
-		cmd);
-	*((u32 *)arg) = s->current_rssi;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_GRSSI",
+			__func__, cmd);
+		*((u32 *)arg) = s->current_rssi;
 	break;
 	default:
 		ret = -ENOIOCTLCMD;
@@ -1249,17 +1103,15 @@ static void si4455_null_void(struct uart_port *port)
 
 static const struct uart_ops si4455_ops = {
 	.tx_empty		= si4455_tx_empty,
-	.set_mctrl		= si4455_set_mctrl,
+	.set_mctrl		= si4455_set_mctrl,/* required */
 	.get_mctrl		= si4455_get_mctrl,
 	.stop_tx		= si4455_null_void,
 	.start_tx		= si4455_start_tx,
 	.stop_rx		= si4455_null_void,
-	.break_ctl		= si4455_break_ctl,
 	.startup		= si4455_startup,
 	.shutdown		= si4455_shutdown,
-	.set_termios		= si4455_set_termios,
+	.set_termios		= si4455_set_termios,/* required */
 	.type			= si4455_type,
-	.request_port		= si4455_request_port,
 	.release_port		= si4455_null_void,
 	.config_port		= si4455_config_port,
 	.verify_port		= si4455_verify_port,
@@ -1302,7 +1154,7 @@ static int si4455_probe(struct device *dev,
 	dev_set_drvdata(dev, s);
 	mutex_init(&s->mutex);
 
-	s->shdn_gpio = devm_gpiod_get(dev, "shdn", GPIOD_OUT_HIGH);
+	s->shdn_gpio = devm_gpiod_get(dev, "shutdown", GPIOD_OUT_HIGH);
 	if (IS_ERR(s->shdn_gpio)) {
 		dev_err(dev, "Unable to reguest shdn gpio\n");
 		ret = -EINVAL;
@@ -1319,7 +1171,7 @@ static int si4455_probe(struct device *dev,
 	s->one.port.iotype	= UPIO_PORT;
 	s->one.port.iobase	= 0x00;
 	s->one.port.membase	= (void __iomem *)~0;
-	s->one.port.rs485_config = si4455_rs485_config;
+	s->one.port.rs485_config = NULL;
 	s->one.port.ops	= &si4455_ops;
 
 	si4455_s_power(dev, 1);
@@ -1389,8 +1241,6 @@ static int si4455_remove(struct device *dev)
 
 static const struct of_device_id __maybe_unused si4455_dt_ids[] = {
 	{ .compatible = "silabs,si4455" },
-	{ .compatible = "silabs,si4455b1a" },
-	{ .compatible = "silabs,si4455c2a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, si4455_dt_ids);
@@ -1462,4 +1312,4 @@ module_exit(si4455_uart_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("József Horváth <info@ministro.hu>");
-MODULE_DESCRIPTION("SI4455 serial driver");
+MODULE_DESCRIPTION("Si4455 serial driver");
diff --git a/drivers/staging/si4455/si4455_api.h b/drivers/tty/serial/si4455_api.h
similarity index 100%
rename from drivers/staging/si4455/si4455_api.h
rename to drivers/tty/serial/si4455_api.h
-- 
2.17.1


