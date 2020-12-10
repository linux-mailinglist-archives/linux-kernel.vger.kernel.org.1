Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E429E2D57E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgLJKIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgLJKHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:07:51 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6569DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:07:11 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i6so4354700otr.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+R0BKNXPvTj1nFldZr2GXCa6oJrNw9G5B1R2rPAsjPI=;
        b=DROLhMd11igzPKGROpyoZx8GhOeWfJ10GHjMvgI1TfLSxgR0lOMBNnmhBPzmS9rVhE
         49A8cTiu/IPXfMdQjU+aBJ1ssSASp36X3hUWT2gmQ6RD/oYvdjbcxmzElyfplWjrP9IV
         /2waUeiw2pnUfzaCEFcXYhlcwHM2ni29yGfKZujHXbar+RmMZu56Z14k66Gb8eImTawX
         fldv1TBfZ8uC8DjF4Y1v2Hx0JJGapoKc+/PdbmxxwT6BygOY8D2VdkGFNvs5cSOWAwyt
         V9cYQQ6JvLe9G1c6GZdV8AZzq3DNFf6HXboBXobpbZFo09PXSCdOogAqXg0275u618/N
         FwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+R0BKNXPvTj1nFldZr2GXCa6oJrNw9G5B1R2rPAsjPI=;
        b=De2g0upIP4GgTv1Q9TOJiRhglXsViyCZJzIWcZxLJcUOqtfCpTARHALp2LNfvzqdz0
         3f1sSMg4jIXi+dkGlb8xLx+4vVwcjboy1+OlgivIMfoS0nnlj4u0RIJwfsyQB+rSKhDR
         MeyG857y9TJmEy54VOKfmZeO3lMmikM9K47aLWxMMPY0KYn6FPBEHubODo9QNbeT8z//
         gc49/+4Kxs+BR8OY/cyVbnk92sdytLQuLxfeEu9A0uN1Rl2AVgT+GIlBTVgtWMbrAmkY
         fgddqfY6hAqZ2k4uCzZJPK52+DyM4+Z4ygq7oE9eb6qZabOVVk7TCKt1bgY3/rc/RL3/
         JwRg==
X-Gm-Message-State: AOAM530ok/FoXWuUKpKOJqG38hx4NCbNCcgerJNVDlsUcOqrLrCa2KCD
        A+O76+8iCN9DyK+uFNk6hGYUcc+GtITG2Oqmsm0UBg==
X-Google-Smtp-Source: ABdhPJykMJlZwbCa+3WZEXeGLMEuLO2WGkjx66cp6MBWDvWJ8qO7UNfYdGcOguCexX06dZ4FLRvqrPK3ejg/7lJuK88=
X-Received: by 2002:a05:6830:916:: with SMTP id v22mr5327040ott.257.1607594830604;
 Thu, 10 Dec 2020 02:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20201210092853.303-1-wangzhiqiang.bj@bytedance.com> <X9HtwHo8s6e2UsAT@kroah.com>
In-Reply-To: <X9HtwHo8s6e2UsAT@kroah.com>
From:   John Wang <wangzhiqiang.bj@bytedance.com>
Date:   Thu, 10 Dec 2020 18:06:59 +0800
Message-ID: <CAH0XSJt3=XJ_gQb2rTvbUcbyow2k7E4jfuKGKAKdi+nwdfauVw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] misc: aspeed: Add Aspeed UART routing
 control driver.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lotus Xu <xuxiaohan@bytedance.com>,
        =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
        Oskar Senft <osk@google.com>,
        Yong Li <yong.b.li@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 5:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 10, 2020 at 05:28:53PM +0800, John Wang wrote:
