Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF62B2F0606
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 09:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAJIkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 03:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbhAJIkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 03:40:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D0AF23108;
        Sun, 10 Jan 2021 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610267981;
        bh=7IwDG2usy/oykAkzEN3CCqnxLOEYuGGq8AomKeUOZZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1GaD7vZV6SdGUOFJ8jaTAoXOka4aWfVLd7NG+dwwm7rdYEnF/CXtTf2JMziAyX1V
         9MsynHj80OO7XEJyhHiqI1exTGqVQ3mMPzk/iu4F7D3wlPDevFG9RCq2wv2MQixpld
         yKPSZgr+/lNjQ231+LDKqa/bZJzAYnnHpbi0fI+k=
Date:   Sun, 10 Jan 2021 09:39:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] misc: pvpanic: introduce device capability
Message-ID: <X/q9SQllBgySgDd2@kroah.com>
References: <20210110053719.3038348-1-pizhenwei@bytedance.com>
 <20210110053719.3038348-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110053719.3038348-2-pizhenwei@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 01:37:18PM +0800, zhenwei pi wrote:
> According to pvpanic spec:
> https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/pvpanic.txt
> 
> The guest should determine pvpanic capability by RDPT, so initialize
> capability during device probing. There is no need to register panic
> notifier callback function if no events supported.
> 
> Before sending event to host side, check capability firstly.
> 
> Suggested by Greg KH, use sysfs to expose capability to user space,
> also add new sysfs attribute in document.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  .../ABI/testing/sysfs-bus-pci-devices-pvpanic |  7 ++++
>  drivers/misc/pvpanic.c                        | 33 ++++++++++++++++---
>  2 files changed, 35 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> new file mode 100644
> index 000000000000..57d014a2c339
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
> @@ -0,0 +1,7 @@
> +What:		/sys/devices/pci0000:00/*/QEMU0001:00/capability
> +Date:		Jan 2021
> +Contact:	zhenwei pi <pizhenwei@bytedance.com>
> +Description:
> +		Read-only attribute. Capabilities of pvpanic device
> +		which are supported by QEMU.
> +		Format: %s.

Again, you are not saying exactly what the %s is, shouldn't you?  And
this does NOT match with the code below :(

> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 951b37da5e3c..c2f6a9e866b3 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -19,6 +19,22 @@
>  #include <uapi/misc/pvpanic.h>
>  
>  static void __iomem *base;
> +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> +
> +static ssize_t capability_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%s%s",
> +		capability & PVPANIC_PANICKED ? "PANICKED[BIT 0]\n" : "",
> +		capability & PVPANIC_CRASH_LOADED ? "CRASH_LOADED[BIT 1]\n" : "");

Why do you have "BIT X" in here?  Why would userspace care?

The rule for sysfs is "one value per file".  You just printed out
multiple lines.  Not good, and totally not allowed.

Also please use sysfs_emit().

thanks,

greg k-h
