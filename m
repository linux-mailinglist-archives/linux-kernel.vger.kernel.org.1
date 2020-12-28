Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9459B2E65D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392907AbgL1QEz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Dec 2020 11:04:55 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53207 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbgL1QEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:04:53 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A3384C0005;
        Mon, 28 Dec 2020 16:04:07 +0000 (UTC)
Date:   Mon, 28 Dec 2020 17:04:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Conor Culhane <conor.culhane@silvaco.com>
Subject: Re: [PATCH v2 3/4] i3c: master: svc: Add Silvaco I3C master driver
Message-ID: <20201228170405.3ee40b28@xps13>
In-Reply-To: <20200819110432.0df68db9@collabora.com>
References: <20200812141312.3331-1-miquel.raynal@bootlin.com>
 <20200812141312.3331-3-miquel.raynal@bootlin.com>
 <20200819110432.0df68db9@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

It's been quite some time since you made this review, but now that I am
ready to send a new version, I think it is useful to answer your
questions and remarks below which I pretty much all addressed with
significant changes.

Also adding Alexandre so he can smoothly get into this driver :)

> > +static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
> > +				     struct i3c_dev_desc *dev)
> > +{
> > +	struct svc_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> > +	struct i3c_ibi_slot *slot;
> > +	unsigned int count;
> > +	u32 mdatactrl;
> > +	int ret = 0;
> > +	u8 *buf;
> > +
> > +	spin_lock(&master->ibi.lock);
> > +
> > +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> > +	if (!slot) {
> > +		ret = -ENOSPC;
> > +		goto unlock;
> > +	}
> > +
> > +	slot->len = 0;
> > +	buf = slot->data;
> > +	while (readl(master->regs + SVC_I3C_MSTATUS) & SVC_I3C_MINT_RXPEND) {
> > +		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
> > +		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
> > +		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);
> > +		slot->len += count;
> > +		buf += count;
> > +	}  
> 
> I don't think the while loop and i3c_generic_ibi_get_free_slot() call
> have to be protected by the ibi lock (having an unbounded while loop in
> a critical section makes me nervous).

Dropped indeed, I don't think it is needed as well.

> We also discussed the race you have because IBIs and regular transfers
> share the same RX FIFO, which you mentioned in your previous reply
> already.

I addressed this issue by automatically nacking IBIs happening during
transfers (hardware feature).

> > +
> > +	i3c_master_queue_ibi(dev, slot);
> > +
> > +unlock:
> > +	spin_unlock(&master->ibi.lock);
> > +	svc_i3c_master_emit_stop(master);
> > +	svc_i3c_master_flush_fifo(master);  
> 
> Flush FIFOs? Does it flush all remaining bytes present in the RX/TX
> FIFOs? Are you sure that's appropriate?

Indeed this is not appropriate and has been dropped.

> > +
> > +	return ret;
> > +}
> > +
> > +static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
> > +				   bool mandatory_byte)
> > +{
> > +	unsigned int ibi_ack_nack;
> > +
> > +	ibi_ack_nack = SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
> > +	if (mandatory_byte)
> > +		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITH_BYTE;  
> 
> 
> IIRC, some devices send more than one byte, does that mean you don't
> support those?

The dequeuing mechanism is able to read up to 16 bytes (FIFO size), it
should not be a problem.

> > +	else
> > +		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
> > +
> > +	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
> > +}
> > +
> > +static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
> > +{
> > +	writel(SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK |
> > +	       SVC_I3C_MCTRL_IBIRESP_NACK,
> > +	       master->regs + SVC_I3C_MCTRL);
> > +}
> > +
> > +static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
> > +{
> > +	struct svc_i3c_master *master = (struct svc_i3c_master *)dev_id;
> > +	u32 active = readl(master->regs + SVC_I3C_MINTMASKED);
> > +	u32 status = readl(master->regs + SVC_I3C_MSTATUS);
> > +	unsigned int ibitype = SVC_I3C_MSTATUS_IBITYPE(status);
> > +	unsigned int ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);
> > +	struct i3c_dev_desc *dev;
> > +	bool rdata;
> > +
> > +	if (active & SVC_I3C_MINT_SLVSTART) {
> > +		writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
> > +		writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
> > +		       SVC_I3C_MCTRL_IBIRESP_MANUAL,
> > +		       master->regs + SVC_I3C_MCTRL);  
> 
> I would expect some kind of auto-ack/nack mechanism. Not sure what
> happens when you do it manually, but if that blocks the bus waiting for
> the interrupt handler to tell the I3C master what to do with IBI,
> that's far from ideal.

