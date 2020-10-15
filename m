Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A486628EEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbgJOImv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:42:51 -0400
Received: from foss.arm.com ([217.140.110.172]:47330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387734AbgJOImv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:42:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1262031B;
        Thu, 15 Oct 2020 01:42:50 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 852BC3F719;
        Thu, 15 Oct 2020 01:42:48 -0700 (PDT)
Date:   Thu, 15 Oct 2020 09:42:38 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 01/11] firmware: arm_scmi: review protocol registration
 interface
Message-ID: <20201015084224.GA34395@e120937-lin>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-2-cristian.marussi@arm.com>
 <1b461304-2c25-3206-5799-b561ac6e0bd2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b461304-2c25-3206-5799-b561ac6e0bd2@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

thanks for the review first of all !

On Wed, Oct 14, 2020 at 12:03:45PM -0700, Florian Fainelli wrote:
> On 10/14/20 8:05 AM, Cristian Marussi wrote:
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
> 
> [snip]
> 
> > +static struct scmi_protocol scmi_base = {
> > +	.id = SCMI_PROTOCOL_BASE,
> > +	.init = &scmi_base_protocol_init,
> > +	.ops = NULL,
> > +};
> 
> This could be const I believe.
> 

Right, I thought that and finally I left it as it is because in the last
patch of the series I introduce modularization and this struct gets an
owner field which get set by scmi_protocol_register() transparently
through a dance of macros wrapper carrying THIS_MODULE reference, the
alternative would be to just make this const as you said and have the
user explicitly set .owner = THIS_MODULE once the const struct is
defined...it feels now this const approach would fit better even if
requires the user defining a new protocol to explicitly set the .owner
field.

> > +
> > +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(base, scmi_base)
> > diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> > index 1377ec76a45d..afa2e4818a2b 100644
> > --- a/drivers/firmware/arm_scmi/bus.c
> > +++ b/drivers/firmware/arm_scmi/bus.c
> > @@ -16,7 +16,7 @@
> >  #include "common.h"
> >  
> >  static DEFINE_IDA(scmi_bus_id);
> > -static DEFINE_IDR(scmi_protocols);
> > +static DEFINE_IDR(scmi_available_protocols);
> >  static DEFINE_SPINLOCK(protocol_lock);
> >  
> >  static const struct scmi_device_id *
> > @@ -51,13 +51,29 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
> >  	return 0;
> >  }
> >  
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
> >  static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
> >  {
> > -	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);
> > +	const struct scmi_protocol *proto;
> >  
> > -	if (unlikely(!fn))
> > +	proto = idr_find(&scmi_available_protocols, protocol_id);
> > +	if (!proto)
> >  		return -EINVAL;
> > -	return fn(handle);
> > +	return proto->init(handle);
> >  }
> >  
> >  static int scmi_protocol_dummy_init(struct scmi_handle *handle)
> > @@ -84,7 +100,7 @@ static int scmi_dev_probe(struct device *dev)
> >  		return ret;
> >  
> >  	/* Skip protocol initialisation for additional devices */
> > -	idr_replace(&scmi_protocols, &scmi_protocol_dummy_init,
> > +	idr_replace(&scmi_available_protocols, &scmi_protocol_dummy_init,
> >  		    scmi_dev->protocol_id);
> >  
> >  	return scmi_drv->probe(scmi_dev);
> > @@ -194,26 +210,45 @@ void scmi_set_handle(struct scmi_device *scmi_dev)
> >  	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
> >  }
> >  
> > -int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn)
> > +int scmi_protocol_register(struct scmi_protocol *proto)
> 
> And this could probably take a const struct scmi_protocol here too as
> you do not appear to be modifying proto, idr_alloc() may complain.
> 
> [snip]
> 
Ditto.
> >  
> > -DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_CLOCK, clock)
> > +static struct scmi_protocol scmi_clock = {
> 
> static const here too and throughout your submission.
> 
> [snip]
> 

Ditto.

> > +	struct scmi_protocol_instance *protocols[SCMI_MAX_PROTO];
> 
> Humm that would be 2048 bytes on a 64-bit platform and 1024 bytes on a
> 32-bit platform, this is not so bad, but it is a bit wasteful given that
> 6-7 standard protocols are typically found, and most often no
> proprietary protocols are registered. Not necessarily to be addressed
> right now.
> 
In fact Sudeep pointed out this, as of now I left this as it is for
simplicity but I'll rework this to use some cheaper container data struct.

> > +	/* Ensure mutual exclusive access to protocols instance array */
> > +	struct mutex protocols_mtx;
> >  	u8 *protocols_imp;
> >  	struct list_head node;
> >  	int users;
> > @@ -519,6 +542,132 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
> >  	return ret;
> >  }
> >  
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
> 
> You could return -ENODEV here and propagate that error code for
> scmi_probe() to use as -is.
> 

