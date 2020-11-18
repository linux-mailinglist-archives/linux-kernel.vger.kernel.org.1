Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C42B79D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKRI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:58:53 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33679 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:58:53 -0500
X-Greylist: delayed 43111 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 03:58:52 EST
X-Originating-IP: 62.210.143.248
Received: from weirdfishes.localdomain (62-210-143-248.rev.poneytelecom.eu [62.210.143.248])
        (Authenticated sender: m@thi.eu.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B6C241C0009;
        Wed, 18 Nov 2020 08:58:49 +0000 (UTC)
Received: by weirdfishes.localdomain (Postfix, from userid 1000)
        id 5DF1372214948; Wed, 18 Nov 2020 09:58:49 +0100 (CET)
Date:   Wed, 18 Nov 2020 09:58:49 +0100
From:   Mathieu Chouquet-Stringer <me@mathieu.digital>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20201118085849.GA189743@weirdfishes>
Mail-Followup-To: Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Borislav Petkov <bp@alien8.de>, Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes>
 <20201117212016.GQ5719@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117212016.GQ5719@zn.tnic>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:20:16PM +0100, Borislav Petkov wrote:
> Not for long:
> 
> https://git.kernel.org/tip/fe0a5788624c8b8f113a35bbe4636e37f9321241

That's fantastic.

> Because if you poke at random MSRs and you manage to "configure" your
> CPU to run "out of spec" - this is what the taint flag is called:
> TAINT_CPU_OUT_OF_SPEC - then this is exactly the case you've created: a
> CPU executing outside of specifications.

Don't get me wrong, it makes total sense to do that, it's just the
original reason of !SMP-capable isn't so clear while CPU out of spec is.

-- 
Mathieu Chouquet-Stringer                             me@mathieu.digital
            The sun itself sees not till heaven clears.
	             -- William Shakespeare --
