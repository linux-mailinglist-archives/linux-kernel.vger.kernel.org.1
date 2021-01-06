Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955D02EBFE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbhAFO45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:56:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbhAFO44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:56:56 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F002323110;
        Wed,  6 Jan 2021 14:56:15 +0000 (UTC)
Date:   Wed, 6 Jan 2021 09:56:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobes: Do the notrace functions check without
 kprobes on ftrace
Message-ID: <20210106095614.4ca3f166@gandalf.local.home>
In-Reply-To: <160990323982.16047.9136060149082849917.stgit@devnote2>
References: <160990323982.16047.9136060149082849917.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jan 2021 12:20:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Enable the notrace function check on the architecture which doesn't
> support kprobes on ftrace. This notrace function check is not only
> for the kprobes on ftrace but also sw-breakpoint based kprobes.
> Thus there is no reason to limit this check for the arch which
> supports kprobes on ftrace.
> 
> This also changes the dependency of Kconfig. Because kprobe event
> uses the function tracer's address list for identifying notrace
> function, if the CONFIG_FUNCTION_TRACER=n, it can not check whether
> the target function is notrace or not.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  

Thanks Masami,

I queued this up for testing, and will mark it for stable. I know it's a
minor fix, but it also shouldn't have much risk either.

-- Steve
