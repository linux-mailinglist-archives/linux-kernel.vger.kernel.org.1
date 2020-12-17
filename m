Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F62DCFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLQKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgLQKqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:46:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C01C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vD/MxHgLBcrC3XLRiPmHcUgbEPW0ezghwc6G56p2x2A=; b=m55HwJUJOGFKvCxqY5TQIaXtP9
        bAHT0ddmDXXX/HgTcvwIv+U5htjAwvtKs5z4PaOPtCoL1RcdeD3Gnk3txBOBlL6ZWeybJO7K0lURX
        Bkg9LSUwyQTBGdcyOdHp7ydAcxXmNksvTsY7CVjH7yO/AtFjIJPBdFrFT4nWGlwM08qIvGQMVmts2
        XNydp58QQAbguPg2fQq6G8tzLcAnAFctPFNcWcXhkzpRgS1wHfJdFzvUupsxoG92Ujip8cdG6m+KI
        mQX2i83cI0a+90iE7s/yhhhYtdx1EwCWWs1LW6zpxZiBxL+rHl6SIVIiUL0byB4o0ImiNWcj5PKSD
        c+v5Fzow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpqnG-0003eK-3P; Thu, 17 Dec 2020 10:45:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47D3D300446;
        Thu, 17 Dec 2020 11:45:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E3CD202395BD; Thu, 17 Dec 2020 11:45:56 +0100 (CET)
Date:   Thu, 17 Dec 2020 11:45:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: New objtool warning..
Message-ID: <20201217104556.GT3040@hirez.programming.kicks-ass.net>
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble>
 <CAHk-=wjMoZesNgi1yWzY3nikyR11PUxHgov561UNom5mL1R4rA@mail.gmail.com>
 <CAHk-=whpp_eo-5d0ZLpx=0X91J0ZNReZ_9riNf96z2dy24z=hw@mail.gmail.com>
 <20201216200158.akf356yrw44o2rlb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216200158.akf356yrw44o2rlb@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 02:01:58PM -0600, Josh Poimboeuf wrote:
> So this is kind of tricky, because the unreachable() annotation usually
> means "the previous instruction is a dead end".  Most of the time, the
> next instruction -- the one actually pointed to by the annotation -- is
> actually reachable from another path.

*groan*, this is why I ended up sticking a nop in
instrumentation_begin()/_end().

