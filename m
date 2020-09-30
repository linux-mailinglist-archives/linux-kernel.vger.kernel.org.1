Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF127F55B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbgI3Wp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgI3Wp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:45:26 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED6CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:45:25 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 67so2519032ybt.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNMsU5r50aBHRIDtaWlPSANLm0F4Ze9torbe8s0tQL4=;
        b=LK8EcwIgnuzNkqO2orIXHbbd0uXWaGlVAPmcHAMHuf/b7JpEavdShwR9odCfydZNVD
         wABLcr2zLhBfvkGaotF4jnc/teHUoEQ2hD+viRfcf3+Cl1E+WZlglVOXgVZ4iE63Pquh
         /1duSnBqgTF86DNOeBptfZsUnUYWmUsQ/JtF4XBPAefjUkTiLmtvBtpCiNODwDRvNAa2
         hERxVgFcENCdiDN7i/5sbqwb73ivo3cEuDMEKdzc6ZDIl7RjqEOLtWa9S4gXXPRY2qwY
         E0wf61dwCdrlkiSwsHNWswoRow8PfQU3O7wm80X/zdv47e8y+KiY1DDKUu//JeDABy5n
         0yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNMsU5r50aBHRIDtaWlPSANLm0F4Ze9torbe8s0tQL4=;
        b=nCfCYCofq5j9NPsoPcfetsrKHOzaHEBEt8+wSIuSazKFIQVwvFhnvVa6mdxYv1l8oz
         DAH9+7Q5ZzIZ8klVqeJ4dPTGXJRrjoUjlV7S4uF0jgx2cib2kzUs68lCBzdhp6+3chHh
         A86MChHplnozB4LBLCEMZZQa2XoCTPjxlO07OyJlK1dREn+l0u/WwxxGbhWnHuS2MMnG
         Pw28kLly8iSfuwDpIMHOFbP5QOp0V0mffuEQ5qFjpFwH204hEN3vy/4V74itMvBtn9L3
         MmnXiEGHGVChdLbLHVhpOcHBZRDyERd6ElIoYPlql9+j4gr3uxlsvc/OTjeUg996Gh4G
         vNjQ==
X-Gm-Message-State: AOAM533jhfUguDVE8lvGzeECBz1oUm3Rque5pV9I+1wwoLZa5MQjWbfK
        m9Lzh/cqjPDBNVG3AZULPYU2VnOhb/70HDtvdLMZdA==
X-Google-Smtp-Source: ABdhPJx/CFSdnU9M3PuRXtjKjWV9RrWgdULpHKqSRVU8rPNjSYWHJVtI3vH7ZCdOrixJmwzkv+M3qqBZZCUngjm8wQ8=
X-Received: by 2002:a25:b1a3:: with SMTP id h35mr6223422ybj.136.1601505924949;
 Wed, 30 Sep 2020 15:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200921152653.3924-1-kan.liang@linux.intel.com>
 <20200921152653.3924-2-kan.liang@linux.intel.com> <CABPqkBRYzXH-76BZ3DdxYp7bdyPcr3_WxuxOsJw=1YPE9EwZaw@mail.gmail.com>
 <4e974520-6d0f-68af-7eb8-fa52d95ba77b@linux.intel.com> <35e875ba-2c04-8452-5105-ccacf72840d8@intel.com>
 <20200930173042.GD2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20200930173042.GD2628@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 30 Sep 2020 15:45:13 -0700
Message-ID: <CABPqkBTxpSY--BdL+-AF_Zug8QAO97O-q5mAPNXzD6Tygg+Wag@mail.gmail.com>
Subject: Re: [PATCH V8 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        kirill.shutemov@linux.intel.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 30, 2020 at 07:48:48AM -0700, Dave Hansen wrote:
> > On 9/30/20 7:42 AM, Liang, Kan wrote:
> > >> When I tested on my kernel, it panicked because I suspect
> > >> current->active_mm could be NULL. Adding a check for NULL avoided the
> > >> problem. But I suspect this is not the correct solution.
> > >
> > > I guess the NULL active_mm should be a rare case. If so, I think it's
> > > not bad to add a check and return 0 page size.
> >
> > I think it would be best to understand why ->active_mm is NULL instead
> > of just papering over the problem.  If it is papered over, and this is
> > common, you might end up effectively turning off your shiny new feature
> > inadvertently.
>
> context_switch() can set prev->active_mm to NULL when it transfers it to
> @next. It does this before @current is updated. So an NMI that comes in
> between this active_mm swizzling and updating @current will see
> !active_mm.
>
I think Peter is right. This code is called in the context of NMI, so
if active_mm is set to NULL inside
a locked section, this is not enough to protect the perf_events code
from seeing it.

> In general though; I think using ->active_mm is a mistake though. That
> code should be doing something like:
>
>
>         mm = current->mm;
>         if (!mm)
>                 mm = &init_mm;
>
>
