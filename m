Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E341D0993
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgEMHJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 03:09:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:32245 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbgEMHJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:09:08 -0400
IronPort-SDR: 98/OobJqlps6txPSd56BET1qc9AhPKHoLue+P3jeL6oFZ2cnK5w/mt6rOSOteBLb4LvkdBkD62
 h6KtJlwzNk9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 00:08:52 -0700
IronPort-SDR: uZDSNpoxpFZ/EKyf0tOKyBkR34w+l1xNhQm74Iqocaz+L/tpM4cpTml+YcGIaHFth6afqq42fh
 7AQtdIJ6p8OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400"; 
   d="scan'208";a="371815356"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 13 May 2020 00:08:48 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 13 May 2020 10:08:47 +0300
Date:   Wed, 13 May 2020 10:08:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     ptyser@xes-inc.com, lee.jones@linaro.org,
        tudor.ambarus@microchip.com, kstewart@linuxfoundation.org,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
Message-ID: <20200513070847.GM2571@lahna.fi.intel.com>
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, May 12, 2020 at 09:42:43PM +0100, Richard Hughes wrote:
> Export standard SPI-specific config values from various LPC
> controllers.
> This allows userspace components such as fwupd to verify the most basic
> SPI
> protections are set correctly. For instance, checking BIOSWE is
> disabled
> and BLE is enabled.
> 
> Exporting these values from the kernel allows us to report the security
> level of the platform without rebooting and running an EFI binary like
> chipsec.
> 
> Signed-off-by: Richard Hughes <richard@hughsie.com>
> ---
>  Documentation/ABI/testing/sysfs-security-spi |  17 ++
>  drivers/mfd/lpc_ich.c                        | 225 ++++++++++++++++++-
>  include/linux/platform_data/intel-spi.h      |   7 +-
>  3 files changed, 242 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-security-spi
> 
> diff --git a/Documentation/ABI/testing/sysfs-security-spi
> b/Documentation/ABI/testing/sysfs-security-spi
> new file mode 100644
> index 000000000000..ee867b1366f9
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-security-spi
> @@ -0,0 +1,17 @@
> +What:           /sys/kernel/security/spi/bioswe
> +Date:           May 2020

I think this one should contain KernelVersion as well, see
Documentation/ABI/README.

> +Contact:        platform-driver-x86@vger.kernel.org
> +Description:    If the system firmware set BIOS Write Enable.
> +		0: writes disabled, 1: writes enabled.
> +
> +What:           /sys/kernel/security/spi/ble
> +Date:           May 2020
> +Contact:        platform-driver-x86@vger.kernel.org
> +Description:    If the system firmware set Bios Lock Enable.
> +		0: SMM lock disabled, 1: SMM lock enabled.
> +
> +What:           /sys/kernel/security/spi/smm_bwp
> +Date:           May 2020
> +Contact:        platform-driver-x86@vger.kernel.org
> +Description:    If the system firmware set SMM Bios Write Protect.
> +		0: writes disabled unless in SMM, 1: writes enabled.
> diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> index 3bbb29a7e7a5..e9a97c461d9a 100644
> --- a/drivers/mfd/lpc_ich.c
> +++ b/drivers/mfd/lpc_ich.c
> @@ -33,6 +33,8 @@
>   *	document number 322169-001, 322170-003: 5 Series, 3400 Series
> (PCH)
>   *	document number 320066-003, 320257-008: EP80597 (IICH)
>   *	document number 324645-001, 324646-001: Cougar Point (CPT)
> + *	document number 332690-006, 332691-003: C230 (CPT)
> + *	document number 337867-003, 337868-002: Cannon Point (PCH)
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -46,6 +48,10 @@
>  #include <linux/mfd/lpc_ich.h>
>  #include <linux/platform_data/itco_wdt.h>
>  
> +#if IS_ENABLED(CONFIG_SECURITY)
> +#include <linux/security.h>
> +#endif

I think you can always include this header without #ifs

