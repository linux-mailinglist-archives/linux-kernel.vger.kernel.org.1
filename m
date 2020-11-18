Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF48C2B8362
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgKRRu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgKRRu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:50:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9C4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:50:56 -0800 (PST)
Received: from zn.tnic (p200300ec2f0caf00cee835374c0b640d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:cee8:3537:4c0b:640d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73C861EC03CE;
        Wed, 18 Nov 2020 18:50:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605721854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QiqQkv1w0oYRuDKj7Z/aBLGaM45MnOPpOCa80MwzhF8=;
        b=ddj6T9i+f21ZT6X+Apj5RMCQ8VegsnLs2hKyVE1OtJV28wK/6kE8i1ICOt0Qs79dCK0pBt
        W9LOAkxmO8Nl0gvFliRs/RVxk/Uzewm2NOjyzLUJVBtw9R39wLyfQpsCDKEZFjV9vFTxA8
        19/dBDzODl5jBqVZsgtFQ6xvgtjgxmY=
Date:   Wed, 18 Nov 2020 18:50:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mathieu Chouquet-Stringer <me@mathieu.digital>
Cc:     Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] x86/msr: Filter MSR writes
Message-ID: <20201118175048.GK7472@zn.tnic>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes>
 <20201117212016.GQ5719@zn.tnic>
 <20201118090929.GC189743@weirdfishes>
 <20201118115027.GF7472@zn.tnic>
 <20201118140427.GA213447@weirdfishes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118140427.GA213447@weirdfishes>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 03:04:27PM +0100, Mathieu Chouquet-Stringer wrote:
> TAINT_CPU_OUT_OF_SPEC now means what it says. Historically it was for
> SMP kernel oops on an officially SMP incapable processor but now it also
> covers CPUs whose MSRs have been incorrectly poked at. Update
> documentation and script to reflect that.
> 
> Signed-off-by: Mathieu Chouquet-Stringer <me@mathieu.digital>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 11 ++++++-----
>  tools/debugging/kernel-chktaint               |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)

Please fix the text in Documentation/admin-guide/sysctl/kernel.rst also.

> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index f718a2eaf1f6..95f432c43ba0 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -84,7 +84,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>  ===  ===  ======  ========================================================
>    0  G/P       1  proprietary module was loaded
>    1  _/F       2  module was force loaded
> -  2  _/S       4  SMP kernel oops on an officially SMP incapable processor
> +  2  _/S       4  kernel running on out of spec processor
>    3  _/R       8  module was force unloaded
>    4  _/M      16  processor reported a Machine Check Exception (MCE)
>    5  _/B      32  bad page referenced or some unexpected page flags
> @@ -116,10 +116,11 @@ More detailed explanation for tainting
>   1)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
>       modules were loaded normally.
>  
> - 2)  ``S`` if the oops occurred on an SMP kernel running on hardware that
> -     hasn't been certified as safe to run multiprocessor.
> -     Currently this occurs only on various Athlons that are not
> -     SMP capable.
> + 2)  ``S`` if the kernel is running on any processor that is out of
> +     specifications (writing to MSRs will trigger this behavior).

People might wonder what "out of specifications" means. I'd say
something along the lines of "the CPU has been put into a not supported
configuration, therefore proper execution cannot be guaranteed". Grep
the tree for TAINT_CPU_OUT_OF_SPEC to see when this gets set, might give
you a better idea of what to say.

> +     Historically, it could also be if an oops occured on a kernel running on
> +     hardware that hasn't been certified as safe to run multiprocessor, such
> +     as various Athlons that are not SMP capable.

And here you can expand on the examples by saying that poking at random
MSRs from userspace is one possible way to mis-configure it.

>   3)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
>       modules were unloaded normally.
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 2240cb56e6e5..0b9d93e27910 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -72,7 +72,7 @@ if [ `expr $T % 2` -eq 0 ]; then
>  	addout " "
>  else
>  	addout "S"
> -	echo " * SMP kernel oops on an officially SMP incapable processor (#2)"
> +	echo " * kernel running on out of spec processor (#2)"

Yeah, can you think of a better formulation than "out of spec
processor"?

The CPU is fine, only its current configuration is not.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
