Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7187A28E569
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbgJNRcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:32:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388981AbgJNRcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:32:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11BFD6E;
        Wed, 14 Oct 2020 10:32:54 -0700 (PDT)
Received: from bogus (unknown [10.57.12.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25D473F71F;
        Wed, 14 Oct 2020 10:32:52 -0700 (PDT)
Date:   Wed, 14 Oct 2020 18:32:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix duplicate workqueue name
Message-ID: <20201014173109.dxi2asvkojkxdtwd@bogus>
References: <20201014021737.287340-1-f.fainelli@gmail.com>
 <20201014091806.GB20315@bogus>
 <872e84c9-ff49-c5a3-d07e-10a80b10ffa9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <872e84c9-ff49-c5a3-d07e-10a80b10ffa9@gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 10:08:32AM -0700, Florian Fainelli wrote:
> On 10/14/20 2:18 AM, Sudeep Holla wrote:
> > Hi Florian,
> >
> > Thanks for the patch, it shows someone else is also using this and
> > testing 😉.
> >
> > On Tue, Oct 13, 2020 at 07:17:37PM -0700, Florian Fainelli wrote:
> >> When more than a single SCMI device are present in the system, the
> >> creation of the notification workqueue with the WQ_SYSFS flag will lead
> >> to the following sysfs duplicate node warning:
> >>
> >
> > Please trim the calltrace next time without timestamp and register raw
> > hex values.
>
> Will do, thanks!
>

Thanks!

> >
> > You using this on 32-bit platform ? If so, thanks for additional test
> > coverage.
>
> We have a mix of ARMv7/LPAE (Brahma-B15) and ARMv8 (Brahma-B53,
> Cortex-A72) devices that we regularly test with 32-bit and 64-bit kernels.
>

Ah OK, good to know.

[...]

> >> Fix this by using dev_name(handle->dev) which guarantees that the name is
> >> unique and this also helps correlate which notification workqueue corresponds
> >> to which SCMI device instance.
> >>
> >
> > I am curious as how multiple SCMI instances are used. We know few limitations
> > in the code to handle that yet, so interested to know if you are carrying
> > more patches/fixes.
>
> We currently have two SCMI device nodes in Device Tree:
>
> - the first one is responsible for all of the base, performance, sensors
> protocols and is present on all of the chips listed above
>
> - the second one is responsible for a proprietary protocol through which
> we encapsulate a variety of operations towards a secure agent in the
> system, this is only present in a subset of devices.
>

And any particular reasons it can't exist in the same node. And also are
they talking to different SCMI firmware implementation meaning different
location in the system. The reason I ask is we have notion of one platform
with agent id = 0 as per the specification. It can be split in terms
of implementation and can have some side band communication amongst
themselves but can't have agent ID other than 0. It violates specification.

I don't have issues split it into 2 or more SCMI device as long as it
doesn't provide notion of existence of multiple SCMI platform firmware
implementations with different agent ID.

Also Cristian has posted patches to support custom protocols[1]. It would
be good if you can take a look/review/test/comment...

> The reason for that split was because the nature of the SCMI traffic was
> different, the first one is comprised of small messages dealing with
> power management, most messages can be completed synchronously (or
> quasi, if you remember our mailbox implementation) whereas the second is
> comprised of large and asynchronously completed messages. This is not
> probably a common set-up, and we have since eliminated that second SCMI
> interface and went with a direct Linux to agent interface that does not
> "speak" SCMI.
>

I still don't see strong reasons for splitting it. Also by above I assume
you still have one SCMI server/platform implementation and just different
types of transport for std vs custom protocol and all sorts of such combo.
I think we deal with that as long as they are of same transport type like
mailbox or smc.

> We may still have multiple SCMI devices in the future since we are
> trying to separate out the CPU performance domain which involves writing
> to registers that are either ARM system control registers, or only on an
> ARM CPU local bus. The other clock/performance controls can go directly
> to the agent implementing SCMI.
>

We have something called fastchannels for that. Your scmi perf protocol
can present those registers in those fastchannels if they are MMIO.
If they are system registers, then you need not use scmi at all for CPU
DVFS and still need one SCMI device for all other needs.

> >
> >> Fixes: bd31b249692e ("firmware: arm_scmi: Add notification dispatch and delivery")
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  drivers/firmware/arm_scmi/notify.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> >> index 4731daaacd19..24c9ef232f48 100644
> >> --- a/drivers/firmware/arm_scmi/notify.c
> >> +++ b/drivers/firmware/arm_scmi/notify.c
> >> @@ -1468,7 +1468,7 @@ int scmi_notification_init(struct scmi_handle *handle)
> >>  	ni->gid = gid;
> >>  	ni->handle = handle;
> >>
> >> -	ni->notify_wq = alloc_workqueue("scmi_notify",
> >> +	ni->notify_wq = alloc_workqueue(dev_name(handle->dev),
> >
> > Not sure if it makes sense to add "_notify" to clearly identify the workqueue.
>
> I had intentionally not done it because:
>

OK fair enough.

> - it would create a different name than "dev_name" and I liked having
> the same name throughout the entire sysfs hierarchy to easily identify
> the device
>

Good point. I was worried if we need to create another workqueue for
something else in the future.

> - it would require doing a sprintf() variant to format the name which
> require a temporary buffer
>

Indeed, which I tried but don't like.

> No strong preference either way though.

For now, we can have as is in your patch. We can address this if and
when we create another workqueue in scmi

--
Regards,
Sudeep
