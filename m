Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3165A1D1D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbgEMS1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733310AbgEMS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:27:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05949C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:27:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so29699010wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kWJEB6/3+uM87XdqBfhZov9wO73JOwlblRPHRb3IRmA=;
        b=fbDosHi4R8zgk6cAkz1Ve4WNS7+g6rEbQW3/1GKJKh1+rs42YzIvGUeFDeK7l2oU8X
         83+VInicx5TA1EDhI7x4M1ytqklIAONcNCCh2j8KVvV2a/5WWOrv1ukS4MPOvAxcy7zr
         ResK8gwZcLBpFDPle64uTSI/wx1vNttB7E6aYgOaYJaQklbuJL4hhnRPnDNIA7OSbJuN
         EIkFy83I90SU1toAeAmEidX1mwem209bwdf9u1jNUWE5lBwgSHC+qB6WL8aitRLNWjgz
         AxEJkAnSWR8ufi24+r8FzgfgXIVTc2lOws0L+W3QUL9iV+xLT038dqCa2Uk0OjA3tr+x
         hrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kWJEB6/3+uM87XdqBfhZov9wO73JOwlblRPHRb3IRmA=;
        b=Rjec3gcjq0K1CHIpNWkJAzaVcB8PqUGbnLybeOOmmwKhqy2ieB3ghDDws7Bj8xM/B/
         rN7/g1BE/BFEds/Gnf758H+sUC9/Vpc5fm9pFs4/JJFtLlzxXloukJHAbdpKGzTg2Btz
         DMm8zQmPwAIR0EJaneS5XkesqtDWGRQAZcWSvnSVrxRw6cgzqnoUjHY/9x112JTHGQ9w
         jJU1P6jm4JN0ZyzzRHxhRD5KmtwHLGF3IOoX6r+Ww17kKgLzCeXpPQdqjla2yH2pmyQb
         y8lig/XL22yUYgwFGaSXZ+lURGcw98jNOziAAq6PUe/bXttBnnPcu/zs6mbo4mVF6upY
         RxUA==
X-Gm-Message-State: AGi0PubCqzzcfw5y2UZNffo1WPkA/oHi2AEOuWbNePMSnRk2PMMc+Yxr
        OOPg6SEvJYjHYlsQqcA986axn0mqUEw=
X-Google-Smtp-Source: APiQypKehlR4umB2521Qk+5pAdomTM5DnRvKw7fQuUydp1NLb8CcVu9nwP55HmmsIPMmA88NPztWbA==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr27741449wma.15.1589394473600;
        Wed, 13 May 2020 11:27:53 -0700 (PDT)
Received: from localhost.localdomain ([62.31.71.236])
        by smtp.gmail.com with ESMTPSA id p8sm453037wre.11.2020.05.13.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:27:52 -0700 (PDT)
Message-ID: <c4602e6768377179ff3204ea0c2d5944e6d35844.camel@gmail.com>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
From:   Richard Hughes <hughsient@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     ptyser@xes-inc.com, Lee Jones <lee.jones@linaro.org>,
        tudor.ambarus@microchip.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 13 May 2020 19:27:50 +0100
In-Reply-To: <20200513162513.GI2571@lahna.fi.intel.com>
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
         <20200513070847.GM2571@lahna.fi.intel.com>
         <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
         <20200513091100.GY2571@lahna.fi.intel.com>
         <CAD2FfiGNErUhz=7DH6Z37X573hSkJkzbOEXbb++X+Ey5WLc9=Q@mail.gmail.com>
         <20200513162513.GI2571@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-13 at 19:25 +0300, Mika Westerberg wrote:
> This may be problematic if there is driver bound to the device and
> accessing the hardware simultaneusly. Although this is just read side
> and I don't think these registers have any side effects when you read
> them, so should not be an issue.

Right, agreed.

> > So Cannon Lake, Cannon Point and Ice Lake would go into
> > drivers/mtd/spi-nor/controllers/intel-spi-pci.c and the systems
> > like
> > Sunrise Point using an ISA bridge would use drivers/mfd/lpc_ich.c?
> 
> Yes, something like that.

Okay, lets get lpc_ich.c sorted, then I'll look at implementing the
same securityfs interface for intel-spi-pci.c

