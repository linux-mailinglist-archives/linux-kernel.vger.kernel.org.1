Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2C61C07AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD3URc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 16:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgD3URc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:17:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E6C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:17:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id y6so1324195pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/R2wHXJxtMrl+SzTeOjf6brGQ893PDXmdmleCb9Xj14=;
        b=Uqir6SuPD2pnB5+bb9YsztSSk1QqSFslHxl2x3qcONJhUrYwRvemFw7Kf75bj23isk
         6B3tuUlB00cRxBGu77vjO+C9T740DXMso9bXeaTKv+rJ40VvKMDO1o5CrCBTMw5lmYk3
         n/Ls5sKIPY+V4Y1CBW7FX1t3s1DlcR+Lu+jn84fRVMhJBnKlMSTKGpHkxwZMrObMznzp
         lb8YV3PqtQuz78x9LtsJZdQxmCVagQovbrmhBZy8K9LU+oHlZX6VciHyxzUHvFIQbzcv
         Xm0kWHmHhg6170wKwnKH8h5UZEe4Zw5y5Dh5621pJ0qvXYMkQ73km0JY6heldyA90a71
         zbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/R2wHXJxtMrl+SzTeOjf6brGQ893PDXmdmleCb9Xj14=;
        b=E9MQ0MheHCK4fi0FydqSLocdT1cucwZ7GTMoIwjg8K+a6Cig26xX8HVVB+vuvBAXBo
         q8P3BgN2ufgUt+wQEWnwqm8qBFbC+HTd8j3pII/YkEuWTe6RDkwocUWJ1Ygf7Lz3X1kl
         akIa/sBa7IOzjAUkS6oTQ6TqIhxbD1aZlq9eixjbyp+YSEok+Io0OgdDR7t5g1CZXjt1
         G9GTVlewGQtaE7f0L8LoOvOC80GW3WK91E3m8Oeww1/KOPasDcjJBw9IQ2EsOY01AfmJ
         MMiT5hMyKcc01jmUZJpxkIdHNUmkdJlyo+GQqVKYmbxtACpZhNgVnSOZsmVVyefN4J9w
         nUUQ==
X-Gm-Message-State: AGi0PuZfYMOY+iBr+YGgrqRLvBxl6+2Jhy19lIOSrlsvKPZrZ0uRMjhe
        lK4DwhExl3A4E13XOGSXCJVzzg==
X-Google-Smtp-Source: APiQypKf6o+i2X7BKW/8kcWviD44p0tTIxvkzNCqDlAZyaT6lPyFs3DNpa+KQnJZZWEOchL+xOXfEQ==
X-Received: by 2002:a17:90a:64cc:: with SMTP id i12mr607205pjm.65.1588277850422;
        Thu, 30 Apr 2020 13:17:30 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u3sm527415pfb.105.2020.04.30.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:17:29 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:18:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Raghavendra Rao Ananta <rananta@codeaurora.org>
Subject: Re: [PATCH 2/2] soc: qcom: ipcc: Add support for IPCC controller
Message-ID: <20200430201807.GB20625@builder.lan>
References: <20200430063054.18879-1-manivannan.sadhasivam@linaro.org>
 <20200430063054.18879-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430063054.18879-2-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Apr 23:30 PDT 2020, Manivannan Sadhasivam wrote:

> From: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> 
> Add support for the Inter-Processor Communication Controller (IPCC)
> driver that coordinates the interrupts (inbound & outbound) for
> Multiprocessor (MPROC), COMPUTE-Level0 (COMPUTE-L0) & COMPUTE-Level1
> (COMPUTE-L1) protocols for the Application Processor Subsystem (APSS).
> 
> As a part of its inbound communication, the driver would be responsible
> for forwarding the interrupts from various clients, such as Modem, DSPs,
> PCIe, and so on, to the entities running on the APPS. As a result, it's
> implemented as an irq_chip driver.
> 
> On the other hand, the driver also registers as a mailbox controller
> that provides a mailbox interface to interrupt other clients connected
> to the IPCC, acting as an outbound communication channel.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> [mani: cleaned up for upstream]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig     |  11 +
>  drivers/soc/qcom/Makefile    |   1 +
>  drivers/soc/qcom/qcom_ipcc.c | 410 +++++++++++++++++++++++++++++++++++

I think the driver should be moved to either drivers/irqchip or
drivers/mailbox.

