Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA56B28E56E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbgJNRf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:35:26 -0400
Received: from foss.arm.com ([217.140.110.172]:54574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNRf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:35:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB929D6E;
        Wed, 14 Oct 2020 10:35:25 -0700 (PDT)
Received: from bogus (unknown [10.57.12.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B64513F71F;
        Wed, 14 Oct 2020 10:35:24 -0700 (PDT)
Date:   Wed, 14 Oct 2020 18:35:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix duplicate workqueue name
Message-ID: <20201014173522.ugrdswnkrmrnmudv@bogus>
References: <20201014021737.287340-1-f.fainelli@gmail.com>
 <20201014091806.GB20315@bogus>
 <872e84c9-ff49-c5a3-d07e-10a80b10ffa9@gmail.com>
 <20201014173109.dxi2asvkojkxdtwd@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201014173109.dxi2asvkojkxdtwd@bogus>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 06:32:42PM +0100, Sudeep Holla wrote:
> On Wed, Oct 14, 2020 at 10:08:32AM -0700, Florian Fainelli wrote:
> > On 10/14/20 2:18 AM, Sudeep Holla wrote:
> > > Hi Florian,
> > >
> > > Thanks for the patch, it shows someone else is also using this and
> > > testing 😉.
> > >
> > > On Tue, Oct 13, 2020 at 07:17:37PM -0700, Florian Fainelli wrote:
> > >> When more than a single SCMI device are present in the system, the
> > >> creation of the notification workqueue with the WQ_SYSFS flag will lead
> > >> to the following sysfs duplicate node warning:
> > >>
> > >
> > > Please trim the calltrace next time without timestamp and register raw
> > > hex values.
> >
> > Will do, thanks!
> >
> 
> Thanks!
> 
> > >
> > > You using this on 32-bit platform ? If so, thanks for additional test
> > > coverage.
> >
> > We have a mix of ARMv7/LPAE (Brahma-B15) and ARMv8 (Brahma-B53,
> > Cortex-A72) devices that we regularly test with 32-bit and 64-bit kernels.
> >
> 
> Ah OK, good to know.
> 
> [...]
> 
> > >> Fix this by using dev_name(handle->dev) which guarantees that the name is
> > >> unique and this also helps correlate which notification workqueue corresponds
> > >> to which SCMI device instance.
> > >>
> > >
> > > I am curious as how multiple SCMI instances are used. We know few limitations
> > > in the code to handle that yet, so interested to know if you are carrying
> > > more patches/fixes.
> >
> > We currently have two SCMI device nodes in Device Tree:
> >
> > - the first one is responsible for all of the base, performance, sensors
> > protocols and is present on all of the chips listed above
> >
> > - the second one is responsible for a proprietary protocol through which
> > we encapsulate a variety of operations towards a secure agent in the
> > system, this is only present in a subset of devices.
> >
> 
> And any particular reasons it can't exist in the same node. And also are
> they talking to different SCMI firmware implementation meaning different
> location in the system. The reason I ask is we have notion of one platform
> with agent id = 0 as per the specification. It can be split in terms
> of implementation and can have some side band communication amongst
> themselves but can't have agent ID other than 0. It violates specification.
> 
> I don't have issues split it into 2 or more SCMI device as long as it
> doesn't provide notion of existence of multiple SCMI platform firmware
> implementations with different agent ID.
> 
> Also Cristian has posted patches to support custom protocols[1]. It would
> be good if you can take a look/review/test/comment...
> 

Pressed enter too early, link added now.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20201014150545.44807-1-cristian.marussi@arm.com
