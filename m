Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D16C2E6A42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgL1THB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgL1THB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:07:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15810C061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:06:21 -0800 (PST)
Received: from zn.tnic (p200300ec2f07e400d86914afc5d02204.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e400:d869:14af:c5d0:2204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0ABA01EC04EC;
        Mon, 28 Dec 2020 20:06:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609182378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=epJ8+KmcZxZ40J2MpLxroms446T7wcU+Dw83zuJ6onM=;
        b=JGbjrreN0GxkoFhL2HslUSuO58F9Iy7PKW2r033V5uAg0MP//Y0XvnNMlSqkUIVtYzn/Gn
        gT7wuZ4KBOAqOUG1iQflxGZyQJLJ3FBEqEV7/sYnrkuCDoWFKVwvnArY3+zSJ21CShow6k
        dZiscCbgGBmiOC/RGQ4zfqYvseRQ1BQ=
Date:   Mon, 28 Dec 2020 20:06:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 04/19] x86/insn-eval: Handle return values from the
 decoder
Message-ID: <20201228190615.GC20321@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-5-bp@alien8.de>
 <X+opI92rzCNZ151F@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X+opI92rzCNZ151F@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 10:51:15AM -0800, Sean Christopherson wrote:
> This patch is incomplete/inconsistent, and arguably wrong.
> 
>   - get_eff_addr_reg() and get_eff_addr_modrm() still ignore the return of
>     insn_get_modrm() after this patch.

Ah, will fix, thx.

>   - Calling insn_get_modrm() from get_eff_addr_sib() is unnecessary (unless the
>     caller passed uninitialized garbage in @insn) as get_eff_addr_sib() is
>     called if and only if sib.nbytes!=0, and sib.nbytes can be non-zero if and
>     only if the modrm and sib have been got.
> 
>   - get_addr_ref_16() does insn_get_displacement, i.e. guarantees the modrm is
>     parsed, while the 32/64 variants do not.
> 
> What about adding a prereq patch (or three) to call insn_get_displacement() in
> insn_get_addr_ref() prior to switching on insn->addr_bytes?  Then the various
> internal helpers could be changed to either omit the sanity checks entirely or
> WARN on invalid calls?  Or better yet, add an INSN_WARN_ON() macro that compiles
> out the checks by default?  E.g. something like:

So the idea is one construction site at a time (that's a German saying :)).

This set deals with whacking the insn decoder into returning
proper error/success values. The next set should do
simplifications/fixes/cleanups/whatever but not all at the same time for
obvious reasons.

So yeah, I'm all for omitting useless code but let's do that ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
