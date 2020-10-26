Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0030729931E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786802AbgJZQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:58:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440702AbgJZQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=//lu6xMbJlxbiFG8DRyGUvg9gve889/4bYoNxrBB48c=; b=JMHMEFbEpproyn2wjMxZuEGOhe
        WhXYpL+5+r0u+Ske6gIIi6D1V4WoNRj73FkUw/3EdIN7eEb29IUzx0ufBP6ZMFdNnvJxHafZ+6Hao
        Ffhvlc47br02RxFj3v8L4w0F8R0MJMbtOrgwAElsbLjdAZaJS6MF6rG5w7oTemEh3Kmc4frLA3AY9
        3Yerlm5icl/LXE+NNNtthdZmwyk4zLjNjiQfhFsrxY+KoB0p6nDWRv9NpS6+2+IZYe3eEnCpTMhxs
        uooEEQ2s98d+AIsrht3MCkgKtUWY35VpjxO81PhUfBLy5c38aQS+fpSrwl88qjHZ6L+Xu1xEyZVKt
        Aufp6mIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX5ot-0005au-24; Mon, 26 Oct 2020 16:58:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD469301179;
        Mon, 26 Oct 2020 17:58:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92C16203BE3CE; Mon, 26 Oct 2020 17:58:05 +0100 (CET)
Date:   Mon, 26 Oct 2020 17:58:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seqlock: avoid -Wshadow warnings
Message-ID: <20201026165805.GS2594@hirez.programming.kicks-ass.net>
References: <20201026165044.3722931-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026165044.3722931-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:50:38PM +0100, Arnd Bergmann wrote:

> -	unsigned seq;							\
> +	unsigned __seq;							\

> -	unsigned seq = __read_seqcount_begin(s);			\
> +	unsigned _seq = __read_seqcount_begin(s);			\

> -	unsigned seq = __seqcount_sequence(s);				\
> +	unsigned __seq = __seqcount_sequence(s);			\

Can we have a consistent number of leading '_' ?

Also, I suppose you're going to find the explicit shadow in
___wait_event(), that one's not going to be trivial to fix.
