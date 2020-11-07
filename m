Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370982AA518
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgKGMxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:53:39 -0500
Received: from foss.arm.com ([217.140.110.172]:50880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgKGMxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:53:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C6F1474;
        Sat,  7 Nov 2020 04:53:37 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B6B03F66E;
        Sat,  7 Nov 2020 04:53:36 -0800 (PST)
Date:   Sat, 7 Nov 2020 12:53:34 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 2/8] firmware: arm_scmi: introduce protocol handles
Message-ID: <20201107125333.GA42652@e120937-lin>
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-3-cristian.marussi@arm.com>
 <ceda764f-6cd9-9e47-edc7-2e915c920301@linaro.org>
 <20201104174427.GB24640@e120937-lin>
 <745d52d0-8578-6a25-c55e-e628d970e9fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <745d52d0-8578-6a25-c55e-e628d970e9fe@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara

thanks for the feedback.

On Fri, Nov 06, 2020 at 11:26:44AM -0500, Thara Gopinath wrote:
> 
> 
> On 11/4/20 12:44 PM, Cristian Marussi wrote:
> > Hi
> > 
> > On Wed, Nov 04, 2020 at 11:16:18AM -0500, Thara Gopinath wrote:
> > > 
> > > Hi Cristian,
> > > 
> > > On 10/28/20 4:29 PM, Cristian Marussi wrote:
> > > > Add basic protocol handles definitions and helpers support.
> > > > All protocols initialization code and SCMI drivers probing is still
> > > > performed using the handle based interface.
> > > > 
> > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > ---
> > > >    drivers/firmware/arm_scmi/common.h | 61 ++++++++++++++++++++++++++++
> > > >    drivers/firmware/arm_scmi/driver.c | 64 ++++++++++++++++++++++++++++++
> > > >    2 files changed, 125 insertions(+)
> > > > 
> > > > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > > > index b08a8ddbc22a..f0678be02a09 100644
> > > > --- a/drivers/firmware/arm_scmi/common.h
> > > > +++ b/drivers/firmware/arm_scmi/common.h
> > > > @@ -151,6 +151,67 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
> > > >    		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
> > > >    void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
> > > >    			    struct scmi_xfer *xfer);
> > > > +
> > > > +struct scmi_xfer_ops;
> > > > +
> > > > +/**
> > > > + * struct scmi_protocol_handle  - Reference to an initialized protocol instance
> > > > + *
> > > > + * @dev: A reference to the associated SCMI instance device (handle->dev).
> > > > + * @xops: A reference to a struct holding refs to the core xfer operations that
> > > > + *	  can be used by the protocol implementation to generate SCMI messages.
> > > > + * @set_priv: A method to set protocol private data for this instance.
> > > > + * @get_priv: A method to get protocol private data previously set.
> > > > + *
> > > > + * This structure represents a protocol initialized against specific SCMI
> > > > + * instance and it will be used as follows:
> > > > + * - as a parameter fed from the core to the protocol initialization code so
> > > > + *   that it can access the core xfer operations to build and generate SCMI
> > > > + *   messages exclusively for the specific underlying protocol instance.
> > > > + * - as an opaque handle fed by an SCMI driver user when it tries to access
> > > > + *   this protocol through its own protocol operations.
> > > > + *   In this case this handle will be returned as an opaque object together
> > > > + *   with the related protocol operations when the SCMI driver tries to access
> > > > + *   the protocol.
> > > > + */
> > > > +struct scmi_protocol_handle {
> > > > +	struct device *dev;
> > > > +	const struct scmi_xfer_ops *xops;
> > > > +	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
> > > > +	void *(*get_priv)(const struct scmi_protocol_handle *ph);
> > > > +};
> > > 
> > > So scmi_xfer_ops are the ops that actually talks with the scmi firmware on
> > > the other end , right ? IIUC, these ops are the same for all the protocols
> > > of a scmi instance. Imho, this struct is not the right place for these ops
> > > to reside.You are inadvertently exposing scmi internal details to the client
> > > drivers. There is no reason why this should be part of scmi_handle. The
> > > protocols can extract it from the handle during protocol_reigster, right?
> > > 
> > > So, now to the second part, why do you need a scmi_protocol_handle? Again
> > > IIUC, if you have set_priv and get_priv hooks and get_ops and put_ops hooks,
> > > there is nothing that scmi_protocol_handle is providing extra, right? As
> > > mentioned in the comments for last patch any reason all of this cannot be
> > > rolled into scmi_protocol?
> > 
> > The basic idea for protocol_hande existence is that the protocol code
> > should be able to access the core xfer ops (without EXPORTing all
> > scmi_xfer ops) but protoX should NOT be allowed to mistakenly or
> > maliciously build and send protoY messages: since the protocol_handle
> > for protoX is embedded in a specific protocol_instance in this way you
> > can call from your protocol code something like:
> > 
> > ph->xops->xfer_get_init(ph, ...)
> 
> I am still confused by this one... scmi_protocol_instance has a pointer to
> scmi_handle. So why not handle->xops->xfer_get_init(pi, ....). Here also
> protoX will not be allowed to send protoY messages, right? And then again
> set_priv and get_priv can be moved to scmi_protocol_instance right ?
> 

So given that there a number of different 'actors' playing in the SCMI
stack, the basic idea/attempt in general was to expose to each single actor
just the bare minimum needed data structs with the bare minimum needed level
of access (read-only const when no write-access is needed).

We can consider 3 main SCMI actors in these regards:

- SCMI core which takes care to keep track of all the available/loadable
  protocols and to provide access to such protocols via get_ops while
  allocating proper instances and tracking the lifecycle of all the needed
  resources: to do that the core needs all the data in protocol_instance.

- SCMI Protocols that basically just need to be able to build and send
  messages related to their implemented protocols, and also storing any
  needed per-protocol private data somewhere; to do that a protocol
  implementation really needs only:
   
   + xfer_ops possibly restricted to its own protocol ID
   + a dev to use optionally for its own devres
   + a way to store private data specific to the SCMI instance if needed

  In order to realize this the core indeed passes down the protocols'
  init code a const protocol_handle, so that the protocol has available
  all of the above and nothing more, while the core, with the usual
  containmr_of trick, can retrieve the containing protocol_instance
  needed to process properly the xfer_ops.
  What I really don't like are the bulky set_priv/get_priv ops instead
  of a much simpler ph->priv kind-of-access: but this bulky accessors are
  in fact needed because ph is passed as const to protocol init.
  Not sure if I can play some trick here to avoid this without making
  the code even more complex.

  Note also that, the usage of the protocol_handle in the init code
  enforces as a consequence its usage also in the exposed protocol
  operations, because if I had kept the old perf_ops(handle, ) style
  interface that would have meant that the protocol core should have
  been able to somehow ask the core for the proper handle to use like:
   
   ph = scmi_map_protocol(handle, SCMI_PROTOCOL_X)

  which would have defeated all of the above attempt to effectively restrict
  the access of protoX to proto ID=X, since any protocol could have
  grabbed any other protocol_handle of choice with the above map interface.
  (beside being an unneeded repetition)

- at last, there are SCMI drivers that basically just need to able to grab
  access to their desired protocols, if available, and use those specific
  protocol operations related to the SCMI handle instance they refer: here
  the trick to limit the visibility of the data to the bare minimum needs,
  as said, is that the protocol_handle is just an opaque pointer for the
  SCMI driver, it cannot be dereferenced and accessed by the SCMI driver.


Regards

Cristian


> 
> -- 
> Warm Regards
> Thara