>  3 files changed, 422 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom_ipcc.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index bf42a17a45de..97c380c3fa09 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -53,6 +53,17 @@ config QCOM_GSBI
>  	  functions for connecting the underlying serial UART, SPI, and I2C
>  	  devices to the output pins.
>  
> +config QCOM_IPCC
> +	tristate "Qualcomm Technologies, Inc. IPCC driver"
> +	depends on MAILBOX
> +	help
> +	  Qualcomm Technologies, Inc. IPCC driver for MSM devices. The drivers
> +	  acts as an interrupt controller for the clients interested in
> +	  talking to the IPCC (inbound-communication). On the other hand, the
> +	  driver also provides a mailbox channel for outbound-communications.
> +	  Say Y here to compile the driver as a part of kernel or M to compile
> +	  as a module.
> +
>  config QCOM_LLCC
>  	tristate "Qualcomm Technologies, Inc. LLCC driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 5d6b83dc58e8..b7658b007040 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -24,5 +24,6 @@ obj-$(CONFIG_QCOM_SOCINFO)	+= socinfo.o
>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
>  obj-$(CONFIG_QCOM_APR) += apr.o
>  obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
> +obj-$(CONFIG_QCOM_IPCC) += qcom_ipcc.o
>  obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
> diff --git a/drivers/soc/qcom/qcom_ipcc.c b/drivers/soc/qcom/qcom_ipcc.c
> new file mode 100644
> index 000000000000..5906a70220e0
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_ipcc.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/soc/qcom,ipcc.h>
> +
> +/* IPCC Register offsets */
> +#define IPCC_REG_SEND_ID		0x0c
> +#define IPCC_REG_RECV_ID		0x10
> +#define IPCC_REG_RECV_SIGNAL_ENABLE	0x14
> +#define IPCC_REG_RECV_SIGNAL_DISABLE	0x18
> +#define IPCC_REG_RECV_SIGNAL_CLEAR	0x1c
> +#define IPCC_REG_CLIENT_CLEAR		0x38
> +
> +#define IPCC_SIGNAL_ID_MASK		GENMASK(15, 0)
> +#define IPCC_CLIENT_ID_MASK		GENMASK(31, 16)
> +#define IPCC_CLIENT_ID_SHIFT		16
> +
> +#define IPCC_NO_PENDING_IRQ		0xffffffff
> +
> +/**
> + * struct qcom_ipcc_proto_data - Per-protocol data
> + * @irq_domain:		irq_domain associated with this protocol-id
> + * @mbox:		mailbox-controller interface
> + * @chans:		The mailbox clients channel array (created dynamically)
> + * @base:		Base address of the IPCC frame associated to APSS
> + * @dev:		Device associated with this instance
> + * @irq:		Summary irq
> + */
> +struct qcom_ipcc_proto_data {

There's only one of these per IPCC hardware block, so I would suggest
that you shorten in to just "struct qcom_ipcc" and then throughout the
implementation replace "proto_data" with just "ipcc".

> +	struct irq_domain *irq_domain;
> +	struct mbox_controller mbox;
> +	struct mbox_chan *chans;
> +	void __iomem *base;
> +	struct device *dev;
> +	int irq;
> +};
> +
> +/**
> + * struct qcom_ipcc_mbox_chan - Per-mailbox-channel data. Associated to
> + *				channel when requested by the clients
> + * @chan:	Points to this channel's array element for this protocol's
> + *		ipcc_protocol_data->chans[]
> + * @proto_data: The pointer to per-protocol data associated to this channel
> + * @client_id:	The client-id to which the interrupt has to be triggered
> + * @signal_id:	The signal-id to which the interrupt has to be triggered
> + */
> +struct qcom_ipcc_mbox_chan {
> +	struct mbox_chan *chan;
> +	struct qcom_ipcc_proto_data *proto_data;
> +	u16 client_id;
> +	u16 signal_id;
> +};
> +
> +static struct qcom_ipcc_proto_data *ipcc_proto_data;
> +
> +static inline u32 qcom_ipcc_get_packed_id(u16 client_id, u16 signal_id)

qcom_ipcc_pack_ids()

and please omit the "inline", the compiler will inline it if it's a good
thing to do.

> +{
> +	return (client_id << IPCC_CLIENT_ID_SHIFT) | signal_id;

How about:

	return FIELD_PREP(IPCC_CLIENT_ID_MASK, client_id) |
	       FIELD_PREP(IPCC_SIGNAL_ID_MASK, signal_id);

> +}
> +
> +static inline u16 qcom_ipcc_get_client_id(u32 packed_id)

This is used only to extract the field for a dev_dbg print. How about
dropping this for now and if this kind of debugging is beneficial lets
add some tracepoint that internally can extract the fields.

> +{
> +	return packed_id >> IPCC_CLIENT_ID_SHIFT;
> +}
> +
> +static inline u16 qcom_ipcc_get_signal_id(u32 packed_id)

