Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC052F060C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 09:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhAJImD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 03:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbhAJImC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 03:42:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39A0723108;
        Sun, 10 Jan 2021 08:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610268082;
        bh=KXN+CQFfQ84t1Sozw1DkLW3at94VjvOZ5kl2CHgtYD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwgIVEX/3mh9KzW+ZrrXmrwLGLyhIKrolvvGjjj8umeF3P8On2OpZQYOslQrpgaCv
         Jxi2Wy5fldtWOBWxk2xhC1xAC7Uiv6Slnh5p7L87IgCquQJJPlysvsGBkMg+YJkfHy
         fhfZ1ivRxLBwkx9Ee1PmqHKF04TKi2mUdDyZk5Lk=
Date:   Sun, 10 Jan 2021 09:41:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] misc: pvpanic: introduce events device attribue
Message-ID: <X/q9rrN6/pGnmZQl@kroah.com>
References: <20210110053719.3038348-1-pizhenwei@bytedance.com>
 <20210110053719.3038348-3-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110053719.3038348-3-pizhenwei@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 01:37:19PM +0800, zhenwei pi wrote:
> Suggested by Paolo & Greg, add 'events' device attribute that can be
> used to limit which capabilities the driver uses.
> 
> Finally, the pvpanic guest driver works by the limitation of both
> device capability and user setting.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  .../ABI/testing/sysfs-bus-pci-devices-pvpanic |  7 +++++
>  drivers/misc/pvpanic.c                        | 26 ++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> index 57d014a2c339..4750cfa0af2b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> @@ -5,3 +5,10 @@ Description:
>  		Read-only attribute. Capabilities of pvpanic device
>  		which are supported by QEMU.
>  		Format: %s.
> +
> +What:          /sys/devices/pci0000:00/*/QEMU0001:00/events
> +Date:          Jan 2021
> +Contact:       zhenwei pi <pizhenwei@bytedance.com>
> +Description:
> +               RW attribute. Set/get which features in-use.
> +               Format: %x.

Please describe the allowed values.

> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index c2f6a9e866b3..07a008e15bd2 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -19,8 +19,31 @@
>  #include <uapi/misc/pvpanic.h>
>  
>  static void __iomem *base;
> +static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>  static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>  
> +static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%x\n", events);
> +}
> +
> +static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	unsigned int tmp;
> +	int err;
> +
> +	err = kstrtouint(buf, 16, &tmp);
> +	if (err)
> +		return err;
> +
> +	events = tmp;
> +
> +	return count;
> +
> +}
> +static DEVICE_ATTR_RW(events);
> +
>  static ssize_t capability_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> @@ -32,6 +55,7 @@ static DEVICE_ATTR_RO(capability);
>  
>  static struct attribute *pvpanic_dev_attrs[] = {
>  	&dev_attr_capability.attr,
> +	&dev_attr_events.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(pvpanic_dev);
> @@ -43,7 +67,7 @@ MODULE_LICENSE("GPL");
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -	if (event & capability)
> +	if (event & capability & events)

That's just going to be so crazy to try to figure out, I'm glad I'm not
a user trying to configure this.

User apis are hard.

thanks,

greg k-h
