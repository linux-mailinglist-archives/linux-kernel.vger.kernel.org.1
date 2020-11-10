Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1912AD9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbgKJPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbgKJPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:07:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F40C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:07:39 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcVFC-0000Ij-3y; Tue, 10 Nov 2020 16:07:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kcVFA-00033N-Mt; Tue, 10 Nov 2020 16:07:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drivers: make struct device_driver::remove return void
Date:   Tue, 10 Nov 2020 16:07:23 +0100
Message-Id: <20201110150723.1592682-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core doesn't check the return value of the remove callback
because there is only little software can do when hardware disappears.

So change the callback to not return a value at all and adapt all users.
The motivation for this change is that some driver authors have a
misconception about failures in the remove callback. Making it void
makes it pretty obvious that there is no error handling to be expected.

Most drivers were easy to convert as they returned 0 unconditionally, I
added a warning to code paths that returned an error code (that was
ignored already before).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I expect that there are still a few driver that need adaption as I only
build tested allmodconfig on ARM and amd64.

Best regards
Uwe

 drivers/acpi/processor_driver.c         | 10 ++++------
 drivers/amba/bus.c                      |  7 ++++---
 drivers/base/platform.c                 | 13 +++++++------
 drivers/bus/fsl-mc/fsl-mc-bus.c         |  7 ++-----
 drivers/bus/mhi/core/init.c             |  6 ++----
 drivers/char/hw_random/optee-rng.c      |  4 +---
 drivers/char/tpm/tpm_ftpm_tee.c         |  8 ++++----
 drivers/firmware/broadcom/tee_bnxt_fw.c |  4 +---
 drivers/fsi/fsi-master-hub.c            |  4 +---
 drivers/fsi/fsi-sbefifo.c               |  4 +---
 drivers/fsi/fsi-scom.c                  |  4 +---
 drivers/gpu/drm/drm_mipi_dsi.c          |  7 +++++--
 drivers/gpu/host1x/bus.c                | 11 +++++++----
 drivers/greybus/core.c                  |  4 +---
 drivers/hsi/clients/cmt_speech.c        |  4 +---
 drivers/hsi/clients/hsi_char.c          |  4 +---
 drivers/hsi/clients/nokia-modem.c       |  4 +---
 drivers/hsi/clients/ssi_protocol.c      |  4 +---
 drivers/i2c/busses/i2c-fsi.c            |  4 +---
 drivers/input/rmi4/rmi_bus.c            |  4 +---
 drivers/input/rmi4/rmi_driver.c         |  4 +---
 drivers/input/touchscreen/wm97xx-core.c |  7 +++----
 drivers/mfd/ucb1400_core.c              |  3 +--
 drivers/net/ethernet/3com/3c509.c       |  5 ++---
 drivers/net/ethernet/3com/3c59x.c       |  3 +--
 drivers/net/ethernet/dec/tulip/de4x5.c  |  4 +---
 drivers/net/fddi/defxx.c                |  5 ++---
 drivers/net/phy/mdio_device.c           |  4 +---
 drivers/net/phy/phy_device.c            |  4 +---
 drivers/pci/pcie/portdrv_core.c         |  5 ++---
 drivers/scsi/advansys.c                 |  3 +--
 drivers/scsi/aha1740.c                  |  4 +---
 drivers/scsi/aic7xxx/aic7770_osm.c      |  3 +--
 drivers/scsi/ch.c                       |  3 +--
 drivers/scsi/sd.c                       |  6 ++----
 drivers/scsi/ses.c                      |  3 +--
 drivers/scsi/sim710.c                   |  3 +--
 drivers/scsi/sr.c                       |  6 ++----
 drivers/scsi/st.c                       |  5 ++---
 drivers/siox/siox-core.c                |  6 ++++--
 drivers/soundwire/bus_type.c            | 13 +++++++------
 drivers/spi/spi.c                       |  8 +++++---
 drivers/usb/core/driver.c               |  7 ++-----
 drivers/visorbus/visorbus_main.c        |  5 +----
 include/linux/device/driver.h           |  2 +-
 sound/core/seq/oss/seq_oss_synth.c      |  6 ++----
 sound/core/seq/oss/seq_oss_synth.h      |  2 +-
 sound/core/seq/seq_midi.c               |  6 +++---
 sound/drivers/opl3/opl3_seq.c           | 10 ++++++----
 sound/drivers/opl4/opl4_seq.c           |  9 +++++----
 sound/hda/ext/hdac_ext_bus.c            |  9 +++++++--
 sound/isa/sb/emu8000_synth.c            |  5 ++---
 sound/pci/emu10k1/emu10k1_synth.c       |  5 ++---
 sound/pci/hda/hda_bind.c                | 11 +++++++----
 54 files changed, 129 insertions(+), 172 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 62114a03a51a..b466e93630bc 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -36,7 +36,7 @@ MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
 static int acpi_processor_start(struct device *dev);
-static int acpi_processor_stop(struct device *dev);
+static void acpi_processor_stop(struct device *dev);
 
 static const struct acpi_device_id processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, 0},
@@ -261,27 +261,25 @@ static int acpi_processor_start(struct device *dev)
 	return ret;
 }
 
-static int acpi_processor_stop(struct device *dev)
+static void acpi_processor_stop(struct device *dev)
 {
 	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_processor *pr;
 
 	if (!device)
-		return 0;
+		return;
 
 	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
 				   acpi_processor_notify);
 
 	pr = acpi_driver_data(device);
 	if (!pr)
-		return 0;
+		return;
 	acpi_processor_power_exit(pr);
 
 	acpi_pss_perf_exit(pr, device);
 
 	acpi_cppc_processor_exit(pr);
-
-	return 0;
 }
 
 bool acpi_processor_cpufreq_init;
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index ecc304149067..ed79a5c657e5 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -295,7 +295,7 @@ static int amba_probe(struct device *dev)
 	return ret;
 }
 
