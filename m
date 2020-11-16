Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604362B4B71
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbgKPQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbgKPQjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:39:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C06720776;
        Mon, 16 Nov 2020 16:39:32 +0000 (UTC)
Date:   Mon, 16 Nov 2020 11:39:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/ftrace: mark my_tramp[12]? global
Message-ID: <20201116113931.2b60a191@gandalf.local.home>
In-Reply-To: <20201113183414.1446671-1-samitolvanen@google.com>
References: <20201113183414.1446671-1-samitolvanen@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 10:34:14 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> my_tramp[12]? are declared as global functions in C, but they are not
> marked global in the inline assembly definition. This mismatch confuses
> Clang's Control-Flow Integrity checking. Fix the definitions by adding
> .globl.
> 

Actually, since that function is not really global, would it work if you
removed the "extern" from the my_tramp declaration?

In other words, is there a way to tell C that a function is declared in an
inline assembly block?

-- Steve


> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  samples/ftrace/ftrace-direct-modify.c | 2 ++
>  samples/ftrace/ftrace-direct-too.c    | 1 +
>  samples/ftrace/ftrace-direct.c        | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index c13a5bc5095b..5b9a09957c6e 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -21,6 +21,7 @@ static unsigned long my_ip = (unsigned long)schedule;
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
>  "	.type		my_tramp1, @function\n"
> +"	.globl		my_tramp1\n"
>  "   my_tramp1:"
>  "	pushq %rbp\n"
>  "	movq %rsp, %rbp\n"
> @@ -29,6 +30,7 @@ asm (
>  "	.size		my_tramp1, .-my_tramp1\n"
>  "	ret\n"
>  "	.type		my_tramp2, @function\n"
> +"	.globl		my_tramp2\n"
>  "   my_tramp2:"
>  "	pushq %rbp\n"
>  "	movq %rsp, %rbp\n"
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index d5c5022be664..3f0079c9bd6f 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -16,6 +16,7 @@ extern void my_tramp(void *);
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
>  "	.type		my_tramp, @function\n"
> +"	.globl		my_tramp\n"
>  "   my_tramp:"
>  "	pushq %rbp\n"
>  "	movq %rsp, %rbp\n"
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> index 63ca06d42c80..a2729d1ef17f 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -14,6 +14,7 @@ extern void my_tramp(void *);
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
>  "	.type		my_tramp, @function\n"
> +"	.globl		my_tramp\n"
>  "   my_tramp:"
>  "	pushq %rbp\n"
>  "	movq %rsp, %rbp\n"
> 
> base-commit: 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba

