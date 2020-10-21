Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B094294B10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438580AbgJUKIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:08:46 -0400
Received: from foss.arm.com ([217.140.110.172]:32956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438559AbgJUKIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:08:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75A1B1FB;
        Wed, 21 Oct 2020 03:08:45 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0010B3F66E;
        Wed, 21 Oct 2020 03:08:43 -0700 (PDT)
Date:   Wed, 21 Oct 2020 11:08:41 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 01/11] firmware: arm_scmi: review protocol registration
 interface
Message-ID: <20201021100841.GA20482@e120937-lin>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-2-cristian.marussi@arm.com>
 <70179e01-5157-5531-1ed1-12dcbe6aced4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70179e01-5157-5531-1ed1-12dcbe6aced4@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:46:46PM -0400, Thara Gopinath wrote:
> Hi Cristian,
> 
> Thanks for this series!
> 
Hi Thara,

thanks for reviewing.


> On 10/14/20 11:05 AM, Cristian Marussi wrote:
> > Extend common protocol registration routines and provide some new generic
> > protocols' init/deinit helpers that tracks protocols' users and automatically
> > perform the proper initialization/de-initialization on demand.
> > 
> > Convert all protocols to use new registration schema while modifying only Base
> > protocol to use also the new initialization helpers.
> > 
> > All other standard protocols' initialization is still umodified and bound to
> > SCMI devices probing.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
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
> >   12 files changed, 298 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> > index 017e5d8bd869..f19e08ed4369 100644
> > --- a/drivers/firmware/arm_scmi/base.c
> > +++ b/drivers/firmware/arm_scmi/base.c
> > @@ -318,7 +318,7 @@ static const struct scmi_event_ops base_event_ops = {
> >   	.fill_custom_report = scmi_base_fill_custom_report,
> >   };
> > -int scmi_base_protocol_init(struct scmi_handle *h)
> > +static int scmi_base_protocol_init(struct scmi_handle *h)
> >   {
> >   	int id, ret;
> >   	u8 *prot_imp;
> > @@ -365,3 +365,11 @@ int scmi_base_protocol_init(struct scmi_handle *h)
> >   	return 0;
> >   }
> > +
> > +static struct scmi_protocol scmi_base = {
> > +	.id = SCMI_PROTOCOL_BASE,
> > +	.init = &scmi_base_protocol_init,
> > +	.ops = NULL,
> > +};
> > +
> > +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(base, scmi_base)
> > diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> > index 1377ec76a45d..afa2e4818a2b 100644
> > --- a/drivers/firmware/arm_scmi/bus.c
> > +++ b/drivers/firmware/arm_scmi/bus.c
> > @@ -16,7 +16,7 @@
> >   #include "common.h"
> >   static DEFINE_IDA(scmi_bus_id);
> > -static DEFINE_IDR(scmi_protocols);
> > +static DEFINE_IDR(scmi_available_protocols);
> >   static DEFINE_SPINLOCK(protocol_lock);
> >   static const struct scmi_device_id *
> > @@ -51,13 +51,29 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
> >   	return 0;
> >   }
> > +const struct scmi_protocol *scmi_get_protocol(int protocol_id)
> > +{
> > +	const struct scmi_protocol *proto;
> > +
> > +	proto = idr_find(&scmi_available_protocols, protocol_id);
> > +	if (!proto) {
> > +		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
> > +		return NULL;
> > +	}
> > +
> > +	pr_debug("GOT SCMI Protocol 0x%x\n", protocol_id);
> > +
> > +	return proto;
> > +}
> > +
> >   static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
> >   {
> > -	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);
> > +	const struct scmi_protocol *proto;
> > -	if (unlikely(!fn))
> > +	proto = idr_find(&scmi_available_protocols, protocol_id);
> > +	if (!proto)
> >   		return -EINVAL;
> 
> 
> Any reason not to use the above scmi_get_protocol here ?
> 

You're right I spotted this awkward thing but I left it because the
whole scmi_protocol_init() is removed later on in this series, moving
proto initialization to when the protocol is requested, so it seemed
silly to fix code that I'm going to remove as a whole in the same
series.
Probably I could split the whole series better to avoid this. (or fix
it anyway and later removed)