-static int amba_remove(struct device *dev)
+static void amba_remove(struct device *dev)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *drv = to_amba_driver(dev->driver);
@@ -303,6 +303,9 @@ static int amba_remove(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	ret = drv->remove(pcdev);
+	if (ret)
+		dev_info(dev, "Failed to remove (%pe), ignoring\n",
+			 ERR_PTR(ret));
 	pm_runtime_put_noidle(dev);
 
 	/* Undo the runtime PM settings in amba_probe() */
@@ -312,8 +315,6 @@ static int amba_remove(struct device *dev)
 
 	amba_put_disable_pclk(pcdev);
 	dev_pm_domain_detach(dev, true);
-
-	return ret;
 }
 
 static void amba_shutdown(struct device *dev)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 88aef93eb4dd..9e9f2393fce3 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -777,17 +777,18 @@ static int platform_drv_probe_fail(struct device *_dev)
 	return -ENXIO;
 }
 
-static int platform_drv_remove(struct device *_dev)
+static void platform_drv_remove(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
-	int ret = 0;
 
-	if (drv->remove)
-		ret = drv->remove(dev);
+	if (drv->remove) {
+		int ret = drv->remove(dev);
+		if (ret)
+			dev_warn(_dev, "Failed to remove driver (%pe), ignoring\n",
+				 ERR_PTR(ret));
+	}
 	dev_pm_domain_detach(_dev, true);
-
-	return ret;
 }
 
 static void platform_drv_shutdown(struct device *_dev)
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 76a6ee505d33..529e562d8363 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -339,7 +339,7 @@ static int fsl_mc_driver_probe(struct device *dev)
 	return 0;
 }
 
-static int fsl_mc_driver_remove(struct device *dev)
+static void fsl_mc_driver_remove(struct device *dev)
 {
 	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(dev->driver);
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
@@ -347,11 +347,8 @@ static int fsl_mc_driver_remove(struct device *dev)
 
 	error = mc_drv->remove(mc_dev);
 	if (error < 0) {
-		dev_err(dev, "%s failed: %d\n", __func__, error);
-		return error;
+		dev_err(dev, "%s failed: %d (ignoring)\n", __func__, error);
 	}
-
-	return 0;
 }
 
 static void fsl_mc_driver_shutdown(struct device *dev)
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 0ffdebde8265..4455cfb166ee 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1213,7 +1213,7 @@ static int mhi_driver_probe(struct device *dev)
 	return ret;
 }
 
-static int mhi_driver_remove(struct device *dev)
+static void mhi_driver_remove(struct device *dev)
 {
 	struct mhi_device *mhi_dev = to_mhi_device(dev);
 	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
@@ -1227,7 +1227,7 @@ static int mhi_driver_remove(struct device *dev)
 
 	/* Skip if it is a controller device */
 	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
-		return 0;
+		return;
 
 	/* Reset both channels */
 	for (dir = 0; dir < 2; dir++) {
@@ -1280,8 +1280,6 @@ static int mhi_driver_remove(struct device *dev)
 	while (mhi_dev->dev_wake)
 		mhi_device_put(mhi_dev);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return 0;
 }
 
 int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner)
diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index a99d82949981..5730610d61db 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -261,13 +261,11 @@ static int optee_rng_probe(struct device *dev)
 	return err;
 }
 
-static int optee_rng_remove(struct device *dev)
+static void optee_rng_remove(struct device *dev)
 {
 	hwrng_unregister(&pvt_data.optee_rng);
 	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
 	tee_client_close_context(pvt_data.ctx);
-
-	return 0;
 }
 
 static const struct tee_client_device_id optee_rng_id_table[] = {
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac6994..527c8427f4a3 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -310,7 +310,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
  * Return:
  *	0 always.
  */
-static int ftpm_tee_remove(struct device *dev)
+static void ftpm_tee_remove(struct device *dev)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
 
@@ -330,15 +330,15 @@ static int ftpm_tee_remove(struct device *dev)
 	tee_client_close_context(pvt_data->ctx);
 
 	/* memory allocated with devm_kzalloc() is freed automatically */
-
-	return 0;
 }
 
 static int ftpm_plat_tee_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	return ftpm_tee_remove(dev);
+	ftpm_tee_remove(dev);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index ed10da5313e8..d158568fe126 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -232,14 +232,12 @@ static int tee_bnxt_fw_probe(struct device *dev)
 	return err;
 }
 
-static int tee_bnxt_fw_remove(struct device *dev)
+static void tee_bnxt_fw_remove(struct device *dev)
 {
 	tee_shm_free(pvt_data.fw_shm_pool);
 	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
 	tee_client_close_context(pvt_data.ctx);
 	pvt_data.ctx = NULL;
-
-	return 0;
 }
 
 static const struct tee_client_device_id tee_bnxt_fw_id_table[] = {
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 01f0a796111e..daaafe50c962 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -259,7 +259,7 @@ static int hub_master_probe(struct device *dev)
 	return rc;
 }
 
-static int hub_master_remove(struct device *dev)
+static void hub_master_remove(struct device *dev)
 {
 	struct fsi_master_hub *hub = dev_get_drvdata(dev);
 
@@ -272,8 +272,6 @@ static int hub_master_remove(struct device *dev)
 	 * the hub
 	 */
 	put_device(&hub->master.dev);
-
-	return 0;
 }
 
 static const struct fsi_device_id hub_master_ids[] = {
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index bfd5e5da8020..5d37686807ad 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -1010,7 +1010,7 @@ static int sbefifo_unregister_child(struct device *dev, void *data)
 	return 0;
 }
 
-static int sbefifo_remove(struct device *dev)
+static void sbefifo_remove(struct device *dev)
 {
 	struct sbefifo *sbefifo = dev_get_drvdata(dev);
 
@@ -1024,8 +1024,6 @@ static int sbefifo_remove(struct device *dev)
 	fsi_free_minor(sbefifo->dev.devt);
 	device_for_each_child(dev, NULL, sbefifo_unregister_child);
 	put_device(&sbefifo->dev);
-
-	return 0;
 }
 
 static const struct fsi_device_id sbefifo_ids[] = {
diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index b45bfab7b7f5..681372e58820 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -613,7 +613,7 @@ static int scom_probe(struct device *dev)
 	return rc;
 }
 
