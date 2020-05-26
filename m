Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D10C1BBDC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgD1MoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 08:44:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34927 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726544AbgD1MoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:44:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0C4676F6;
        Tue, 28 Apr 2020 08:44:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Apr 2020 08:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=d
        81mc83rtLbzYCQx45eznvL30ABgy1B2NEW9gCbmbGU=; b=AYMBQ5jy/HW/5XGoW
        GTqf46FDFIgEB3NEWG0ME72zzBcZR4eJEaKfclpfuKFnyKGI0XjpbeDIyQe0D/J8
        geO+qegJO41qfkOLdiveFlFlZg4/QAlGeCj7ZcuakfvjIdxeiTRx8aWSiRG5a9cU
        1jKYZypbGdHW8KOdXmtM9Xm5mlzO84S/YlNWr36OoT99DCYs/zZDGuVU3rl6IyFW
        cYSrE+9k3ONNKIXTv8znuj7P0+fQ0aVAQwRW+qBkxWgfBm6tQoOHiDbAHAvHN54r
        +6GCE1Kbnciptr4M3lpaVAvkr/t8riEN0nwyo+FJYX/cMoEbMyNeDQS3pT/MiT+K
        cltuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=d81mc83rtLbzYCQx45eznvL30ABgy1B2NEW9gCbmb
        GU=; b=ZY6CGG8klxg7W7sK7rOTd0RhOk/Gr7meFL9+oxZRJTrfPBlZwBHXxLhpV
        4gFNvmFeWFDMoYGe4r3/X1ttf/3rLecZi9oPHgYANQr6ATNf6E7l5wylilVNz/tY
        Gv+8Fj6bYNref6hCI8uyBuTrHBJ+XZ3Qt05Fd2W0djDCSEeBrxLpsATGMUqqI5jp
        YnqxQde97a4SQA3EMuXp3oAbnBLJ0AYJA3jEavzbfP7tWZagWjlYQ+wUI/5DocUr
        bGQFvPwT2LXL+OFTZAHC0lvZhZdTSe1u7whSDi2CYQaxgWibadhq9/zppl/we0aa
        0nJHaj848W5Z12G3rs9Y9s6Omg6CQ==
X-ME-Sender: <xms:FiWoXpeuavyAzCq4yaRCwkRjRQZCNdH9qwlD8Ttu3i2IyyHJrQo0Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedugdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesthekre
    dttddtudenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:FiWoXhpL9VAaIZ8mmT2kjYWY2fG9Mw7iFOn9SNwuizLoCpIdv73wzw>
    <xmx:FiWoXmea4WkrFY2G6S9hachCAI6NmUmpOrPWQU949hrsAyz9BEVE-Q>
    <xmx:FiWoXpohrAAApJe0MP5m6wEyJM9s7n2AsyzWCWJrEYMEz1cJAsNdmw>
    <xmx:FiWoXpaptbVCjvg68_aGea_g0KQighH5MGGhsG_LMHPcT_AEav-CPQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25A82328006A;
        Tue, 28 Apr 2020 08:44:06 -0400 (EDT)
Date:   Tue, 28 Apr 2020 14:44:01 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Changes in w1_therm.c and adding w1_therm.h
Message-ID: <20200428124401.GA1269471@kroah.com>
References: <20200423144116.GA7319@kroah.com>
 <20200425153141.247055-1-akira215corp@gmail.com>
 <20200426075141.GB2100063@kroah.com>
 <1b002fb8caf1755b89882fd7a3bbac1565959a6d.camel@gmail.com>
 <20200426170901.GA2139089@kroah.com>
 <97cc7047c5c3892c4a52a6a1fcc6ec948e0796ac.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97cc7047c5c3892c4a52a6a1fcc6ec948e0796ac.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 07:20:30PM +0200, Akira shimahara wrote:
