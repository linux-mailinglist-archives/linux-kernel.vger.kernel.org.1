Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC22B79E7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgKRJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:03:02 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50029 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgKRJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:03:02 -0500
X-Originating-IP: 62.210.143.248
Received: from weirdfishes.localdomain (62-210-143-248.rev.poneytelecom.eu [62.210.143.248])
        (Authenticated sender: m@thi.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A87296000C;
        Wed, 18 Nov 2020 09:02:57 +0000 (UTC)
Received: by weirdfishes.localdomain (Postfix, from userid 1000)
        id 569DD72214948; Wed, 18 Nov 2020 10:02:57 +0100 (CET)
Date:   Wed, 18 Nov 2020 10:02:57 +0100
From:   Mathieu Chouquet-Stringer <me@mathieu.digital>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Chris Down <chris@chrisdown.name>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel-team@fb.com, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20201118090257.GB189743@weirdfishes>
Mail-Followup-To: Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com,
        Len Brown <lenb@kernel.org>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes>
 <CACdnJusV0QBy16Njge3-KR+gxcdTVXF3aO4B-z-QN+e0uhDnkQ@mail.gmail.com>
 <CACdnJuvXhVnoeK223pA3VmaRAQ=utWZei6RpQrkJyBcdpMxkOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuvXhVnoeK223pA3VmaRAQ=utWZei6RpQrkJyBcdpMxkOg@mail.gmail.com>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 01:22:49PM -0800, Matthew Garrett wrote:
> > MSR_IA32_ENERGY_PERF_BIAS (cc: Len Brown, who tried mightily to
> > convince me I was wrong here) on the grounds that it was exporting an
> > implementation detail rather than providing a generic interface, and
> > that it was something that could be done via userland instead. I
> > thought we'd end up with more examples of similar functionality and
> > could tie it into something more reasonable - history has proven me
> > wrong on that. I think it's probably reasonable to dust off the driver
> > that Len submitted however many years ago and push that into the
> > kernel now.
> 
> But ha ok based on Borislav's response it looks like someone's already
> done that.

Indeed, all is good. Just have to wait for it to be merged and the
proper kernel to be released...

-- 
Mathieu Chouquet-Stringer                             me@mathieu.digital
            The sun itself sees not till heaven clears.
	             -- William Shakespeare --