-static int scom_remove(struct device *dev)
+static void scom_remove(struct device *dev)
 {
 	struct scom_device *scom = dev_get_drvdata(dev);
 
@@ -623,8 +623,6 @@ static int scom_remove(struct device *dev)
 	cdev_device_del(&scom->cdev, &scom->dev);
 	fsi_free_minor(scom->dev.devt);
 	put_device(&scom->dev);
-
-	return 0;
 }
 
 static const struct fsi_device_id scom_ids[] = {
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 5dd475e82995..3e7ca026a548 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1150,12 +1150,15 @@ static int mipi_dsi_drv_probe(struct device *dev)
 	return drv->probe(dsi);
 }
 
-static int mipi_dsi_drv_remove(struct device *dev)
+static void mipi_dsi_drv_remove(struct device *dev)
 {
 	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
 
-	return drv->remove(dsi);
+	int ret = drv->remove(dsi);
+	if (ret)
+		dev_warn(dev, "Failed to unbind device (%pe), ignoring\n",
+			 ERR_PTR(ret));
 }
 
 static void mipi_dsi_drv_shutdown(struct device *dev)
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index e201f62d62c0..7eb894aef332 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -619,15 +619,18 @@ static int host1x_device_probe(struct device *dev)
 	return 0;
 }
 
-static int host1x_device_remove(struct device *dev)
+static void host1x_device_remove(struct device *dev)
 {
 	struct host1x_driver *driver = to_host1x_driver(dev->driver);
 	struct host1x_device *device = to_host1x_device(dev);
 
-	if (driver->remove)
-		return driver->remove(device);
+	if (driver->remove) {
+		int ret = driver->remove(device);
+		if (ret)
+			dev_warn(dev, "Failed to unbind driver (%pe), ignoring\n",
+				 ERR_PTR(ret));
 
-	return 0;
+	}
 }
 
 static void host1x_device_shutdown(struct device *dev)
diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index e546c6431877..dbb2b2f92178 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -222,7 +222,7 @@ static int greybus_probe(struct device *dev)
 	return 0;
 }
 
-static int greybus_remove(struct device *dev)
+static void greybus_remove(struct device *dev)
 {
 	struct greybus_driver *driver = to_greybus_driver(dev->driver);
 	struct gb_bundle *bundle = to_gb_bundle(dev);
@@ -261,8 +261,6 @@ static int greybus_remove(struct device *dev)
 	pm_runtime_set_suspended(dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_put_noidle(dev);
-
-	return 0;
 }
 
 int greybus_register_driver(struct greybus_driver *driver, struct module *owner,
diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
index 89869c66fb9d..b8b839d8bdcb 100644
--- a/drivers/hsi/clients/cmt_speech.c
+++ b/drivers/hsi/clients/cmt_speech.c
@@ -1402,7 +1402,7 @@ static int cs_hsi_client_probe(struct device *dev)
 	return err;
 }
 
-static int cs_hsi_client_remove(struct device *dev)
+static void cs_hsi_client_remove(struct device *dev)
 {
 	struct cs_hsi_iface *hi;
 
@@ -1414,8 +1414,6 @@ static int cs_hsi_client_remove(struct device *dev)
 	spin_unlock_bh(&cs_char_data.lock);
 	if (hi)
 		cs_hsi_stop(hi);
-
-	return 0;
 }
 
 static struct hsi_client_driver cs_hsi_driver = {
diff --git a/drivers/hsi/clients/hsi_char.c b/drivers/hsi/clients/hsi_char.c
index 71ce7dbfe31d..17e4d8a86af2 100644
--- a/drivers/hsi/clients/hsi_char.c
+++ b/drivers/hsi/clients/hsi_char.c
@@ -730,7 +730,7 @@ static int hsc_probe(struct device *dev)
 	return ret;
 }
 
-static int hsc_remove(struct device *dev)
+static void hsc_remove(struct device *dev)
 {
 	struct hsi_client *cl = to_hsi_client(dev);
 	struct hsc_client_data *cl_data = hsi_client_drvdata(cl);
@@ -740,8 +740,6 @@ static int hsc_remove(struct device *dev)
 	unregister_chrdev_region(hsc_dev, HSC_DEVS);
 	hsi_client_set_drvdata(cl, NULL);
 	kfree(cl_data);
-
-	return 0;
 }
 
 static struct hsi_client_driver hsc_driver = {
diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index cd7ebf4c2e2f..c346353a527b 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -237,7 +237,7 @@ static int nokia_modem_probe(struct device *dev)
 	return err;
 }
 
-static int nokia_modem_remove(struct device *dev)
+static void nokia_modem_remove(struct device *dev)
 {
 	struct nokia_modem_device *modem = dev_get_drvdata(dev);
 
@@ -258,8 +258,6 @@ static int nokia_modem_remove(struct device *dev)
 	dev_set_drvdata(dev, NULL);
 	disable_irq_wake(modem->nokia_modem_rst_ind_irq);
 	tasklet_kill(&modem->nokia_modem_rst_ind_tasklet);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 96d0eccca3aa..c5cfd76f31bd 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -1146,7 +1146,7 @@ static int ssi_protocol_probe(struct device *dev)
 	return err;
 }
 
-static int ssi_protocol_remove(struct device *dev)
+static void ssi_protocol_remove(struct device *dev)
 {
 	struct hsi_client *cl = to_hsi_client(dev);
 	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
@@ -1156,8 +1156,6 @@ static int ssi_protocol_remove(struct device *dev)
 	ssip_free_cmds(ssi);
 	hsi_client_set_drvdata(cl, NULL);
 	kfree(ssi);
-
-	return 0;
 }
 
 static struct hsi_client_driver ssip_driver = {
diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 10332693edf0..513a30530dda 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -740,7 +740,7 @@ static int fsi_i2c_probe(struct device *dev)
 	return 0;
 }
 
-static int fsi_i2c_remove(struct device *dev)
+static void fsi_i2c_remove(struct device *dev)
 {
 	struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
 	struct fsi_i2c_port *port, *tmp;
@@ -750,8 +750,6 @@ static int fsi_i2c_remove(struct device *dev)
 		i2c_del_adapter(&port->adapter);
 		kfree(port);
 	}
-
-	return 0;
 }
 
 static const struct fsi_device_id fsi_i2c_ids[] = {
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 47d1b97ed6cf..d25a21ae9720 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -223,7 +223,7 @@ static int rmi_function_probe(struct device *dev)
 	return 0;
 }
 
