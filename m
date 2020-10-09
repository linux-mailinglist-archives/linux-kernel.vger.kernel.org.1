Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE9288EEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbgJIQbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:31:25 -0400
Received: from foss.arm.com ([217.140.110.172]:55446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389662AbgJIQbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:31:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C394D6E;
        Fri,  9 Oct 2020 09:31:24 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1B03F66B;
        Fri,  9 Oct 2020 09:31:23 -0700 (PDT)
Date:   Fri, 9 Oct 2020 17:31:13 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        cristian.marussi@arm.com
Subject: Re: [PATCH 1/5] firmware: arm_scmi: always initialize protocols
Message-ID: <20201009162916.GA1105@e120937-lin>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008191727.ht26r5dnh3iwqj5n@bogus>
 <CAN5uoS9YffDZa6YOnJ_35ueMbkvCPuQ1=0KAuX5=k=kQYm+_Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS9YffDZa6YOnJ_35ueMbkvCPuQ1=0KAuX5=k=kQYm+_Ng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne,

On Fri, Oct 09, 2020 at 02:31:55PM +0200, Etienne Carriere wrote:
> On Thu, 8 Oct 2020 at 21:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Oct 08, 2020 at 04:37:18PM +0200, Etienne Carriere wrote:
> > > Remove the IDR replacement that prevent initializing an SCMI protocol
> > > when it has already been initialized. This is needed when there are
> > > several SCMI agents that do implement a given SCMI protocol unless
> > > what only the related SCMI protocol communication is initialized only
> > > for first probed agent.
> > >
> >
> > Can you please elaborate on your usecase please. What do you mean by several
> > SCMI agents here. OSPM is the only agent we are interested here. What
> > other agents is this driver supposed to handle here. We allocate memory
> > in init and calling init multiple times messes up the allocated and
> > initialised structures.
> >
> > So NACK for this patch as it needs more work if we need this at all.
> >
> 
> Hello Sudeep,
> 
> Considering a device with several SCMI servers spread over several co-processor
> and possibly also in the Arm TZ secure world, each of these servers
> uses a specific
> SCMI channel. Without this change, each SCMI protocol gets initialized
> only for the
> first agent device that is probed.
> 
> My setup is also a bit specific. My device has several secure configuration
> features that can individually be enabled or not. For example, configuring
> domain X as secure makes some clocks reachable by Linux only through SCMI,
> and configuring domain Y as secure makes other clocks reachable by Linux
> only through SCMI. For flexibility, I expose domain X resources (here clocks)
> to an Linux agent whereas domain Y resources (here clocks also) are
> exposed to another agent, each agent with its specific transport/channel.
> Enabling each agent node in the Linux FDT allows to define which SCMI clocks
> get exposed and hence registered in the kernel.
> Without the change proposed here, I cannot get the clocks exposed to both
> agents when enabled as the SCMI clock protocol is initialized only for the 1st
> probbed agent device.
> 

Just a heads up that I have a series to be posted soon(ish) that is
meant to address vendor protocols support and more in general protocols
modularization by simplifying and reorganizing 'a bit' the whole
initialization process and the handle interface itself: in that context
I've got rid as a whole of the above protocol initialization code inside
device probing and moved it at the time of first usage of the protocol,
i.e. when the first SCMI driver, inside its probe, attempts to get hold
of a protocol issuing something like:

	perf_ops = handle->get_ops(handle, SCMI_PROTOCOL_PERF);

This will effectively trigger a run of the usual protocol initialization
code if the protocol was still NOT initialized (no previous get_ops) for
that SCMI instance (server): so if your SCMI driver/device gets instantiated
multiple times against multiple different servers, the needed protocol(s)
will be initialized multiple times one for each instance (handle) upon
first usage, while any other further instance of another SCMI driver
requesting the same, already initialized, protocol will find it ready to go.

Cleanup/deinitialization is delegated to a corresponding handle->put_ops(),
while the general notifications will still be available using the current
.notify_ops() interface, but those requests will be now tracked
internally against the relevant protocol in order to avoid premature
deinitialization or removal of still in-use protocols.

Thanks

Cristian

> Regards,
> Etienne
> 
> > --
> > Regards,
> > Sudeep