> > From: Oskar Senft <osk@google.com>
> >
> > This driver adds sysfs files that allow the BMC userspace to configure
> > how UARTs and physical serial I/O ports are routed.
> >
> > Tested: Checked correct behavior (both read & write) on TYAN S7106
> > board by manually changing routing settings and confirming that bits
> > flow as expected. Tested for UART1 and UART3 as this board doesn't have
> > the other UARTs wired up in a testable way.
> >
> > Signed-off-by: Oskar Senft <osk@google.com>
> > Signed-off-by: Yong Li <yong.b.li@linux.intel.com>
> > Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> > ---
> >  .../stable/sysfs-driver-aspeed-uart-routing   |  14 +
> >  .../misc-devices/aspeed-uart-routing.txt      |  49 +++
> >  drivers/misc/Kconfig                          |   6 +
> >  drivers/misc/Makefile                         |   1 +
> >  drivers/misc/aspeed-uart-routing.c            | 383 ++++++++++++++++++
> >  5 files changed, 453 insertions(+)
> >  create mode 100644 Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> >  create mode 100644 Documentation/misc-devices/aspeed-uart-routing.txt
> >  create mode 100644 drivers/misc/aspeed-uart-routing.c
> >
> > diff --git a/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing b/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> > new file mode 100644
> > index 000000000000..5068737d9c12
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> > @@ -0,0 +1,14 @@
> > +What:                /sys/bus/platform/drivers/aspeed-uart-routing/*/io*
> > +Date:                August 2018
> > +Contact:     Oskar Senft <osk@google.com>
> > +Description: Configures the input source for the specific physical
> > +             serial I/O port.
> > +Users:               OpenBMC.  Proposed changes should be mailed to
> > +             openbmc@lists.ozlabs.org
> > +
> > +What:                /sys/bus/platform/drivers/aspeed-uart-routing/*/uart*
> > +Date:                August 2018
> > +Contact:     Oskar Senft <osk@google.com>
> > +Description: Configures the input source for the specific UART.
> > +Users:               OpenBMC.  Proposed changes should be mailed to
> > +             openbmc@lists.ozlabs.org
> > diff --git a/Documentation/misc-devices/aspeed-uart-routing.txt b/Documentation/misc-devices/aspeed-uart-routing.txt
> > new file mode 100644
> > index 000000000000..cf1c2a466875
> > --- /dev/null
> > +++ b/Documentation/misc-devices/aspeed-uart-routing.txt
> > @@ -0,0 +1,49 @@
> > +Kernel driver aspeed-uart-routing
> > +=================================
> > +
> > +Supported chips:
> > +ASPEED AST2500/AST2600
> > +
> > +Author:
> > +Google LLC
> > +
> > +Description
> > +-----------
> > +
> > +The Aspeed AST2500/AST2600 allows to dynamically route the inputs for the
> > +built-in UARTS and physical serial I/O ports.
> > +
> > +This allows, for example, to connect the output of UART to another UART.
> > +This can be used to enable host<->BMC communication via UARTs, e.g. to allow
> > +access to the host's serial console.
> > +
> > +This driver is for the BMC side. The sysfs files allow the BMC userspace
> > +which owns the system configuration policy, to configure how UARTs and
> > +physical serial I/O ports are routed.
> > +
> > +The driver provides the following files in sysfs:
> > +uart1                Configure the input signal to UART1.
> > +uart2                Configure the input signal to UART2.
> > +uart3                Configure the input signal to UART3.
> > +uart4                Configure the input signal to UART4.
> > +uart5                Configure the input signal to UART5.
> > +io1          Configure the input signal to physical serial port 1.
> > +io2          Configure the input signal to physical serial port 2.
> > +io3          Configure the input signal to physical serial port 3.
> > +io4          Configure the input signal to physical serial port 4.
> > +io5          Configure the input signal to physical serial port 5.
> > +
> > +When read, each file shows the list of available options with the currently
> > +selected option marked by square brackets "[]". The list of available options
> > +depends on the selected file.
> > +
> > +Example:
> > +$ cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > +[io1] io2 io3 io4 uart2 uart3 uart4 io6
> > +
> > +In this case, UART1 gets its input signal from IO1 (physical serial port 1).
> > +
> > +$ echo -n "uart3" \
> > +  >/sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > +$ cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > +io1 io2 io3 io4 uart2 [uart3] uart4 io6
>
> Are you sure there are no other ways to configure this type of thing,
> than to a driver-specific sysfs file?

I think this is good. but what's your suggestion?

If I use a driver-specific sysfs and modify the code based on the
comments, is this a good direction to go?

I can maintain this code.

