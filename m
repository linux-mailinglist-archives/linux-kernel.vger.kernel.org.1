Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD02EF1C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAHMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:05:20 -0500
Received: from foss.arm.com ([217.140.110.172]:49854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbhAHMFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:05:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B258431B;
        Fri,  8 Jan 2021 04:04:33 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95ED3F719;
        Fri,  8 Jan 2021 04:04:31 -0800 (PST)
Date:   Fri, 8 Jan 2021 12:04:28 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v4 02/37] firmware: arm_scmi: introduce protocol handle
 definitions
Message-ID: <20210108120428.GB9138@e120937-lin>
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-3-cristian.marussi@arm.com>
 <19054e89-c117-ef85-444e-8e126a8a9efb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19054e89-c117-ef85-444e-8e126a8a9efb@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara

thanks for reviewing.

On Thu, Jan 07, 2021 at 09:29:17AM -0500, Thara Gopinath wrote:
> 
> 
> On 1/6/21 3:15 PM, Cristian Marussi wrote:
> > Add basic protocol handles definitions and private data helpers support.
> > 
> > A protocol handle identifies a protocol instance initialized against a
> > specific handle; it embeds all the references to the core SCMI xfer methods
> > that will be needed by a protocol implementation to build and send its own
> > protocol specific messages using common core methods.
> > 
> > As such, in the interface, a protocol handle will be passed down from the
> > core to the protocol specific initialization callback at init time.
> > 
> > Anyway at this point only definitions are introduced, all protocols
> > initialization code and SCMI drivers probing is still based on the old
> > interface, so no functional change.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/common.h | 59 ++++++++++++++++++++++++++++++
> >   drivers/firmware/arm_scmi/driver.c | 45 +++++++++++++++++++++++
> >   2 files changed, 104 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index e052507dc918..977e31224efe 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -149,6 +149,65 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
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
> 
> Maybe move the definition above struct scmi_protocol_handle to avoid a
> declaration ?
> 

But all the ops defined inside scmi_xfer_ops refers then to a param
struct scmi_protocol_handle, so I'd need anyway a similar declaration
the other way around.

If not:

linux/drivers/firmware/arm_scmi/common.h:178:32: warning: ‘struct scmi_protocol_handle’ declared inside parameter list will not be visible outside of this definition or declaration

Thanks

Cristian
> 
> -- 
> Warm Regards
> Thara
