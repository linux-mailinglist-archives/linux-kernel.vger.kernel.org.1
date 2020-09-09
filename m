Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4706A2635AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIISPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 14:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIISPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:15:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42FFF2078E;
        Wed,  9 Sep 2020 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599675348;
        bh=uWQl3F1a56D31XTKtlW56i9v22Kw/H48cIk9Ucu5yeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCIL2ANg0kpJJAT6Xybyfs60+yPM6hkIU0aYTYG+Cd/IKAfRCD8UR5oHSKsk0Hxz+
         zSZ3Z+YrgVP8DFr7aaw6FmZEiwhQ430pZ+vbS93I5+LJ4BAhjiqv/GUIDv3ooPckQV
         U6DEZrdlU4OLUc6yCtJQCSsbKhCfxCpVN5SySIqA=
Date:   Wed, 9 Sep 2020 20:15:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] misc: hisi_hikey_usb: Driver to support onboard
 USB gpio hub on Hikey960
Message-ID: <20200909181556.GC1007128@kroah.com>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
 <d53de8ab89c23e4be6d2a4fd24b10bcd76dad97d.1599493845.git.mchehab+huawei@kernel.org>
 <20200909083555.GA579996@kroah.com>
 <20200909104442.20f63e9b@coco.lan>
 <20200909115547.1678cd88@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909115547.1678cd88@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 11:55:47AM +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 9 Sep 2020 10:44:42 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > Em Wed, 9 Sep 2020 10:35:55 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > 
> > > On Mon, Sep 07, 2020 at 05:59:32PM +0200, Mauro Carvalho Chehab wrote:  
> > > > From: Yu Chen <chenyu56@huawei.com>
> > > > 
> > > > The HiKey960 has a fairly complex USB configuration due to it
> > > > needing to support a USB-C port for host/device mode and multiple
> > > > USB-A ports in host mode, all using a single USB controller.
> > > > 
> > > > See schematics here:
> > > >   https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> > > > 
> > > > This driver acts as a usb-role-switch intermediary, intercepting
> > > > the role switch notifications from the tcpm code, and passing
> > > > them on to the dwc3 core.
> > > > 
> > > > In doing so, it also controls the onboard hub and power gpios in
> > > > order to properly route the data lines between the USB-C port
> > > > and the onboard hub to the USB-A ports.
> > > > 
> > > > Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > > > [jstultz: Major rework to make the driver a usb-role-switch
> > > >           intermediary]
> > > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > >  MAINTAINERS                   |   7 ++
> > > >  drivers/misc/Kconfig          |   9 ++
> > > >  drivers/misc/Makefile         |   1 +
> > > >  drivers/misc/hisi_hikey_usb.c | 205 ++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 222 insertions(+)
> > > >  create mode 100644 drivers/misc/hisi_hikey_usb.c    
> > > 
> > > Can this, and the next patch, go into my char-misc tree independent of
> > > the other patches in this series?   
> > 
> > Yes, they can go via char-misc tree. The drivers are independent.
> > 
> 
> Forgot to ask: should I re-send the patches on a separate series?

Sure, that would make things much easier for me so that I "know" I have
the right patches to apply.

thanks,

greg k-h
