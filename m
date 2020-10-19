Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44459292729
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgJSMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:25:01 -0400
Received: from foss.arm.com ([217.140.110.172]:56532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgJSMZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:25:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64B3730E;
        Mon, 19 Oct 2020 05:25:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.55.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35F743F719;
        Mon, 19 Oct 2020 05:24:58 -0700 (PDT)
Date:   Mon, 19 Oct 2020 13:24:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH] perf: arm_spe: Use Inner Shareable DSB when draining the
 buffer
Message-ID: <20201019122455.GD34028@C02TD0UTHF1T.local>
References: <20201006150520.161985-1-alexandru.elisei@arm.com>
 <87ft6r4bgd.wl-maz@kernel.org>
 <8fa8af94-ab08-b43a-95e4-55a13de09efe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa8af94-ab08-b43a-95e4-55a13de09efe@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 05:13:31PM +0100, Alexandru Elisei wrote:
> Hi Marc,
> 
> Thank you for having a look at the patch!
> 
> On 10/6/20 4:32 PM, Marc Zyngier wrote:
> > Hi Alex,
> >
> > On Tue, 06 Oct 2020 16:05:20 +0100,
> > Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> >> From ARM DDI 0487F.b, page D9-2807:
> >>
> >> "Although the Statistical Profiling Extension acts as another observer in
> >> the system, for determining the Shareability domain of the DSB
> >> instructions, the writes of sample records are treated as coming from the
> >> PE that is being profiled."
> >>
> >> Similarly, on page D9-2801:
> >>
> >> "The memory type and attributes that are used for a write by the
> >> Statistical Profiling Extension to the Profiling Buffer is taken from the
> >> translation table entries for the virtual address being written to. That
> >> is:
> >> - The writes are treated as coming from an observer that is coherent with
> >>   all observers in the Shareability domain that is defined by the
> >>   translation tables."
> >>
> >> All the PEs are in the Inner Shareable domain, use a DSB ISH to make sure
> >> writes to the profiling buffer have completed.
> > I'm a bit sceptical of this change. The SPE writes are per-CPU, and
> > all we are trying to ensure is that the CPU we are running on has
> > drained its own queue of accesses.
> >
> > The accesses being made within the IS domain doesn't invalidate the
> > fact that they are still per-CPU, because "the writes of sample
> > records are treated as coming from the PE that is being profiled.".
> >
> > So why should we have an IS-wide synchronisation for accesses that are
> > purely local?
> 
> I think I might have misunderstood how perf spe works. Below is my original train
> of thought.
> 
> In the buffer management event interrupt we drain the buffer, and if the buffer is
> full, we call arm_spe_perf_aux_output_end() -> perf_aux_output_end(). The comment
> for perf_aux_output_end() says "Commit the data written by hardware into the ring
> buffer by adjusting aux_head and posting a PERF_RECORD_AUX into the perf buffer.
> It is the pmu driver's responsibility to observe ordering rules of the hardware,
> so that all the data is externally visible before this is called." My conclusion
> was that after we drain the buffer, the data must be visible to all CPUs.

FWIW, this reasoning sounds correct to me. The DSB NSH will be
sufficient to drain the buffer, but we need the DSB ISH to ensure that
it's visbile to other CPUs at the instant we call perf_aux_output_end().

Otherwise, if CPU x is reading the ring-buffer written by CPU y, it
might see the aux buffer pointers updated before the samples are
viisble, and hence read junk from the buffer.

We can add a comment to that effect (or rework perf_aux_output_end()
somehow to handle that ordering).

Thanks,
Mark.