After discussing with people who designed the IP, they told me that
the time between SDA being pulled low to interrupt the master and the
master responding is unbounded. What is critical is the handling of
the interrupt once the master authorized the interrupt. I entirely
reworked the IRQ handling for that in v3.

> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if (!(active & SVC_I3C_MINT_IBIWON))
> > +		return IRQ_NONE;
> > +
> > +	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
> > +
> > +	switch (ibitype) {
> > +	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > +		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
> > +		if (WARN_ON(!dev)) {  
> 
> I wouldn't WARN_ON() that. I wouldn't be surprised if some slaves send
> IBIs without being allowed, and you're in an interrupt context. This
> being said, you should probably trigger a DISEC on this device when
> that happens.

I dropped the warning, however the point of warning here is that I
cannot identify the device, hence I cannot disable the event calls
coming from this device :)

> > +			svc_i3c_master_nack_ibi(master);
> > +			break;
> > +		}
> > +
> > +		rdata = dev->info.bcr & I3C_BCR_IBI_PAYLOAD;
> > +		svc_i3c_master_ack_ibi(master, rdata);
> > +		if (rdata) {
> > +			svc_i3c_master_disable_interrupts(master);
> > +			return IRQ_WAKE_THREAD;
> > +		}
> > +
> > +		break;
> > +	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
> > +		svc_i3c_master_nack_ibi(master);
> > +		break;
> > +	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
> > +		svc_i3c_master_ack_ibi(master, false);
> > +		queue_work(master->base.wq, &master->hj_work);
> > +		break;
> > +	default:
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t svc_i3c_master_threaded_handler(int irq, void *dev_id)
> > +{
> > +	struct svc_i3c_master *master = (struct svc_i3c_master *)dev_id;
> > +	u32 status = readl(master->regs + SVC_I3C_MSTATUS);
> > +	unsigned int ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);
> > +	struct i3c_dev_desc *dev;  
> 
> Do you really need a threaded irq? We already have a workqueue per
> master, maybe you can use it to schedule the IBI dequeuing?

Right, I moved the code to an "IBI work" over the master's workqueue.

