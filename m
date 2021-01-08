Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1677E2EF3AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbhAHOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:05:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbhAHOFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:05:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFD6422A99;
        Fri,  8 Jan 2021 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610114690;
        bh=dh5AcKItP/thzhpAhb2qn1EWSQN4tGOASKoRBeeHar4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EnWx2tnClfbl5em5LtQDrvSywyJmJ3426Q7Zt6AMTMd98m/R5yPNZAA6rVfIIEL+Z
         tBKoXiljEQOGiNdsnbrvJ7q/+3EuOzCXYtpABHzeArDwvY1iZBrTZI24EM862YvYV2
         mZOZ72OCZ4M97F6gmTT1yUUGDo3beacATrDXd98o=
Date:   Fri, 8 Jan 2021 15:06:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] misc: pvpanic: introduce device capability
Message-ID: <X/hmz0ZdKyvwtq5z@kroah.com>
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
 <20210108135223.2924507-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108135223.2924507-2-pizhenwei@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:52:22PM +0800, zhenwei pi wrote:
> According to pvpanic spec:
> https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/pvpanic.txt
> 
> The guest should determine pvpanic capability by RDPT, so initialize
> capability during device probing. There is no need to register panic
> notifier callback function if no events supported.
> 
> Before sending event to host side, check capability firstly.
> 
> Suggested by Greg KH, use sysfs to expose capability to user space.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  .../ABI/testing/sysfs-bus-pci-devices-pvpanic |  7 ++++
>  drivers/misc/pvpanic.c                        | 41 ++++++++++++++++---
>  2 files changed, 42 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> new file mode 100644
> index 000000000000..5daf1167b1c1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> @@ -0,0 +1,7 @@
> +What:		/sys/devices/pci0000:00/*/QEMU0001:00/capability
> +Date:		Jan 2021
> +Contact:	zhenwei pi <pizhenwei@bytedance.com>
> +Description:
> +		Capabilities of pvpanic device which are supported by
> +		QEMU.
> +		Format: %s.

This really can be 2 values in the string, shouldn't you list what the
file can contain here so that people know what to expect?

> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 951b37da5e3c..e1023c7b8fb0 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -19,6 +19,27 @@
>  #include <uapi/misc/pvpanic.h>
>  
>  static void __iomem *base;
> +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> +
> +static ssize_t capability_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%s%s\n",
> +		capability & PVPANIC_PANICKED ? "PANICKED " : "",
> +		capability & PVPANIC_CRASH_LOADED ? "CRASH_LOADED" : "");
> +}
> +static DEVICE_ATTR_RO(capability);
> +
> +static struct attribute *pvpanic_sysfs_entries[] = {
> +	&dev_attr_capability.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group pvpanic_attribute_group = {
> +	.name = NULL,
> +	.attrs = pvpanic_sysfs_entries,
> +};
> +
>  
>  MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
>  MODULE_DESCRIPTION("pvpanic device driver");
> @@ -27,7 +48,8 @@ MODULE_LICENSE("GPL");
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -	iowrite8(event, base);
> +	if (event & capability)
> +		iowrite8(event, base);
>  }
>  
>  static int
> @@ -62,17 +84,24 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -				       &pvpanic_panic_nb);
> +	/* initlize capability by RDPT */
> +	capability &= ioread8(base);
>  
> -	return 0;
> +	if (capability)
> +		atomic_notifier_chain_register(&panic_notifier_list,
> +					       &pvpanic_panic_nb);
> +
> +	return sysfs_create_group(&dev->kobj, &pvpanic_attribute_group);

You just raced with userspace and lost :(

If you ever find yourself calling a sysfs_* function in a driver, that
is a huge hint that you are not doing something correctly.  Please just
set the default groups of your platform driver to this group, and the
driver core will handle all of the file creation/removal automatically
for you, in a race-free way.

thanks,

greg k-h
