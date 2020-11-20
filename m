Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1186C2BABA9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgKTOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:09:06 -0500
Received: from foss.arm.com ([217.140.110.172]:49740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgKTOJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:09:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 128E111D4;
        Fri, 20 Nov 2020 06:09:04 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24C8E3F718;
        Fri, 20 Nov 2020 06:09:02 -0800 (PST)
Date:   Fri, 20 Nov 2020 14:09:00 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
Message-ID: <20201120140900.et6kkskv7rrzq7j4@bogus>
References: <20201112175632.42234-1-james.quinlan@broadcom.com>
 <20201112175632.42234-3-james.quinlan@broadcom.com>
 <20201113094732.4bcyjs7zz7vwg4of@bogus>
 <CA+-6iNxZ73gYtjP54kBJhcwzL5h4Co6Wh8-Nk4poqLV0s=jA8w@mail.gmail.com>
 <20201113143627.jxxha7uejhjucwbz@bogus>
 <CA+-6iNz099CQQky7U7vm7w7s=QAECauuosLAf7zC4hWNFZ9yqQ@mail.gmail.com>
 <CA+-6iNw2+uGX3W3boiNokbVwaK2MseJORPq8mDpc+SihoLSOQw@mail.gmail.com>
 <20201120111427.erqfowx4rosuktao@bogus>
 <CA+-6iNwVM6EOXBUk2DY6+xZHn0R-JDP0wsfinqjET6Xs-Ovqww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwVM6EOXBUk2DY6+xZHn0R-JDP0wsfinqjET6Xs-Ovqww@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 08:27:38AM -0500, Jim Quinlan wrote:
> On Fri, Nov 20, 2020 at 6:14 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Nov 19, 2020 at 01:34:18PM -0500, Jim Quinlan wrote:
> > > On Fri, Nov 13, 2020 at 10:12 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > > >
> > > > On Fri, Nov 13, 2020 at 9:36 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > On Fri, Nov 13, 2020 at 09:26:43AM -0500, Jim Quinlan wrote:
> > > > > > Hi, these are fast calls.  Regards, Jim
> > > > > >
> > > > > >
> > > > > > On Fri, Nov 13, 2020 at 4:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > >
> > > > > > > On Thu, Nov 12, 2020 at 12:56:27PM -0500, Jim Quinlan wrote:
> > > > > > > > The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> > > > > > > > message to be indicated by an interrupt rather than the return of the smc
> > > > > > > > call.  This accommodates the existing behavior of the BrcmSTB SCMI
> > > > > > > > "platform" whose SW is already out in the field and cannot be changed.
> > > > > > > >
> > > > > > >
> > > > > > > Sorry for missing to check with you earlier. Are these not fast smc calls ?
> > > > > > > Can we check the SMC Function IDs for the same and expect IRQ to be present
> > > > > > > if they are not fast calls ?
> > > > > > Hi, if I understand you correctly you want to do something like this:
> > > > > >
> > > > > >  if (! ARM_SMCCC_IS_FAST_CALL(func_id)) {
> > > > > >         /* look for irq and request it */
> > > > > > }
> > > > > >
> > > > >
> > > > > Yes.
> > > > >
> > > > > > But we  do use fast calls.
> > > > >
> > > > > What was the rationale for retaining fast SMC calls but use IRQ for Tx
> > > > > completion ?
> > > > >
> > > > > Is it because you offload it to some other microprocessor and don't
> > > > > continue execution on secure side in whcih case you can afford fast call ?
> > > Hi Sudeep,
> > >
> >
> > Thanks for the details. Unfortunately more questions:
> >
> > > Here is my understanding:  Some SMC calls may take a few longer to
> > > complete than others. The longer ones tie up the CPU core that is
> > > handling the SMC call, and so nothing can be scheduled on that
> > > specific core.
> >
> > So far good.
> >
> > > Unfortunately, we have a real-time OS that runs
> > > sporadically on one specific core and if that happens to be the same
> > > core that is handling the SMC, the RTOS will miss its deadline.  So we
> > > need to have the SMC return immediately and use an SGI for task
> > > completion.
> > >
> >
> > So it sounds more like it can't be fast call then.
> Hi Sudeep,
>
> To be honest,  I'm not sure what the big difference between fast and
> slow SMC calls are other than the latter is "yielding" and
> interruptible.  We cannot tolerate them being interruptible.
>

OK

> >
> > Does that me, it will always return early and send SGI when the request
> > is complete ?
> Most calls send the SGI and return immediately.  The ones that take
> longer return from the SMC and send the SGI when the operation is
> completed.

That's relief.

> >
> > 1. If yes, what happens if there are multiple requests in parallel and
> >    second one completes before the first. Can we handle that with this
> >    patch set. Of will the second request fails until the first one is
> >    complete ? It extends to number of cpus in the system worst case.
>
> With SCMI we only have one message pending  at  a time;  perhaps I do
> not understand your question.  Having the SMC return is mostly a no-op
> as far as the SCMI  driver is concerned.
>

Yes we have lock, I forgot. There are requirements to make the smc atomic
by some vendors, was thinking about that and forgot about the lock and
how what I explained can never happen. Thanks for the patience.

If you ping and get Rob's ack on DT, I can take this patch along with
DT bindings for now as is. We can always enhance if required.

> Our SCMI messages cannot fail.  When we do have timeouts it indicates
> that something is wrong and needs to be fixed.
>

Good to know.

--
Regards,
Sudeep
