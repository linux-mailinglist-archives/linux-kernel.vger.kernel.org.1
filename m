Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A5B28F61C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389811AbgJOPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389713AbgJOPte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:49:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AAA21D41;
        Thu, 15 Oct 2020 15:49:33 +0000 (UTC)
Date:   Thu, 15 Oct 2020 11:49:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 0/3] tracing: Show real address instead of hashed
 pointer
Message-ID: <20201015114931.1c9803ae@gandalf.local.home>
In-Reply-To: <160277369795.29307.6792451054602907237.stgit@devnote2>
References: <160277369795.29307.6792451054602907237.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 23:54:58 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of the series for real address printing in trace log.
> 
> Here is the previous version, I've fixed [1/3] to use krealloc(), fix memory
> allocation error check and add __printf() attribute, according to Steve's
> comment.
> 
> https://lore.kernel.org/lkml/160275239876.115066.10891356497426857018.stgit@devnote2/
> 
> 
> Since trace_seq_printf() use in-kernel vsprintf() at last, the %p is always
> converted to the hash value instead of real address.
> 
> For the dmesg it maybe secure, but for the ftrace, I think it is
> meaningless because
> 
> - tracefs is used by root user, so no need to hide it.
> - tracefs user can access percpu/cpu*/trace_pipe_raw which stores real
>   address on the trace buffer.
> - external commands like perf doesn't convert to the hash value.
> 
> And when debugging kernel, we would like to know real address which tells
> us the address is in which area in the kernel by comparing with kernel
> memory mapping.
> 
> However, to compare the trace log with dmesg, we also need a bridging
> information. So 3/3 gives the options/hash-ptr knob which switches
> the output format.
> 

Thanks Masami,

I'm going to hold off on adding this for this merge window, and look at
applying it for the next window.

-- Steve
