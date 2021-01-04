Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB52E992B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbhADPtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbhADPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:49:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DF0C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QfzUiQJccm/Q6S5NHoegdV1WqXCxnB544Qz2HJH+Bz0=; b=XkreHAdLJ6OufjVAc/xUApTceA
        gdBa3jIrMwOXsOEQEQBKp1yoNLW3Xn6PN/Y8LDuOob0iDVCo/GHWVVXUHfLE3+U/c+w99SsthNUqn
        h7xilpAKhANBBqF/BG0xm7bhQHYBYBvCHaxhBQYnrLQ2nm+Gp6UIdeRAf69TMpc2DNm12NJz7Uzog
        0O/2ZvstWOX0ifJcem3UksOSCzh+Qg4tD+MMdV2DPG/NdaxDaJkR7flUHNK5C6zAxm/BCKX24a4ii
        fyItpmKkVJKR2QTp/wZ7MJWGN7idu8MFZ4t6dsr3nmfqWOe/hnL7W7zuzTgd++B5844l4S3iptt0P
        CIMMl/PQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwS5j-000GDc-Mo; Mon, 04 Jan 2021 15:48:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E607E3013E5;
        Mon,  4 Jan 2021 16:48:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C74DE20CBF487; Mon,  4 Jan 2021 16:48:18 +0100 (CET)
Date:   Mon, 4 Jan 2021 16:48:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/3] objtool: Support stack layout changes in alternatives
Message-ID: <20210104154818.GB3040@hirez.programming.kicks-ass.net>
References: <cover.1608700338.git.jpoimboe@redhat.com>
 <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com>
 <20210104140952.GQ3021@hirez.programming.kicks-ass.net>
 <20210104151633.ojv3wggzpxzn2alx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104151633.ojv3wggzpxzn2alx@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 09:16:33AM -0600, Josh Poimboeuf wrote:

> > There's another fun scenario:
> > 
> >   0x00	CALL *pv_ops.save_fl		PUSHF
> >   0x01					NOP2
> >   ..
> >   0x03					NOP5
> >   ..
> >   0x07	NOP2
> >   0x08					POP %RAX
> >   0x09	<insn>
> > 
> > No conflicting boundary at 0x07, but still buggered.
> > 
> > Let me go read the actual patch to see if this is handled.
> 
> That scenario looks good, see ORC below:
> 
> .diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index cad08703c4ad..4079a430ab3f 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1483,3 +1483,8 @@ SYM_CODE_START(rewind_stack_do_exit)
>  	call	do_exit
>  SYM_CODE_END(rewind_stack_do_exit)
>  .popsection
> +
> +SYM_FUNC_START(peter)
> +	ALTERNATIVE "call *pv_ops+288(%rip); .byte 0x66,0x90", "pushf; .byte 0x66,0x90; .byte 0x66,0x66,0x66,0x90; popq %rax", X86_FEATURE_ALWAYS
> +	ret
> +SYM_FUNC_END(peter)
> 
> 
> 00000000000014e0 <peter>:
>     14e0:       ff 15 00 00 00 00       callq  *0x0(%rip)        # 14e6 <peter+0x6>
>                         14e2: R_X86_64_PC32     pv_ops+0x11c
>     14e6:       66 90                   xchg   %ax,%ax
>     14e8:       c3                      retq
> 
> alt replacement:
>   cf:   9c                      pushfq
>   d0:   66 90                   xchg   %ax,%ax
>   d2:   66 66 66 90             data16 data16 xchg %ax,%ax
>   d6:   58                      pop    %rax
> 
> 
> 
> ORC:
> 
> .entry.text+14e0: sp:sp+8 bp:(und) type:call end:0
> .entry.text+14e1: sp:sp+16 bp:(und) type:call end:0
> .entry.text+14e6: sp:sp+8 bp:(und) type:call end:0
> .entry.text+14e7: sp:sp+16 bp:(und) type:call end:0
> .entry.text+14e8: sp:sp+8 bp:(und) type:call end:0
> .entry.text+14e9: sp:(und) bp:(und) type:call end:0

Aaah, I was thinking the (LHS) NOP2 lookup would find the (RHS) PUSHF
and fail, but yes, it will emit it's own +8 and find that ofcourse!

So then yes, we only need to concern outselves with same offset
conflicts, and that does indeed simplify things considerably.
