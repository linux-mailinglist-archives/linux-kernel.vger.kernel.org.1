Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26D928B1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgJLJc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:32:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLJc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:32:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71F7D31B;
        Mon, 12 Oct 2020 02:32:25 -0700 (PDT)
Received: from bogus (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58E223F66B;
        Mon, 12 Oct 2020 02:32:24 -0700 (PDT)
Date:   Mon, 12 Oct 2020 10:32:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH 1/5] firmware: arm_scmi: always initialize protocols
Message-ID: <20201012092827.GB16519@bogus>
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
> uses a specific SCMI channel. Without this change, each SCMI protocol gets
> initialized only for the first agent device that is probed.
>

Fair enough, but it also adds complexity. Do you have a master SCMI server
implementation in that case. As some protocols like system might need to
be broadcast to all servers and master server needs to take appropriate
action.

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

OK, as Cristian has already mentioned we need to clean up a bit on these
initcalls and Cristian has some WIP patches, I would like to wait and look
at them instead of breaking other usecases with patch(multiple devices
per protocol within one scmi server)

-- 
Regards,
Sudeep