> +
>  #define ACPIBASE		0x40
>  #define ACPIBASE_GPE_OFF	0x28
>  #define ACPIBASE_GPE_END	0x2f
> @@ -68,6 +74,8 @@
>  #define SPIBASE_LPT_SZ		512
>  #define BCR			0xdc
>  #define BCR_WPD			BIT(0)
> +#define BCR_BLE			BIT(1)
> +#define BCR_SMM_BWP		BIT(5)
>  
>  #define SPIBASE_APL_SZ		4096
>  
> @@ -93,6 +101,13 @@ struct lpc_ich_priv {
>  	int abase_save;		/* Cached ACPI base value */
>  	int actrl_pbase_save;		/* Cached ACPI control or PMC
> base value */
>  	int gctrl_save;		/* Cached GPIO control value */
> +
> +#if IS_ENABLED(CONFIG_SECURITY)
> +	struct dentry *spi_dir;		/* SecurityFS entries */
> +	struct dentry *spi_bioswe;
> +	struct dentry *spi_ble;
> +	struct dentry *spi_smm_bwp;
> +#endif

Maybe these ones can also be added always.

>  };
>  
>  static struct resource wdt_ich_res[] = {
> @@ -221,6 +236,16 @@ enum lpc_chipsets {
>  	LPC_APL,	/* Apollo Lake SoC */
>  	LPC_GLK,	/* Gemini Lake SoC */
>  	LPC_COUGARMOUNTAIN,/* Cougar Mountain SoC*/
> +	LPC_SPT,	/* Sunrise Point */
> +	LPC_KLK,	/* Kaby Lake */

KBL for Kaby Lake

> +	LPC_CNPT,	/* Cannon Point */

CNL for Cannon Lake

> +	LPC_CLK,	/* Comet Lake */

CML for Comet Lake

> +	LPC_ILK,	/* Ice Lake */

ICL for Ice Lake

> +	LPC_ELK,	/* Elkhart Lake */

EHL for Elkhart Lake

> +	LPC_JLK,	/* Jasper Lake */

JSL for Jasper Lake

> +	LPC_TLK,	/* Tiger Lake */

TGL for Tiger Lake

> +	LPC_CNLK,	/* Cannon Lake */

This is redundant with CNL

> +	LPC_CRDG,	/* Cactus Ridge */

This is not PCH, Cactus Ridge is Thunderbolt host controller AFAIK.

>  };
>  
>  static struct lpc_ich_info lpc_chipset_info[] = {
> @@ -557,6 +582,46 @@ static struct lpc_ich_info lpc_chipset_info[] = {
>  		.name = "Cougar Mountain SoC",
>  		.iTCO_version = 3,
>  	},
> +	[LPC_SPT] = {
> +		.name = "Sunrise Point",
> +		.spi_type = INTEL_SPI_LPC,

Problem here and with the rest of the Lakes is that on those systems the
SPI-NOR controller is actually not part of the LPC/eSPI device. Instead
it is a separate PCI device (00:1f.5), not compatible with LPC.

So I don't think we can add these entries here without careful
verification that these are accessible through LPC.

I suggested lpc_ich.c because I think I saw in your previous patch that
you were adding LPC PCI IDs as well. Those are fine to add here. Sorry
if that confused you.

> +	},
> +	[LPC_KLK] = {
> +		.name = "Kaby Lake-H",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_CNPT] = {
> +		.name = "Cannon Point",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_CLK] = {
> +		.name = "Comet Lake",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_ILK] = {
> +		.name = "Ice Lake",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_ELK] = {
> +		.name = "Elkhart Lake",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_JLK] = {
> +		.name = "Jasper Lake",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_TLK] = {
> +		.name = "Tiger Lake",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_CNLK] = {
> +		.name = "Cannon Lake",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_CRDG] = {
> +		.name = "Cactus Ridge",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
>  };
>  
>  /*
> @@ -566,6 +631,8 @@ static struct lpc_ich_info lpc_chipset_info[] = {
>   * functions that probably will be registered by other drivers.
>   */
>  static const struct pci_device_id lpc_ich_ids[] = {
> +	{ PCI_VDEVICE(INTEL, 0x02a4), LPC_CLK},
> +	{ PCI_VDEVICE(INTEL, 0x06a4), LPC_CLK},

For example these PCI IDs are for the SPI-NOR controller (not LPC
controller) so this causes this driver to try to bind to a completely
different device which it cannot handle.

Therefore I suggest adding this feature only for the hardware you can
actually test. At least for starters.

>  	{ PCI_VDEVICE(INTEL, 0x0f1c), LPC_BAYTRAIL},
>  	{ PCI_VDEVICE(INTEL, 0x1c41), LPC_CPT},
>  	{ PCI_VDEVICE(INTEL, 0x1c42), LPC_CPTD},
> @@ -687,6 +754,7 @@ static const struct pci_device_id lpc_ich_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2919), LPC_ICH9M},
>  	{ PCI_VDEVICE(INTEL, 0x3197), LPC_GLK},
>  	{ PCI_VDEVICE(INTEL, 0x2b9c), LPC_COUGARMOUNTAIN},
> +	{ PCI_VDEVICE(INTEL, 0x34a4), LPC_ILK},

Ditto this one.

>  	{ PCI_VDEVICE(INTEL, 0x3a14), LPC_ICH10DO},
>  	{ PCI_VDEVICE(INTEL, 0x3a16), LPC_ICH10R},
>  	{ PCI_VDEVICE(INTEL, 0x3a18), LPC_ICH10},
> @@ -706,6 +774,8 @@ static const struct pci_device_id lpc_ich_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x3b12), LPC_3400},
>  	{ PCI_VDEVICE(INTEL, 0x3b14), LPC_3420},
>  	{ PCI_VDEVICE(INTEL, 0x3b16), LPC_3450},
> +	{ PCI_VDEVICE(INTEL, 0x4b24), LPC_ELK},
> +	{ PCI_VDEVICE(INTEL, 0x4da4), LPC_JLK},
>  	{ PCI_VDEVICE(INTEL, 0x5031), LPC_EP80579},
>  	{ PCI_VDEVICE(INTEL, 0x5ae8), LPC_APL},
>  	{ PCI_VDEVICE(INTEL, 0x8c40), LPC_LPT},
> @@ -785,6 +855,7 @@ static const struct pci_device_id lpc_ich_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x9c45), LPC_LPT_LP},
>  	{ PCI_VDEVICE(INTEL, 0x9c46), LPC_LPT_LP},
>  	{ PCI_VDEVICE(INTEL, 0x9c47), LPC_LPT_LP},
> +	{ PCI_VDEVICE(INTEL, 0x9c66), LPC_CRDG},
>  	{ PCI_VDEVICE(INTEL, 0x9cc1), LPC_WPT_LP},
>  	{ PCI_VDEVICE(INTEL, 0x9cc2), LPC_WPT_LP},
>  	{ PCI_VDEVICE(INTEL, 0x9cc3), LPC_WPT_LP},
> @@ -792,6 +863,33 @@ static const struct pci_device_id lpc_ich_ids[] =
> {
>  	{ PCI_VDEVICE(INTEL, 0x9cc6), LPC_WPT_LP},
>  	{ PCI_VDEVICE(INTEL, 0x9cc7), LPC_WPT_LP},
>  	{ PCI_VDEVICE(INTEL, 0x9cc9), LPC_WPT_LP},
> +	{ PCI_VDEVICE(INTEL, 0x9ce6), LPC_WPT_LP},
> +	{ PCI_VDEVICE(INTEL, 0x9d2a), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0x9d4e), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0x9da4), LPC_CNPT},
> +	{ PCI_VDEVICE(INTEL, 0xa0a4), LPC_TLK},
> +	{ PCI_VDEVICE(INTEL, 0xa140), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa141), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa142), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa143), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa144), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa145), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa146), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa147), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa148), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa149), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14a), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14b), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14c), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14d), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14e), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14f), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa150), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa151), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa152), LPC_KLK},
> +	{ PCI_VDEVICE(INTEL, 0xa153), LPC_KLK},
> +	{ PCI_VDEVICE(INTEL, 0xa154), LPC_KLK},
> +	{ PCI_VDEVICE(INTEL, 0xa155), LPC_SPT},
>  	{ PCI_VDEVICE(INTEL, 0xa1c1), LPC_LEWISBURG},
>  	{ PCI_VDEVICE(INTEL, 0xa1c2), LPC_LEWISBURG},
>  	{ PCI_VDEVICE(INTEL, 0xa1c3), LPC_LEWISBURG},
> @@ -801,6 +899,12 @@ static const struct pci_device_id lpc_ich_ids[] =
> {
>  	{ PCI_VDEVICE(INTEL, 0xa1c7), LPC_LEWISBURG},
>  	{ PCI_VDEVICE(INTEL, 0xa242), LPC_LEWISBURG},
>  	{ PCI_VDEVICE(INTEL, 0xa243), LPC_LEWISBURG},
> +	{ PCI_VDEVICE(INTEL, 0xa304), LPC_CNLK},
> +	{ PCI_VDEVICE(INTEL, 0xa305), LPC_CNLK},
> +	{ PCI_VDEVICE(INTEL, 0xa306), LPC_CNLK},
> +	{ PCI_VDEVICE(INTEL, 0xa30c), LPC_CNLK},
> +	{ PCI_VDEVICE(INTEL, 0xa324), LPC_CNLK},
> +	{ PCI_VDEVICE(INTEL, 0xa3a4), LPC_CLK},
>  	{ 0, },			/* End of list */
>  };
>  MODULE_DEVICE_TABLE(pci, lpc_ich_ids);
> @@ -1083,6 +1187,104 @@ static int lpc_ich_init_wdt(struct pci_dev
> *dev)
>  	return ret;
>  }
>  
> +#if IS_ENABLED(CONFIG_SECURITY)
> +static ssize_t bioswe_read(struct file *filp, char __user *buf,
> +			   size_t count, loff_t *ppos)
> +{
> +	struct intel_spi_boardinfo *info =
> lpc_ich_spi_cell.platform_data;

I think the patch has some wrapping issues.

> +	char tmp[2];

Wouldn't this need to account the '\0' as well?

> +
> +	sprintf(tmp, "%d\n", info->writeable ? 1 : 0);
> +	return simple_read_from_buffer(buf, count, ppos, tmp,
> sizeof(tmp));
> +}
> +
> +static const struct file_operations spi_bioswe_ops = {
> +	.read  = bioswe_read,
> +};
> +
> +static ssize_t ble_read(struct file *filp, char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct intel_spi_boardinfo *info =
> lpc_ich_spi_cell.platform_data;
> +	char tmp[2];
> +
> +	sprintf(tmp, "%d\n", info->ble ? 1 : 0);
> +	return simple_read_from_buffer(buf, count, ppos, tmp,
> sizeof(tmp));
> +}
> +
> +static const struct file_operations spi_ble_ops = {
> +	.read  = ble_read,
> +};
> +
> +static ssize_t smm_bwp_read(struct file *filp, char __user *buf,
> +			    size_t count, loff_t *ppos)
> +{
> +	struct intel_spi_boardinfo *info =
> lpc_ich_spi_cell.platform_data;
> +	char tmp[2];
> +
> +	sprintf(tmp, "%d\n", info->smm_bwp ? 1 : 0);
> +	return simple_read_from_buffer(buf, count, ppos, tmp,
> sizeof(tmp));
> +}
> +
> +static const struct file_operations spi_smm_bwp_ops = {
> +	.read  = smm_bwp_read,
> +};
> +
> +static int lpc_ich_init_securityfs(struct pci_dev *dev)
> +{
> +	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> +
> +	priv->spi_dir = securityfs_create_dir("spi", NULL);

I think "spi" is bit too general name here. I would expect "spi" to
actually refer to something connected to spi bus and possibly coming
from drivers/spi/*.

Perhaps "bios_protections" or something like that.

> +	if (IS_ERR(priv->spi_dir))
> +		return -1;
> +
> +	priv->spi_bioswe =
> +	    securityfs_create_file("bioswe",
> +				   0600, priv->spi_dir, dev,
> +				   &spi_bioswe_ops);
> +	if (IS_ERR(priv->spi_bioswe))
> +		goto out;
> +	priv->spi_ble =
> +	    securityfs_create_file("ble",
> +				   0600, priv->spi_dir, dev,
> +				   &spi_ble_ops);
> +	if (IS_ERR(priv->spi_ble))
> +		goto out;
> +	priv->spi_smm_bwp =
> +	    securityfs_create_file("smm_bwp",
> +				   0600, priv->spi_dir, dev,
> +				   &spi_smm_bwp_ops);
> +	if (IS_ERR(priv->spi_smm_bwp))
> +		goto out;
> +	return 0;
> +out:
> +	securityfs_remove(priv->spi_ble);
> +	securityfs_remove(priv->spi_bioswe);
> +	securityfs_remove(priv->spi_dir);
> +	return -1;

I don't know securityfs well enought but I think -1 is not correct here
and if you want that then maybe -EPERM instead.

> +}
> +
> +static void lpc_ich_uninit_securityfs(struct pci_dev *dev)
> +{
> +	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> +
> +	securityfs_remove(priv->spi_smm_bwp);
> +	securityfs_remove(priv->spi_ble);
> +	securityfs_remove(priv->spi_bioswe);
> +	securityfs_remove(priv->spi_dir);

I wonder if you can simply call 

	securityfs_remove(priv->spi_dir);

and that removes the children automatically? I'm do not know securityfs
so it may not be the case.

> +}
> +#else
> +static inline int lpc_ich_init_securityfs(struct pci_dev *dev) {
> return 0; }
> +static inline void lpc_ich_uninit_securityfs(struct pci_dev *dev) {
> return 0; }
> +#endif
> +
> +static void lpc_ich_init_spi_bcr(struct intel_spi_boardinfo *info, u32
> bcr)
> +{
> +	info->writeable = !!(bcr & BCR_WPD);
> +	info->ble = !!(bcr & BCR_BLE);
> +	info->smm_bwp = !!(bcr & BCR_SMM_BWP);
> +}
> +
>  static int lpc_ich_init_spi(struct pci_dev *dev)
>  {
>  	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> @@ -1112,9 +1314,14 @@ static int lpc_ich_init_spi(struct pci_dev *dev)
>  			res->start = spi_base + SPIBASE_LPT;
>  			res->end = res->start + SPIBASE_LPT_SZ - 1;
>  
> -			pci_read_config_dword(dev, BCR, &bcr);
> -			info->writeable = !!(bcr & BCR_WPD);
>  		}
> +		pci_read_config_dword(dev, BCR, &bcr);
> +		lpc_ich_init_spi_bcr(info, bcr);
> +		break;
> +
> +	case INTEL_SPI_LPC:
> +		pci_read_config_dword(dev, BCR, &bcr);
> +		lpc_ich_init_spi_bcr(info, bcr);
>  		break;
>  
>  	case INTEL_SPI_BXT: {
> @@ -1135,7 +1342,7 @@ static int lpc_ich_init_spi(struct pci_dev *dev)
>  			res->end = res->start + SPIBASE_APL_SZ - 1;
>  
>  			pci_bus_read_config_dword(bus, spi, BCR, &bcr);
> -			info->writeable = !!(bcr & BCR_WPD);
> +			lpc_ich_init_spi_bcr(info, bcr);
>  		}
>  
>  		pci_bus_write_config_byte(bus, p2sb, 0xe1, 0x1);
> @@ -1146,8 +1353,10 @@ static int lpc_ich_init_spi(struct pci_dev *dev)
>  		return -EINVAL;
>  	}
>  
> -	if (!res->start)
> -		return -ENODEV;
> +	if (info->type != INTEL_SPI_LPC) {
> +		if (!res->start)
> +			return -ENODEV;
> +	}
>  
>  	lpc_ich_spi_cell.platform_data = info;
>  	lpc_ich_spi_cell.pdata_size = sizeof(*info);
> @@ -1201,8 +1410,11 @@ static int lpc_ich_probe(struct pci_dev *dev,
>  
>  	if (lpc_chipset_info[priv->chipset].spi_type) {
>  		ret = lpc_ich_init_spi(dev);
> -		if (!ret)
> +		if (!ret) {
> +			if (lpc_ich_init_securityfs(dev))
> +				return -EINVAL;
>  			cell_added = true;
> +		}
>  	}
>  
>  	/*
> @@ -1221,6 +1433,7 @@ static int lpc_ich_probe(struct pci_dev *dev,
>  static void lpc_ich_remove(struct pci_dev *dev)
>  {
>  	mfd_remove_devices(&dev->dev);
> +	lpc_ich_uninit_securityfs(dev);
>  	lpc_ich_restore_config_space(dev);
>  }
>  
> diff --git a/include/linux/platform_data/intel-spi.h
> b/include/linux/platform_data/intel-spi.h
> index 7f53a5c6f35e..049cc726f868 100644
> --- a/include/linux/platform_data/intel-spi.h
> +++ b/include/linux/platform_data/intel-spi.h
> @@ -14,16 +14,21 @@ enum intel_spi_type {
>  	INTEL_SPI_LPT,
>  	INTEL_SPI_BXT,
>  	INTEL_SPI_CNL,
> +	INTEL_SPI_LPC,
>  };
>  
>  /**
>   * struct intel_spi_boardinfo - Board specific data for Intel SPI
> driver
>   * @type: Type which this controller is compatible with
> - * @writeable: The chip is writeable
> + * @writeable: The chip is writeable, a.k.a. BIOSWE
> + * @ble: a SMM is raised when setting BIOSWE
> + * @smm_bwp: the BIOS region is non-writable unless all processors are
> in SMM
>   */
>  struct intel_spi_boardinfo {
>  	enum intel_spi_type type;
>  	bool writeable;
> +	bool ble;
> +	bool smm_bwp;

I don't think these belong here. They should be part of the lpc private
structure instead (lpc_ich_priv).

>  };
>  
>  #endif /* INTEL_SPI_PDATA_H */
> 
