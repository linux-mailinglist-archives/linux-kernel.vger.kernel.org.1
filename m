Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED252C9845
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgLAHj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgLAHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:39:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C7AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7fCxfMgvNP5evF0Sh/ywGl1CmE7pC2KJxA7sTdoG65I=; b=evTFk2D5OoAFmqTYLiJLgwhV25
        MhIWsV0KEKGqhtcAlkp4TnaHPPhu7hhGKtbeZB3TP8Oy7Iy5DRf6GRsVhrOt72VppnzLYwruuFJTT
        JSBE7JrUW4XM06t8h/aHauLxahyveoOr6NWvV0AjCRdmo/rwJVHxIcZAOFYBYRG1LG8JqoeNBAmDE
        4xtKGrzg/8mEc4Nd0W0gxApIUVljxaJQ0Dw5EDSbx85mexSs6vevRxG9+TmXCs2PObU1vDHSbXMIE
        RqpENVRXU9EklciBvY0TLxYNZOuDBaEpTT4k6lXkUNu0RjzzsWYrEN9N/DUA2EB4mcVmJZw7YYYMQ
        sonGzBpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk0Fi-0007Qd-Gk; Tue, 01 Dec 2020 07:39:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 462EC300DAE;
        Tue,  1 Dec 2020 08:39:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34C6C2BBF26BF; Tue,  1 Dec 2020 08:39:06 +0100 (CET)
Date:   Tue, 1 Dec 2020 08:39:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201073906.GP2414@hirez.programming.kicks-ass.net>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <CAHk-=whPM9Ng6OsNGy==6F6WqEqLFo3kVwS1Hs063woxah5Z5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whPM9Ng6OsNGy==6F6WqEqLFo3kVwS1Hs063woxah5Z5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:55:44AM -0800, Linus Torvalds wrote:

> Yes, yes, I can very well imagine some hardware doing a "idle until
> you sense an interrupt, but don't actually take it". It's not
> _impossible_. But it's certainly not normal.

A lot of hardware actually does that, including modern x86. But yes, not
nearly everything.

