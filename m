Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9147429E14D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgJ1Vvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:51:48 -0400
Received: from casper.infradead.org ([90.155.50.34]:44160 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgJ1Vvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LWAt3YLBnQhNeDnqwPDEzJ9AVuEW7vMRozZX/tRR0/A=; b=CNYtxV5IYy2HVVTwyWjXk+JEr+
        Rn+l3TGtVH6jpPuY6f0vFG3VJhWmTWoDQyK921Fqe3FuMsYaxOQUlsf4iwmgY2/deilFNLbE6zxKs
        TGUk+NLSaDORes3OW61/DBbdXJ6/KaVwx8XIaRfe+eR/YJ5rckSn+n/Ju0N4hfAbY7IvHKaKK5rpP
        e9Q5AgsBrbq2xR9CX1Yd6VwySTIGUMreoA3Vr+ijCpycBk4ErkWvcpq298W9nu0gcJLQ1JrEVZ1+d
        hrhCtXnbqzxk6t1jCIdBMS4ZO83Hpqo7DpRJgHJjyM23zaCYNLUsr06fmKyJlIjLBHAGt8fuCZwM6
        3plL3rig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXhB1-0005Kj-S5; Wed, 28 Oct 2020 08:51:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D1AD300455;
        Wed, 28 Oct 2020 09:51:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 533902C5FEB40; Wed, 28 Oct 2020 09:51:27 +0100 (CET)
Date:   Wed, 28 Oct 2020 09:51:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] seqlock: avoid -Wshadow warnings
Message-ID: <20201028085127.GV2628@hirez.programming.kicks-ass.net>
References: <20201026165044.3722931-1-arnd@kernel.org>
 <20201026165805.GS2594@hirez.programming.kicks-ass.net>
 <CAK8P3a3wDEKSn307UXbc33+Uqu-NDV2V=0dDKbYJpAtgZjDNkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3wDEKSn307UXbc33+Uqu-NDV2V=0dDKbYJpAtgZjDNkQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:34:10AM +0100, Arnd Bergmann wrote:
> On Mon, Oct 26, 2020 at 5:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 26, 2020 at 05:50:38PM +0100, Arnd Bergmann wrote:
> >
> > > -     unsigned seq;                                                   \
> > > +     unsigned __seq;                                                 \
> >
> > > -     unsigned seq = __read_seqcount_begin(s);                        \
> > > +     unsigned _seq = __read_seqcount_begin(s);                       \
> >
> > > -     unsigned seq = __seqcount_sequence(s);                          \
> > > +     unsigned __seq = __seqcount_sequence(s);                        \
> >
> > Can we have a consistent number of leading '_' ?
> 
> Not really ;-)

Duh.. ok, I'll take it as is.
