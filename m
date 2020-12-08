Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF82D2B94
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgLHNDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728287AbgLHNDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607432483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAwq6tAddDM3lA2WcgZw20XAbvCsawFWfXw9dUX1FvA=;
        b=YbCywj4quatv7TCSKud8pcO3yTronsYWIgZvleBdC3mRaRs7JWXCb1YKXmZ6kOSr+g3ZCO
        m3/Fc8L03RAq/Hsxf5R9TfWF7YW64uEGRPQR4riWGgmSLNl1NvtzPQCtQ3bi1whQzNwWH+
        vq7DniMSRlnt/gPLebhiM/HVSPfa2UA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-K0gMbqkkMdeSHQAnCeCJkg-1; Tue, 08 Dec 2020 08:01:15 -0500
X-MC-Unique: K0gMbqkkMdeSHQAnCeCJkg-1
Received: by mail-ed1-f69.google.com with SMTP id h5so7421414edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 05:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RAwq6tAddDM3lA2WcgZw20XAbvCsawFWfXw9dUX1FvA=;
        b=gDJVRPH+eHndz4dq+YC++N8JOiBMrajo7ayWdpIBmiaf3lkpKvhPSMXkrF9AZgPh2Y
         QsupbW7/RZZLHMs1lyJd2QPAmgrT/Jq55IuDeWNi0PCN/S/3v2xePaU1X2gqXi2HaShn
         B6DtTVdS1AybuHceu53VmoWHFXRHDdPS60RHms/3gXlkTCuBlntyrmFl5MRKNiQtFhmn
         LaFGDKKTeLj2C40mhecl/fjfTR7lc+IPoLKbSLL2HumGL0HvpWueWXPsXGbxyQNd5xkz
         wHAf+mz7LkE0sBU4gQsYxWdMxtqURwwd7LDZ648ucehyCcZjkgjj9ALYcxdkQYGkI41A
         0+tg==
X-Gm-Message-State: AOAM5308B48igapusF5Ef+tmpq/OkKJ80O4DbWTcQHOt5qjUVvy9mcMq
        v+PNp0UPyk6yxSQ97tJ4jaAtL1CI1yPuQ+WrrIphw95GG3O6wuAKU/AySn+KQC2xTuj++WoW1TZ
        hn+qyr7wpChDrU4IVevAwfb3S
X-Received: by 2002:a17:906:cec3:: with SMTP id si3mr22880956ejb.277.1607432470812;
        Tue, 08 Dec 2020 05:01:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSTwBskVR8yMfQKpVzn5gqkdvty92IjDlutYJ/pvu+aRGZuJvKK9aEKhx5i0gkdEJjiwCXmg==
X-Received: by 2002:a17:906:cec3:: with SMTP id si3mr22880759ejb.277.1607432468291;
        Tue, 08 Dec 2020 05:01:08 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t26sm15592581eji.22.2020.12.08.05.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 05:01:07 -0800 (PST)
Subject: Re: [PATCH v2 1/9] platform/surface: Add Surface Aggregator subsystem
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201203212640.663931-2-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fd24d99a-e4f4-2030-e9bb-bcd549ce4bb9@redhat.com>
Date:   Tue, 8 Dec 2020 14:01:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203212640.663931-2-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your patch series.

Full review done, I have a couple of minor review remarks inline below.

Note these are really all suggestions and not must fix for this to
be merged items.

