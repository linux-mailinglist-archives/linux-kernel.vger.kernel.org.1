Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2CA2791E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgIYURe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgIYUPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:15:31 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C0123A02;
        Fri, 25 Sep 2020 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601063330;
        bh=VRP3UV3UB6DTFB0UhK6oObbVaxGYiqjwDxHPG2aahMs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R7h9+t7XQo1i+A8FqIzHwT2IUPrZSxIlQKp8m6ejQA5/gqHU8tdD4ajxVTImp+Kst
         SSVGAs7hXwPognyZzJCEY5YTYFMPG3NQwKrjVkaACX5PDmVfjuLpsNcqn+34fJ4enM
         SbTPNDV4Nsh/z1YCzgnogTU4mghRjvnAERyr+eHE=
Message-ID: <cb89ebee230aedc9b5b6668bb333a258fc971b30.camel@kernel.org>
Subject: Re: [RFC PATCH 0/1] tracing: support dynamic string field types for
 synthetic events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 14:48:48 -0500
In-Reply-To: <20200925190806.1870935-1-axelrasmussen@google.com>
References: <20200925190806.1870935-1-axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Fri, 2020-09-25 at 12:08 -0700, Axel Rasmussen wrote:
> Hi Steven and Tom,
> 
> In this thread: https://lkml.org/lkml/2020/9/17/1015 we discussed how
> to plumb
> dynamic strings into synthetic events. Tom, you proposed adding a new
> dynamic
> string type to synthetic event definition like "char foo[]".
> 
> I'm sending this patch because it may be simpler than implementing
> that (I'm
> not too familiar with the tracing infrastructure, apologies if this
> is not
> true), and in my testing it seems sufficient to address my use case.
> I tested
> both setting up a synthetic event as Steven described in the other
> thread, as
> well as doing an analogous thing with a small bpftrace program, and
> both work as
> expected with this patch.
> 
> This is because I happen to know there's an upper bound on the length
> of the
> string in question, so I can just define a "char memcg_path[256]" in
> the
> synthetic event, and I can be sure the string won't be truncated.
> 
> Let me know what you think. Happy to drop this and wait for Tom's
> suggested
> approach instead.

Changing check_synth_field() is one of the things that will need to
change for this to work - I'm working on a patch but am kind of in the
middle of it, if you can wait - I expect to be able to post something
Monday...

Thanks,

Tom

> 
> Axel Rasmussen (1):
>   tracing: support dynamic string field types for synthetic events
> 
>  kernel/trace/trace_events_hist.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> --
> 2.28.0.681.g6f77f65b4e-goog
> 

