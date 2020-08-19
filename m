Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4A24A208
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgHSOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 10:52:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54474 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgHSOwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:52:00 -0400
Received: from zn.tnic (p200300ec2f26be00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C74781EC0246;
        Wed, 19 Aug 2020 16:51:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597848718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A70rq59A6Q3Nc/C3E+NfgmfDZGXvR0KV5Hb4Ux18h5c=;
        b=f3ivnx419gP8w2Ml7xRmY8cWHYckXcQm9lm+DH4qBB1wRtNZN+P22KTZdObU3jRRZ+X89u
        6FnD8a7EII2N6i3iYaHLEd4eE5xAU/i7oZkNDo8jU1Aklt7TCOU8vY4WzNuJcj5AGdunLB
        nFndid/xRETUoa0a4qP6ckXTx0lZPMg=
Date:   Wed, 19 Aug 2020 16:51:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH 2/2] x86: Make source of unrecognised MSR writes
 unambiguous
Message-ID: <20200819145158.GC19351@zn.tnic>
References: <cover.1597677395.git.chris@chrisdown.name>
 <df42b70ed20d616d7c2d7f42cd38300115584619.1597677395.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df42b70ed20d616d7c2d7f42cd38300115584619.1597677395.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 04:24:36PM +0100, Chris Down wrote:
> In many cases the comm enough isn't enough to distinguish the offender,
> since for interpreted languages it's likely just going to be "python3"
> or whatever. Add the pid to make it unambiguous.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Jakub Kicinski <kuba@kernel.org>
> ---
>  arch/x86/kernel/msr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index 3babb0e58b0e..76b6b0011d62 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -99,8 +99,9 @@ static int filter_write(u32 reg)
>  	if (!__ratelimit(&fw_rs) || reg == MSR_IA32_ENERGY_PERF_BIAS)
>  		return 0;
>  
> -	pr_err("Write to unrecognized MSR 0x%x by %s\n"
> -	       "Please report to x86@kernel.org\n", reg, current->comm);
> +	pr_err("Write to unrecognized MSR 0x%x by pid %s:%d\n"

Perhaps make that "... by %s (pid: %d)\n".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