-static int rmi_function_remove(struct device *dev)
+static void rmi_function_remove(struct device *dev)
 {
 	struct rmi_function *fn = to_rmi_function(dev);
 	struct rmi_function_handler *handler =
@@ -231,8 +231,6 @@ static int rmi_function_remove(struct device *dev)
 
 	if (handler->remove)
 		handler->remove(fn);
-
-	return 0;
 }
 
 int rmi_register_function(struct rmi_function *fn)
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 258d5fe3d395..8a99a00fb901 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -971,7 +971,7 @@ int rmi_driver_resume(struct rmi_device *rmi_dev, bool clear_wake)
 }
 EXPORT_SYMBOL_GPL(rmi_driver_resume);
 
-static int rmi_driver_remove(struct device *dev)
+static void rmi_driver_remove(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
@@ -983,8 +983,6 @@ static int rmi_driver_remove(struct device *dev)
 
 	rmi_f34_remove_sysfs(rmi_dev);
 	rmi_free_function_list(rmi_dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 0a174bd82915..94bfe4274ed0 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -752,14 +752,12 @@ static int wm97xx_probe(struct device *dev)
 	return ret;
 }
 
-static int wm97xx_remove(struct device *dev)
+static void wm97xx_remove(struct device *dev)
 {
 	struct wm97xx *wm = dev_get_drvdata(dev);
 
 	wm97xx_remove_battery(wm);
 	wm97xx_unregister_touch(wm);
-
-	return 0;
 }
 
 static int wm97xx_mfd_probe(struct platform_device *pdev)
@@ -792,7 +790,8 @@ static int wm97xx_mfd_probe(struct platform_device *pdev)
 
 static int wm97xx_mfd_remove(struct platform_device *pdev)
 {
-	return wm97xx_remove(&pdev->dev);
+	wm97xx_remove(&pdev->dev);
+	return 0;
 }
 
 static int __maybe_unused wm97xx_suspend(struct device *dev)
diff --git a/drivers/mfd/ucb1400_core.c b/drivers/mfd/ucb1400_core.c
index 8c3832a58ef6..6e28124e11f9 100644
--- a/drivers/mfd/ucb1400_core.c
+++ b/drivers/mfd/ucb1400_core.c
@@ -125,7 +125,7 @@ static int ucb1400_core_probe(struct device *dev)
 	return err;
 }
 
-static int ucb1400_core_remove(struct device *dev)
+static void ucb1400_core_remove(struct device *dev)
 {
 	struct ucb1400 *ucb = dev_get_drvdata(dev);
 
@@ -133,7 +133,6 @@ static int ucb1400_core_remove(struct device *dev)
 	platform_device_unregister(ucb->ucb1400_gpio);
 
 	kfree(ucb);
-	return 0;
 }
 
 static struct device_driver ucb1400_core_driver = {
diff --git a/drivers/net/ethernet/3com/3c509.c b/drivers/net/ethernet/3com/3c509.c
index 667f38c9e4c6..2a79f8467178 100644
--- a/drivers/net/ethernet/3com/3c509.c
+++ b/drivers/net/ethernet/3com/3c509.c
@@ -206,7 +206,7 @@ static int el3_resume(struct device *);
 
 
 /* generic device remove for all device types */
-static int el3_device_remove (struct device *device);
+static void el3_device_remove (struct device *device);
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void el3_poll_controller(struct net_device *dev);
 #endif
@@ -609,14 +609,13 @@ static int el3_eisa_probe(struct device *device)
 /* This remove works for all device types.
  *
  * The net dev must be stored in the driver data field */
-static int el3_device_remove(struct device *device)
+static void el3_device_remove(struct device *device)
 {
 	struct net_device *dev;
 
 	dev = dev_get_drvdata(device);
 
 	el3_common_remove (dev);
-	return 0;
 }
 
 /* Read a word from the EEPROM using the regular EEPROM access register.
diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
index 741c67e546d4..15c713669048 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -923,7 +923,7 @@ static int vortex_eisa_probe(struct device *device)
 	return 0;
 }
 
-static int vortex_eisa_remove(struct device *device)
+static void vortex_eisa_remove(struct device *device)
 {
 	struct eisa_device *edev;
 	struct net_device *dev;
@@ -946,7 +946,6 @@ static int vortex_eisa_remove(struct device *device)
 	release_region(edev->base_addr, VORTEX_TOTAL_SIZE);
 
 	free_netdev(dev);
-	return 0;
 }
 
 static struct eisa_driver vortex_eisa_driver = {
diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index 683e328b5461..5add34ba29c2 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -2077,7 +2077,7 @@ static int de4x5_eisa_probe(struct device *gendev)
 	return status;
 }
 
-static int de4x5_eisa_remove(struct device *device)
+static void de4x5_eisa_remove(struct device *device)
 {
 	struct net_device *dev;
 	u_long iobase;
@@ -2089,8 +2089,6 @@ static int de4x5_eisa_remove(struct device *device)
 	free_netdev (dev);
 	release_region (iobase + DE4X5_EISA_IO_PORTS, DE4X5_EISA_TOTAL_SIZE);
 	release_region (iobase, DE4X5_EISA_TOTAL_SIZE);
-
-	return 0;
 }
 
 static const struct eisa_device_id de4x5_eisa_ids[] = {
diff --git a/drivers/net/fddi/defxx.c b/drivers/net/fddi/defxx.c
index 077c68498f04..25e89eb2046b 100644
--- a/drivers/net/fddi/defxx.c
+++ b/drivers/net/fddi/defxx.c
@@ -3735,7 +3735,7 @@ static void dfx_unregister(struct device *bdev)
 
 
 static int __maybe_unused dfx_dev_register(struct device *);
-static int __maybe_unused dfx_dev_unregister(struct device *);
+static void __maybe_unused dfx_dev_unregister(struct device *);
 
 #ifdef CONFIG_PCI
 static int dfx_pci_register(struct pci_dev *, const struct pci_device_id *);
@@ -3818,11 +3818,10 @@ static int __maybe_unused dfx_dev_register(struct device *dev)
 	return status;
 }
 
-static int __maybe_unused dfx_dev_unregister(struct device *dev)
+static void __maybe_unused dfx_dev_unregister(struct device *dev)
 {
 	put_device(dev);
 	dfx_unregister(dev);
-	return 0;
 }
 
 
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 0837319a52d7..74afb4357c22 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -164,7 +164,7 @@ static int mdio_probe(struct device *dev)
 	return err;
 }
 
-static int mdio_remove(struct device *dev)
+static void mdio_remove(struct device *dev)
 {
 	struct mdio_device *mdiodev = to_mdio_device(dev);
 	struct device_driver *drv = mdiodev->dev.driver;
@@ -175,8 +175,6 @@ static int mdio_remove(struct device *dev)
 
 	/* Assert the reset signal */
 	mdio_device_reset(mdiodev, 1);
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5dab6be6fc38..a0b7c59bc5ec 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2923,7 +2923,7 @@ static int phy_probe(struct device *dev)
 	return err;
 }
 
