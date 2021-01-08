Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2562EF282
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbhAHMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:25:30 -0500
Received: from foss.arm.com ([217.140.110.172]:50402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbhAHMZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:25:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 451DE31B;
        Fri,  8 Jan 2021 04:24:43 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7326D3F719;
        Fri,  8 Jan 2021 04:24:41 -0800 (PST)
Date:   Fri, 8 Jan 2021 12:24:39 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v4 03/37] firmware: arm_scmi: introduce devres get/put
 protocols operations
Message-ID: <20210108122439.GC9138@e120937-lin>
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-4-cristian.marussi@arm.com>
 <e817b8a6-6e67-9f1e-8541-5e0b15d7a562@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e817b8a6-6e67-9f1e-8541-5e0b15d7a562@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:28:37AM -0500, Thara Gopinath wrote:
> 
> 
> On 1/6/21 3:15 PM, Cristian Marussi wrote:
> > Expose to the SCMI drivers a new devres managed common protocols API based
> > on generic get/put methods and protocol handles.
> > 
> > All drivers still keep using the old API, no functional change.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/driver.c | 92 ++++++++++++++++++++++++++++++
> >   include/linux/scmi_protocol.h      | 11 ++++
> >   2 files changed, 103 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 10fe9aacae1b..fbc3ba1b69f6 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -15,6 +15,7 @@
> >    */
> >   #include <linux/bitmap.h>
> > +#include <linux/device.h>
> >   #include <linux/export.h>
> >   #include <linux/idr.h>
> >   #include <linux/io.h>
> > @@ -732,6 +733,95 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
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
> > @@ -986,6 +1076,8 @@ static int scmi_probe(struct platform_device *pdev)
> >   	handle = &info->handle;
> >   	handle->dev = info->dev;
> >   	handle->version = &info->version;
> > +	handle->devm_get_ops = scmi_devm_get_protocol_ops;
> > +	handle->devm_put_ops = scmi_devm_put_protocol_ops;
> >   	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
> >   	if (ret)
> > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > index 757a826e3cef..2fd2fffb4024 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -57,6 +57,8 @@ struct scmi_clock_info {
> >   };
> >   struct scmi_handle;
> > +struct scmi_device;
> > +struct scmi_protocol_handle;
> >   /**
> >    * struct scmi_clk_ops - represents the various operations provided
> > @@ -593,6 +595,9 @@ struct scmi_notify_ops {
> >    * @sensor_ops: pointer to set of sensor protocol operations
> >    * @reset_ops: pointer to set of reset protocol operations
> >    * @voltage_ops: pointer to set of voltage protocol operations
> > + * @devm_get_ops: devres managed method to acquire a protocol and get specific
> > + *		  operations and a dedicated protocol handler
> > + * @devm_put_ops: devres managed method to release a protocol
> >    * @notify_ops: pointer to set of notifications related operations
> >    * @perf_priv: pointer to private data structure specific to performance
> >    *	protocol(for internal use only)
> > @@ -618,6 +623,12 @@ struct scmi_handle {
> >   	const struct scmi_sensor_ops *sensor_ops;
> >   	const struct scmi_reset_ops *reset_ops;
> >   	const struct scmi_voltage_ops *voltage_ops;
> > +
> > +	const void __must_check *
> > +		(*devm_get_ops)(struct scmi_device *sdev, u8 proto,
> > +				struct scmi_protocol_handle **ph);
> > +	void (*devm_put_ops)(struct scmi_device *sdev, u8 proto);
> 
> These names are misleading. The devm_get_ops does two things. One populate
> the scmi_protocol_handle, second return the protocol ops. Either split this
> into two separate functions or rename it into something like
> devm_get_protocol (or something better). Similar comment for devm_put_ops as
> there is no releasing of ops happening here per say.

Yes I agree, now that you really get ops and a hold on the protocol in
fact it'd be better _get_protocol/_put_protocol or similar; I'd prefer
not to split retrieving the ops from the protocol_handle since they
need each other to work. I'll fix in V5.

> Also I am still not convinced that protocol_instance should be hidden from
> the client drivers. But if everyone else is aligned towards this approach, I
> am fine.

Do you mean passing the protocol_handle around instead of the handle, so
that protocols impementation are restricted to their own protocol number
and SCMI drivers cannot access anything at the protocol layer ?
It seems reasonable to me but I'm happy to discuss your concerns, also
because up until now you are my main and only feedback about this :D

Thanks

Cristian

> 
> > +
> >   	const struct scmi_notify_ops *notify_ops;
> >   	/* for protocol internal use */
> >   	void *perf_priv;
> > 
> 
> -- 
> Warm Regards
> Thara
