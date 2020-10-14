Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710D528E19E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgJNNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:48:24 -0400
Received: from foss.arm.com ([217.140.110.172]:49006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbgJNNsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:48:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E510D31B;
        Wed, 14 Oct 2020 06:48:22 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12B8F3F71F;
        Wed, 14 Oct 2020 06:48:21 -0700 (PDT)
Date:   Wed, 14 Oct 2020 14:48:19 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix duplicate workqueue name
Message-ID: <20201014134819.GA24061@e120937-lin>
References: <20201014021737.287340-1-f.fainelli@gmail.com>
 <20201014091806.GB20315@bogus>
 <20201014130524.cj42wknvzdpgsbsr@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201014130524.cj42wknvzdpgsbsr@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Oct 14, 2020 at 02:05:24PM +0100, Sudeep Holla wrote:
> On Wed, Oct 14, 2020 at 10:18:06AM +0100, Sudeep Holla wrote:
> > Hi Florian,
> > 
> > Thanks for the patch, it shows someone else is also using this and
> > testing 😉.
> > 
> > On Tue, Oct 13, 2020 at 07:17:37PM -0700, Florian Fainelli wrote:
> > > When more than a single SCMI device are present in the system, the
> > > creation of the notification workqueue with the WQ_SYSFS flag will lead
> > > to the following sysfs duplicate node warning:
> > > 
> > 
> > Please trim the calltrace next time without timestamp and register raw
> > hex values.
> > 
> > You using this on 32-bit platform ? If so, thanks for additional test
> > coverage.
> > 
> > > [    9.259990] sysfs: cannot create duplicate filename '/devices/virtual/workqueue/scmi_notify'
> > > [    9.260024] CPU: 0 PID: 20 Comm: kworker/0:1 Not tainted 5.9.0-gdf4dd84a3f7d #29
> > > [    9.260045] Hardware name: Broadcom STB (Flattened Device Tree)
> > > [    9.260083] Workqueue: events deferred_probe_work_func
> > > [    9.260099] Backtrace:
> > > [    9.260127] [<c02120b4>] (dump_backtrace) from [<c02123d8>] (show_stack+0x20/0x24)
> > > [    9.260155]  r9:ffffffff r8:00000000 r7:c298e3c0 r6:60000013 r5:00000000 r4:c298e3c0
> > > [    9.260186] [<c02123b8>] (show_stack) from [<c08852a0>] (dump_stack+0xbc/0xe0)
> > > [    9.260216] [<c08851e4>] (dump_stack) from [<c054442c>] (sysfs_warn_dup+0x70/0x80)
> > > [    9.260243]  r10:e472d814 r9:ffffffef r8:e4614a50 r7:c2806d48 r6:e0e50f80 r5:e4614a50
> > > [    9.260265]  r4:e0e82000 r3:c5b17c34
> > > [    9.260285] [<c05443bc>] (sysfs_warn_dup) from [<c05445fc>] (sysfs_create_dir_ns+0x15c/0x1a4)
> > > [    9.260310]  r7:c2806d48 r6:ffffffef r5:e0dff008 r4:bb8cd6e4
> > > [    9.260335] [<c05444a0>] (sysfs_create_dir_ns) from [<c088ebac>] (kobject_add_internal+0x140/0x4d0)
> > > [    9.260363]  r9:e451fa80 r8:e0dff01c r7:e0dff014 r6:e45b1400 r5:e0dff018 r4:e0dff008
> > > [    9.260390] [<c088ea6c>] (kobject_add_internal) from [<c088f004>] (kobject_add+0xc8/0x138)
> > > [    9.260416]  r10:e0dff030 r9:00000000 r8:e45b1400 r7:00000000 r6:c2806d48 r5:e0dff008
> > > [    9.260436]  r4:bb8cd708
> > > [    9.260455] [<c088ef3c>] (kobject_add) from [<c0a0bc70>] (device_add+0x1dc/0xc20)
> > > [    9.260476]  r3:e0dff014 r2:00000000
> > > [    9.260495]  r9:00000000 r8:e466b980 r7:e45b1400 r6:c2806d48 r5:bb8cd724 r4:e0dff008
> > > [    9.260521] [<c0a0ba94>] (device_add) from [<c0a0c6d8>] (device_register+0x24/0x28)
> > > [    9.260547]  r10:c2831340 r9:e0dfec08 r8:e0dff028 r7:e0dfecc0 r6:e0dfec00 r5:e0dff008
> > > [    9.260567]  r4:e0dff008
> > > [    9.260586] [<c0a0c6b4>] (device_register) from [<c025f2a8>] (workqueue_sysfs_register+0xe4/0x1f0)
> > > [    9.260609]  r5:e0dff008 r4:e0dff000
> > > [    9.260627] [<c025f1c4>] (workqueue_sysfs_register) from [<c025f7fc>] (alloc_workqueue+0x448/0x6ac)
> > > [    9.260655]  r10:e0dfecc0 r9:e0dfec08 r8:e0dfec0c r7:e0dfec04 r6:e0dfecc0 r5:e0dfec00
> > > [    9.260675]  r4:00000001
> > > [    9.260698] [<c025f3b4>] (alloc_workqueue) from [<c0d8b58c>] (scmi_notification_init+0x78/0x1dc)
> > > [    9.260720]  r3:c0a1b488 r2:00000000
> > > [    9.260739]  r10:e0de1040 r9:00800004 r8:e0de10d8 r7:e0de10f4 r6:e0de1074 r5:e0e54740
> > > [    9.260759]  r4:e0e50d00
> > > [    9.260778] [<c0d8b514>] (scmi_notification_init) from [<c0d87c00>] (scmi_probe+0x268/0x4fc)
> > > [    9.260805]  r9:00800004 r8:e0de10d8 r7:e0de10f4 r6:e0de1074 r5:e0de10f0 r4:e472d810
> > > [    9.260833] [<c0d87998>] (scmi_probe) from [<c0a17d74>] (platform_drv_probe+0x70/0xc8)
> > > [    9.260859]  r10:e472d844 r9:c2ab02b4 r8:c2b5e298 r7:00000000 r6:c2ab02b4 r5:00000000
> > > [    9.260879]  r4:e472d810
> > > [    9.260898] [<c0a17d04>] (platform_drv_probe) from [<c0a13e80>] (really_probe+0x184/0x728)
> > > [    9.260922]  r7:00000000 r6:c2fc82a0 r5:c2fc8220 r4:e472d810
> > > [    9.260946] [<c0a13cfc>] (really_probe) from [<c0a146b4>] (driver_probe_device+0xa4/0x278)
> > > [    9.260973]  r10:e0cef438 r9:c0a14a04 r8:c2b771c0 r7:c2b5e298 r6:c2ab02b4 r5:e472d834
> > > [    9.260993]  r4:e472d810
> > > [    9.261014] [<c0a14610>] (driver_probe_device) from [<c0a14aec>] (__device_attach_driver+0xe8/0x148)
> > > [    9.261042]  r10:e0cef438 r9:c0a14a04 r8:e466bdc0 r7:e472d810 r6:00000000 r5:c2ab02b4
> > > [    9.261062]  r4:e466bdc0
> > > [    9.261082] [<c0a14a04>] (__device_attach_driver) from [<c0a10f6c>] (bus_for_each_drv+0x108/0x158)
> > > [    9.261107]  r7:c2806d48 r6:00000000 r5:bb8cd79c r4:e466bd00
> > > [    9.261131] [<c0a10e64>] (bus_for_each_drv) from [<c0a13c38>] (__device_attach+0x190/0x234)
> > > [    9.261158]  r10:e46fde00 r9:e472d848 r8:e472d854 r7:e466be00 r6:c2806d48 r5:bb8cd7b4
> > > [    9.261178]  r4:e472d810
> > > [    9.261199] [<c0a13aa8>] (__device_attach) from [<c0a14b68>] (device_initial_probe+0x1c/0x20)
> > > [    9.261226]  r10:e46fde54 r9:c29d6380 r8:c29d7910 r7:e472d810 r6:c29d78c0 r5:c29d6340
> > > [    9.261246]  r4:e44efe00
> > > [    9.261266] [<c0a14b4c>] (device_initial_probe) from [<c0a125fc>] (bus_probe_device+0xdc/0xec)
> > > [    9.261296] [<c0a12520>] (bus_probe_device) from [<c0a12e24>] (deferred_probe_work_func+0xd4/0x11c)
> > > [    9.261324]  r9:c29d6380 r8:e4672e54 r7:c29d6380 r6:c29d6340 r5:c29d6340 r4:e472d810
> > > [    9.261356] [<c0a12d50>] (deferred_probe_work_func) from [<c025a534>] (process_one_work+0x420/0x8f0)
> > > [    9.261384]  r10:e452fd84 r9:c2b53750 r8:00000000 r7:e452ae0c r6:e8a1e240 r5:e452ae00
> > > [    9.261404]  r4:c29d6440
> > > [    9.261424] [<c025a114>] (process_one_work) from [<c025af00>] (worker_thread+0x4fc/0x91c)
> > > [    9.261450]  r10:e8a1e258 r9:e452ae00 r8:e8a1e254 r7:e8a1e240 r6:e452fd84 r5:e8a1e254
> > > [    9.261470]  r4:e452ae14
> > > [    9.261492] [<c025aa04>] (worker_thread) from [<c026591c>] (kthread+0x21c/0x22c)
> > > [    9.261517]  r10:e455bce0 r9:e45b8d80 r8:e452ae00 r7:c025aa04 r6:e45b8d80 r5:00000000
> > > [    9.261537]  r4:e45c0400
> > > [    9.261555] [<c0265700>] (kthread) from [<c0200114>] (ret_from_fork+0x14/0x20)
> > > [    9.261575] Exception stack(0xe466bfb0 to 0xe466bff8)
> > > [    9.261593] bfa0:                                     00000000 00000000 00000000 00000000
> > > [    9.261618] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > [    9.261641] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > [    9.261663]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0265700
> > > [    9.261683]  r4:e4622080
> > > [    9.261728] kobject_add_internal failed for scmi_notify with -EEXIST, don't try to register things with the same name in the same directory.
> > > [    9.261805] arm-scmi brcm_scmi@1: SCMI Notifications - Initialization Failed.
> > > [    9.261847] arm-scmi brcm_scmi@1: SCMI Notifications NOT available.
> > > [    9.262026] arm-scmi brcm_scmi@1: SCMI Protocol v1.0 'brcm-scmi:' Firmware version 0x1
> > > 
> > > Fix this by using dev_name(handle->dev) which guarantees that the name is
> > > unique and this also helps correlate which notification workqueue corresponds
> > > to which SCMI device instance.
> > >
> > 
> > I am curious as how multiple SCMI instances are used. We know few limitations
> > in the code to handle that yet, so interested to know if you are carrying
> > more patches/fixes.
> > 
> > > Fixes: bd31b249692e ("firmware: arm_scmi: Add notification dispatch and delivery")
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >  drivers/firmware/arm_scmi/notify.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> > > index 4731daaacd19..24c9ef232f48 100644
> > > --- a/drivers/firmware/arm_scmi/notify.c
> > > +++ b/drivers/firmware/arm_scmi/notify.c
> > > @@ -1468,7 +1468,7 @@ int scmi_notification_init(struct scmi_handle *handle)
> > >  	ni->gid = gid;
> > >  	ni->handle = handle;
> > >  
> > > -	ni->notify_wq = alloc_workqueue("scmi_notify",
> > > +	ni->notify_wq = alloc_workqueue(dev_name(handle->dev),
> > 
> > Not sure if it makes sense to add "_notify" to clearly identify the workqueue.
> > 
> 
> I have pushed a version with above change [1], please check if you are
> happy with that ?
> 
> -- 
> Regards,
> Sudeep
> 
> [1] https://git.kernel.org/sudeep.holla/linux/c/b2cd15549b

I agree with the need to retain _notify name, but I'm not so sure about
the above patch...which is:


diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index c24e427dce0d7..f60fa630dd98f 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1461,6 +1461,7 @@ static const struct scmi_notify_ops notify_ops = {
 int scmi_notification_init(struct scmi_handle *handle)
 {
 	void *gid;
+	char scmi_wq_name[32];
 	struct scmi_notify_instance *ni;
 
 	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
@@ -1474,7 +1475,8 @@ int scmi_notification_init(struct scmi_handle *handle)
 	ni->gid = gid;
 	ni->handle = handle;
 
-	ni->notify_wq = alloc_workqueue("scmi_notify",
+	sprintf(scmi_wq_name, "%s_notify", dev_name(handle->dev));
+	ni->notify_wq = alloc_workqueue(scmi_wq_name,
 					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
 					0);
 	if (!ni->notify_wq)


...does not expose a potential buffer overflow given that the dev_name now comes
from the DT chosen name for this SCMI server instance ?

I'd use snprintf and enlarge a bit the static scmi_wq_name[] to fit a max
device bane plus "_notify".

Regards

Cristian



