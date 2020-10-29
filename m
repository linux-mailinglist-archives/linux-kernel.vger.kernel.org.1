Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECA129EE30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgJ2O2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJ2O2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:28:53 -0400
Received: from coco.lan (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E80142151B;
        Thu, 29 Oct 2020 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603981731;
        bh=8YEKmSQxeMhYw9/AD1252B/ftYY1OGS1AdKbmMqT9DM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=udou9hMftLwhkBHK6y9CFjKIEcFuIHXuf/WZ3IZBwRT3ukB+dv5laha67AssrM10z
         n0Fr8bIRzXjfGGdK8+gPU3nGtvXJ43s1pCLyM4DaIcEPSOVljWUKu7muW3ZnVfHCdU
         qs0WYt98b5lb0g28mg7cVGNWAEJtbEVxT0mMqoyM=
Date:   Thu, 29 Oct 2020 15:28:45 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Evgeny Boger <boger@wirenboard.com>
Subject: Re: Adding ABI to htmldocs - Was: Re: [PATCH 2/2] w1: w1_therm: Add
 support for GXCAS GX20MH01 device.
Message-ID: <20201029152845.6bbb39ce@coco.lan>
In-Reply-To: <20201021165819.GA1361645@kroah.com>
References: <20200904160004.87710-1-ivan.zaentsev@wirenboard.ru>
        <20200904160004.87710-2-ivan.zaentsev@wirenboard.ru>
        <20201006151915.77d044a4@coco.lan>
        <1561045277.20201007103227@wirenboard.ru>
        <20201007105702.67988846@coco.lan>
        <20201007090619.GA613204@kroah.com>
        <20201007130549.6ca57af0@coco.lan>
        <20201007114359.GA2167293@kroah.com>
        <20201007135934.4b6e598e@coco.lan>
        <20201021182843.522dd7e7@coco.lan>
        <20201021165819.GA1361645@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 21 Oct 2020 18:58:19 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Wed, Oct 21, 2020 at 06:28:43PM +0200, Mauro Carvalho Chehab wrote:
> > Hi greg,
> > 
> > Em Wed, 7 Oct 2020 13:59:34 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> >   
> > > Em Wed, 7 Oct 2020 13:43:59 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > >   
> > > > On Wed, Oct 07, 2020 at 01:05:49PM +0200, Mauro Carvalho Chehab wrote:    
> > > > > Em Wed, 7 Oct 2020 11:06:19 +0200
> > > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > > > >       
> > > > > > On Wed, Oct 07, 2020 at 10:57:02AM +0200, Mauro Carvalho Chehab wrote:      
> > > > > > > Em Wed, 7 Oct 2020 10:32:27 +0300
> > > > > > > Ivan Zaentsev <ivan.zaentsev@wirenboard.ru> escreveu:
> > > > > > >         
> > > > > > > > Tuesday, October 6, 2020, 4:19:15 PM, Mauro Carvalho Chehab wrote:
> > > > > > > >         
> > > > > > > > >> diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
> > > > > > > > >> index f1148181f53e..00376501a5ef 100644
> > > > > > > > >> --- a/Documentation/w1/slaves/w1_therm.rst
> > > > > > > > >> +++ b/Documentation/w1/slaves/w1_therm.rst          
> > > > > > > >         
> > > > > > > > >>  
> > > > > > > > >> @@ -130,4 +131,12 @@ conversion and temperature reads 85.00 (powerup value) or 127.94 (insufficient
> > > > > > > > >>  power), the driver returns a conversion error. Bit mask ``2`` enables poll for
> > > > > > > > >>  conversion completion (normal power only) by generating read cycles on the bus
> > > > > > > > >>  after conversion starts. In parasite power mode this feature is not available.
> > > > > > > > >> -Feature bit masks may be combined (OR).
> > > > > > > > >> +Feature bit masks may be combined (OR). See accompanying sysfs documentation:
> > > > > > > > >> +:ref:`Documentation/w1/slaves/w1_therm.rst <w1_therm>`
> > > > > > > > >> +          
> > > > > > > >         
> > > > > > > > > As warned by Sphinx, this cross-reference is broken:          
> > > > > > > >         
> > > > > > > > >         .../Documentation/w1/slaves/w1_therm.rst:125: WARNING:
> > > > > > > > > undefined label: w1_therm (if the link has no caption the label must precede a section header)          
> > > > > > > > 
> > > > > > > > Would this be ok?        
> > > > > > > 
> > > > > > > Yeah, sure!
> > > > > > >         
> > > > > > > > 
> > > > > > > > "More details in Documentation/ABI/testing/sysfs-driver-w1_therm"
> > > > > > > >         
> > > > > > > > > Not sure what you wanted to point here.          
> > > > > > > > 
> > > > > > > > A link to a driver's sysfs interface, but sysfs docs are text
> > > > > > > > files and seem to not be included in Sphynx Docs.        
> > > > > > > 
> > > > > > > I sent upstream sometime ago a patch series adding ABI to Sphinx, but I 
> > > > > > > was not merged, not sure why:
> > > > > > > 
> > > > > > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v5.6        
> > > > > > 
> > > > > > I think the raft of different patches floating around at the time made
> > > > > > me totally confused as to what was, and was not, the latest versions.      
> > > > > 
> > > > > Yeah, there were lots of patches floating around that time.
> > > > > 
> > > > > I also recall that someone (Jeni?) asked if the best wouldn't be to
> > > > > just convert the ABI files to ReST directly.
> > > > >       
> > > > > > I'll be glad to look at them again, if you want to rebase after 5.10-rc1
> > > > > > is out and resend them, as I think this should be showing up in the
> > > > > > documentation.      
> > > > > 
> > > > > Surely. I'll rebase them after 5.10-rc1 and re-submit. 
> > > > > 
> > > > > What strategy do you prefer? Keep the files with the same format as
> > > > > today (allowing them to optionally have ReST markups) or to convert
> > > > > them to .rst directly?
> > > > > 
> > > > > In the latter case, the best would be to apply it as early as possible
> > > > > after 5.10-rc1, as it may cause conflicts with other patches being
> > > > > submitted for 5.11.      
> > > > 
> > > > The existing format if at all possible, doing wholesale changes is a
> > > > mess and wouldn't be recommended.    
> > > 
> > > Yeah, merging it would indeed be a mess. At long term, though, it could 
> > > be easier to maintain.
> > >   
> > > > I think you already fixed up the entries that had problems being parsed
> > > > in the past, if not, we can resolve those as well.    
> > > 
> > > Yes. The series start with fixes. I suspect several of them
> > > (if not all) were already merged, but if anything is missing, I can fix 
> > > at the upcoming rebased series.  
> > 
> > Rebasing the patch series was easier than what I expected:
> > 
> > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v6
> > 
> > Yet, while fixing one build issue, I noticed that there are multiple
> > files defining the same ABI, with different contents.
> > 
> > Right now, scripts/get_abi.pl assumes that "what" is unique. Well, sorts
> > of. When it finds a duplicated entry, it merges the description, 
> > preserving the fields from the last parsed entry.
> > 
> > I ended adding a patch to detect those ABI duplication:
> > 
> > 	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=abi_patches_v6&id=6868914605cb0ebffe3fd07d344c246e1e4cd94e
> > 
> > I'm enclosing the results.
> > 
> > One such example is this one:
> > 
> > 	3 duplicated entries for /sys/class/leds/<led>/hw_pattern: on file(s) sysfs-class-led-trigger-pattern sysfs-class-led-driver-sc27xx sysfs-class-led-driver-el15203000
> > 
> > It sounds that different drivers define and use this ABI, but
> > each one with different meanings. 
> > 
> > There are even some cases where the same file define the same ABI twice:
> > 
> > 	2 duplicated entries for /sys/class/power_supply/<supply_name>/temp_alert_min: on file(s) sysfs-class-power
> > 
> > Not sure what's the best way to document things like that, or if
> > the fix would be to drop/merge those.
> > 
> > Any ideas?  
> 
> We should merge them to be the correct representation.  The
> driver-specific ones for LED should just be dropped to use the
> class-generic one.
> 
> I guess just take them one at a time :)

