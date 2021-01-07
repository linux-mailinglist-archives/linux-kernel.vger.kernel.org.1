Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1DE2ECCB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbhAGJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbhAGJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:28:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3919CC0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ce6R9qZEcSw6D/Slc7aoeYMFlr00GjL9ASTOwgEEWUk=; b=ENwGrrVxn6+mJlSSo/bzeIwg9t
        UOyjT4y03UXMfJcDl1JLUnH1FMVag/GxUNOo6sYLV3/sHBR/tBRE3O0szCTARrpmYCq+Gnp3SL2c6
        OtkzKDpP655QB9EwkekgUqn9/Ue+O5wXv40GC5UcmaiTJuydN/S23BC44ormDFIPuQk6UpIo7xKMX
        DYG9N28q5EIrXx0jGmAVsApGXxXKIsTT1apCPZarTYF7dSbqMkGqSgCsxr4Y+D2kpKEX6x4kGM3qV
        NCfI4Umpjs+0fFVEmoAW9EbJLUU8xJ0wAg737lYRCvriPkcKOqj6X/FcAbcIuKyy00+ER3TOKSxPx
        hY4hMhFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxRZu-000198-Qn; Thu, 07 Jan 2021 09:27:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 228E2301E02;
        Thu,  7 Jan 2021 10:27:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0ECF52029C718; Thu,  7 Jan 2021 10:27:33 +0100 (CET)
Date:   Thu, 7 Jan 2021 10:27:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] objtool: Don't add empty symbols to the rbtree
Message-ID: <X/bUBRCCBNObgrok@hirez.programming.kicks-ass.net>
References: <9638ee49574226218d978ce7e26f7a107021f509.1609990368.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9638ee49574226218d978ce7e26f7a107021f509.1609990368.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 09:33:20PM -0600, Josh Poimboeuf wrote:
> Building with the Clang assembler shows the following warning:
> 
>   arch/x86/kernel/ftrace_64.o: warning: objtool: missing symbol for insn at offset 0x16
> 
> The Clang assembler strips section symbols.  That ends up giving
> objtool's find_func_containing() much more test coverage than normal.
> Turns out, find_func_containing() doesn't work so well for overlapping
> symbols:
> 
>      2: 000000000000000e     0 NOTYPE  LOCAL  DEFAULT    2 fgraph_trace
>      3: 000000000000000f     0 NOTYPE  LOCAL  DEFAULT    2 trace
>      4: 0000000000000000   165 FUNC    GLOBAL DEFAULT    2 __fentry__
>      5: 000000000000000e     0 NOTYPE  GLOBAL DEFAULT    2 ftrace_stub
> 
> The zero-length NOTYPE symbols are inside __fentry__(), confusing the
> rbtree search for any __fentry__() offset coming after a NOTYPE.
> 
> Try to avoid this problem by not adding zero-length symbols to the
> rbtree.  They're rare and aren't needed in the rbtree anyway.
> 
> One caveat, this actually might not end up being the right fix.
> Non-empty overlapping symbols, if they exist, could have the same
> problem.  But that would need bigger changes, let's see if we can get
> away with the easy fix for now.

Right, overlapping things needs a different data structure, could be
done though, but like you say, moar work.

> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/elf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index be89c741ba9a..ccee8fc331f0 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -448,6 +448,13 @@ static int read_symbols(struct elf *elf)
>  		list_add(&sym->list, entry);
>  		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
>  		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
> +
> +		/*
> +		 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
> +		 * can exist within a real function, confusing the sorting.
> +		 */
> +		if (!sym->len)
> +			rb_erase(&sym->node, &sym->sec->symbol_tree);
>  	}
>  
>  	if (stats)
> -- 
> 2.29.2
> 