> I would like to keep it (the label) there but I think we can label
> SPI_INTEL_SPI with that instead and then make the -pci.c to work
> standalone if CONFIG_SPI_INTEL_SPI is not enabled.

Okay, good idea. I'll have a look at this next week after we get the
ISB bridges agreed on.

New patch here, if you want me to split it up a bit please just ask how
you would like it split. I fear Evolution is mangling the patch so I
might have to indeed start using git-send-email. :(

Thanks,

Richard.

From 0b395efde8da7d5099c87945def473ff164d1c4c Mon Sep 17 00:00:00 2001
From: Richard Hughes <richard@hughsie.com>
Date: Mon, 11 May 2020 14:19:27 +0100
Subject: [PATCH] mfd: Export LPC attributes for the system SPI chip

Export standard SPI-specific config values from various LPC
controllers.
This allows userspace components such as fwupd to verify the most basic
SPI
protections are set correctly. For instance, checking BIOSWE is
disabled
and BLE is enabled.

Exporting these values from the kernel allows us to report the security
level of the platform without rebooting and running an EFI binary like
chipsec.

Signed-off-by: Richard Hughes <richard@hughsie.com>
---
 Documentation/ABI/testing/sysfs-security-spi |  23 +++
 drivers/mfd/lpc_ich.c                        | 169 ++++++++++++++++++-
 include/linux/platform_data/intel-spi.h      |   1 +
 3 files changed, 187 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-security-spi

diff --git a/Documentation/ABI/testing/sysfs-security-spi
b/Documentation/ABI/testing/sysfs-security-spi
new file mode 100644
index 000000000000..6805b74d7036
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-security-spi
@@ -0,0 +1,23 @@
+What:		/sys/kernel/security/firmware/bioswe
+Date:		May 2020
+KernelVersion:	5.7.0
+Contact:	richard@hughsie.com
+Description:	If the system firmware set BIOS Write Enable.
+		0: writes disabled, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/kernel/security/firmware/ble
+Date:		May 2020
+KernelVersion:	5.7.0
+Contact:	richard@hughsie.com
+Description:	If the system firmware set Bios Lock Enable.
+		0: SMM lock disabled, 1: SMM lock enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/kernel/security/firmware/smm_bwp
+Date:		May 2020
+KernelVersion:	5.7.0
+Contact:	richard@hughsie.com
+Description:	If the system firmware set SMM Bios Write Protect.
+		0: writes disabled unless in SMM, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 3bbb29a7e7a5..fab017efdb9d 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -33,6 +33,7 @@
  *	document number 322169-001, 322170-003: 5 Series, 3400 Series
(PCH)
  *	document number 320066-003, 320257-008: EP80597 (IICH)
  *	document number 324645-001, 324646-001: Cougar Point (CPT)
+ *	document number 332690-006, 332691-003: C230 (CPT)
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -40,6 +41,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/security.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/mfd/core.h>
@@ -68,6 +70,8 @@
 #define SPIBASE_LPT_SZ		512
 #define BCR			0xdc
 #define BCR_WPD			BIT(0)
+#define BCR_BLE			BIT(1)
+#define BCR_SMM_BWP		BIT(5)
 
 #define SPIBASE_APL_SZ		4096
 
@@ -93,6 +97,11 @@ struct lpc_ich_priv {
 	int abase_save;		/* Cached ACPI base value */
 	int actrl_pbase_save;		/* Cached ACPI control or PMC
base value */
 	int gctrl_save;		/* Cached GPIO control value */
+
+	struct dentry *firmware_dir;	/* SecurityFS entries */
+	struct dentry *firmware_bioswe;
+	struct dentry *firmware_ble;
+	struct dentry *firmware_smm_bwp;
 };
 
 static struct resource wdt_ich_res[] = {
@@ -221,6 +230,9 @@ enum lpc_chipsets {
 	LPC_APL,	/* Apollo Lake SoC */
 	LPC_GLK,	/* Gemini Lake SoC */
 	LPC_COUGARMOUNTAIN,/* Cougar Mountain SoC*/
+	LPC_SPT,	/* Sunrise Point */
+	LPC_KBL,	/* Kaby Lake */
+	LPC_TGL,	/* Tiger Lake */
 };
 
 static struct lpc_ich_info lpc_chipset_info[] = {
@@ -557,6 +569,18 @@ static struct lpc_ich_info lpc_chipset_info[] = {
 		.name = "Cougar Mountain SoC",
 		.iTCO_version = 3,
 	},
+	[LPC_SPT] = {
+		.name = "Sunrise Point",
+		.spi_type = INTEL_SPI_LPC,
+	},
+	[LPC_KBL] = {
+		.name = "Kaby Lake-H",
+		.spi_type = INTEL_SPI_LPC,
+	},
+	[LPC_TGL] = {
+		.name = "Tiger Lake",
+		.spi_type = INTEL_SPI_LPC,
+	},
 };
 
 /*
@@ -792,6 +816,32 @@ static const struct pci_device_id lpc_ich_ids[] =
{
 	{ PCI_VDEVICE(INTEL, 0x9cc6), LPC_WPT_LP},
 	{ PCI_VDEVICE(INTEL, 0x9cc7), LPC_WPT_LP},
 	{ PCI_VDEVICE(INTEL, 0x9cc9), LPC_WPT_LP},
+	{ PCI_VDEVICE(INTEL, 0x9ce6), LPC_WPT_LP},
+	{ PCI_VDEVICE(INTEL, 0x9d2a), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0x9d4e), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa0a4), LPC_TGL},
+	{ PCI_VDEVICE(INTEL, 0xa140), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa141), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa142), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa143), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa144), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa145), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa146), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa147), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa148), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa149), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa14a), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa14b), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa14c), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa14d), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa14e), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa14f), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa150), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa151), LPC_SPT},
+	{ PCI_VDEVICE(INTEL, 0xa152), LPC_KBL},
+	{ PCI_VDEVICE(INTEL, 0xa153), LPC_KBL},
+	{ PCI_VDEVICE(INTEL, 0xa154), LPC_KBL},
+	{ PCI_VDEVICE(INTEL, 0xa155), LPC_SPT},
 	{ PCI_VDEVICE(INTEL, 0xa1c1), LPC_LEWISBURG},
 	{ PCI_VDEVICE(INTEL, 0xa1c2), LPC_LEWISBURG},
 	{ PCI_VDEVICE(INTEL, 0xa1c3), LPC_LEWISBURG},
@@ -1083,6 +1133,103 @@ static int lpc_ich_init_wdt(struct pci_dev
*dev)
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_SECURITY)
+static ssize_t bioswe_read(struct file *filp, char __user *buf,
+			   size_t count, loff_t *ppos)
+{
+	struct pci_dev *dev = filp->f_inode->i_private;
+	char tmp[3];
+	u32 bcr;
+
+	pci_read_config_dword(dev, BCR, &bcr);
+	sprintf(tmp, "%d\n", bcr & BCR_WPD ? 1 : 0);
+	return simple_read_from_buffer(buf, count, ppos, tmp,
sizeof(tmp));
+}
+
+static const struct file_operations spi_bioswe_ops = {
+	.read  = bioswe_read,
+};
+
+static ssize_t ble_read(struct file *filp, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct pci_dev *dev = filp->f_inode->i_private;
+	char tmp[3];
+	u32 bcr;
+
+	pci_read_config_dword(dev, BCR, &bcr);
+	sprintf(tmp, "%d\n", bcr & BCR_BLE ? 1 : 0);
+	return simple_read_from_buffer(buf, count, ppos, tmp,
sizeof(tmp));
+}
+
+static const struct file_operations spi_ble_ops = {
+	.read  = ble_read,
+};
+
+static ssize_t smm_bwp_read(struct file *filp, char __user *buf,
+			    size_t count, loff_t *ppos)
+{
+	struct pci_dev *dev = filp->f_inode->i_private;
+	char tmp[3];
+	u32 bcr;
+
+	pci_read_config_dword(dev, BCR, &bcr);
+	sprintf(tmp, "%d\n", bcr & BCR_SMM_BWP ? 1 : 0);
+	return simple_read_from_buffer(buf, count, ppos, tmp,
sizeof(tmp));
+}
+
+static const struct file_operations spi_smm_bwp_ops = {
+	.read  = smm_bwp_read,
+};
+
+static int lpc_ich_init_securityfs(struct pci_dev *dev)
+{
+	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
+
+	priv->firmware_dir = securityfs_create_dir("firmware", NULL);
+	if (IS_ERR(priv->firmware_dir))
+		return -1;
+
+	priv->firmware_bioswe =
+	    securityfs_create_file("bioswe",
+				   0600, priv->firmware_dir, dev,
+				   &spi_bioswe_ops);
+	if (IS_ERR(priv->firmware_bioswe))
+		goto out;
+	priv->firmware_ble =
+	    securityfs_create_file("ble",
+				   0600, priv->firmware_dir, dev,
+				   &spi_ble_ops);
+	if (IS_ERR(priv->firmware_ble))
+		goto out;
+	priv->firmware_smm_bwp =
+	    securityfs_create_file("smm_bwp",
+				   0600, priv->firmware_dir, dev,
+				   &spi_smm_bwp_ops);
+	if (IS_ERR(priv->firmware_smm_bwp))
+		goto out;
+	return 0;
+out:
+	securityfs_remove(priv->firmware_ble);
+	securityfs_remove(priv->firmware_bioswe);
+	securityfs_remove(priv->firmware_dir);
+	return -1;
+}
+
+static void lpc_ich_uninit_securityfs(struct pci_dev *dev)
+{
+	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
+
+	securityfs_remove(priv->firmware_smm_bwp);
+	securityfs_remove(priv->firmware_ble);
+	securityfs_remove(priv->firmware_bioswe);
+	securityfs_remove(priv->firmware_dir);
+}
+#else
+static inline int lpc_ich_init_securityfs(struct pci_dev *dev) {
return 0; }
+static inline void lpc_ich_uninit_securityfs(struct pci_dev *dev) {
return 0; }
+#endif
+
 static int lpc_ich_init_spi(struct pci_dev *dev)
 {
 	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
@@ -1111,10 +1258,14 @@ static int lpc_ich_init_spi(struct pci_dev
*dev)
 			spi_base = round_down(rcba, SPIBASE_LPT_SZ);
 			res->start = spi_base + SPIBASE_LPT;
 			res->end = res->start + SPIBASE_LPT_SZ - 1;
-
-			pci_read_config_dword(dev, BCR, &bcr);
-			info->writeable = !!(bcr & BCR_WPD);
 		}
+		pci_read_config_dword(dev, BCR, &bcr);
+		info->writeable = !!(bcr & BCR_WPD);
+		break;
+
+	case INTEL_SPI_LPC:
+		pci_read_config_dword(dev, BCR, &bcr);
+		info->writeable = !!(bcr & BCR_WPD);
 		break;
 
 	case INTEL_SPI_BXT: {
@@ -1146,8 +1297,10 @@ static int lpc_ich_init_spi(struct pci_dev *dev)
 		return -EINVAL;
 	}
 
-	if (!res->start)
-		return -ENODEV;
+	if (info->type != INTEL_SPI_LPC) {
+		if (!res->start)
+			return -ENODEV;
+	}
 
 	lpc_ich_spi_cell.platform_data = info;
 	lpc_ich_spi_cell.pdata_size = sizeof(*info);
@@ -1201,8 +1354,11 @@ static int lpc_ich_probe(struct pci_dev *dev,
 
 	if (lpc_chipset_info[priv->chipset].spi_type) {
 		ret = lpc_ich_init_spi(dev);
-		if (!ret)
+		if (!ret) {
+			if (lpc_ich_init_securityfs(dev))
+				return -EINVAL;
 			cell_added = true;
+		}
 	}
 
 	/*
@@ -1221,6 +1377,7 @@ static int lpc_ich_probe(struct pci_dev *dev,
 static void lpc_ich_remove(struct pci_dev *dev)
 {
 	mfd_remove_devices(&dev->dev);
+	lpc_ich_uninit_securityfs(dev);
 	lpc_ich_restore_config_space(dev);
 }
 
diff --git a/include/linux/platform_data/intel-spi.h
b/include/linux/platform_data/intel-spi.h
index 7f53a5c6f35e..ed5b527cf1c6 100644
--- a/include/linux/platform_data/intel-spi.h
+++ b/include/linux/platform_data/intel-spi.h
@@ -14,6 +14,7 @@ enum intel_spi_type {
 	INTEL_SPI_LPT,
 	INTEL_SPI_BXT,
 	INTEL_SPI_CNL,
+	INTEL_SPI_LPC,
 };
 
 /**
-- 
2.26.2




