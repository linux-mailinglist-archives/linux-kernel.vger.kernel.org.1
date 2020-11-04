Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC22A6BF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgKDRoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:44:32 -0500
Received: from foss.arm.com ([217.140.110.172]:40988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbgKDRoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:44:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DEDC139F;
        Wed,  4 Nov 2020 09:44:31 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AB123F718;
        Wed,  4 Nov 2020 09:44:29 -0800 (PST)
Date:   Wed, 4 Nov 2020 17:44:27 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 2/8] firmware: arm_scmi: introduce protocol handles
Message-ID: <20201104174427.GB24640@e120937-lin>
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-3-cristian.marussi@arm.com>
 <ceda764f-6cd9-9e47-edc7-2e915c920301@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceda764f-6cd9-9e47-edc7-2e915c920301@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Nov 04, 2020 at 11:16:18AM -0500, Thara Gopinath wrote:
> 
> Hi Cristian,
> 
> On 10/28/20 4:29 PM, Cristian Marussi wrote:
> > Add basic protocol handles definitions and helpers support.
> > All protocols initialization code and SCMI drivers probing is still
> > performed using the handle based interface.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/common.h | 61 ++++++++++++++++++++++++++++
> >   drivers/firmware/arm_scmi/driver.c | 64 ++++++++++++++++++++++++++++++
> >   2 files changed, 125 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index b08a8ddbc22a..f0678be02a09 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -151,6 +151,67 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
> >   		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
> >   void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
> >   			    struct scmi_xfer *xfer);
> > +
> > +struct scmi_xfer_ops;
> > +
> > +/**
> > + * struct scmi_protocol_handle  - Reference to an initialized protocol instance
> > + *
> > + * @dev: A reference to the associated SCMI instance device (handle->dev).
> > + * @xops: A reference to a struct holding refs to the core xfer operations that
> > + *	  can be used by the protocol implementation to generate SCMI messages.
> > + * @set_priv: A method to set protocol private data for this instance.
> > + * @get_priv: A method to get protocol private data previously set.
> > + *
> > + * This structure represents a protocol initialized against specific SCMI
> > + * instance and it will be used as follows:
> > + * - as a parameter fed from the core to the protocol initialization code so
> > + *   that it can access the core xfer operations to build and generate SCMI
> > + *   messages exclusively for the specific underlying protocol instance.
> > + * - as an opaque handle fed by an SCMI driver user when it tries to access
> > + *   this protocol through its own protocol operations.
> > + *   In this case this handle will be returned as an opaque object together
> > + *   with the related protocol operations when the SCMI driver tries to access
> > + *   the protocol.
> > + */
> > +struct scmi_protocol_handle {
> > +	struct device *dev;
> > +	const struct scmi_xfer_ops *xops;
> > +	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
> > +	void *(*get_priv)(const struct scmi_protocol_handle *ph);
> > +};
> 
> So scmi_xfer_ops are the ops that actually talks with the scmi firmware on
> the other end , right ? IIUC, these ops are the same for all the protocols
> of a scmi instance. Imho, this struct is not the right place for these ops
> to reside.You are inadvertently exposing scmi internal details to the client
> drivers. There is no reason why this should be part of scmi_handle. The
> protocols can extract it from the handle during protocol_reigster, right?
> 
> So, now to the second part, why do you need a scmi_protocol_handle? Again
> IIUC, if you have set_priv and get_priv hooks and get_ops and put_ops hooks,
> there is nothing that scmi_protocol_handle is providing extra, right? As
> mentioned in the comments for last patch any reason all of this cannot be
> rolled into scmi_protocol?

The basic idea for protocol_hande existence is that the protocol code
should be able to access the core xfer ops (without EXPORTing all
scmi_xfer ops) but protoX should NOT be allowed to mistakenly or
maliciously build and send protoY messages: since the protocol_handle
for protoX is embedded in a specific protocol_instance in this way you
can call from your protocol code something like:

ph->xops->xfer_get_init(ph, ...)

and the core will transparently (and forcibly) call for you an xfer_get_init()
for protcolX.

Same goes for the get_priv/set_priv you can set and get only your protoX
private data.

