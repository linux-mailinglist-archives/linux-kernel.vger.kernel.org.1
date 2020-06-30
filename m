Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393E020F867
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbgF3Pcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 11:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389385AbgF3Pcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:32:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153162074F;
        Tue, 30 Jun 2020 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593531155;
        bh=tAIb2Qe7+I4lxLCnl0yGHLtglv0iHdUd2/6wnIC4ik0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0EA0GK1X6DSpkNJflwMuat3MABzOduzn3I4hAHMj6UCPcXGM7ls3kOXt2u+xC6DfI
         ttv6zHhqQvqItW6q20tEUkRbwxz8tnORm/aggFLVKV0eUnhGKR0Vks832ucRXh98sV
         MlNcGbvl0gbC/y96WdxYtZkGNsifH8Yi/oLDpfPk=
Date:   Tue, 30 Jun 2020 17:32:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200630153223.GA1784805@kroah.com>
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <20200630085641.GD637809@kroah.com>
 <CAFmMkTGrnZt7ZaGyYCe-LCHET4yHz9DfanaZwsOS6HCxK40apQ@mail.gmail.com>
 <20200630152832.GB1780940@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630152832.GB1780940@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 05:28:32PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 30, 2020 at 11:42:58AM -0300, Daniel Gutson wrote:
> > On Tue, Jun 30, 2020 at 5:56 AM Greg Kroah-Hartman <
> > gregkh@linuxfoundation.org> wrote:
> > 
> > > On Mon, Jun 29, 2020 at 07:59:32PM -0300, Daniel Gutson wrote:
> > > > This kernel module exports configuration attributes for the
> > > > system SPI chip.
> > > > This initial version exports the BIOS Write Enable (bioswe),
> > > > BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
> > > > fields of the Bios Control register. The idea is to keep adding more
> > > > flags, not only from the BC but also from other registers in following
> > > > versions.
> > > >
> > > > The goal is that the attributes are avilable to fwupd when SecureBoot
> > > > is turned on.
> > > >
> > > > A technical note: I check if *ppos == BUFFER_SIZE in the reading function
> > > > to exit early and avoid an extra access to the HW, for example when using
> > > > the 'cat' command, which causes two read operations.
> > >
> > > Why not use the simple_* functions which should prevent that type of
> > > thing?
> > >
> > 
> > a hint please? I don't see how to do it with simple_read_from_buffer, I
> > need to return in the read fop the amount of read bytes, but don't know
> > how to mark EOF. Because of that, 'cat' reads again just for me to tell it
> > there's nothing else to read.
> 
> That's fine, the kernel does not tell userspace "EOF", that is up to the
> libc to determine.  If you read the data from the hardware once, and
> keep it in your buffer, simple_read_from_buffer() will handle all of
> that logic for you, please let it do that.
> 
> > > > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > ---
> > > >  Documentation/ABI/stable/securityfs-spi-lpc |  23 +
> > >
> > > Why is this going in securityfs at all?  Why not just sysfs as it is a
> > > CPU attribute, right?
> > >
> > 
> > Richard already discussed that, but "it" is not only (one) CPU attribute,
> > are SPI chip settings and attributes coming from the firmware.
> 
> All hardware things, please use sysfs, that is what it is designed for.
> 
> > Please note that I wanted to submit the minimum patch, but I need to add
> > more attributes.
> 
> A patch series is great to create and send showing all of that.
> 
> > > > diff --git a/Documentation/ABI/stable/securityfs-spi-lpc
> > > b/Documentation/ABI/stable/securityfs-spi-lpc
> > > > new file mode 100644
> > > > index 000000000000..22660a7fd914
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/stable/securityfs-spi-lpc
> > > > @@ -0,0 +1,23 @@
> > > > +What:                /sys/kernel/security/firmware/bioswe
> > > > +Date:                June 2020
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     daniel.gutson@eclypsium.com
> > > > +Description: If the system firmware set BIOS Write Enable.
> > > > +             0: writes disabled, 1: writes enabled.
> > >
> > > THis is very x86-specific, what about ARM/MIPS/anything else?  Perhaps a
> > > cpu/arch-specific thing instead?
> > >
> > 
> > We debated this but didn't find a better match, since cpu/arch-specific
> > seemed too core to put informational drivers.
> > Do you have a suggestion?
> 
> Make it explicitly hardware specific in your userspace location.
> Otherwise you just defined this for all hardware types, with what you
> used above, and I do not think you wanted to do that.
> 
> > > Again, which makes it seem like securityfs is not the thing for this, as
> > > it describes the hardware, not a security model which is what securityfs
> > > has been for in the past, right?
> > >
> > 
> > I prefer to leave this to the other discussion with Richard. It's fine for
> > me too to use sysfs.
> > FWIW, the driver provides information related to firmware security.
> 
> It provides information on what is going on with the firmware, it's up
> to userspace to know/determine/care if that means anything with regards
> to "security" or not :)

Also, you seem to have missed /sys/firmware/ on your system :)