-static int phy_remove(struct device *dev)
+static void phy_remove(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 
@@ -2943,8 +2943,6 @@ static int phy_remove(struct device *dev)
 	phy_device_reset(phydev, 1);
 
 	phydev->drv = NULL;
-
-	return 0;
 }
 
 /**
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522ab07d..2509564c5eb4 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -533,13 +533,13 @@ static int pcie_port_probe_service(struct device *dev)
  * when device_unregister() is called for the port service device associated
  * with the driver.
  */
-static int pcie_port_remove_service(struct device *dev)
+static void pcie_port_remove_service(struct device *dev)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
 
 	if (!dev || !dev->driver)
-		return 0;
+		return;
 
 	pciedev = to_pcie_device(dev);
 	driver = to_service_driver(dev->driver);
@@ -547,7 +547,6 @@ static int pcie_port_remove_service(struct device *dev)
 		driver->remove(pciedev);
 		put_device(dev);
 	}
-	return 0;
 }
 
 /**
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index c2c7850ff7b4..c3051be05280 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -11671,7 +11671,7 @@ static int advansys_eisa_probe(struct device *dev)
 	return err;
 }
 
-static int advansys_eisa_remove(struct device *dev)
+static void advansys_eisa_remove(struct device *dev)
 {
 	int i;
 	struct eisa_scsi_data *data = dev_get_drvdata(dev);
@@ -11687,7 +11687,6 @@ static int advansys_eisa_remove(struct device *dev)
 	}
 
 	kfree(data);
-	return 0;
 }
 
 static struct eisa_driver advansys_eisa_driver = {
diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index 5a227c03895f..fa7feb70ca8b 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -625,7 +625,7 @@ static int aha1740_probe (struct device *dev)
 	return -ENODEV;
 }
 
-static int aha1740_remove (struct device *dev)
+static void aha1740_remove (struct device *dev)
 {
 	struct Scsi_Host *shpnt = dev_get_drvdata(dev);
 	struct aha1740_hostdata *host = HOSTDATA (shpnt);
@@ -638,8 +638,6 @@ static int aha1740_remove (struct device *dev)
 	release_region (shpnt->io_port, SLOTSIZE);
 
 	scsi_host_put (shpnt);
-	
-	return 0;
 }
 
 static struct eisa_device_id aha1740_ids[] = {
diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c b/drivers/scsi/aic7xxx/aic7770_osm.c
index bdd177e3d762..3e4583147c33 100644
--- a/drivers/scsi/aic7xxx/aic7770_osm.c
+++ b/drivers/scsi/aic7xxx/aic7770_osm.c
@@ -106,7 +106,7 @@ aic7770_probe(struct device *dev)
 	return (error);
 }
 
-static int
+static void
 aic7770_remove(struct device *dev)
 {
 	struct ahc_softc *ahc = dev_get_drvdata(dev);
@@ -120,7 +120,6 @@ aic7770_remove(struct device *dev)
 	ahc_unlock(ahc, &s);
 
 	ahc_free(ahc);
-	return 0;
 }
  
 static struct eisa_device_id aic7770_ids[] = {
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index cb74ab1ae5a4..9fddca0cec24 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -985,7 +985,7 @@ static int ch_probe(struct device *dev)
 	return ret;
 }
 
-static int ch_remove(struct device *dev)
+static void ch_remove(struct device *dev)
 {
 	scsi_changer *ch = dev_get_drvdata(dev);
 
@@ -997,7 +997,6 @@ static int ch_remove(struct device *dev)
 	device_destroy(ch_sysfs_class, MKDEV(SCSI_CHANGER_MAJOR,ch->minor));
 	scsi_device_put(ch->device);
 	kref_put(&ch->ref, ch_destroy);
-	return 0;
 }
 
 static struct scsi_driver ch_template = {
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 656bcf4940d6..074f69d50369 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -109,7 +109,7 @@ static void sd_config_write_same(struct scsi_disk *);
 static int  sd_revalidate_disk(struct gendisk *);
 static void sd_unlock_native_capacity(struct gendisk *disk);
 static int  sd_probe(struct device *);
-static int  sd_remove(struct device *);
+static void sd_remove(struct device *);
 static void sd_shutdown(struct device *);
 static int sd_suspend_system(struct device *);
 static int sd_suspend_runtime(struct device *);
@@ -3512,7 +3512,7 @@ static int sd_probe(struct device *dev)
  *	that could be re-used by a subsequent sd_probe().
  *	This function is not called when the built-in sd driver is "exit-ed".
  **/
