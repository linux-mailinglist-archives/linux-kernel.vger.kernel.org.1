Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA6295A03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894867AbgJVITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894839AbgJVITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:19:32 -0400
Received: from coco.lan (ip5f5ad5dd.dynamic.kabel-deutschland.de [95.90.213.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BD221481;
        Thu, 22 Oct 2020 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603354771;
        bh=8wUI/nVanrbqAQdr5Ja9X8qzvPrNhabfUxp65ZfsmIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=birRuSq4ZE5pThNYmPqQ/63D1FneC/X/R49X+xROkRiJxvb/3WNAk7f/Jyjk/NE3X
         KW5JGL7Q6bJsQ0HzZ5d4YAc/uGhFRuSfZeLvlvLIB+hsfT/QOfRtP5/G/fKw67S0Qi
         b3tL6BApb9/qMrV8THB9VdbgHjqx6VfzeErBsDlM=
Date:   Thu, 22 Oct 2020 10:19:24 +0200
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
Message-ID: <20201022101924.3378345f@coco.lan>
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
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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
> We should merge them to be the correct representation. 

Ok, makes sense to me.

I improved the script to better report such issues:

	$ ./scripts/get_abi.pl --dir Documentation/ABI/testing validate
	Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined 2 times: Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:101 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:1
	Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode is defined 2 times: Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:118 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:15
	Warning: /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available is defined 2 times: Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:112 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:9
	Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency is defined 2 times: Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:1 Documentation/ABI/testing/sysfs-bus-iio:599
	Warning: /sys/bus/iio/devices/iio:deviceX/out_currentY_raw is defined 2 times: Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als:44 Documentation/ABI/testing/sysfs-bus-iio-health-afe440x:35
	Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw, /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available is defined 2 times: Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:2 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:2
	Warning: /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity is defined 2 times: Documentation/ABI/testing/sysfs-bus-iio-distance-srf08:1 Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935:9
	Warning: /sys/class/backlight/<backlight>/ambient_light_level is defined 2 times: Documentation/ABI/testing/sysfs-class-backlight-adp8860:9 Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870:31
	Warning: /sys/class/backlight/<backlight>/ambient_light_zone is defined 2 times: Documentation/ABI/testing/sysfs-class-backlight-adp8860:19 Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870:41
	Warning: /sys/class/c2port/c2portX/flash_erase is defined 2 times: Documentation/ABI/testing/sysfs-c2port:61 Documentation/ABI/testing/sysfs-c2port:69
	Warning: /sys/class/leds/<led>/brightness is defined 2 times: Documentation/ABI/testing/sysfs-class-led:1 Documentation/ABI/testing/sysfs-class-led-multicolor:1
	Warning: /sys/class/leds/<led>/hw_pattern is defined 3 times: Documentation/ABI/testing/sysfs-class-led-trigger-pattern:15 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx:1 Documentation/ABI/testing/sysfs-class-led-driver-el15203000:1
	Warning: /sys/class/leds/<led>/repeat is defined 2 times: Documentation/ABI/testing/sysfs-class-led-trigger-pattern:29 Documentation/ABI/testing/sysfs-class-led-driver-el15203000:136
	Warning: /sys/class/power_supply/<supply_name>/current_avg is defined 2 times: Documentation/ABI/testing/sysfs-class-power:105 Documentation/ABI/testing/sysfs-class-power:386
	Warning: /sys/class/power_supply/<supply_name>/current_max is defined 2 times: Documentation/ABI/testing/sysfs-class-power:117 Documentation/ABI/testing/sysfs-class-power:399
	Warning: /sys/class/power_supply/<supply_name>/current_now is defined 2 times: Documentation/ABI/testing/sysfs-class-power:126 Documentation/ABI/testing/sysfs-class-power:409
	Warning: /sys/class/power_supply/<supply_name>/temp is defined 2 times: Documentation/ABI/testing/sysfs-class-power:276 Documentation/ABI/testing/sysfs-class-power:486
	Warning: /sys/class/power_supply/<supply_name>/temp_alert_max is defined 2 times: Documentation/ABI/testing/sysfs-class-power:286 Documentation/ABI/testing/sysfs-class-power:498
	Warning: /sys/class/power_supply/<supply_name>/temp_alert_min is defined 2 times: Documentation/ABI/testing/sysfs-class-power:301 Documentation/ABI/testing/sysfs-class-power:514
	Warning: /sys/class/power_supply/<supply_name>/temp_max is defined 2 times: Documentation/ABI/testing/sysfs-class-power:317 Documentation/ABI/testing/sysfs-class-power:530
	Warning: /sys/class/power_supply/<supply_name>/temp_min is defined 2 times: Documentation/ABI/testing/sysfs-class-power:328 Documentation/ABI/testing/sysfs-class-power:540
	Warning: /sys/kernel/iommu_groups/reserved_regions is defined 2 times: Documentation/ABI/testing/sysfs-kernel-iommu_groups:16 Documentation/ABI/testing/sysfs-kernel-iommu_groups:28

With the line numbers where each occurrence happens, it should be
easier to solve such warnings.

> The driver-specific ones for LED should just be dropped to use the
> class-generic one.

I suspect that, instead of just dropping them, it could make sense to
move driver-specific ones to the ReST file for that driver,
like the ones inside Documentation/leds/.

> I guess just take them one at a time :)

Makes sense to me. Btw, right now there are 60 warnings like that.

Thanks,
Mauro
