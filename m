Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B94A28E35D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgJNPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbgJNPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:35:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A938C2222A;
        Wed, 14 Oct 2020 15:35:19 +0000 (UTC)
Date:   Wed, 14 Oct 2020 11:35:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/1] tracepoints: tree-wide: Replace %p with %px
Message-ID: <20201014113517.512fbd07@gandalf.local.home>
In-Reply-To: <20201015001104.593651d4e07bc3d4597e0771@kernel.org>
References: <160266594977.74973.9883936722540767319.stgit@devnote2>
        <160266595921.74973.16021029265750003477.stgit@devnote2>
        <20201014093813.74490c26@gandalf.local.home>
        <20201015001104.593651d4e07bc3d4597e0771@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 00:11:04 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 14 Oct 2020 09:38:13 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
> Hmm, would you mean we always run such conversion on printing the trace
> buffer for each entry? It could be much overhead because we need allocate
> memory (%p->%px increase 1 byte) and format conversion (with copying it).

I was thinking of having a single buffer allocated to the iterator (could
increase in size when needed). Really, the output isn't that time critical,
and running a conversion on all events each time shouldn't be that bad. And
if it is, we could have a cache in the iter for a set of events to handle.
Note, the conversion only needs to happen for events that have a %p in the
fmt, and only those need to be cached.

Then those buffers could be freed when the iter is freed.

> Maybe we can avoid repeating it using a kind of cache, but it also consumes
> memory. And as I pointed, the security reason is meaningless because there
> are raw addresses in raw data which user can read...
> Could you tell me what is your point? Making the code change as small as
> possible?
> 

It's about not having to worry about this in the future. Otherwise, we'll
be playing whack-a-mole on making all %px in new trace events.

-- Steve