-static int sd_remove(struct device *dev)
+static void sd_remove(struct device *dev)
 {
 	struct scsi_disk *sdkp;
 	dev_t devt;
@@ -3535,8 +3535,6 @@ static int sd_remove(struct device *dev)
 	dev_set_drvdata(dev, NULL);
 	put_device(&sdkp->dev);
 	mutex_unlock(&sd_ref_mutex);
-
-	return 0;
 }
 
 /**
diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index c2afba2a5414..2917eb80083b 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -777,9 +777,8 @@ static int ses_intf_add(struct device *cdev,
 	return err;
 }
 
-static int ses_remove(struct device *dev)
+static void ses_remove(struct device *dev)
 {
-	return 0;
 }
 
 static void ses_intf_remove_component(struct scsi_device *sdev)
diff --git a/drivers/scsi/sim710.c b/drivers/scsi/sim710.c
index 22302612e032..468b18c3c7a3 100644
--- a/drivers/scsi/sim710.c
+++ b/drivers/scsi/sim710.c
@@ -140,7 +140,7 @@ static int sim710_probe_common(struct device *dev, unsigned long base_addr,
 	return -ENODEV;
 }
 
-static int sim710_device_remove(struct device *dev)
+static void sim710_device_remove(struct device *dev)
 {
 	struct Scsi_Host *host = dev_get_drvdata(dev);
 	struct NCR_700_Host_Parameters *hostdata =
@@ -151,7 +151,6 @@ static int sim710_device_remove(struct device *dev)
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	release_region(host->base, 64);
-	return 0;
 }
 
 #ifdef CONFIG_EISA
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index fd4b582110b2..3cadee71d383 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -82,7 +82,7 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_WORM);
 	 CDC_MRW|CDC_MRW_W|CDC_RAM)
 
 static int sr_probe(struct device *);
-static int sr_remove(struct device *);
+static void sr_remove(struct device *);
 static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt);
 static int sr_done(struct scsi_cmnd *);
 static int sr_runtime_suspend(struct device *dev);
@@ -1049,7 +1049,7 @@ static void sr_kref_release(struct kref *kref)
 	kfree(cd);
 }
 
-static int sr_remove(struct device *dev)
+static void sr_remove(struct device *dev)
 {
 	struct scsi_cd *cd = dev_get_drvdata(dev);
 
@@ -1061,8 +1061,6 @@ static int sr_remove(struct device *dev)
 	mutex_lock(&sr_ref_mutex);
 	kref_put(&cd->kref, sr_kref_release);
 	mutex_unlock(&sr_ref_mutex);
-
-	return 0;
 }
 
 static int __init init_sr(void)
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index e2e5356a997d..510a5472a5ae 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -200,7 +200,7 @@ static int sgl_map_user_pages(struct st_buffer *, const unsigned int,
 static int sgl_unmap_user_pages(struct st_buffer *, const unsigned int, int);
 
 static int st_probe(struct device *);
-static int st_remove(struct device *);
+static void st_remove(struct device *);
 
 static struct scsi_driver st_template = {
 	.gendrv = {
@@ -4446,7 +4446,7 @@ static int st_probe(struct device *dev)
 };
 
 
-static int st_remove(struct device *dev)
+static void st_remove(struct device *dev)
 {
 	struct scsi_tape *tpnt = dev_get_drvdata(dev);
 	int index = tpnt->index;
@@ -4460,7 +4460,6 @@ static int st_remove(struct device *dev)
 	spin_lock(&st_index_lock);
 	idr_remove(&st_index_idr, index);
 	spin_unlock(&st_index_lock);
-	return 0;
 }
 
 /**
diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index f8c08fb9891d..97e02b7e4bd2 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -527,7 +527,7 @@ static int siox_driver_probe(struct device *dev)
 	return ret;
 }
 
-static int siox_driver_remove(struct device *dev)
+static void siox_driver_remove(struct device *dev)
 {
 	struct siox_driver *sdriver =
 		container_of(dev->driver, struct siox_driver, driver);
@@ -535,7 +535,9 @@ static int siox_driver_remove(struct device *dev)
 	int ret;
 
 	ret = sdriver->remove(sdevice);
-	return ret;
+	if (ret)
+		dev_warn(dev, "Failed to unbind driver (%pe), ignoring\n",
+			 ERR_PTR(ret));
 }
 
 static void siox_driver_shutdown(struct device *dev)
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 575b9bad99d5..8758717996c6 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -142,18 +142,19 @@ static int sdw_drv_probe(struct device *dev)
 	return 0;
 }
 
-static int sdw_drv_remove(struct device *dev)
+static void sdw_drv_remove(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
-	int ret = 0;
 
-	if (drv->remove)
-		ret = drv->remove(slave);
+	if (drv->remove) {
+		int ret = drv->remove(slave);
+		if (ret)
+			dev_warn(dev, "Failed to unbind driver (%pe), ignoring\n",
+				 ERR_PTR(ret));
+	}
 
 	dev_pm_domain_detach(dev, false);
-
-	return ret;
 }
 
 static void sdw_drv_shutdown(struct device *dev)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..73c81dcbc195 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -412,15 +412,17 @@ static int spi_drv_probe(struct device *dev)
 	return ret;
 }
 
-static int spi_drv_remove(struct device *dev)
+static void spi_drv_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 	int ret;
 
 	ret = sdrv->remove(to_spi_device(dev));
-	dev_pm_domain_detach(dev, true);
+	if (ret)
+		dev_warn(dev, "Failed to unbind driver (%pe), ignoring\n",
+			 ERR_PTR(ret));
 
-	return ret;
+	dev_pm_domain_detach(dev, true);
 }
 
 static void spi_drv_shutdown(struct device *dev)
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 4dfa44d6cc3c..dd57141b2876 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -300,7 +300,7 @@ static int usb_probe_device(struct device *dev)
 }
 
 /* called from driver core with dev locked */
