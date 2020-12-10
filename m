Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C32D583C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgLJK3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:29:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgLJK3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:29:34 -0500
Date:   Thu, 10 Dec 2020 11:30:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607596133;
        bh=NOlYB6gWlOdhNT+lTIb0YEj6TcISa/ub3wn3vWVEtbI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/hNtwb4Cvp7YAvD4fjYfG8+02skCrsmdplJz2tPlnYuQ7QbupdZltryuQ6QAzzEs
         UBLGVhyQPhZ3lqYuxa9F15bTK7gIWNMvc+dQisPTR7fB0IY6MJB8xwanBnRIjdQp98
         DvYwG+xVcmyDlT9AZaQmyWeNNGQ+jho7nW2xr5qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Wang <wangzhiqiang.bj@bytedance.com>
Cc:     Lotus Xu <xuxiaohan@bytedance.com>,
        =?utf-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
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
Subject: Re: [External] Re: [PATCH 1/3] misc: aspeed: Add Aspeed UART routing
 control driver.
Message-ID: <X9H4r3XZynGtSDw0@kroah.com>
References: <20201210092853.303-1-wangzhiqiang.bj@bytedance.com>
 <X9HtwHo8s6e2UsAT@kroah.com>
 <CAH0XSJt3=XJ_gQb2rTvbUcbyow2k7E4jfuKGKAKdi+nwdfauVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH0XSJt3=XJ_gQb2rTvbUcbyow2k7E4jfuKGKAKdi+nwdfauVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 06:06:59PM +0800, John Wang wrote:
> On Thu, Dec 10, 2020 at 5:42 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Dec 10, 2020 at 05:28:53PM +0800, John Wang wrote:
> > > From: Oskar Senft <osk@google.com>
> > >
> > > This driver adds sysfs files that allow the BMC userspace to configure
> > > how UARTs and physical serial I/O ports are routed.
> > >
> > > Tested: Checked correct behavior (both read & write) on TYAN S7106
> > > board by manually changing routing settings and confirming that bits
> > > flow as expected. Tested for UART1 and UART3 as this board doesn't have
> > > the other UARTs wired up in a testable way.
> > >
> > > Signed-off-by: Oskar Senft <osk@google.com>
> > > Signed-off-by: Yong Li <yong.b.li@linux.intel.com>
> > > Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> > > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> > > ---
> > >  .../stable/sysfs-driver-aspeed-uart-routing   |  14 +
> > >  .../misc-devices/aspeed-uart-routing.txt      |  49 +++
> > >  drivers/misc/Kconfig                          |   6 +
> > >  drivers/misc/Makefile                         |   1 +
> > >  drivers/misc/aspeed-uart-routing.c            | 383 ++++++++++++++++++
> > >  5 files changed, 453 insertions(+)
> > >  create mode 100644 Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> > >  create mode 100644 Documentation/misc-devices/aspeed-uart-routing.txt
> > >  create mode 100644 drivers/misc/aspeed-uart-routing.c
> > >
> > > diff --git a/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing b/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> > > new file mode 100644
> > > index 000000000000..5068737d9c12
> > > --- /dev/null
> > > +++ b/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> > > @@ -0,0 +1,14 @@
> > > +What:                /sys/bus/platform/drivers/aspeed-uart-routing/*/io*
> > > +Date:                August 2018
> > > +Contact:     Oskar Senft <osk@google.com>
> > > +Description: Configures the input source for the specific physical
> > > +             serial I/O port.
> > > +Users:               OpenBMC.  Proposed changes should be mailed to
> > > +             openbmc@lists.ozlabs.org
> > > +
> > > +What:                /sys/bus/platform/drivers/aspeed-uart-routing/*/uart*
> > > +Date:                August 2018
> > > +Contact:     Oskar Senft <osk@google.com>
> > > +Description: Configures the input source for the specific UART.
> > > +Users:               OpenBMC.  Proposed changes should be mailed to
> > > +             openbmc@lists.ozlabs.org
> > > diff --git a/Documentation/misc-devices/aspeed-uart-routing.txt b/Documentation/misc-devices/aspeed-uart-routing.txt
> > > new file mode 100644
> > > index 000000000000..cf1c2a466875
> > > --- /dev/null
> > > +++ b/Documentation/misc-devices/aspeed-uart-routing.txt
> > > @@ -0,0 +1,49 @@
> > > +Kernel driver aspeed-uart-routing
> > > +=================================
> > > +
> > > +Supported chips:
> > > +ASPEED AST2500/AST2600
> > > +
> > > +Author:
> > > +Google LLC
> > > +
> > > +Description
> > > +-----------
> > > +
> > > +The Aspeed AST2500/AST2600 allows to dynamically route the inputs for the
> > > +built-in UARTS and physical serial I/O ports.
> > > +
> > > +This allows, for example, to connect the output of UART to another UART.
> > > +This can be used to enable host<->BMC communication via UARTs, e.g. to allow
> > > +access to the host's serial console.
> > > +
> > > +This driver is for the BMC side. The sysfs files allow the BMC userspace
> > > +which owns the system configuration policy, to configure how UARTs and
> > > +physical serial I/O ports are routed.
> > > +
> > > +The driver provides the following files in sysfs:
> > > +uart1                Configure the input signal to UART1.
> > > +uart2                Configure the input signal to UART2.
> > > +uart3                Configure the input signal to UART3.
> > > +uart4                Configure the input signal to UART4.
> > > +uart5                Configure the input signal to UART5.
> > > +io1          Configure the input signal to physical serial port 1.
> > > +io2          Configure the input signal to physical serial port 2.
> > > +io3          Configure the input signal to physical serial port 3.
> > > +io4          Configure the input signal to physical serial port 4.
> > > +io5          Configure the input signal to physical serial port 5.
> > > +
> > > +When read, each file shows the list of available options with the currently
> > > +selected option marked by square brackets "[]". The list of available options
> > > +depends on the selected file.
> > > +
> > > +Example:
> > > +$ cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > > +[io1] io2 io3 io4 uart2 uart3 uart4 io6
> > > +
> > > +In this case, UART1 gets its input signal from IO1 (physical serial port 1).
> > > +
> > > +$ echo -n "uart3" \
> > > +  >/sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > > +$ cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > > +io1 io2 io3 io4 uart2 [uart3] uart4 io6
> >
> > Are you sure there are no other ways to configure this type of thing,
> > than to a driver-specific sysfs file?
> 
> I think this is good. but what's your suggestion?

I do not know, but isn't this normally handled in a dts file?  Why must
it be done "on the fly" like this?

> If I use a driver-specific sysfs and modify the code based on the
> comments, is this a good direction to go?

That's what you are trying to do here, and is why I am objecting to it
:)

thanks,

greg k-h
