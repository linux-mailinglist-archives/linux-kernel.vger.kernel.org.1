Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF528E4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbgJNQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbgJNQlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:41:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7461A21D7F;
        Wed, 14 Oct 2020 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602693691;
        bh=QbRigrjXaq+g74CGIhSQBl08lkdBoCo/f+rGUw6hzCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ysbw0L1muDbuB+MwS1ngLi21vF72/J3wm24+2dSqgvHvm0/ta/zz66ifwA3IMgjQ7
         lWKjoySQ0KqQzZsQ2WiS3QTWGdL7DUYvp/hYOQy8UoZhcvIyL1QJv9dym/ZWSVA/gz
         2LrV1C+jMHKmYua0mkS6ap1s1FwMwKbX45PJrxmw=
Date:   Thu, 15 Oct 2020 01:41:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/1] tracepoints: tree-wide: Replace %p with %px
Message-Id: <20201015014127.dab82a6d488c3b4156ff576d@kernel.org>
In-Reply-To: <20201014113517.512fbd07@gandalf.local.home>
References: <160266594977.74973.9883936722540767319.stgit@devnote2>
        <160266595921.74973.16021029265750003477.stgit@devnote2>
        <20201014093813.74490c26@gandalf.local.home>
        <20201015001104.593651d4e07bc3d4597e0771@kernel.org>
        <20201014113517.512fbd07@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 11:35:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 15 Oct 2020 00:11:04 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Wed, 14 Oct 2020 09:38:13 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > 
> > Hmm, would you mean we always run such conversion on printing the trace
> > buffer for each entry? It could be much overhead because we need allocate
> > memory (%p->%px increase 1 byte) and format conversion (with copying it).
> 
> I was thinking of having a single buffer allocated to the iterator (could
> increase in size when needed). Really, the output isn't that time critical,
> and running a conversion on all events each time shouldn't be that bad. And
> if it is, we could have a cache in the iter for a set of events to handle.
> Note, the conversion only needs to happen for events that have a %p in the
> fmt, and only those need to be cached.
> 
> Then those buffers could be freed when the iter is freed.

Ah, I got it. so you meant adding a buffer field to struct trace_iterator,
correct?

> 
> > Maybe we can avoid repeating it using a kind of cache, but it also consumes
> > memory. And as I pointed, the security reason is meaningless because there
> > are raw addresses in raw data which user can read...
> > Could you tell me what is your point? Making the code change as small as
> > possible?
> > 
> 
> It's about not having to worry about this in the future. Otherwise, we'll
> be playing whack-a-mole on making all %px in new trace events.

Hmm, OK. I hope no one adds an event which shows both ptr and hashed ptr
for making a database in the future ;)
Let me try to re-implement it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
