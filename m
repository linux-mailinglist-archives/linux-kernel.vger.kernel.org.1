Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF428A292
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390680AbgJJW6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731084AbgJJTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:53:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D1C0613AE
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 03:55:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1bdf00c1046aa2c3de4fbe.dip0.t-ipconnect.de [IPv6:2003:ec:2f1b:df00:c104:6aa2:c3de:4fbe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 945AA1EC03C1;
        Sat, 10 Oct 2020 12:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602327269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2LZMhhNg+cN619NJs7oi04st1IL4Syf4eqW8dVYtiZ0=;
        b=HywqL1cHTj9/+0s4t0OnRT2NAiHuZ/9vz6m4YqDAAg5zmsxz9FRBTESG/SE1RFDsVG1Eiv
        uK+FUwwIY/XdwE4N9FMF7io5vVOz8mc7y95eH/ZMO+RGfh5VUe13h4bet3QN9ocH/+k3dj
        wJepXRxlbLSkP3CJS0jkw5F6dldZtXc=
Date:   Sat, 10 Oct 2020 12:54:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
Message-ID: <20201010105421.GA24674@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
 <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:01:18AM -0700, Joe Perches wrote:
> Given the location, this only works on .c and .h files.
> It does not work on .S files.  Should it?

Probably not because there will be too many false positives. .byte is
used not only to spell instruction opcodes in .S files. And the main
case we're addressing here is using those .byte spelled opcodes in asm
volatile constructs so...

> No need for a capture group.

Debugging leftover, gone now.

> Please use @ not " as all the other $realfile comparisons
> use that form when expecting a /

Done.

> So it looks like the regex would be more complete as:
> 
> 	if ($realfile =~ m@^arch/x86/@ &&
> 	    $rawline =~ /\.byte\s+(?:$Constant|(?:\\)?$Ident|"\s*$Ident)\b/) {

This is much less readable than what I have now (yes, realfile test
should come first):

	if ($realfile =~ m@^arch/x86/@ && $rawline =~ /\.byte[\s0-9a-fx,]+/) {

Also, this

	$rawline =~ /\.byte\s+(?:$Constant|(?:\\)?$Ident|"\s*$Ident)\b/) {

matches

	".byte 0x66"

This

	$rawline =~ /\.byte[\s0-9a-fx,]+)) {

matches

	".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"

which is what it needs to match.

> A patch can modify any number of files.
> 
> This should use ctx_locate_comment($file ? 0 : $first_line, $linenr)
> as checkpatch tests work on patch contexts not the entire
> file before this line.

Done.

> No need for the $!comment test

Done.

> checkpatch uses only a single line output only before $herecurr
> Output line length doesn't matter.

Well, this:

WARNING: Please document which binutils version supports these .byte-spelled
        insn opcodes by adding "binutils version <num>" in a comment above them.
#90: FILE: arch/x86/include/asm/special_insns.h:254:
+       asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"


is easier readable than this:

WARNING: Please document which binutils version supports these .byte-spelledinsn opcodes by adding "binutils version <num>" in a comment above them.
#90: FILE: arch/x86/include/asm/special_insns.h:254:
+       asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
