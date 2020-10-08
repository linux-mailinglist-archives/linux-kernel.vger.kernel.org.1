Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0632879D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgJHQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgJHQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:16:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A16C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 09:16:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a9000bfab7746bad7d6a7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9000:bfab:7746:bad7:d6a7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F14591EC026E;
        Thu,  8 Oct 2020 18:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602173779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eGDZdAzjKySLlW/Fl54wbLzTmYiTtw97G6M5tRigd0U=;
        b=RpCJbT+pOBSuXvAh+B3AeSv13PhQ9LZLw/MLmfqPObhdKmAYO8dimIuyVo39e9UrCVFeZt
        OkYc9C1QWHze3kCmQF1pLidRJ3IQ2W4ldOtUtDJlkHUkGu3GUFmsm2P/ca/MADSz/VYGR/
        5okWLT6a+NJo1qLUSpmDgZ/pUIyWnDM=
Date:   Thu, 8 Oct 2020 18:16:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] x86/boot: Move get_cmd_line_ptr() and
 COMMAND_LINE_SIZE into misc.h
Message-ID: <20201008161611.GD5505@zn.tnic>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-3-nivedita@alum.mit.edu>
 <20201008093042.GA6491@zn.tnic>
 <20201008134723.GB2429573@rani.riverdale.lan>
 <20201008151047.GB5505@zn.tnic>
 <20201008153002.GA2697342@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008153002.GA2697342@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:30:02AM -0400, Arvind Sankar wrote:
> I'm working on a couple of separate series to clean up cmdline
> and the compressed boot code a bit. I was actually planning to
> get rid of boot/compressed/cmdline.c entirely, replacing it with
> arch/x86/lib/cmdline.c instead:

The problem with mixing code from kernel proper with the decompressor is
that when someone changes former, latter gets all those changes too and
gradual changes like that have lead to this mess. There's a reason the
two are separate and we should separate them even more. I'm even fine
with copying functionality between the two instead of sharing.

> that one's better and is reusable as-is for the decompressor stub,
> instead of the current hack to use the real-mode boot stub's
> cmdline.c. The real mess in there is all the includes of .c files from
> various places.

Yes, and that needs untangling and making all separate. This will keep
the decompressor simple and without all that undeffery/ifdeffery because
of includes leaking symbols from kernel proper and whatnot.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
