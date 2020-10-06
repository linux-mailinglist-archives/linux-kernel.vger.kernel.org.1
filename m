Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7A2848A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFIcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:32:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CBEC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F8+5gkGPVqKgbh4FUVYDJTT7CPoPeJTjUg9zFd6ApBc=; b=UBksAM3QzNyHx3FLo60CS9n/2H
        7+PaJK0UVGHJWTBqKgx1ZpvScnqNTryXRdT8dQ0CIla0cmlAqqdG+JXMzDAvnJRiHpol5tPDGKPA/
        V/LMi35z8P6AO4hXGrU8wZ5956xyDCN8ERBQI0VVsY1RDTqu5Ss+42DMqvjAmbo7VovQkbI2BHDVc
        iWNj5crABf0V+zr2SVLLeEUQdxvTiseN3HLYWtWJ7cokJPOEEv7vKCYncBpONEApGXZra5NpT1VjX
        uevrcQH62qbw1ocyIQPq4fX7n47BPGCKe4jtpMNqR4+ClzgYaIovWvKgwlRbqf92cHDxRP6et1cXR
        rAzQy3ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPiOG-0008FX-P5; Tue, 06 Oct 2020 08:32:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1C533006D0;
        Tue,  6 Oct 2020 10:32:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA8B328B30F6D; Tue,  6 Oct 2020 10:32:05 +0200 (CEST)
Date:   Tue, 6 Oct 2020 10:32:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 0/2] Clean up x86_32 stackprotector
Message-ID: <20201006083205.GN2628@hirez.programming.kicks-ass.net>
References: <cover.1601925251.git.luto@kernel.org>
 <CAMzpN2j9h7FjpG_s_a09vKTCV+CYafjsKgK-k2RH7TG59FWz-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2j9h7FjpG_s_a09vKTCV+CYafjsKgK-k2RH7TG59FWz-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 07:10:39PM -0400, Brian Gerst wrote:
> On Mon, Oct 5, 2020 at 3:30 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > x86_32 stackprotector is a maintenance nightmare.  Clean it up.  This
> > disables stackprotector on x86_32 on GCC 8.1 and on all clang
> > versions -- I'll file a bug for the latter.
> 
> This should be doable on 64-bit too.  All that would need to be done
> is to remove the zero-base of the percpu segment (which would simplify
> alot of other code).

Like what?

I don't think it'd be hard to do, but I really don't see it doing
anything other than make things confusing as heck.