> > +
> > +	dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
> > +	if (WARN_ON(!dev)) {
> > +		svc_i3c_master_emit_stop(master);
> > +		svc_i3c_master_flush_fifo(master);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	svc_i3c_master_handle_ibi(master, dev);
> > +	svc_i3c_master_enable_interrupts(master,
> > +					 SVC_I3C_MINT_SLVSTART |
> > +					 SVC_I3C_MINT_IBIWON);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +  

[...]

> > +static int svc_i3c_master_do_daa_locked(struct svc_i3c_master
*master,
> > +					u8 *addrs, unsigned int *count)
> > +{
> > +	u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
> > +	unsigned int dev_nb = 0, last_addr = 0;
> > +	u32 reg;
> > +	int ret, i;
> > +
> > +	while (true) {
> > +		/* Enter/proceed with DAA */
> > +		writel(SVC_I3C_MCTRL_REQUEST_PROC_DAA |
> > +		       SVC_I3C_MCTRL_TYPE_I3C |
> > +		       SVC_I3C_MCTRL_IBIRESP_MANUAL |
> > +		       SVC_I3C_MCTRL_DIR(SVC_I3C_MCTRL_DIR_WRITE),
> > +		       master->regs + SVC_I3C_MCTRL);
> > +
> > +		/*
> > +		 * Either one slave will send its ID, or the assignment process
> > +		 * is done.
> > +		 */
> > +		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> > +					 reg & (SVC_I3C_MINT_RXPEND |
> > +						SVC_I3C_MINT_MCTRLDONE),
> > +					 1, 1000);  
> 
> No interrupt for the DAA? I'm also curious about the RX FIFO size.
> Looks like PIDs/BCRs/DCRs of attached devices go there. What happens if
> it exceeds the size of the FIFO and you're not dequeuing things fast
> enough?

Interrupts are available but for clarity reasons (the current handler
is already very complicated to avoid any races and prevent misreads
or endless loops) I decided to keep using polling here. I guess it does
not hurt anyway.

About the FIFO size, it is 16 bytes, so it is pretty safe for this kind
of operation.

> > +		if (ret)
> > +			return ret;
> > +
> > +		if (reg & SVC_I3C_MINT_RXPEND) {
> > +			u8 datab;
> > +
> > +			/*
> > +			 * We only care about the 48-bit provisional ID yet to
> > +			 * be sure a device does not nack an address twice.
> > +			 * Otherwise, we would just need to flush the RX FIFO.
> > +			 */
> > +			for (i = 0; i < 6; i++) {
> > +				ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS,
> > +							 reg,
> > +							 reg & SVC_I3C_MINT_RXPEND,
> > +							 0, 1000);
> > +				if (ret)
> > +					return ret;
> > +
> > +				datab = readl(master->regs + SVC_I3C_MRDATAB);
> > +				prov_id[dev_nb] |= (u64)(datab) << (8 * (5 - i));  
> 
> This calls for an svc_i3c_read_bytes() helper.

Done.

> 
> > +			}
> > +
> > +			/* We do not care about the BCR and DCR yet */
> > +			for (i = 0; i < 2; i++) {
> > +				ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS,
> > +							 reg,
> > +							 reg & SVC_I3C_MINT_RXPEND,
> > +							 0, 1000);
> > +				if (ret)
> > +					return ret;
> > +
> > +				reg = readl(master->regs + SVC_I3C_MRDATAB);
> > +			}
> > +		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {  
> 
> Can't you have both SVC_I3C_MSTATUS_MCTRLDONE and SVC_I3C_MINT_RXPEND?

If we have MCTRLDONE it means there is nothing left to read, so RXPEND
cannot be also set.

> BTW, can we make the bit definitions consistent. You sometimes have:
> 
> #define FOO(x)	FIELD_GET(BIT(n), (x))
> 
> and sometimes
> 
> #define BAR	BIT(n)
> 
> which leads to inconsistencies in how you test presence of those bits:
> 
> 'if (FOO(reg))' vs 'if (reg & BAR)'.

Done.

> > +			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
> > +			    SVC_I3C_MSTATUS_COMPLETE(reg)) {
> > +				/*
> > +				 * All devices received and acked they dynamic
> > +				 * address, this is the natural end of the DAA
> > +				 * procedure.
> > +				 */
> > +				break;
> > +			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
> > +				/*
> > +				 * A slave device nacked the address, this is
> > +				 * allowed only once, DAA will be stopped and
> > +				 * then resumed. The same device is supposed to
> > +				 * answer again immediately and shall ack the
> > +				 * address this time.
> > +				 */  
> 
> 
> I couldn't find where this is described in v1 of the spec. All I see is:
> 
> "
> The Arbitration-winning Device shall acknowledge the assigned Dynamic
> Address
> "

I was told to do it this way, and got the following snippet from the
I3C v1 spec:

"
If a given Slave does not acknowledge its assigned Dynamic Address,
then the procedure requires the Main Master to continue from step 4
[sending the broadcast address and iterating again]. The Slave will
then participate in the Address Arbitration using the same 48-bit
Provisional ID, and as a result the Slave will win the Arbitration
round. If the Slave does not ACK the Dynamic Address a second time,
then the Main Master shall exit the Dynamic Address Assignment
procedure and execute an error management procedure provided by the I3C
Bus designer.
"

> 
> > +				if (prov_id[dev_nb] ==
> > nacking_prov_id)
> > +					return -EIO;
> > +
> > +				dev_nb--;
> > +				nacking_prov_id = prov_id[dev_nb];
> > +				svc_i3c_master_emit_stop(master);
> > +
> > +				continue;
> > +			} else {
> > +				return -EIO;
> > +			}
> > +		}
> > +
> > +		/* Wait for the slave to be ready to receive its
> > address */
> > +		ret = readl_poll_timeout(master->regs +
> > SVC_I3C_MSTATUS, reg,
> > +
> > SVC_I3C_MSTATUS_MCTRLDONE(reg) &&
> > +
> > SVC_I3C_MSTATUS_STATE_DAA(reg) &&
> > +
> > SVC_I3C_MSTATUS_BETWEEN(reg),
> > +					 0, 1000);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Give the slave device a suitable dynamic
> > address */
> > +		ret = i3c_master_get_free_addr(&master->base,
> > last_addr + 1);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		addrs[dev_nb] = ret;
> > +
> > +		writel(addrs[dev_nb], master->regs +
> > SVC_I3C_MWDATAB);
> > +		last_addr = addrs[dev_nb++];
> > +	}
> > +
> > +	*count = dev_nb;
> > +
> > +	return 0;
> > +}  

Thanks for the review :)

Miquèl
