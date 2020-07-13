Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9021BF73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 23:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGJV5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 17:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgGJV5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:57:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890B42075D;
        Fri, 10 Jul 2020 21:57:06 +0000 (UTC)
Date:   Fri, 10 Jul 2020 17:57:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 07/17] static_call: Add inline static call
 infrastructure
Message-ID: <20200710175705.5c20f7f7@oasis.local.home>
In-Reply-To: <20200710134336.560096994@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.560096994@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Add infrastructure for an arch-specific CONFIG_HAVE_STATIC_CALL_INLINE
> option, which is a faster version of CONFIG_HAVE_STATIC_CALL.  At
> runtime, the static call sites are patched directly, rather than using
> the out-of-line trampolines.
> 
> Compared to out-of-line static calls, the performance benefits are more
> modest, but still measurable.  Steven Rostedt did some tracepoint
> measurements:
> 
>   https://lkml.kernel.org/r/20181126155405.72b4f718@gandalf.local.home
> 
> This code is heavily inspired by the jump label code (aka "static
> jumps"), as some of the concepts are very similar.
> 
> For more details, see the comments in include/linux/static_call.h.
> 
> [peterz: simplified interface; merged trampolines]
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> ---
>  arch/Kconfig                      |    4 
>  include/asm-generic/vmlinux.lds.h |    7 
>  include/linux/module.h            |    5 
>  include/linux/static_call.h       |   36 ++++
>  include/linux/static_call_types.h |   13 +
>  kernel/Makefile                   |    1 
>  kernel/module.c                   |    5 
>  kernel/static_call.c              |  303 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 373 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/static_call.c
