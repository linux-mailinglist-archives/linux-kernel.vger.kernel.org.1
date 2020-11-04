Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D420A2A6B26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgKDQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:57:05 -0500
Received: from foss.arm.com ([217.140.110.172]:40386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729179AbgKDQ5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:57:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD25B139F;
        Wed,  4 Nov 2020 08:57:03 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 565323F718;
        Wed,  4 Nov 2020 08:57:02 -0800 (PST)
Date:   Wed, 4 Nov 2020 16:56:59 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 1/8] firmware: arm_scmi: review protocol registration
 interface
Message-ID: <20201104165659.GA24640@e120937-lin>
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-2-cristian.marussi@arm.com>
 <5bc2f96e-bb66-c816-d856-56a18456dcf5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc2f96e-bb66-c816-d856-56a18456dcf5@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

thanks for reviewing.

On Wed, Nov 04, 2020 at 11:16:06AM -0500, Thara Gopinath wrote:
> Hi Cristian,
> 
> On 10/28/20 4:29 PM, Cristian Marussi wrote:
> > Extend common protocol registration routines and provide some new generic
> > protocols' init/deinit helpers that tracks protocols' users and automatically
> > perform the proper initialization/de-initialization on demand.
> > 
> > Convert all protocols to use new registration schema while modifying only Base
> > protocol to use also the new initialization helpers.
> > 
> > All other standard protocols' initialization is still umodified and bound to
> > SCMI devices probing.
> 
> minor nit : umodified->unmodified.
> > 

Right.

> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 --> v2
> > - made all scmi_protocol refs const
> > - introduced IDR to handle protocols instead of static array
> > - refactored code around fast path
> > ---
> >   drivers/firmware/arm_scmi/base.c    |  10 +-
> >   drivers/firmware/arm_scmi/bus.c     |  61 +++++++---
> >   drivers/firmware/arm_scmi/clock.c   |  10 +-
> >   drivers/firmware/arm_scmi/common.h  |  31 ++++-
> >   drivers/firmware/arm_scmi/driver.c  | 168 +++++++++++++++++++++++++++-
> >   drivers/firmware/arm_scmi/notify.c  |   3 +-
> >   drivers/firmware/arm_scmi/perf.c    |  10 +-
> >   drivers/firmware/arm_scmi/power.c   |  10 +-
> >   drivers/firmware/arm_scmi/reset.c   |  10 +-
> >   drivers/firmware/arm_scmi/sensors.c |  10 +-
> >   drivers/firmware/arm_scmi/system.c  |   8 +-
> >   include/linux/scmi_protocol.h       |   6 +-
> >   12 files changed, 299 insertions(+), 38 deletions(-)
> > 
> 
> [...]
> 
> 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 3dfd8b6a0ebf..beae8991422d 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -11,11 +11,12 @@
> >    * various power domain DVFS including the core/cluster, certain system
> >    * clocks configuration, thermal sensors and many others.
> >    *
> > - * Copyright (C) 2018 ARM Ltd.
> > + * Copyright (C) 2018-2020 ARM Ltd.
> >    */
> >   #include <linux/bitmap.h>
> >   #include <linux/export.h>
> > +#include <linux/idr.h>
> >   #include <linux/io.h>
> >   #include <linux/kernel.h>
> >   #include <linux/ktime.h>
> > @@ -23,6 +24,7 @@
> >   #include <linux/of_address.h>
> >   #include <linux/of_device.h>
> >   #include <linux/processor.h>
> > +#include <linux/refcount.h>
> >   #include <linux/slab.h>
> >   #include "common.h"
> > @@ -68,6 +70,21 @@ struct scmi_xfers_info {
> >   	spinlock_t xfer_lock;
> >   };
> > +/**
> > + * struct scmi_protocol_instance  - Describe an initialized protocol instance.
> > + * @proto: A reference to the protocol descriptor.
> > + * @gid: A reference for per-protocol devres management.
> > + * @users: A refcount to track effective users of this protocol.
> > + *
> > + * Each protocol is initialized independently once for each SCMI platform in
> > + * which is defined by DT and implemented by the SCMI server fw.
> > + */
> > +struct scmi_protocol_instance {
> > +	const struct scmi_protocol	*proto;
> > +	void				*gid;
> > +	refcount_t			users;
> > +};
> 
> Why do you need a separate protocol_instance? Will there be two instances of
> the same protocol for a single scmi device/instance?
> Else everything that has been defined in this struct in this patch the
> following ones can be rolled into scmi_protocol struct, right ?
> 

Basically scm_protocol represents generically a protocol with all its ops,
events and stuff, and it is registered during core init or protocol module
loading with the core so that it appears into the available protocols IDR.

