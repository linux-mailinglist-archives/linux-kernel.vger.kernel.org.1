Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3E323F75B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHHLUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Aug 2020 07:20:49 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:58760 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHHLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 07:20:04 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 2B8B220021;
        Sat,  8 Aug 2020 13:19:36 +0200 (CEST)
Date:   Sat, 8 Aug 2020 13:19:34 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 02/12] fbdev: lxfb: use generic power management
Message-ID: <20200808111934.GB24172@ravnborg.org>
References: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
 <20200805180722.244008-3-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805180722.244008-3-vaibhavgupta40@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=9vxFon6PXiDQMAcgzJ0A:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaibhav

On Wed, Aug 05, 2020 at 11:37:12PM +0530, Vaibhav Gupta wrote:
> Drivers using legacy power management .suspen()/.resume() callbacks
> have to manage PCI states and device's PM states themselves. They also
> need to take care of standard configuration registers.
> 
> Switch to generic power management framework using a single
> "struct dev_pm_ops" variable to take the unnecessary load from the driver.
> This also avoids the need for the driver to directly call most of the PCI
> helper functions and device power state control functions, as through
> the generic framework PCI Core takes care of the necessary operations,
> and drivers are required to do only device-specific jobs.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Some of the same comments from fxfb applies to lxfb.
Please address these and re-submit.

	Sam

> ---
>  drivers/video/fbdev/geode/lxfb.h      |  5 ----
>  drivers/video/fbdev/geode/lxfb_core.c | 37 +++++++++++++++------------
>  drivers/video/fbdev/geode/lxfb_ops.c  |  4 ---
>  3 files changed, 20 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/video/fbdev/geode/lxfb.h b/drivers/video/fbdev/geode/lxfb.h
> index ef24bf6d49dc..d37b32dbcd68 100644
> --- a/drivers/video/fbdev/geode/lxfb.h
> +++ b/drivers/video/fbdev/geode/lxfb.h
> @@ -29,7 +29,6 @@ struct lxfb_par {
>  	void __iomem *gp_regs;
>  	void __iomem *dc_regs;
>  	void __iomem *vp_regs;
> -#ifdef CONFIG_PM
>  	int powered_down;
>  
>  	/* register state, for power mgmt functionality */
> @@ -50,7 +49,6 @@ struct lxfb_par {
>  	uint32_t hcoeff[DC_HFILT_COUNT * 2];
>  	uint32_t vcoeff[DC_VFILT_COUNT];
>  	uint32_t vp_coeff[VP_COEFF_SIZE / 4];
> -#endif
>  };
>  
>  static inline unsigned int lx_get_pitch(unsigned int xres, int bpp)
> @@ -64,11 +62,8 @@ int lx_blank_display(struct fb_info *, int);
>  void lx_set_palette_reg(struct fb_info *, unsigned int, unsigned int,
>  			unsigned int, unsigned int);
>  
> -#ifdef CONFIG_PM
>  int lx_powerdown(struct fb_info *info);
>  int lx_powerup(struct fb_info *info);
> -#endif
> -
>  
>  /* Graphics Processor registers (table 6-29 from the data book) */
>  enum gp_registers {
> diff --git a/drivers/video/fbdev/geode/lxfb_core.c b/drivers/video/fbdev/geode/lxfb_core.c
> index adc2d9c2395e..66c81262d18f 100644
> --- a/drivers/video/fbdev/geode/lxfb_core.c
> +++ b/drivers/video/fbdev/geode/lxfb_core.c
> @@ -443,17 +443,14 @@ static struct fb_info *lxfb_init_fbinfo(struct device *dev)
>  	return info;
>  }
>  
> -#ifdef CONFIG_PM
> -static int lxfb_suspend(struct pci_dev *pdev, pm_message_t state)
> +static int __maybe_unused lxfb_suspend(struct device *dev)
>  {
> -	struct fb_info *info = pci_get_drvdata(pdev);
> +	struct fb_info *info = dev_get_drvdata(dev);
>  
> -	if (state.event == PM_EVENT_SUSPEND) {
> -		console_lock();
> -		lx_powerdown(info);
> -		fb_set_suspend(info, 1);
> -		console_unlock();
> -	}
> +	console_lock();
> +	lx_powerdown(info);
> +	fb_set_suspend(info, 1);
> +	console_unlock();
>  
>  	/* there's no point in setting PCI states; we emulate PCI, so
>  	 * we don't end up getting power savings anyways */
> @@ -461,9 +458,9 @@ static int lxfb_suspend(struct pci_dev *pdev, pm_message_t state)
>  	return 0;
>  }
>  
> -static int lxfb_resume(struct pci_dev *pdev)
> +static int __maybe_unused lxfb_resume(struct device *dev)
>  {
> -	struct fb_info *info = pci_get_drvdata(pdev);
> +	struct fb_info *info = dev_get_drvdata(dev);
>  	int ret;
>  
>  	console_lock();
> @@ -477,10 +474,6 @@ static int lxfb_resume(struct pci_dev *pdev)
>  	console_unlock();
>  	return 0;
>  }
> -#else
> -#define lxfb_suspend NULL
> -#define lxfb_resume NULL
> -#endif
>  
>  static int lxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> @@ -600,13 +593,23 @@ static struct pci_device_id lxfb_id_table[] = {
>  
>  MODULE_DEVICE_TABLE(pci, lxfb_id_table);
>  
> +static const struct dev_pm_ops lxfb_pm_ops = {
> +#ifdef CONFIG_PM_SLEEP
> +	.suspend	= lxfb_suspend,
> +	.resume		= lxfb_resume,
> +	.freeze		= NULL,
> +	.thaw		= lxfb_resume,
> +	.poweroff	= NULL,
> +	.restore	= lxfb_resume,
> +#endif
> +};
> +
>  static struct pci_driver lxfb_driver = {
>  	.name		= "lxfb",
>  	.id_table	= lxfb_id_table,
>  	.probe		= lxfb_probe,
>  	.remove		= lxfb_remove,
> -	.suspend	= lxfb_suspend,
> -	.resume		= lxfb_resume,
> +	.driver.pm	= &lxfb_pm_ops,
>  };
>  
>  #ifndef MODULE
> diff --git a/drivers/video/fbdev/geode/lxfb_ops.c b/drivers/video/fbdev/geode/lxfb_ops.c
> index 5be8bc62844c..b3a041fce570 100644
> --- a/drivers/video/fbdev/geode/lxfb_ops.c
> +++ b/drivers/video/fbdev/geode/lxfb_ops.c
> @@ -580,8 +580,6 @@ int lx_blank_display(struct fb_info *info, int blank_mode)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -
>  static void lx_save_regs(struct lxfb_par *par)
>  {
>  	uint32_t filt;
> @@ -837,5 +835,3 @@ int lx_powerup(struct fb_info *info)
>  	par->powered_down = 0;
>  	return 0;
>  }
> -
> -#endif
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
