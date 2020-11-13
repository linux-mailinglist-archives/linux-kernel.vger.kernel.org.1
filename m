Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0162B1D92
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKMOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:36:32 -0500
Received: from foss.arm.com ([217.140.110.172]:39460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgKMOgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:36:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3425142F;
        Fri, 13 Nov 2020 06:36:31 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744703F6CF;
        Fri, 13 Nov 2020 06:36:30 -0800 (PST)
Date:   Fri, 13 Nov 2020 14:36:27 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
Message-ID: <20201113143627.jxxha7uejhjucwbz@bogus>
References: <20201112175632.42234-1-james.quinlan@broadcom.com>
 <20201112175632.42234-3-james.quinlan@broadcom.com>
 <20201113094732.4bcyjs7zz7vwg4of@bogus>
 <CA+-6iNxZ73gYtjP54kBJhcwzL5h4Co6Wh8-Nk4poqLV0s=jA8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNxZ73gYtjP54kBJhcwzL5h4Co6Wh8-Nk4poqLV0s=jA8w@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 09:26:43AM -0500, Jim Quinlan wrote:
> Hi, these are fast calls.  Regards, Jim
> 
> 
> On Fri, Nov 13, 2020 at 4:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Nov 12, 2020 at 12:56:27PM -0500, Jim Quinlan wrote:
> > > The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> > > message to be indicated by an interrupt rather than the return of the smc
> > > call.  This accommodates the existing behavior of the BrcmSTB SCMI
> > > "platform" whose SW is already out in the field and cannot be changed.
> > >
> >
> > Sorry for missing to check with you earlier. Are these not fast smc calls ?
> > Can we check the SMC Function IDs for the same and expect IRQ to be present
> > if they are not fast calls ?
> Hi, if I understand you correctly you want to do something like this:
>
>  if (! ARM_SMCCC_IS_FAST_CALL(func_id)) {
>         /* look for irq and request it */
> }
>

Yes.

> But we  do use fast calls.

What was the rationale for retaining fast SMC calls but use IRQ for Tx
completion ?

Is it because you offload it to some other microprocessor and don't
continue execution on secure side in whcih case you can afford fast call ?

--
Regards,
Sudeep