-static int usb_unbind_device(struct device *dev)
+static void usb_unbind_device(struct device *dev)
 {
 	struct usb_device *udev = to_usb_device(dev);
 	struct usb_device_driver *udriver = to_usb_device_driver(dev->driver);
@@ -311,7 +311,6 @@ static int usb_unbind_device(struct device *dev)
 		usb_generic_driver_disconnect(udev);
 	if (!udriver->supports_autosuspend)
 		usb_autosuspend_device(udev);
-	return 0;
 }
 
 /* called from driver core with dev locked */
@@ -425,7 +424,7 @@ static int usb_probe_interface(struct device *dev)
 }
 
 /* called from driver core with dev locked */
-static int usb_unbind_interface(struct device *dev)
+static void usb_unbind_interface(struct device *dev)
 {
 	struct usb_driver *driver = to_usb_driver(dev->driver);
 	struct usb_interface *intf = to_usb_interface(dev);
@@ -510,8 +509,6 @@ static int usb_unbind_interface(struct device *dev)
 
 	if (!error)
 		usb_autosuspend_device(udev);
-
-	return 0;
 }
 
 /**
diff --git a/drivers/visorbus/visorbus_main.c b/drivers/visorbus/visorbus_main.c
index 152fd29f04f2..d4f42afbb3c9 100644
--- a/drivers/visorbus/visorbus_main.c
+++ b/drivers/visorbus/visorbus_main.c
@@ -523,10 +523,8 @@ static void dev_stop_periodic_work(struct visor_device *dev)
  * This is called when device_unregister() is called for each child device
  * instance, to notify the appropriate visorbus function driver that the device
  * is going away, and to decrease the reference count of the device.
- *
- * Return: 0 iff successful
  */
-static int visordriver_remove_device(struct device *xdev)
+static void visordriver_remove_device(struct device *xdev)
 {
 	struct visor_device *dev = to_visor_device(xdev);
 	struct visor_driver *drv = to_visor_driver(xdev->driver);
@@ -537,7 +535,6 @@ static int visordriver_remove_device(struct device *xdev)
 	mutex_unlock(&dev->visordriver_callback_lock);
 	dev_stop_periodic_work(dev);
 	put_device(&dev->device);
-	return 0;
 }
 
 /*
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index ee7ba5b5417e..6a3058d4476a 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -107,7 +107,7 @@ struct device_driver {
 
 	int (*probe) (struct device *dev);
 	void (*sync_state)(struct device *dev);
-	int (*remove) (struct device *dev);
+	void (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
 	int (*resume) (struct device *dev);
diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index 11554d0412f0..62491eb90a0c 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -136,7 +136,7 @@ snd_seq_oss_synth_probe(struct device *_dev)
 }
 
 
-int
+void
 snd_seq_oss_synth_remove(struct device *_dev)
 {
 	struct snd_seq_device *dev = to_seq_dev(_dev);
@@ -152,7 +152,7 @@ snd_seq_oss_synth_remove(struct device *_dev)
 	if (index >= max_synth_devs) {
 		spin_unlock_irqrestore(&register_lock, flags);
 		pr_err("ALSA: seq_oss: can't unregister synth\n");
-		return -EINVAL;
+		return;
 	}
 	synth_devs[index] = NULL;
 	if (index == max_synth_devs - 1) {
@@ -170,8 +170,6 @@ snd_seq_oss_synth_remove(struct device *_dev)
 
 	snd_use_lock_sync(&rec->use_lock);
 	kfree(rec);
-
-	return 0;
 }
 
 
diff --git a/sound/core/seq/oss/seq_oss_synth.h b/sound/core/seq/oss/seq_oss_synth.h
index ffc40d8a7ef1..3aae32b55b6d 100644
--- a/sound/core/seq/oss/seq_oss_synth.h
+++ b/sound/core/seq/oss/seq_oss_synth.h
@@ -16,7 +16,7 @@
 
 void snd_seq_oss_synth_init(void);
 int snd_seq_oss_synth_probe(struct device *dev);
-int snd_seq_oss_synth_remove(struct device *dev);
+void snd_seq_oss_synth_remove(struct device *dev);
 void snd_seq_oss_synth_setup(struct seq_oss_devinfo *dp);
 void snd_seq_oss_synth_setup_midi(struct seq_oss_devinfo *dp);
 void snd_seq_oss_synth_cleanup(struct seq_oss_devinfo *dp);
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 6825940ea2cf..5b6290b3c7f2 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -409,7 +409,7 @@ snd_seq_midisynth_probe(struct device *_dev)
 }
 
 /* release midi synth port */
-static int
+static void
 snd_seq_midisynth_remove(struct device *_dev)
 {
 	struct snd_seq_device *dev = to_seq_dev(_dev);
@@ -422,7 +422,8 @@ snd_seq_midisynth_remove(struct device *_dev)
 	client = synths[card->number];
 	if (client == NULL || client->ports[device] == NULL) {
 		mutex_unlock(&register_mutex);
-		return -ENODEV;
+		dev_warn(_dev, "Failed to find client for this card, ignoring request to remove\n");
+		return;
 	}
 	ports = client->ports_per_device[device];
 	client->ports_per_device[device] = 0;
@@ -438,7 +439,6 @@ snd_seq_midisynth_remove(struct device *_dev)
 		kfree(client);
 	}
 	mutex_unlock(&register_mutex);
-	return 0;
 }
 
 static struct snd_seq_driver seq_midisynth_driver = {
diff --git a/sound/drivers/opl3/opl3_seq.c b/sound/drivers/opl3/opl3_seq.c
index cd2a01b5e2e1..b522c0fef2c4 100644
--- a/sound/drivers/opl3/opl3_seq.c
+++ b/sound/drivers/opl3/opl3_seq.c
@@ -244,14 +244,17 @@ static int snd_opl3_seq_probe(struct device *_dev)
 	return 0;
 }
 
