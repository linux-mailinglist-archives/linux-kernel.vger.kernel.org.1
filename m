Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA362A8616
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbgKES1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:27:16 -0500
Received: from foss.arm.com ([217.140.110.172]:39630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgKES1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:27:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02CC01474;
        Thu,  5 Nov 2020 10:27:15 -0800 (PST)
Received: from bogus (unknown [10.57.22.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEDDE3F719;
        Thu,  5 Nov 2020 10:27:13 -0800 (PST)
Date:   Thu, 5 Nov 2020 18:27:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add bindings for BrcmSTB SCMI
 mailbox driver
Message-ID: <20201105182707.l4xx3wu2ch22qysi@bogus>
References: <20201029195913.5927-1-james.quinlan@broadcom.com>
 <20201029195913.5927-2-james.quinlan@broadcom.com>
 <20201104215050.GA4180546@bogus>
 <CA+-6iNw1Z1dj8oFn8DdyVPuMUP-3+n9sKXuWYWo2rfPo5j4dkA@mail.gmail.com>
 <CAL_JsqJQA_VLhez8y6HVCdFB2DZ85KoDZ1=RtbU4Mw98aQRSxA@mail.gmail.com>
 <CA+-6iNznMY78tJBeNrtyOy58DTKKPGxfgA0Pu2Rxx42YDJWV1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNznMY78tJBeNrtyOy58DTKKPGxfgA0Pu2Rxx42YDJWV1w@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 10:28:25AM -0500, Jim Quinlan wrote:
> On Thu, Nov 5, 2020 at 10:13 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Nov 4, 2020 at 4:04 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > >
> > > On Wed, Nov 4, 2020 at 4:50 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 29, 2020 at 03:59:06PM -0400, Jim Quinlan wrote:
> > > > > Bindings are added.  Only one interrupt is needed because
> > > > > we do not yet employ the SCMI p2a channel.
> > > >
> > > > I still don't understand what this is. To repeat from v1: I thought SCMI
> > > > was a mailbox consumer, not provider?
> > >
> > > Hi Rob,
> > >
> > > I'm not sure where I am implying that SCMI is a mailbox provider?
> > > Should I not mention "SCMI" in the subject line?
> > >
> > > This is just a mailbox driver, "consumed" by SCMI.    Our SCMI DT node
> > > looks like this:
> > >
> > > brcm_scmi_mailbox: brcm_scmi_mailbox@0 {
> > >         #mbox-cells = <1>;
> > >         compatible = "brcm,brcmstb-mbox";
> > > };
> > >
> > > brcm_scmi@0 {
> > >         compatible = "arm,scmi";
> > >         mboxes = <&brcm_scmi_mailbox 0>;;
> > >         mbox-names = "tx";
> > >         shmem = <&NWMBOX>;
> > >         /* ... */
> > > };
> >
> > Okay, that makes more sense. Though it seems like this is just adding
> > a pointless level of indirection to turn an interrupt into a mailbox.
> > There's nothing more to 'the mailbox' is there?
>
> Correct.  Although you can see that it uses both interrupts and SMC
> calls to get the job done.
>

I was against having 2 separate solutions and would have raised my concern
again. As I mentioned earlier, either extend what we have or move the
existing SMC solution into this mailbox driver. Having 2 different solution
for this just because you have extra interrupt to deal with is definite
NACK from me as I had previously mentioned.

> > So why not either
> > allow SCMI to have an interrupt directly
> Not sure here -- perhaps the SCMI folks have an answer?
>

I did ask why can't you extend the existing SCMI/SMC binding to add this
as optional feature ?

> > or have a generic irq mailbox driver?

Fine with this too.

> The SCMI implementation doesn't offer a generic irq mailbox driver
> AFAICT.  The SCMI folks recently provided  an "smc transport" driver
> in "drivers/firmware/arm_scmi/smc.c" -- it is close to what we need
> but is missing interrupts.

IIRC, you were using SGIs and it can't be represented and use today as
is ? Am  I missing something or anything has changed ?

--
Regards,
Sudeep
