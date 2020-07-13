Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDE219F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGILZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 07:25:03 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:48224 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgGILZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:25:03 -0400
Received: from [78.43.71.214] (helo=marius.fritz.box)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@mariuszachmann.de>)
        id 1jtUff-0007QU-JL; Thu, 09 Jul 2020 13:24:55 +0200
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: corsair-cpro: add fan_target
Date:   Thu,  9 Jul 2020 13:24:39 +0200
Message-Id: <20200709112439.6069-1-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 78.43.71.214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds fan_target entries to the corsair-cpro driver.
Reading the attribute from the device does not seem possible, so
it returns the last set value. (same as pwm)

Furthermore:
- removes unnecessary kernel.h include.
- send_usb_cmd now has one more argument which is needed for the
  fan_target command.

Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
---
 Documentation/hwmon/corsair-cpro.rst |  3 ++
 drivers/hwmon/corsair-cpro.c         | 62 ++++++++++++++++++++++------
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
index 5913e23d764c..080f063d74b6 100644
--- a/Documentation/hwmon/corsair-cpro.rst
+++ b/Documentation/hwmon/corsair-cpro.rst
@@ -33,6 +33,9 @@ in2_input		Voltage on SATA 3.3v
 temp[1-4]_input		Temperature on connected temperature sensors
 fan[1-6]_input		Connected fan rpm.
 fan[1-6]_label		Shows fan type as detected by the device.
+fan[1-6]_set_target	Sets fan speed target rpm. Values from 0-65535.
+			When reading, it reports the last value if it was set by the driver.
+			Otherwise returns 0.
 pwm[1-6]		Sets the fan speed. Values from 0-255.
 			When reading, it reports the last value if it was set by the driver.
 			Otherwise returns 0.
diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index a22583acc229..a2cb2b474f08 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -5,7 +5,6 @@
  */

 #include <linux/bitops.h>
-#include <linux/kernel.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -51,6 +50,12 @@
 					 * send: byte 1 is fan number
 					 * send: byte 2 is percentage from 0 - 100
 					 */
+#define CTL_SET_FAN_TARGET	0x24	/*
+					 * set target rpm
+					 * send: byte 1 is fan number
+					 * send: byte 2-3 is target
+					 * device accepts all values from 0x00 - 0xFFFF
+					 */

 #define NUM_FANS		6
 #define NUM_TEMP_SENSORS	4
@@ -60,13 +65,14 @@ struct ccp_device {
 	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
 	u8 *buffer;
 	int pwm[6];
+	int target[6];
 	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
 	DECLARE_BITMAP(fan_cnct, NUM_FANS);
 	char fan_label[6][LABEL_LENGTH];
 };

 /* send command, check for error in response, response in ccp->buffer */
-static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2)
+static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2, u8 byte3)
 {
 	int actual_length;
 	int ret;
@@ -75,6 +81,7 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2)
 	ccp->buffer[0] = command;
 	ccp->buffer[1] = byte1;
 	ccp->buffer[2] = byte2;
+	ccp->buffer[3] = byte3;

 	ret = usb_bulk_msg(ccp->udev, usb_sndintpipe(ccp->udev, 2), ccp->buffer, OUT_BUFFER_SIZE,
 			   &actual_length, 1000);
@@ -103,7 +110,7 @@ static int get_data(struct ccp_device *ccp, int command, int channel)

 	mutex_lock(&ccp->mutex);

-	ret = send_usb_cmd(ccp, command, channel, 0);
+	ret = send_usb_cmd(ccp, command, channel, 0, 0);
 	if (ret)
 		goto out_unlock;

@@ -128,7 +135,24 @@ static int set_pwm(struct ccp_device *ccp, int channel, long val)

 	mutex_lock(&ccp->mutex);

-	ret = send_usb_cmd(ccp, CTL_SET_FAN_FPWM, channel, val);
+	ret = send_usb_cmd(ccp, CTL_SET_FAN_FPWM, channel, val, 0);
+
+	mutex_unlock(&ccp->mutex);
+	return ret;
+}
+
+static int set_target(struct ccp_device *ccp, int channel, long val)
+{
+	int ret;
+
+	if (val < 0 || val > 0xFFFF)
+		return -EINVAL;
+
+	ccp->target[channel] = val;
+
+	mutex_lock(&ccp->mutex);
+
+	ret = send_usb_cmd(ccp, CTL_SET_FAN_TARGET, channel, val >> 8, val);

 	mutex_unlock(&ccp->mutex);
 	return ret;
@@ -183,6 +207,11 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
 				return ret;
 			*val = ret;
 			return 0;
+		case hwmon_fan_target:
+			/* how to read target values from the device is unknown */
+			/* driver returns last set value or 0			*/
+			*val = ccp->target[channel];
+			return 0;
 		default:
 			break;
 		}
@@ -231,6 +260,13 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
 			break;
 		}
 		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_target:
+			return set_target(ccp, channel, val);
+		default:
+			break;
+		}
 	default:
 		break;
 	}
@@ -266,6 +302,8 @@ static umode_t ccp_is_visible(const void *data, enum hwmon_sensor_types type,
 			return 0444;
 		case hwmon_fan_label:
 			return 0444;
+		case hwmon_fan_target:
+			return 0644;
 		default:
 			break;
 		}
@@ -313,12 +351,12 @@ static const struct hwmon_channel_info *ccp_info[] = {
 			   HWMON_T_INPUT
 			   ),
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET
 			   ),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT,
@@ -348,7 +386,7 @@ static int get_fan_cnct(struct ccp_device *ccp)
 	int mode;
 	int ret;

-	ret = send_usb_cmd(ccp, CTL_GET_FAN_CNCT, 0, 0);
+	ret = send_usb_cmd(ccp, CTL_GET_FAN_CNCT, 0, 0, 0);
 	if (ret)
 		return ret;

@@ -385,7 +423,7 @@ static int get_temp_cnct(struct ccp_device *ccp)
 	int mode;
 	int ret;

-	ret = send_usb_cmd(ccp, CTL_GET_TMP_CNCT, 0, 0);
+	ret = send_usb_cmd(ccp, CTL_GET_TMP_CNCT, 0, 0, 0);
 	if (ret)
 		return ret;

--
2.27.0
