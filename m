Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E541BDCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgD2NBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 09:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2NBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:01:37 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.25.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E41214D8;
        Wed, 29 Apr 2020 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588165297;
        bh=zNBekyFZGFYfMOOOV65o8aytIfG87wwm23IWKpe4Fbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmNAjTgu/r1QUb30T3OHTNekPYdmIwYkZVLrOhrnkrNyeIhUUfozyHjTRTlM7eDxH
         O6L9CB4CsdJS+K3PfVwTthyrWWYQ8g2d+wJf9585Kd0x44+zwE+bX2XtvoH6jRl2oC
         ar1wY0UdqMwZ2vHXy7+8mW8hDJBFeqnTKotbzWOs=
Date:   Wed, 29 Apr 2020 18:31:26 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, patong.mxl@gmail.com
Subject: Re: [PATCH 1/2] usb: serial: Add MaxLinear/Exar USB to Serial driver
Message-ID: <20200429130126.GD6443@Mani-XPS-13-9360>
References: <20200428195651.6793-1-mani@kernel.org>
 <20200428195651.6793-2-mani@kernel.org>
 <20200429072036.GA2045202@kroah.com>
 <20200429074025.GA6443@Mani-XPS-13-9360>
 <20200429092904.GA2079263@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429092904.GA2079263@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:29:04AM +0200, Greg KH wrote:
> On Wed, Apr 29, 2020 at 01:10:26PM +0530, Manivannan Sadhasivam wrote:
> > Hi Greg,
> > 
> > On Wed, Apr 29, 2020 at 09:20:36AM +0200, Greg KH wrote:
> > > On Wed, Apr 29, 2020 at 01:26:50AM +0530, mani@kernel.org wrote:
> > > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > > 
> > > > Add support for MaxLinear/Exar USB to Serial converters. This driver
> > > > only supports XR21V141X series but provision has been made to support
> > > > other series in future.
> > > > 
> > > > This driver is inspired from the initial one submitted by Patong Yang:
> > > > 
> > > > https://patchwork.kernel.org/patch/10543261/
> > > > 
> > > > While the initial driver was a custom tty USB driver exposing whole
> > > > new serial interface ttyXRUSBn, this version is completely based on USB
> > > > serial core thus exposing the interfaces as ttyUSBn. This will avoid
> > > > the overhead of exposing a new USB serial interface which the userspace
> > > > tools are unaware of.
> > > 
> > > Nice work!
> > > 
> > > Some comments below:
> > > 
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * MaxLinear/Exar USB to Serial driver
> > > > + *
> > > > + * Based on initial driver written by Patong Yang <patong.mxl@gmail.com>
> > > > + *
> > > > + * Copyright (c) 2020 Manivannan Sadhasivam <mani@kernel.org>
> > > > + */
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/tty.h>
> > > > +#include <linux/usb.h>
> > > > +#include <linux/usb/serial.h>
> > > > +
> > > > +#include "xr_serial.h"
> > > 
> > > No need for a .h file for a single .c file.
> > > 
> > 
> > Yeah but since this driver can support multiple series of XR chips (they
> > might have separate register definitions and such), I thought it is a good
> > idea to have a header file to keep the driver sane. But can club it to the
> > source file for now.
> 
> Don't worry about future stuff, focus on what you need to do now :)
> 

Alright, will do :)

> > > > +static int xr_get_reg(struct usb_serial_port *port, u8 block, u16 reg,
> > > > +		      u16 *val)
> > > > +{
> > > > +	struct usb_serial *serial = port->serial;
> > > > +	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
> > > > +	void *dmabuf;
> > > > +	int ret = -EINVAL;
> > > > +
> > > > +	dmabuf = kmalloc(sizeof(reg), GFP_KERNEL);
> > > 
> > > So that is 2 bytes?
> > > 
> > 
> > Explanation below...
> > 
> > > > +	if (!dmabuf)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	if (port_priv->idProduct == XR21V141X_ID) {
> > > > +		/* XR21V141X uses custom command for reading UART registers */
> > > > +		ret = usb_control_msg(serial->dev,
> > > > +				      usb_rcvctrlpipe(serial->dev, 0),
> > > > +				      XR_GET_XR21V141X,
> > > > +				      USB_DIR_IN | USB_TYPE_VENDOR, 0,
> > > > +				      reg | (block << 8), dmabuf,
> > > > +				      port_priv->reg_width,
> > > > +				      USB_CTRL_SET_TIMEOUT);
> > > > +	}
> > > > +
> > > > +	if (ret == port_priv->reg_width) {
> > > > +		memcpy(val, dmabuf, port_priv->reg_width);
> > > 
> > > But here you copy ->reg_width bytes in?  How do you know val can hold
> > > that much?  It's only set to be 1, so you copy 1 byte to a 16bit value?
> > > What part of the 16bits did you just copy those 8 bits to (hint, think
> > > cpu endian issues...)
> > > 
> > > That feels really really odd and a bit broken.
> > > 
> > 
> > Right. The reason is, the other series which can be supported by this driver
> > have different register widths. For instance XR2280x. I haven't used them
> > personally but seen this in initial driver. So I just used the max u16 type
> > to make the reg_{set/get} routines work with those.
> 
> Drop the whole "different register width" stuff for now, as the driver
> does not support it and it adds additional complexity that is hard to
> review for no good reason.  If you want to add support for new devices
> later, _then_ we can add support for that.
> 
> Don't over-engineer :)
> 

Sure!

> > But agree, I should've used le16_to_cpu() cast to avoid endian issues.
> 
> You have to, the code is broken as-is right now.
> 

We don't need the conversion if u8 is used everywhere :)

Thanks,
Mani

> > If you think this hack is not required now, I can just use u8 and worry about
> > compatibility later.
> 
> Please do so.
> 
> thanks,
> 
> greg k-h
