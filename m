Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33FC28B0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgJLI55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:57:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLI55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:57:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48EA031B;
        Mon, 12 Oct 2020 01:57:56 -0700 (PDT)
Received: from bogus (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833103F66B;
        Mon, 12 Oct 2020 01:57:54 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:57:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/5] firmware: arm_scmi: smc transport supports
 multi-message pool
Message-ID: <20201012085546.GA16519@bogus>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-4-etienne.carriere@linaro.org>
 <20201008211116.l6gbym2ypb6lzlo7@bogus>
 <CAN5uoS8tz0wXkD1dtFbAYBWHvngHG8KeUD2JkK32siPa2MwgYA@mail.gmail.com>
 <20201009151752.fxqakqrritrgzo4r@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009151752.fxqakqrritrgzo4r@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 04:17:52PM +0100, Sudeep Holla wrote:
> On Fri, Oct 09, 2020 at 02:43:31PM +0200, Etienne Carriere wrote:
> > On Thu, 8 Oct 2020 at 23:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Oct 08, 2020 at 04:37:21PM +0200, Etienne Carriere wrote:
> > > > There is no reason for the smc transport to restrict itself to a 1
> > > > message pool. More can be allocated, messages are copied from/to the
> > > > shared memory only on SMC exit/entry hence SCMI driver can play with
> > > > several messages.
> > > >
> > > > Use value of 20 to mimic mailbox transport implementation.
> > >
> > > What is the need to mimic ?
> > 
> > I had to pick a value. I can't say whether 2, 5 or 20 is better.
> > I looks how the mailbox transport did and used the same value
> > as it seemed reasonable regarding its memory cost.
> > 
> > >
> > > > Any high value could fit. This should be something configurable.
> > >
> > > Why not 10 or 100 ? I see any value other than 1 is useless as we lock
> > > the channel in send_message and we don't maintain a queue like mailbox.
> > 
> > I'll check again.
> > Playing with SCMI voltage domain [1], it happens that I needed several
> > preallocated message buffers unless what regulators fail to be probed.
> 
> 
> I may be missing something but I can't see how, we simply block in
> send_message while mailbox has a queue of 20 which is why it has 20 there.
> 
> The issue you are seeing could be different. Let me know if I am missing
> something.
> 

OK, I gave this some thought and realise that in-order to allow multiple
requests simultaneously, we do need this value > 1. I will take this
and make some tweaks to the commit log to indicate the same.

-- 
Regards,
Sudeep
