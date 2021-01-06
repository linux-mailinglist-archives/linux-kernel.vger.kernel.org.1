Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7F2EBBB8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbhAFJbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:31:44 -0500
Received: from foss.arm.com ([217.140.110.172]:37858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbhAFJbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:31:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81D81FB;
        Wed,  6 Jan 2021 01:30:57 -0800 (PST)
Received: from bogus (unknown [10.57.35.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E261E3F719;
        Wed,  6 Jan 2021 01:30:55 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:30:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
Message-ID: <20210106093053.tnlncqvcba7qnwnk@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBukX33YxVh8uuashC3grRVa1oZBig+-UD90YKgVUgSS=A@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 01:32:49PM -0500, Jim Quinlan wrote:

[...]

>
> I don't think that is the case;  the bottom routine,
> do_wait_for_common(), decrements the x->done after a completion (which
> does an increment).  Regardless, I think it is prudent to add the
> reinit patch you've provided below.
>

Ah right, but I will add that.

> BTW, one thing I could have done was incorporate the timeout value but
> I thought that since this is the "fast" call we shouldn't be timing
> out at all.
>

Agreed, we can add it later. However it is not related to fast call, it is
more for protection against failure of delivery of interrupt from the platform
or any firmware responsible IMO.

> > This electronic communication and the information and any files
> > transmitted with it, or attached to it, are confidential and are intended
> > solely for the use of the individual or entity to whom it is addressed and
> > may contain information that is confidential, legally privileged,
> > protected by privacy laws, or otherwise restricted from disclosure to
> > anyone else. If you are not the intended recipient or the person
> > responsible for delivering the e-mail to the intended recipient, you are
> > hereby notified that any use, copying, distributing, dissemination,
> > forwarding, printing, or copying of this e-mail is strictly prohibited. If
> > you received this e-mail in error, please return the e-mail to the sender,
> > delete it from your computer, and destroy any printed copy of it.

I am assuming this was unintentional and ignoring. If not disregard my
response. Otherwise you may need to fix your mail server.

--
Regards,
Sudeep