This also avoids error prone repetitions of the protocol ID params all
over the protocol code (as pointed out previously by Florian).

At this point the problem is that I have to pass such protocol_handle
also as param into all the protocols_ops in order to avoid to reintroduce
some form of repetition inside the protocol code to derive the ph from the
handle with some helper like

	ph = scmi_map_protocol_handle(handle, SCMI_PERF_PROTOCOL)

which also indeed would have re-introduce the capability for protocolX
to maliciosuly or mistakenly build/send protoY messages.

At the same time, you're right, the xops should NOT be exposed instead
to the SCMI drivers, which must not be able to build tehir own rogue
messaes, and here the trick is indeed that scmi_protocol_handle is an
opaque object for SCMI drivers: it is NOT defined in scmi_protocol.h BUT
only declared so the SCMI drivers are not able to dereference it and
access the xops, nor anything else in fact.

In fact I could also have declared it as a void * all across the
protocols ops in scmi_protocol.h, but I thought some sort of type
checking was better (maybe I'm wrong)

So basically now, when an SCMI driver wants to use protoX, it issues a
	get_ops(handle, X)
	
and it gets back:

- a void * to be cast back to protoX_ops
- and an scmi_protocol_handle *ph which represents protoX for that specific
  SCMI instance (handle) which it has use all over the protoX_ops
  invocations:
  	
	protoX_ops->oper1->(ph, ...)

  with such ph being completely opaque for the SCMI driver calling oper1(ph,...),
  but acting as a well defined protocol_handle inside protocolX code.

> 
> As long as you are not supporting multiple scmi_protocol_instance and
> scmi_protocol_handle for a protocol, I don't think having separate structs
> make sense. And you need to do this only if you think there can be multiple
> versions/instances of a protocol in the same scmi instance.
> Or am I missing something here ?
> 

What really protocol_handle brings in is the fact that is embedded in a
specific protocol_instance which in turn is associated to a specific
SCMI server instance: so the SCMI drivers can refer to a very specific
SCMI instance when using that protocol, and at the same time the protocol
code instead can use the xops ONLY to build/send messages for the
protocol number for which they are supposed to send them.

So the separation of the structures is indeed wanted so that the
protocol code receive only the bare minimum access to the data it needs,
while the core processing the protocol xops requests can derive the
containing specific protocol_instance to act upon, so that
 - protocolX can send ONLY protoX messages
 - messageX are sennt to the proper protocol instance associated to that
   handle, which identifies one specific SCMI server amomgst possible
   multiple choices: an SCMI driver instance indeed operates on a very
   specific handle and use that to get hold a specific protocol_handle
   and proto_ops when calling something like:
   
      perf_ops = get_ops(handle, SCMI_PROTOCOL_PERF, &ph)
      perf_ops->ferq_get(ph, ...);

Regards

Cristian

> > +
> > +/**
> > + * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
> > + * @version_get: Get this version protocol.
> > + * @xfer_get_init: Initialize one struct xfer if any xfer slot is free.
> > + * @reset_rx_to_maxsz: Reset rx size to max transport size.
> > + * @do_xfer: Do the SCMI transfer.
> > + * @do_xfer_with_response: Do the SCMI transfer waiting for a response.
> > + * @xfer_put: Free the xfer slot.
> > + *
> > + * Note that all this operations expect a protocol handle as first parameter;
> > + * they then internally use it to infer the underlying protocol number: this
> > + * way is not possible for a protocol implementation to forge messages for
> > + * another protocol.
> > + */
> > +struct scmi_xfer_ops {
> > +	int (*version_get)(const struct scmi_protocol_handle *ph, u32 *version);
> > +	int (*xfer_get_init)(const struct scmi_protocol_handle *ph, u8 msg_id,
> > +			     size_t tx_size, size_t rx_size,
> > +			     struct scmi_xfer **p);
> > +	void (*reset_rx_to_maxsz)(const struct scmi_protocol_handle *ph,
> > +				  struct scmi_xfer *xfer);
> > +	int (*do_xfer)(const struct scmi_protocol_handle *ph,
> > +		       struct scmi_xfer *xfer);
> > +	int (*do_xfer_with_response)(const struct scmi_protocol_handle *ph,
> > +				     struct scmi_xfer *xfer);
> > +	void (*xfer_put)(const struct scmi_protocol_handle *ph,
> > +			 struct scmi_xfer *xfer);
> > +};
> > +
> > +struct scmi_revision_info *
> > +scmi_get_revision_area(const struct scmi_protocol_handle *ph);
> >   int scmi_handle_put(const struct scmi_handle *handle);
> >   struct scmi_handle *scmi_handle_get(struct device *dev);
> >   void scmi_set_handle(struct scmi_device *scmi_dev);
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index beae8991422d..8ca04acb6abb 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -72,19 +72,28 @@ struct scmi_xfers_info {
> >   /**
> >    * struct scmi_protocol_instance  - Describe an initialized protocol instance.
> > + * @handle: Reference to the SCMI handle associated to this protocol instance.
> >    * @proto: A reference to the protocol descriptor.
> >    * @gid: A reference for per-protocol devres management.
> >    * @users: A refcount to track effective users of this protocol.
> > + * @priv: Reference for optional protocol private data.
> > + * @ph: An embedded protocol handle that will be passed down to protocol
> > + *	initialization code to identify this instance.
> >    *
> >    * Each protocol is initialized independently once for each SCMI platform in
> >    * which is defined by DT and implemented by the SCMI server fw.
> >    */
> >   struct scmi_protocol_instance {
> > +	const struct scmi_handle	*handle;
> >   	const struct scmi_protocol	*proto;
> >   	void				*gid;
> >   	refcount_t			users;
> > +	void				*priv;
> > +	struct scmi_protocol_handle	ph;
> >   };
> > +#define ph_to_pi(h)	container_of(h, struct scmi_protocol_instance, ph)
> > +
> >   /**
> >    * struct scmi_info - Structure representing a SCMI instance
> >    *
> > @@ -543,6 +552,57 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
> >   	return ret;
> >   }
> > +/**
> > + * scmi_set_protocol_priv  - Set protocol specific data at init time
> > + *
> > + * @ph: A reference to the protocol handle.
> > + * @priv: The private data to set.
> > + *
> > + * Return: 0 on Success
> > + */
> > +static int scmi_set_protocol_priv(const struct scmi_protocol_handle *ph,
> > +				  void *priv)
> > +{
> > +	struct scmi_protocol_instance *pi = ph_to_pi(ph);
> > +
> > +	pi->priv = priv;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * scmi_get_protocol_priv  - Set protocol specific data at init time
> > + *
> > + * @ph: A reference to the protocol handle.
> > + *
> > + * Return: Protocol private data if any was set.
> > + */
> > +static void *scmi_get_protocol_priv(const struct scmi_protocol_handle *ph)
> > +{
> > +	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
> > +
> > +	return pi->priv;
> > +}
> > +
> > +/**
> > + * scmi_get_revision_area  - Retrieve version memory area.
> > + *
> > + * @ph: A reference to the protocol handle.
> > + *
> > + * A helper to grab the version memory area reference during SCMI Base protocol
> > + * initialization.
> > + *
> > + * Return: A reference to the version memory area associated to the SCMI
> > + *	   instance underlying this protocol handle.
> > + */
> > +struct scmi_revision_info *
> > +scmi_get_revision_area(const struct scmi_protocol_handle *ph)
> > +{
> > +	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
> > +
> > +	return pi->handle->version;
> > +}
> > +
> >   /**
> >    * scmi_get_protocol_instance  - Protocol initialization helper.
> >    * @handle: A reference to the SCMI platform instance.
> > @@ -588,6 +648,10 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
> >   		pi->gid = gid;
> >   		pi->proto = proto;
> > +		pi->handle = handle;
> > +		pi->ph.dev = handle->dev;
> > +		pi->ph.set_priv = scmi_set_protocol_priv;
> > +		pi->ph.get_priv = scmi_get_protocol_priv;
> >   		refcount_set(&pi->users, 1);
> >   		/* proto->init is assured NON NULL by scmi_protocol_register */
> >   		ret = pi->proto->init(handle);
> > 
> 
> -- 
> Warm Regards
> Thara
