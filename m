Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617E01CFBE0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgELRT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 13:19:59 -0400
Received: from foss.arm.com ([217.140.110.172]:58868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgELRT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:19:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56A841FB;
        Tue, 12 May 2020 10:19:58 -0700 (PDT)
Received: from bogus (unknown [10.37.12.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FC1E3F305;
        Tue, 12 May 2020 10:19:55 -0700 (PDT)
Date:   Tue, 12 May 2020 18:19:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jonathan.Cameron@Huawei.com,
        james.quinlan@broadcom.com, lukasz.luba@arm.com
Subject: Re: [PATCH v7 1/9] firmware: arm_scmi: Add notification
 protocol-registration
Message-ID: <20200512171949.GA23943@bogus>
References: <20200504163855.54548-1-cristian.marussi@arm.com>
 <20200504163855.54548-2-cristian.marussi@arm.com>
 <20200506152550.GA21779@arm.com>
 <20200511220403.GB17648@e119603-lin.cambridge.arm.com>
 <20200512170020.GC17648@e119603-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512170020.GC17648@e119603-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:00:20PM +0100, Cristian Marussi wrote:
> On Mon, May 11, 2020 at 11:04:03PM +0100, Cristian Marussi wrote:
> > Hi Dave
> >
> > thanks for the review first of all.
> >
> [snip]
>
> > > I'm not sure about scmi_notification_exit() (see below).
> [snip]
> > > > +/**
> > > > + * scmi_notification_exit()  - Shutdown and clean Notification core
> > > > + * @handle: The handle identifying the platform instance to shutdown
> > > > + */
> > > > +void scmi_notification_exit(struct scmi_handle *handle)
> > > > +{
> > > > +	struct scmi_notify_instance *ni = handle->notify_priv;
> > > > +
> > > > +	if (unlikely(!ni || !atomic_read(&ni->initialized)))
> > > > +		return;
> > > > +
> > > > +	atomic_set(&ni->enabled, 0);
> > > > +	/* Ensure atomic values are updated */
> > > > +	smp_mb__after_atomic();
> > >
> > > If users can race with this, we're dead: the atomic by itself doesn't
> > > ensure that handle is not in use once we arrive here.  Should this
> > > be a refcount instead?
> > >
> > > If users can't race with this, we probably don't protection here.
> > >
> > >
> > > I may be misunderstanding what this code is doing...
> > >
> >
> > First of all the enabled flag does not probably belong to this commit properly;
> > here is initialized but it is really fully used only in subsequent patches
> > (...so makes apparently little sense here... my bad...)
> >
> > Anyway, in general SCMI protocols (beside notifications stuff) are initialized
> > as depicted above, BUT they are never deinitialized explicitly (there's no
> > equivalent scmi_protocol_deinit()) and also proto devices are never destroyed:
> > so there's no scmi_protocol_deregister_events() neither in this series, because
> > it would have been tricky to properly invoke it and would have not been consistent
> > with the original SCMI design.
> >
> > On the other side since in protocol driver _remove() some general protos resources
> > are in fact freed anyway, for consistency I decided to free the devm notification
> > resources allocated with the above init() in scmi_notification_exit(): this should
> > happen only at system shutdown in fact when notification are no more of a concern.
> >
> > So given there's no explicit deregister I had to ensure somehow that the wanna-be-freed
> > notif devm resources were safe to be released.
> >
> > In this context the 'enabled' atomic flag is set to 0 @_exit to stop the dispatch of the
> > events (possibly still coming from the fw) from the ISR into the kfifo queues: once such
> > pkts flow is stopped I destroy_sync() (in a subsequent patch @_exit too) all the workqueues
> > fetching the events from the kfifos: this way I can be sure that all the notif resources
> > are no more used at all when I free all of them with devm_release() at the end.
> >
> > All of this is an additional precaution against buggy fw not stopping sending events
> > even when asked to do so (by drivers when deregistering notif callbacks in their shutdown)
> >
> > Give the above scenario on shutdown (which I never observed to tell the truth), and the fact
> > I'm freeing all devm res (including ni) at shutdown, it's now apparent ALSO that I cannot use
> > 'enabled' to keep stopped the flow in a safe way after its enclosing struct ni has been freed !
> >
> > So I'll remove the 'enable' atomic_t too and rely equally on the bare !ni check to determine
> > if the notification are enabled and should be dispatched. So that in
> >
>
> ...replying to my early self here (o_O)....I'd add that I've tested the above changes (removing
> initialized and enabled) triggering this _exit path by brutally unbinding the platform protocol
> driver and I can see the notifications flow stop and the queues emptied as expected without
> tragedy...the SCMI stack in general is not so happy though at that point, since it is not even
> supposed to be unloaded ever in fact...I wonder if this limit condition(unbind of a core SCMI
> driver which is not even modularizable in Kconfig) makes sense to be tested at all...
> (if not for testing this specific code path...)
>

We may need this eventually, I just kept initial implementation simple.
The scmi_drivers should be module and loading/unloading should be stable
and must work today.

Looking at the driver again, I am wondering why haven't I added
scmi_device_destroy in scmi_remove. We should be able to add that.

Lastly we can see how to make protocol registration and unregistration
as a module.

--
Regards,
Sudeep
