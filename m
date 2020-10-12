Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8807728BEDF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403996AbgJLRPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:15:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60966 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403845AbgJLRPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:15:54 -0400
Received: from zn.tnic (p200300ec2f06920038fd325cadbd10b1.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:38fd:325c:adbd:10b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 818291EC0354;
        Mon, 12 Oct 2020 19:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602522953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SVEgQUKffP8ymr3h0zxoWDWJJBsuRqSGl9gDFBBQSfU=;
        b=NDA+CGbs6hMCkOIIkvx/sXos6ujKKZ2vXdDrA9UykAzBUirN7cAmWbV0ASSn7dpXnZLeEg
        5HANlkTHvJmNbkDxfHa7bqs3dXTCtBqsyIzmm7X16di1i8iGMgz/+l6Lq/MBvP2DXV4GFh
        gp+P61p9eeDC2ySbIE5AIpvHDRM+RDw=
Date:   Mon, 12 Oct 2020 19:15:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v4] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
Message-ID: <20201012171544.GH22829@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
 <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
 <20201010105421.GA24674@zn.tnic>
 <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
 <20201010161112.GC24674@zn.tnic>
 <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
 <20201012142148.GA22829@zn.tnic>
 <b74a95944a4bc6be1ea4ae8cf065c23e03511ba5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b74a95944a4bc6be1ea4ae8cf065c23e03511ba5.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:09:44AM -0700, Joe Perches wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Instruction opcode bytes spelled using the gas directive .byte should
> carry a comment above them stating which binutils version has added
> support for the instruction mnemonic so that they can be replaced with
> the mnemonic when that binutils version is equal or less than the
> minimum-supported version by the kernel.
> 
> Add a check for that.
> 
> Requested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> v4: trivial neatening of $Hex_byte and adding a mechanism to
>     only emit the message once per patched file (Joe)
> 
>  scripts/checkpatch.pl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

./scripts/checkpatch.pl /tmp/test
Global symbol "$rawline" requires explicit package name (did you forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line 6943.
Global symbol "$herecurr" requires explicit package name (did you forget to declare "my $herecurr"?) at ./scripts/checkpatch.pl line 6948.
Execution of ./scripts/checkpatch.pl aborted due to compilation errors.

No workie.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
