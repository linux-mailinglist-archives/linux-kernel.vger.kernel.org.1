Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F63529714D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750593AbgJWO1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:27:36 -0400
Received: from foss.arm.com ([217.140.110.172]:53910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750553AbgJWO1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:27:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A6F1113E;
        Fri, 23 Oct 2020 07:27:34 -0700 (PDT)
Received: from bogus (unknown [10.57.15.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1E9C3F66B;
        Fri, 23 Oct 2020 07:27:32 -0700 (PDT)
Date:   Fri, 23 Oct 2020 15:27:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI
 performance domains
Message-ID: <20201023142730.ru4rfoj3atxyinww@bogus>
References: <20201020203710.10100-1-sudeep.holla@arm.com>
 <CAL_JsqKH9pN7E7o+UY7YmOrOKCUigrMTxY3f3AH4PdpQUAaawg@mail.gmail.com>
 <20201021181951.xu2igea2qbca3alf@bogus>
 <CAL_JsqJ0OO68AbML7osOU3fNzJk3NhXYrWVmNwn8mwtNzSuf8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ0OO68AbML7osOU3fNzJk3NhXYrWVmNwn8mwtNzSuf8g@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 08:34:05AM -0500, Rob Herring wrote:
> On Wed, Oct 21, 2020 at 1:19 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Oct 21, 2020 at 11:20:27AM -0500, Rob Herring wrote:
> > > On Tue, Oct 20, 2020 at 3:37 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> >
> > [...]
> >
> > >
> > > When is this not 1 (IOW, you only need this if variable)? How would it
> > > be used outside SCMI (given it has a generic name)?
> > >
> > > > +
> > > > +* Property arm,scmi-perf-domain
> > >
> > [...]
> >
> > > Really though, why can't you give SCMI a CPUs MPIDR and get its domain?
> > >
> >
> > Now I remembered why we can't use MPIDR. The spec talks about perf domains
> > for devices in generic. CPU is just a special device. We will still need
> > a mechanism to get device performance domain. So MPIDR idea was dropped to
> > keep it uniform across all the devices.
>
> What implications to the binding are there for non-CPU devices? Do
> they need more cells? How does this integrate our plethora of other PM
> related bindings?
>

Ideally it is just a device perf domain ID. SCMI f/w will just assign
perf domain IDs for both CPUs and other devices like GPUs sequentially
without any distinction.

However, I can't speak about other aspects of PM especially on wild
variety of platforms we have on Arm.

Today even with SCMI each device/cpu needs to track clock or performance,
reset, power, voltage, ...etc domains and their IDs needs to be passed
via DT.

We are thinking of making all these device ID centric in future. It means
if the device tree had scmi device ID for each of them, we must be able to
perform any power management or configuration management on that device.
SCMI f/w must then abstract everything at device level. Just a thought
as of now and it aligns with some of the ACPI concepts.

> So somewhere in the firmware we're defining device X is domain 0,
> device Y is domain 1, etc. Then we do this again in DT. Seems fragile
> to define this information twice. I guess that's true for any number
> space SCMI defines.
>

Correct and agreed on your point. Any ideas to make this discoverable ?
Atleast with SCMI, we have been able to reduce the amount of information
just to that ID(though there are multiple ID space today for each aspects
of PM and config management). As I mentioned we would like to make it
device centric. Any thoughts on making IDs discoverable is appreciated.

We thought about names and other things during initial days of the
spec evolution, but we circled back to how does OS provide that info and
we go back to DT/ACPI which was not too bad at that time. We can see if
we can improve anything there.

--
Regards,
Sudeep
