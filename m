Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCCC294B39
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438794AbgJUK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:27:46 -0400
Received: from foss.arm.com ([217.140.110.172]:33192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390067AbgJUK1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:27:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F9DB1FB;
        Wed, 21 Oct 2020 03:27:45 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F5813F66E;
        Wed, 21 Oct 2020 03:27:43 -0700 (PDT)
Date:   Wed, 21 Oct 2020 11:27:41 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 03/11] firmware: arm_scmi: introduce common protocol
 interface
Message-ID: <20201021102741.GB20482@e120937-lin>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-4-cristian.marussi@arm.com>
 <64254fdf-dcb3-b27f-9624-de2abacf55d2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64254fdf-dcb3-b27f-9624-de2abacf55d2@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:47:10PM -0400, Thara Gopinath wrote:
> 
> 
> On 10/14/20 11:05 AM, Cristian Marussi wrote:
> > Introduce generic get_ops/put_ops handle operations: any protocol, both
> > standard or custom, now exposes its operations through this common
> > interface which internally takes care to account for protocols' usage:
> > protocols' initialization is now performed on demand as soon as the first
> > user shows up while deinitialization (if any) is performed once
> > the last user of a protocol has gone.
> > Registered events' notifier are tracked too against the related protocol.
> > Convert all SCMI drivers to the new interface too.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> 
> [...]
> 
> 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index bad1d0130e96..049220efd227 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -585,7 +585,7 @@ void *scmi_get_proto_priv(const struct scmi_handle *handle, u8 protocol_id)
> >    * Return: A reference to an initialized protocol instance or error on failure.
> >    */
> >   static struct scmi_protocol_instance * __must_check
> > -scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
> > +scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
> >   {
> >   	int ret = -ENOMEM;
> >   	void *gid;
> > @@ -655,7 +655,7 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
> >    *
> >    * Return: 0 if protocol was acquired successfully.
> >    */
> > -int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
> > +int scmi_acquire_protocol(const struct scmi_handle *handle, u8 protocol_id)
> >   {
> >   	return IS_ERR(scmi_get_protocol_instance(handle, protocol_id));
> >   }
> > @@ -668,7 +668,7 @@ int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
> >    * Remove one user for the specified protocol and triggers de-initialization
> >    * and resources de-allocation once the last user has gone.
> >    */
> > -void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
> > +void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id)
> >   {
> >   	struct scmi_info *info = handle_to_scmi_info(handle);
> >   	struct scmi_protocol_instance *pi;
> > @@ -700,6 +700,29 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
> >   	mutex_unlock(&info->protocols_mtx);
> >   }
> > +/**
> > + * scmi_get_protocol_operations  - Get protocol operations
> > + * @handle: A reference to the SCMI platform instance.
> > + * @protocol_id: The protocol being requested.
> > + *
> > + * Get hold of a protocol accounting for its usage, eventually triggering its
> > + * initialization, and returning the protocol specific operations.
> > + *
> > + * Return: A reference to the requested protocol operations or error.
> > + *	   Must be checked for errors by caller.
> > + */
> > +static const void __must_check
> > +*scmi_get_protocol_operations(const struct scmi_handle *handle, u8 protocol_id)
> > +{
> > +	struct scmi_protocol_instance *pi;
> > +
> > +	pi = scmi_get_protocol_instance(handle, protocol_id);
> > +	if (IS_ERR(pi))
> > +		return pi;
> > +
> > +	return pi->proto->ops;
> > +} > +
> >   void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
> >   				     u8 *prot_imp)
> >   {
> > @@ -975,6 +998,8 @@ static int scmi_probe(struct platform_device *pdev)
> >   	handle = &info->handle;
> >   	handle->dev = info->dev;
> >   	handle->version = &info->version;
> > +	handle->get_ops = scmi_get_protocol_operations;
> > +	handle->put_ops = scmi_release_protocol;
> 
> 
> Why do you need get_ops and put_ops? Why not have the drivers call
> scmi_acquire_protocol and scmi_release_protocol directly and get the ops
> from retrieved scmi_get_protocol_instance ? IMHO, this makes it more
> readable. Also, this will make the usage of scmi_acquire_protocol and
> scmi_release_protocol more consistent. Right now, notify.c uses
> scmi_acquire_protocol to acquire protocol because there is no need for ops
> and other drivers use get_ops to acquire protocol. Kind of confusing..
> 

Trying to avoid exporting new synbols if not strictly needed, I exposed
get_ops()/put_ops() via handle for the usage of the SCMI drivers users,
while keeping scmi_acquire/release as internal non-exported wrappers used
only by the SCMI core itself like notifications.
You cannot call acquire/release from a loadable module as of now.

Additionally I thougt to add these wrappers for cases in which like
notifications you don't need the ops really (like notif or base) nor 
the related forced __must_check(like notif), but just to get hold of
the protocol to avoid it being possibly unloaded.

I would antyway keep the get_ops/put_ops and I could just drop
acquire/release if confusing and use the raw ops methods also internally,
properly checking for the result everytime: currently notifications core
takes care to acquire a protocol only once the requested event has been
registered by some protocol (i.e. event handler is NOT pending) so that
I do not trigger a protocol initialization when registering a notifier
against a still unknown event: as a consequence acquire/release when
called in the notif context cannot fail, so I don;t check.

I'll try to simplify this though.

Regards

Cristian

> -- 
> Warm Regards
> Thara
> 
> >   	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
> >   	if (ret)
> > diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> > index eae58b2a92cc..02b00af9b08f 100644
> > --- a/drivers/firmware/arm_scmi/notify.c
> > +++ b/drivers/firmware/arm_scmi/notify.c
> > @@ -367,7 +367,7 @@ static struct scmi_event_handler *
> >   scmi_get_active_handler(struct scmi_notify_instance *ni, u32 evt_key);
> >   static void scmi_put_active_handler(struct scmi_notify_instance *ni,
> >   				    struct scmi_event_handler *hndl);
> > -static void scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
> > +static bool scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
> >   				      struct scmi_event_handler *hndl);
> >   /**
> > @@ -899,9 +899,21 @@ static inline int scmi_bind_event_handler(struct scmi_notify_instance *ni,
> >   	if (!r_evt)
> >   		return -EINVAL;
> > -	/* Remove from pending and insert into registered */
> > +	/*
> > +	 * Remove from pending and insert into registered while getting hold
> > +	 * of protocol instance.
> > +	 */
> >   	hash_del(&hndl->hash);
> > +	/*
> > +	 * Acquire protocols only for NON pending handlers, so as NOT to trigger
> > +	 * protocol initialization when a notifier is registered against a still
> > +	 * not registered protocol, since it would make little sense to force init
> > +	 * protocols for which still no SCMI driver user exists: they wouldn't
> > +	 * emit any event anyway till some SCMI driver starts using it.
> > +	 */
> > +	scmi_acquire_protocol(ni->handle, KEY_XTRACT_PROTO_ID(hndl->key));
> >   	hndl->r_evt = r_evt;
> > +
> >   	mutex_lock(&r_evt->proto->registered_mtx);
> >   	hash_add(r_evt->proto->registered_events_handlers,
> >   		 &hndl->hash, hndl->key);
> > @@ -1192,41 +1204,65 @@ static int scmi_disable_events(struct scmi_event_handler *hndl)
> >    * * unregister and free the handler itself
> >    *
> >    * Context: Assumes all the proper locking has been managed by the caller.
> > + *
> > + * Return: True if handler was freed (users dropped to zero)
> >    */
> > -static void scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
> > +static bool scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
> >   				      struct scmi_event_handler *hndl)
> >   {
> > +	bool freed = false;
> > +
> >   	if (refcount_dec_and_test(&hndl->users)) {
> >   		if (!IS_HNDL_PENDING(hndl))
> >   			scmi_disable_events(hndl);
> >   		scmi_free_event_handler(hndl);
> > +		freed = true;
> >   	}
> > +
> > +	return freed;
> >   }
> >   static void scmi_put_handler(struct scmi_notify_instance *ni,
> >   			     struct scmi_event_handler *hndl)
> >   {
> > +	bool freed;
> > +	u8 protocol_id;
> >   	struct scmi_registered_event *r_evt = hndl->r_evt;
> >   	mutex_lock(&ni->pending_mtx);
> > -	if (r_evt)
> > +	if (r_evt) {
> > +		protocol_id = r_evt->proto->id;
> >   		mutex_lock(&r_evt->proto->registered_mtx);
> > +	}
> > -	scmi_put_handler_unlocked(ni, hndl);
> > +	freed = scmi_put_handler_unlocked(ni, hndl);
> > -	if (r_evt)
> > +	if (r_evt) {
> >   		mutex_unlock(&r_evt->proto->registered_mtx);
> > +		/*
> > +		 * Only registered handler acquired protocol; must be here
> > +		 * released only AFTER unlocking registered_mtx, since
> > +		 * releasing a protocol can trigger its de-initialization
> > +		 * (ie. including r_evt and registered_mtx)
> > +		 */
> > +		if (freed)
> > +			scmi_release_protocol(ni->handle, protocol_id);
> > +	}
> >   	mutex_unlock(&ni->pending_mtx);
> >   }
> >   static void scmi_put_active_handler(struct scmi_notify_instance *ni,
> >   				    struct scmi_event_handler *hndl)
> >   {
> > +	bool freed;
> >   	struct scmi_registered_event *r_evt = hndl->r_evt;
> > +	u8 protocol_id = r_evt->proto->id;
> >   	mutex_lock(&r_evt->proto->registered_mtx);
> > -	scmi_put_handler_unlocked(ni, hndl);
> > +	freed = scmi_put_handler_unlocked(ni, hndl);
> >   	mutex_unlock(&r_evt->proto->registered_mtx);
> > +	if (freed)
> > +		scmi_release_protocol(ni->handle, protocol_id);
> >   }
> >   /**
> > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > index 13e215f359fb..bd9cb2583557 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -857,7 +857,7 @@ static const struct scmi_event_ops perf_event_ops = {
> >   	.fill_custom_report = scmi_perf_fill_custom_report,
> >   };
> > -static int scmi_perf_protocol_init(struct scmi_handle *handle)
> > +static int scmi_perf_protocol_init(const struct scmi_handle *handle)
> >   {
> >   	int domain;
> >   	u32 version;
> > @@ -896,7 +896,6 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
> >   				      pinfo->num_domains);
> >   	pinfo->version = version;
> > -	handle->perf_ops = &perf_ops;
> >   	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_PERF, pinfo);
> >   }
> > diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
> > index e0b29ed4e09a..1e026b5530a7 100644
> > --- a/drivers/firmware/arm_scmi/power.c
> > +++ b/drivers/firmware/arm_scmi/power.c
> > @@ -262,7 +262,7 @@ static const struct scmi_event_ops power_event_ops = {
> >   	.fill_custom_report = scmi_power_fill_custom_report,
> >   };
> > -static int scmi_power_protocol_init(struct scmi_handle *handle)
> > +static int scmi_power_protocol_init(const struct scmi_handle *handle)
> >   {
> >   	int domain;
> >   	u32 version;
> > @@ -297,7 +297,6 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
> >   				      pinfo->num_domains);
> >   	pinfo->version = version;
> > -	handle->power_ops = &power_ops;
> >   	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_POWER, pinfo);
> >   }
> > diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
> > index f70e9b5108d5..b7da4de0e56e 100644
> > --- a/drivers/firmware/arm_scmi/reset.c
> > +++ b/drivers/firmware/arm_scmi/reset.c
> > @@ -274,7 +274,7 @@ static const struct scmi_event_ops reset_event_ops = {
> >   	.fill_custom_report = scmi_reset_fill_custom_report,
> >   };
> > -static int scmi_reset_protocol_init(struct scmi_handle *handle)
> > +static int scmi_reset_protocol_init(const struct scmi_handle *handle)
> >   {
> >   	int domain;
> >   	u32 version;
> > @@ -309,7 +309,6 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
> >   				      pinfo->num_domains);
> >   	pinfo->version = version;
> > -	handle->reset_ops = &reset_ops;
> >   	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_RESET, pinfo);
> >   }
> > diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
> > index 9e44479f0284..bfea56f77890 100644
> > --- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
> > +++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
> > @@ -2,7 +2,7 @@
> >   /*
> >    * SCMI Generic power domain support.
> >    *
> > - * Copyright (C) 2018 ARM Ltd.
> > + * Copyright (C) 2018-2020 ARM Ltd.
> >    */
> >   #include <linux/err.h>
> > @@ -11,6 +11,8 @@
> >   #include <linux/pm_domain.h>
> >   #include <linux/scmi_protocol.h>
> > +static const struct scmi_power_ops *power_ops;
> > +
> >   struct scmi_pm_domain {
> >   	struct generic_pm_domain genpd;
> >   	const struct scmi_handle *handle;
> > @@ -25,16 +27,15 @@ static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
> >   	int ret;
> >   	u32 state, ret_state;
> >   	struct scmi_pm_domain *pd = to_scmi_pd(domain);
> > -	const struct scmi_power_ops *ops = pd->handle->power_ops;
> >   	if (power_on)
> >   		state = SCMI_POWER_STATE_GENERIC_ON;
> >   	else
> >   		state = SCMI_POWER_STATE_GENERIC_OFF;
> > -	ret = ops->state_set(pd->handle, pd->domain, state);
> > +	ret = power_ops->state_set(pd->handle, pd->domain, state);
> >   	if (!ret)
> > -		ret = ops->state_get(pd->handle, pd->domain, &ret_state);
> > +		ret = power_ops->state_get(pd->handle, pd->domain, &ret_state);
> >   	if (!ret && state != ret_state)
> >   		return -EIO;
> > @@ -61,10 +62,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
> >   	struct generic_pm_domain **domains;
> >   	const struct scmi_handle *handle = sdev->handle;
> > -	if (!handle || !handle->power_ops)
> > +	if (!handle)
> >   		return -ENODEV;
> > -	num_domains = handle->power_ops->num_domains_get(handle);
> > +	power_ops = handle->get_ops(handle, SCMI_PROTOCOL_POWER);
> > +	if (IS_ERR(power_ops))
> > +		return PTR_ERR(power_ops);
> > +
> > +	num_domains = power_ops->num_domains_get(handle);
> >   	if (num_domains < 0) {
> >   		dev_err(dev, "number of domains not found\n");
> >   		return num_domains;
> > @@ -85,14 +90,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
> >   	for (i = 0; i < num_domains; i++, scmi_pd++) {
> >   		u32 state;
> > -		if (handle->power_ops->state_get(handle, i, &state)) {
> > +		if (power_ops->state_get(handle, i, &state)) {
> >   			dev_warn(dev, "failed to get state for domain %d\n", i);
> >   			continue;
> >   		}
> >   		scmi_pd->domain = i;
> >   		scmi_pd->handle = handle;
> > -		scmi_pd->name = handle->power_ops->name_get(handle, i);
> > +		scmi_pd->name = power_ops->name_get(handle, i);
> >   		scmi_pd->genpd.name = scmi_pd->name;
> >   		scmi_pd->genpd.power_off = scmi_pd_power_off;
> >   		scmi_pd->genpd.power_on = scmi_pd_power_on;
> > @@ -111,6 +116,13 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
> >   	return 0;
> >   }
> > +static void scmi_pm_domain_remove(struct scmi_device *sdev)
> > +{
> > +	const struct scmi_handle *handle = sdev->handle;
> > +
> > +	handle->put_ops(handle, SCMI_PROTOCOL_POWER);
> > +}
> > +
> >   static const struct scmi_device_id scmi_id_table[] = {
> >   	{ SCMI_PROTOCOL_POWER, "genpd" },
> >   	{ },
> > @@ -120,6 +132,7 @@ MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> >   static struct scmi_driver scmi_power_domain_driver = {
> >   	.name = "scmi-power-domain",
> >   	.probe = scmi_pm_domain_probe,
> > +	.remove = scmi_pm_domain_remove,
> >   	.id_table = scmi_id_table,
> >   };
> >   module_scmi_driver(scmi_power_domain_driver);
> > diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> > index 8a0a599558ba..e0129dcd322f 100644
> > --- a/drivers/firmware/arm_scmi/sensors.c
> > +++ b/drivers/firmware/arm_scmi/sensors.c
> > @@ -334,7 +334,7 @@ static const struct scmi_event_ops sensor_event_ops = {
> >   	.fill_custom_report = scmi_sensor_fill_custom_report,
> >   };
> > -static int scmi_sensors_protocol_init(struct scmi_handle *handle)
> > +static int scmi_sensors_protocol_init(const struct scmi_handle *handle)
> >   {
> >   	u32 version;
> >   	struct sensors_info *sinfo;
> > @@ -364,7 +364,6 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
> >   				      sinfo->num_sensors);
> >   	sinfo->version = version;
> > -	handle->sensor_ops = &sensor_ops;
> >   	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_SENSOR, sinfo);
> >   }
> > diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
> > index 8f53f93c63ca..30e3510c1f07 100644
> > --- a/drivers/firmware/arm_scmi/system.c
> > +++ b/drivers/firmware/arm_scmi/system.c
> > @@ -101,7 +101,7 @@ static const struct scmi_event_ops system_event_ops = {
> >   	.fill_custom_report = scmi_system_fill_custom_report,
> >   };
> > -static int scmi_system_protocol_init(struct scmi_handle *handle)
> > +static int scmi_system_protocol_init(const struct scmi_handle *handle)
> >   {
> >   	u32 version;
> >   	struct scmi_system_info *pinfo;
> > diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> > index d421e691318b..27ef71996a15 100644
> > --- a/drivers/hwmon/scmi-hwmon.c
> > +++ b/drivers/hwmon/scmi-hwmon.c
> > @@ -2,7 +2,7 @@
> >   /*
> >    * System Control and Management Interface(SCMI) based hwmon sensor driver
> >    *
> > - * Copyright (C) 2018 ARM Ltd.
> > + * Copyright (C) 2018-2020 ARM Ltd.
> >    * Sudeep Holla <sudeep.holla@arm.com>
> >    */
> > @@ -13,6 +13,8 @@
> >   #include <linux/sysfs.h>
> >   #include <linux/thermal.h>
> > +static const struct scmi_sensor_ops *sensor_ops;
> > +
> >   struct scmi_sensors {
> >   	const struct scmi_handle *handle;
> >   	const struct scmi_sensor_info **info[hwmon_max];
> > @@ -72,7 +74,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> >   	const struct scmi_handle *h = scmi_sensors->handle;
> >   	sensor = *(scmi_sensors->info[type] + channel);
> > -	ret = h->sensor_ops->reading_get(h, sensor->id, &value);
> > +	ret = sensor_ops->reading_get(h, sensor->id, &value);
> >   	if (ret)
> >   		return ret;
> > @@ -170,10 +172,14 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
> >   	const struct hwmon_channel_info **ptr_scmi_ci;
> >   	const struct scmi_handle *handle = sdev->handle;
> > -	if (!handle || !handle->sensor_ops)
> > +	if (!handle)
> >   		return -ENODEV;
> > -	nr_sensors = handle->sensor_ops->count_get(handle);
> > +	sensor_ops = handle->get_ops(handle, SCMI_PROTOCOL_SENSOR);
> > +	if (IS_ERR(sensor_ops))
> > +		return PTR_ERR(sensor_ops);
> > +
> > +	nr_sensors = sensor_ops->count_get(handle);
> >   	if (!nr_sensors)
> >   		return -EIO;
> > @@ -184,7 +190,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
> >   	scmi_sensors->handle = handle;
> >   	for (i = 0; i < nr_sensors; i++) {
> > -		sensor = handle->sensor_ops->info_get(handle, i);
> > +		sensor = sensor_ops->info_get(handle, i);
> >   		if (!sensor)
> >   			return -EINVAL;
> > @@ -234,7 +240,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
> >   	}
> >   	for (i = nr_sensors - 1; i >= 0 ; i--) {
> > -		sensor = handle->sensor_ops->info_get(handle, i);
> > +		sensor = sensor_ops->info_get(handle, i);
> >   		if (!sensor)
> >   			continue;
> > @@ -258,6 +264,13 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
> >   	return PTR_ERR_OR_ZERO(hwdev);
> >   }
> > +static void scmi_hwmon_remove(struct scmi_device *sdev)
> > +{
> > +	const struct scmi_handle *handle = sdev->handle;
> > +
> > +	handle->put_ops(handle, SCMI_PROTOCOL_SENSOR);
> > +}
> > +
> >   static const struct scmi_device_id scmi_id_table[] = {
> >   	{ SCMI_PROTOCOL_SENSOR, "hwmon" },
> >   	{ },
> > @@ -267,6 +280,7 @@ MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> >   static struct scmi_driver scmi_hwmon_drv = {
> >   	.name		= "scmi-hwmon",
> >   	.probe		= scmi_hwmon_probe,
> > +	.remove		= scmi_hwmon_remove,
> >   	.id_table	= scmi_id_table,
> >   };
> >   module_scmi_driver(scmi_hwmon_drv);
> > diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
> > index 8d3a858e3b19..e48220dedb35 100644
> > --- a/drivers/reset/reset-scmi.c
> > +++ b/drivers/reset/reset-scmi.c
> > @@ -2,7 +2,7 @@
> >   /*
> >    * ARM System Control and Management Interface (ARM SCMI) reset driver
> >    *
> > - * Copyright (C) 2019 ARM Ltd.
> > + * Copyright (C) 2019-2020 ARM Ltd.
> >    */
> >   #include <linux/module.h>
> > @@ -11,6 +11,8 @@
> >   #include <linux/reset-controller.h>
> >   #include <linux/scmi_protocol.h>
> > +static const struct scmi_reset_ops *reset_ops;
> > +
> >   /**
> >    * struct scmi_reset_data - reset controller information structure
> >    * @rcdev: reset controller entity
> > @@ -39,7 +41,7 @@ scmi_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> >   {
> >   	const struct scmi_handle *handle = to_scmi_handle(rcdev);
> > -	return handle->reset_ops->assert(handle, id);
> > +	return reset_ops->assert(handle, id);
> >   }
> >   /**
> > @@ -57,7 +59,7 @@ scmi_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> >   {
> >   	const struct scmi_handle *handle = to_scmi_handle(rcdev);
> > -	return handle->reset_ops->deassert(handle, id);
> > +	return reset_ops->deassert(handle, id);
> >   }
> >   /**
> > @@ -75,7 +77,7 @@ scmi_reset_reset(struct reset_controller_dev *rcdev, unsigned long id)
> >   {
> >   	const struct scmi_handle *handle = to_scmi_handle(rcdev);
> > -	return handle->reset_ops->reset(handle, id);
> > +	return reset_ops->reset(handle, id);
> >   }
> >   static const struct reset_control_ops scmi_reset_ops = {
> > @@ -91,9 +93,13 @@ static int scmi_reset_probe(struct scmi_device *sdev)
> >   	struct device_node *np = dev->of_node;
> >   	const struct scmi_handle *handle = sdev->handle;
> > -	if (!handle || !handle->reset_ops)
> > +	if (!handle)
> >   		return -ENODEV;
> > +	reset_ops = handle->get_ops(handle, SCMI_PROTOCOL_RESET);
> > +	if (IS_ERR(reset_ops))
> > +		return PTR_ERR(reset_ops);
> > +
> >   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >   	if (!data)
> >   		return -ENOMEM;
> > @@ -101,12 +107,19 @@ static int scmi_reset_probe(struct scmi_device *sdev)
> >   	data->rcdev.ops = &scmi_reset_ops;
> >   	data->rcdev.owner = THIS_MODULE;
> >   	data->rcdev.of_node = np;
> > -	data->rcdev.nr_resets = handle->reset_ops->num_domains_get(handle);
> > +	data->rcdev.nr_resets = reset_ops->num_domains_get(handle);
> >   	data->handle = handle;
> >   	return devm_reset_controller_register(dev, &data->rcdev);
> >   }
> > +static void scmi_reset_remove(struct scmi_device *sdev)
> > +{
> > +	const struct scmi_handle *handle = sdev->handle;
> > +
> > +	handle->put_ops(handle, SCMI_PROTOCOL_RESET);
> > +}
> > +
> >   static const struct scmi_device_id scmi_id_table[] = {
> >   	{ SCMI_PROTOCOL_RESET, "reset" },
> >   	{ },
> > @@ -116,6 +129,7 @@ MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> >   static struct scmi_driver scmi_reset_driver = {
> >   	.name = "scmi-reset",
> >   	.probe = scmi_reset_probe,
> > +	.remove = scmi_reset_remove,
> >   	.id_table = scmi_id_table,
> >   };
> >   module_scmi_driver(scmi_reset_driver);
> > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > index bc4f06d46bfb..bfe7017cff19 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -257,11 +257,6 @@ struct scmi_notify_ops {
> >    *
> >    * @dev: pointer to the SCMI device
> >    * @version: pointer to the structure containing SCMI version information
> > - * @power_ops: pointer to set of power protocol operations
> > - * @perf_ops: pointer to set of performance protocol operations
> > - * @clk_ops: pointer to set of clock protocol operations
> > - * @sensor_ops: pointer to set of sensor protocol operations
> > - * @reset_ops: pointer to set of reset protocol operations
> >    * @notify_ops: pointer to set of notifications related operations
> >    * @notify_priv: pointer to private data structure specific to notifications
> >    *	(for internal use only)
> > @@ -269,11 +264,11 @@ struct scmi_notify_ops {
> >   struct scmi_handle {
> >   	struct device *dev;
> >   	struct scmi_revision_info *version;
> > -	const struct scmi_perf_ops *perf_ops;
> > -	const struct scmi_clk_ops *clk_ops;
> > -	const struct scmi_power_ops *power_ops;
> > -	const struct scmi_sensor_ops *sensor_ops;
> > -	const struct scmi_reset_ops *reset_ops;
> > +
> > +	const void __must_check *(*get_ops)(const struct scmi_handle *handle,
> > +					    u8 proto);
> > +	void (*put_ops)(const struct scmi_handle *handle, u8 proto);
> > +
> >   	const struct scmi_notify_ops *notify_ops;
> >   	void *notify_priv;
> >   };
> > 
> 
> 
