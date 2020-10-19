Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB782927CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgJSNBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgJSNBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:01:19 -0400
Received: from willie-the-truck (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA90222BA;
        Mon, 19 Oct 2020 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603112478;
        bh=GgGkZAaRlizj7Hi/+mHqvSgG6p+ntVUBjwnOiM3XDlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=du4KWCHjBVYLKJUft5CYwfv20d0edDysVSZ9+SoMX4DD+4Gz7SVW9I/f+e/rIz//U
         FhypW6Tk5/M7jl1s2Suca4/aKJsYvSrGKolGLHHTtrByhSHzXsaiaoQCwsB7ZBnTq6
         O8ninp9XeA7zPWR9okz/UOXqYycVCi40Fmmbhn/U=
Date:   Mon, 19 Oct 2020 14:01:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH] perf: arm_spe: Use Inner Shareable DSB when draining the
 buffer
Message-ID: <20201019130109.GA14994@willie-the-truck>
References: <20201006150520.161985-1-alexandru.elisei@arm.com>
 <87ft6r4bgd.wl-maz@kernel.org>
 <8fa8af94-ab08-b43a-95e4-55a13de09efe@arm.com>
 <20201019122455.GD34028@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019122455.GD34028@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 01:24:55PM +0100, Mark Rutland wrote:
> On Tue, Oct 06, 2020 at 05:13:31PM +0100, Alexandru Elisei wrote:
> > On 10/6/20 4:32 PM, Marc Zyngier wrote:
> > > On Tue, 06 Oct 2020 16:05:20 +0100,
> > > Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > >> From ARM DDI 0487F.b, page D9-2807:
> > >>
> > >> "Although the Statistical Profiling Extension acts as another observer in
> > >> the system, for determining the Shareability domain of the DSB
> > >> instructions, the writes of sample records are treated as coming from the
> > >> PE that is being profiled."
> > >>
> > >> Similarly, on page D9-2801:
> > >>
> > >> "The memory type and attributes that are used for a write by the
> > >> Statistical Profiling Extension to the Profiling Buffer is taken from the
> > >> translation table entries for the virtual address being written to. That
> > >> is:
> > >> - The writes are treated as coming from an observer that is coherent with
> > >>   all observers in the Shareability domain that is defined by the
> > >>   translation tables."
> > >>
> > >> All the PEs are in the Inner Shareable domain, use a DSB ISH to make sure
> > >> writes to the profiling buffer have completed.
> > > I'm a bit sceptical of this change. The SPE writes are per-CPU, and
> > > all we are trying to ensure is that the CPU we are running on has
> > > drained its own queue of accesses.
> > >
> > > The accesses being made within the IS domain doesn't invalidate the
> > > fact that they are still per-CPU, because "the writes of sample
> > > records are treated as coming from the PE that is being profiled.".
> > >
> > > So why should we have an IS-wide synchronisation for accesses that are
> > > purely local?
> > 
> > I think I might have misunderstood how perf spe works. Below is my original train
> > of thought.
> > 
> > In the buffer management event interrupt we drain the buffer, and if the buffer is
> > full, we call arm_spe_perf_aux_output_end() -> perf_aux_output_end(). The comment
> > for perf_aux_output_end() says "Commit the data written by hardware into the ring
> > buffer by adjusting aux_head and posting a PERF_RECORD_AUX into the perf buffer.
> > It is the pmu driver's responsibility to observe ordering rules of the hardware,
> > so that all the data is externally visible before this is called." My conclusion
> > was that after we drain the buffer, the data must be visible to all CPUs.
> 
> FWIW, this reasoning sounds correct to me. The DSB NSH will be
> sufficient to drain the buffer, but we need the DSB ISH to ensure that
> it's visbile to other CPUs at the instant we call perf_aux_output_end().
> 
> Otherwise, if CPU x is reading the ring-buffer written by CPU y, it
> might see the aux buffer pointers updated before the samples are
> viisble, and hence read junk from the buffer.
> 
> We can add a comment to that effect (or rework perf_aux_output_end()
> somehow to handle that ordering).

Given that DSB is about completion rather than ordering, completion only
matters for endpoints and the endpoint in this scenarion is part of the
same observer, DSB NSH should be sufficient. Ordering of accesses as
observed by other CPUs should be handled with DMB or acquire/release.

So if the aux buffer code is missing barriers, we should add them there,
like you proposed before:

https://lore.kernel.org/lkml/20180510130632.34497-1-mark.rutland@arm.com/

What happened to that?

Will
