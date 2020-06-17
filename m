Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A11FD15D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFQPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:55:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4579C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZSPAp3VauC2iLtFOlqrXko5KarTwOTs5rDR2BqCF0EQ=; b=QJorX77slEMvf6a6+NDAsnDz1j
        heaUddJD9Qtfu1kc8dJKMbHsAwkNfk/HvWYp0hawDwU4FWjp4vCZV6Jc2MxZfsIfXwG3bVC+Xp98x
        w5ptC6mbudst+eUjvEqVVFsbFtjYeviAF2Wfzuei8XKxOEFOndjadyWR6SWXLMk5/tQ4a7zNV229v
        qV2h8qGywNJ9isSV9HGBN0pihgO3QBSH7KGLlTMHWS3TPdDUIxY5rPjqptBF9vv5Dn/y6Yv5FUahg
        cGErcX7294qbwHyGg7lA332BnneWp8ougVCri4L9w10fiSNlf70ERXuBY+dy6kyVlF9coteSPC7L3
        3JpR7TDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlaPI-0007Fz-27; Wed, 17 Jun 2020 15:55:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1FFD30018A;
        Wed, 17 Jun 2020 17:55:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91CC620707D49; Wed, 17 Jun 2020 17:55:17 +0200 (CEST)
Date:   Wed, 17 Jun 2020 17:55:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, ndesaulniers@google.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200617155517.GB576905@hirez.programming.kicks-ass.net>
References: <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
 <20200615150327.GW2531@hirez.programming.kicks-ass.net>
 <20200615152056.GF2554@hirez.programming.kicks-ass.net>
 <20200617143208.GA56208@elver.google.com>
 <20200617144949.GA576905@hirez.programming.kicks-ass.net>
 <20200617151959.GB56208@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617151959.GB56208@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 05:19:59PM +0200, Marco Elver wrote:

> > Does GCC (8, as per the new KASAN thing) have that
> > __builtin_memcpy_inline() ?
> 
> No, sadly it doesn't. Only Clang 11. :-/
> 
> But using a call to __memcpy() somehow breaks with Clang+KCSAN. Yet,
> it's not the memcpy that BUGs, but once again check_preemption_disabled
> (which is noinstr!). Just adding calls anywhere here seems to results in
> unpredictable behaviour. Are we running out of stack space?

Very likely, bad_iret is running on that entry_stack you found, and as
you found, it is puny.

Andy wanted to make it a full page a while ago, so I suppose the
question is do we do that now?
