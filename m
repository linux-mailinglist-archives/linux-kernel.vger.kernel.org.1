Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54FB2B02FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgKLKoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKLKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:44:07 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F14C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:44:05 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h12so3570055qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVLGh5FifLkYqQfVM082cyaY5vQXpe21CNDZNGO5gkQ=;
        b=Jz/qwHRoejvsxbEHWKyetXdokqooB4QwLuogszMZAcdWKYnHzONmxNySc2ZlYKUMgS
         DzfTe8ngXCRGXfUpiuel07k7sRP3XzmApYMq+q3s4Z5zFTEVqXZz7Nx9115lRebpnzIW
         qfwxWDpVNE8QrxsgdtbJg4K+bWtW1Vw/vj4G6c2Sru3DE8CcDTs26kgJluHHsuQAVa4r
         eW8biZnAQ54WS4tpweaYK3mCLEdZODggBVQWLylB2BXnGoxS7rkEgTuhRYQT+y0q8Fuy
         E4WXyJpwZdpv8Qp8JvySHD9xo7xrOntoJCQQwNmOkN8YWnwDPerax/Hx4/6SmERT6myx
         XOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVLGh5FifLkYqQfVM082cyaY5vQXpe21CNDZNGO5gkQ=;
        b=hyLWT984OFuq6vOH0fF/i9JSnqcuqFGtq03HkvIUMVQ7HPdta/dvQZpRYHS6Zth57z
         iztNKATClIIT8FIMn94SgZxDOYdXRYborZhBLiwIGZWkeL2aX9afuEn/enJ84c6BVLxC
         /nitjh4MHYvNL1yeXSAtyK9kOolhkuW5FI5V/byqyweLyMnDZ9dmrDwRhTHJXq71YOJ7
         f+AXTejmc05bmX8nLJN+8uXf7lrZS05PbyspT+fpeIO3wUbVxsi42BqYuIz3ehd9GYWQ
         8R7Er8+X2xe7JEpUrte7KU/Wkc1Y8HgBqMu5leiaCk+d1PcEZXWHTZslnjquZ7yVjY7F
         mMDA==
X-Gm-Message-State: AOAM530cjzXFP600k23gZed0cLq5cqxv6ywBbUuq2UfMNjT6Hg47DEvp
        jDqlHPFKtEUdsdjSza8MFwr/K6PjpUrXgYCPM5orAg==
X-Google-Smtp-Source: ABdhPJyJxipBI9psRLogYjFCDUIBkvuG9qnVgFqpuycss8mi/cWQCxoLkywYWkrSDeuEg1zYSLKH4U8zKhsChZuEVbo=
X-Received: by 2002:ac8:e41:: with SMTP id j1mr25910351qti.43.1605177844947;
 Thu, 12 Nov 2020 02:44:04 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201112103125.GV2628@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Nov 2020 11:43:53 +0100
Message-ID: <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
Subject: Re: Process-wide watchpoints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 12, 2020 at 08:46:23AM +0100, Dmitry Vyukov wrote:
>
> > for sampling race detection),
> > number of threads in the process can be up to, say, ~~10K and the
> > watchpoint is intended to be set for a very brief period of time
> > (~~few ms).
>
> Performance is a consideration here, doing lots of IPIs in such a short
> window, on potentially large machines is a DoS risk.
>
> > This can be done today with both perf_event_open and ptrace.
> > However, the problem is that both APIs work on a single thread level
> > (? perf_event_open can be inherited by children, but not for existing
> > siblings). So doing this would require iterating over, say, 10K
>
> One way would be to create the event before the process starts spawning
> threads and keeping it disabled. Then every thread will inherit it, but
> it'll be inactive.
>
> > I see at least one potential problem: what do we do if some sibling
> > thread already has all 4 watchpoints consumed?
>
> That would be immediately avoided by this, since it will have the
> watchpoint reserved per inheriting the event.
>
> Then you can do ioctl(PERF_EVENT_IOC_{MODIFY_ATTRIBUTES,ENABLE,DISABLE})
> to update the watch location and enable/disable it. This _will_ indeed
> result in a shitload of IPIs if the threads are active, but it should
> work.

Aha! That's the possibility I missed.
We will try to prototype this and get back with more questions if/when
we have them.
Thanks!
