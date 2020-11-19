Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1C2B9B10
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgKSTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:01:53 -0500
Received: from foss.arm.com ([217.140.110.172]:37670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgKSTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:01:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0206D1396;
        Thu, 19 Nov 2020 11:01:51 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CE623F70D;
        Thu, 19 Nov 2020 11:01:49 -0800 (PST)
Date:   Thu, 19 Nov 2020 19:01:47 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, broonie@kernel.org, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v5 1/5] firmware: arm_scmi: Add Voltage Domain Support
Message-ID: <20201119190147.GB16158@e120937-lin>
References: <20201117123415.55105-1-cristian.marussi@arm.com>
 <20201117123415.55105-2-cristian.marussi@arm.com>
 <20201119160824.3vztaax75p3fg4vl@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119160824.3vztaax75p3fg4vl@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep

thanks for reviewing.

On Thu, Nov 19, 2020 at 04:08:24PM +0000, Sudeep Holla wrote:
> On Tue, Nov 17, 2020 at 12:34:11PM +0000, Cristian Marussi wrote:
> > Add SCMI Voltage Domain protocol support.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v4 --> v5
> > - removed inline
> > - moved segmented intervals defines
> > - fixed some macros complaints by checkpatch
> > 
> > v3 --> v4
> > - avoid fixed sized typing in voltage_info
> > - avoid coccinelle falde complaints about pointer-sized allocations
> > 
> > v2 --> v3
> > - restrict segmented voltage domain descriptors to one triplet
> > - removed unneeded inline
> > - free allocated resources for invalid voltage domain
> > - added __must_check to info_get voltage operations
> > - added a few comments
> > - removed fixed size typing from struct voltage_info
> > 
> > v1 --> v2
> > - fix voltage levels query loop to reload full cmd description
> >   between iterations as reported by Etienne Carriere
> > - ensure rx buffer is properly sized calli scmi_reset_rx_to_maxsz
> >   between transfers
> > ---
> >  drivers/firmware/arm_scmi/Makefile  |   2 +-
> >  drivers/firmware/arm_scmi/common.h  |   1 +
> >  drivers/firmware/arm_scmi/driver.c  |   2 +
> >  drivers/firmware/arm_scmi/voltage.c | 397 ++++++++++++++++++++++++++++
> >  include/linux/scmi_protocol.h       |  64 +++++
> >  5 files changed, 465 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/firmware/arm_scmi/voltage.c
> > 
> > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> > index bc0d54f8e861..6a2ef63306d6 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -4,7 +4,7 @@ scmi-driver-y = driver.o notify.o
> >  scmi-transport-y = shmem.o
> >  scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
> >  scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
> > -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o
> > +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
> >  scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
> >  		    $(scmi-transport-y)
> >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 65063fa948d4..c0fb45e7c3e8 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -169,6 +169,7 @@ DECLARE_SCMI_REGISTER_UNREGISTER(perf);
> >  DECLARE_SCMI_REGISTER_UNREGISTER(power);
> >  DECLARE_SCMI_REGISTER_UNREGISTER(reset);
> >  DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
> > +DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
> >  DECLARE_SCMI_REGISTER_UNREGISTER(system);
> >  
> >  #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(id, name) \
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 3dfd8b6a0ebf..ada35e63feae 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -946,6 +946,7 @@ static int __init scmi_driver_init(void)
> >  	scmi_power_register();
> >  	scmi_reset_register();
> >  	scmi_sensors_register();
> > +	scmi_voltage_register();
> >  	scmi_system_register();
> >  
> >  	return platform_driver_register(&scmi_driver);
> > @@ -961,6 +962,7 @@ static void __exit scmi_driver_exit(void)
> >  	scmi_power_unregister();
> >  	scmi_reset_unregister();
> >  	scmi_sensors_unregister();
> > +	scmi_voltage_unregister();
> >  	scmi_system_unregister();
> >  
> >  	platform_driver_unregister(&scmi_driver);
> > diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
> > new file mode 100644
> > index 000000000000..6b71589e0846
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/voltage.c
> > @@ -0,0 +1,397 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * System Control and Management Interface (SCMI) Voltage Protocol
> > + *
> > + * Copyright (C) 2020 ARM Ltd.
> > + */
> > +
> > +#include <linux/scmi_protocol.h>
> > +
> > +#include "common.h"
> > +
> > +#define VOLTAGE_DOMS_NUM_MASK		GENMASK(15, 0)
> > +#define REMAINING_LEVELS_MASK		GENMASK(31, 16)
> > +#define RETURNED_LEVELS_MASK		GENMASK(11, 0)
> > +
> > +enum scmi_voltage_protocol_cmd {
> > +	VOLTAGE_DOMAIN_ATTRIBUTES = 0x3,
> > +	VOLTAGE_DESCRIBE_LEVELS = 0x4,
> > +	VOLTAGE_CONFIG_SET = 0x5,
> > +	VOLTAGE_CONFIG_GET = 0x6,
> > +	VOLTAGE_LEVEL_SET = 0x7,
> > +	VOLTAGE_LEVEL_GET = 0x8,
> > +};
> > +
> > +struct scmi_msg_resp_protocol_attributes {
> > +	__le32 attr;
> > +#define NUM_VOLTAGE_DOMAINS(x)	((u16)(FIELD_GET(VOLTAGE_DOMS_NUM_MASK, (x))))
> > +};
> > +
> 
> Sorry but same annoying comment again, drop one element structures.
> 

