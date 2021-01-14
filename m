Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4D62F6C65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbhANUnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:43:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbhANUnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:43:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741CC23A9F;
        Thu, 14 Jan 2021 20:42:23 +0000 (UTC)
Date:   Thu, 14 Jan 2021 15:42:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 06/21] x86/ftrace: Add UNWIND_HINT_FUNC annotation for
 ftrace_stub
Message-ID: <20210114154221.4d6223e1@gandalf.local.home>
In-Reply-To: <8c06a9137fb88d62d0af7d9d358317919ba8a001.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
        <8c06a9137fb88d62d0af7d9d358317919ba8a001.1610652862.git.jpoimboe@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 13:40:02 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Prevent an unreachable objtool warning after the sibling call detection
> gets improved.  ftrace_stub() is basically a function, annotate it as
> such.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/kernel/ftrace_64.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 0d54099c2a3a..58d125ed9d1a 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -184,6 +184,7 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
>   * It is also used to copy the retq for trampolines.
>   */
>  SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
> +	UNWIND_HINT_FUNC
>  	retq
>  SYM_FUNC_END(ftrace_epilogue)
>  

