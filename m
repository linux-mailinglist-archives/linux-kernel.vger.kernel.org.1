Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0A227922E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIYUdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgIYUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:21:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E8C0610D2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:01:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 457211EC02C1;
        Fri, 25 Sep 2020 22:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601064082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BFl67QbQjwUSBvUT1djhqyti1ywRvwTEKEq8ij345QA=;
        b=KqxBnZztXKQVxL3zoHiyGxYHqcqnzmWRpC8Oql+IYvcXh3s01KCxiV4lCNLBueejERSA2u
        q9gr3sgxY/6vYZUKUsW3AYk+AU38Vhl71jKdWbrcnIGIfFOpRBD7S9Oi9SHuZlvnTHusbQ
        fWjR0HCn8X7D5l4crFd1l67yetRL/J0=
Date:   Fri, 25 Sep 2020 22:01:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mark Mossberg <mark.mossberg@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jannh@google.com
Subject: Re: [PATCH] x86/dumpstack: Fix misleading instruction pointer error
 message
Message-ID: <20200925200115.GP16872@zn.tnic>
References: <20200925193150.832387-1-mark.mossberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925193150.832387-1-mark.mossberg@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 07:31:51PM +0000, Mark Mossberg wrote:
> Unconditionally printing "Bad RIP value" if copy_code() fails can be
> misleading for userspace pointers, since copy_code() can fail if the
> instruction pointer is valid, but the code is paged out.  This is
> because copy_code() calls copy_from_user_nmi() for userspace pointers,
> which disables page fault handling.
> 
> This is reproducible in OOM situations, where it's plausible that the
> code may be reclaimed in the time between entry into the kernel and when
> this message is printed. This leaves a misleading log in dmesg that
> suggests instruction pointer corruption has occurred, which may alarm
> users.
> 
> This patch changes the message printed for userspace pointers to more
> accurately reflect the possible reasons why the code cannot be dumped.
> 
> Signed-off-by: Mark Mossberg <mark.mossberg@gmail.com>
> ---
>  arch/x86/kernel/dumpstack.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 48ce44576947..37dbf16c7456 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -115,7 +115,10 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
>  	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
>  
>  	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
> -		printk("%sCode: Bad RIP value.\n", loglvl);

I'd prefer if this thing said exactly what the problem is:

		printk("%sCode: Unable to access opcode bytes at rIP 0x%lx... "

or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
