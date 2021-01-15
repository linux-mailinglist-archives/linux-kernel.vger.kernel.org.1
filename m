Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2322C2F77AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbhAOLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:32:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:35152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAOLcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:32:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF8CAACB0;
        Fri, 15 Jan 2021 11:31:26 +0000 (UTC)
Date:   Fri, 15 Jan 2021 12:31:26 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] objtool: Don't fail on missing symbol table
In-Reply-To: <a96c3f76173c7021a2298bd73362313736e674b6.1610663051.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2101151217000.4375@pobox.suse.cz>
References: <a96c3f76173c7021a2298bd73362313736e674b6.1610663051.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021, Josh Poimboeuf wrote:

> Thanks to a recent binutils change which doesn't generate unused
> symbols, it's now possible for thunk_64.o be completely empty with
> CONFIG_PREEMPTION: no text, no data, no symbols.

"without CONFIG_PREEMPTION", or did I misunderstand?
 
> We could edit the Makefile to only build that file when
> CONFIG_PREEMPTION is enabled, but that will likely create confusion
> if/when the thunks end up getting used by some other code again.
> 
> Just ignore it and move on.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

with the note below.

> ---
>  tools/objtool/elf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index be89c741ba9a..2b0f4f52f7b5 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -380,8 +380,11 @@ static int read_symbols(struct elf *elf)
>  
>  	symtab = find_section_by_name(elf, ".symtab");
>  	if (!symtab) {
> -		WARN("missing symbol table");
> -		return -1;
> +		/*
> +		 * A missing symbol table is actually possible if it's an empty
> +		 * .o file.  This can happen for thunk_64.o.
> +		 */
> +		return 0;
>  	}

We rely on .symtab presence elsewhere in the code. See 
elf_create_{rel,rela}_reloc_section(). However, there should never be a 
problem. If there is a need to create a new reloc section (either for a 
static call site, or ORC), there should always be a symbol to create it 
for (or because of it).

Miroslav
