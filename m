Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3648B2A6C72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbgKDSIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:08:17 -0500
Received: from foss.arm.com ([217.140.110.172]:41460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732282AbgKDSIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:08:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA2BE14BF;
        Wed,  4 Nov 2020 10:08:12 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D5153F718;
        Wed,  4 Nov 2020 10:08:11 -0800 (PST)
Date:   Wed, 4 Nov 2020 18:08:09 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 3/8] firmware: arm_scmi: introduce new protocol
 operations support
Message-ID: <20201104180808.GC24640@e120937-lin>
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-4-cristian.marussi@arm.com>
 <2b09a607-6470-ad41-fd19-6a7a248237c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b09a607-6470-ad41-fd19-6a7a248237c5@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 04, 2020 at 11:16:31AM -0500, Thara Gopinath wrote:
> Hi Cristian,
> 
> On 10/28/20 4:29 PM, Cristian Marussi wrote:
> > Expose a new generic get/put protocols API based on protocol handles;
> > provide also a devres managed version also for notifications.
> 
> minor nit.. Maybe yous should reword this! Kind of confusing to understand!
> 
> Also, if it was me, I will separate the notifications and get/put hooks
> into two separate patches. Not an issue though if you want to keep it
> in the same patch.

You're right I have to reword the commit message, and I'll review the
possibility of a further split, even though many parts of this series
are tightly bound together given the kind of changes so sometimes to
avoid breaking bisectability I had to push painfully long patches (like
6/8 :< )...but maybe I've got it wrong and this is not the case here.