> Le dimanche 26 avril 2020 � 19:09 +0200, Greg KH a �crit :
> > On Sun, Apr 26, 2020 at 02:36:52PM +0200, Akira shimahara wrote:
> > > Le dimanche 26 avril 2020 � 09:51 +0200, Greg KH a �crit :
> > > > On Sat, Apr 25, 2020 at 05:31:41PM +0200, Akira Shimahara wrote:
> > > > > From: Akira SHIMAHARA <akira215corp@gmail.com>
> > > > > 
> > > > > Patch for enhacement of w1_therm module. Added features :
> > > > >  - Bulk read : send one command for all the slaves
> > > > >  		on the bus to trigger temperature conversion
> > > > >  - Optimized conversion time regarding to device resolution
> > > > >  - Dedicated sysfs entry for powering read,
> > > > >  		resolution set/get, eeprom save/restore
> > > > >  - Alarms settings and reading
> > > > >  - Code optimization to mitigate bus traffic
> > > > >  		(devices information are stored to avoid
> > > > > 		interrogating each device every-time)
> > > > > 
> > > > > Following sysfs entry are added :
> > > > >  - temperature (RO) : return the temperature in 1/1000�
> > > > >  - ext_power (RO) : return the power status of the device
> > > > >  - resolution (RW) : get or set the device resolution
> > > > > (supported
> > > > > devices)
> > > > >  - eeprom (WO) :trigger a save or restore to/from device EEPROM
> > > > >  - alarms (RW) : read or write TH and TL in the device RAM
> > > > >  - therm_bulk_read (RW) : Attribute at master level to trigger
> > > > >  		bulk read and to survey the progress of devices
> > > > > conversions
> > > > >  - w1_slave has been kept for compatibility
> > > > > 
> > > > > Main motivation was to improve temperature reading speed, which
> > > > > depend
> > > > > on resolution settings of devices. The module store the powwer
> > > > > status and
> > > > > the resolution of each device so that during reading operation,
> > > > > no
> > > > > transaction is required on the bus, which improve speed.
> > > > > The hardware status is checked as soon as a new device is
> > > > > detected, 
> > > > > when a user change occurred, or when the corresponding sys file
> > > > > is 
> > > > > accessed by user.
> > > > > 
> > > > > The bulk read allow to trigger convserion of all devices on the
> > > > > bus
> > > > > at
> > > > > the same time. It will apply a strong pull up on the line if at
> > > > > least
> > > > > one device required it. The duration of the pull up is the max
> > > > > time
> > > > > required by a device on the line.
> > > > > 
> > > > > Please let me know any feedback you have on this patch.
> > > > > 
> > > > > Thanks ahead,
> > > > > 
> > > > > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > >  - Adding documentation in Documentatin/ABI/testing/sysfs-
> > > > > driver-
> > > > > w1_therm
> > > > >  - Updating existing documentation in
> > > > > Documentation/w1/slaves/w1_therm.rst
> > > > > 
> > > > >  drivers/w1/slaves/w1_therm.c | 1406
> > > > > ++++++++++++++++++++++++++--
> > > > > ------
> > > > >  drivers/w1/slaves/w1_therm.h |  386 ++++++++++
> > > > >  2 files changed, 1470 insertions(+), 322 deletions(-)
> > > > >  create mode 100644 drivers/w1/slaves/w1_therm.h
> > > > 
> > > > No documentation files are added here :(
> > > > 
> > > 
> > > It's in the PATCH 2/2 included in the previous mail. You want me to
> > > merge in one commit ?. I thought it was easier for you to keep a
> > > track
> > > of the v1.
> > 
> > What previous mail?  I don't see a patch 2/2 here, did you not cc:
> > me?
> > 
> > thanks,
> > 
> > greg kh
> 
> I'm so sorry Greg, I made a mistake. Please find hereby the patch 2/2.
> Let me know if you want me to merge into 1 commit.

No, multiple patches are good.

And the first patch really should be split up into smaller pieces too.
Each patch should only do 1 thing, not lots of things all at once.  

Can you do that and send a patch series please?

thanks,

greg k-h
