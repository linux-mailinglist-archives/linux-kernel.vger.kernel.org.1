Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33912AF79B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgKKRwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:52:54 -0500
Received: from foss.arm.com ([217.140.110.172]:59128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKRww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:52:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F37CE139F;
        Wed, 11 Nov 2020 09:52:51 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B852D3F718;
        Wed, 11 Nov 2020 09:52:50 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:52:43 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
Message-ID: <20201111175243.immpc2wa6hap3nhl@bogus>
References: <20201110183827.19731-1-james.quinlan@broadcom.com>
 <20201110183827.19731-2-james.quinlan@broadcom.com>
 <20201111104157.wpll6en4qvlhb2ws@bogus>
 <CA+-6iNwqKKPzEWLJuRvS_Vubq1GAUE5zNzQobvR8Di4iF1ALwA@mail.gmail.com>
 <20201111174546.GI42652@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111174546.GI42652@e120937-lin>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:45:46PM +0000, Cristian Marussi wrote:
> On Wed, Nov 11, 2020 at 11:45:24AM -0500, Jim Quinlan wrote:
> > On Wed, Nov 11, 2020 at 5:42 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Tue, Nov 10, 2020 at 01:38:19PM -0500, Jim Quinlan wrote:
> > > > The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> > > > message to be indicated by an interrupt rather than the return of the smc
> > > > call.  This accommodates the existing behavior of the BrcmSTB SCMI
> > > > "platform" whose SW is already out in the field and cannot be changed.
> > > >
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > ---
> > > >  drivers/firmware/arm_scmi/smc.c | 31 +++++++++++++++++++++++++++++++
> > > >  1 file changed, 31 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> > > > index 82a82a5dc86a..3bf935dbd00e 100644
> > > > --- a/drivers/firmware/arm_scmi/smc.c
> > > > +++ b/drivers/firmware/arm_scmi/smc.c
> > > > @@ -9,9 +9,11 @@
> > > >  #include <linux/arm-smccc.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/err.h>
> > > > +#include <linux/interrupt.h>
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_address.h>
> > > > +#include <linux/of_irq.h>
> > > >  #include <linux/slab.h>
> > > >
> > > >  #include "common.h"
> > > > @@ -23,6 +25,8 @@
> > > >   * @shmem: Transmit/Receive shared memory area
> > > >   * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
> > > >   * @func_id: smc/hvc call function id
> > > > + * @irq: Optional; employed when platforms indicates msg completion by intr.
> > > > + * @tx_complete: Optional, employed only when irq is valid.
> > > >   */
> > > >
> > > >  struct scmi_smc {
> > > > @@ -30,8 +34,19 @@ struct scmi_smc {
> > > >       struct scmi_shared_mem __iomem *shmem;
> > > >       struct mutex shmem_lock;
> > > >       u32 func_id;
> > > > +     int irq;
> > > > +     struct completion tx_complete;
> > > >  };
> > > >
> > > > +static irqreturn_t smc_msg_done_isr(int irq, void *data)
> > > > +{
> > > > +     struct scmi_smc *scmi_info = data;
> > > > +
> > > > +     complete(&scmi_info->tx_complete);
> > > > +
> > > > +     return IRQ_HANDLED;
> > > > +}
> > > > +
> > > >  static bool smc_chan_available(struct device *dev, int idx)
> > > >  {
> > > >       struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
> > > > @@ -79,6 +94,20 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> > > >       if (ret < 0)
> > > >               return ret;
> > > >
> > > > +     /* Optional feature -- signal message completion using an interrupt */
> > > > +     ret = of_irq_get_byname(cdev->of_node, "msg-serviced");
> > >
> > > So, looks like it is mandatory if "interrupts" is used. Please update the
> > > binding or if that is not the practice followed elsewhere, drop search by
> > > name.
> >
> > Well, I can certainly change the comment. I do not want it to be
> > "mandatory" if just interrupts are used.
> >  The reason I prefer using "interrupt-names" is that this allows
> > unforeseen use of future additional interrupts w/o caring about order
> > in the interrupts DT node. If you are absolutely positive that there
> > will never be other interrupts used  in the future for the SCMI node
> > then I will drop it.
> >

Good point, please make it required property then if "interrupts" property
is present.

>
> What about the future possibility of adding p2a notifications handling
> to SMC transport, won't that need some other IRQ (and shmem) ?
>

Indeed it needs. Since this Tx completion interrupt is optional and may not
be present, better to fix the name so that when Rx/notification interrupt
is added in future, we can identify them easily.

--
Regards,
Sudeep
