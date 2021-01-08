Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B561F2EEA5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbhAHAXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbhAHAXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:23:37 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26821C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 16:22:57 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 17CA522EE3;
        Fri,  8 Jan 2021 01:22:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610065374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kp9+IsP6zTHvwkJZGQlS67rySYNBDrjPSSPFm5ckv3w=;
        b=m984ciF1uwGggx41uMVz5L1bK5onF1lnUG6R1tQdikSUPRqmioyuQ0rIJzW2sLxRPcBEoE
        Srk/cQRj7zn/Vh1rQVN6dKwUWO0MXSM81+W7U5qEJeqPIu/aAu7ZqYxvJH/mrZOqkhgL3d
        rZU/P5pfPAtskDliDQ6nvek3oxEg0RY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Jan 2021 01:22:54 +0100
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] driver core: Fix device link device name collision
In-Reply-To: <CAGETcx9J-WzdE+HAvftERPj9K5Q5gV_F03GKAOrQ9Vv733+szw@mail.gmail.com>
References: <20210106232641.459081-1-saravanak@google.com>
 <305deba691b59aec2414dee611c23e69@walle.cc>
 <CAGETcx9J-WzdE+HAvftERPj9K5Q5gV_F03GKAOrQ9Vv733+szw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1f1263e3f383918573a3e4238e4b1fc3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-08 00:39, schrieb Saravana Kannan:
