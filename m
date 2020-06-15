Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E51FA147
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbgFOURl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 16:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbgFOURk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:17:40 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3642071A;
        Mon, 15 Jun 2020 20:17:39 +0000 (UTC)
Date:   Mon, 15 Jun 2020 16:17:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace: Remove function callback casts
Message-ID: <20200615161738.18d07ce6@oasis.local.home>
In-Reply-To: <20200614070154.6039-1-oscar.carter@gmx.com>
References: <20200614070154.6039-1-oscar.carter@gmx.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 09:01:54 +0200
Oscar Carter <oscar.carter@gmx.com> wrote:

> In an effort to enable -Wcast-function-type in the top-level Makefile to
> support Control Flow Integrity builds, remove all the function callback
> casts.
> 
> To do this, use the ftrace_ops_list_func function as a wrapper when the
> arch not supports ftrace ops instead of the use of a function cast.
> 

We need more tricker than this.

> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  kernel/trace/ftrace.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c163c3531faf..ed1efc0e3a25 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -119,13 +119,12 @@ struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
>  ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
>  struct ftrace_ops global_ops;
> 
> -#if ARCH_SUPPORTS_FTRACE_OPS
>  static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  				 struct ftrace_ops *op, struct pt_regs *regs);
> -#else
> +
> +#if !ARCH_SUPPORTS_FTRACE_OPS
>  /* See comment below, where ftrace_ops_list_func is defined */
>  static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
> -#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)

The reason for the typecast is because this gets called from asm with only two parameters.

>  #endif
> 
>  static inline void ftrace_ops_init(struct ftrace_ops *ops)
> @@ -6860,6 +6859,12 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  }
>  NOKPROBE_SYMBOL(ftrace_ops_list_func);
>  #else
> +static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> +				 struct ftrace_ops *op, struct pt_regs *regs)
> +{
> +	ftrace_ops_no_ops(ip, parent_ip);
> +}
> +
>  static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
>  {
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
> --
> 2.20.1

