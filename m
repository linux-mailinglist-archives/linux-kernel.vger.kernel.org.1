Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1253D2179A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgGGUmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 16:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGUmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:42:03 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988CC206F6;
        Tue,  7 Jul 2020 20:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594154523;
        bh=AnGRUUPwqzcwpLs6pEvzN/rJFDFLsWpe3uIVEGqiWr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j2EUy+Xh9X4HarBCOIEDlDUsFtpmrZdVwzS2NDWjlKi4VsuWloS9i5zmnmiW5oSTG
         K3EXcBM9inuude2+oF3BTJOtX9Gb83ucYZnVtHsEn5l4gxgJAUJaEsBiIF0RN4JuNz
         ze09c/EdDdu7pfVYHQ39lSmUG5z8HoARoOkS6lfc=
Date:   Tue, 7 Jul 2020 15:42:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ide: triflex: use generic power management
Message-ID: <20200707204201.GA382915@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703081428.1011527-3-vaibhavgupta40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 01:44:26PM +0530, Vaibhav Gupta wrote:
> While upgrading ide_pci_suspend() and ide_pci_resume(), all other source
> files, using same callbacks, were also updated except
> drivers/ide/triflex.c. This is because the driver does not want to power
> off the device during suspend. A quirk was required for the same.
> 
> This patch provides the fix. Another driver,
> drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c, makes use of
> a quirk for similar goal. Hence a similar quirk has been applied for
> triflex.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/ide/triflex.c | 45 +++++++++++--------------------------------
>  1 file changed, 11 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/ide/triflex.c b/drivers/ide/triflex.c
> index 1886bbfb9e5d..f707f11c296d 100644
> --- a/drivers/ide/triflex.c
> +++ b/drivers/ide/triflex.c
> @@ -100,48 +100,25 @@ static const struct pci_device_id triflex_pci_tbl[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
>  
> -#ifdef CONFIG_PM
> -static int triflex_ide_pci_suspend(struct pci_dev *dev, pm_message_t state)
> -{
> -	/*
> -	 * We must not disable or powerdown the device.
> -	 * APM bios refuses to suspend if IDE is not accessible.
> -	 */
> -	pci_save_state(dev);
> -	return 0;
> -}
> -
> -static int triflex_ide_pci_resume(struct pci_dev *dev)
> +/*
> + * We must not disable or powerdown the device.
> + * APM bios refuses to suspend if IDE is not accessible.
> + */
> +static void triflex_pci_pm_cap_fixup(struct pci_dev *pdev)
>  {
> -	struct ide_host *host = pci_get_drvdata(dev);
> -	int rc;
> -
> -	pci_set_power_state(dev, PCI_D0);
> -
> -	rc = pci_enable_device(dev);
> -	if (rc)
> -		return rc;
> -
> -	pci_restore_state(dev);
> -	pci_set_master(dev);
> -
> -	if (host->init_chipset)
> -		host->init_chipset(dev);
> -
> -	return 0;
> +	dev_info(&pdev->dev, "Disable triflex to be turned off by PCI CORE\n");

I would change this message to "Disabling PCI power management" to be
more like existing messages:

  "PM disabled\n"
  "Disabling PCI power management to avoid bug\n"
  "Disabling PCI power management on camera ISP\n"

> +	pdev->pm_cap = 0;
>  }
> -#else
> -#define triflex_ide_pci_suspend NULL
> -#define triflex_ide_pci_resume NULL
> -#endif
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_COMPAQ,
> +			PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
> +			triflex_pci_pm_cap_fixup);

I don't think this needs to be a fixup.  This could be done in the
probe routine (triflex_init_one()).

Doing it as a fixup means the PCI core will check every PCI device
to see if it matches PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE, which is a
little extra useless overhead and quirks are a little bit magic
because it's not as obvious how they're called.

But since triflex_init_one() is called only for the devices we care
about, you can just do:

  static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
  {
        dev->pm_cap = 0;
	dev_info(...);
        return ide_pci_init_one(dev, &triflex_device, NULL);
  }

>  static struct pci_driver triflex_pci_driver = {
>  	.name		= "TRIFLEX_IDE",
>  	.id_table	= triflex_pci_tbl,
>  	.probe		= triflex_init_one,
>  	.remove		= ide_pci_remove,
> -	.suspend	= triflex_ide_pci_suspend,
> -	.resume		= triflex_ide_pci_resume,
> +	.driver.pm	= &ide_pci_pm_ops,
>  };
>  
>  static int __init triflex_ide_init(void)
> -- 
> 2.27.0
> 
