Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A5275EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIWRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgIWRcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:32:51 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B67212053B;
        Wed, 23 Sep 2020 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600882370;
        bh=AwqwnzQM5H5rMV4SyxlArkCa3qX6tgB4iEhI+yqsBVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3LbgKH1DW8QKPdFZxPhR8ItvC34+LG6DAiPlnT+tuHV803lYXQP8nfvi49zy5ZzO
         XZZjRuWTjjvMfCLsbZji8WImDnOjwZjDRomHxHLMwXi4b7zP14r4iya487GLmZ+4aK
         EV/x0dUsRguAaRbJ5BUlZk8vA8tEeptAuIqARuEk=
Date:   Wed, 23 Sep 2020 19:33:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 6/9] surface_aggregator: Add dedicated bus and device
 type
Message-ID: <20200923173308.GA3965283@kroah.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-7-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923151511.3842150-7-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:15:08PM +0200, Maximilian Luz wrote:
> The Surface Aggregator EC provides varying functionality, depending on
> the Surface device. To manage this functionality, we use dedicated
> client devices for each subsystem or virtual device of the EC. While
> some of these clients are described as standard devices in ACPI and the
> corresponding client drivers can be implemented as platform drivers in
> the kernel (making use of the controller API already present), many
> devices, especially on newer Surface models, cannot be found there.
> 
> To simplify management of these devices, we introduce a new bus and
> client device type for the Surface Aggregator subsystem. The new device
> type takes care of managing the controller reference, essentially
> guaranteeing its validity for as long as the client device exists, thus
> alleviating the need to manually establish device links for that purpose
> in the client driver (as has to be done with the platform devices).
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Overall, nice work on this patch, the integration to the driver core
looks totally correct.  Great job.

A few minor nits below:

> --- /dev/null
> +++ b/drivers/misc/surface_aggregator/bus.c
> @@ -0,0 +1,419 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +

No copyright?

