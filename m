Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A912EE924
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbhAGWqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:46:30 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56736 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbhAGWq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:46:28 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B86111C0B90; Thu,  7 Jan 2021 23:45:30 +0100 (CET)
Date:   Thu, 7 Jan 2021 23:45:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     johan@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, tony@atomide.com
Subject: [PATCH] gnss: motmdm: Add support for Motorola Mapphone MDM6600 modem
Message-ID: <20210107224530.GA23250@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Motorola is using a custom TS 27.010 based serial port line discipline
for various devices on the modem. These devices can be accessed on
dedicated channels using Linux kernel serdev-ngsm driver.

For the GNSS on these devices, we need to kick the GNSS device at a
desired rate. Otherwise the GNSS device stops sending data after a
few minutes. The rate we poll data defaults to 1000 ms, and can be
specified with a module option rate_ms between 1 to 16 seconds.

[Tony Lindgren did most of the work here, I just converted it to be
normal serdev.]

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index bd12e3d57baa..a7c449d8428c 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -13,6 +13,14 @@ menuconfig GNSS
=20
 if GNSS
=20
+config GNSS_MOTMDM
+	tristate "Motorola Modem TS 27.010 serdev GNSS receiver support"
+	depends on SERIAL_DEV_N_GSM
+	help
+	  Say Y here if you have a Motorola modem using TS 27.010 line
+	  discipline for GNSS such as a Motorola Mapphone series device
+	  like Droid 4.
+
 config GNSS_SERIAL
 	tristate
=20
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 451f11401ecc..f5afc2c22a3b 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -6,6 +6,9 @@
 obj-$(CONFIG_GNSS)			+=3D gnss.o
 gnss-y :=3D core.o
=20
+obj-$(CONFIG_GNSS_MOTMDM)		+=3D gnss-motmdm.o
+gnss-motmdm-y :=3D motmdm.o
+
 obj-$(CONFIG_GNSS_SERIAL)		+=3D gnss-serial.o
 gnss-serial-y :=3D serial.o