I'm trying to address each one of the duplicated ones...
I'm now stuck with this one:

At Documentation/ABI/testing/sysfs-driver-w1_therm, it has:

	What:		/sys/bus/w1/devices/.../eeprom
	Date:		May 2020
	Contact:	Akira Shimahara <akira215corp@gmail.com>
	Description:
			(WO) writing that file will either trigger a save of the
			device data to its embedded EEPROM, either restore data
			embedded in device EEPROM. Be aware that devices support
			limited EEPROM writing cycles (typical 50k)
	
				* 'save': save device RAM to EEPROM
				* 'restore': restore EEPROM data in device RAM

	Users:		any user space application which wants to communicate with
			w1_term device

Which defines the same ABI as this one:

	What:		/sys/bus/w1/devices/.../eeprom
	Date:		May 2012
	Contact:	Markus Franke <franm@hrz.tu-chemnitz.de>
	Description:	read/write the contents of the EEPROM memory of the DS28E04-100
			see Documentation/w1/slaves/w1_ds28e04.rst for detailed information
	Users:		any user space application which wants to communicate with DS28E04-100

Which is further described at Documentation/w1/slaves/w1_ds28e04.rst:

   Memory Access

	A read operation on the "eeprom" file reads the given amount of bytes
	from the EEPROM of the DS28E04.

	A write operation on the "eeprom" file writes the given byte sequence
	to the EEPROM of the DS28E04. If CRC checking mode is enabled only
	fully aligned blocks of 32 bytes with valid CRC16 values (in bytes 30
	and 31) are allowed to be written.

-

This specific duplication seems very evil, as if someone does:

	echo restore > /sys/bus/w1/devices/.../eeprom

and the device is a DS28E04-100, its eeprom will be erased instead
of being restored!

Not sure how this could be solved without causing regressions.

As the new ABI is from May 2020, added on this commit:

  commit 45d457a4cf24455eefd076a01a3d86414fc2ff1e
  Author: Akira Shimahara <akira215corp@gmail.com>
  Date:   Mon May 11 22:37:25 2020 +0200

    w1_therm: adding eeprom sysfs entry
    
    The driver implement 2 hardware functions to access device RAM:
     * copy_scratchpad
     * recall_scratchpad
    They act according to device specifications.
    
    As EEPROM operations are not device dependent (all w1_therm can perform
    EEPROM read/write operation following the same protocol), it is removed
    from device families structures.
    
    Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly.
    
    Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
    Link: https://lore.kernel.org/r/20200511203725.410844-1-akira215corp@gmail.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

(probably reached Kernel 5.8):

	$ git describe 45d457a4cf244
	v5.7-rc5-92-g45d457a4cf24

I guess the solution would be to rename the new one.

Comments?


Thanks,
Mauro