> > -	return fn(handle);
> > +	return proto->init(handle);
> >   }
> >   static int scmi_protocol_dummy_init(struct scmi_handle *handle)
> > @@ -84,7 +100,7 @@ static int scmi_dev_probe(struct device *dev)
> >   		return ret;
> >   	/* Skip protocol initialisation for additional devices */
> > -	idr_replace(&scmi_protocols, &scmi_protocol_dummy_init,
> > +	idr_replace(&scmi_available_protocols, &scmi_protocol_dummy_init,
> >   		    scmi_dev->protocol_id);
> >   	return scmi_drv->probe(scmi_dev);
> > @@ -194,26 +210,45 @@ void scmi_set_handle(struct scmi_device *scmi_dev)
> >   	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
> >   }
> > -int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn)
> > +int scmi_protocol_register(struct scmi_protocol *proto)
> >   {
> >   	int ret;
> > +	if (!proto) {
> > +		pr_err("invalid protocol\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!proto->init) {
> > +		pr_err("missing .init() for protocol 0x%x\n", proto->id);
> > +		return -EINVAL;
> > +	}
> > +
> >   	spin_lock(&protocol_lock);
> > -	ret = idr_alloc(&scmi_protocols, fn, protocol_id, protocol_id + 1,
> > -			GFP_ATOMIC);
> > +	ret = idr_alloc(&scmi_available_protocols, proto,
> > +			proto->id, proto->id + 1, GFP_ATOMIC);
> >   	spin_unlock(&protocol_lock);
> > -	if (ret != protocol_id)
> > -		pr_err("unable to allocate SCMI idr slot, err %d\n", ret);
> > +	if (ret != proto->id) {
> > +		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
> > +		       proto->id, ret);
> > +		return ret;
> > +	}
> > +
> > +	pr_debug("Registered SCMI Protocol 0x%x\n", proto->id);
> > -	return ret;
> > +	return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(scmi_protocol_register);
> > -void scmi_protocol_unregister(int protocol_id)
> > +void scmi_protocol_unregister(const struct scmi_protocol *proto)
> >   {
> >   	spin_lock(&protocol_lock);
> > -	idr_remove(&scmi_protocols, protocol_id);
> > +	idr_remove(&scmi_available_protocols, proto->id);
> >   	spin_unlock(&protocol_lock);
> > +
> > +	pr_debug("Unregistered SCMI Protocol 0x%x\n", proto->id);
> > +
> > +	return;
> >   }
> >   EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
> 
> [...]
> 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 3dfd8b6a0ebf..7de994e49884 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -23,6 +23,7 @@
> >   #include <linux/of_address.h>
> >   #include <linux/of_device.h>
> >   #include <linux/processor.h>
> > +#include <linux/refcount.h>
> >   #include <linux/slab.h>
> >   #include "common.h"
> > @@ -68,6 +69,21 @@ struct scmi_xfers_info {
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
> > +
> >   /**
> >    * struct scmi_info - Structure representing a SCMI instance
> >    *
> > @@ -80,6 +96,10 @@ struct scmi_xfers_info {
> >    * @rx_minfo: Universal Receive Message management info
> >    * @tx_idr: IDR object to map protocol id to Tx channel info pointer
> >    * @rx_idr: IDR object to map protocol id to Rx channel info pointer
> > + * @protocols: An array of protocols' instance descriptors initialized for
> > + *	       this SCMI instance: populated on protocol's first attempted
> > + *	       usage.
> > + * @protocols_mtx: A mutex to protect protocols instances initialization.
> >    * @protocols_imp: List of protocols implemented, currently maximum of
> >    *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
> >    * @node: List head
> > @@ -94,6 +114,9 @@ struct scmi_info {
> >   	struct scmi_xfers_info rx_minfo;
> >   	struct idr tx_idr;
> >   	struct idr rx_idr;
> > +	struct scmi_protocol_instance *protocols[SCMI_MAX_PROTO];
> > +	/* Ensure mutual exclusive access to protocols instance array */
> > +	struct mutex protocols_mtx;
> >   	u8 *protocols_imp;
> >   	struct list_head node;
> >   	int users;
> > @@ -519,6 +542,132 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
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
> > +	/* Ensure protocols has been updated */
> > +	smp_rmb();
> > +	pi = info->protocols[protocol_id];
> > +
> > +	if (!pi) {
> > +		const struct scmi_protocol *proto;
> > +
> > +		/* Fail if protocol not registered on bus */
> > +		proto = scmi_get_protocol(protocol_id);
> > +		if (!proto) {
> > +			ret = -EINVAL;
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
> Isnt this already done in scmi_protocol_init? Or rather the init should
> remain here and there is no need for it to be called from
> scmi_protocol_init?
> 

So, basically I introduced a new initialization flow triggered by
scmi_acquire_protocol (and later in the series by get_ops), so that
protocols won't be anymore initialized by scmi_protocol_init() during
dev prove but later on when used effectively (acquire/get_ops) so that
I can track their usage, but in this patch I ported only base protocol
to this new flow while keeping other protos the old way...so again maybe
I could split this series better in V2, maybe merging all these protos
changes in one go

Regards

Cristian

> 
> 
> -- 
> Warm Regards
> Thara