=20
diff --git a/drivers/gnss/motmdm.c b/drivers/gnss/motmdm.c
new file mode 100644
index 000000000000..bfd50e130631
--- /dev/null
+++ b/drivers/gnss/motmdm.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Motorola Modem TS 27.010 serdev GNSS driver
+ *
+ * Copyright (C) 2018 - 2020 Tony Lindgren <tony@atomide.com>
+ * Copyright (C) 2020 - 2021 Pavel Machek <pavel@ucw.cz>
+ *
+ * Based on drivers/gnss/sirf.c driver example:
+ * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/gnss.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/serdev-gsm.h>
+#include <linux/slab.h>
+
+#define MOTMDM_GNSS_TIMEOUT	1000
+#define MOTMDM_GNSS_RATE	1000
+
+/*
+ * Motorola MDM GNSS device communicates over a dedicated TS 27.010 channel
+ * using custom data packets. The packets look like AT commands embedded i=
nto
+ * a Motorola invented packet using format like "U1234AT+MPDSTART=3D0,1,10=
0,0".
+ * But it's not an AT compatible serial interface, it's a packet interface
+ * using AT like commands.
+ */
+#define MOTMDM_GNSS_HEADER_LEN	5				/* U1234 */
+#define MOTMDM_GNSS_RESP_LEN	(MOTMDM_GNSS_HEADER_LEN + 4)	/* U1234+MPD */
+#define MOTMDM_GNSS_DATA_LEN	(MOTMDM_GNSS_RESP_LEN + 1)	/* U1234~+MPD */
+#define MOTMDM_GNSS_STATUS_LEN	(MOTMDM_GNSS_DATA_LEN + 7)	/* STATUS=3D */
+#define MOTMDM_GNSS_NMEA_LEN	(MOTMDM_GNSS_DATA_LEN + 8)	/* NMEA=3DNN, */
+
+enum motmdm_gnss_status {
+	MOTMDM_GNSS_UNKNOWN,
+	MOTMDM_GNSS_INITIALIZED,
+	MOTMDM_GNSS_DATA_OR_TIMEOUT,
+	MOTMDM_GNSS_STARTED,
+	MOTMDM_GNSS_STOPPED,
+};
+
+struct motmdm_gnss_data {
+	struct gnss_device *gdev;
+	struct device *modem;
+	struct serdev_device *serdev;
+	struct delayed_work restart_work;
+	struct mutex mutex;	/* For modem commands */
+	ktime_t last_update;
+	int status;
+	unsigned char *buf;
+	size_t len;
+	wait_queue_head_t read_queue;
+	unsigned int parsed:1;
+};
+
+static unsigned int rate_ms =3D MOTMDM_GNSS_RATE;
+module_param(rate_ms, uint, 0644);
+MODULE_PARM_DESC(rate_ms, "GNSS refresh rate between 1000 and 16000 ms (de=
fault 1000 ms)");
+
+/*
+ * Note that multiple commands can be sent in series with responses coming
+ * out-of-order. For GNSS, we don't need to care about the out-of-order
+ * responses, and can assume we have at most one command active at a time.
+ * For the commands, can use just a jiffies base packet ID and let the mod=
em
+ * sort out the ID conflicts with the modem's unsolicited message ID
+ * numbering.
+ */
+int motmdm_gnss_send_command(struct motmdm_gnss_data *ddata,
+			     const u8 *buf, int len)
+{
+	struct gnss_device *gdev =3D ddata->gdev;
+	const int timeout_ms =3D 1000;
+	unsigned char cmd[128];
+	int ret, cmdlen;
+
+	cmdlen =3D len + MOTMDM_GNSS_HEADER_LEN + 1;
+	if (cmdlen > 128)
+		return -EINVAL;
+
+	mutex_lock(&ddata->mutex);
+	memset(ddata->buf, 0, ddata->len);
+	ddata->parsed =3D false;
+	snprintf(cmd, cmdlen, "U%04li%s", jiffies % 10000, buf);
+
+	ret =3D serdev_device_write(ddata->serdev, cmd, cmdlen, MAX_SCHEDULE_TIME=
OUT);
+	if (ret < 0)
+		goto out_unlock;
+
+	serdev_device_wait_until_sent(ddata->serdev, 0);
+
+	ret =3D wait_event_timeout(ddata->read_queue, ddata->parsed,
+				 msecs_to_jiffies(timeout_ms));
+	if (ret =3D=3D 0) {
+		ret =3D -ETIMEDOUT;
+		goto out_unlock;
+	} else if (ret < 0) {
+		goto out_unlock;
+	}
+
+	if (!strstr(ddata->buf, ":OK")) {
+		dev_err(&gdev->dev, "command %s error %s\n",
+			cmd, ddata->buf);
+		ret =3D -EPIPE;
+	}
+
+	ret =3D len;
+
+out_unlock:
+	mutex_unlock(&ddata->mutex);
+
+	return ret;
+}
+
+/*
+ * Android uses AT+MPDSTART=3D0,1,100,0 which starts GNSS for a while,
+ * and then GNSS needs to be kicked with an AT command based on a
+ * status message.
+ */
+static void motmdm_gnss_restart(struct work_struct *work)
+{
+	struct motmdm_gnss_data *ddata =3D
+		container_of(work, struct motmdm_gnss_data,
+			     restart_work.work);
+	struct gnss_device *gdev =3D ddata->gdev;
+	const unsigned char *cmd =3D "AT+MPDSTART=3D0,1,100,0";
+	int error;
+
+	ddata->last_update =3D ktime_get();
+
+	error =3D motmdm_gnss_send_command(ddata, cmd, strlen(cmd));
+	if (error < 0) {
+		/* Timeouts can happen, don't warn and try again */
+		if (error !=3D -ETIMEDOUT)
+			dev_warn(&gdev->dev, "%s: could not start: %i\n",
+				 __func__, error);
+
+		schedule_delayed_work(&ddata->restart_work,
+				      msecs_to_jiffies(MOTMDM_GNSS_RATE));
+	}
+}
+
+static void motmdm_gnss_start(struct gnss_device *gdev, int delay_ms)
+{
+	struct motmdm_gnss_data *ddata =3D gnss_get_drvdata(gdev);
+	ktime_t now, next, delta;
+	int next_ms;
+
+	now =3D ktime_get();
+	next =3D ktime_add_ms(ddata->last_update, delay_ms);
+	delta =3D ktime_sub(next, now);
+	next_ms =3D ktime_to_ms(delta);
+
+	if (next_ms < 0)
+		next_ms =3D 0;
+	if (next_ms > delay_ms)
+		next_ms =3D delay_ms;
+
+	schedule_delayed_work(&ddata->restart_work, msecs_to_jiffies(next_ms));
+}
+
+static int motmdm_gnss_stop(struct gnss_device *gdev)
+{
+	struct motmdm_gnss_data *ddata =3D gnss_get_drvdata(gdev);
+	const unsigned char *cmd =3D "AT+MPDSTOP";
+
+	cancel_delayed_work_sync(&ddata->restart_work);
+
+	return motmdm_gnss_send_command(ddata, cmd, strlen(cmd));
+}
+
+static int motmdm_gnss_init(struct gnss_device *gdev)
+{
+	struct motmdm_gnss_data *ddata =3D gnss_get_drvdata(gdev);
+	const unsigned char *cmd =3D "AT+MPDINIT=3D1";
+	int error;
+
+	error =3D motmdm_gnss_send_command(ddata, cmd, strlen(cmd));
+	if (error < 0)
+		return error;
+
+	motmdm_gnss_start(gdev, 0);
+
+	return 0;
+}
+
+static int motmdm_gnss_finish(struct gnss_device *gdev)
+{
+	struct motmdm_gnss_data *ddata =3D gnss_get_drvdata(gdev);
+	const unsigned char *cmd =3D "AT+MPDINIT=3D0";
+	int error;
+
+	error =3D motmdm_gnss_stop(gdev);
+	if (error < 0)
+		return error;
+
+	return motmdm_gnss_send_command(ddata, cmd, strlen(cmd));
+}
+
+static int motmdm_gnss_receive_data(struct serdev_device *serdev,
+					const unsigned char *buf, size_t len)
+{
+	struct motmdm_gnss_data *ddata =3D serdev_device_get_drvdata(serdev);
+	struct gnss_device *gdev =3D ddata->gdev;
+	const unsigned char *msg;
+	size_t msglen;
+	int error =3D 0;
+
+	if (len <=3D MOTMDM_GNSS_RESP_LEN)
+		return 0;
+
+	/* Handle U1234+MPD style command response */
+	if (buf[MOTMDM_GNSS_HEADER_LEN] !=3D '~') {
+		msg =3D buf + MOTMDM_GNSS_RESP_LEN;
+		strncpy(ddata->buf, msg, len - MOTMDM_GNSS_RESP_LEN);
+		ddata->parsed =3D true;
+		wake_up(&ddata->read_queue);
+
+		return len;
+	}
+
+	if (len <=3D MOTMDM_GNSS_DATA_LEN)
+		return 0;
+
+	/* Handle U1234~+MPD style unsolicted message */
+	switch (buf[MOTMDM_GNSS_DATA_LEN]) {
+	case 'N':	/* UNNNN~+MPDNMEA=3DNN, */
+		msg =3D buf + MOTMDM_GNSS_NMEA_LEN;
+		msglen =3D len - MOTMDM_GNSS_NMEA_LEN;
+
+		/*
+		 * Firmware bug: Strip out extra duplicate line break always
+		 * in the data
+		 */
+		msglen--;
+
+		/*
+		 * Firmware bug: Strip out extra data based on an
+		 * earlier line break in the data
+		 */
+		if (msg[msglen - 5 - 1] =3D=3D 0x0a)
+			msglen -=3D 5;
+
+		error =3D gnss_insert_raw(gdev, msg, msglen);
+		WARN_ON(error);
+		break;
+	case 'S':	/* UNNNN~+MPDSTATUS=3DN,NN */
+		msg =3D buf + MOTMDM_GNSS_STATUS_LEN;
+		msglen =3D len - MOTMDM_GNSS_STATUS_LEN;
+
+		switch (msg[0]) {
+		case '1':
+			ddata->status =3D MOTMDM_GNSS_INITIALIZED;
+			break;
+		case '2':
+			ddata->status =3D MOTMDM_GNSS_DATA_OR_TIMEOUT;
+			if (rate_ms < MOTMDM_GNSS_RATE)
+				rate_ms =3D MOTMDM_GNSS_RATE;
+			if (rate_ms > 16 * MOTMDM_GNSS_RATE)
+				rate_ms =3D 16 * MOTMDM_GNSS_RATE;
+			motmdm_gnss_start(gdev, rate_ms);
+			break;
+		case '3':
+			ddata->status =3D MOTMDM_GNSS_STARTED;
+			break;
+		case '4':
+			ddata->status =3D MOTMDM_GNSS_STOPPED;
+			break;
+		default:
+			ddata->status =3D MOTMDM_GNSS_UNKNOWN;
+			break;
+		}
+		break;
+	case 'X':	/* UNNNN~+MPDXREQ=3DN for updated xtra2.bin needed */
+	default:
+		break;
+	}
+
+	return len;
+}
+
+static const struct serdev_device_ops gnss_serdev_ops =3D {
+	.receive_buf    =3D motmdm_gnss_receive_data,
+	.write_wakeup   =3D serdev_device_write_wakeup,
+};
+
+static int motmdm_gnss_open(struct gnss_device *gdev)
+{
+	struct motmdm_gnss_data *ddata =3D gnss_get_drvdata(gdev);
+	int error;
+
+	serdev_device_set_client_ops(ddata->serdev, &gnss_serdev_ops);
+
+	error =3D serdev_device_open(ddata->serdev);
+	if (error) {
+		return error;
+	}
+
+	error =3D motmdm_gnss_init(gdev);
+	if (error) {
+		return error;
+	}
+
+	return 0;
+}
+
+static void motmdm_gnss_close(struct gnss_device *gdev)
+{
+	struct motmdm_gnss_data *ddata =3D gnss_get_drvdata(gdev);
+	int error;
+
+	error =3D motmdm_gnss_finish(gdev);
+	if (error < 0)
+		dev_warn(&gdev->dev, "%s: close failed: %i\n",
+			 __func__, error);
+
+	serdev_device_close(ddata->serdev);
+}
+
+static int motmdm_gnss_write_raw(struct gnss_device *gdev,
+				 const unsigned char *buf,
+				 size_t count)
+{
+	struct motmdm_gnss_data *ddata =3D gnss_get_drvdata(gdev);
+
+	return serdev_device_write(ddata->serdev, buf, count, MAX_SCHEDULE_TIMEOU=
T);
+	serdev_device_wait_until_sent(ddata->serdev, 0);
+
+	return count;
+}
+
+static const struct gnss_operations motmdm_gnss_ops =3D {
+	.open		=3D motmdm_gnss_open,
+	.close		=3D motmdm_gnss_close,
+	.write_raw	=3D motmdm_gnss_write_raw,
+};
+
+static int motmdm_gnss_probe(struct serdev_device *serdev)
+{
+	struct device *dev =3D &serdev->dev;
+	struct motmdm_gnss_data *ddata;
+	struct gnss_device *gdev;
+	int ret;
+
+	ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->serdev =3D serdev;
+	ddata->modem =3D dev->parent;
+	ddata->len =3D PAGE_SIZE;
+	mutex_init(&ddata->mutex);
+	INIT_DELAYED_WORK(&ddata->restart_work, motmdm_gnss_restart);
+	init_waitqueue_head(&ddata->read_queue);
+
+	ddata->buf =3D devm_kzalloc(dev, ddata->len, GFP_KERNEL);
+	if (!ddata->buf)
+		return -ENOMEM;
+
+	serdev_device_set_drvdata(serdev, ddata);
+
+	gdev =3D gnss_allocate_device(dev);
+	if (!gdev)
+		return -ENOMEM;
+
+	gdev->type =3D GNSS_TYPE_NMEA;
+	gdev->ops =3D &motmdm_gnss_ops;
+	gnss_set_drvdata(gdev, ddata);
+	ddata->gdev =3D gdev;
+
+	ret =3D gnss_register_device(gdev);
+	if (ret)
+		gnss_put_device(ddata->gdev);
+
+	return ret;
+}
+
+static void motmdm_gnss_remove(struct serdev_device *serdev)
+{
+	struct motmdm_gnss_data *data =3D serdev_device_get_drvdata(serdev);
+
+	gnss_deregister_device(data->gdev);
+	gnss_put_device(data->gdev);
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id motmdm_gnss_of_match[] =3D {
+	{ .compatible =3D "motorola,mapphone-mdm6600-gnss" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, motmdm_gnss_of_match);
+#endif
+
+static struct serdev_device_driver motmdm_gnss_driver =3D {
+	.driver	=3D {
+		.name		=3D "gnss-mot-mdm6600",
+		.of_match_table	=3D of_match_ptr(motmdm_gnss_of_match),
+	},
+	.probe	=3D motmdm_gnss_probe,
+	.remove	=3D motmdm_gnss_remove,
+};
+module_serdev_device_driver(motmdm_gnss_driver);
+
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("Motorola Mapphone MDM6600 GNSS receiver driver");
+MODULE_LICENSE("GPL v2");


--=20
http://www.livejournal.com/~pavelmachek

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/ePCgAKCRAw5/Bqldv6
8plGAKCLIypG8CZTy/lHG74MjwojEYNwqQCfaPYp0ftNV0PbJ9I4zJTiUumHBd8=
=Guio
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