Each protocol then, if available, is later initialized only on its first usage
after a get/ops or notify reg by an SCMI driver; now, this SCMI driver operates
on an handle which represents in fact an SCMI instance (server) and you could
have more than one instance in theory on the system (multiple SCMI servers
identified by multiple DT nodes).

As an example you could have two distinct MCU handling two different set of
sensors, so you'd have two distinct DT nodes representing each of these SCMI
servers (with distinct transport channels of course) and you'll endup with two
instances of the core SCMI platform driver (so 2 distinct handles), creating 2
distinct devices each for the sensor protocol, so ending up at the end with two
different running instances of the SCMI Sensor driver (hwmon) using a distinct
handle to communicate with the correspondent sensors: as a consequence I
initialize a distinct protocol instance structure for each handle, and keep
distinct resource accounting (gid an users) while keeping a single reference
(proto) to the same undelrying protocol descriptor; you could see as the
scmi_protocol representing a class and the scmi_protocol_instance being an
instantiated object (for a specific SCMI handle) in our poor C-Based OO world :D

In this way the two possible SCMI instances stacks are completely separated from
the lower transport channels up to the SCMI driver users, including the
intermediate protocols implementation.


> > +
> >   /**
> >    * struct scmi_info - Structure representing a SCMI instance
> >    *
> > @@ -80,6 +97,10 @@ struct scmi_xfers_info {
> >    * @rx_minfo: Universal Receive Message management info
> >    * @tx_idr: IDR object to map protocol id to Tx channel info pointer
> >    * @rx_idr: IDR object to map protocol id to Rx channel info pointer
> > + * @protocols: IDR for protocols' instance descriptors initialized for
> > + *	       this SCMI instance: populated on protocol's first attempted
> > + *	       usage.
> > + * @protocols_mtx: A mutex to protect protocols instances initialization.
> >    * @protocols_imp: List of protocols implemented, currently maximum of
> >    *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
> >    * @node: List head
> > @@ -94,6 +115,9 @@ struct scmi_info {
> >   	struct scmi_xfers_info rx_minfo;
> >   	struct idr tx_idr;
> >   	struct idr rx_idr;
> > +	struct idr protocols;
> > +	/* Ensure mutual exclusive access to protocols instance array */
> > +	struct mutex protocols_mtx;
> >   	u8 *protocols_imp;
> >   	struct list_head node;
> >   	int users;
> > @@ -519,6 +543,127 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
> >   	return ret;
> >   }
> > +/**
> > + * scmi_get_protocol_instance  - Protocol initialization helper.
> > + * @handle: A reference to the SCMI platform instance.
> > + * @protocol_id: The protocol being requested.
> > + *
> > + * In case the required protocol has never been requested before for this
> > + * instance, allocate and initialize all the needed structures while handling
> > + * resource allocation with a dedicated per-protocol devres subgroup.
> > + *
> > + * Return: A reference to an initialized protocol instance or error on failure.
> > + */
> > +static struct scmi_protocol_instance * __must_check
> > +scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
> > +{
> > +	int ret = -ENOMEM;
> > +	void *gid;
> > +	struct scmi_protocol_instance *pi;
> > +	struct scmi_info *info = handle_to_scmi_info(handle);
> > +
> > +	mutex_lock(&info->protocols_mtx);
> > +	pi = idr_find(&info->protocols, protocol_id);
> > +
> > +	if (pi) {
> > +		refcount_inc(&pi->users);
> > +	} else {
> > +		const struct scmi_protocol *proto;
> > +
> > +		/* Fail if protocol not registered on bus */
> > +		proto = scmi_get_protocol(protocol_id);
> > +		if (!proto) {
> > +			ret = -ENODEV;
> > +			goto out;
> > +		}
> > +
> > +		/* Protocol specific devres group */
> > +		gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
> > +		if (!gid)
> > +			goto out;
> > +
> > +		pi = devm_kzalloc(handle->dev, sizeof(*pi), GFP_KERNEL);
> > +		if (!pi)
> > +			goto clean;
> > +
> > +		pi->gid = gid;
> > +		pi->proto = proto;
> > +		refcount_set(&pi->users, 1);
> > +		/* proto->init is assured NON NULL by scmi_protocol_register */
> > +		ret = pi->proto->init(handle);
> 
> So init for a protocol will be called twice. Is this intentional ? Once
> during the device probe via scmi_dev_probe and scmi_protocol_init. And
> once via scmi_get_protocol_instance which gets called in get_ops apis
> defined and used in the later patches.
> 

This is part of the desperate attempt to split this series as much as
possible :D ... so that in this patch I introduce this code path for
initialization (and all the related helpers) but I'm using it only for
the Base protocol (via acquire) ... all the other standard protocols here
still reliy on the probe based legacy initialization, then later in the
series I drop all the init@probe code and rely only on this path for
init and also events registrations.

> > +		if (ret)
> > +			goto clean;
> > +
> > +		ret = idr_alloc(&info->protocols, pi,
> > +				protocol_id, protocol_id + 1, GFP_KERNEL);
> > +		if (ret != protocol_id)
> > +			goto clean;
> > +
> > +		devres_close_group(handle->dev, pi->gid);
> > +		dev_dbg(handle->dev, "Initialized protocol: 0x%X\n",
> > +			protocol_id);
> > +	}
> > +	mutex_unlock(&info->protocols_mtx);
> > +
> > +	return pi;
> > +
> > +clean:
> > +	devres_release_group(handle->dev, gid);
> > +out:
> > +	mutex_unlock(&info->protocols_mtx);
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +/**
> > + * scmi_acquire_protocol  - Protocol acquire
> > + * @handle: A reference to the SCMI platform instance.
> > + * @protocol_id: The protocol being requested.
> > + *
> > + * Register a new user for the requested protocol on the specified SCMI
> > + * platform instance, possibly triggering its initialization on first user.
> > + *
> > + * Return: 0 if protocol was acquired successfully.
> > + */
> > +int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
> > +{
> > +	return PTR_ERR_OR_ZERO(scmi_get_protocol_instance(handle, protocol_id));
> > +}
> > +
> > +/**
> > + * scmi_release_protocol  - Protocol de-initialization helper.
> > + * @handle: A reference to the SCMI platform instance.
> > + * @protocol_id: The protocol being requested.
> > + *
> > + * Remove one user for the specified protocol and triggers de-initialization
> > + * and resources de-allocation once the last user has gone.
> > + */
> > +void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
> > +{
> > +	struct scmi_info *info = handle_to_scmi_info(handle);
> > +	struct scmi_protocol_instance *pi;
> > +
> > +	mutex_lock(&info->protocols_mtx);
> > +	pi = idr_find(&info->protocols, protocol_id);
> > +	if (WARN_ON(!pi))
> > +		goto out;
> > +
> > +	if (refcount_dec_and_test(&pi->users)) {
> > +		void *gid = pi->gid;
> > +
> > +		if (pi->proto->deinit)
> > +			pi->proto->deinit(handle);
> > +
> > +		idr_remove(&info->protocols, protocol_id);
> > +
> > +		devres_release_group(handle->dev, gid);
> > +		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
> > +			protocol_id);
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&info->protocols_mtx);
> > +}
> > +
> >   void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
> >   				     u8 *prot_imp)
> >   {
> > @@ -785,6 +930,8 @@ static int scmi_probe(struct platform_device *pdev)
> >   	info->dev = dev;
> >   	info->desc = desc;
> >   	INIT_LIST_HEAD(&info->node);
> > +	idr_init(&info->protocols);
> > +	mutex_init(&info->protocols_mtx);
> >   	platform_set_drvdata(pdev, info);
> >   	idr_init(&info->tx_idr);
> > @@ -805,9 +952,14 @@ static int scmi_probe(struct platform_device *pdev)
> >   	if (scmi_notification_init(handle))
> >   		dev_err(dev, "SCMI Notifications NOT available.\n");
> > -	ret = scmi_base_protocol_init(handle);
> > +	/*
> > +	 * Trigger SCMI Base protocol initialization.
> > +	 * It's mandatory and won't be ever released/deinit until the
> > +	 * SCMI stack is shutdown/unloaded as a whole.
> > +	 */
> > +	ret = scmi_acquire_protocol(handle, SCMI_PROTOCOL_BASE);
> >   	if (ret) {
> > -		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> > +		dev_err(dev, "unable to communicate with SCMI\n");
> >   		return ret;
> >   	}
> > @@ -859,6 +1011,10 @@ static int scmi_remove(struct platform_device *pdev)
> >   	if (ret)
> >   		return ret;
> > +	mutex_lock(&info->protocols_mtx);
> > +	idr_destroy(&info->protocols);
> > +	mutex_unlock(&info->protocols_mtx);
> > +
> >   	/* Safe to free channels since no more users */
> >   	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
> >   	idr_destroy(&info->tx_idr);
> > @@ -941,6 +1097,8 @@ static int __init scmi_driver_init(void)
> >   {
> >   	scmi_bus_init();
> > +	scmi_base_register();
> > +
> 
> minor nit. extra line addeed ?
> 

Yep.

Thanks

Cristian

> -- 
> Warm Regards
> Thara