I'll do.

> > +struct scmi_msg_resp_domain_attributes {
> > +	__le32 attr;
> > +	u8 name[SCMI_MAX_STR_SIZE];
> > +};
> > +
> > +struct scmi_msg_cmd_describe_levels {
> > +	__le32 domain_id;
> > +	__le32 level_index;
> > +};
> > +
> > +struct scmi_msg_resp_describe_levels {
> > +	__le32 flags;
> > +#define NUM_REMAINING_LEVELS(f)	((u16)(FIELD_GET(REMAINING_LEVELS_MASK, (f))))
> > +#define NUM_RETURNED_LEVELS(f)	((u16)(FIELD_GET(RETURNED_LEVELS_MASK, (f))))
> > +#define SUPPORTS_SEGMENTED_LEVELS(f)	((f) & BIT(12))
> > +	__le32 voltage[];
> > +};
> > +
> > +struct scmi_msg_cmd_config_set {
> > +	__le32 domain_id;
> > +	__le32 config;
> > +};
> > +
> > +struct scmi_msg_cmd_level_set {
> > +	__le32 domain_id;
> > +	__le32 flags;
> > +	__le32 voltage_level;
> > +};
> > +
> > +struct voltage_info {
> > +	unsigned int version;
> > +	unsigned int num_domains;
> > +	struct scmi_voltage_info **domains;
> > +};
> > +
> > +static int scmi_protocol_attributes_get(const struct scmi_handle *handle,
> > +					struct voltage_info *vinfo)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_resp_protocol_attributes *resp;
> > +
> > +	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
> > +				 SCMI_PROTOCOL_VOLTAGE, 0, sizeof(*resp), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	resp = t->rx.buf;
> > +	ret = scmi_do_xfer(handle, t);
> > +	if (!ret)
> > +		vinfo->num_domains =
> > +			NUM_VOLTAGE_DOMAINS(le32_to_cpu(resp->attr));
> > +
> > +	scmi_xfer_put(handle, t);
> > +	return ret;
> > +}
> > +
> > +static int scmi_init_voltage_levels(struct device *dev,
> > +				    struct scmi_voltage_info *v,
> > +				    u32 flags, u32 num_returned,
> > +				    u32 num_remaining)
> > +{
> > +	bool segmented;
> > +	u32 num_levels;
> > +
> 
> Why can't you pass the above 2 directly from the caller to this function
> since they are just used to obtain them here.
> 

I can and I'll do for segmented, num_levels I need to have it split in
returned and remaining here to check the holy triplet is fine.
(assuming I want to keep all the checkery inside this func)

> 
> [...]
> 
> > +static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
> > +					struct voltage_info *vinfo)
> > +{
> > +	int ret, dom;
> > +	struct scmi_xfer *td, *tl;
> > +	struct device *dev = handle->dev;
> > +	struct scmi_msg_resp_domain_attributes *resp_dom;
> > +	struct scmi_msg_resp_describe_levels *resp_levels;
> > +
> > +	ret = scmi_xfer_get_init(handle, VOLTAGE_DOMAIN_ATTRIBUTES,
> > +				 SCMI_PROTOCOL_VOLTAGE, sizeof(__le32),
> > +				 sizeof(*resp_dom), &td);
> > +	if (ret)
> > +		return ret;
> > +	resp_dom = td->rx.buf;
> > +
> > +	ret = scmi_xfer_get_init(handle, VOLTAGE_DESCRIBE_LEVELS,
> > +				 SCMI_PROTOCOL_VOLTAGE, sizeof(__le64), 0, &tl);
> > +	if (ret)
> > +		goto outd;
> > +	resp_levels = tl->rx.buf;
> > +
> > +	for (dom = 0; dom < vinfo->num_domains; dom++) {
> > +		u32 desc_index = 0;
> > +		u16 num_returned = 0, num_remaining = 0;
> > +		struct scmi_msg_cmd_describe_levels *cmd;
> > +		struct scmi_voltage_info *v;
> > +
> > +		/* Retrieve domain attributes at first ... */
> > +		put_unaligned_le32(dom, td->tx.buf);
> > +		ret = scmi_do_xfer(handle, td);
> > +		/* Skip domain on comms error */
> > +		if (ret)
> > +			continue;
> > +
> > +		v = devm_kzalloc(dev, sizeof(*v), GFP_KERNEL);
> > +		if (!v) {
> > +			ret = -ENOMEM;
> > +			break;
> > +		}
> > +
> 
> Why can't we allocate vinfo->domains real structure instead of pointers
> and indirection there ? I understand that it helps to manage holes easily
> but I think that would simplify the dynamic allocation and error handling.
> It doesn't have to be this complicated(not much but still) IMO.
> 
> May be scmi_voltage_info_get can use num_levels to either return NULL
> or vinfo->domains[domain_id] ?
> 

Yes it was for the holes, but I'll do allocating contiguously and
checking on num_levels != 0 as you suggested

Thanks

Cristian

> Regards,
> Sudeep
