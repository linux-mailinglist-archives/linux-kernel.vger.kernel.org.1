Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9367726E343
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIQRbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:31:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45372 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgIQR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:29:27 -0400
Received: from zn.tnic (p200300ec2f105300d80be81ad57dea02.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:d80b:e81a:d57d:ea02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B07011EC03D2;
        Thu, 17 Sep 2020 19:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600363722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DPFZ7R7KMR4GIHVlYtjgerY8lFRwnbkOZgmyXUzJz/8=;
        b=KIsGzNW5GDbEH/cPxtlMc/bbz/A0UiKdMoc5YwFnhJI8eSiLJbzS/+EpkniTK4FgMaldZ8
        LTzJfcs/cJoJgSBmRAH8snOjI13ouHxBeNkoy2TuOLT6oVqvz1waBb2Y9qZON32RJljipD
        9VQWx1qx8jeO/V97FNpt9POn51GevXg=
Date:   Thu, 17 Sep 2020 19:28:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cmdline: Disable instrumentation of cmdline
 unconditionally
Message-ID: <20200917172840.GP31960@zn.tnic>
References: <20200906154637.1618112-1-nivedita@alum.mit.edu>
 <20200917094055.GF31960@zn.tnic>
 <20200917160548.GA1877352@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917160548.GA1877352@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:05:48PM -0400, Arvind Sankar wrote:
> I did have a crash and this patch fixed it, but it seems it was on a
> branch where I was making changes to cmdline.c, which triggered clang to
> use a jump table for cmdline_find_option_bool(). That was the cause of
> the crash, and the reason this patch fixed it was because it enabled
> -fno-jump-tables, rather than because it disabled instrumentation.

I see.

> The instrumentation code does write data to random addresses, but
> apparently that doesn't necessarily crash the system. This patch would
> also be insufficient to fix it, since load_ucode_bsp() itself can have
> instrumentation code in it.

Yeah, it better not have any.

> Eg with GCOV_PROFILE_ALL enabled, the start of the function is:
> 
> 	c2a7706a <load_ucode_bsp>:
> 	c2a7706a:       55                      push   %ebp
> 	c2a7706b:       83 05 c0 4d ba c2 01    addl   $0x1,0xc2ba4dc0
> 	c2a77072:       83 15 c4 4d ba c2 00    adcl   $0x0,0xc2ba4dc4
> 	c2a77079:       89 e5                   mov    %esp,%ebp
> 
> but when it's called from arch/x86/kernel/head_32.S, paging is disabled
> and the code is executing out of physical addresses, so it's going to
> read/write data from garbage addresses.

Right, so I'm sceptical to all this instrumentation nonsense - it is
fine and good if you have it but not everywhere. And certainly not when
the thing is loading microcode.

microcode/core.c contains all the code, early and late so it might make
some little sense to have instrumentation there for whatever reasons,
say KASANing (yah, I made a verb :)) the thing for leaks or whatnot,
but meh, I can't find it in me to care. So at some point, if it starts
getting in the way, we might remove all instrumentation from that thing
altogether.

> Anyway, please ignore this patch and sorry for the noise.

No worries.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