Yes right, here I return -EPROBEDEFER once I introduce modularization
later on in the series, but is defintely better to return this err codes
straight away from scmi_get_protocol() as you said.

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
> > +		if (ret)
> > +			goto clean;
> > +
> > +		info->protocols[protocol_id] = pi;
> > +		/* Ensure initialized protocol is visible */
> > +		smp_wmb();
> > +
> > +		devres_close_group(handle->dev, pi->gid);
> > +		dev_dbg(handle->dev, "Initialized protocol: 0x%X\n",
> > +			protocol_id);
> > +	} else {
> > +		refcount_inc(&pi->users);
> > +	}
> 
> You may be able to re-arrange the indentation and do:
> 
> 	if (pi) {
> 		refcount_inc(&pi->users);
> 		mutex_unlock(&info->protocols_mtx);
> 		return pi;
> 	}
> 
> to reduce the indentation level, and this would also have the fast path
> tested first.
> 

Of course, I'll do.

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
> > +	return IS_ERR(scmi_get_protocol_instance(handle, protocol_id));
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
> > +	/* Ensure protocols has been updated */
> > +	smp_rmb();
> > +	pi = info->protocols[protocol_id];
> > +	if (WARN_ON(!pi)) {
> > +		mutex_unlock(&info->protocols_mtx);
> > +		return;
> 
> Maybe define an "out" label just to avoid the repetition?
> 

I'll do.

> > +	}
> > +
> > +	if (refcount_dec_and_test(&pi->users)) {
> > +		void *gid = pi->gid;
> > +
> > +		if (pi->proto->deinit)
> > +			pi->proto->deinit(handle);
> > +
> > +		info->protocols[protocol_id] = NULL;
> > +		/* Ensure deinitialized protocol is visible */
> > +		smp_wmb();
> > +
> > +		devres_release_group(handle->dev, gid);
> > +		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
> > +			protocol_id);
> > +	}
> > +	mutex_unlock(&info->protocols_mtx);
> > +}
> > +
> >  void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
> >  				     u8 *prot_imp)
> >  {
> > @@ -785,6 +934,7 @@ static int scmi_probe(struct platform_device *pdev)
> >  	info->dev = dev;
> >  	info->desc = desc;
> >  	INIT_LIST_HEAD(&info->node);
> > +	mutex_init(&info->protocols_mtx);
> >  
> >  	platform_set_drvdata(pdev, info);
> >  	idr_init(&info->tx_idr);
> > @@ -805,10 +955,14 @@ static int scmi_probe(struct platform_device *pdev)
> >  	if (scmi_notification_init(handle))
> >  		dev_err(dev, "SCMI Notifications NOT available.\n");
> >  
> > -	ret = scmi_base_protocol_init(handle);
> > -	if (ret) {
> > -		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> > -		return ret;
> > +	/*
> > +	 * Trigger SCMI Base protocol initialization.
> > +	 * It's mandatory and won't be ever released/deinit until the
> > +	 * SCMI stack is shutdown/unloaded as a whole.
> > +	 */
> > +	if (scmi_acquire_protocol(handle, SCMI_PROTOCOL_BASE)) {
> > +		dev_err(dev, "unable to communicate with SCMI\n");
> > +		return -ENODEV;
> 
> and you could do:
> 
> ret = scmi_acquire_protocol(.., ...);
> if (ret) {
> 	dev_err(dev, "unable to communicate with SCMI\n");
> 	return ret;
> }
> 

Ok.

> Everything else looked good to me, thanks!
> -- 
> Florian

Thanks !

Cristian
