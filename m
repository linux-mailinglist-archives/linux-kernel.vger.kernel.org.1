Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77E23BC74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgHDOn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 10:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHDOnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:43:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893182075D;
        Tue,  4 Aug 2020 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596552235;
        bh=PR9lGaNfYYuKKCwBgZipB38E9ZH8vb2DxOGeZiAiRjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzIq9tre5sCt5z6jzbhWVIOHvBYMoJdZ2oMxA1RT+dTvWKUS5F/nf8mhH0Vi/kW3v
         wdiBRJRB8XWxz/QLCQrlJkGu57RzFURfwg+uKeMldksd6b4Uq19Syw1sHGXUbGaKd7
         2FgN/7Oe3lSeTK4eFMAtVUFIahtqyX3tVwuQBi68=
Date:   Tue, 4 Aug 2020 16:44:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] Platform lockdown information in SYSFS
Message-ID: <20200804144414.GA50022@kroah.com>
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
 <20200731070053.GC1518178@kroah.com>
 <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com>
 <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
 <20200804064154.GE696690@kroah.com>
 <CAFmMkTE1PHPrZwnH7DKFW145dn01LhydTbL7HPTO+_zKA+P61Q@mail.gmail.com>
 <20200804142250.GA247448@kroah.com>
 <CAFmMkTFEWrMsigabvE2HtmpFXMe0qb8QZJHzMzQ=wZXE1G3fbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTFEWrMsigabvE2HtmpFXMe0qb8QZJHzMzQ=wZXE1G3fbQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 11:37:02AM -0300, Daniel Gutson wrote:
> On Tue, Aug 4, 2020 at 11:23 AM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 04, 2020 at 10:50:13AM -0300, Daniel Gutson wrote:
> > > On Tue, Aug 4, 2020 at 3:41 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Aug 03, 2020 at 07:04:56PM -0300, Daniel Gutson wrote:
> > > > > > > > Think of this as an input device.  You don't put the random
> input
> > > > > > > > attributes all in one place, you create a new device that
> represents the
> > > > > > > > input interface and register that.
> > > > >
> > > > > I'm having trouble with this. What's the dev_t for the child
> devices?
> > > > > I'm doing
> > > > >     child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> > > > > NULL, "child");
> > > > > pdev is the pci_device (intel-spi-pci)
> > > > > dmesg shows
> > > > >
> > > > >     sysfs: cannot create duplicate filename '/class/my-class'
> > > > >     (call trace)
> > > > >     kobject_add_internal failed for my-class with -EEXIST, don't try
> > > > > to register things with the same name in the same directory.
> > > >
> > > > Without seeing all of your code, I can't tell you what you are doing
> > > > wrong, but the kernel should be giving you a huge hint here...
> > > >
> > > > Don't create duplicate names in the same subdirectory.
> > >
> > > I'm not doing that. One of my questions is if MKDEV(0, 0) is valid for
> > > create_device, which I inferred so from the documentation.
> >
> > Yes it is, but that's not the error given to you :)
> >
> > Many in-kernel users call device_create() with MKDEV(0, 0)
> >
> > > Here is the listing
> >
> > <snip>
> >
> > It's not in any format to read, please never strip leading whitespace,
> > it hurts my brain...
> 
> (trying again)
> Also, this is in pastebin:  https://pastebin.com/8Ye9eUm5
> 
> #include <linux/kobject.h>
> #include <linux/sysfs.h>
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/list.h>
> #include <linux/slab.h>
> #include <linux/device.h>
> #include <linux/pci.h>
> 
> static ssize_t howareyou_show(struct class *class, struct class_attribute
> *attr,
>    char *buf)
> {
>         return sprintf(buf, "%s\n", "How are you?");
> }
> static CLASS_ATTR_RO(howareyou);

These are rare, as they are "global" for a class, are you sure you want
that?

> 
> static struct class my_class = {
>         .name =         "my-class",
>         .owner =        THIS_MODULE,
> };
> 
> struct device* child_device;
> 
> static int mypci_probe(struct pci_dev *pdev,
>       const struct pci_device_id *id)
> {
>         int ret;
> 
>         ret = pcim_enable_device(pdev);
>         if (ret)
>                 return ret;
> 
>         ret = class_register(&my_class);
>         if (ret < 0)
>                 return ret;
> 
> 
>         pr_info("DFG: Recognized. DID: %lx\n", (unsigned long
> int)id->driver_data);
>         pr_info("DFG: device DID: %lx\n", (unsigned long int)pdev->device);
> 
>         ret = class_create_file(&my_class, &class_attr_howareyou);
>         if (ret != 0) {
>                pr_err("DFG class create file error: %d\n", ret);
>                class_unregister(&my_class);
>                return ret;
>        }
> 
>        child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> NULL, "child");
>         if (child_device == NULL) {
>                pr_err("DFG error child device NULL");
>         }
> 
>         return ret;
> }
> 


Looks sane, what does your kernel log say when you load this?

thanks,

greg k-h