>
>
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index d8626a0d3e31..48a519c59bdf 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -451,6 +451,12 @@ config MCTP_LPC
> >         Implements the MCTP LPC binding via KCS LPC IO cycles for control and
> >            LPC FWH cycles for data
> >
> > +config ASPEED_UART_ROUTING
> > +     tristate "Aspeed ast2500 UART routing control"
> > +     help
> > +       If you want to configure UART routing on Aspeed BMC platforms, enable
> > +       this option.
> > +
> >  config MISC_RTSX
> >       tristate
> >       default MISC_RTSX_PCI || MISC_RTSX_USB
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index 183970192ced..4e67e21c2e65 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)  += xilinx_sdfec.o
> >  obj-$(CONFIG_NPCM7XX_LPC_BPC)        += npcm7xx-lpc-bpc.o
> >  obj-$(CONFIG_NPCM7XX_PCI_MBOX)       += npcm7xx-pci-mbox.o
> >  obj-$(CONFIG_MCTP_LPC)               += mctp-lpc.o
> > +obj-$(CONFIG_ASPEED_UART_ROUTING) += aspeed-uart-routing.o
> > diff --git a/drivers/misc/aspeed-uart-routing.c b/drivers/misc/aspeed-uart-routing.c
> > new file mode 100644
> > index 000000000000..21ef5d98c317
> > --- /dev/null
> > +++ b/drivers/misc/aspeed-uart-routing.c
> > @@ -0,0 +1,383 @@
> > +/*
> > + * UART Routing driver for Aspeed AST2500
> > + *
> > + * Copyright (c) 2018 Google LLC
>
> No SPDX line?
>
>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
>
> Please remove after adding the SPDX line.
>
> > + */
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +
> > +/* The Aspeed AST2500 allows to dynamically route the inputs for the built-in
> > + * UARTS and physical serial I/O ports.
> > + *
> > + * This allows, for example, to connect the output of UART to another UART.
> > + * This can be used to enable host<->BMC communication via UARTs, e.g. to allow
> > + * access to the host's serial console.
> > + *
> > + * This driver is for the BMC side. The sysfs files allow the BMC userspace
> > + * which owns the system configuration policy, to configure how UARTs and
> > + * physical serial I/O ports are routed.
> > + */
> > +
> > +#define ASPEED_HICRA_IO1     "io1"
> > +#define ASPEED_HICRA_IO2     "io2"
> > +#define ASPEED_HICRA_IO3     "io3"
> > +#define ASPEED_HICRA_IO4     "io4"
> > +#define ASPEED_HICRA_IO5     "io5"
> > +#define ASPEED_HICRA_IO6     "io6"
> > +#define ASPEED_HICRA_UART1   "uart1"
> > +#define ASPEED_HICRA_UART2   "uart2"
> > +#define ASPEED_HICRA_UART3   "uart3"
> > +#define ASPEED_HICRA_UART4   "uart4"
> > +#define ASPEED_HICRA_UART5   "uart5"
> > +
> > +struct aspeed_uart_routing {
> > +     struct device           *dev;
> > +     void __iomem            *regs;
> > +     spinlock_t              lock;
> > +};
> > +
> > +struct aspeed_uart_routing_selector {
> > +     struct device_attribute dev_attr;
> > +     int                             shift;
> > +     int                             mask;
> > +     const char * const options[];
> > +};
> > +
> > +#define to_routing_selector(_dev_attr)                                       \
> > +     container_of(_dev_attr, struct aspeed_uart_routing_selector, dev_attr)
> > +
> > +
> > +static ssize_t aspeed_uart_routing_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf);
> > +
> > +static ssize_t aspeed_uart_routing_store(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      const char *buf, size_t count);
> > +
> > +#define ROUTING_ATTR(_name) {                                                \
> > +     .attr = {.name = _name,                                 \
> > +              .mode = VERIFY_OCTAL_PERMISSIONS(S_IWUSR | S_IRUGO) }, \
> > +     .show = aspeed_uart_routing_show,                               \
> > +     .store = aspeed_uart_routing_store,                             \
> > +}
>
> Why is all of this needed for a driver?
>
> What's wrong with the DEVICE_ATTR_RW()? macro?
>
>
> > +
> > +static struct aspeed_uart_routing_selector uart5_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_UART5),
> > +     .shift = 28,
> > +     .mask = 0xf,
> > +     .options = {
> > +                 ASPEED_HICRA_IO5,   // 0
> > +                 ASPEED_HICRA_IO1,   // 1
> > +                 ASPEED_HICRA_IO2,   // 2
> > +                 ASPEED_HICRA_IO3,   // 3
> > +                 ASPEED_HICRA_IO4,   // 4
> > +                 ASPEED_HICRA_UART1, // 5
> > +                 ASPEED_HICRA_UART2, // 6
> > +                 ASPEED_HICRA_UART3, // 7
> > +                 ASPEED_HICRA_UART4, // 8
> > +                 ASPEED_HICRA_IO6,   // 9
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector uart4_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_UART4),
> > +     .shift = 25,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_IO4,   // 0
> > +                 ASPEED_HICRA_IO1,   // 1
> > +                 ASPEED_HICRA_IO2,   // 2
> > +                 ASPEED_HICRA_IO3,   // 3
> > +                 ASPEED_HICRA_UART1, // 4
> > +                 ASPEED_HICRA_UART2, // 5
> > +                 ASPEED_HICRA_UART3, // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +     },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector uart3_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_UART3),
> > +     .shift = 22,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_IO3,   // 0
> > +                 ASPEED_HICRA_IO4,   // 1
> > +                 ASPEED_HICRA_IO1,   // 2
> > +                 ASPEED_HICRA_IO2,   // 3
> > +                 ASPEED_HICRA_UART4, // 4
> > +                 ASPEED_HICRA_UART1, // 5
> > +                 ASPEED_HICRA_UART2, // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector uart2_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_UART2),
> > +     .shift = 19,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_IO2,   // 0
> > +                 ASPEED_HICRA_IO3,   // 1
> > +                 ASPEED_HICRA_IO4,   // 2
> > +                 ASPEED_HICRA_IO1,   // 3
> > +                 ASPEED_HICRA_UART3, // 4
> > +                 ASPEED_HICRA_UART4, // 5
> > +                 ASPEED_HICRA_UART1, // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector uart1_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_UART1),
> > +     .shift = 16,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_IO1,   // 0
> > +                 ASPEED_HICRA_IO2,   // 1
> > +                 ASPEED_HICRA_IO3,   // 2
> > +                 ASPEED_HICRA_IO4,   // 3
> > +                 ASPEED_HICRA_UART2, // 4
> > +                 ASPEED_HICRA_UART3, // 5
> > +                 ASPEED_HICRA_UART4, // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector io5_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_IO5),
> > +     .shift = 12,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_UART5, // 0
> > +                 ASPEED_HICRA_UART1, // 1
> > +                 ASPEED_HICRA_UART2, // 2
> > +                 ASPEED_HICRA_UART3, // 3
> > +                 ASPEED_HICRA_UART4, // 4
> > +                 ASPEED_HICRA_IO1,   // 5
> > +                 ASPEED_HICRA_IO3,   // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector io4_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_IO4),
> > +     .shift = 9,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_UART4, // 0
> > +                 ASPEED_HICRA_UART5, // 1
> > +                 ASPEED_HICRA_UART1, // 2
> > +                 ASPEED_HICRA_UART2, // 3
> > +                 ASPEED_HICRA_UART3, // 4
> > +                 ASPEED_HICRA_IO1,   // 5
> > +                 ASPEED_HICRA_IO2,   // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector io3_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_IO3),
> > +     .shift = 6,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_UART3, // 0
> > +                 ASPEED_HICRA_UART4, // 1
> > +                 ASPEED_HICRA_UART5, // 2
> > +                 ASPEED_HICRA_UART1, // 3
> > +                 ASPEED_HICRA_UART2, // 4
> > +                 ASPEED_HICRA_IO1,   // 5
> > +                 ASPEED_HICRA_IO2,   // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector io2_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_IO2),
> > +     .shift = 3,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_UART2, // 0
> > +                 ASPEED_HICRA_UART3, // 1
> > +                 ASPEED_HICRA_UART4, // 2
> > +                 ASPEED_HICRA_UART5, // 3
> > +                 ASPEED_HICRA_UART1, // 4
> > +                 ASPEED_HICRA_IO3,   // 5
> > +                 ASPEED_HICRA_IO4,   // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +static struct aspeed_uart_routing_selector io1_sel = {
> > +     .dev_attr = ROUTING_ATTR(ASPEED_HICRA_IO1),
> > +     .shift = 0,
> > +     .mask = 0x7,
> > +     .options = {
> > +                 ASPEED_HICRA_UART1, // 0
> > +                 ASPEED_HICRA_UART2, // 1
> > +                 ASPEED_HICRA_UART3, // 2
> > +                 ASPEED_HICRA_UART4, // 3
> > +                 ASPEED_HICRA_UART5, // 4
> > +                 ASPEED_HICRA_IO3,   // 5
> > +                 ASPEED_HICRA_IO4,   // 6
> > +                 ASPEED_HICRA_IO6,   // 7
> > +                 NULL,               // NULL termination
> > +                 },
> > +};
> > +
> > +
> > +static struct attribute *aspeed_uart_routing_attrs[] = {
> > +     &uart1_sel.dev_attr.attr,
> > +     &uart2_sel.dev_attr.attr,
> > +     &uart3_sel.dev_attr.attr,
> > +     &uart4_sel.dev_attr.attr,
> > +     &uart5_sel.dev_attr.attr,
> > +     &io1_sel.dev_attr.attr,
> > +     &io2_sel.dev_attr.attr,
> > +     &io3_sel.dev_attr.attr,
> > +     &io4_sel.dev_attr.attr,
> > +     &io5_sel.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group aspeed_uart_routing_attr_group = {
> > +     .attrs = aspeed_uart_routing_attrs,
> > +};
> > +
> > +static ssize_t aspeed_uart_routing_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     struct aspeed_uart_routing *uart_routing = dev_get_drvdata(dev);
> > +     struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
> > +     int val, pos, len;
> > +
> > +     val = (readl(uart_routing->regs) >> sel->shift) & sel->mask;
> > +
> > +     len = 0;
> > +     for (pos = 0; sel->options[pos] != NULL; ++pos) {
> > +             if (pos == val) {
> > +                     len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> > +                                     "[%s] ", sel->options[pos]);
>
> Use the sysfs_emit() function please.
>
>
> > +             } else {
> > +                     len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> > +                                     "%s ", sel->options[pos]);
> > +             }
> > +     }
> > +
> > +     if (val >= pos) {
> > +             len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> > +                             "[unknown(%d)]", val);
> > +     }
> > +
> > +     len += snprintf(buf + len, PAGE_SIZE - 1 - len, "\n");
> > +
> > +     return len;
> > +}
> > +
> > +static ssize_t aspeed_uart_routing_store(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      const char *buf, size_t count)
> > +{
> > +     struct aspeed_uart_routing *uart_routing = dev_get_drvdata(dev);
> > +     struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
> > +     int val;
> > +     u32 reg;
> > +
> > +     val = match_string(sel->options, -1, buf);
> > +     if (val < 0) {
> > +             dev_err(dev, "invalid value \"%s\"\n", buf);
>
> So userspace can cause syslog spam?  That's not nice :(
>
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     spin_lock(&uart_routing->lock);
> > +     reg = readl(uart_routing->regs);
> > +     // Zero out existing value in specified bits.
> > +     reg &= ~(sel->mask << sel->shift);
> > +     // Set new value in specified bits.
> > +     reg |= (val & sel->mask) << sel->shift;
>
> Don't we have bit manipulation functions?
>
> > +     writel(reg, uart_routing->regs);
> > +     spin_unlock(&uart_routing->lock);
> > +
> > +     return count;
> > +}
> > +
> > +static int aspeed_uart_routing_probe(struct platform_device *pdev)
> > +{
> > +     struct aspeed_uart_routing *uart_routing;
> > +     struct resource *res;
> > +     int rc;
> > +
> > +     uart_routing = devm_kzalloc(&pdev->dev,
> > +                                 sizeof(*uart_routing),
> > +                                 GFP_KERNEL);
> > +     if (!uart_routing)
> > +             return -ENOMEM;
> > +
> > +     spin_lock_init(&uart_routing->lock);
> > +     uart_routing->dev = &pdev->dev;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     uart_routing->regs = devm_ioremap_resource(&pdev->dev, res);
> > +     if (IS_ERR(uart_routing->regs))
> > +             return PTR_ERR(uart_routing->regs);
> > +
> > +     rc = sysfs_create_group(&uart_routing->dev->kobj,
> > +                             &aspeed_uart_routing_attr_group);
>
> You just raced with userspace and lost :(
>
> Please use the correct api to add a list of sysfs files to a driver.
> Huge hint, if you EVER call sysfs_* from a driver, that's usually not a
> sign something is correct.
>
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     platform_set_drvdata(pdev, uart_routing);
> > +
> > +     return 0;
> > +}
> > +
> > +static int aspeed_uart_routing_remove(struct platform_device *pdev)
> > +{
> > +     struct aspeed_uart_routing *uart_routing = platform_get_drvdata(pdev);
> > +
> > +     sysfs_remove_group(&uart_routing->dev->kobj,
> > +                        &aspeed_uart_routing_attr_group);
>
> Again, wrong api :(
>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id aspeed_uart_routing_table[] = {
> > +     { .compatible = "aspeed,ast2500-uart-routing" },
> > +     { },
> > +};
> > +
> > +static struct platform_driver aspeed_uart_routing_driver = {
> > +     .driver = {
> > +             .name = "aspeed-uart-routing",
> > +             .of_match_table = aspeed_uart_routing_table,
> > +     },
> > +     .probe = aspeed_uart_routing_probe,
> > +     .remove = aspeed_uart_routing_remove,
> > +};
> > +
> > +module_platform_driver(aspeed_uart_routing_driver);
> > +
> > +MODULE_AUTHOR("Oskar Senft <osk@google.com>");
>
> Who is going to maintain this file?

>
> thanks,
>
> greg k-h