> On Thu, Jan 7, 2021 at 1:56 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Hi Saravana,
>> 
>> Am 2021-01-07 00:26, schrieb Saravana Kannan:
>> > The device link device's name was of the form:
>> > <supplier-dev-name>--<consumer-dev-name>
>> >
>> > This can cause name collision as reported here [1] as device names are
>> > not globally unique. Since device names have to be unique within the
>> > bus/class, add the bus/class name as a prefix to the device names used
>> > to
>> > construct the device link device name.
>> >
>> > So the devuce link device's name will be of the form:
>> > <supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name><consumer-dev-name>
>> >
>> > [1] -
>> > https://lore.kernel.org/lkml/20201229033440.32142-1-michael@walle.cc/
>> > Reported-by: Michael Walle <michael@walle.cc>
>> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>> 
>> missing Fixes: tag?
>> 
>> > Can you please test this? This should fix your issue.
>> 
>> Unfortunately, not:
>> 
>> [    4.234617] fsl_enetc 0000:00:00.0: Adding to iommu group 1
>> [    4.346768] fsl_enetc 0000:00:00.0: enabling device (0400 -> 0402)
>> [    4.353012] fsl_enetc 0000:00:00.0: no MAC address specified for 
>> SI1,
>> using 3e:6a:a1:57:9c:b0
>> [    4.361580] fsl_enetc 0000:00:00.0: no MAC address specified for 
>> SI2,
>> using 9e:8b:7b:e3:e2:ad
>> [    4.370539] libphy: Freescale ENETC MDIO Bus: probed
>> [    4.376751] libphy: Freescale ENETC internal MDIO Bus: probed
>> [    4.383060] fsl_enetc 0000:00:00.1: Adding to iommu group 2
>> [    4.494764] fsl_enetc 0000:00:00.1: enabling device (0400 -> 0402)
>> [    4.501012] fsl_enetc 0000:00:00.1: no MAC address specified for 
>> SI1,
>> using ee:99:cb:b1:24:4c
>> [    4.509580] fsl_enetc 0000:00:00.1: no MAC address specified for 
>> SI2,
>> using 66:60:f4:0d:9e:e0
>> [    4.518556] sysfs: cannot create duplicate filename
>> '/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/consumer:0000:00:00.1'
>> [    4.530882] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
>> 5.11.0-rc2-next-20210107-00017-g392ec8cbdef5 #303
>> [    4.540317] Hardware name: Kontron KBox A-230-LS (DT)
>> [    4.545385] Call trace:
>> [    4.547834]  dump_backtrace+0x0/0x1b8
>> [    4.551517]  show_stack+0x20/0x70
>> [    4.554844]  dump_stack+0xd8/0x134
>> [    4.558258]  sysfs_warn_dup+0x6c/0x88
>> [    4.561932]  sysfs_do_create_link_sd.isra.2+0x10c/0x110
>> [    4.567175]  sysfs_create_link+0x2c/0x50
>> [    4.571109]  devlink_add_symlinks+0x110/0x1b8
>> [    4.575484]  device_add+0x460/0x798
>> [    4.578982]  device_link_add+0x46c/0x628
>> [    4.582917]  fw_devlink_create_devlink+0xb8/0xc8
>> [    4.587549]  __fw_devlink_link_to_suppliers+0x84/0x180
>> [    4.592705]  __fw_devlink_link_to_suppliers+0x134/0x180
>> [    4.597948]  device_add+0x778/0x798
>> [    4.601445]  device_register+0x28/0x38
>> [    4.605205]  __mdiobus_register+0x94/0x340
>> [    4.609317]  of_mdiobus_register+0xb4/0x380
>> [    4.613513]  enetc_pf_probe+0x73c/0xb10
>> [    4.617362]  local_pci_probe+0x48/0xb8
>> [    4.621125]  pci_device_probe+0x120/0x1c0
>> [    4.625146]  really_probe+0xec/0x3c0
>> [    4.628732]  driver_probe_device+0x60/0xc0
>> [    4.632842]  device_driver_attach+0x7c/0x88
>> [    4.637039]  __driver_attach+0x60/0xe8
>> [    4.640799]  bus_for_each_dev+0x7c/0xd0
>> [    4.644647]  driver_attach+0x2c/0x38
>> [    4.648232]  bus_add_driver+0x194/0x1f8
>> [    4.652079]  driver_register+0x6c/0x128
>> [    4.655927]  __pci_register_driver+0x4c/0x58
>> [    4.660213]  enetc_pf_driver_init+0x2c/0x38
>> [    4.664412]  do_one_initcall+0x54/0x2d8
>> [    4.668260]  kernel_init_freeable+0x200/0x26c
>> [    4.672631]  kernel_init+0x1c/0x120
>> [    4.676131]  ret_from_fork+0x10/0x30
>> [    4.679758] libphy: Freescale ENETC MDIO Bus: probed
>> [    4.686590] fsl_enetc 0000:00:00.2: Adding to iommu group 3
>> [    4.798764] fsl_enetc 0000:00:00.2: enabling device (0400 -> 0402)
>> [    4.805010] fsl_enetc 0000:00:00.2: no MAC address specified for 
>> SI0,
>> using 2a:90:8e:f9:ee:5d
>> [    4.814279] fsl_enetc 0000:00:00.6: Adding to iommu group 4
>> [    4.819992] fsl_enetc 0000:00:00.6: device is disabled, skipping
>> [    4.826146] fsl_enetc_mdio 0000:00:00.3: Adding to iommu group 5
>> [    4.938764] fsl_enetc_mdio 0000:00:00.3: enabling device (0400 ->
>> 0402)
>> [    4.945601] libphy: FSL PCIe IE Central MDIO Bus: probed
>> 
>> Please note the:
>> [    4.518556] sysfs: cannot create duplicate filename
>> '/devices/platform/soc/1f0000000.pcie/pci0000:00/0000:00:00.1/consumer:0000:00:00.1'
>> 
>> Your patch just addresses the link names, but not the ones for
>> "consumer:"
>> and "supplier:" under the device itself, right?
> 
> Ah, this is another location where I needed to fix the collision. Will
> send out a v2.
> 
>> > Having said that, do you have some local DT changes when you are
>> > testing
>> > this?
>> 
>> No. But keep in mind that this is also PCI and there might be other
>> devices too.
> 
> Right, but fw_devlink is only parsing DT to figure out the
> dependencies. So I'm confused where these dependencies are inferred
> from DT. I did check all the DT includes, but it's hard to tell if you
> have downstream changes or if I'm missing something. Looks like the
> mdio bus or one of its children is dependent on both the mdio bus node
> AND the PCI root node. Do you know which one that might be? Can you
> point to it in DT?

Sorry, I'm not familiar with that whole devlink thing. But one thing
I noticed is, that it only seems to happen with the following device
tree:
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
and not with:
   arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts

The difference here is that on the latter the second enetc is not
enabled (pci dev 0000:00:00.1).

And in the log I've sent you in the v2 thread I've noticed that the
filenames seem to be truncated:

[   10.875402] platform 2000000.i2c:sl28cpld@4a:gpio@10: Linked as a 
sync state only consumer to 2310000.gpio
[   10.890943] sysfs: cannot create duplicate filename 
'/devices/platform/soc/2310000.gpio/consumer:platform:2000000.i2c:sl28cpld@4'

Shouldn't this be 
"/devices/platform/soc/2310000.gpio/consumer:platform:2000000.i2c:sl28cpld@4a:gpio@10 
?

> If not, can you change both the dev_dbg() calls in device_link_add()
> to dev_info() and share the boot log with me? Maybe even enable
> initcall_debug? My v2 should fix your collision issue, but I still
> want to make sure the refactor isn't creating any links it shouldn't
> be creating.

See the v2 thread.

-michael
