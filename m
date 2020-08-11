Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56758241D16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgHKPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:22:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59156 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgHKPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:22:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597159375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOKrhA9/8Dw3b1MEGoQnT3OLTeegBJg+uMIZeCAWcPA=;
        b=Q4D+OfpRS/p/vhHrfquXf6g0lyrsNdi1mroTAtY9KhvLFBpN9C1BKdL2o+E4GFj9v5ry2w
        gOojjnlKOZY7XlkFA+vfTTmynlHH/jAiS14XVy+kqXf8Qi2smXWdBM1HSEr8dO6+f/7qES
        NNyby2pgEjuPM1DnswKs9F8ZfphgWj8HP+Q+tZmZMCCjDL8g4a1IEaPgGg905J6axpM8Zk
        lonWW6ZY/I9GFa/PQzy7JFGnbQfXupLCLVhJTR+06NgwaNjIzsZ7ge9X86CCAXkthm7YoO
        vbL5MAWomQ/3AEW+8YVvrSHG+pObd5ZUsK9rqHolRXpBQ5y0Noml5G7+2lkdww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597159375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOKrhA9/8Dw3b1MEGoQnT3OLTeegBJg+uMIZeCAWcPA=;
        b=eKcqpl3aGqnoNbuEnk9+xeczPxofwMUfvBKJ9zXcIPBSGQaGiOQM/oWzZMbZ5bnJsEfb7f
        DKPJKuByk1O135Cw==
To:     Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
References: <20200809204354.20137-1-urezki@gmail.com> <20200809204354.20137-2-urezki@gmail.com> <20200810123141.GF4773@dhcp22.suse.cz> <20200810160739.GA29884@pc636> <20200810192525.GG4773@dhcp22.suse.cz> <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
Date:   Tue, 11 Aug 2020 17:22:54 +0200
Message-ID: <87k0y56wc1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Michal Hocko <mhocko@suse.com> writes:
>> zone->lock should be held for a very limited amount of time.
>
> Emphasis on should. free_pcppages_bulk() can hold it for quite some time
> when a large amount of pages are purged. We surely would have converted
> it to a raw lock long time ago otherwise.
>
> For regular enterprise stuff a few hundred microseconds might qualify as
> a limited amount of time. For advanced RT applications that's way beyond
> tolerable..

Sebastian just tried with zone lock converted to a raw lock and maximum
latencies go up by a factor of 7 when putting a bit of stress on the
memory subsytem. Just a regular kernel compile kicks them up by a factor
of 5. Way out of tolerance.

We'll have a look whether it's solely free_pcppages_bulk() and if so we
could get away with dropping the lock in the loop.

Thanks,

        tglx