Ditto.

> +{
> +	return packed_id & IPCC_SIGNAL_ID_MASK;
> +}
> +
> +static irqreturn_t qcom_ipcc_irq_fn(int irq, void *data)
> +{
> +	struct qcom_ipcc_proto_data *proto_data = data;
> +	u32 packed_id;
> +	int virq;
> +
> +	for (;;) {
> +		packed_id = readl(proto_data->base + IPCC_REG_RECV_ID);
> +		if (packed_id == IPCC_NO_PENDING_IRQ)
> +			break;
> +
> +		virq = irq_find_mapping(proto_data->irq_domain, packed_id);
> +
> +		dev_dbg(proto_data->dev,
> +			"IRQ for client_id: %u; signal_id: %u; virq: %d\n",
> +			qcom_ipcc_get_client_id(packed_id),
> +			qcom_ipcc_get_signal_id(packed_id), virq);

As above, I think this is useful either during development of the driver
(now done) or in a system debugging case as a tracepoint. So please omit
this debug print.

> +
> +		writel(packed_id,

If you're consistently with naming this "hwirq" you don't need to wrap
this line.

> +		       proto_data->base + IPCC_REG_RECV_SIGNAL_CLEAR);
> +
> +		generic_handle_irq(virq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void qcom_ipcc_mask_irq(struct irq_data *irqd)
> +{
> +	struct qcom_ipcc_proto_data *proto_data;
> +	irq_hw_number_t hwirq = irqd_to_hwirq(irqd);
> +	u16 sender_client_id = qcom_ipcc_get_client_id(hwirq);
> +	u16 sender_signal_id = qcom_ipcc_get_signal_id(hwirq);
> +
> +	proto_data = irq_data_get_irq_chip_data(irqd);

	struct qcom_ipcc *ipcc = irq_data_get_irq_chip_data(irqd);
	irq_hw_number_t hwirq = irqd_to_hwirq(irqd);

Looks better.

> +
> +	dev_dbg(proto_data->dev,
> +		"Disabling interrupts for: client_id: %u; signal_id: %u\n",
> +		sender_client_id, sender_signal_id);

Pushing out field dissection and "logging" to a tracepoint would make
this function prettier as well.

> +
> +	writel(hwirq, proto_data->base + IPCC_REG_RECV_SIGNAL_DISABLE);
> +}
> +
> +static void qcom_ipcc_unmask_irq(struct irq_data *irqd)
> +{
> +	struct qcom_ipcc_proto_data *proto_data;
> +	irq_hw_number_t hwirq = irqd_to_hwirq(irqd);
> +	u16 sender_client_id = qcom_ipcc_get_client_id(hwirq);
> +	u16 sender_signal_id = qcom_ipcc_get_signal_id(hwirq);
> +
> +	proto_data = irq_data_get_irq_chip_data(irqd);

As above.

> +
> +	dev_dbg(proto_data->dev,
> +		"Enabling interrupts for: client_id: %u; signal_id: %u\n",
> +		sender_client_id, sender_signal_id);
> +
> +	writel(hwirq, proto_data->base + IPCC_REG_RECV_SIGNAL_ENABLE);
> +}
> +
> +static struct irq_chip qcom_ipcc_irq_chip = {
> +	.name = "ipcc",
> +	.irq_mask = qcom_ipcc_mask_irq,
> +	.irq_unmask = qcom_ipcc_unmask_irq,
> +	.flags = IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static int qcom_ipcc_domain_map(struct irq_domain *d, unsigned int irq,
> +				irq_hw_number_t hw)
> +{
> +	struct qcom_ipcc_proto_data *proto_data = d->host_data;
> +
> +	irq_set_chip_and_handler(irq, &qcom_ipcc_irq_chip, handle_level_irq);
> +	irq_set_chip_data(irq, proto_data);
> +	irq_set_noprobe(irq);
> +
> +	return 0;
> +}
> +
> +static int qcom_ipcc_domain_xlate(struct irq_domain *d,
> +				  struct device_node *node, const u32 *intspec,
> +				  unsigned int intsize,
> +				  unsigned long *out_hwirq,
> +				  unsigned int *out_type)
> +{
> +	struct qcom_ipcc_proto_data *proto_data = d->host_data;
> +	struct device *dev = proto_data->dev;
> +
> +	if (intsize != 3)
> +		return -EINVAL;
> +
> +	*out_hwirq = qcom_ipcc_get_packed_id(intspec[0], intspec[1]);
> +	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
> +
> +	dev_dbg(dev, "hwirq: 0x%lx\n", *out_hwirq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops qcom_ipcc_irq_ops = {
> +	.map = qcom_ipcc_domain_map,
> +	.xlate = qcom_ipcc_domain_xlate,
> +};
> +
> +static int qcom_ipcc_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct qcom_ipcc_mbox_chan *ipcc_mbox_chan = chan->con_priv;
> +	struct qcom_ipcc_proto_data *proto_data = ipcc_mbox_chan->proto_data;
> +	u32 packed_id;

Although we're in the "mailbox section", I still think it's reasonable
to name this hwirq for consistency (otherwise please shorten it to "id").

> +
> +	dev_dbg(proto_data->dev,
> +		"Generating IRQ for client_id: %u; signal_id: %u\n",
> +		ipcc_mbox_chan->client_id, ipcc_mbox_chan->signal_id);
> +
> +	packed_id = qcom_ipcc_get_packed_id(ipcc_mbox_chan->client_id,
> +					    ipcc_mbox_chan->signal_id);
> +	writel(packed_id, proto_data->base + IPCC_REG_SEND_ID);
> +
> +	return 0;
> +}
> +
> +static void qcom_ipcc_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	struct qcom_ipcc_mbox_chan *ipcc_mbox_chan = chan->con_priv;
> +
> +	chan->con_priv = NULL;
> +	kfree(ipcc_mbox_chan);
> +}
> +
> +static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
> +					const struct of_phandle_args *ph)
> +{
> +	struct device *dev;
> +	struct qcom_ipcc_proto_data *proto_data;
> +	struct qcom_ipcc_mbox_chan *ipcc_mbox_chan;
> +	int chan_id;
> +
> +	proto_data = container_of(mbox, struct qcom_ipcc_proto_data, mbox);
> +	if (WARN_ON(!proto_data))

Is this possible?

> +		return ERR_PTR(-EINVAL);
> +
> +	dev = proto_data->dev;
> +
> +	if (ph->args_count != 2)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Check whether the mbox channel is allocated or not */
> +	for (chan_id = 0; chan_id < mbox->num_chans; chan_id++) {
> +		ipcc_mbox_chan = proto_data->chans[chan_id].con_priv;
> +
> +		if (!ipcc_mbox_chan)
> +			break;
> +		else if (ipcc_mbox_chan->client_id == ph->args[0] &&
> +			 ipcc_mbox_chan->signal_id == ph->args[1])
> +			return ERR_PTR(-EBUSY);

I think it would be better to just return the matching chan, and let
mbox_request_channel() deal with the fact that it's already in use.

> +	}
> +
> +	if (chan_id >= mbox->num_chans)
> +		return ERR_PTR(-EBUSY);
> +
> +	ipcc_mbox_chan = kzalloc(sizeof(*ipcc_mbox_chan), GFP_KERNEL);

Can we allocate these during initialization time instead of allocating
and releasing them in of_xlate and shutdown?

> +	if (!ipcc_mbox_chan)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ipcc_mbox_chan->client_id = ph->args[0];
> +	ipcc_mbox_chan->signal_id = ph->args[1];
> +	ipcc_mbox_chan->chan = &proto_data->chans[chan_id];
> +	ipcc_mbox_chan->proto_data = proto_data;
> +	ipcc_mbox_chan->chan->con_priv = ipcc_mbox_chan;
> +
> +	dev_dbg(dev,
> +		"New mailbox channel: %u for client_id: %u; signal_id: %u\n",
> +		chan_id, ipcc_mbox_chan->client_id,
> +		ipcc_mbox_chan->signal_id);
> +
> +	return ipcc_mbox_chan->chan;
> +}
> +
> +static const struct mbox_chan_ops ipcc_mbox_chan_ops = {
> +	.send_data = qcom_ipcc_mbox_send_data,
> +	.shutdown = qcom_ipcc_mbox_shutdown
> +};
> +
> +static int qcom_ipcc_setup_mbox(struct qcom_ipcc_proto_data *proto_data,
> +				struct device_node *controller_dn)
> +{
> +	struct mbox_controller *mbox;
> +	struct device_node *client_dn;
> +	struct device *dev = proto_data->dev;
> +	struct of_phandle_args curr_ph;
> +	int i, j, ret;
> +	int num_chans = 0;
> +
> +	/*
> +	 * Find out the number of clients interested in this mailbox
> +	 * and create channels accordingly.
> +	 */
> +	for_each_node_with_property(client_dn, "mboxes") {

How much memory do we save by doing this, in comparison to just picking
a max amount?

> +		if (!of_device_is_available(client_dn))
> +			continue;
> +		i = of_count_phandle_with_args(client_dn,
> +					       "mboxes", "#mbox-cells");
> +		for (j = 0; j < i; j++) {
> +			ret = of_parse_phandle_with_args(client_dn, "mboxes",
> +							 "#mbox-cells", j,
> +							 &curr_ph);
> +			of_node_put(curr_ph.np);
> +			if (!ret && curr_ph.np == controller_dn) {
> +				num_chans++;
> +				break;
> +			}
> +		}
> +	}
> +
> +	/* If no clients are found, skip registering as a mbox controller */
> +	if (!num_chans)
> +		return 0;
> +
> +	proto_data->chans = devm_kcalloc(dev, num_chans,
> +					 sizeof(struct mbox_chan), GFP_KERNEL);

sizeof(*proto_data->chans)

> +	if (!proto_data->chans)
> +		return -ENOMEM;
> +
> +	mbox = &proto_data->mbox;
> +	mbox->dev = dev;
> +	mbox->num_chans = num_chans;
> +	mbox->chans = proto_data->chans;
> +	mbox->ops = &ipcc_mbox_chan_ops;
> +	mbox->of_xlate = qcom_ipcc_mbox_xlate;
> +	mbox->txdone_irq = false;
> +	mbox->txdone_poll = false;
> +
> +	return devm_mbox_controller_register(dev, mbox);
> +}
> +
> +static int qcom_ipcc_probe(struct platform_device *pdev)
> +{
> +	struct qcom_ipcc_proto_data *proto_data;
> +	int ret;
> +
> +	proto_data = devm_kzalloc(&pdev->dev, sizeof(*proto_data), GFP_KERNEL);
> +	if (!proto_data)
> +		return -ENOMEM;
> +
> +	ipcc_proto_data = proto_data;

ipcc_protocol_data is unused.

> +	proto_data->dev = &pdev->dev;
> +
> +	proto_data->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(proto_data->base)) {
> +		dev_err(&pdev->dev, "Failed to ioremap the ipcc base addr\n");
> +		return PTR_ERR(proto_data->base);
> +	}
> +
> +	proto_data->irq = platform_get_irq(pdev, 0);
> +	if (proto_data->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get the IRQ\n");

platform_get_irq() already did print.

> +		return proto_data->irq;
> +	}
> +
> +	/* Perform a SW reset on this client's protocol state */
> +	writel(0x1, proto_data->base + IPCC_REG_CLIENT_CLEAR);
> +
> +	proto_data->irq_domain = irq_domain_add_tree(pdev->dev.of_node,
> +						     &qcom_ipcc_irq_ops,
> +						     proto_data);
> +	if (!proto_data->irq_domain) {
> +		dev_err(&pdev->dev, "Failed to add irq_domain\n");

Afaict this also prints errors.

> +		return -ENOMEM;
> +	}
> +
> +	ret = qcom_ipcc_setup_mbox(proto_data, pdev->dev.of_node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to create mailbox\n");

Afaict this too will print errors in all code paths (except the ones
where you pass invalid data to mbox_controller_register() - but we're
already past that).

Regards,
Bjorn

> +		goto err_mbox;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, proto_data->irq, qcom_ipcc_irq_fn,
> +			       IRQF_TRIGGER_HIGH, "ipcc", proto_data);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
> +		goto err_mbox;
> +	}
> +
> +	enable_irq_wake(proto_data->irq);
> +	platform_set_drvdata(pdev, proto_data);
> +
> +	return 0;
> +
> +err_mbox:
> +	irq_domain_remove(proto_data->irq_domain);
> +
> +	return ret;
> +}
> +
> +static int qcom_ipcc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_ipcc_proto_data *proto_data = platform_get_drvdata(pdev);
> +
> +	disable_irq_wake(proto_data->irq);
> +	irq_domain_remove(proto_data->irq_domain);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_ipcc_of_match[] = {
> +	{ .compatible = "qcom,ipcc"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
> +
> +static struct platform_driver qcom_ipcc_driver = {
> +	.probe = qcom_ipcc_probe,
> +	.remove = qcom_ipcc_remove,
> +	.driver = {
> +		.name = "qcom_ipcc",
> +		.of_match_table = qcom_ipcc_of_match,
> +	},
> +};
> +
> +static int __init qcom_ipcc_init(void)
> +{
> +	return platform_driver_register(&qcom_ipcc_driver);
> +}
> +arch_initcall(qcom_ipcc_init);
> +
> +static void __exit qcom_ipcc_exit(void)
> +{
> +	platform_driver_unregister(&qcom_ipcc_driver);
> +}
> +module_exit(qcom_ipcc_exit);
> +
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
