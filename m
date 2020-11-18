Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E928D2B7D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKRMFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:05:07 -0500
Received: from foss.arm.com ([217.140.110.172]:53014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKRMFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:05:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCCE7D6E;
        Wed, 18 Nov 2020 04:05:05 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 786BF3F70D;
        Wed, 18 Nov 2020 04:05:04 -0800 (PST)
Date:   Wed, 18 Nov 2020 12:05:02 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        arnd@arndb.de, robh@kernel.org
Subject: Re: [PATCH v3] firmware: arm_scmi: Add SCMI System Power Control
 driver
Message-ID: <20201118120440.GA11909@e120937-lin>
References: <20201117155725.13502-1-cristian.marussi@arm.com>
 <X7P4lA1nITo58eFT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7P4lA1nITo58eFT@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

thanks for the review.

On Tue, Nov 17, 2020 at 05:21:40PM +0100, Greg KH wrote:
> On Tue, Nov 17, 2020 at 03:57:25PM +0000, Cristian Marussi wrote:
> > +/**
> > + * scmi_request_timeout  - On timeout trigger a forceful transition
> > + * @t: The timer reference
> > + *
> > + * Actual work is deferred out of the timer IRQ context since shutdown/reboot
> > + * code do not play well when !in_task().
> > + */
> > +static void scmi_request_timeout(struct timer_list *t)
> > +{
> > +	struct scmi_syspower_config *conf = from_timer(conf, t, request_timer);
> > +
> > +	dev_warn(conf->dev,
> > +		 "SCMI Graceful System Transition request timed out !\n");
> 
> Don't be noisy please, what can a user do about this?
> 

This is something that should not happen normally so I thought it was an
error worth to be logged, but in fact it's worth only if you consider
as a user the developer himself or someone tuning the system,
I'll drop to _dbg.

> 
> > +	atomic_set(&conf->status, SCMI_SYSPOWER_FORCING);
> > +	/* Ensure atomic values are updated */
> > +	smp_mb__after_atomic();
> > +	schedule_work(&conf->forceful_work);
> 
> Um, what is that smp_mb__after_atomic() and the whole mess here for?
> 
> What exactly are you thinking this whole mess is needed for, and how is
> it working and why not just use a simple lock that handles everything
> instead?
> 

In my broken understanding of atomics some atomic_ops do not imply a
barrier so you have to add it explictly, but here there's really nothing
beside the atomic (and possibly the schedule itself would be enough
anwyay....)...so the barriers are messed up (I'm clearly in need of
another N reads of memory-barriers.txt) and I'll simplify the state
machine not to use atomics...as you pointed out below.

> > +}
> > +
> > +/**
> > + * scmi_reboot_notifier  - A reboot_notifier to catch an ongoing successful
> > + * system transition
> > + * @nb: Reference to the related notifier block
> > + * @reason: The reason for the ongoing reboot
> > + * @__unused: The cmd being executed on a restart request (unused)
> > + *
> > + * When an ongoing system transition is detected, compatible with the requested
> > + * one, cancel the timer work.
> > + *
> > + * Return: NOTIFY_OK in any case
> > + */
> > +static int scmi_reboot_notifier(struct notifier_block *nb,
> > +				unsigned long reason, void *__unused)
> > +{
> > +	struct scmi_syspower_config *conf;
> > +
> > +	conf = container_of(nb, struct scmi_syspower_config, reboot_nb);
> > +
> > +	/* Ensure atomic values are updated */
> > +	smp_mb__before_atomic();
> 
> What?
> 

Again uneeded.

> > +	if (unlikely(atomic_read(&conf->status) == SCMI_SYSPOWER_FORCING))
> > +		return NOTIFY_OK;
> 
> Unless you can benchmark the benifit of using likely/unlikely, do not
> use it, as the compiler/CPU will do it better for you.
> 

Ok.

> > +
> > +	switch (reason) {
> > +	case SYS_HALT:
> > +	case SYS_POWER_OFF:
> > +		if (conf->required_state == SCMI_SYSTEM_SHUTDOWN)
> > +			atomic_set(&conf->status, SCMI_SYSPOWER_INPROGRESS);
> 
> Why are you trying to use an atomic variable for a state machine?  Why
> not a simple enum and a lock?
> 

It seemed easier to use atomics given that the state machine itself is
trivial and under the false assumption of mine that it was better to
avoid grabbing more locks while shutting down the system.

I'll drop the atomics and review the states to simplify.

> > +		break;
> > +	case SYS_RESTART:
> > +		if (conf->required_state == SCMI_SYSTEM_COLDRESET ||
> > +		    conf->required_state == SCMI_SYSTEM_WARMRESET)
> > +			atomic_set(&conf->status, SCMI_SYSPOWER_INPROGRESS);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	/* Ensure atomic values are updated */
> > +	smp_mb__after_atomic();
> > +	if (atomic_read(&conf->status) == SCMI_SYSPOWER_INPROGRESS) {
> > +		dev_info(conf->dev,
> > +			 "SCMI System State request in progress...\n");
> > +		del_timer_sync(&conf->request_timer);
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static inline void scmi_send_cad_signal(struct device *dev, unsigned int sig)
> > +{
> > +	dev_info(dev, "SCMI Sending signal %d to CAD pid\n", sig);
> 
> When drivers work properly, they are quiet, don't be noisy.
> 
> You do that in many other places in this codebase, just remove them all,
> or make them dev_dbg() if you really want to see them in the future.
> 

As you pointed out in general I've been way too much noisy in this
driver and I'll drop them or reduce to debug most of it, but I was thinking
that given that the end result of all of this is a shutdown/reboot event
it would have been important to at least log somewhere who triggered it and
how, but I can drop all of them to _dbg if worthless.

> > +
> > +	kill_cad_pid(sig, 1);
> > +}
> > +
> > +/**
> > + * scmi_request_graceful_transition  - Request graceful SystemPower transition
> > + * @conf: The current SystemPower configuration descriptor
> > + *
> > + * Initiates the required SystemPower transition, requesting userspace
> > + * co-operation using the same orderly_ methods used by ACPI Shutdown event
> > + * processing.
> > + *
> > + * This takes care also to register a reboot notifier and a timer callback in
> > + * order to detect if userspace actions are taking too long; in such a case
> > + * the timeout callback will finally perform a forceful transition, ignoring
> > + * lagging userspace: the aim here is to at least perform an emergency_sync()
> > + * and a clean shutdown or reboot transition when userspace is late, avoiding
> > + * the brutal final power-cut from platform.
> > + */
> > +static void scmi_request_graceful_transition(struct scmi_syspower_config *conf)
> > +{
> > +	int ret;
> > +	u32 status;
> > +
> > +	if (conf->required_state >= SCMI_SYSTEM_POWERUP) {
> > +		dev_warn(conf->dev,
> > +			 "Received unexpected SYSTEM POWER request: %d\n",
> > +			 conf->required_state);
> > +		return;
> > +	}
> > +
> > +	status = atomic_cmpxchg(&conf->status, SCMI_SYSPOWER_IDLE,
> > +				SCMI_SYSPOWER_SERVED);
> > +	if (status != SCMI_SYSPOWER_IDLE)
> > +		return;
> > +
> > +	ret = devm_register_reboot_notifier(conf->dev, &conf->reboot_nb);
> > +	if (ret)
> > +		dev_warn(conf->dev, "Cannot register reboot notifier !\n");
> 
> And you keep going?  Why?
> 

I track reboot progress so that:

- if not completed within a reasonable time from the SCMI request reception
  I can at least try an emergency sync and kernel_power_off() before the fw
  cuts finally the power

- if a bogus fw sends multiple system power request I can just ignore
  them all but the first one once the reboot has started: the alternative
  would have been to disable System Power notifications after the first
  good one received, so in fact sending fw more commands to disable such
  notifications, and it seemed to me not a safe thing to do with a possibly
  already misbehaving fw. (which anyway is shutting down)

But all of the above is just a best effort to make the most possible clean
shutdown, if devm_register_reboot_notifier() fails why giving up as a whole
without even attempting to shutdown/reboot as requested ?

I should add a comment why carrying on on failure make sense maybe...

> > +
> > +	INIT_WORK(&conf->forceful_work, scmi_forceful_work_func);
> > +	conf->request_timer.expires = jiffies +
> > +				msecs_to_jiffies(scmi_graceful_request_tmo_ms);
> > +	timer_setup(&conf->request_timer, scmi_request_timeout, 0);
> > +	add_timer(&conf->request_timer);
> > +
> > +	dev_info(conf->dev,
> > +		 "Serving SCMI Graceful request: %d (timeout_ms:%d)\n",
> > +		 conf->required_state, scmi_graceful_request_tmo_ms);
> 
> Again, be quiet.
> 

Ok.
> > +
> > +	switch (conf->required_state) {
> > +	case SCMI_SYSTEM_SHUTDOWN:
> > +		/*
> > +		 * When received early at boot-time the 'orderly' part will
> > +		 * fail due to the lack of userspace itself, but the force=true
> > +		 * argument will anyway be able trigger a successful forced
> > +		 * shutdown.
> > +		 */
> > +		if (!scmi_graceful_poweroff_signum)
> > +			orderly_poweroff(true);
> > +		else
> > +			scmi_send_cad_signal(conf->dev,
> > +					     scmi_graceful_poweroff_signum);
> > +		break;
> > +	case SCMI_SYSTEM_COLDRESET:
> > +	case SCMI_SYSTEM_WARMRESET:
> > +		if (!scmi_graceful_reboot_signum)
> > +			orderly_reboot();
> > +		else
> > +			scmi_send_cad_signal(conf->dev,
> > +					     scmi_graceful_reboot_signum);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +static void scmi_request_forceful_transition(struct scmi_syspower_config *conf)
> > +{
> > +	/* Ensure atomic values are updated */
> > +	smp_mb__before_atomic();
> > +	if (unlikely(atomic_read(&conf->status) == SCMI_SYSPOWER_INPROGRESS))
> > +		return;
> > +
> > +	dev_info(conf->dev, "Serving SCMI FORCEFUL SystemPower request:%d\n",
> > +		 conf->required_state);
> 
> {ssshhh}
> 
ok
> > +
> > +	emergency_sync();
> > +	switch (conf->required_state) {
> > +	case SCMI_SYSTEM_SHUTDOWN:
> > +		kernel_power_off();
> > +		break;
> > +	case SCMI_SYSTEM_COLDRESET:
> > +	case SCMI_SYSTEM_WARMRESET:
> > +		kernel_restart(NULL);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +#define SCMI_IS_REQUEST_GRACEFUL(flags)		((flags) & BIT(0))
> > +
> > +/**
> > + * scmi_userspace_notifier  - Notifier callback to act on SystemPower
> > + * Notifications
> > + * @nb: Reference to the related notifier block
> > + * @event: The SystemPower notification event id
> > + * @data: The SystemPower event report
> > + *
> > + * This callback is in charge of decoding the received SystemPower report
> > + * and act accordingly triggering a graceful or forceful system transition.
> > + *
> > + * Return: NOTIFY_OK in any case
> > + */
> > +static int scmi_userspace_notifier(struct notifier_block *nb,
> > +				   unsigned long event, void *data)
> > +{
> > +	struct scmi_system_power_state_notifier_report *er = data;
> > +	struct scmi_syspower_config *conf;
> > +
> > +	if (unlikely(system_state > SYSTEM_RUNNING))
> > +		return NOTIFY_OK;
> 
> no unlikely please.
> 
> 
Ok
> 
> > +
> > +	conf = container_of(nb, struct scmi_syspower_config, userspace_nb);
> > +	conf->required_state = er->system_state;
> > +
> > +	if (conf->required_state >= SCMI_SYSTEM_MAX)
> > +		return NOTIFY_OK;
> > +
> > +	if (SCMI_IS_REQUEST_GRACEFUL(er->flags))
> > +		conf->request_graceful_transition(conf);
> > +	else
> > +		conf->request_forceful_transition(conf);
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +/**
> > + * scmi_syspower_configure  - General SystemPower configuration init
> > + * @dev: The associated struct device
> > + *
> > + * Return: SystemPower configuration descriptor on Success, NULL otherwise
> > + */
> > +static void *scmi_syspower_configure(struct device *dev)
> > +{
> > +	struct scmi_syspower_config *conf;
> > +
> > +	conf = devm_kzalloc(dev, sizeof(*conf), GFP_KERNEL);
> > +	if (!conf)
> > +		return NULL;
> > +
> > +	conf->dev = dev;
> > +	conf->required_state = SCMI_SYSTEM_MAX;
> > +	conf->request_graceful_transition = &scmi_request_graceful_transition;
> > +	conf->request_forceful_transition = &scmi_request_forceful_transition;
> > +	conf->userspace_nb.notifier_call = &scmi_userspace_notifier;
> > +	conf->reboot_nb.notifier_call = &scmi_reboot_notifier;
> > +	atomic_set(&conf->status, SCMI_SYSPOWER_IDLE);
> > +	/* Ensure atomic values are updated */
> > +	smp_mb__after_atomic();
> 
> Why is this needed?
> 

Not really needed all this dynalloc thing, nor the funcpoimters for this
driver, I'll drop it.

Thanks

Cristian

> thanks,
> 
> greg k-h