On 12/3/20 10:26 PM, Maximilian Luz wrote:
> Add Surface System Aggregator Module core and Surface Serial Hub driver,
> required for the embedded controller found on Microsoft Surface devices.
> 
> The Surface System Aggregator Module (SSAM, SAM or Surface Aggregator)
> is an embedded controller (EC) found on 4th and later generation
> Microsoft Surface devices, with the exception of the Surface Go series.
> This EC provides various functionality, depending on the device in
> question. This can include battery status and thermal reporting (5th and
> later generations), but also HID keyboard (6th+) and touchpad input
> (7th+) on Surface Laptop and Surface Book 3 series devices.
> 
> This patch provides the basic necessities for communication with the SAM
> EC on 5th and later generation devices. On these devices, the EC
> provides an interface that acts as serial device, called the Surface
> Serial Hub (SSH). 4th generation devices, on which the EC interface is
> provided via an HID-over-I2C device, are not supported by this patch.
> 
> Specifically, this patch adds a driver for the SSH device (device HID
> MSHW0084 in ACPI), as well as a controller structure and associated API.
> This represents the functional core of the Surface Aggregator kernel
> subsystem, introduced with this patch, and will be expanded upon in
> subsequent commits.
> 
> The SSH driver acts as the main attachment point for this subsystem and
> sets-up and manages the controller structure. The controller in turn
> provides a basic communication interface, allowing to send requests from
> host to EC and receiving the corresponding responses, as well as
> managing and receiving events, sent from EC to host. It is structured
> into multiple layers, with the top layer presenting the API used by
> other kernel drivers and the lower layers modeled after the serial
> protocol used for communication.
> 
> Said other drivers are then responsible for providing the (Surface model
> specific) functionality accessible through the EC (e.g. battery status
> reporting, thermal information, ...) via said controller structure and
> API, and will be added in future commits.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> 
> Changes in v1 (from RFC):
>  - add copyright lines
>  - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
>  - fix bug in __ssh_ptl_queue_push, potentially leading to a deadlock
>    in high-traffic situations
>  - remove unnecessary READ_ONCE on multiple occasions
>  - add NULL checks for ssh_packet_get, ssh_packet_put
>  - add NULL checks for ssh_request_get, ssh_request_put
>  - guard dev_pm_ops with CONFIG_PM_SLEEP check
>  - mark struct ssam_request pointer as const when possible
>  - introduce generic retry macro with defaults
>  - retry base controller requests on failure
> 
> Changes in v2:
>  - add transmission timeout for packets
>  - simplify acknowledgment timeout implementation
>  - simplify packet ACK handling
>  - restructure and simplify transmitter thread function
>  - restructure SSH message building
>  - switch to explicit RCU list for event notifiers
>  - use sysfs_emit for sysfs attributes
>  - fix memory leak on event item submission failure
>  - fix unaligned length access in parser
>  - use printk specifier for hex prefix instead of hard-coding it
>  - use numeric limit macros instead of casting around '-1'
>  - extract and document magic values
>  - try to make return values more consistent
>  - spell check comments and strings, fix typos
>  - unify comment style
>  - run checkpatch --strict, fix these and other style issues
>  - improve comments/documentation
> 
> ---
>  MAINTAINERS                                   |    8 +
>  drivers/platform/surface/Kconfig              |    2 +
>  drivers/platform/surface/Makefile             |    1 +
>  drivers/platform/surface/aggregator/Kconfig   |   43 +
>  drivers/platform/surface/aggregator/Makefile  |   10 +
>  .../platform/surface/aggregator/controller.c  | 2468 +++++++++++++++++
>  .../platform/surface/aggregator/controller.h  |  276 ++
>  drivers/platform/surface/aggregator/core.c    |  781 ++++++
>  .../platform/surface/aggregator/ssh_msgb.h    |  205 ++
>  .../surface/aggregator/ssh_packet_layer.c     | 1699 ++++++++++++
>  .../surface/aggregator/ssh_packet_layer.h     |  187 ++
>  .../platform/surface/aggregator/ssh_parser.c  |  228 ++
>  .../platform/surface/aggregator/ssh_parser.h  |  154 +
>  .../surface/aggregator/ssh_request_layer.c    | 1203 ++++++++
>  .../surface/aggregator/ssh_request_layer.h    |  143 +
>  include/linux/surface_aggregator/controller.h |  824 ++++++
>  include/linux/surface_aggregator/serial_hub.h |  672 +++++
>  17 files changed, 8904 insertions(+)
>  create mode 100644 drivers/platform/surface/aggregator/Kconfig
>  create mode 100644 drivers/platform/surface/aggregator/Makefile
>  create mode 100644 drivers/platform/surface/aggregator/controller.c
>  create mode 100644 drivers/platform/surface/aggregator/controller.h
>  create mode 100644 drivers/platform/surface/aggregator/core.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_msgb.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_parser.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_parser.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.h
>  create mode 100644 include/linux/surface_aggregator/controller.h
>  create mode 100644 include/linux/surface_aggregator/serial_hub.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bb4604e64b4a..64730461f4df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11692,6 +11692,14 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Supported
>  F:	drivers/platform/surface/surfacepro3_button.c
> 
> +MICROSOFT SURFACE SYSTEM AGGREGATOR SUBSYSTEM
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +S:	Maintained
> +W:	https://github.com/linux-surface/surface-aggregator-module
> +C:	irc://chat.freenode.net/##linux-surface
> +F:	drivers/platform/surface/aggregator/
> +F:	include/linux/surface_aggregator/
> +
>  MICROTEK X6 SCANNER
>  M:	Oliver Neukum <oliver@neukum.org>
>  S:	Maintained
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index 33040b0b3b79..5af22f5141ff 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -56,4 +56,6 @@ config SURFACE_PRO3_BUTTON
>  	help
>  	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
> 
> +source "drivers/platform/surface/aggregator/Kconfig"
> +
>  endif # SURFACE_PLATFORMS
> diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
> index cedfb027ded1..034134fe0264 100644
> --- a/drivers/platform/surface/Makefile
> +++ b/drivers/platform/surface/Makefile
> @@ -7,5 +7,6 @@
>  obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
>  obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
>  obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
> +obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
>  obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
>  obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
> diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
> new file mode 100644
> index 000000000000..ce34941ef91b
> --- /dev/null
> +++ b/drivers/platform/surface/aggregator/Kconfig
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
> +
> +menuconfig SURFACE_AGGREGATOR
> +	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
> +	depends on SERIAL_DEV_BUS
> +	depends on ACPI
> +	select CRC_CCITT
> +	help
> +	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
> +	  embedded controller (EC) found on 5th- and later-generation Microsoft
> +	  Surface devices (i.e. Surface Pro 5, Surface Book 2, Surface Laptop,
> +	  and newer, with exception of Surface Go series devices).
> +
> +	  Depending on the device in question, this EC provides varying
> +	  functionality, including:
> +	  - EC access from ACPI via Surface ACPI Notify (5th- and 6th-generation)
> +	  - battery status information (all devices)
> +	  - thermal sensor access (all devices)
> +	  - performance mode / cooling mode control (all devices)
> +	  - clipboard detachment system control (Surface Book 2 and 3)
> +	  - HID / keyboard input (Surface Laptops, Surface Book 3)
> +
> +	  This option controls whether the Surface SAM subsystem core will be
> +	  built. This includes a driver for the Surface Serial Hub (SSH), which
> +	  is the device responsible for the communication with the EC, and a
> +	  basic kernel interface exposing the EC functionality to other client
> +	  drivers, i.e. allowing them to make requests to the EC and receive
> +	  events from it. Selecting this option alone will not provide any
> +	  client drivers and therefore no functionality beyond the in-kernel
> +	  interface. Said functionality is the responsibility of the respective
> +	  client drivers.
> +
> +	  Note: While 4th-generation Surface devices also make use of a SAM EC,
> +	  due to a difference in the communication interface of the controller,
> +	  only 5th and later generations are currently supported. Specifically,
> +	  devices using SAM-over-SSH are supported, whereas devices using
> +	  SAM-over-HID, which is used on the 4th generation, are currently not
> +	  supported.
> +
> +	  Choose m if you want to build the SAM subsystem core and SSH driver as
> +	  module, y if you want to build it into the kernel and n if you don't
> +	  want it at all.
> diff --git a/drivers/platform/surface/aggregator/Makefile b/drivers/platform/surface/aggregator/Makefile
> new file mode 100644
> index 000000000000..faad18d4a7f2
> --- /dev/null
> +++ b/drivers/platform/surface/aggregator/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
> +
> +obj-$(CONFIG_SURFACE_AGGREGATOR) += surface_aggregator.o
> +
> +surface_aggregator-objs := core.o
> +surface_aggregator-objs += ssh_parser.o
> +surface_aggregator-objs += ssh_packet_layer.o
> +surface_aggregator-objs += ssh_request_layer.o
> +surface_aggregator-objs += controller.o
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> new file mode 100644
> index 000000000000..8d9811cc2943
> --- /dev/null
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -0,0 +1,2468 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Main SSAM/SSH controller structure and functionality.
> + *
> + * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/atomic.h>
> +#include <linux/completion.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kref.h>
> +#include <linux/limits.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/rculist.h>
> +#include <linux/rbtree.h>
> +#include <linux/rwsem.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/surface_aggregator/controller.h>
> +#include <linux/surface_aggregator/serial_hub.h>
> +
> +#include "controller.h"
> +#include "ssh_msgb.h"
> +#include "ssh_request_layer.h"
> +
> +
> +/* -- Safe counters. -------------------------------------------------------- */
> +
> +/**
> + * ssh_seq_reset() - Reset/initialize sequence ID counter.
> + * @c: The counter to reset.
> + */
> +static void ssh_seq_reset(struct ssh_seq_counter *c)
> +{
> +	WRITE_ONCE(c->value, 0);
> +}
> +
> +/**
> + * ssh_seq_next() - Get next sequence ID.
> + * @c: The counter providing the sequence IDs.
> + *
> + * Return: Returns the next sequence ID of the counter.
> + */
> +static u8 ssh_seq_next(struct ssh_seq_counter *c)
> +{
> +	u8 old = READ_ONCE(c->value);
> +	u8 new = old + 1;
> +	u8 ret;
> +
> +	while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
> +		old = ret;
> +		new = old + 1;
> +	}
> +
> +	return old;
> +}
> +
> +/**
> + * ssh_rqid_reset() - Reset/initialize request ID counter.
> + * @c: The counter to reset.
> + */
> +static void ssh_rqid_reset(struct ssh_rqid_counter *c)
> +{
> +	WRITE_ONCE(c->value, 0);
> +}
> +
> +/**
> + * ssh_rqid_next() - Get next request ID.
> + * @c: The counter providing the request IDs.
> + *
> + * Return: Returns the next request ID of the counter, skipping any reserved
> + * request IDs.
> + */
> +static u16 ssh_rqid_next(struct ssh_rqid_counter *c)
> +{
> +	u16 old = READ_ONCE(c->value);
> +	u16 new = ssh_rqid_next_valid(old);
> +	u16 ret;
> +
> +	while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
> +		old = ret;
> +		new = ssh_rqid_next_valid(old);
> +	}
> +
> +	return old;
> +}
> +
> +
> +/* -- Event notifier/callbacks. --------------------------------------------- */
> +/*
> + * The notifier system is based on linux/notifier.h, specifically the SRCU
> + * implementation. The difference to that is, that some bits of the notifier
> + * call return value can be tracked across multiple calls. This is done so
> + * that handling of events can be tracked and a warning can be issued in case
> + * an event goes unhandled. The idea of that warning is that it should help
> + * discover and identify new/currently unimplemented features.
> + */
> +
> +/**
> + * ssam_event_matches_notifier() - Test if an event matches a notifier.
> + * @n: The event notifier to test against.
> + * @event: The event to test.
> + *
> + * Return: Returns %true iff the given event matches the given notifier

s/iff/if/

> + * according to the rules set in the notifier's event mask, %false otherwise.
> + */
> +static bool ssam_event_matches_notifier(const struct ssam_event_notifier *n,
> +					const struct ssam_event *event)
> +{
> +	bool match = n->event.id.target_category == event->target_category;
> +
> +	if (n->event.mask & SSAM_EVENT_MASK_TARGET)
> +		match &= n->event.reg.target_id == event->target_id;
> +
> +	if (n->event.mask & SSAM_EVENT_MASK_INSTANCE)
> +		match &= n->event.id.instance == event->instance_id;
> +
> +	return match;
> +}
> +
> +/**
> + * ssam_nfblk_call_chain() - Call event notifier callbacks of the given chain.
> + * @nh:    The notifier head for which the notifier callbacks should be called.
> + * @event: The event data provided to the callbacks.
> + *
> + * Call all registered notifier callbacks in order of their priority until
> + * either no notifier is left or a notifier returns a value with the
> + * %SSAM_NOTIF_STOP bit set. Note that this bit is automatically set via
> + * ssam_notifier_from_errno() on any non-zero error value.
> + *
> + * Return: Returns the notifier status value, which contains the notifier
> + * status bits (%SSAM_NOTIF_HANDLED and %SSAM_NOTIF_STOP) as well as a
> + * potential error value returned from the last executed notifier callback.
> + * Use ssam_notifier_to_errno() to convert this value to the original error
> + * value.
> + */
> +static int ssam_nfblk_call_chain(struct ssam_nf_head *nh, struct ssam_event *event)
> +{
> +	struct ssam_event_notifier *nf;
> +	int ret = 0, idx;
> +
> +	idx = srcu_read_lock(&nh->srcu);
> +
> +	list_for_each_entry_rcu(nf, &nh->head, base.node) {
> +		if (ssam_event_matches_notifier(nf, event)) {
> +			ret = (ret & SSAM_NOTIF_STATE_MASK) | nf->base.fn(nf, event);
> +			if (ret & SSAM_NOTIF_STOP)
> +				break;
> +		}
> +	}
> +
> +	srcu_read_unlock(&nh->srcu, idx);
> +	return ret;
> +}
> +
> +/**
> + * ssam_nfblk_insert() - Insert a new notifier block into the given notifier
> + * list.
> + * @nh: The notifier head into which the block should be inserted.
> + * @nb: The notifier block to add.
> + *
> + * Note: This function must be synchronized by the caller with respect to other
> + * insert, find, and/or remove calls.
> + *
> + * Return: Returns zero on success, %-EEXIST if the notifier block has already
> + * been registered.
> + */
> +static int ssam_nfblk_insert(struct ssam_nf_head *nh, struct ssam_notifier_block *nb)
> +{
> +	struct ssam_notifier_block *p;
> +	struct list_head *h;
> +
> +	/* Runs under lock, no need for RCU variant. */
> +	list_for_each(h, &nh->head) {
> +		p = list_entry(h, struct ssam_notifier_block, node);
> +
> +		if (unlikely(p == nb)) {
> +			WARN(1, "double register detected");
> +			return -EEXIST;
> +		}
> +
> +		if (nb->priority > p->priority)
> +			break;
> +	}
> +
> +	list_add_tail_rcu(&nb->node, h);
> +	return 0;
> +}
> +
> +/**
> + * ssam_nfblk_find() - Check if a notifier block is registered on the given
> + * notifier head.
> + * list.
> + * @nh: The notifier head on which to search.
> + * @nb: The notifier block to search for.
> + *
> + * Note: This function must be synchronized by the caller with respect to other
> + * insert, find, and/or remove calls.
> + *
> + * Return: Returns true if the given notifier block is registered on the given
> + * notifier head, false otherwise.
> + */
> +static bool ssam_nfblk_find(struct ssam_nf_head *nh, struct ssam_notifier_block *nb)
> +{
> +	struct ssam_notifier_block *p;
> +
> +	/* Runs under lock, no need for RCU variant. */
> +	list_for_each_entry(p, &nh->head, node) {
> +		if (p == nb)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * ssam_nfblk_remove() - Remove a notifier block from its notifier list.
> + * @nb: The notifier block to be removed.
> + *
> + * Note: This function must be synchronized by the caller with respect to
> + * other insert, find and/or remove calls. The caller _must_ ensure SRCU
> + * synchronization by calling synchronize_srcu() with ``nh->srcu`` after
> + * leaving the critical section, to ensure that the removed notifier block is
> + * not in use any more.
> + */
> +static void ssam_nfblk_remove(struct ssam_notifier_block *nb)
> +{
> +	list_del_rcu(&nb->node);
> +}
> +
> +/**
> + * ssam_nf_head_init() - Initialize the given notifier head.
> + * @nh: The notifier head to initialize.
> + */
> +static int ssam_nf_head_init(struct ssam_nf_head *nh)
> +{
> +	int status;
> +
> +	status = init_srcu_struct(&nh->srcu);
> +	if (status)
> +		return status;
> +
> +	INIT_LIST_HEAD(&nh->head);
> +	return 0;
> +}
> +
> +/**
> + * ssam_nf_head_destroy() - Deinitialize the given notifier head.
> + * @nh: The notifier head to deinitialize.
> + */
> +static void ssam_nf_head_destroy(struct ssam_nf_head *nh)
> +{
> +	cleanup_srcu_struct(&nh->srcu);
> +}
> +
> +
> +/* -- Event/notification registry. ------------------------------------------ */
> +
> +/**
> + * struct ssam_nf_refcount_key - Key used for event activation reference
> + * counting.
> + * @reg: The registry via which the event is enabled/disabled.
> + * @id:  The ID uniquely describing the event.
> + */
> +struct ssam_nf_refcount_key {
> +	struct ssam_event_registry reg;
> +	struct ssam_event_id id;
> +};
> +
> +/**
> + * struct ssam_nf_refcount_entry - RB-tree entry for reference counting event
> + * activations.
> + * @node:     The node of this entry in the rb-tree.
> + * @key:      The key of the event.
> + * @refcount: The reference-count of the event.
> + * @flags:    The flags used when enabling the event.
> + */
> +struct ssam_nf_refcount_entry {
> +	struct rb_node node;
> +	struct ssam_nf_refcount_key key;
> +	int refcount;
> +	u8 flags;
> +};
> +
> +/**
> + * ssam_nf_refcount_inc() - Increment reference-/activation-count of the given
> + * event.
> + * @nf:  The notifier system reference.
> + * @reg: The registry used to enable/disable the event.
> + * @id:  The event ID.
> + *
> + * Increments the reference-/activation-count associated with the specified
> + * event type/ID, allocating a new entry for this event ID if necessary. A
> + * newly allocated entry will have a refcount of one.
> + *
> + * Note: Must be synchronized by the caller with regards to other
> + * ssam_nf_refcount_inc() and ssam_nf_refcount_dec() calls, e.g. via
> + * ``nf->lock``. Note that this lock should also be used to ensure the
> + * corresponding EC requests are sent, if necessary.

You write "e.g. via ``nf->lock``", are any other locking strategies used
in the other patches ?  If not then it might be good to change this to just
stating that nf->lock must be held and adding an assert for that. I would
prefer a clear set of locking rules like this over rules like:
"must be synchronized ...".

Note I am naively assuming here that it is possible to come up with such a
clear set of locking rules, I'm not sure if that is the case.

Note in case it is possible to always take nf->lock but you are not doing
so in some places because of performance concerns then I would prefer to
move to a model where the caller simply always takes nf->lock. AFAICT non
of the events/data going through the SSH are high frequency (iow
none of them occur at a high rate of see 50 times / second or more) so
I don't think that we need to focus too much on optimizing things for
speed.


> + *
> + * Return: Returns the refcount entry on success. Returns an error pointer
> + * with %-ENOSPC if there have already been %INT_MAX events of the specified
> + * ID and type registered, or %-ENOMEM if the entry could not be allocated.
> + */
> +static struct ssam_nf_refcount_entry
> +*ssam_nf_refcount_inc(struct ssam_nf *nf, struct ssam_event_registry reg,
> +		      struct ssam_event_id id)
> +{
> +	struct ssam_nf_refcount_entry *entry;
> +	struct ssam_nf_refcount_key key;
> +	struct rb_node **link = &nf->refcount.rb_node;
> +	struct rb_node *parent = NULL;
> +	int cmp;
> +
> +	key.reg = reg;
> +	key.id = id;
> +
> +	while (*link) {
> +		entry = rb_entry(*link, struct ssam_nf_refcount_entry, node);
> +		parent = *link;
> +
> +		cmp = memcmp(&key, &entry->key, sizeof(key));
> +		if (cmp < 0) {
> +			link = &(*link)->rb_left;
> +		} else if (cmp > 0) {
> +			link = &(*link)->rb_right;
> +		} else if (entry->refcount < INT_MAX) {
> +			entry->refcount++;
> +			return entry;
> +		} else {

So we hit this only if entry->refcount == INT_MAX, right?

That seems like something which should never happen, right?

So maybe add a:

			WARN_ON(1);

here?

> +			return ERR_PTR(-ENOSPC);
> +		}
> +	}
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return ERR_PTR(-ENOMEM);
> +
> +	entry->key = key;
> +	entry->refcount = 1;
> +
> +	rb_link_node(&entry->node, parent, link);
> +	rb_insert_color(&entry->node, &nf->refcount);
> +
> +	return entry;
> +}
> +
> +/**
> + * ssam_nf_refcount_dec() - Decrement reference-/activation-count of the given
> + * event.
> + * @nf:  The notifier system reference.
> + * @reg: The registry used to enable/disable the event.
> + * @id:  The event ID.
> + *
> + * Decrements the reference-/activation-count of the specified event,
> + * returning its entry. If the returned entry has a refcount of zero, the
> + * caller is responsible for freeing it using kfree().
> + *
> + * Note: Must be synchronized by the caller with regards to other
> + * ssam_nf_refcount_inc() and ssam_nf_refcount_dec() calls, e.g. via
> + * ``nf->lock``. Note that this lock should also be used to ensure the
> + * corresponding EC requests are sent, if necessary.
> + *
> + * Return: Returns the refcount entry on success or %NULL if the entry has not
> + * been found.
> + */
> +static struct ssam_nf_refcount_entry
> +*ssam_nf_refcount_dec(struct ssam_nf *nf, struct ssam_event_registry reg,
> +		      struct ssam_event_id id)
> +{
> +	struct ssam_nf_refcount_entry *entry;
> +	struct ssam_nf_refcount_key key;
> +	struct rb_node *node = nf->refcount.rb_node;
> +	int cmp;
> +
> +	key.reg = reg;
> +	key.id = id;
> +
> +	while (node) {
> +		entry = rb_entry(node, struct ssam_nf_refcount_entry, node);
> +
> +		cmp = memcmp(&key, &entry->key, sizeof(key));
> +		if (cmp < 0) {
> +			node = node->rb_left;
> +		} else if (cmp > 0) {
> +			node = node->rb_right;
> +		} else {
> +			entry->refcount--;
> +			if (entry->refcount == 0)
> +				rb_erase(&entry->node, &nf->refcount);
> +
> +			return entry;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * ssam_nf_refcount_empty() - Test if the notification system has any
> + * enabled/active events.
> + * @nf: The notification system.
> + */
> +static bool ssam_nf_refcount_empty(struct ssam_nf *nf)
> +{
> +	return RB_EMPTY_ROOT(&nf->refcount);
> +}
> +
> +/**
> + * ssam_nf_call() - Call notification callbacks for the provided event.
> + * @nf:    The notifier system
> + * @dev:   The associated device, only used for logging.
> + * @rqid:  The request ID of the event.
> + * @event: The event provided to the callbacks.
> + *
> + * Execute registered callbacks in order of their priority until either no
> + * callback is left or a callback returns a value with the %SSAM_NOTIF_STOP
> + * bit set. Note that this bit is set automatically when converting non-zero
> + * error values via ssam_notifier_from_errno() to notifier values.
> + *
> + * Also note that any callback that could handle an event should return a value
> + * with bit %SSAM_NOTIF_HANDLED set, indicating that the event does not go
> + * unhandled/ignored. In case no registered callback could handle an event,
> + * this function will emit a warning.
> + *
> + * In case a callback failed, this function will emit an error message.
> + */
> +static void ssam_nf_call(struct ssam_nf *nf, struct device *dev, u16 rqid,
> +			 struct ssam_event *event)
> +{
> +	struct ssam_nf_head *nf_head;
> +	int status, nf_ret;
> +
> +	if (!ssh_rqid_is_event(rqid)) {
> +		dev_warn(dev, "event: unsupported rqid: %#06x\n", rqid);
> +		return;
> +	}
> +
> +	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
> +	nf_ret = ssam_nfblk_call_chain(nf_head, event);
> +	status = ssam_notifier_to_errno(nf_ret);
> +
> +	if (status < 0) {
> +		dev_err(dev,
> +			"event: error handling event: %d (tc: %#04x, tid: %#04x, cid: %#04x, iid: %#04x)\n",
> +			status, event->target_category, event->target_id,
> +			event->command_id, event->instance_id);
> +	}
> +
> +	if (!(nf_ret & SSAM_NOTIF_HANDLED)) {

Maybe use "else if" here so that on an error we don't emit both the error
and the unhandled event warning ?


> +		dev_warn(dev,
> +			 "event: unhandled event (rqid: %#04x, tc: %#04x, tid: %#04x, cid: %#04x, iid: %#04x)\n",
> +			 rqid, event->target_category, event->target_id,
> +			 event->command_id, event->instance_id);
> +	}
> +}
> +
> +/**
> + * ssam_nf_init() - Initialize the notifier system.
> + * @nf: The notifier system to initialize.
> + */
> +static int ssam_nf_init(struct ssam_nf *nf)
> +{
> +	int i, status;
> +
> +	for (i = 0; i < SSH_NUM_EVENTS; i++) {
> +		status = ssam_nf_head_init(&nf->head[i]);
> +		if (status)
> +			break;
> +	}
> +
> +	if (status) {
> +		while (i--)
> +			ssam_nf_head_destroy(&nf->head[i]);
> +
> +		return status;
> +	}
> +
> +	mutex_init(&nf->lock);
> +	return 0;
> +}
> +
> +/**
> + * ssam_nf_destroy() - Deinitialize the notifier system.
> + * @nf: The notifier system to deinitialize.
> + */
> +static void ssam_nf_destroy(struct ssam_nf *nf)
> +{
> +	int i;
> +
> +	for (i = 0; i < SSH_NUM_EVENTS; i++)
> +		ssam_nf_head_destroy(&nf->head[i]);
> +
> +	mutex_destroy(&nf->lock);
> +}
> +
> +
> +/* -- Event/async request completion system. -------------------------------- */
> +
> +#define SSAM_CPLT_WQ_NAME	"ssam_cpltq"
> +
> +/*
> + * SSAM_CPLT_WQ_BATCH - Maximum number of event item completions executed per
> + * work execution. Used to prevent livelocking of the workqueue. Value chosen
> + * via educated guess, may be adjusted.
> + */
> +#define SSAM_CPLT_WQ_BATCH	10
> +
> +/**
> + * ssam_event_item_alloc() - Allocate an event item with the given payload size.
> + * @len:   The event payload length.
> + * @flags: The flags used for allocation.
> + *
> + * Allocate an event item with the given payload size. Sets the item
> + * operations and payload length values. The item free callback (``ops.free``)
> + * should not be overwritten after this call.
> + *
> + * Return: Returns the newly allocated event item.
> + */
> +static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t flags)
> +{
> +	struct ssam_event_item *item;
> +
> +	item = kzalloc(struct_size(item, event.data, len), flags);
> +	if (!item)
> +		return NULL;
> +
> +	item->event.length = len;
> +	return item;
> +}
> +
> +/**
> + * ssam_event_queue_push() - Push an event item to the event queue.
> + * @q:    The event queue.
> + * @item: The item to add.
> + */
> +static void ssam_event_queue_push(struct ssam_event_queue *q,
> +				  struct ssam_event_item *item)
> +{
> +	spin_lock(&q->lock);
> +	list_add_tail(&item->node, &q->head);
> +	spin_unlock(&q->lock);
> +}
> +
> +/**
> + * ssam_event_queue_pop() - Pop the next event item from the event queue.
> + * @q: The event queue.
> + *
> + * Returns and removes the next event item from the queue. Returns %NULL If
> + * there is no event item left.
> + */
> +static struct ssam_event_item *ssam_event_queue_pop(struct ssam_event_queue *q)
> +{
> +	struct ssam_event_item *item;
> +
> +	spin_lock(&q->lock);
> +	item = list_first_entry_or_null(&q->head, struct ssam_event_item, node);
> +	if (item)
> +		list_del(&item->node);
> +	spin_unlock(&q->lock);
> +
> +	return item;
> +}
> +
> +/**
> + * ssam_event_queue_is_empty() - Check if the event queue is empty.
> + * @q: The event queue.
> + */
> +static bool ssam_event_queue_is_empty(struct ssam_event_queue *q)
> +{
> +	bool empty;
> +
> +	spin_lock(&q->lock);
> +	empty = list_empty(&q->head);
> +	spin_unlock(&q->lock);
> +
> +	return empty;
> +}
> +
> +/**
> + * ssam_cplt_get_event_queue() - Get the event queue for the given parameters.
> + * @cplt: The completion system on which to look for the queue.
> + * @tid:  The target ID of the queue.
> + * @rqid: The request ID representing the event ID for which to get the queue.
> + *
> + * Return: Returns the event queue corresponding to the event type described
> + * by the given parameters. If the request ID does not represent an event,
> + * this function returns %NULL. If the target ID is not supported, this
> + * function will fall back to the default target ID (``tid = 1``).
> + */
> +static
> +struct ssam_event_queue *ssam_cplt_get_event_queue(struct ssam_cplt *cplt,
> +						   u8 tid, u16 rqid)
> +{
> +	u16 event = ssh_rqid_to_event(rqid);
> +	u16 tidx = ssh_tid_to_index(tid);
> +
> +	if (!ssh_rqid_is_event(rqid)) {
> +		dev_err(cplt->dev, "event: unsupported request ID: %#06x\n", rqid);
> +		return NULL;
> +	}
> +
> +	if (!ssh_tid_is_valid(tid)) {
> +		dev_warn(cplt->dev, "event: unsupported target ID: %u\n", tid);
> +		tidx = 0;
> +	}
> +
> +	return &cplt->event.target[tidx].queue[event];
> +}
> +
> +/**
> + * ssam_cplt_submit() - Submit a work item to the completion system workqueue.
> + * @cplt: The completion system.
> + * @work: The work item to submit.
> + */
> +static bool ssam_cplt_submit(struct ssam_cplt *cplt, struct work_struct *work)
> +{
> +	return queue_work(cplt->wq, work);
> +}
> +
> +/**
> + * ssam_cplt_submit_event() - Submit an event to the completion system.
> + * @cplt: The completion system.
> + * @item: The event item to submit.
> + *
> + * Submits the event to the completion system by queuing it on the event item
> + * queue and queuing the respective event queue work item on the completion
> + * workqueue, which will eventually complete the event.
> + *
> + * Return: Returns zero on success, %-EINVAL if there is no event queue that
> + * can handle the given event item.
> + */
> +static int ssam_cplt_submit_event(struct ssam_cplt *cplt,
> +				  struct ssam_event_item *item)
> +{
> +	struct ssam_event_queue *evq;
> +
> +	evq = ssam_cplt_get_event_queue(cplt, item->event.target_id, item->rqid);
> +	if (!evq)
> +		return -EINVAL;
> +
> +	ssam_event_queue_push(evq, item);
> +	ssam_cplt_submit(cplt, &evq->work);
> +	return 0;
> +}
> +
> +/**
> + * ssam_cplt_flush() - Flush the completion system.
> + * @cplt: The completion system.
> + *
> + * Flush the completion system by waiting until all currently submitted work
> + * items have been completed.
> + *
> + * Note: This function does not guarantee that all events will have been
> + * handled once this call terminates. In case of a larger number of
> + * to-be-completed events, the event queue work function may re-schedule its
> + * work item, which this flush operation will ignore.
> + *
> + * This operation is only intended to, during normal operation prior to
> + * shutdown, try to complete most events and requests to get them out of the
> + * system while the system is still fully operational. It does not aim to
> + * provide any guarantee that all of them have been handled.
> + */
> +static void ssam_cplt_flush(struct ssam_cplt *cplt)
> +{
> +	flush_workqueue(cplt->wq);
> +}
> +
> +static void ssam_event_queue_work_fn(struct work_struct *work)
> +{
> +	struct ssam_event_queue *queue;
> +	struct ssam_event_item *item;
> +	struct ssam_nf *nf;
> +	struct device *dev;
> +	unsigned int iterations = SSAM_CPLT_WQ_BATCH;
> +
> +	queue = container_of(work, struct ssam_event_queue, work);
> +	nf = &queue->cplt->event.notif;
> +	dev = queue->cplt->dev;
> +
> +	/* Limit number of processed events to avoid livelocking. */
> +	do {
> +		item = ssam_event_queue_pop(queue);
> +		if (!item)
> +			return;
> +
> +		ssam_nf_call(nf, dev, item->rqid, &item->event);
> +		kfree(item);
> +	} while (--iterations);
> +
> +	if (!ssam_event_queue_is_empty(queue))
> +		ssam_cplt_submit(queue->cplt, &queue->work);
> +}
> +
> +/**
> + * ssam_event_queue_init() - Initialize an event queue.
> + * @cplt: The completion system on which the queue resides.
> + * @evq:  The event queue to initialize.
> + */
> +static void ssam_event_queue_init(struct ssam_cplt *cplt,
> +				  struct ssam_event_queue *evq)
> +{
> +	evq->cplt = cplt;
> +	spin_lock_init(&evq->lock);
> +	INIT_LIST_HEAD(&evq->head);
> +	INIT_WORK(&evq->work, ssam_event_queue_work_fn);
> +}
> +
> +/**
> + * ssam_cplt_init() - Initialize completion system.
> + * @cplt: The completion system to initialize.
> + * @dev:  The device used for logging.
> + */
> +static int ssam_cplt_init(struct ssam_cplt *cplt, struct device *dev)
> +{
> +	struct ssam_event_target *target;
> +	int status, c, i;
> +
> +	cplt->dev = dev;
> +
> +	cplt->wq = create_workqueue(SSAM_CPLT_WQ_NAME);
> +	if (!cplt->wq)
> +		return -ENOMEM;
> +
> +	for (c = 0; c < ARRAY_SIZE(cplt->event.target); c++) {
> +		target = &cplt->event.target[c];
> +
> +		for (i = 0; i < ARRAY_SIZE(target->queue); i++)
> +			ssam_event_queue_init(cplt, &target->queue[i]);
> +	}
> +
> +	status = ssam_nf_init(&cplt->event.notif);
> +	if (status)
> +		destroy_workqueue(cplt->wq);
> +
> +	return status;
> +}
> +
> +/**
> + * ssam_cplt_destroy() - Deinitialize the completion system.
> + * @cplt: The completion system to deinitialize.
> + *
> + * Deinitialize the given completion system and ensure that all pending, i.e.
> + * yet-to-be-completed, event items and requests have been handled.
> + */
> +static void ssam_cplt_destroy(struct ssam_cplt *cplt)
> +{
> +	/*
> +	 * Note: destroy_workqueue ensures that all currently queued work will
> +	 * be fully completed and the workqueue drained. This means that this
> +	 * call will inherently also free any queued ssam_event_items, thus we
> +	 * don't have to take care of that here explicitly.
> +	 */
> +	destroy_workqueue(cplt->wq);
> +	ssam_nf_destroy(&cplt->event.notif);
> +}
> +
> +
> +/* -- Main SSAM device structures. ------------------------------------------ */
> +
> +/**
> + * ssam_controller_device() - Get the &struct device associated with this
> + * controller.
> + * @c: The controller for which to get the device.
> + *
> + * Return: Returns the &struct device associated with this controller,
> + * providing its lower-level transport.
> + */
> +struct device *ssam_controller_device(struct ssam_controller *c)
> +{
> +	return ssh_rtl_get_device(&c->rtl);
> +}
> +EXPORT_SYMBOL_GPL(ssam_controller_device);
> +
> +static void __ssam_controller_release(struct kref *kref)
> +{
> +	struct ssam_controller *ctrl = to_ssam_controller(kref, kref);
> +
> +	ssam_controller_destroy(ctrl);
> +	kfree(ctrl);
> +}
> +
> +/**
> + * ssam_controller_get() - Increment reference count of controller.
> + * @c: The controller.
> + *
> + * Return: Returns the controller provided as input.
> + */
> +struct ssam_controller *ssam_controller_get(struct ssam_controller *c)
> +{
> +	if (c)
> +		kref_get(&c->kref);
> +	return c;
> +}
> +EXPORT_SYMBOL_GPL(ssam_controller_get);
> +
> +/**
> + * ssam_controller_put() - Decrement reference count of controller.
> + * @c: The controller.
> + */
> +void ssam_controller_put(struct ssam_controller *c)
> +{
> +	if (c)
> +		kref_put(&c->kref, __ssam_controller_release);
> +}
> +EXPORT_SYMBOL_GPL(ssam_controller_put);
> +
> +/**
> + * ssam_controller_statelock() - Lock the controller against state transitions.
> + * @c: The controller to lock.
> + *
> + * Lock the controller against state transitions. Holding this lock guarantees
> + * that the controller will not transition between states, i.e. if the
> + * controller is in state "started", when this lock has been acquired, it will
> + * remain in this state at least until the lock has been released.
> + *
> + * Multiple clients may concurrently hold this lock. In other words: The
> + * ``statelock`` functions represent the read-lock part of a r/w-semaphore.
> + * Actions causing state transitions of the controller must be executed while
> + * holding the write-part of this r/w-semaphore (see ssam_controller_lock()
> + * and ssam_controller_unlock() for that).
> + *
> + * See ssam_controller_stateunlock() for the corresponding unlock function.
> + */
> +void ssam_controller_statelock(struct ssam_controller *c)
> +{
> +	down_read(&c->lock);
> +}
> +EXPORT_SYMBOL_GPL(ssam_controller_statelock);
> +
> +/**
> + * ssam_controller_stateunlock() - Unlock controller state transitions.
> + * @c: The controller to unlock.
> + *
> + * See ssam_controller_statelock() for the corresponding lock function.
> + */
> +void ssam_controller_stateunlock(struct ssam_controller *c)
> +{
> +	up_read(&c->lock);
> +}
> +EXPORT_SYMBOL_GPL(ssam_controller_stateunlock);
> +
> +/**
> + * ssam_controller_lock() - Acquire the main controller lock.
> + * @c: The controller to lock.
> + *
> + * This lock must be held for any state transitions, including transition to
> + * suspend/resumed states and during shutdown. See ssam_controller_statelock()
> + * for more details on controller locking.
> + *
> + * See ssam_controller_unlock() for the corresponding unlock function.
> + */
> +void ssam_controller_lock(struct ssam_controller *c)
> +{
> +	down_write(&c->lock);
> +}
> +
> +/*
> + * ssam_controller_unlock() - Release the main controller lock.
> + * @c: The controller to unlock.
> + *
> + * See ssam_controller_lock() for the corresponding lock function.
> + */
> +void ssam_controller_unlock(struct ssam_controller *c)
> +{
> +	up_write(&c->lock);
> +}
> +
> +static void ssam_handle_event(struct ssh_rtl *rtl,
> +			      const struct ssh_command *cmd,
> +			      const struct ssam_span *data)
> +{
> +	struct ssam_controller *ctrl = to_ssam_controller(rtl, rtl);
> +	struct ssam_event_item *item;
> +
> +	item = ssam_event_item_alloc(data->len, GFP_KERNEL);
> +	if (!item)
> +		return;
> +
> +	item->rqid = get_unaligned_le16(&cmd->rqid);
> +	item->event.target_category = cmd->tc;
> +	item->event.target_id = cmd->tid_in;
> +	item->event.command_id = cmd->cid;
> +	item->event.instance_id = cmd->iid;
> +	memcpy(&item->event.data[0], data->ptr, data->len);
> +
> +	if (WARN_ON(ssam_cplt_submit_event(&ctrl->cplt, item)))
> +		kfree(item);
> +}
> +
> +static const struct ssh_rtl_ops ssam_rtl_ops = {
> +	.handle_event = ssam_handle_event,
> +};
> +
> +static bool ssam_notifier_is_empty(struct ssam_controller *ctrl);
> +static void ssam_notifier_unregister_all(struct ssam_controller *ctrl);
> +
> +#define SSAM_SSH_DSM_REVISION	0
> +
> +/* d5e383e1-d892-4a76-89fc-f6aaae7ed5b5 */
> +static const guid_t SSAM_SSH_DSM_GUID =
> +	GUID_INIT(0xd5e383e1, 0xd892, 0x4a76,
> +		  0x89, 0xfc, 0xf6, 0xaa, 0xae, 0x7e, 0xd5, 0xb5);
> +
> +enum ssh_dsm_fn {
> +	SSH_DSM_FN_SSH_POWER_PROFILE             = 0x05,
> +	SSH_DSM_FN_SCREEN_ON_SLEEP_IDLE_TIMEOUT  = 0x06,
> +	SSH_DSM_FN_SCREEN_OFF_SLEEP_IDLE_TIMEOUT = 0x07,
> +	SSH_DSM_FN_D3_CLOSES_HANDLE              = 0x08,
> +	SSH_DSM_FN_SSH_BUFFER_SIZE               = 0x09,
> +};
> +
> +static int ssam_dsm_get_functions(acpi_handle handle, u64 *funcs)
> +{
> +	union acpi_object *obj;
> +	u64 mask = 0;
> +	int i;
> +
> +	*funcs = 0;
> +
> +	if (!acpi_has_method(handle, "_DSM"))
> +		return 0;

Is this expected on some models?

If yes then maybe add a comment.

If not then I think this can be dropped as acpi_evaluate_dsm_typed()
will then error out with -EIO which seems better then return 0
(while this is not expected).

> +
> +	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
> +				      SSAM_SSH_DSM_REVISION, 0, NULL,
> +				      ACPI_TYPE_BUFFER);
> +	if (!obj)
> +		return -EIO;
> +
> +	for (i = 0; i < obj->buffer.length && i < 8; i++)
> +		mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
> +
> +	if (mask & BIT(0))
> +		*funcs = mask;
> +
> +	ACPI_FREE(obj);
> +	return 0;
> +}
> +
> +static int ssam_dsm_load_u32(acpi_handle handle, u64 funcs, u64 func, u32 *ret)
> +{
> +	union acpi_object *obj;
> +	u64 val;
> +> +	if (!(funcs & BIT(func)))
> +		return 0;

This exit path leaves *ret uninitialized, looking at the usage if this
function I see that this is intentional, but it did stood out to me, so maybe
add a comment like this ? : 

	if (!(funcs & BIT(func)))
		return 0; /* Not supported leave *ret at its default value */

> +
> +	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
> +				      SSAM_SSH_DSM_REVISION, func, NULL,
> +				      ACPI_TYPE_INTEGER);
> +	if (!obj)
> +		return -EIO;
> +
> +	val = obj->integer.value;
> +	ACPI_FREE(obj);
> +
> +	if (val > U32_MAX)
> +		return -ERANGE;
> +
> +	*ret = val;
> +	return 0;
> +}
> +
> +/**
> + * ssam_controller_caps_load_from_acpi() - Load controller capabilities from
> + * ACPI _DSM.
> + * @handle: The handle of the ACPI controller/SSH device.
> + * @caps:   Where to store the capabilities in.
> + *
> + * Initializes the given controller capabilities with default values, then
> + * checks and, if the respective _DSM functions are available, loads the
> + * actual capabilities from the _DSM.
> + *
> + * Return: Returns zero on success, a negative error code on failure.
> + */
> +static
> +int ssam_controller_caps_load_from_acpi(acpi_handle handle,
> +					struct ssam_controller_caps *caps)
> +{
> +	u32 d3_closes_handle = false;
> +	u64 funcs;
> +	int status;
> +
> +	/* Set defaults. */
> +	caps->ssh_power_profile = U32_MAX;
> +	caps->screen_on_sleep_idle_timeout = U32_MAX;
> +	caps->screen_off_sleep_idle_timeout = U32_MAX;
> +	caps->d3_closes_handle = false;
> +	caps->ssh_buffer_size = U32_MAX;
> +
> +	/* Pre-load supported DSM functions. */
> +	status = ssam_dsm_get_functions(handle, &funcs);
> +	if (status)
> +		return status;
> +
> +	/* Load actual values from ACPI, if present. */
> +	status = ssam_dsm_load_u32(handle, funcs, SSH_DSM_FN_SSH_POWER_PROFILE,
> +				   &caps->ssh_power_profile);
> +	if (status)
> +		return status;
> +
> +	status = ssam_dsm_load_u32(handle, funcs,
> +				   SSH_DSM_FN_SCREEN_ON_SLEEP_IDLE_TIMEOUT,
> +				   &caps->screen_on_sleep_idle_timeout);
> +	if (status)
> +		return status;
> +
> +	status = ssam_dsm_load_u32(handle, funcs,
> +				   SSH_DSM_FN_SCREEN_OFF_SLEEP_IDLE_TIMEOUT,
> +				   &caps->screen_off_sleep_idle_timeout);
> +	if (status)
> +		return status;
> +
> +	status = ssam_dsm_load_u32(handle, funcs, SSH_DSM_FN_D3_CLOSES_HANDLE,
> +				   &d3_closes_handle);
> +	if (status)
> +		return status;
> +
> +	caps->d3_closes_handle = !!d3_closes_handle;
> +
> +	status = ssam_dsm_load_u32(handle, funcs, SSH_DSM_FN_SSH_BUFFER_SIZE,
> +				   &caps->ssh_buffer_size);
> +	if (status)
> +		return status;
> +
> +	return 0;
> +}
> +
> +/**
> + * ssam_controller_init() - Initialize SSAM controller.
> + * @ctrl:   The controller to initialize.
> + * @serdev: The serial device representing the underlying data transport.
> + *
> + * Initializes the given controller. Does neither start receiver nor
> + * transmitter threads. After this call, the controller has to be hooked up to
> + * the serdev core separately via &struct serdev_device_ops, relaying calls to
> + * ssam_controller_receive_buf() and ssam_controller_write_wakeup(). Once the
> + * controller has been hooked up, transmitter and receiver threads may be
> + * started via ssam_controller_start(). These setup steps need to be completed
> + * before controller can be used for requests.
> + */
> +int ssam_controller_init(struct ssam_controller *ctrl,
> +			 struct serdev_device *serdev)
> +{
> +	acpi_handle handle = ACPI_HANDLE(&serdev->dev);
> +	int status;
> +
> +	init_rwsem(&ctrl->lock);
> +	kref_init(&ctrl->kref);
> +
> +	status = ssam_controller_caps_load_from_acpi(handle, &ctrl->caps);
> +	if (status)
> +		return status;
> +
> +	dev_dbg(&serdev->dev,
> +		"device capabilities:\n"
> +		"  ssh_power_profile:             %u\n"
> +		"  ssh_buffer_size:               %u\n"
> +		"  screen_on_sleep_idle_timeout:  %u\n"
> +		"  screen_off_sleep_idle_timeout: %u\n"
> +		"  d3_closes_handle:              %u\n",
> +		ctrl->caps.ssh_power_profile,
> +		ctrl->caps.ssh_buffer_size,
> +		ctrl->caps.screen_on_sleep_idle_timeout,
> +		ctrl->caps.screen_off_sleep_idle_timeout,
> +		ctrl->caps.d3_closes_handle);
> +
> +	ssh_seq_reset(&ctrl->counter.seq);
> +	ssh_rqid_reset(&ctrl->counter.rqid);
> +
> +	/* Initialize event/request completion system. */
> +	status = ssam_cplt_init(&ctrl->cplt, &serdev->dev);
> +	if (status)
> +		return status;
> +
> +	/* Initialize request and packet transport layers. */
> +	status = ssh_rtl_init(&ctrl->rtl, serdev, &ssam_rtl_ops);
> +	if (status) {
> +		ssam_cplt_destroy(&ctrl->cplt);
> +		return status;
> +	}
> +
> +	/*
> +	 * Set state via write_once even though we expect to be in an
> +	 * exclusive context, due to smoke-testing in
> +	 * ssam_request_sync_submit().
> +	 */
> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_INITIALIZED);
> +	return 0;
> +}
> +
> +/**
> + * ssam_controller_start() - Start the receiver and transmitter threads of the
> + * controller.
> + * @ctrl: The controller.
> + *
> + * Note: When this function is called, the controller should be properly
> + * hooked up to the serdev core via &struct serdev_device_ops. Please refer
> + * to ssam_controller_init() for more details on controller initialization.
> + *
> + * This function must be called from an exclusive context with regards to the
> + * state, if necessary, by locking the controller via ssam_controller_lock().

Again you are being a bit hand-wavy (I assume you know what I mean by that)
wrt the locking requirements. If possible I would prefer clearly spelled out
locking requirements in the form of "this and that lock must be held when
calling this function". Preferably backed-up by lockdep_assert-s asserting
these conditions.

And maybe if you are a bit stricter with always holding the lock when
calling this, you can also drop the WRITE_ONCE and the comment about it
(in all places where you do this).

Note, that like my remarks around the locking docs for
ssam_nf_refcount_inc() this assumes that it is possible to come
up with such a clear set of locking rules.  If that for some reason
is not straight forwardd, then maybe add some docs documenting the
locking expectations somewhere instead ?

> + */
> +int ssam_controller_start(struct ssam_controller *ctrl)
> +{
> +	int status;
> +
> +	if (ctrl->state != SSAM_CONTROLLER_INITIALIZED)
> +		return -EINVAL;
> +
> +	status = ssh_rtl_start(&ctrl->rtl);
> +	if (status)
> +		return status;
> +
> +	/*
> +	 * Set state via write_once even though we expect to be locked/in an
> +	 * exclusive context, due to smoke-testing in
> +	 * ssam_request_sync_submit().
> +	 */
> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_STARTED);
> +	return 0;
> +}
> +
> +/*
> + * SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT - Timeout for flushing requests during
> + * shutdown.
> + *
> + * Chosen to be larger than one full request timeout, including packets timing
> + * out. This value should give ample time to complete any outstanding requests
> + * during normal operation and account for the odd package timeout.
> + */
> +#define SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT	msecs_to_jiffies(5000)
> +
> +/**
> + * ssam_controller_shutdown() - Shut down the controller.
> + * @ctrl: The controller.
> + *
> + * Shuts down the controller by flushing all pending requests and stopping the
> + * transmitter and receiver threads. All requests submitted after this call
> + * will fail with %-ESHUTDOWN. While it is discouraged to do so, this function
> + * is safe to use in parallel with ongoing request submission.
> + *
> + * In the course of this shutdown procedure, all currently registered
> + * notifiers will be unregistered. It is, however, strongly recommended to not
> + * rely on this behavior, and instead the party registering the notifier
> + * should unregister it before the controller gets shut down, e.g. via the
> + * SSAM bus which guarantees client devices to be removed before a shutdown.
> + *
> + * Note that events may still be pending after this call, but, due to the
> + * notifiers being unregistered, these events will be dropped when the
> + * controller is subsequently destroyed via ssam_controller_destroy().
> + *
> + * This function must be called from an exclusive context with regards to the
> + * state, if necessary, by locking the controller via ssam_controller_lock().

Same comment as earlier wrt the locking.

> + */
> +void ssam_controller_shutdown(struct ssam_controller *ctrl)
> +{
> +	enum ssam_controller_state s = ctrl->state;
> +	int status;
> +
> +	if (s == SSAM_CONTROLLER_UNINITIALIZED || s == SSAM_CONTROLLER_STOPPED)
> +		return;
> +
> +	/*
> +	 * Try to flush pending events and requests while everything still
> +	 * works. Note: There may still be packets and/or requests in the
> +	 * system after this call (e.g. via control packets submitted by the
> +	 * packet transport layer or flush timeout / failure, ...). Those will
> +	 * be handled with the ssh_rtl_shutdown() call below.
> +	 */
> +	status = ssh_rtl_flush(&ctrl->rtl, SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT);
> +	if (status) {
> +		ssam_err(ctrl, "failed to flush request transport layer: %d\n",
> +			 status);
> +	}
> +
> +	/* Try to flush all currently completing requests and events. */
> +	ssam_cplt_flush(&ctrl->cplt);
> +
> +	/*
> +	 * We expect all notifiers to have been removed by the respective client
> +	 * driver that set them up at this point. If this warning occurs, some
> +	 * client driver has not done that...
> +	 */
> +	WARN_ON(!ssam_notifier_is_empty(ctrl));
> +
> +	/*
> +	 * Nevertheless, we should still take care of drivers that don't behave
> +	 * well. Thus disable all enabled events, unregister all notifiers.
> +	 */
> +	ssam_notifier_unregister_all(ctrl);
> +
> +	/*
> +	 * Cancel remaining requests. Ensure no new ones can be queued and stop
> +	 * threads.
> +	 */
> +	ssh_rtl_shutdown(&ctrl->rtl);
> +
> +	/*
> +	 * Set state via write_once even though we expect to be locked/in an
> +	 * exclusive context, due to smoke-testing in
> +	 * ssam_request_sync_submit().
> +	 */
> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_STOPPED);
> +	ctrl->rtl.ptl.serdev = NULL;
> +}
> +
> +/**
> + * ssam_controller_destroy() - Destroy the controller and free its resources.
> + * @ctrl: The controller.
> + *
> + * Ensures that all resources associated with the controller get freed. This
> + * function should only be called after the controller has been stopped via
> + * ssam_controller_shutdown(). In general, this function should not be called
> + * directly. The only valid place to call this function directly is during
> + * initialization, before the controller has been fully initialized and passed
> + * to other processes. This function is called automatically when the
> + * reference count of the controller reaches zero.
> + *
> + * Must be called from an exclusive context with regards to the controller
> + * state.

Same comment as earlier wrt the locking.

> + */
> +void ssam_controller_destroy(struct ssam_controller *ctrl)
> +{
> +	if (ctrl->state == SSAM_CONTROLLER_UNINITIALIZED)
> +		return;
> +
> +	WARN_ON(ctrl->state != SSAM_CONTROLLER_STOPPED);
> +
> +	/*
> +	 * Note: New events could still have been received after the previous
> +	 * flush in ssam_controller_shutdown, before the request transport layer
> +	 * has been shut down. At this point, after the shutdown, we can be sure
> +	 * that no new events will be queued. The call to ssam_cplt_destroy will
> +	 * ensure that those remaining are being completed and freed.
> +	 */
> +
> +	/* Actually free resources. */
> +	ssam_cplt_destroy(&ctrl->cplt);
> +	ssh_rtl_destroy(&ctrl->rtl);
> +
> +	/*
> +	 * Set state via write_once even though we expect to be locked/in an
> +	 * exclusive context, due to smoke-testing in
> +	 * ssam_request_sync_submit().
> +	 */
> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_UNINITIALIZED);
> +}
> +
> +/**
> + * ssam_controller_suspend() - Suspend the controller.
> + * @ctrl: The controller to suspend.
> + *
> + * Marks the controller as suspended. Note that display-off and D0-exit
> + * notifications have to be sent manually before transitioning the controller
> + * into the suspended state via this function.
> + *
> + * See ssam_controller_resume() for the corresponding resume function.
> + *
> + * Return: Returns %-EINVAL if the controller is currently not in the
> + * "started" state.
> + */
> +int ssam_controller_suspend(struct ssam_controller *ctrl)
> +{
> +	ssam_controller_lock(ctrl);
> +
> +	if (ctrl->state != SSAM_CONTROLLER_STARTED) {
> +		ssam_controller_unlock(ctrl);
> +		return -EINVAL;
> +	}
> +
> +	ssam_dbg(ctrl, "pm: suspending controller\n");
> +
> +	/*
> +	 * Set state via write_once even though we're locked, due to
> +	 * smoke-testing in ssam_request_sync_submit().
> +	 */
> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_SUSPENDED);
> +
> +	ssam_controller_unlock(ctrl);
> +	return 0;
> +}
> +
> +/**
> + * ssam_controller_resume() - Resume the controller from suspend.
> + * @ctrl: The controller to resume.
> + *
> + * Resume the controller from the suspended state it was put into via
> + * ssam_controller_suspend(). This function does not issue display-on and
> + * D0-entry notifications. If required, those have to be sent manually after
> + * this call.
> + *
> + * Return: Returns %-EINVAL if the controller is currently not suspended.
> + */
> +int ssam_controller_resume(struct ssam_controller *ctrl)
> +{
> +	ssam_controller_lock(ctrl);
> +
> +	if (ctrl->state != SSAM_CONTROLLER_SUSPENDED) {
> +		ssam_controller_unlock(ctrl);
> +		return -EINVAL;
> +	}
> +
> +	ssam_dbg(ctrl, "pm: resuming controller\n");
> +
> +	/*
> +	 * Set state via write_once even though we're locked, due to
> +	 * smoke-testing in ssam_request_sync_submit().
> +	 */
> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_STARTED);
> +
> +	ssam_controller_unlock(ctrl);
> +	return 0;
> +}
> +
> +
> +/* -- Top-level request interface ------------------------------------------- */
> +
> +/**
> + * ssam_request_write_data() - Construct and write SAM request message to
> + * buffer.
> + * @buf:  The buffer to write the data to.
> + * @ctrl: The controller via which the request will be sent.
> + * @spec: The request data and specification.
> + *
> + * Constructs a SAM/SSH request message and writes it to the provided buffer.
> + * The request and transport counters, specifically RQID and SEQ, will be set
> + * in this call. These counters are obtained from the controller. It is thus
> + * only valid to send the resulting message via the controller specified here.
> + *
> + * For calculation of the required buffer size, refer to the
> + * SSH_COMMAND_MESSAGE_LENGTH() macro.
> + *
> + * Return: Returns the number of bytes used in the buffer on success. Returns
> + * %-EINVAL if the payload length provided in the request specification is too
> + * large (larger than %SSH_COMMAND_MAX_PAYLOAD_SIZE) or if the provided buffer
> + * is too small.
> + */
> +ssize_t ssam_request_write_data(struct ssam_span *buf,
> +				struct ssam_controller *ctrl,
> +				const struct ssam_request *spec)
> +{
> +	struct msgbuf msgb;
> +	u16 rqid;
> +	u8 seq;
> +
> +	if (spec->length > SSH_COMMAND_MAX_PAYLOAD_SIZE)
> +		return -EINVAL;
> +
> +	if (SSH_COMMAND_MESSAGE_LENGTH(spec->length) > buf->len)
> +		return -EINVAL;
> +
> +	msgb_init(&msgb, buf->ptr, buf->len);
> +	seq = ssh_seq_next(&ctrl->counter.seq);
> +	rqid = ssh_rqid_next(&ctrl->counter.rqid);
> +	msgb_push_cmd(&msgb, seq, rqid, spec);
> +
> +	return msgb_bytes_used(&msgb);
> +}
> +EXPORT_SYMBOL_GPL(ssam_request_write_data);
> +
> +static void ssam_request_sync_complete(struct ssh_request *rqst,
> +				       const struct ssh_command *cmd,
> +				       const struct ssam_span *data, int status)
> +{
> +	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
> +	struct ssam_request_sync *r;
> +
> +	r = container_of(rqst, struct ssam_request_sync, base);
> +	r->status = status;
> +
> +	if (r->resp)
> +		r->resp->length = 0;
> +
> +	if (status) {
> +		rtl_dbg_cond(rtl, "rsp: request failed: %d\n", status);
> +		return;
> +	}
> +
> +	if (!data)	/* Handle requests without a response. */
> +		return;
> +
> +	if (!r->resp || !r->resp->pointer) {
> +		if (data->len)
> +			rtl_warn(rtl, "rsp: no response buffer provided, dropping data\n");
> +		return;
> +	}
> +
> +	if (data->len > r->resp->capacity) {
> +		rtl_err(rtl,
> +			"rsp: response buffer too small, capacity: %zu bytes, got: %zu bytes\n",
> +			r->resp->capacity, data->len);
> +		r->status = -ENOSPC;
> +		return;
> +	}
> +
> +	r->resp->length = data->len;
> +	memcpy(r->resp->pointer, data->ptr, data->len);
> +}
> +
> +static void ssam_request_sync_release(struct ssh_request *rqst)
> +{
> +	complete_all(&container_of(rqst, struct ssam_request_sync, base)->comp);
> +}
> +
> +static const struct ssh_request_ops ssam_request_sync_ops = {
> +	.release = ssam_request_sync_release,
> +	.complete = ssam_request_sync_complete,
> +};
> +
> +/**
> + * ssam_request_sync_alloc() - Allocate a synchronous request.
> + * @payload_len: The length of the request payload.
> + * @flags:       Flags used for allocation.
> + * @rqst:        Where to store the pointer to the allocated request.
> + * @buffer:      Where to store the buffer descriptor for the message buffer of
> + *               the request.
> + *
> + * Allocates a synchronous request with corresponding message buffer. The
> + * request still needs to be initialized ssam_request_sync_init() before
> + * it can be submitted, and the message buffer data must still be set to the
> + * returned buffer via ssam_request_sync_set_data() after it has been filled,
> + * if need be with adjusted message length.
> + *
> + * After use, the request and its corresponding message buffer should be freed
> + * via ssam_request_sync_free(). The buffer must not be freed separately.
> + *
> + * Return: Returns zero on success, %-ENOMEM if the request could not be
> + * allocated.
> + */
> +int ssam_request_sync_alloc(size_t payload_len, gfp_t flags,
> +			    struct ssam_request_sync **rqst,
> +			    struct ssam_span *buffer)
> +{
> +	size_t msglen = SSH_COMMAND_MESSAGE_LENGTH(payload_len);
> +
> +	*rqst = kzalloc(sizeof(**rqst) + msglen, flags);
> +	if (!*rqst)
> +		return -ENOMEM;
> +
> +	buffer->ptr = (u8 *)(*rqst + 1);
> +	buffer->len = msglen;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ssam_request_sync_alloc);
> +
> +/**
> + * ssam_request_sync_free() - Free a synchronous request.
> + * @rqst: The request to be freed.
> + *
> + * Free a synchronous request and its corresponding buffer allocated with
> + * ssam_request_sync_alloc(). Do not use for requests allocated on the stack
> + * or via any other function.
> + *
> + * Warning: The caller must ensure that the request is not in use any more.
> + * I.e. the caller must ensure that it has the only reference to the request
> + * and the request is not currently pending. This means that the caller has
> + * either never submitted the request, request submission has failed, or the
> + * caller has waited until the submitted request has been completed via
> + * ssam_request_sync_wait().
> + */
> +void ssam_request_sync_free(struct ssam_request_sync *rqst)
> +{
> +	kfree(rqst);
> +}
> +EXPORT_SYMBOL_GPL(ssam_request_sync_free);
> +
> +/**
> + * ssam_request_sync_init() - Initialize a synchronous request struct.
> + * @rqst:  The request to initialize.
> + * @flags: The request flags.
> + *
> + * Initializes the given request struct. Does not initialize the request
> + * message data. This has to be done explicitly after this call via
> + * ssam_request_sync_set_data() and the actual message data has to be written
> + * via ssam_request_write_data().
> + */
> +void ssam_request_sync_init(struct ssam_request_sync *rqst,
> +			    enum ssam_request_flags flags)
> +{
> +	ssh_request_init(&rqst->base, flags, &ssam_request_sync_ops);
> +	init_completion(&rqst->comp);
> +	rqst->resp = NULL;
> +	rqst->status = 0;
> +}
> +EXPORT_SYMBOL_GPL(ssam_request_sync_init);
> +
> +/**
> + * ssam_request_sync_submit() - Submit a synchronous request.
> + * @ctrl: The controller with which to submit the request.
> + * @rqst: The request to submit.
> + *
> + * Submit a synchronous request. The request has to be initialized and
> + * properly set up, including response buffer (may be %NULL if no response is
> + * expected) and command message data. This function does not wait for the
> + * request to be completed.
> + *
> + * If this function succeeds, ssam_request_sync_wait() must be used to ensure
> + * that the request has been completed before the response data can be
> + * accessed and/or the request can be freed. On failure, the request may
> + * immediately be freed.
> + *
> + * This function may only be used if the controller is active, i.e. has been
> + * initialized and not suspended.
> + */
> +int ssam_request_sync_submit(struct ssam_controller *ctrl,
> +			     struct ssam_request_sync *rqst)
> +{
> +	int status;
> +
> +	/*
> +	 * This is only a superficial check. In general, the caller needs to
> +	 * ensure that the controller is initialized and is not (and does not
> +	 * get) suspended during use, i.e. until the request has been completed
> +	 * (if _absolutely_ necessary, by use of ssam_controller_statelock/
> +	 * ssam_controller_stateunlock, but something like ssam_client_link
> +	 * should be preferred as this needs to last until the request has been
> +	 * completed).
> +	 *
> +	 * Note that it is actually safe to use this function while the
> +	 * controller is in the process of being shut down (as ssh_rtl_submit
> +	 * is safe with regards to this), but it is generally discouraged to do
> +	 * so.
> +	 */
> +	if (WARN_ON(READ_ONCE(ctrl->state) != SSAM_CONTROLLER_STARTED)) {
> +		ssh_request_put(&rqst->base);
> +		return -ENODEV;
> +	}
> +
> +	status = ssh_rtl_submit(&ctrl->rtl, &rqst->base);
> +	ssh_request_put(&rqst->base);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(ssam_request_sync_submit);
> +
> +/**
> + * ssam_request_sync() - Execute a synchronous request.
> + * @ctrl: The controller via which the request will be submitted.
> + * @spec: The request specification and payload.
> + * @rsp:  The response buffer.
> + *
> + * Allocates a synchronous request with its message data buffer on the heap
> + * via ssam_request_sync_alloc(), fully initializes it via the provided
> + * request specification, submits it, and finally waits for its completion
> + * before freeing it and returning its status.
> + *
> + * Return: Returns the status of the request or any failure during setup.
> + */
> +int ssam_request_sync(struct ssam_controller *ctrl,
> +		      const struct ssam_request *spec,
> +		      struct ssam_response *rsp)
> +{
> +	struct ssam_request_sync *rqst;
> +	struct ssam_span buf;
> +	ssize_t len;
> +	int status;
> +
> +	status = ssam_request_sync_alloc(spec->length, GFP_KERNEL, &rqst, &buf);
> +	if (status)
> +		return status;
> +
> +	ssam_request_sync_init(rqst, spec->flags);
> +	ssam_request_sync_set_resp(rqst, rsp);
> +
> +	len = ssam_request_write_data(&buf, ctrl, spec);
> +	if (len < 0) {
> +		ssam_request_sync_free(rqst);
> +		return len;
> +	}
> +
> +	ssam_request_sync_set_data(rqst, buf.ptr, len);
> +
> +	status = ssam_request_sync_submit(ctrl, rqst);
> +	if (!status)
> +		status = ssam_request_sync_wait(rqst);
> +
> +	ssam_request_sync_free(rqst);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(ssam_request_sync);
> +
> +/**
> + * ssam_request_sync_with_buffer() - Execute a synchronous request with the
> + * provided buffer as back-end for the message buffer.
> + * @ctrl: The controller via which the request will be submitted.
> + * @spec: The request specification and payload.
> + * @rsp:  The response buffer.
> + * @buf:  The buffer for the request message data.
> + *
> + * Allocates a synchronous request struct on the stack, fully initializes it
> + * using the provided buffer as message data buffer, submits it, and then
> + * waits for its completion before returning its status. The
> + * SSH_COMMAND_MESSAGE_LENGTH() macro can be used to compute the required
> + * message buffer size.
> + *
> + * This function does essentially the same as ssam_request_sync(), but instead
> + * of dynamically allocating the request and message data buffer, it uses the
> + * provided message data buffer and stores the (small) request struct on the
> + * heap.
> + *
> + * Return: Returns the status of the request or any failure during setup.
> + */
> +int ssam_request_sync_with_buffer(struct ssam_controller *ctrl,
> +				  const struct ssam_request *spec,
> +				  struct ssam_response *rsp,
> +				  struct ssam_span *buf)
> +{
> +	struct ssam_request_sync rqst;
> +	ssize_t len;
> +	int status;
> +
> +	ssam_request_sync_init(&rqst, spec->flags);
> +	ssam_request_sync_set_resp(&rqst, rsp);
> +
> +	len = ssam_request_write_data(buf, ctrl, spec);
> +	if (len < 0)
> +		return len;
> +
> +	ssam_request_sync_set_data(&rqst, buf->ptr, len);
> +
> +	status = ssam_request_sync_submit(ctrl, &rqst);
> +	if (!status)
> +		status = ssam_request_sync_wait(&rqst);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(ssam_request_sync_with_buffer);
> +
> +
> +/* -- Internal SAM requests. ------------------------------------------------ */
> +
> +static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_get_firmware_version, __le32, {
> +	.target_category = SSAM_SSH_TC_SAM,
> +	.target_id       = 0x01,
> +	.command_id      = 0x13,
> +	.instance_id     = 0x00,
> +});
> +
> +static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_off, u8, {
> +	.target_category = SSAM_SSH_TC_SAM,
> +	.target_id       = 0x01,
> +	.command_id      = 0x15,
> +	.instance_id     = 0x00,
> +});
> +
> +static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_on, u8, {
> +	.target_category = SSAM_SSH_TC_SAM,
> +	.target_id       = 0x01,
> +	.command_id      = 0x16,
> +	.instance_id     = 0x00,
> +});
> +
> +static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_exit, u8, {
> +	.target_category = SSAM_SSH_TC_SAM,
> +	.target_id       = 0x01,
> +	.command_id      = 0x33,
> +	.instance_id     = 0x00,
> +});
> +
> +static SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_entry, u8, {
> +	.target_category = SSAM_SSH_TC_SAM,
> +	.target_id       = 0x01,
> +	.command_id      = 0x34,
> +	.instance_id     = 0x00,
> +});
> +
> +/**
> + * struct ssh_notification_params - Command payload to enable/disable SSH
> + * notifications.
> + * @target_category: The target category for which notifications should be
> + *                   enabled/disabled.
> + * @flags:           Flags determining how notifications are being sent.
> + * @request_id:      The request ID that is used to send these notifications.
> + * @instance_id:     The specific instance in the given target category for
> + *                   which notifications should be enabled.
> + */
> +struct ssh_notification_params {
> +	u8 target_category;
> +	u8 flags;
> +	__le16 request_id;
> +	u8 instance_id;
> +} __packed;
> +
> +static_assert(sizeof(struct ssh_notification_params) == 5);
> +
> +static int __ssam_ssh_event_request(struct ssam_controller *ctrl,
> +				    struct ssam_event_registry reg, u8 cid,
> +				    struct ssam_event_id id, u8 flags)
> +{
> +	struct ssh_notification_params params;
> +	struct ssam_request rqst;
> +	struct ssam_response result;
> +	int status;
> +
> +	u16 rqid = ssh_tc_to_rqid(id.target_category);
> +	u8 buf = 0;
> +
> +	/* Only allow RQIDs that lie within the event spectrum. */
> +	if (!ssh_rqid_is_event(rqid))
> +		return -EINVAL;
> +
> +	params.target_category = id.target_category;
> +	params.instance_id = id.instance;
> +	params.flags = flags;
> +	put_unaligned_le16(rqid, &params.request_id);
> +
> +	rqst.target_category = reg.target_category;
> +	rqst.target_id = reg.target_id;
> +	rqst.command_id = cid;
> +	rqst.instance_id = 0x00;
> +	rqst.flags = SSAM_REQUEST_HAS_RESPONSE;
> +	rqst.length = sizeof(params);
> +	rqst.payload = (u8 *)&params;
> +
> +	result.capacity = sizeof(buf);
> +	result.length = 0;
> +	result.pointer = &buf;
> +
> +	status = ssam_retry(ssam_request_sync_onstack, ctrl, &rqst, &result,
> +			    sizeof(params));
> +
> +	return status < 0 ? status : buf;
> +}
> +
> +/**
> + * ssam_ssh_event_enable() - Enable SSH event.
> + * @ctrl:  The controller for which to enable the event.
> + * @reg:   The event registry describing what request to use for enabling and
> + *         disabling the event.
> + * @id:    The event identifier.
> + * @flags: The event flags.
> + *
> + * Enables the specified event on the EC. This function does not manage
> + * reference counting of enabled events and is basically only a wrapper for
> + * the raw EC request. If the specified event is already enabled, the EC will
> + * ignore this request.
> + *
> + * Return: Returns the status of the executed SAM request (zero on success and
> + * negative on direct failure) or %-EPROTO if the request response indicates a
> + * failure.
> + */
> +static int ssam_ssh_event_enable(struct ssam_controller *ctrl,
> +				 struct ssam_event_registry reg,
> +				 struct ssam_event_id id, u8 flags)
> +{
> +	int status;
> +
> +	status = __ssam_ssh_event_request(ctrl, reg, reg.cid_enable, id, flags);
> +
> +	if (status < 0 && status != -EINVAL) {
> +		ssam_err(ctrl,
> +			 "failed to enable event source (tc: %#04x, iid: %#04x, reg: %#04x)\n",
> +			 id.target_category, id.instance, reg.target_category);
> +	}
> +
> +	if (status > 0) {
> +		ssam_err(ctrl,
> +			 "unexpected result while enabling event source: %#04x (tc: %#04x, iid: %#04x, reg: %#04x)\n",
> +			 status, id.target_category, id.instance, reg.target_category);
> +		return -EPROTO;
> +	}
> +
> +	return status;
> +}
> +
> +/**
> + * ssam_ssh_event_disable() - Disable SSH event.
> + * @ctrl:  The controller for which to disable the event.
> + * @reg:   The event registry describing what request to use for enabling and
> + *         disabling the event (must be same as used when enabling the event).
> + * @id:    The event identifier.
> + * @flags: The event flags (likely ignored for disabling of events).
> + *
> + * Disables the specified event on the EC. This function does not manage
> + * reference counting of enabled events and is basically only a wrapper for
> + * the raw EC request. If the specified event is already disabled, the EC will
> + * ignore this request.
> + *
> + * Return: Returns the status of the executed SAM request (zero on success and
> + * negative on direct failure) or %-EPROTO if the request response indicates a
> + * failure.
> + */
> +static int ssam_ssh_event_disable(struct ssam_controller *ctrl,
> +				  struct ssam_event_registry reg,
> +				  struct ssam_event_id id, u8 flags)
> +{
> +	int status;
> +
> +	status = __ssam_ssh_event_request(ctrl, reg, reg.cid_enable, id, flags);
> +
> +	if (status < 0 && status != -EINVAL) {
> +		ssam_err(ctrl,
> +			 "failed to disable event source (tc: %#04x, iid: %#04x, reg: %#04x)\n",
> +			 id.target_category, id.instance, reg.target_category);
> +	}
> +
> +	if (status > 0) {
> +		ssam_err(ctrl,
> +			 "unexpected result while disabling event source: %#04x (tc: %#04x, iid: %#04x, reg: %#04x)\n",
> +			 status, id.target_category, id.instance, reg.target_category);
> +		return -EPROTO;
> +	}
> +
> +	return status;
> +}
> +
> +
> +/* -- Wrappers for internal SAM requests. ----------------------------------- */
> +
> +/**
> + * ssam_get_firmware_version() - Get the SAM/EC firmware version.
> + * @ctrl:    The controller.
> + * @version: Where to store the version number.
> + *
> + * Return: Returns zero on success or the status of the executed SAM request
> + * if that request failed.
> + */
> +int ssam_get_firmware_version(struct ssam_controller *ctrl, u32 *version)
> +{
> +	__le32 __version;
> +	int status;
> +
> +	status = ssam_retry(ssam_ssh_get_firmware_version, ctrl, &__version);
> +	if (status)
> +		return status;
> +
> +	*version = le32_to_cpu(__version);
> +	return 0;
> +}
> +
> +/**
> + * ssam_ctrl_notif_display_off() - Notify EC that the display has been turned
> + * off.
> + * @ctrl: The controller.
> + *
> + * Notify the EC that the display has been turned off and the driver may enter
> + * a lower-power state. This will prevent events from being sent directly.
> + * Rather, the EC signals an event by pulling the wakeup GPIO high for as long
> + * as there are pending events. The events then need to be manually released,
> + * one by one, via the GPIO callback request. All pending events accumulated
> + * during this state can also be released by issuing the display-on
> + * notification, e.g. via ssam_ctrl_notif_display_on(), which will also reset
> + * the GPIO.
> + *
> + * On some devices, specifically ones with an integrated keyboard, the keyboard
> + * backlight will be turned off by this call.
> + *
> + * This function will only send the display-off notification command if
> + * display notifications are supported by the EC. Currently all known devices
> + * support these notifications.
> + *
> + * Use ssam_ctrl_notif_display_on() to reverse the effects of this function.
> + *
> + * Return: Returns zero on success or if no request has been executed, the
> + * status of the executed SAM request if that request failed, or %-EPROTO if
> + * an unexpected response has been received.
> + */
> +int ssam_ctrl_notif_display_off(struct ssam_controller *ctrl)
> +{
> +	int status;
> +	u8 response;
> +
> +	ssam_dbg(ctrl, "pm: notifying display off\n");
> +
> +	status = ssam_retry(ssam_ssh_notif_display_off, ctrl, &response);
> +	if (status)
> +		return status;
> +
> +	if (response != 0) {
> +		ssam_err(ctrl, "unexpected response from display-off notification: %#04x\n",
> +			 response);
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ssam_ctrl_notif_display_on() - Notify EC that the display has been turned on.
> + * @ctrl: The controller.
> + *
> + * Notify the EC that the display has been turned back on and the driver has
> + * exited its lower-power state. This notification is the counterpart to the
> + * display-off notification sent via ssam_ctrl_notif_display_off() and will
> + * reverse its effects, including resetting events to their default behavior.
> + *
> + * This function will only send the display-on notification command if display
> + * notifications are supported by the EC. Currently all known devices support
> + * these notifications.
> + *
> + * See ssam_ctrl_notif_display_off() for more details.
> + *
> + * Return: Returns zero on success or if no request has been executed, the
> + * status of the executed SAM request if that request failed, or %-EPROTO if
> + * an unexpected response has been received.
> + */
> +int ssam_ctrl_notif_display_on(struct ssam_controller *ctrl)
> +{
> +	int status;
> +	u8 response;
> +
> +	ssam_dbg(ctrl, "pm: notifying display on\n");
> +
> +	status = ssam_retry(ssam_ssh_notif_display_on, ctrl, &response);
> +	if (status)
> +		return status;
> +
> +	if (response != 0) {
> +		ssam_err(ctrl, "unexpected response from display-on notification: %#04x\n",
> +			 response);
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ssam_ctrl_notif_d0_exit() - Notify EC that the driver/device exits the D0
> + * power state.
> + * @ctrl: The controller
> + *
> + * Notifies the EC that the driver prepares to exit the D0 power state in
> + * favor of a lower-power state. Exact effects of this function related to the
> + * EC are currently unknown.
> + *
> + * This function will only send the D0-exit notification command if D0-state
> + * notifications are supported by the EC. Only newer Surface generations
> + * support these notifications.
> + *
> + * Use ssam_ctrl_notif_d0_entry() to reverse the effects of this function.
> + *
> + * Return: Returns zero on success or if no request has been executed, the
> + * status of the executed SAM request if that request failed, or %-EPROTO if
> + * an unexpected response has been received.
> + */
> +int ssam_ctrl_notif_d0_exit(struct ssam_controller *ctrl)
> +{
> +	int status;
> +	u8 response;
> +
> +	if (!ctrl->caps.d3_closes_handle)
> +		return 0;
> +
> +	ssam_dbg(ctrl, "pm: notifying D0 exit\n");
> +
> +	status = ssam_retry(ssam_ssh_notif_d0_exit, ctrl, &response);
> +	if (status)
> +		return status;
> +
> +	if (response != 0) {
> +		ssam_err(ctrl, "unexpected response from D0-exit notification: %#04x\n",
> +			 response);
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ssam_ctrl_notif_d0_entry() - Notify EC that the driver/device enters the D0
> + * power state.
> + * @ctrl: The controller
> + *
> + * Notifies the EC that the driver has exited a lower-power state and entered
> + * the D0 power state. Exact effects of this function related to the EC are
> + * currently unknown.
> + *
> + * This function will only send the D0-entry notification command if D0-state
> + * notifications are supported by the EC. Only newer Surface generations
> + * support these notifications.
> + *
> + * See ssam_ctrl_notif_d0_exit() for more details.
> + *
> + * Return: Returns zero on success or if no request has been executed, the
> + * status of the executed SAM request if that request failed, or %-EPROTO if
> + * an unexpected response has been received.
> + */
> +int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl)
> +{
> +	int status;
> +	u8 response;
> +
> +	if (!ctrl->caps.d3_closes_handle)
> +		return 0;
> +
> +	ssam_dbg(ctrl, "pm: notifying D0 entry\n");
> +
> +	status = ssam_retry(ssam_ssh_notif_d0_entry, ctrl, &response);
> +	if (status)
> +		return status;
> +
> +	if (response != 0) {
> +		ssam_err(ctrl, "unexpected response from D0-entry notification: %#04x\n",
> +			 response);
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/* -- Top-level event registry interface. ----------------------------------- */
> +
> +/**
> + * ssam_notifier_register() - Register an event notifier.
> + * @ctrl: The controller to register the notifier on.
> + * @n:    The event notifier to register.
> + *
> + * Register an event notifier and increment the usage counter of the
> + * associated SAM event. If the event was previously not enabled, it will be
> + * enabled during this call.
> + *
> + * Return: Returns zero on success, %-ENOSPC if there have already been
> + * %INT_MAX notifiers for the event ID/type associated with the notifier block
> + * registered, %-ENOMEM if the corresponding event entry could not be
> + * allocated. If this is the first time that a notifier block is registered
> + * for the specific associated event, returns the status of the event-enable
> + * EC-command.
> + */
> +int ssam_notifier_register(struct ssam_controller *ctrl,
> +			   struct ssam_event_notifier *n)
> +{
> +	u16 rqid = ssh_tc_to_rqid(n->event.id.target_category);
> +	struct ssam_nf_refcount_entry *entry;
> +	struct ssam_nf_head *nf_head;
> +	struct ssam_nf *nf;
> +	int status;
> +
> +	if (!ssh_rqid_is_event(rqid))
> +		return -EINVAL;
> +
> +	nf = &ctrl->cplt.event.notif;
> +	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
> +
> +	mutex_lock(&nf->lock);
> +
> +	entry = ssam_nf_refcount_inc(nf, n->event.reg, n->event.id);
> +	if (IS_ERR(entry)) {
> +		mutex_unlock(&nf->lock);
> +		return PTR_ERR(entry);
> +	}
> +
> +	ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
> +		 n->event.reg.target_category, n->event.id.target_category,
> +		 n->event.id.instance, entry->refcount);
> +
> +	status = ssam_nfblk_insert(nf_head, &n->base);
> +	if (status) {
> +		entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
> +		if (entry->refcount == 0)
> +			kfree(entry);
> +
> +		mutex_unlock(&nf->lock);
> +		return status;
> +	}
> +
> +	if (entry->refcount == 1) {
> +		status = ssam_ssh_event_enable(ctrl, n->event.reg, n->event.id,
> +					       n->event.flags);
> +		if (status) {
> +			ssam_nfblk_remove(&n->base);
> +			kfree(ssam_nf_refcount_dec(nf, n->event.reg, n->event.id));
> +			mutex_unlock(&nf->lock);
> +			synchronize_srcu(&nf_head->srcu);
> +			return status;
> +		}
> +
> +		entry->flags = n->event.flags;
> +
> +	} else if (entry->flags != n->event.flags) {
> +		ssam_warn(ctrl,
> +			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
> +			  n->event.flags, entry->flags, n->event.reg.target_category,
> +			  n->event.id.target_category, n->event.id.instance);
> +	}
> +
> +	mutex_unlock(&nf->lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ssam_notifier_register);
> +
> +/**
> + * ssam_notifier_unregister() - Unregister an event notifier.
> + * @ctrl: The controller the notifier has been registered on.
> + * @n:    The event notifier to unregister.
> + *
> + * Unregister an event notifier and decrement the usage counter of the
> + * associated SAM event. If the usage counter reaches zero, the event will be
> + * disabled.
> + *
> + * Return: Returns zero on success, %-ENOENT if the given notifier block has
> + * not been registered on the controller. If the given notifier block was the
> + * last one associated with its specific event, returns the status of the
> + * event-disable EC-command.
> + */
> +int ssam_notifier_unregister(struct ssam_controller *ctrl,
> +			     struct ssam_event_notifier *n)
> +{
> +	u16 rqid = ssh_tc_to_rqid(n->event.id.target_category);
> +	struct ssam_nf_refcount_entry *entry;
> +	struct ssam_nf_head *nf_head;
> +	struct ssam_nf *nf;
> +	int status = 0;
> +
> +	if (!ssh_rqid_is_event(rqid))
> +		return -EINVAL;
> +
> +	nf = &ctrl->cplt.event.notif;
> +	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
> +
> +	mutex_lock(&nf->lock);
> +
> +	if (!ssam_nfblk_find(nf_head, &n->base)) {
> +		mutex_unlock(&nf->lock);
> +		return -ENOENT;
> +	}
> +
> +	entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
> +	if (WARN_ON(!entry)) {
> +		/*
> +		 * If this does not return an entry, there's a logic error
> +		 * somewhere: The notifier block is registered, but the event
> +		 * refcount entry is not there. Remove the notifier block
> +		 * anyways.
> +		 */
> +		status = -ENOENT;
> +		goto remove;
> +	}
> +
> +	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
> +		 n->event.reg.target_category, n->event.id.target_category,
> +		 n->event.id.instance, entry->refcount);
> +
> +	if (entry->flags != n->event.flags) {
> +		ssam_warn(ctrl,
> +			  "inconsistent flags when disabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
> +			  n->event.flags, entry->flags, n->event.reg.target_category,
> +			  n->event.id.target_category, n->event.id.instance);
> +	}
> +
> +	if (entry->refcount == 0) {
> +		status = ssam_ssh_event_disable(ctrl, n->event.reg, n->event.id,
> +						n->event.flags);
> +		kfree(entry);
> +	}
> +
> +remove:
> +	ssam_nfblk_remove(&n->base);
> +	mutex_unlock(&nf->lock);
> +	synchronize_srcu(&nf_head->srcu);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(ssam_notifier_unregister);
> +
> +/**
> + * ssam_notifier_disable_registered() - Disable events for all registered
> + * notifiers.
> + * @ctrl: The controller for which to disable the notifiers/events.
> + *
> + * Disables events for all currently registered notifiers. In case of an error
> + * (EC command failing), all previously disabled events will be restored and
> + * the error code returned.
> + *
> + * This function is intended to disable all events prior to hibernation entry.
> + * See ssam_notifier_restore_registered() to restore/re-enable all events
> + * disabled with this function.
> + *
> + * Note that this function will not disable events for notifiers registered
> + * after calling this function. It should thus be made sure that no new
> + * notifiers are going to be added after this call and before the corresponding
> + * call to ssam_notifier_restore_registered().
> + *
> + * Return: Returns zero on success. In case of failure returns the error code
> + * returned by the failed EC command to disable an event.
> + */
> +int ssam_notifier_disable_registered(struct ssam_controller *ctrl)
> +{
> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
> +	struct rb_node *n;
> +	int status;
> +
> +	mutex_lock(&nf->lock);
> +	for (n = rb_first(&nf->refcount); n; n = rb_next(n)) {
> +		struct ssam_nf_refcount_entry *e;
> +
> +		e = rb_entry(n, struct ssam_nf_refcount_entry, node);
> +		status = ssam_ssh_event_disable(ctrl, e->key.reg,
> +						e->key.id, e->flags);
> +		if (status)
> +			goto err;
> +	}
> +	mutex_unlock(&nf->lock);
> +
> +	return 0;
> +
> +err:
> +	for (n = rb_prev(n); n; n = rb_prev(n)) {
> +		struct ssam_nf_refcount_entry *e;
> +
> +		e = rb_entry(n, struct ssam_nf_refcount_entry, node);
> +		ssam_ssh_event_enable(ctrl, e->key.reg, e->key.id, e->flags);
> +	}
> +	mutex_unlock(&nf->lock);
> +
> +	return status;
> +}
> +
> +/**
> + * ssam_notifier_restore_registered() - Restore/re-enable events for all
> + * registered notifiers.
> + * @ctrl: The controller for which to restore the notifiers/events.
> + *
> + * Restores/re-enables all events for which notifiers have been registered on
> + * the given controller. In case of a failure, the error is logged and the
> + * function continues to try and enable the remaining events.
> + *
> + * This function is intended to restore/re-enable all registered events after
> + * hibernation. See ssam_notifier_disable_registered() for the counter part
> + * disabling the events and more details.
> + */
> +void ssam_notifier_restore_registered(struct ssam_controller *ctrl)
> +{
> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
> +	struct rb_node *n;
> +
> +	mutex_lock(&nf->lock);
> +	for (n = rb_first(&nf->refcount); n; n = rb_next(n)) {
> +		struct ssam_nf_refcount_entry *e;
> +
> +		e = rb_entry(n, struct ssam_nf_refcount_entry, node);
> +
> +		/* Ignore errors, will get logged in call. */
> +		ssam_ssh_event_enable(ctrl, e->key.reg, e->key.id, e->flags);
> +	}
> +	mutex_unlock(&nf->lock);
> +}
> +
> +/**
> + * ssam_notifier_is_empty() - Check if there are any registered notifiers.
> + * @ctrl: The controller to check on.
> + *
> + * Return: Returns %true if there are currently no notifiers registered on the
> + * controller, %false otherwise.
> + */
> +static bool ssam_notifier_is_empty(struct ssam_controller *ctrl)
> +{
> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
> +	bool result;
> +
> +	mutex_lock(&nf->lock);
> +	result = ssam_nf_refcount_empty(nf);
> +	mutex_unlock(&nf->lock);
> +
> +	return result;
> +}
> +
> +/**
> + * ssam_notifier_unregister_all() - Unregister all currently registered
> + * notifiers.
> + * @ctrl: The controller to unregister the notifiers on.
> + *
> + * Unregisters all currently registered notifiers. This function is used to
> + * ensure that all notifiers will be unregistered and associated
> + * entries/resources freed when the controller is being shut down.
> + */
> +static void ssam_notifier_unregister_all(struct ssam_controller *ctrl)
> +{
> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
> +	struct ssam_nf_refcount_entry *e, *n;
> +
> +	mutex_lock(&nf->lock);
> +	rbtree_postorder_for_each_entry_safe(e, n, &nf->refcount, node) {
> +		/* Ignore errors, will get logged in call. */
> +		ssam_ssh_event_disable(ctrl, e->key.reg, e->key.id, e->flags);
> +		kfree(e);
> +	}
> +	nf->refcount = RB_ROOT;
> +	mutex_unlock(&nf->lock);
> +}
> +
> +
> +/* -- Wakeup IRQ. ----------------------------------------------------------- */
> +
> +static irqreturn_t ssam_irq_handle(int irq, void *dev_id)
> +{
> +	struct ssam_controller *ctrl = dev_id;
> +
> +	ssam_dbg(ctrl, "pm: wake irq triggered\n");
> +
> +	/*
> +	 * Note: Proper wakeup detection is currently unimplemented.
> +	 *       When the EC is in display-off or any other non-D0 state, it
> +	 *       does not send events/notifications to the host. Instead it
> +	 *       signals that there are events available via the wakeup IRQ.
> +	 *       This driver is responsible for calling back to the EC to
> +	 *       release these events one-by-one.
> +	 *
> +	 *       This IRQ should not cause a full system resume by its own.
> +	 *       Instead, events should be handled by their respective subsystem
> +	 *       drivers, which in turn should signal whether a full system
> +	 *       resume should be performed.
> +	 *
> +	 * TODO: Send GPIO callback command repeatedly to EC until callback
> +	 *       returns 0x00. Return flag of callback is "has more events".
> +	 *       Each time the command is sent, one event is "released". Once
> +	 *       all events have been released (return = 0x00), the GPIO is
> +	 *       re-armed. Detect wakeup events during this process, go back to
> +	 *       sleep if no wakeup event has been received.
> +	 */
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * ssam_irq_setup() - Set up SAM EC wakeup-GPIO interrupt.
> + * @ctrl: The controller for which the IRQ should be set up.
> + *
> + * Set up an IRQ for the wakeup-GPIO pin of the SAM EC. This IRQ can be used
> + * to wake the device from a low power state.
> + *
> + * Note that this IRQ can only be triggered while the EC is in the display-off
> + * state. In this state, events are not sent to the host in the usual way.
> + * Instead the wakeup-GPIO gets pulled to "high" as long as there are pending
> + * events and these events need to be released one-by-one via the GPIO
> + * callback request, either until there are no events left and the GPIO is
> + * reset, or all at once by transitioning the EC out of the display-off state,
> + * which will also clear the GPIO.
> + *
> + * Not all events, however, should trigger a full system wakeup. Instead the
> + * driver should, if necessary, inspect and forward each event to the
> + * corresponding subsystem, which in turn should decide if the system needs to
> + * be woken up. This logic has not been implemented yet, thus wakeup by this
> + * IRQ should be disabled by default to avoid spurious wake-ups, caused, for
> + * example, by the remaining battery percentage changing. Refer to comments in
> + * this function and comments in the corresponding IRQ handler for more
> + * details on how this should be implemented.
> + *
> + * See also ssam_ctrl_notif_display_off() and ssam_ctrl_notif_display_off()
> + * for functions to transition the EC into and out of the display-off state as
> + * well as more details on it.
> + *
> + * The IRQ is disabled by default and has to be enabled before it can wake up
> + * the device from suspend via ssam_irq_arm_for_wakeup(). On teardown, the IRQ
> + * should be freed via ssam_irq_free().
> + */
> +int ssam_irq_setup(struct ssam_controller *ctrl)
> +{
> +	struct device *dev = ssam_controller_device(ctrl);
> +	struct gpio_desc *gpiod;
> +	int irq;
> +	int status;
> +
> +	/*
> +	 * The actual GPIO interrupt is declared in ACPI as TRIGGER_HIGH.
> +	 * However, the GPIO line only gets reset by sending the GPIO callback
> +	 * command to SAM (or alternatively the display-on notification). As
> +	 * proper handling for this interrupt is not implemented yet, leaving
> +	 * the IRQ at TRIGGER_HIGH would cause an IRQ storm (as the callback
> +	 * never gets sent and thus the line never gets reset). To avoid this,
> +	 * mark the IRQ as TRIGGER_RISING for now, only creating a single
> +	 * interrupt, and let the SAM resume callback during the controller
> +	 * resume process clear it.
> +	 */
> +	const int irqf = IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_RISING;
> +
> +	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
> +	if (IS_ERR(gpiod))
> +		return PTR_ERR(gpiod);
> +
> +	irq = gpiod_to_irq(gpiod);
> +	gpiod_put(gpiod);
> +
> +	if (irq < 0)
> +		return irq;
> +
> +	status = request_threaded_irq(irq, NULL, ssam_irq_handle, irqf,
> +				      "ssam_wakeup", ctrl);
> +	if (status)
> +		return status;
> +
> +	ctrl->irq.num = irq;
> +	disable_irq(ctrl->irq.num);
> +	return 0;
> +}
> +
> +/**
> + * ssam_irq_free() - Free SAM EC wakeup-GPIO interrupt.
> + * @ctrl: The controller for which the IRQ should be freed.
> + *
> + * Free the wakeup-GPIO IRQ previously set-up via ssam_irq_setup().
> + */
> +void ssam_irq_free(struct ssam_controller *ctrl)
> +{
> +	free_irq(ctrl->irq.num, ctrl);
> +	ctrl->irq.num = -1;
> +}
> +
> +/**
> + * ssam_irq_arm_for_wakeup() - Arm the EC IRQ for wakeup, if enabled.
> + * @ctrl: The controller for which the IRQ should be armed.
> + *
> + * Sets up the IRQ so that it can be used to wake the device. Specifically,
> + * this function enables the irq and then, if the device is allowed to wake up
> + * the system, calls enable_irq_wake(). See ssam_irq_disarm_wakeup() for the
> + * corresponding function to disable the IRQ.
> + *
> + * This function is intended to arm the IRQ before entering S2idle suspend.
> + *
> + * Note: calls to ssam_irq_arm_for_wakeup() and ssam_irq_disarm_wakeup() must
> + * be balanced.
> + */
> +int ssam_irq_arm_for_wakeup(struct ssam_controller *ctrl)
> +{
> +	struct device *dev = ssam_controller_device(ctrl);
> +	int status;
> +
> +	enable_irq(ctrl->irq.num);
> +	if (device_may_wakeup(dev)) {
> +		status = enable_irq_wake(ctrl->irq.num);
> +		if (status) {
> +			ssam_err(ctrl, "failed to enable wake IRQ: %d\n", status);
> +			disable_irq(ctrl->irq.num);
> +			return status;
> +		}
> +
> +		ctrl->irq.wakeup_enabled = true;
> +	} else {
> +		ctrl->irq.wakeup_enabled = false;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ssam_irq_disarm_wakeup() - Disarm the wakeup IRQ.
> + * @ctrl: The controller for which the IRQ should be disarmed.
> + *
> + * Disarm the IRQ previously set up for wake via ssam_irq_arm_for_wakeup().
> + *
> + * This function is intended to disarm the IRQ after exiting S2idle suspend.
> + *
> + * Note: calls to ssam_irq_arm_for_wakeup() and ssam_irq_disarm_wakeup() must
> + * be balanced.
> + */
> +void ssam_irq_disarm_wakeup(struct ssam_controller *ctrl)
> +{
> +	int status;
> +
> +	if (ctrl->irq.wakeup_enabled) {
> +		status = disable_irq_wake(ctrl->irq.num);
> +		if (status)
> +			ssam_err(ctrl, "failed to disable wake IRQ: %d\n", status);
> +
> +		ctrl->irq.wakeup_enabled = false;
> +	}
> +	disable_irq(ctrl->irq.num);
> +}
> diff --git a/drivers/platform/surface/aggregator/controller.h b/drivers/platform/surface/aggregator/controller.h
> new file mode 100644
> index 000000000000..5ee9e966f1d7
> --- /dev/null
> +++ b/drivers/platform/surface/aggregator/controller.h
> @@ -0,0 +1,276 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Main SSAM/SSH controller structure and functionality.
> + *
> + * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#ifndef _SURFACE_AGGREGATOR_CONTROLLER_H
> +#define _SURFACE_AGGREGATOR_CONTROLLER_H
> +
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/rbtree.h>
> +#include <linux/rwsem.h>
> +#include <linux/serdev.h>
> +#include <linux/spinlock.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/surface_aggregator/controller.h>
> +#include <linux/surface_aggregator/serial_hub.h>
> +
> +#include "ssh_request_layer.h"
> +
> +
> +/* -- Safe counters. -------------------------------------------------------- */
> +
> +/**
> + * struct ssh_seq_counter - Safe counter for SSH sequence IDs.
> + * @value: The current counter value.
> + */
> +struct ssh_seq_counter {
> +	u8 value;
> +};
> +
> +/**
> + * struct ssh_rqid_counter - Safe counter for SSH request IDs.
> + * @value: The current counter value.
> + */
> +struct ssh_rqid_counter {
> +	u16 value;
> +};
> +
> +
> +/* -- Event/notification system. -------------------------------------------- */
> +
> +/**
> + * struct ssam_nf_head - Notifier head for SSAM events.
> + * @srcu: The SRCU struct for synchronization.
> + * @head: List-head for notifier blocks registered under this head.
> + */
> +struct ssam_nf_head {
> +	struct srcu_struct srcu;
> +	struct list_head head;
> +};
> +
> +/**
> + * struct ssam_nf - Notifier callback- and activation-registry for SSAM events.
> + * @lock:     Lock guarding (de-)registration of notifier blocks. Note: This
> + *            lock does not need to be held for notifier calls, only
> + *            registration and deregistration.
> + * @refcount: The root of the RB-tree used for reference-counting enabled
> + *            events/notifications.
> + * @head:     The list of notifier heads for event/notification callbacks.
> + */
> +struct ssam_nf {
> +	struct mutex lock;
> +	struct rb_root refcount;
> +	struct ssam_nf_head head[SSH_NUM_EVENTS];
> +};
> +
> +
> +/* -- Event/async request completion system. -------------------------------- */
> +
> +struct ssam_cplt;
> +
> +/**
> + * struct ssam_event_item - Struct for event queuing and completion.
> + * @node:     The node in the queue.
> + * @rqid:     The request ID of the event.
> + * @event:    Actual event data.
> + */
> +struct ssam_event_item {
> +	struct list_head node;
> +	u16 rqid;
> +
> +	struct ssam_event event;	/* must be last */
> +};
> +
> +/**
> + * struct ssam_event_queue - Queue for completing received events.
> + * @cplt: Reference to the completion system on which this queue is active.
> + * @lock: The lock for any operation on the queue.
> + * @head: The list-head of the queue.
> + * @work: The &struct work_struct performing completion work for this queue.
> + */
> +struct ssam_event_queue {
> +	struct ssam_cplt *cplt;
> +
> +	spinlock_t lock;
> +	struct list_head head;
> +	struct work_struct work;
> +};
> +
> +/**
> + * struct ssam_event_target - Set of queues for a single SSH target ID.
> + * @queue: The array of queues, one queue per event ID.
> + */
> +struct ssam_event_target {
> +	struct ssam_event_queue queue[SSH_NUM_EVENTS];
> +};
> +
> +/**
> + * struct ssam_cplt - SSAM event/async request completion system.
> + * @dev:          The device with which this system is associated. Only used
> + *                for logging.
> + * @wq:           The &struct workqueue_struct on which all completion work
> + *                items are queued.
> + * @event:        Event completion management.
> + * @event.target: Array of &struct ssam_event_target, one for each target.
> + * @event.notif:  Notifier callbacks and event activation reference counting.
> + */
> +struct ssam_cplt {
> +	struct device *dev;
> +	struct workqueue_struct *wq;
> +
> +	struct {
> +		struct ssam_event_target target[SSH_NUM_TARGETS];
> +		struct ssam_nf notif;
> +	} event;
> +};
> +
> +
> +/* -- Main SSAM device structures. ------------------------------------------ */
> +
> +/**
> + * enum ssam_controller_state - State values for &struct ssam_controller.
> + * @SSAM_CONTROLLER_UNINITIALIZED:
> + *	The controller has not been initialized yet or has been deinitialized.
> + * @SSAM_CONTROLLER_INITIALIZED:
> + *	The controller is initialized, but has not been started yet.
> + * @SSAM_CONTROLLER_STARTED:
> + *	The controller has been started and is ready to use.
> + * @SSAM_CONTROLLER_STOPPED:
> + *	The controller has been stopped.
> + * @SSAM_CONTROLLER_SUSPENDED:
> + *	The controller has been suspended.
> + */
> +enum ssam_controller_state {
> +	SSAM_CONTROLLER_UNINITIALIZED,
> +	SSAM_CONTROLLER_INITIALIZED,
> +	SSAM_CONTROLLER_STARTED,
> +	SSAM_CONTROLLER_STOPPED,
> +	SSAM_CONTROLLER_SUSPENDED,
> +};
> +
> +/**
> + * struct ssam_controller_caps - Controller device capabilities.
> + * @ssh_power_profile:             SSH power profile.
> + * @ssh_buffer_size:               SSH driver UART buffer size.
> + * @screen_on_sleep_idle_timeout:  SAM UART screen-on sleep idle timeout.
> + * @screen_off_sleep_idle_timeout: SAM UART screen-off sleep idle timeout.
> + * @d3_closes_handle:              SAM closes UART handle in D3.
> + *
> + * Controller and SSH device capabilities found in ACPI.
> + */
> +struct ssam_controller_caps {
> +	u32 ssh_power_profile;
> +	u32 ssh_buffer_size;
> +	u32 screen_on_sleep_idle_timeout;
> +	u32 screen_off_sleep_idle_timeout;
> +	u32 d3_closes_handle:1;
> +};
> +
> +/**
> + * struct ssam_controller - SSAM controller device.
> + * @kref:  Reference count of the controller.
> + * @lock:  Main lock for the controller, used to guard state changes.
> + * @state: Controller state.
> + * @rtl:   Request transport layer for SSH I/O.
> + * @cplt:  Completion system for SSH/SSAM events and asynchronous requests.
> + * @counter:      Safe SSH message ID counters.
> + * @counter.seq:  Sequence ID counter.
> + * @counter.rqid: Request ID counter.
> + * @irq:          Wakeup IRQ resources.
> + * @irq.num:      The wakeup IRQ number.
> + * @irq.wakeup_enabled: Whether wakeup by IRQ is enabled during suspend.
> + * @caps: The controller device capabilities.
> + */
> +struct ssam_controller {
> +	struct kref kref;
> +
> +	struct rw_semaphore lock;
> +	enum ssam_controller_state state;
> +
> +	struct ssh_rtl rtl;
> +	struct ssam_cplt cplt;
> +
> +	struct {
> +		struct ssh_seq_counter seq;
> +		struct ssh_rqid_counter rqid;
> +	} counter;
> +
> +	struct {
> +		int num;
> +		bool wakeup_enabled;
> +	} irq;
> +
> +	struct ssam_controller_caps caps;
> +};
> +
> +#define to_ssam_controller(ptr, member) \
> +	container_of(ptr, struct ssam_controller, member)
> +
> +#define ssam_dbg(ctrl, fmt, ...)  rtl_dbg(&(ctrl)->rtl, fmt, ##__VA_ARGS__)
> +#define ssam_info(ctrl, fmt, ...) rtl_info(&(ctrl)->rtl, fmt, ##__VA_ARGS__)
> +#define ssam_warn(ctrl, fmt, ...) rtl_warn(&(ctrl)->rtl, fmt, ##__VA_ARGS__)
> +#define ssam_err(ctrl, fmt, ...)  rtl_err(&(ctrl)->rtl, fmt, ##__VA_ARGS__)
> +
> +/**
> + * ssam_controller_receive_buf() - Provide input-data to the controller.
> + * @ctrl: The controller.
> + * @buf:  The input buffer.
> + * @n:    The number of bytes in the input buffer.
> + *
> + * Provide input data to be evaluated by the controller, which has been
> + * received via the lower-level transport.
> + *
> + * Return: Returns the number of bytes consumed, or, if the packet transport
> + * layer of the controller has been shut down, %-ESHUTDOWN.
> + */
> +static inline
> +int ssam_controller_receive_buf(struct ssam_controller *ctrl,
> +				const unsigned char *buf, size_t n)
> +{
> +	return ssh_ptl_rx_rcvbuf(&ctrl->rtl.ptl, buf, n);
> +}
> +
> +/**
> + * ssam_controller_write_wakeup() - Notify the controller that the underlying
> + * device has space available for data to be written.
> + * @ctrl: The controller.
> + */
> +static inline void ssam_controller_write_wakeup(struct ssam_controller *ctrl)
> +{
> +	ssh_ptl_tx_wakeup_transfer(&ctrl->rtl.ptl);
> +}
> +
> +int ssam_controller_init(struct ssam_controller *ctrl, struct serdev_device *s);
> +int ssam_controller_start(struct ssam_controller *ctrl);
> +void ssam_controller_shutdown(struct ssam_controller *ctrl);
> +void ssam_controller_destroy(struct ssam_controller *ctrl);
> +
> +int ssam_notifier_disable_registered(struct ssam_controller *ctrl);
> +void ssam_notifier_restore_registered(struct ssam_controller *ctrl);
> +
> +int ssam_irq_setup(struct ssam_controller *ctrl);
> +void ssam_irq_free(struct ssam_controller *ctrl);
> +int ssam_irq_arm_for_wakeup(struct ssam_controller *ctrl);
> +void ssam_irq_disarm_wakeup(struct ssam_controller *ctrl);
> +
> +void ssam_controller_lock(struct ssam_controller *c);
> +void ssam_controller_unlock(struct ssam_controller *c);
> +
> +int ssam_get_firmware_version(struct ssam_controller *ctrl, u32 *version);
> +int ssam_ctrl_notif_display_off(struct ssam_controller *ctrl);
> +int ssam_ctrl_notif_display_on(struct ssam_controller *ctrl);
> +int ssam_ctrl_notif_d0_exit(struct ssam_controller *ctrl);
> +int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl);
> +
> +int ssam_controller_suspend(struct ssam_controller *ctrl);
> +int ssam_controller_resume(struct ssam_controller *ctrl);
> +
> +#endif /* _SURFACE_AGGREGATOR_CONTROLLER_H */
> diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
> new file mode 100644
> index 000000000000..ec6c7f40ad36
> --- /dev/null
> +++ b/drivers/platform/surface/aggregator/core.c
> @@ -0,0 +1,781 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Surface Serial Hub (SSH) driver for communication with the Surface/System
> + * Aggregator Module (SSAM/SAM).
> + *
> + * Provides access to a SAM-over-SSH connected EC via a controller device.
> + * Handles communication via requests as well as enabling, disabling, and
> + * relaying of events.
> + *
> + * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/atomic.h>
> +#include <linux/completion.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/kref.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/serdev.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/surface_aggregator/controller.h>
> +#include "controller.h"
> +
> +
> +/* -- Static controller reference. ------------------------------------------ */
> +
> +/*
> + * Main controller reference. The corresponding lock must be held while
> + * accessing (reading/writing) the reference.
> + */
> +static struct ssam_controller *__ssam_controller;
> +static DEFINE_SPINLOCK(__ssam_controller_lock);
> +
> +/**
> + * ssam_get_controller() - Get reference to SSAM controller.
> + *
> + * Returns a reference to the SSAM controller of the system or %NULL if there
> + * is none, it hasn't been set up yet, or it has already been unregistered.
> + * This function automatically increments the reference count of the
> + * controller, thus the calling party must ensure that ssam_controller_put()
> + * is called when it doesn't need the controller any more.
> + */
> +struct ssam_controller *ssam_get_controller(void)
> +{
> +	struct ssam_controller *ctrl;
> +
> +	spin_lock(&__ssam_controller_lock);
> +
> +	ctrl = __ssam_controller;
> +	if (!ctrl)
> +		goto out;
> +
> +	if (WARN_ON(!kref_get_unless_zero(&ctrl->kref)))
> +		ctrl = NULL;
> +
> +out:
> +	spin_unlock(&__ssam_controller_lock);
> +	return ctrl;
> +}
> +EXPORT_SYMBOL_GPL(ssam_get_controller);
> +
> +/**
> + * ssam_try_set_controller() - Try to set the main controller reference.
> + * @ctrl: The controller to which the reference should point.
> + *
> + * Set the main controller reference to the given pointer if the reference
> + * hasn't been set already.
> + *
> + * Return: Returns zero on success or %-EEXIST if the reference has already
> + * been set.
> + */
> +static int ssam_try_set_controller(struct ssam_controller *ctrl)
> +{
> +	int status = 0;
> +
> +	spin_lock(&__ssam_controller_lock);
> +	if (!__ssam_controller)
> +		__ssam_controller = ctrl;
> +	else
> +		status = -EEXIST;
> +	spin_unlock(&__ssam_controller_lock);
> +
> +	return status;
> +}
> +
> +/**
> + * ssam_clear_controller() - Remove/clear the main controller reference.
> + *
> + * Clears the main controller reference, i.e. sets it to %NULL. This function
> + * should be called before the controller is shut down.
> + */
> +static void ssam_clear_controller(void)
> +{
> +	spin_lock(&__ssam_controller_lock);
> +	__ssam_controller = NULL;
> +	spin_unlock(&__ssam_controller_lock);
> +}
> +
> +/**
> + * ssam_client_link() - Link an arbitrary client device to the controller.
> + * @c: The controller to link to.
> + * @client: The client device.
> + *
> + * Link an arbitrary client device to the controller by creating a device link
> + * between it as consumer and the controller device as provider. This function
> + * can be used for non-SSAM devices (or SSAM devices not registered as child
> + * under the controller) to guarantee that the controller is valid for as long
> + * as the driver of the client device is bound, and that proper suspend and
> + * resume ordering is guaranteed.
> + *
> + * The device link does not have to be destructed manually. It is removed
> + * automatically once the driver of the client device unbinds.
> + *
> + * Return: Returns zero on success, %-ENODEV if the controller is not ready or
> + * going to be removed soon, or %-ENOMEM if the device link could not be
> + * created for other reasons.
> + */
> +int ssam_client_link(struct ssam_controller *c, struct device *client)
> +{
> +	const u32 flags = DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
> +	struct device_link *link;
> +	struct device *ctrldev;
> +
> +	ssam_controller_statelock(c);
> +
> +	if (c->state != SSAM_CONTROLLER_STARTED) {
> +		ssam_controller_stateunlock(c);
> +		return -ENODEV;
> +	}
> +
> +	ctrldev = ssam_controller_device(c);
> +	if (!ctrldev) {
> +		ssam_controller_stateunlock(c);
> +		return -ENODEV;
> +	}
> +
> +	link = device_link_add(client, ctrldev, flags);
> +	if (!link) {
> +		ssam_controller_stateunlock(c);
> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * Return -ENODEV if supplier driver is on its way to be removed. In
> +	 * this case, the controller won't be around for much longer and the
> +	 * device link is not going to save us any more, as unbinding is
> +	 * already in progress.
> +	 */
> +	if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND) {
> +		ssam_controller_stateunlock(c);
> +		return -ENODEV;
> +	}
> +
> +	ssam_controller_stateunlock(c);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ssam_client_link);
> +
> +/**
> + * ssam_client_bind() - Bind an arbitrary client device to the controller.
> + * @client: The client device.
> + *
> + * Link an arbitrary client device to the controller by creating a device link
> + * between it as consumer and the main controller device as provider. This
> + * function can be used for non-SSAM devices to guarantee that the controller
> + * returned by this function is valid for as long as the driver of the client
> + * device is bound, and that proper suspend and resume ordering is guaranteed.
> + *
> + * This function does essentially the same as ssam_client_link(), except that
> + * it first fetches the main controller reference, then creates the link, and
> + * finally returns this reference. Note that this function does not increment
> + * the reference counter of the controller, as, due to the link, the
> + * controller lifetime is assured as long as the driver of the client device
> + * is bound.
> + *
> + * It is not valid to use the controller reference obtained by this method
> + * outside of the driver bound to the client device at the time of calling
> + * this function, without first incrementing the reference count of the
> + * controller via ssam_controller_get(). Even after doing this, care must be
> + * taken that requests are only submitted and notifiers are only
> + * (un-)registered when the controller is active and not suspended. In other
> + * words: The device link only lives as long as the client driver is bound and
> + * any guarantees enforced by this link (e.g. active controller state) can
> + * only be relied upon as long as this link exists and may need to be enforced
> + * in other ways afterwards.
> + *
> + * The created device link does not have to be destructed manually. It is
> + * removed automatically once the driver of the client device unbinds.
> + *
> + * Return: Returns the controller on success, an error pointer with %-ENODEV
> + * if the controller is not present, not ready or going to be removed soon, or
> + * %-ENOMEM if the device link could not be created for other reasons.
> + */
> +struct ssam_controller *ssam_client_bind(struct device *client)
> +{
> +	struct ssam_controller *c;
> +	int status;
> +
> +	c = ssam_get_controller();
> +	if (!c)
> +		return ERR_PTR(-ENODEV);
> +
> +	status = ssam_client_link(c, client);
> +
> +	/*
> +	 * Note that we can drop our controller reference in both success and
> +	 * failure cases: On success, we have bound the controller lifetime
> +	 * inherently to the client driver lifetime, i.e. it the controller is
> +	 * now guaranteed to outlive the client driver. On failure, we're not
> +	 * going to use the controller any more.
> +	 */
> +	ssam_controller_put(c);
> +
> +	return status >= 0 ? c : ERR_PTR(status);
> +}
> +EXPORT_SYMBOL_GPL(ssam_client_bind);
> +
> +
> +/* -- Glue layer (serdev_device -> ssam_controller). ------------------------ */
> +
> +static int ssam_receive_buf(struct serdev_device *dev, const unsigned char *buf,
> +			    size_t n)
> +{
> +	struct ssam_controller *ctrl;
> +
> +	ctrl = serdev_device_get_drvdata(dev);
> +	return ssam_controller_receive_buf(ctrl, buf, n);
> +}
> +
> +static void ssam_write_wakeup(struct serdev_device *dev)
> +{
> +	ssam_controller_write_wakeup(serdev_device_get_drvdata(dev));
> +}
> +
> +static const struct serdev_device_ops ssam_serdev_ops = {
> +	.receive_buf = ssam_receive_buf,
> +	.write_wakeup = ssam_write_wakeup,
> +};
> +
> +
> +/* -- SysFS and misc. ------------------------------------------------------- */
> +
> +static int ssam_log_firmware_version(struct ssam_controller *ctrl)
> +{
> +	u32 version, a, b, c;
> +	int status;
> +
> +	status = ssam_get_firmware_version(ctrl, &version);
> +	if (status)
> +		return status;
> +
> +	a = (version >> 24) & 0xff;
> +	b = ((version >> 8) & 0xffff);
> +	c = version & 0xff;
> +
> +	ssam_info(ctrl, "SAM firmware version: %u.%u.%u\n", a, b, c);
> +	return 0;
> +}
> +
> +static ssize_t firmware_version_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct ssam_controller *ctrl = dev_get_drvdata(dev);
> +	u32 version, a, b, c;
> +	int status;
> +
> +	status = ssam_get_firmware_version(ctrl, &version);
> +	if (status < 0)
> +		return status;
> +
> +	a = (version >> 24) & 0xff;
> +	b = ((version >> 8) & 0xffff);
> +	c = version & 0xff;
> +
> +	return sysfs_emit(buf, "%u.%u.%u\n", a, b, c);
> +}
> +static DEVICE_ATTR_RO(firmware_version);
> +
> +static struct attribute *ssam_sam_attrs[] = {
> +	&dev_attr_firmware_version.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ssam_sam_group = {
> +	.name = "sam",
> +	.attrs = ssam_sam_attrs,
> +};
> +
> +
> +/* -- ACPI based device setup. ---------------------------------------------- */
> +
> +static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
> +						  void *ctx)
> +{
> +	struct serdev_device *serdev = ctx;
> +	struct acpi_resource_common_serialbus *serial;
> +	struct acpi_resource_uart_serialbus *uart;
> +	bool flow_control;
> +	int status = 0;
> +
> +	if (rsc->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return AE_OK;
> +
> +	serial = &rsc->data.common_serial_bus;
> +	if (serial->type != ACPI_RESOURCE_SERIAL_TYPE_UART)
> +		return AE_OK;
> +
> +	uart = &rsc->data.uart_serial_bus;
> +
> +	/* Set up serdev device. */
> +	serdev_device_set_baudrate(serdev, uart->default_baud_rate);
> +
> +	/* serdev currently only supports RTSCTS flow control. */
> +	if (uart->flow_control & (~((u8)ACPI_UART_FLOW_CONTROL_HW))) {
> +		dev_warn(&serdev->dev, "setup: unsupported flow control (value: %#04x)\n",
> +			 uart->flow_control);
> +	}
> +
> +	/* Set RTSCTS flow control. */
> +	flow_control = uart->flow_control & ACPI_UART_FLOW_CONTROL_HW;
> +	serdev_device_set_flow_control(serdev, flow_control);
> +
> +	/* serdev currently only supports EVEN/ODD parity. */
> +	switch (uart->parity) {
> +	case ACPI_UART_PARITY_NONE:
> +		status = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +		break;
> +	case ACPI_UART_PARITY_EVEN:
> +		status = serdev_device_set_parity(serdev, SERDEV_PARITY_EVEN);
> +		break;
> +	case ACPI_UART_PARITY_ODD:
> +		status = serdev_device_set_parity(serdev, SERDEV_PARITY_ODD);
> +		break;
> +	default:
> +		dev_warn(&serdev->dev, "setup: unsupported parity (value: %#04x)\n",
> +			 uart->parity);
> +		break;
> +	}
> +
> +	if (status) {
> +		dev_err(&serdev->dev, "setup: failed to set parity (value: %#04x, error: %d)\n",
> +			uart->parity, status);
> +		return AE_ERROR;
> +	}
> +
> +	/* We've found the resource and are done. */
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static acpi_status ssam_serdev_setup_via_acpi(acpi_handle handle,
> +					      struct serdev_device *serdev)
> +{
> +	return acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				   ssam_serdev_setup_via_acpi_crs, serdev);
> +}
> +
> +
> +/* -- Power management. ----------------------------------------------------- */
> +
> +static void ssam_serial_hub_shutdown(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	/*
> +	 * Try to disable notifiers, signal display-off and D0-exit, ignore any
> +	 * errors.
> +	 *
> +	 * Note: It has not been established yet if this is actually
> +	 * necessary/useful for shutdown.
> +	 */
> +
> +	status = ssam_notifier_disable_registered(c);
> +	if (status) {
> +		ssam_err(c, "pm: failed to disable notifiers for shutdown: %d\n",
> +			 status);
> +	}
> +
> +	status = ssam_ctrl_notif_display_off(c);
> +	if (status)
> +		ssam_err(c, "pm: display-off notification failed: %d\n", status);
> +
> +	status = ssam_ctrl_notif_d0_exit(c);
> +	if (status)
> +		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int ssam_serial_hub_pm_prepare(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	/*
> +	 * Try to signal display-off, This will quiesce events.
> +	 *
> +	 * Note: Signaling display-off/display-on should normally be done from
> +	 * some sort of display state notifier. As that is not available,
> +	 * signal it here.
> +	 */
> +
> +	status = ssam_ctrl_notif_display_off(c);
> +	if (status)
> +		ssam_err(c, "pm: display-off notification failed: %d\n", status);
> +
> +	return status;
> +}
> +
> +static void ssam_serial_hub_pm_complete(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	/*
> +	 * Try to signal display-on. This will restore events.
> +	 *
> +	 * Note: Signaling display-off/display-on should normally be done from
> +	 * some sort of display state notifier. As that is not available,
> +	 * signal it here.
> +	 */
> +
> +	status = ssam_ctrl_notif_display_on(c);
> +	if (status)
> +		ssam_err(c, "pm: display-on notification failed: %d\n", status);
> +}
> +
> +static int ssam_serial_hub_pm_suspend(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	/*
> +	 * Try to signal D0-exit, enable IRQ wakeup if specified. Abort on
> +	 * error.
> +	 */
> +
> +	status = ssam_ctrl_notif_d0_exit(c);
> +	if (status) {
> +		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
> +		goto err_notif;
> +	}
> +
> +	status = ssam_irq_arm_for_wakeup(c);
> +	if (status)
> +		goto err_irq;
> +
> +	WARN_ON(ssam_controller_suspend(c));
> +	return 0;
> +
> +err_irq:
> +	ssam_ctrl_notif_d0_entry(c);
> +err_notif:
> +	ssam_ctrl_notif_display_on(c);
> +	return status;
> +}
> +
> +static int ssam_serial_hub_pm_resume(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	WARN_ON(ssam_controller_resume(c));
> +
> +	/*
> +	 * Try to disable IRQ wakeup (if specified) and signal D0-entry. In
> +	 * case of errors, log them and try to restore normal operation state
> +	 * as far as possible.
> +	 *
> +	 * Note: Signaling display-off/display-on should normally be done from
> +	 * some sort of display state notifier. As that is not available,
> +	 * signal it here.
> +	 */
> +
> +	ssam_irq_disarm_wakeup(c);
> +
> +	status = ssam_ctrl_notif_d0_entry(c);
> +	if (status)
> +		ssam_err(c, "pm: D0-entry notification failed: %d\n", status);
> +
> +	return 0;
> +}
> +
> +static int ssam_serial_hub_pm_freeze(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	/*
> +	 * During hibernation image creation, we only have to ensure that the
> +	 * EC doesn't send us any events. This is done via the display-off
> +	 * and D0-exit notifications. Note that this sets up the wakeup IRQ
> +	 * on the EC side, however, we have disabled it by default on our side
> +	 * and won't enable it here.
> +	 *
> +	 * See ssam_serial_hub_poweroff() for more details on the hibernation
> +	 * process.
> +	 */
> +
> +	status = ssam_ctrl_notif_d0_exit(c);
> +	if (status) {
> +		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
> +		ssam_ctrl_notif_display_on(c);
> +		return status;
> +	}
> +
> +	WARN_ON(ssam_controller_suspend(c));
> +	return 0;
> +}
> +
> +static int ssam_serial_hub_pm_thaw(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	WARN_ON(ssam_controller_resume(c));
> +
> +	status = ssam_ctrl_notif_d0_entry(c);
> +	if (status)
> +		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
> +
> +	return status;
> +}
> +
> +static int ssam_serial_hub_pm_poweroff(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	/*
> +	 * When entering hibernation and powering off the system, the EC, at
> +	 * least on some models, may disable events. Without us taking care of
> +	 * that, this leads to events not being enabled/restored when the
> +	 * system resumes from hibernation, resulting SAM-HID subsystem devices
> +	 * (i.e. keyboard, touchpad) not working, AC-plug/AC-unplug events being
> +	 * gone, etc.
> +	 *
> +	 * To avoid these issues, we disable all registered events here (this is
> +	 * likely not actually required) and restore them during the drivers PM
> +	 * restore callback.
> +	 *
> +	 * Wakeup from the EC interrupt is not supported during hibernation,
> +	 * so don't arm the IRQ here.
> +	 */
> +
> +	status = ssam_notifier_disable_registered(c);
> +	if (status) {
> +		ssam_err(c, "pm: failed to disable notifiers for hibernation: %d\n",
> +			 status);
> +		return status;
> +	}
> +
> +	status = ssam_ctrl_notif_d0_exit(c);
> +	if (status) {
> +		ssam_err(c, "pm: D0-exit notification failed: %d\n", status);
> +		ssam_notifier_restore_registered(c);
> +		return status;
> +	}
> +
> +	WARN_ON(ssam_controller_suspend(c));
> +	return 0;
> +}
> +
> +static int ssam_serial_hub_pm_restore(struct device *dev)
> +{
> +	struct ssam_controller *c = dev_get_drvdata(dev);
> +	int status;
> +
> +	/*
> +	 * Ignore but log errors, try to restore state as much as possible in
> +	 * case of failures. See ssam_serial_hub_poweroff() for more details on
> +	 * the hibernation process.
> +	 */
> +
> +	WARN_ON(ssam_controller_resume(c));
> +
> +	status = ssam_ctrl_notif_d0_entry(c);
> +	if (status)
> +		ssam_err(c, "pm: D0-entry notification failed: %d\n", status);
> +
> +	ssam_notifier_restore_registered(c);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ssam_serial_hub_pm_ops = {
> +	.prepare  = ssam_serial_hub_pm_prepare,
> +	.complete = ssam_serial_hub_pm_complete,
> +	.suspend  = ssam_serial_hub_pm_suspend,
> +	.resume   = ssam_serial_hub_pm_resume,
> +	.freeze   = ssam_serial_hub_pm_freeze,
> +	.thaw     = ssam_serial_hub_pm_thaw,
> +	.poweroff = ssam_serial_hub_pm_poweroff,
> +	.restore  = ssam_serial_hub_pm_restore,
> +};
> +
> +#else /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops ssam_serial_hub_pm_ops = { };
> +
> +#endif /* CONFIG_PM_SLEEP */
> +
> +
> +/* -- Device/driver setup. -------------------------------------------------- */
> +
> +static const struct acpi_gpio_params gpio_ssam_wakeup_int = { 0, 0, false };
> +static const struct acpi_gpio_params gpio_ssam_wakeup     = { 1, 0, false };
> +
> +static const struct acpi_gpio_mapping ssam_acpi_gpios[] = {
> +	{ "ssam_wakeup-int-gpio", &gpio_ssam_wakeup_int, 1 },
> +	{ "ssam_wakeup-gpio",     &gpio_ssam_wakeup,     1 },
> +	{ },
> +};
> +
> +static int ssam_serial_hub_probe(struct serdev_device *serdev)
> +{
> +	struct ssam_controller *ctrl;
> +	acpi_handle *ssh = ACPI_HANDLE(&serdev->dev);
> +	acpi_status astatus;
> +	int status;
> +
> +	if (gpiod_count(&serdev->dev, NULL) < 0)
> +		return -ENODEV;
> +
> +	status = devm_acpi_dev_add_driver_gpios(&serdev->dev, ssam_acpi_gpios);
> +	if (status)
> +		return status;
> +
> +	/* Allocate controller. */
> +	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	/* Initialize controller. */
> +	status = ssam_controller_init(ctrl, serdev);
> +	if (status)
> +		goto err_ctrl_init;
> +
> +	/* Set up serdev device. */
> +	serdev_device_set_drvdata(serdev, ctrl);
> +	serdev_device_set_client_ops(serdev, &ssam_serdev_ops);
> +	status = serdev_device_open(serdev);
> +	if (status)
> +		goto err_devopen;
> +
> +	astatus = ssam_serdev_setup_via_acpi(ssh, serdev);
> +	if (ACPI_FAILURE(astatus)) {
> +		status = -ENXIO;
> +		goto err_devinit;
> +	}
> +
> +	/* Start controller. */
> +	status = ssam_controller_start(ctrl);
> +	if (status)
> +		goto err_devinit;
> +
> +	/*
> +	 * Initial SAM requests: Log version and notify default/init power
> +	 * states.
> +	 */
> +	status = ssam_log_firmware_version(ctrl);
> +	if (status)
> +		goto err_initrq;
> +
> +	status = ssam_ctrl_notif_d0_entry(ctrl);
> +	if (status)
> +		goto err_initrq;
> +
> +	status = ssam_ctrl_notif_display_on(ctrl);
> +	if (status)
> +		goto err_initrq;
> +
> +	status = sysfs_create_group(&serdev->dev.kobj, &ssam_sam_group);
> +	if (status)
> +		goto err_initrq;
> +
> +	/* Set up IRQ. */
> +	status = ssam_irq_setup(ctrl);
> +	if (status)
> +		goto err_irq;
> +
> +	/* Finally, set main controller reference. */
> +	status = ssam_try_set_controller(ctrl);
> +	if (WARN_ON(status))	/* Currently, we're the only provider. */
> +		goto err_mainref;
> +
> +	/*
> +	 * TODO: The EC can wake up the system via the associated GPIO interrupt
> +	 *       in multiple situations. One of which is the remaining battery
> +	 *       capacity falling below a certain threshold. Normally, we should
> +	 *       use the device_init_wakeup function, however, the EC also seems
> +	 *       to have other reasons for waking up the system and it seems
> +	 *       that Windows has additional checks whether the system should be
> +	 *       resumed. In short, this causes some spurious unwanted wake-ups.
> +	 *       For now let's thus default power/wakeup to false.
> +	 */
> +	device_set_wakeup_capable(&serdev->dev, true);
> +	acpi_walk_dep_device_list(ssh);
> +
> +	return 0;
> +
> +err_mainref:
> +	ssam_irq_free(ctrl);
> +err_irq:
> +	sysfs_remove_group(&serdev->dev.kobj, &ssam_sam_group);
> +err_initrq:
> +	ssam_controller_shutdown(ctrl);
> +err_devinit:
> +	serdev_device_close(serdev);
> +err_devopen:
> +	ssam_controller_destroy(ctrl);
> +err_ctrl_init:
> +	kfree(ctrl);
> +	return status;
> +}
> +
> +static void ssam_serial_hub_remove(struct serdev_device *serdev)
> +{
> +	struct ssam_controller *ctrl = serdev_device_get_drvdata(serdev);
> +	int status;
> +
> +	/* Clear static reference so that no one else can get a new one. */
> +	ssam_clear_controller();
> +
> +	/* Disable and free IRQ. */
> +	ssam_irq_free(ctrl);
> +
> +	sysfs_remove_group(&serdev->dev.kobj, &ssam_sam_group);
> +	ssam_controller_lock(ctrl);
> +
> +	/* Act as if suspending to silence events. */
> +	status = ssam_ctrl_notif_display_off(ctrl);
> +	if (status) {
> +		dev_err(&serdev->dev, "display-off notification failed: %d\n",
> +			status);
> +	}
> +
> +	status = ssam_ctrl_notif_d0_exit(ctrl);
> +	if (status) {
> +		dev_err(&serdev->dev, "D0-exit notification failed: %d\n",
> +			status);
> +	}
> +
> +	/* Shut down controller and remove serdev device reference from it. */
> +	ssam_controller_shutdown(ctrl);
> +
> +	/* Shut down actual transport. */
> +	serdev_device_wait_until_sent(serdev, 0);
> +	serdev_device_close(serdev);
> +
> +	/* Drop our controller reference. */
> +	ssam_controller_unlock(ctrl);
> +	ssam_controller_put(ctrl);
> +
> +	device_set_wakeup_capable(&serdev->dev, false);
> +}
> +
> +static const struct acpi_device_id ssam_serial_hub_match[] = {
> +	{ "MSHW0084", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ssam_serial_hub_match);
> +
> +static struct serdev_device_driver ssam_serial_hub = {
> +	.probe = ssam_serial_hub_probe,
> +	.remove = ssam_serial_hub_remove,
> +	.driver = {
> +		.name = "surface_serial_hub",
> +		.acpi_match_table = ssam_serial_hub_match,
> +		.pm = &ssam_serial_hub_pm_ops,
> +		.shutdown = ssam_serial_hub_shutdown,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_serdev_device_driver(ssam_serial_hub);
> +
> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
> +MODULE_DESCRIPTION("Subsystem and Surface Serial Hub driver for Surface System Aggregator Module");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/surface/aggregator/ssh_msgb.h b/drivers/platform/surface/aggregator/ssh_msgb.h
> new file mode 100644
> index 000000000000..1221f642dda1
> --- /dev/null
> +++ b/drivers/platform/surface/aggregator/ssh_msgb.h
> @@ -0,0 +1,205 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * SSH message builder functions.
> + *
> + * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#ifndef _SURFACE_AGGREGATOR_SSH_MSGB_H
> +#define _SURFACE_AGGREGATOR_SSH_MSGB_H
> +
> +#include <asm/unaligned.h>
> +#include <linux/types.h>
> +
> +#include <linux/surface_aggregator/controller.h>
> +#include <linux/surface_aggregator/serial_hub.h>
> +
> +/**
> + * struct msgbuf - Buffer struct to construct SSH messages.
> + * @begin: Pointer to the beginning of the allocated buffer space.
> + * @end:   Pointer to the end (one past last element) of the allocated buffer
> + *         space.
> + * @ptr:   Pointer to the first free element in the buffer.
> + */
> +struct msgbuf {
> +	u8 *begin;
> +	u8 *end;
> +	u8 *ptr;
> +};
> +
> +/**
> + * msgb_init() - Initialize the given message buffer struct.
> + * @msgb: The buffer struct to initialize
> + * @ptr:  Pointer to the underlying memory by which the buffer will be backed.
> + * @cap:  Size of the underlying memory.
> + *
> + * Initialize the given message buffer struct using the provided memory as
> + * backing.
> + */
> +static inline void msgb_init(struct msgbuf *msgb, u8 *ptr, size_t cap)
> +{
> +	msgb->begin = ptr;
> +	msgb->end = ptr + cap;
> +	msgb->ptr = ptr;
> +}
> +
> +/**
> + * msgb_bytes_used() - Return the current number of bytes used in the buffer.
> + * @msgb: The message buffer.
> + */
> +static inline size_t msgb_bytes_used(const struct msgbuf *msgb)
> +{
> +	return msgb->ptr - msgb->begin;
> +}
> +
> +static inline void __msgb_push_u8(struct msgbuf *msgb, u8 value)
> +{
> +	*msgb->ptr = value;
> +	msgb->ptr += sizeof(u8);
> +}
> +
> +static inline void __msgb_push_u16(struct msgbuf *msgb, u16 value)
> +{
> +	put_unaligned_le16(value, msgb->ptr);
> +	msgb->ptr += sizeof(u16);
> +}
> +
> +/**
> + * msgb_push_u16() - Push a u16 value to the buffer.
> + * @msgb:  The message buffer.
> + * @value: The value to push to the buffer.
> + */
> +static inline void msgb_push_u16(struct msgbuf *msgb, u16 value)
> +{
> +	if (WARN_ON(msgb->ptr + sizeof(u16) > msgb->end))
> +		return;
> +
> +	__msgb_push_u16(msgb, value);
> +}
> +
> +/**
> + * msgb_push_syn() - Push SSH SYN bytes to the buffer.
> + * @msgb: The message buffer.
> + */
> +static inline void msgb_push_syn(struct msgbuf *msgb)
> +{
> +	msgb_push_u16(msgb, SSH_MSG_SYN);
> +}
> +
> +/**
> + * msgb_push_buf() - Push raw data to the buffer.
> + * @msgb: The message buffer.
> + * @buf:  The data to push to the buffer.
> + * @len:  The length of the data to push to the buffer.
> + */
> +static inline void msgb_push_buf(struct msgbuf *msgb, const u8 *buf, size_t len)
> +{
> +	msgb->ptr = memcpy(msgb->ptr, buf, len) + len;
> +}
> +
> +/**
> + * msgb_push_crc() - Compute CRC and push it to the buffer.
> + * @msgb: The message buffer.
> + * @buf:  The data for which the CRC should be computed.
> + * @len:  The length of the data for which the CRC should be computed.
> + */
> +static inline void msgb_push_crc(struct msgbuf *msgb, const u8 *buf, size_t len)
> +{
> +	msgb_push_u16(msgb, ssh_crc(buf, len));
> +}
> +
> +/**
> + * msgb_push_frame() - Push a SSH message frame header to the buffer.
> + * @msgb: The message buffer
> + * @ty:   The type of the frame.
> + * @len:  The length of the payload of the frame.
> + * @seq:  The sequence ID of the frame/packet.
> + */
> +static inline void msgb_push_frame(struct msgbuf *msgb, u8 ty, u16 len, u8 seq)
> +{
> +	u8 *const begin = msgb->ptr;
> +
> +	if (WARN_ON(msgb->ptr + sizeof(struct ssh_frame) > msgb->end))
> +		return;
> +
> +	__msgb_push_u8(msgb, ty);	/* Frame type. */
> +	__msgb_push_u16(msgb, len);	/* Frame payload length. */
> +	__msgb_push_u8(msgb, seq);	/* Frame sequence ID. */
> +
> +	msgb_push_crc(msgb, begin, msgb->ptr - begin);
> +}
> +
> +/**
> + * msgb_push_ack() - Push a SSH ACK frame to the buffer.
> + * @msgb: The message buffer
> + * @seq:  The sequence ID of the frame/packet to be ACKed.
> + */
> +static inline void msgb_push_ack(struct msgbuf *msgb, u8 seq)
> +{
> +	/* SYN. */
> +	msgb_push_syn(msgb);
> +
> +	/* ACK-type frame + CRC. */
> +	msgb_push_frame(msgb, SSH_FRAME_TYPE_ACK, 0x00, seq);
> +
> +	/* Payload CRC (ACK-type frames do not have a payload). */
> +	msgb_push_crc(msgb, msgb->ptr, 0);
> +}
> +
> +/**
> + * msgb_push_nak() - Push a SSH NAK frame to the buffer.
> + * @msgb: The message buffer
> + */
> +static inline void msgb_push_nak(struct msgbuf *msgb)
> +{
> +	/* SYN. */
> +	msgb_push_syn(msgb);
> +
> +	/* NAK-type frame + CRC. */
> +	msgb_push_frame(msgb, SSH_FRAME_TYPE_NAK, 0x00, 0x00);
> +
> +	/* Payload CRC (ACK-type frames do not have a payload). */
> +	msgb_push_crc(msgb, msgb->ptr, 0);
> +}
> +
> +/**
> + * msgb_push_cmd() - Push a SSH command frame with payload to the buffer.
> + * @msgb: The message buffer.
> + * @seq:  The sequence ID (SEQ) of the frame/packet.
> + * @rqid: The request ID (RQID) of the request contained in the frame.
> + * @rqst: The request to wrap in the frame.
> + */
> +static inline void msgb_push_cmd(struct msgbuf *msgb, u8 seq, u16 rqid,
> +				 const struct ssam_request *rqst)
> +{
> +	const u8 type = SSH_FRAME_TYPE_DATA_SEQ;
> +	u8 *cmd;
> +
> +	/* SYN. */
> +	msgb_push_syn(msgb);
> +
> +	/* Command frame + CRC. */
> +	msgb_push_frame(msgb, type, sizeof(struct ssh_command) + rqst->length, seq);
> +
> +	/* Frame payload: Command struct + payload. */
> +	if (WARN_ON(msgb->ptr + sizeof(struct ssh_command) > msgb->end))
> +		return;
> +
> +	cmd = msgb->ptr;
> +
> +	__msgb_push_u8(msgb, SSH_PLD_TYPE_CMD);		/* Payload type. */
> +	__msgb_push_u8(msgb, rqst->target_category);	/* Target category. */
> +	__msgb_push_u8(msgb, rqst->target_id);		/* Target ID (out). */
> +	__msgb_push_u8(msgb, 0x00);			/* Target ID (in). */
> +	__msgb_push_u8(msgb, rqst->instance_id);	/* Instance ID. */
> +	__msgb_push_u16(msgb, rqid);			/* Request ID. */
> +	__msgb_push_u8(msgb, rqst->command_id);		/* Command ID. */
> +
> +	/* Command payload. */
> +	msgb_push_buf(msgb, rqst->payload, rqst->length);
> +
> +	/* CRC for command struct + payload. */
> +	msgb_push_crc(msgb, cmd, msgb->ptr - cmd);
> +}
> +
> +#endif /* _SURFACE_AGGREGATOR_SSH_MSGB_H */
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> new file mode 100644
> index 000000000000..237d28c90e4b
> --- /dev/null
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -0,0 +1,1699 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SSH packet transport layer.
> + *
> + * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/atomic.h>
> +#include <linux/jiffies.h>
> +#include <linux/kfifo.h>
> +#include <linux/kref.h>
> +#include <linux/kthread.h>
> +#include <linux/ktime.h>
> +#include <linux/limits.h>
> +#include <linux/list.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/surface_aggregator/serial_hub.h>
> +
> +#include "ssh_msgb.h"
> +#include "ssh_packet_layer.h"
> +#include "ssh_parser.h"
> +
> +/*
> + * To simplify reasoning about the code below, we define a few concepts. The
> + * system below is similar to a state-machine for packets, however, there are
> + * too many states to explicitly write them down. To (somewhat) manage the
> + * states and packets we rely on flags, reference counting, and some simple
> + * concepts. State transitions are triggered by actions.
> + *
> + * >> Actions <<
> + *
> + * - submit
> + * - transmission start (process next item in queue)
> + * - transmission finished (guaranteed to never be parallel to transmission
> + *   start)
> + * - ACK received
> + * - NAK received (this is equivalent to issuing re-submit for all pending
> + *   packets)
> + * - timeout (this is equivalent to re-issuing a submit or canceling)
> + * - cancel (non-pending and pending)
> + *
> + * >> Data Structures, Packet Ownership, General Overview <<
> + *
> + * The code below employs two main data structures: The packet queue,
> + * containing all packets scheduled for transmission, and the set of pending
> + * packets, containing all packets awaiting an ACK.
> + *
> + * Shared ownership of a packet is controlled via reference counting. Inside
> + * the transport system are a total of five packet owners:
> + *
> + * - the packet queue,
> + * - the pending set,
> + * - the transmitter thread,
> + * - the receiver thread (via ACKing), and
> + * - the timeout work item.
> + *
> + * Normal operation is as follows: The initial reference of the packet is
> + * obtained by submitting the packet and queuing it. The receiver thread takes
> + * packets from the queue. By doing this, it does not increment the refcount
> + * but takes over the reference (removing it from the queue). If the packet is
> + * sequenced (i.e. needs to be ACKed by the client), the transmitter thread
> + * sets-up the timeout and adds the packet to the pending set before starting
> + * to transmit it. As the timeout is handled by a reaper task, no additional
> + * reference for it is needed. After the transmit is done, the reference held
> + * by the transmitter thread is dropped. If the packet is unsequenced (i.e.
> + * does not need an ACK), the packet is completed by the transmitter thread
> + * before dropping that reference.
> + *
> + * On receival of an ACK, the receiver thread removes and obtains the
> + * reference to the packet from the pending set. The receiver thread will then
> + * complete the packet and drop its reference.
> + *
> + * On receival of a NAK, the receiver thread re-submits all currently pending
> + * packets.
> + *
> + * Packet timeouts are detected by the timeout reaper. This is a task,
> + * scheduled depending on the earliest packet timeout expiration date,
> + * checking all currently pending packets if their timeout has expired. If the
> + * timeout of a packet has expired, it is re-submitted and the number of tries
> + * of this packet is incremented. If this number reaches its limit, the packet
> + * will be completed with a failure.
> + *
> + * On transmission failure (such as repeated packet timeouts), the completion
> + * callback is immediately run by on thread on which the error was detected.
> + *
> + * To ensure that a packet eventually leaves the system it is marked as
> + * "locked" directly before it is going to be completed or when it is
> + * canceled. Marking a packet as "locked" has the effect that passing and
> + * creating new references of the packet is disallowed. This means that the
> + * packet cannot be added to the queue, the pending set, and the timeout, or
> + * be picked up by the transmitter thread or receiver thread. To remove a
> + * packet from the system it has to be marked as locked and subsequently all
> + * references from the data structures (queue, pending) have to be removed.
> + * References held by threads will eventually be dropped automatically as
> + * their execution progresses.
> + *
> + * Note that the packet completion callback is, in case of success and for a
> + * sequenced packet, guaranteed to run on the receiver thread, thus providing
> + * a way to reliably identify responses to the packet. The packet completion
> + * callback is only run once and it does not indicate that the packet has
> + * fully left the system (for this, one should rely on the release method,
> + * triggered when the reference count of the packet reaches zero). In case of
> + * re-submission (and with somewhat unlikely timing), it may be possible that
> + * the packet is being re-transmitted while the completion callback runs.
> + * Completion will occur both on success and internal error, as well as when
> + * the packet is canceled.
> + *
> + * >> Flags <<
> + *
> + * Flags are used to indicate the state and progression of a packet. Some flags
> + * have stricter guarantees than other:
> + *
> + * - locked
> + *   Indicates if the packet is locked. If the packet is locked, passing and/or
> + *   creating additional references to the packet is forbidden. The packet thus
> + *   may not be queued, dequeued, or removed or added to the pending set. Note
> + *   that the packet state flags may still change (e.g. it may be marked as
> + *   ACKed, transmitted, ...).
> + *
> + * - completed
> + *   Indicates if the packet completion callback has been executed or is about
> + *   to be executed. This flag is used to ensure that the packet completion
> + *   callback is only run once.
> + *
> + * - queued
> + *   Indicates if a packet is present in the submission queue or not. This flag
> + *   must only be modified with the queue lock held, and must be coherent to the
> + *   presence of the packet in the queue.
> + *
> + * - pending
> + *   Indicates if a packet is present in the set of pending packets or not.
> + *   This flag must only be modified with the pending lock held, and must be
> + *   coherent to the presence of the packet in the pending set.
> + *
> + * - transmitting
> + *   Indicates if the packet is currently transmitting. In case of
> + *   re-transmissions, it is only safe to wait on the "transmitted" completion
> + *   after this flag has been set. The completion will be set both in success
> + *   and error case.
> + *
> + * - transmitted
> + *   Indicates if the packet has been transmitted. This flag is not cleared by
> + *   the system, thus it indicates the first transmission only.
> + *
> + * - acked
> + *   Indicates if the packet has been acknowledged by the client. There are no
> + *   other guarantees given. For example, the packet may still be canceled
> + *   and/or the completion may be triggered an error even though this bit is
> + *   set. Rely on the status provided to the completion callback instead.
> + *
> + * - canceled
> + *   Indicates if the packet has been canceled from the outside. There are no
> + *   other guarantees given. Specifically, the packet may be completed by
> + *   another part of the system before the cancellation attempts to complete it.
> + *
> + * >> General Notes <<
> + *
> + * - To avoid deadlocks, if both queue and pending locks are required, the
> + *   pending lock must be acquired before the queue lock.
> + *
> + * - The packet priority must be accessed only while holding the queue lock.
> + *
> + * - The packet timestamp must be accessed only while holding the pending
> + *   lock.
> + */
> +
> +/*
> + * SSH_PTL_MAX_PACKET_TRIES - Maximum transmission attempts for packet.
> + *
> + * Maximum number of transmission attempts per sequenced packet in case of
> + * time-outs. Must be smaller than 16. If the packet times out after this
> + * amount of tries, the packet will be completed with %-ETIMEDOUT as status
> + * code.
> + */
> +#define SSH_PTL_MAX_PACKET_TRIES		3
> +
> +/*
> + * SSH_PTL_TX_TIMEOUT - Packet transmission timeout.
> + *
> + * Timeout in jiffies for packet transmission via the underlying serial
> + * device. If transmitting the packet takes longer than this timeout, the
> + * packet will be completed with -ETIMEDOUT. It will not be re-submitted.
> + */
> +#define SSH_PTL_TX_TIMEOUT			HZ
> +
> +/*
> + * SSH_PTL_PACKET_TIMEOUT - Packet response timeout.
> + *
> + * Timeout as ktime_t delta for ACKs. If we have not received an ACK in this
> + * time-frame after starting transmission, the packet will be re-submitted.
> + */
> +#define SSH_PTL_PACKET_TIMEOUT			ms_to_ktime(1000)
> +
> +/*
> + * SSH_PTL_PACKET_TIMEOUT_RESOLUTION - Packet timeout granularity.
> + *
> + * Time-resolution for timeouts. Should be larger than one jiffy to avoid
> + * direct re-scheduling of reaper work_struct.
> + */
> +#define SSH_PTL_PACKET_TIMEOUT_RESOLUTION	ms_to_ktime(max(2000 / HZ, 50))
> +
> +/*
> + * SSH_PTL_MAX_PENDING - Maximum number of pending packets.
> + *
> + * Maximum number of sequenced packets concurrently waiting for an ACK.
> + * Packets marked as blocking will not be transmitted while this limit is
> + * reached.
> + */
> +#define SSH_PTL_MAX_PENDING			1
> +
> +/*
> + * SSH_PTL_RX_BUF_LEN - Evaluation-buffer size in bytes.
> + */
> +#define SSH_PTL_RX_BUF_LEN			4096
> +
> +/*
> + * SSH_PTL_RX_FIFO_LEN - Fifo input-buffer size in bytes.
> + */
> +#define SSH_PTL_RX_FIFO_LEN			4096
> +
> +static void __ssh_ptl_packet_release(struct kref *kref)
> +{
> +	struct ssh_packet *p = container_of(kref, struct ssh_packet, refcnt);
> +
> +	ptl_dbg_cond(p->ptl, "ptl: releasing packet %p\n", p);
> +	p->ops->release(p);
> +}
> +
> +/**
> + * ssh_packet_get() - Increment reference count of packet.
> + * @packet: The packet to increment the reference count of.
> + *
> + * Increments the reference count of the given packet. See ssh_packet_put()
> + * for the counter-part of this function.
> + *
> + * Return: Returns the packet provided as input.
> + */
> +struct ssh_packet *ssh_packet_get(struct ssh_packet *packet)
> +{
> +	if (packet)
> +		kref_get(&packet->refcnt);
> +	return packet;
> +}
> +EXPORT_SYMBOL_GPL(ssh_packet_get);
> +
> +/**
> + * ssh_packet_put() - Decrement reference count of packet.
> + * @packet: The packet to decrement the reference count of.
> + *
> + * If the reference count reaches zero, the ``release`` callback specified in
> + * the packet's &struct ssh_packet_ops, i.e. ``packet->ops->release``, will be
> + * called.
> + *
> + * See ssh_packet_get() for the counter-part of this function.
> + */
> +void ssh_packet_put(struct ssh_packet *packet)
> +{
> +	if (packet)
> +		kref_put(&packet->refcnt, __ssh_ptl_packet_release);
> +}
> +EXPORT_SYMBOL_GPL(ssh_packet_put);
> +
> +static u8 ssh_packet_get_seq(struct ssh_packet *packet)
> +{
> +	return packet->data.ptr[SSH_MSGOFFSET_FRAME(seq)];
> +}
> +
> +/**
> + * ssh_packet_init() - Initialize SSH packet.
> + * @packet:   The packet to initialize.
> + * @type:     Type-flags of the packet.
> + * @priority: Priority of the packet. See SSH_PACKET_PRIORITY() for details.
> + * @ops:      Packet operations.
> + *
> + * Initializes the given SSH packet. Sets the transmission buffer pointer to
> + * %NULL and the transmission buffer length to zero. For data-type packets,
> + * this buffer has to be set separately via ssh_packet_set_data() before
> + * submission, and must contain a valid SSH message, i.e. frame with optional
> + * payload of any type.
> + */
> +void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
> +		     u8 priority, const struct ssh_packet_ops *ops)
> +{
> +	kref_init(&packet->refcnt);
> +
> +	packet->ptl = NULL;
> +	INIT_LIST_HEAD(&packet->queue_node);
> +	INIT_LIST_HEAD(&packet->pending_node);
> +
> +	packet->state = type & SSH_PACKET_FLAGS_TY_MASK;
> +	packet->priority = priority;
> +	packet->timestamp = KTIME_MAX;
> +
> +	packet->data.ptr = NULL;
> +	packet->data.len = 0;
> +
> +	packet->ops = ops;
> +}
> +
> +/**
> + * ssh_ctrl_packet_alloc() - Allocate control packet.
> + * @packet: Where the pointer to the newly allocated packet should be stored.
> + * @buffer: The buffer corresponding to this packet.
> + * @flags:  Flags used for allocation.
> + *
> + * Allocates a packet and corresponding transport buffer. Sets the packet's
> + * buffer reference to the allocated buffer. The packet must be freed via
> + * ssh_ctrl_packet_free(), which will also free the corresponding buffer. The
> + * corresponding buffer must not be freed separately. Intended to be used with
> + * %ssh_ptl_ctrl_packet_ops as packet operations.
> + *
> + * Return: Returns zero on success, %-ENOMEM if the allocation failed.
> + */
> +static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
> +				 struct ssam_span *buffer, gfp_t flags)
> +{
> +	*packet = kzalloc(sizeof(**packet) + SSH_MSG_LEN_CTRL, flags);
> +	if (!*packet)
> +		return -ENOMEM;
> +
> +	buffer->ptr = (u8 *)(*packet + 1);
> +	buffer->len = SSH_MSG_LEN_CTRL;
> +
> +	return 0;
> +}
> +
> +/**
> + * ssh_ctrl_packet_free() - Free control packet.
> + * @p: The packet to free.
> + */
> +static void ssh_ctrl_packet_free(struct ssh_packet *p)
> +{
> +	kfree(p);
> +}
> +
> +static const struct ssh_packet_ops ssh_ptl_ctrl_packet_ops = {
> +	.complete = NULL,
> +	.release = ssh_ctrl_packet_free,
> +};
> +
> +static void ssh_ptl_timeout_reaper_mod(struct ssh_ptl *ptl, ktime_t now,
> +				       ktime_t expires)
> +{
> +	unsigned long delta = msecs_to_jiffies(ktime_ms_delta(expires, now));
> +	ktime_t aexp = ktime_add(expires, SSH_PTL_PACKET_TIMEOUT_RESOLUTION);
> +
> +	spin_lock(&ptl->rtx_timeout.lock);
> +
> +	/* Re-adjust / schedule reaper only if it is above resolution delta. */
> +	if (ktime_before(aexp, ptl->rtx_timeout.expires)) {
> +		ptl->rtx_timeout.expires = expires;
> +		mod_delayed_work(system_wq, &ptl->rtx_timeout.reaper, delta);
> +	}
> +
> +	spin_unlock(&ptl->rtx_timeout.lock);
> +}
> +
> +/* Must be called with queue lock held. */
> +static void ssh_packet_next_try(struct ssh_packet *p)
> +{
> +	u8 base = ssh_packet_priority_get_base(p->priority);
> +	u8 try = ssh_packet_priority_get_try(p->priority);
> +
> +	p->priority = __SSH_PACKET_PRIORITY(base, try + 1);
> +}
> +
> +/* Must be called with queue lock held. */
> +static struct list_head *__ssh_ptl_queue_find_entrypoint(struct ssh_packet *p)
> +{
> +	struct list_head *head;
> +	struct ssh_packet *q;
> +
> +	/*
> +	 * We generally assume that there are less control (ACK/NAK) packets
> +	 * and re-submitted data packets as there are normal data packets (at
> +	 * least in situations in which many packets are queued; if there
> +	 * aren't many packets queued the decision on how to iterate should be
> +	 * basically irrelevant; the number of control/data packets is more or
> +	 * less limited via the maximum number of pending packets). Thus, when
> +	 * inserting a control or re-submitted data packet, (determined by
> +	 * their priority), we search from front to back. Normal data packets
> +	 * are, usually queued directly at the tail of the queue, so for those
> +	 * search from back to front.
> +	 */
> +
> +	if (p->priority > SSH_PACKET_PRIORITY(DATA, 0)) {
> +		list_for_each(head, &p->ptl->queue.head) {
> +			q = list_entry(head, struct ssh_packet, queue_node);
> +
> +			if (q->priority < p->priority)
> +				break;
> +		}
> +	} else {
> +		list_for_each_prev(head, &p->ptl->queue.head) {
> +			q = list_entry(head, struct ssh_packet, queue_node);
> +
> +			if (q->priority >= p->priority) {
> +				head = head->next;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return head;
> +}
> +
> +/* Must be called with queue lock held. */

Maybe add a lockdep_assert for this ?

(and the same for a bunch of similar cases below)


> +static int __ssh_ptl_queue_push(struct ssh_packet *packet)
> +{
> +	struct ssh_ptl *ptl = packet->ptl;
> +	struct list_head *head;
> +
> +	if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
> +		return -ESHUTDOWN;
> +
> +	/* Avoid further transitions when canceling/completing. */
> +	if (test_bit(SSH_PACKET_SF_LOCKED_BIT, &packet->state))
> +		return -EINVAL;
> +
> +	/* If this packet has already been queued, do not add it. */
> +	if (test_and_set_bit(SSH_PACKET_SF_QUEUED_BIT, &packet->state))
> +		return -EALREADY;
> +
> +	head = __ssh_ptl_queue_find_entrypoint(packet);
> +
> +	list_add_tail(&ssh_packet_get(packet)->queue_node, head);
> +	return 0;
> +}

<snip about 5000 more lines>

Snipped because nothing stood out in the rest of this patch.

Phew that was one large patch to review. I've run out of review
bandwidth for today, so I will review the rest of the series
later (probably coming Thursday).

Regards,

Hans

