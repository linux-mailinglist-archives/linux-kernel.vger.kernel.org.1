Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B852F6C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbhANUnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbhANUnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:43:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243D523AAC;
        Thu, 14 Jan 2021 20:42:51 +0000 (UTC)
Date:   Thu, 14 Jan 2021 15:42:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 16/21] x86/ftrace: Support objtool vmlinux.o validation
 in ftrace_64.S
Message-ID: <20210114154249.63526c1c@gandalf.local.home>
In-Reply-To: <b46ad8966b1575978b7b9cee467fa6d63a089a4d.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
        <b46ad8966b1575978b7b9cee467fa6d63a089a4d.1610652862.git.jpoimboe@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 13:40:12 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> With objtool vmlinux.o validation of return_to_handler(), now that
> objtool has visibility inside the retpoline, jumping from EMPTY state to
> a proper function state results in a stack state mismatch.
> 
> return_to_handler() is actually quite normal despite the underlying
> magic.  Just annotate it as a normal function.

If you say so ;-)

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/kernel/ftrace_64.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 1bf568d901b1..7c273846c687 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -334,8 +334,7 @@ SYM_FUNC_START(ftrace_graph_caller)
>  	retq
>  SYM_FUNC_END(ftrace_graph_caller)
>  
> -SYM_CODE_START(return_to_handler)
> -	UNWIND_HINT_EMPTY
> +SYM_FUNC_START(return_to_handler)
>  	subq  $24, %rsp
>  
>  	/* Save the return values */
> @@ -350,5 +349,5 @@ SYM_CODE_START(return_to_handler)
>  	movq (%rsp), %rax
>  	addq $24, %rsp
>  	JMP_NOSPEC rdi
> -SYM_CODE_END(return_to_handler)
> +SYM_FUNC_END(return_to_handler)
>  #endif

