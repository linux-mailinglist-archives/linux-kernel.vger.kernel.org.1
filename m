Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9282B7098
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKQVDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:03:25 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:49812 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKQVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:03:25 -0500
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 5D05F3A2217
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:00:42 +0000 (UTC)
X-Originating-IP: 62.210.143.248
Received: from weirdfishes.localdomain (62-210-143-248.rev.poneytelecom.eu [62.210.143.248])
        (Authenticated sender: m@thi.eu.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DA6F61BF208;
        Tue, 17 Nov 2020 21:00:18 +0000 (UTC)
Received: by weirdfishes.localdomain (Postfix, from userid 1000)
        id 8111872214948; Tue, 17 Nov 2020 22:00:18 +0100 (CET)
Date:   Tue, 17 Nov 2020 22:00:18 +0100
From:   Mathieu Chouquet-Stringer <me@mathieu.digital>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Chris Down <chris@chrisdown.name>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20201117210018.GA4247@weirdfishes>
Mail-Followup-To: Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Tue, Jul 14, 2020 at 12:17:50PM -0700, Matthew Garrett wrote:
> On Tue, Jul 14, 2020 at 9:04 AM Chris Down <chris@chrisdown.name> wrote:
> > Either way, again, this isn't really the point. :-) The point is that there
> > _are_ currently widespread cases involving poking MSRs from userspace, however
> > sacrilegious or ugly (which I agree with!), and while people should be told
> > about that, it's excessive to have the potential to take up 80% of kmsg in the
> > default configuration. It doesn't take thousands of messages to get the message
> > across, that's what a custom printk ratelimit is for.

> Agreed - we should now offer all the necessary interfaces to avoid
> userspace having to hit MSRs directly for thermal management, but that
> wasn't always the case, and as a result there's tooling that still
> behaves this way.

I'm late to the party but it seems allowing MSR_IA32_ENERGY_PERF_BIAS
has the downside of flagging the kernel as tainted without telling you
why if you use something like x86_energy_perf_policy (from
tools/power/x86/x86_energy_perf_policy) which itself is used by tuned.

I can taint my kernel manually by just running:
x86_energy_perf_policy -c all performance

The net impact is an OOPS triggered on such kernel won't necessarily be
read by anyone nor analyzed by reporting tools as the kernel is now
considered tainted.

For instance abrt reports the following:
===========8<===========8<===========8<===========8<===========8<===========8<
A kernel problem occurred, but your kernel has been tainted (flags:GS).
Explanation:
S - SMP with CPUs not designed for SMP.
Kernel maintainers are unable to diagnose tainted reports.
===========8<===========8<===========8<===========8<===========8<===========8<

To add to the confusion, kernel documentation
(Documentation/admin-guide/tainted-kernels.rst) is not up to date so
while looking for an explanation, one gets to wonder how what used to be
a regular average computer can now be classified as something using "an
officially SMP incapable processor"...

So while both documentation and tools should be updated as to be clearer
and to not taint the kernel respectively, there's something that remains
to be done to explain why or how the kernel got tainted because of
poking into MSRs...

-- 
Mathieu Chouquet-Stringer
            The sun itself sees not till heaven clears.
	             -- William Shakespeare --