> +/**
> + * ssam_device_add() - Add a SSAM client device.
> + * @sdev: The SSAM client device to be added.
> + *
> + * Added client devices must be guaranteed to always have a valid and active
> + * controller. Thus, this function will fail with %-ENXIO if the controller of
> + * the device has not been initialized yet, has been suspended, or has been
> + * shut down.
> + *
> + * The caller of this function should ensure that the corresponding call to
> + * ssam_device_remove() is issued before the controller is shut down. If the
> + * added device is a direct child of the controller device (default), it will
> + * be automatically removed when the controller is shut down.
> + *
> + * By default, the controller device will become the parent of the newly
> + * created client device. The parent may be changed before ssam_device_add is
> + * called, but care must be taken that a) the correct suspend/resume ordering
> + * is guaranteed and b) the client device does not oultive the controller,
> + * i.e. that the device is removed before the controller is being shut down.
> + * In case these guarantees have to be manually enforced, please refer to the
> + * ssam_client_link() and ssam_client_bind() functions, which are intended to
> + * set up device-links for this purpose.
> + *
> + * Return: Returns zero on success, a negative error code on failure.
> + */
> +int ssam_device_add(struct ssam_device *sdev)
> +{
> +	int status;
> +
> +	/*
> +	 * Ensure that we can only add new devices to a controller if it has
> +	 * been started and is not going away soon. This works in combination
> +	 * with ssam_controller_remove_clients to ensure driver presence for the
> +	 * controller device, i.e. it ensures that the controller (sdev->ctrl)
> +	 * is always valid and can be used for requests as long as the client
> +	 * device we add here is registered as child under it. This essentially
> +	 * guarantees that the client driver can always expect the preconditions
> +	 * for functions like ssam_request_sync (controller has to be started
> +	 * and is not suspended) to hold and thus does not have to check for
> +	 * them.
> +	 *
> +	 * Note that for this to work, the controller has to be a parent device.
> +	 * If it is not a direct parent, care has to be taken that the device is
> +	 * removed via ssam_device_remove(), as device_unregister does not
> +	 * remove child devices recursively.
> +	 */
> +	ssam_controller_statelock(sdev->ctrl);
> +
> +	if (READ_ONCE(sdev->ctrl->state) != SSAM_CONTROLLER_STARTED) {

You locked the state, why the READ_ONCE()?  Is taht needed?

> +		ssam_controller_stateunlock(sdev->ctrl);
> +		return -ENXIO;

odd error value, why this one?

> +	}
> +
> +	status = device_add(&sdev->dev);
> +
> +	ssam_controller_stateunlock(sdev->ctrl);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(ssam_device_add);
> --- /dev/null
> +++ b/include/linux/surface_aggregator/device.h
> @@ -0,0 +1,408 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Copyright?

> +/*
> + * Surface System Aggregator Module (SSAM) bus and client-device subsystem.
> + *
> + * Main interface for the surface-aggregator bus, surface-aggregator client
> + * devices, and respective drivers building on top of the SSAM controller.
> + * Provides support for non-platform/non-ACPI SSAM clients via dedicated
> + * subsystem.
> + */
> +
> +#ifndef _LINUX_SURFACE_AGGREGATOR_DEVICE_H
> +#define _LINUX_SURFACE_AGGREGATOR_DEVICE_H
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/types.h>
> +
> +#include <linux/surface_aggregator/controller.h>
> +
> +
> +/* -- Surface System Aggregator Module Bus. --------------------------------- */
> +
> +/**
> + * enum ssam_device_domain - SAM device domain.
> + * @SSAM_DOMAIN_VIRTUAL:   Virtual device.
> + * @SSAM_DOMAIN_SERIALHUB: Physical dovice connected via Surface Serial Hub.
> + */
> +enum ssam_device_domain {
> +	SSAM_DOMAIN_VIRTUAL   = 0x00,
> +	SSAM_DOMAIN_SERIALHUB = 0x01,
> +};
> +
> +/**
> + * enum ssam_virtual_tc - Target categories for the virtual SAM domain.
> + * @SSAM_VIRTUAL_TC_HUB: Device hub category.
> + */
> +enum ssam_virtual_tc {
> +	SSAM_VIRTUAL_TC_HUB = 0x00,
> +};
> +
> +/**
> + * struct ssam_device_uid - Unique identifier for SSAM device.
> + * @domain:   Domain of the device.
> + * @category: Target category of the device.
> + * @target:   Target ID of the device.
> + * @instance: Instance ID of the device.
> + * @function: Sub-function of the device. This field can be used to split a
> + *            single SAM device into multiple virtual subdevices to separate
> + *            different functionality of that device and allow one driver per
> + *            such functionality.
> + */
> +struct ssam_device_uid {
> +	u8 domain;
> +	u8 category;
> +	u8 target;
> +	u8 instance;
> +	u8 function;
> +};
> +
> +/*
> + * Special values for device matching.
> + */
> +#define SSAM_ANY_TID		0xffff
> +#define SSAM_ANY_IID		0xffff
> +#define SSAM_ANY_FUN		0xffff

These are 16 bits, but the uid values above are 8 bits.  How does that
match up?

> +
> +/**
> + * SSAM_DEVICE() - Initialize a &struct ssam_device_id with the given
> + * parameters.
> + * @d:   Domain of the device.
> + * @cat: Target category of the device.
> + * @tid: Target ID of the device.
> + * @iid: Instance ID of the device.
> + * @fun: Sub-function of the device.
> + *
> + * Initializes a &struct ssam_device_id with the given parameters. See &struct
> + * ssam_device_uid for details regarding the parameters. The special values
> + * %SSAM_ANY_TID, %SSAM_ANY_IID, and %SSAM_ANY_FUN can be used to specify that
> + * matching should ignore target ID, instance ID, and/or sub-function,
> + * respectively. This macro initializes the ``match_flags`` field based on the
> + * given parameters.
> + */
> +#define SSAM_DEVICE(d, cat, tid, iid, fun)					\
> +	.match_flags = (((tid) != SSAM_ANY_TID) ? SSAM_MATCH_TARGET : 0)	\
> +		     | (((iid) != SSAM_ANY_IID) ? SSAM_MATCH_INSTANCE : 0)	\
> +		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
> +	.domain   = d,								\
> +	.category = cat,							\
> +	.target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,			\
> +	.instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,			\
> +	.function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0				\

Again, the 16 vs 8 bits here feels odd.  No casting???


> +/**
> + * ssam_device_get() - Increment reference count of SSAM client device.
> + * @sdev: The device to increment the reference count of.
> + *
> + * Increments the reference count of the given SSAM client device by
> + * incrementing the reference count of the enclosed &struct device via
> + * get_device().
> + *
> + * See ssam_device_put() for the counter-part of this function.
> + *
> + * Return: Returns the device provided as input.
> + */
> +static inline struct ssam_device *ssam_device_get(struct ssam_device *sdev)
> +{
> +	get_device(&sdev->dev);
> +	return sdev;

Do you want to check if sdev is NULL or not here before referencing
it?

> +}
> +
> +/**
> + * ssam_device_put() - Decrement reference count of SSAM client device.
> + * @sdev: The device to decrement the reference count of.
> + *
> + * Decrements the reference count of the given SSAM client device by
> + * decrementing the reference count of the enclosed &struct device via
> + * put_device().
> + *
> + * See ssam_device_get() for the counter-part of this function.
> + */
> +static inline void ssam_device_put(struct ssam_device *sdev)
> +{
> +	put_device(&sdev->dev);

Same here, do you need to check?

anyway, again, nice work, if only all of my code reviews were this easy
:)

thanks,

greg k-h
