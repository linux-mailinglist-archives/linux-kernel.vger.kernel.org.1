Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF942C51C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgKZKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbgKZKDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:03:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB5C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 02:03:34 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c90002c8516e75060f16f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9000:2c85:16e7:5060:f16f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 478AB1EC04B9;
        Thu, 26 Nov 2020 11:03:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606385011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wWlZhrCGFvD7Vf/5hYiDjNW7qKf1owQjDZeEP+QgGHg=;
        b=UWhTeB6Au+OUBYF2bqnpBCgz0k7oBRFSWpBOIzt/ofCdTwnsiRdBnsD6EVL+drTOQU288L
        Gd3ubtcfa/p88e3R7g11wRZbomMp4okYGjfCjOt/7FIpyh0xAO2Tra3qLkPeVuwZEZ6Iam
        P3KaE+od9df2mJs2FhHeoevKRn1R7i0=
Date:   Thu, 26 Nov 2020 11:03:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mathieu Chouquet-Stringer <me@mathieu.digital>
Cc:     Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] x86/msr: Filter MSR writes
Message-ID: <20201126100326.GA31565@zn.tnic>
References: <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes>
 <20201117212016.GQ5719@zn.tnic>
 <20201118090929.GC189743@weirdfishes>
 <20201118115027.GF7472@zn.tnic>
 <20201118140427.GA213447@weirdfishes>
 <20201118175048.GK7472@zn.tnic>
 <20201119105344.GA434279@weirdfishes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119105344.GA434279@weirdfishes>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:53:44AM +0100, Mathieu Chouquet-Stringer wrote:
> ---
> TAINT_CPU_OUT_OF_SPEC now means what a bit more than what it implies as

s/now means what a bit/now means a bit/

> the flag isn't set just because of a CPU misconfiguration or mismatch.
> Historically it was for SMP kernel oops on an officially SMP incapable
> processor but now it also covers CPUs whose MSRs have been incorrectly
> poked at from userspace, drivers being used on non supported
> architectures, broken firmware, mismatched CPUs, ...
> 
> Update documentation and script to reflect that.
> 
> Signed-off-by: Mathieu Chouquet-Stringer <me@mathieu.digital>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst   |  2 +-
>  Documentation/admin-guide/tainted-kernels.rst | 22 +++++++++++++++++-----
>  tools/debugging/kernel-chktaint               |  2 +-
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index d4b32cc32bb7..edd89e2d3af7 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1336,7 +1336,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
>  ======  =====  ==============================================================
>       1  `(P)`  proprietary module was loaded
>       2  `(F)`  module was force loaded
> -     4  `(S)`  SMP kernel oops on an officially SMP incapable processor
> +     4  `(S)`  kernel running on an out of specification system
>       8  `(R)`  module was force unloaded
>      16  `(M)`  processor reported a Machine Check Exception (MCE)
>      32  `(B)`  bad page referenced or some unexpected page flags
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index f718a2eaf1f6..5737dfa17cd1 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -84,7 +84,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>  ===  ===  ======  ========================================================
>    0  G/P       1  proprietary module was loaded
>    1  _/F       2  module was force loaded
> -  2  _/S       4  SMP kernel oops on an officially SMP incapable processor
> +  2  _/S       4  kernel running on an out of specification system
>    3  _/R       8  module was force unloaded
>    4  _/M      16  processor reported a Machine Check Exception (MCE)
>    5  _/B      32  bad page referenced or some unexpected page flags
> @@ -116,10 +116,22 @@ More detailed explanation for tainting
>   1)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
>       modules were loaded normally.
>  
> - 2)  ``S`` if the oops occurred on an SMP kernel running on hardware that
> -     hasn't been certified as safe to run multiprocessor.
> -     Currently this occurs only on various Athlons that are not
> -     SMP capable.
> + 2)  ``S`` if the kernel is running on a processor or system that is out of
> +     specification: hardware has been put into an unsupported configuration,
> +     therefore proper execution cannot be guaranteed.
> +     Kernel will be tainted for example if:

"Kernel will be tainted if, for example:"

> +
> +     - on x86: you force PAE on intel CPUs, you run a SMP kernel on non

"user forces PAE on some Intel CPUs which do not advertize it by default"
- otherwise it doesn't make sense.

Also, please use passive voice: no "we" or "I", etc. Look at how the
rest of the text in that file is written and try to mimick it and get
rid of the "you" formulations.

> +       officially capable SMP Athlon CPUs, you poke at random MSRs from
> +       userspace.
> +     - on arm: you run a kernel on certain CPUs (such as Keystone 2) without
> +       having certain kernel features enabled.
> +     - on arm64: you have mismatched hardware features between CPUs, the
> +       bootloader has booted CPUs in different modes.
> +     - you use certain drivers on non supported architectures (such as
> +       scsi/snic on something else than x86_64, scsi/ips on non
> +       x86/x86_64/itanium, have broken firmware settings for the
> +       irqchip/irq-gic on arm64 ...).

Yes, the text should be giving the idea that the configuration the
system is running on, is not supported.

All in all, this is shaping up ok, you can send the next one as
a proper patch with the people on Cc who should take it - (use
./scripts/get_maintainer.pl for that) and not as an inline diff anymore.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
