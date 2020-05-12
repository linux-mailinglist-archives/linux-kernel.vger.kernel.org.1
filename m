Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922D91CF582
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgELNTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 09:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgELNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:19:20 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F30C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4qw/GqdeMXMhEvp2UNCYNMj+ZEbPP3maTTUH8WjSIYU=; b=f+DjJQ6pkCxGWzY7p97Ayuzsuf
        OWuW/tRbef1rZjdvJiOqx0hWSa9Iq6/4SNkEb7ig3FLlCduzGlF8K8hyrC5jcyHCquewW3fdj82o2
        sfgZloBiDDmy1oyVANYHOdZk2uRZoeMYLelNT79aaEU/UjUrHTSQ1ZbZ/PlKk2Ccs0n9sOKjBk6Ic
        CkMwNrdpOlh/etkBONJN2Hgi/elSox94KWpHEUt867NbZ/WhamzawfG50iVWeAnuD/jyarhui6+jb
        Du+A5DTVtaguQTwghHB7KTRqm8NX4iMnqkwgmOhQNKnMnjDLB8B31CkrbomdyIdKcgRmNTq4gDPt4
        II4f7Bag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYUoE-0004YX-R8; Tue, 12 May 2020 13:18:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FE1B300261;
        Tue, 12 May 2020 15:18:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3449620962E22; Tue, 12 May 2020 15:18:57 +0200 (CEST)
Date:   Tue, 12 May 2020 15:18:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Jan Beulich <jbeulich@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: your "x86: mm: convert dump_pagetables to use walk_page_range"
 change
Message-ID: <20200512131857.GI2978@hirez.programming.kicks-ass.net>
References: <d573dc7e-e742-84de-473d-f971142fa319@suse.com>
 <d95d756d-e940-d81e-d6ca-e45054df72c4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95d756d-e940-d81e-d6ca-e45054df72c4@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:02:51PM +0100, Steven Price wrote:
> > Additionally I'd like to note that note_page()'s "unsigned long val"
> > parameter isn't wide enough for 32-bit PAE PTEs, and hence the NX
> > flag will always be seen as clear in new_prot in such configs.
> 
> Ah, interesting. I'm not sure what type is actually guaranteed to be
> correct. pgprotval_t is x86 specific, but it might be necessary to extend it
> to other architectures. I think I got the "unsigned long" from the generic
> page.h (and because it happens to work on most architectures) - but hadn't
> noticed that that file was specifically only for NOMMU architectures.

unsigned long long should cover the i386-PAE / ARMv7-LPAE cases. I
can't, from teh top of my head, remember if there's anybody else who has
a longer PTE.
