Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47842B70CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKQVUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQVUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:20:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B0AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:20:23 -0800 (PST)
Received: from zn.tnic (p200300ec2f10130053cbbcbd889a5460.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:53cb:bcbd:889a:5460])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76DFE1EC03FA;
        Tue, 17 Nov 2020 22:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605648021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2OhG3czmKZvF/G88BiMnJqwOIdJuRAjW7cfRmQFy+9w=;
        b=paPUw/arWB0ng9H9XjZ8pPFq8+b7DKDPRHLyG23CAmYZTmcftAlrZnomxTOVcS3sTbYFDj
        me14TXVFpVdFeb/7dbyXdxZKfu+vtGuu2poSGD5oxiVEB9ge09d4ncCHgIPuVuIKF0cBsZ
        UddioruCdaIOs0kmn02hT9k6Uif/Jkg=
Date:   Tue, 17 Nov 2020 22:20:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mathieu Chouquet-Stringer <me@mathieu.digital>
Cc:     Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20201117212016.GQ5719@zn.tnic>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117210018.GA4247@weirdfishes>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:00:18PM +0100, Mathieu Chouquet-Stringer wrote:
> I'm late to the party but it seems allowing MSR_IA32_ENERGY_PERF_BIAS
> has the downside of flagging the kernel as tainted without telling you
> why if you use something like x86_energy_perf_policy (from
> tools/power/x86/x86_energy_perf_policy) which itself is used by tuned.

Not for long:

https://git.kernel.org/tip/fe0a5788624c8b8f113a35bbe4636e37f9321241

> So while both documentation and tools should be updated as to be clearer
> and to not taint the kernel respectively, there's something that remains
> to be done to explain why or how the kernel got tainted because of
> poking into MSRs...

Because if you poke at random MSRs and you manage to "configure" your
CPU to run "out of spec" - this is what the taint flag is called:
TAINT_CPU_OUT_OF_SPEC - then this is exactly the case you've created: a
CPU executing outside of specifications.

I agree with the update-the-documentation aspect - S does not mean only
SMP kernel on !SMP-capable CPU but the more general, CPU is out of spec.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