-static int snd_opl3_seq_remove(struct device *_dev)
+static void snd_opl3_seq_remove(struct device *_dev)
 {
 	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_opl3 *opl3;
 
 	opl3 = *(struct snd_opl3 **)SNDRV_SEQ_DEVICE_ARGPTR(dev);
-	if (opl3 == NULL)
-		return -EINVAL;
+	if (opl3 == NULL) {
+		/* I think this cannot happen?! */
+		dev_info(_dev, "ignoring SNDRV_SEQ_DEVICE_ARGPTR being invalid\n");
+		return;
+	}
 
 #if IS_ENABLED(CONFIG_SND_SEQUENCER_OSS)
 	snd_opl3_free_seq_oss(opl3);
@@ -260,7 +263,6 @@ static int snd_opl3_seq_remove(struct device *_dev)
 		snd_seq_delete_kernel_client(opl3->seq_client);
 		opl3->seq_client = -1;
 	}
-	return 0;
 }
 
 static struct snd_seq_driver opl3_seq_driver = {
diff --git a/sound/drivers/opl4/opl4_seq.c b/sound/drivers/opl4/opl4_seq.c
index f59ca660c616..b3d78f74d2d1 100644
--- a/sound/drivers/opl4/opl4_seq.c
+++ b/sound/drivers/opl4/opl4_seq.c
@@ -181,20 +181,21 @@ static int snd_opl4_seq_probe(struct device *_dev)
 	return 0;
 }
 
-static int snd_opl4_seq_remove(struct device *_dev)
+static void snd_opl4_seq_remove(struct device *_dev)
 {
 	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_opl4 *opl4;
 
 	opl4 = *(struct snd_opl4 **)SNDRV_SEQ_DEVICE_ARGPTR(dev);
-	if (!opl4)
-		return -EINVAL;
+	if (!opl4) {
+		dev_info(_dev, "ignoring SNDRV_SEQ_DEVICE_ARGPTR being invalid\n");
+		return;
+	}
 
 	if (opl4->seq_client >= 0) {
 		snd_seq_delete_kernel_client(opl4->seq_client);
 		opl4->seq_client = -1;
 	}
-	return 0;
 }
 
 static struct snd_seq_driver opl4_seq_driver = {
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 765c40a6ccba..1755ee46a005 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -151,9 +151,14 @@ static int hda_ext_drv_probe(struct device *dev)
 	return (get_hdrv(dev))->probe(get_hdev(dev));
 }
 
-static int hdac_ext_drv_remove(struct device *dev)
+static void hdac_ext_drv_remove(struct device *dev)
 {
-	return (get_hdrv(dev))->remove(get_hdev(dev));
+	int ret;
+	ret = get_hdrv(dev)->remove(get_hdev(dev));
+
+	if (ret)
+		dev_info(dev, "Failed to unbind driver (%pe), ignoring\n",
+			 ERR_PTR(ret));
 }
 
 static void hdac_ext_drv_shutdown(struct device *dev)
diff --git a/sound/isa/sb/emu8000_synth.c b/sound/isa/sb/emu8000_synth.c
index 0edfb6875278..bba58ae81a52 100644
--- a/sound/isa/sb/emu8000_synth.c
+++ b/sound/isa/sb/emu8000_synth.c
@@ -81,13 +81,13 @@ static int snd_emu8000_probe(struct device *_dev)
 /*
  * free all resources
  */
-static int snd_emu8000_remove(struct device *_dev)
+static void snd_emu8000_remove(struct device *_dev)
 {
 	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_emu8000 *hw;
 
 	if (dev->driver_data == NULL)
-		return 0; /* no synth was allocated actually */
+		return; /* no synth was allocated actually */
 
 	hw = dev->driver_data;
 	if (hw->pcm)
@@ -96,7 +96,6 @@ static int snd_emu8000_remove(struct device *_dev)
 	snd_util_memhdr_free(hw->memhdr);
 	hw->emu = NULL;
 	hw->memhdr = NULL;
-	return 0;
 }
 
 /*
diff --git a/sound/pci/emu10k1/emu10k1_synth.c b/sound/pci/emu10k1/emu10k1_synth.c
index 549013a4a80b..86d572afecae 100644
--- a/sound/pci/emu10k1/emu10k1_synth.c
+++ b/sound/pci/emu10k1/emu10k1_synth.c
@@ -67,7 +67,7 @@ static int snd_emu10k1_synth_probe(struct device *_dev)
 	return 0;
 }
 
-static int snd_emu10k1_synth_remove(struct device *_dev)
+static void snd_emu10k1_synth_remove(struct device *_dev)
 {
 	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_emux *emux;
@@ -75,7 +75,7 @@ static int snd_emu10k1_synth_remove(struct device *_dev)
 	unsigned long flags;
 
 	if (dev->driver_data == NULL)
-		return 0; /* not registered actually */
+		return; /* not registered actually */
 
 	emux = dev->driver_data;
 
@@ -86,7 +86,6 @@ static int snd_emu10k1_synth_remove(struct device *_dev)
 	spin_unlock_irqrestore(&hw->voice_lock, flags);
 
 	snd_emux_free(emux);
-	return 0;
 }
 
 /*
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 6a8564566375..e97d18bdd662 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -142,21 +142,24 @@ static int hda_codec_driver_probe(struct device *dev)
 	return err;
 }
 
-static int hda_codec_driver_remove(struct device *dev)
+static void hda_codec_driver_remove(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
 	if (codec->bus->core.ext_ops) {
+		int ret;
 		if (WARN_ON(!codec->bus->core.ext_ops->hdev_detach))
-			return -EINVAL;
-		return codec->bus->core.ext_ops->hdev_detach(&codec->core);
+			return;
+		ret = codec->bus->core.ext_ops->hdev_detach(&codec->core);
+		if (ret)
+			dev_warn(dev, "Failed to detach from bus (%pe), ignoring.\n",
+				 ERR_PTR(ret));
 	}
 
 	if (codec->patch_ops.free)
 		codec->patch_ops.free(codec);
 	snd_hda_codec_cleanup_for_unbind(codec);
 	module_put(dev->driver->owner);
-	return 0;
 }
 
 static void hda_codec_driver_shutdown(struct device *dev)

base-commit: 407ab579637ced6dc32cfb2295afb7259cca4b22
-- 
2.28.0

