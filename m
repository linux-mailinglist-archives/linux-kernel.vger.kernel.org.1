Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E628A3CC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbgJJWz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731489AbgJJT3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:29:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F52C05BD36
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 09:16:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1bdf00ce147181cc3ed261.dip0.t-ipconnect.de [IPv6:2003:ec:2f1b:df00:ce14:7181:cc3e:d261])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 308C31EC02C1;
        Sat, 10 Oct 2020 18:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602346280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UoyZM+DcLuyJWqGDtXwL5mcUJFE4ZqJWlnLiDWhzhg4=;
        b=fBkr2geYMoyKNkdAgkV+Uz1Bh2tKv8W2IAOQTpGm/pz+H0RwXYEiVrnR+4iiQW5crbQb/w
        RaQ4AQEGUUlXh6XSHrTZ+QajBphQHpxi/KDJ7m1nthkfbu6ck+3JKuBQ7IaXXEeOKtBYtR
        Gp2RLkOruVO2Dua4P6tj10WrFG8eJiI=
Date:   Sat, 10 Oct 2020 18:11:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
Message-ID: <20201010161112.GC24674@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
 <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
 <20201010105421.GA24674@zn.tnic>
 <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 08:27:20AM -0700, Joe Perches wrote:
> Then this could use:
> 
> /"\s*\.byte\s+(?:0x[0-9a-fA-F]{1,2}\s*,\s*){2,4}/

Yes, this is getting close.

I've tweaked it a bit to:

'/\s*\.byte\s+(?:0x[0-9a-f]{1,2}[\s,]*){2,}/i'

which assumes at least 2 opcode bytes; upper limit can be more than 4.
It still has some false positives in crypto but I'd say that's good
enough. I'll play more with it later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