> 
> > All SCMI drivers still keep using the old handle based interface.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/driver.c | 126 +++++++++++++++++++++++++++++
> >   drivers/firmware/arm_scmi/notify.c | 123 ++++++++++++++++++++++++++++
> >   include/linux/scmi_protocol.h      |  34 +++++++-
> >   3 files changed, 282 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 8ca04acb6abb..4d86aafbf465 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -15,6 +15,7 @@
> >    */
> >   #include <linux/bitmap.h>
> > +#include <linux/device.h>
> >   #include <linux/export.h>
> >   #include <linux/idr.h>
> >   #include <linux/io.h>
> > @@ -728,6 +729,38 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
> >   	mutex_unlock(&info->protocols_mtx);
> >   }
> > +/**
> > + * scmi_get_protocol_operations  - Get protocol operations
> > + * @handle: A reference to the SCMI platform instance.
> > + * @protocol_id: The protocol being requested.
> > + * @ph: A pointer reference used to pass back the associated protocol handle.
> > + *
> > + * Get hold of a protocol accounting for its usage, eventually triggering its
> > + * initialization, and returning the protocol specific operations and related
> > + * protocol handle which will be used as first argument in most of the protocols
> > + * operations methods.
> > + *
> > + * Return: A reference to the requested protocol operations or error.
> > + *	   Must be checked for errors by caller.
> > + */
> > +static const void __must_check *
> > +scmi_get_protocol_operations(struct scmi_handle *handle, u8 protocol_id,
> > +			     struct scmi_protocol_handle **ph)
> > +{
> > +	struct scmi_protocol_instance *pi;
> > +
> > +	if (!ph)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	pi = scmi_get_protocol_instance(handle, protocol_id);
> > +	if (IS_ERR(pi))
> > +		return pi;
> > +
> > +	*ph = &pi->ph;
> > +
> > +	return pi->proto->ops;
> > +}
> > +
> >   void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
> >   				     u8 *prot_imp)
> >   {
> > @@ -751,6 +784,95 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
> >   	return false;
> >   }
> > +struct scmi_protocol_devres {
> > +	struct scmi_handle *handle;
> > +	u8 protocol_id;
> > +};
> > +
> > +static void scmi_devm_release_protocol(struct device *dev, void *res)
> > +{
> > +	struct scmi_protocol_devres *dres = res;
> > +
> > +	scmi_release_protocol(dres->handle, dres->protocol_id);
> > +}
> > +
> > +/**
> > + * scmi_devm_get_protocol_ops  - Devres managed get protocol operations
> > + * @sdev: A reference to an scmi_device whose embedded struct device is to
> > + *	  be used for devres accounting.
> > + * @protocol_id: The protocol being requested.
> > + * @ph: A pointer reference used to pass back the associated protocol handle.
> > + *
> > + * Get hold of a protocol accounting for its usage, eventually triggering its
> > + * initialization, and returning the protocol specific operations and related
> > + * protocol handle which will be used as first argument in most of the
> > + * protocols operations methods.
> > + * Being a devres based managed method, protocol hold will be automatically
> > + * released, and possibly de-initialized on last user, once the SCMI driver
> > + * owning the scmi_device is unbound from it.
> > + *
> > + * Return: A reference to the requested protocol operations or error.
> > + *	   Must be checked for errors by caller.
> > + */
> > +static const void __must_check *
> > +scmi_devm_get_protocol_ops(struct scmi_device *sdev, u8 protocol_id,
> > +			   struct scmi_protocol_handle **ph)
> > +{
> > +	struct scmi_protocol_instance *pi;
> > +	struct scmi_protocol_devres *dres;
> > +	struct scmi_handle *handle = sdev->handle;
> > +
> > +	if (!ph)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	dres = devres_alloc(scmi_devm_release_protocol,
> > +			    sizeof(*dres), GFP_KERNEL);
> > +	if (!dres)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	pi = scmi_get_protocol_instance(handle, protocol_id);
> > +	if (IS_ERR(pi)) {
> > +		devres_free(dres);
> > +		return pi;
> > +	}
> > +
> > +	dres->handle = handle;
> > +	dres->protocol_id = protocol_id;
> > +	devres_add(&sdev->dev, dres);
> > +
> > +	*ph = &pi->ph;
> > +
> > +	return pi->proto->ops;
> > +}
> > +
> > +static int scmi_devm_protocol_match(struct device *dev, void *res, void *data)
> > +{
> > +	struct scmi_protocol_devres *dres = res;
> > +
> > +	if (WARN_ON(!dres || !data))
> > +		return 0;
> > +
> > +	return dres->protocol_id == *((u8 *)data);
> > +}
> > +
> > +/**
> > + * scmi_devm_put_protocol_ops  - Devres managed put protocol operations
> > + * @sdev: A reference to an scmi_device whose embedded struct device is to
> > + *	  be used for devres accounting.
> > + * @protocol_id: The protocol being requested.
> > + *
> > + * Explicitly release a protocol hold previously obtained calling the above
> > + * @scmi_devm_get_protocol_ops.
> > + */
> > +static void scmi_devm_put_protocol_ops(struct scmi_device *sdev, u8 protocol_id)
> > +{
> > +	int ret;
> > +
> > +	ret = devres_release(&sdev->dev, scmi_devm_release_protocol,
> > +			     scmi_devm_protocol_match, &protocol_id);
> > +	WARN_ON(ret);
> > +}
> > +
> >   /**
> >    * scmi_handle_get() - Get the SCMI handle for a device
> >    *
> > @@ -1004,6 +1126,10 @@ static int scmi_probe(struct platform_device *pdev)
> >   	handle = &info->handle;
> >   	handle->dev = info->dev;
> >   	handle->version = &info->version;
> > +	handle->devm_get_ops = scmi_devm_get_protocol_ops;
> > +	handle->devm_put_ops = scmi_devm_put_protocol_ops;
> > +	handle->get_ops = scmi_get_protocol_operations;
> > +	handle->put_ops = scmi_release_protocol;
> 
> Why do you need a dev_res version and a non dev_res version? I checked
> patch 6 where you convert the drivers to use these hooks and all of them
> are using the dev res apis.
> 

Yes indeed, I wanted to drop the non devm_ version, but I was not sure
if for completeness I should have instead not provided...So I left it
to have it discussed on the list...I was hoping to be told to remove
those non devres :D

Also because in fact any current or future SCMI driver (that are the only
possible users of this interface) will certainly have an scmi_dev to use
with devm_() methods.

Probably the same is true for notify_ops, I could stick with the new
devres managed versions.

> >   	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
> >   	if (ret)
> > diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> > index eae58b2a92cc..64d43e425644 100644
> > --- a/drivers/firmware/arm_scmi/notify.c
> > +++ b/drivers/firmware/arm_scmi/notify.c
> > @@ -1370,6 +1370,127 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
> >   	return 0;
> >   }
> > +struct scmi_notifier_devres {
> > +	const struct scmi_handle *handle;
> > +	u8 proto_id;
> > +	u8 evt_id;
> > +	u32 __src_id;
> > +	u32 *src_id;
> 
> Instead of maintaining two separate pointers for src id,
> why not define a bool, something like is_src_id_valid?
> Should simply this a bit and also don't have to maintain two 32 bit
> pointers. What do you think?
> 

Yes, I did not like so much this trick above, I'll review in V3.

> > +	struct notifier_block *nb;
> > +};
> > +
> > +static void scmi_devm_release_notifier(struct device *dev, void *res)
> > +{
> > +	struct scmi_notifier_devres *dres = res;
> > +
> > +	scmi_unregister_notifier(dres->handle, dres->proto_id, dres->evt_id,
> > +				 dres->src_id, dres->nb);
> > +}
> > +
> > +/**
> > + * scmi_devm_register_notifier()  - Managed registration of a notifier_block
> > + * for an event
> > + * @sdev: A reference to an scmi_device whose embedded struct device is to
> > + *	  be used for devres accounting.
> > + * @proto_id: Protocol ID
> > + * @evt_id: Event ID
> > + * @src_id: Source ID, when NULL register for events coming form ALL possible
> > + *	    sources
> > + * @nb: A standard notifier block to register for the specified event
> > + *
> > + * Generic devres managed helper to register a notifier_block against a
> > + * protocol event.
> > + */
> > +static int scmi_devm_register_notifier(struct scmi_device *sdev,
> > +				       u8 proto_id, u8 evt_id, u32 *src_id,
> > +				       struct notifier_block *nb)
> > +{
> > +	int ret;
> > +	struct scmi_notifier_devres *dres;
> > +
> > +	dres = devres_alloc(scmi_devm_release_notifier,
> > +			    sizeof(*dres), GFP_KERNEL);
> > +	if (!dres)
> > +		return -ENOMEM;
> > +
> > +	ret = scmi_register_notifier(sdev->handle, proto_id,
> > +				     evt_id, src_id, nb);
> > +	if (ret) {
> > +		devres_free(dres);
> > +		return ret;
> > +	}
> > +
> > +	dres->handle = sdev->handle;
> > +	dres->proto_id = proto_id;
> > +	dres->evt_id = evt_id;
> > +	dres->nb = nb;
> > +	if (src_id) {
> > +		dres->__src_id = *src_id;
> > +		dres->src_id = &dres->__src_id;
> > +	} else {
> > +		dres->src_id = NULL;
> > +	}
> > +	devres_add(&sdev->dev, dres);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
> > +{
> > +	struct scmi_notifier_devres *dres = res;
> > +	struct scmi_notifier_devres *xres = data;
> > +
> > +	if (WARN_ON(!dres || !xres))
> > +		return 0;
> > +
> > +	return dres->proto_id == xres->proto_id &&
> > +		dres->evt_id == xres->evt_id &&
> > +		dres->nb == xres->nb &&
> 
> Does the nb have to be compared as well ?
> 

So the notify_ops API allows you to register multiple different callbacks
for exactly the same event tuple (proto_id, evt_id, src_id), and even though
on driver detach you'll automatically just unregister all the notifications
registered for the specific scmi_dev, you should be able to explicitly
devm_unregister() just a very specific callback if you want.

> > +		((!dres->src_id && !xres->src_id) ||
> > +		  (dres->src_id && xres->src_id &&
> > +		   dres->__src_id == xres->__src_id));
> 
> 
> -- 
> Warm Regards
> Thara

Cheers

Cristian
