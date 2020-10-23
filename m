Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F492970EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465153AbgJWNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:53306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S464793AbgJWNz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:55:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F80D113E;
        Fri, 23 Oct 2020 06:55:25 -0700 (PDT)
Received: from bogus (unknown [10.57.15.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3283E3F66B;
        Fri, 23 Oct 2020 06:55:24 -0700 (PDT)
Date:   Fri, 23 Oct 2020 14:55:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI
 performance domains
Message-ID: <20201023135521.pjv3ctpxrsg4z2oz@bogus>
References: <20201020203710.10100-1-sudeep.holla@arm.com>
 <CAL_JsqKH9pN7E7o+UY7YmOrOKCUigrMTxY3f3AH4PdpQUAaawg@mail.gmail.com>
 <20201021163021.lkqhum3xnyzt6pir@bogus>
 <CAL_JsqJFu-kn8uY9Jv0B-i2uNkx9wXg86N-aVTTH+zYz2MrxDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJFu-kn8uY9Jv0B-i2uNkx9wXg86N-aVTTH+zYz2MrxDA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 08:21:21AM -0500, Rob Herring wrote:
> On Wed, Oct 21, 2020 at 11:30 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Oct 21, 2020 at 11:20:27AM -0500, Rob Herring wrote:
> > > On Tue, Oct 20, 2020 at 3:37 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> > > > -EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
> > > > _allocate_opp_table() which is called from dev_pm_opp_add and it
> > > > now propagates the error back to the caller.
> > > >
> > > > SCMI performance domain re-used clock bindings to keep it simple. However
> > > > with the above mentioned change, if clock property is present in a device
> > > > node, opps can't be added until clk_get succeeds. So in order to fix the
> > > > issue, we can register dummy clocks which is completely ugly.
> > > >
> > > > Since there are no upstream users for the SCMI performance domain clock
> > > > bindings, let us introduce separate performance domain bindings for the
> > > > same.
> > > >
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  .../devicetree/bindings/arm/arm,scmi.txt      | 19 ++++++++++++++++---
> > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > >
> > > > Hi Rob/Viresh,
> > > >
> > > > This is actually a fix for the regression I reported here[1].
> > > > I am not adding fixes tag as I am targeting in the same release and
> > > > also because it is not directly related.
> > > >
> > > > Regards,
> > > > Sudeep
> > > >
> > > > [1] https://lore.kernel.org/r/20201015180555.gacdzkofpibkdn2e@bogus
> > > >
> > > > P.S.:/me records that this binding needs to be moved to yaml in v5.11
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > index 55deb68230eb..0a6c1b495403 100644
> > > > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > @@ -44,7 +44,7 @@ as described in the following sections. If the platform supports dedicated
> > > >  mboxes, mbox-names and shmem shall be present in the sub-node corresponding
> > > >  to that protocol.
> > > >
> > > > -Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
> > > > +Clock bindings for the clocks based on SCMI Message Protocol
> > > >  ------------------------------------------------------------
> > > >
> > > >  This binding uses the common clock binding[1].
> > > > @@ -52,6 +52,19 @@ This binding uses the common clock binding[1].
> > > >  Required properties:
> > > >  - #clock-cells : Should be 1. Contains the Clock ID value used by SCMI commands.
> > > >
> > > > +Performance bindings for the OPPs based on SCMI Message Protocol
> > > > +------------------------------------------------------------
> > > > +
> > > > +Required properties:
> > > > +- #perf-domain-cells: Should be 1. Contains the performance domain ID value
> > > > +                     used by SCMI commands.
> > >
> > > When is this not 1 (IOW, you only need this if variable)? How would it
> > > be used outside SCMI (given it has a generic name)?
> > >
> >
> > Ah, I thought we need this if phandle is followed by 1 or more arguments.
> > If it is not compulsory I can drop this or make it scmi specific if we
> > need it.
>
> No, your options are fixed or variable number of cells. If this is
> generic, then maybe it needs to be variable. If it's SCMI specific
> then it can likely be fixed unless you can think of other information
> you may need in the cells.
>

Understood.

> > > > +
> > > > +* Property arm,scmi-perf-domain
> > >
> > > Yet this doesn't have a generic name. You mentioned on IRC this is
> > > aligned with QCom, but why can't QCom use the same property here?
> > >
> >
> > This is SCMI firmware driven while they have hardware driven perf/freq
> > domains. So different drivers, need to distinguish between the two.
>
> So what if they are different drivers. That's *always* the case. The
> clock provider(s) for 'clocks' is different for every SoC? I doesn't
> matter who is the provider, it's the same information being described.
>

Fair enough. I was basing my argument on the fact that Qcom has users for
those bindings and I see limited scope for consolidation as that binding
has more information about the cpufreq-hw hardware block.

--
Regards,
Sudeep
