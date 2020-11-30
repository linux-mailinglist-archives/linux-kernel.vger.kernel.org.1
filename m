Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3E2C8695
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgK3OWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgK3OWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:22:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092D2C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XfECwCYY95Uh3FJvumBnHWCMSCcNGHqYoDsLHJkgtmY=; b=DulYgDsbWnEyuLXmSBSFxAmVBD
        rzrMvEJrYA9iHJHu9cRKjC2MzjPvqfJhm4526H65Og1e6HLgPYAtR5rYblt1wlv1mjhmNVjvB0fp1
        hZDo3BQt1oNO98JPp3NmUH2+bLgqJ3TOHbL4gEMHD5RYcmmapLIp5+m4XQtWq2O2ERC/rE0AsltKH
        lzECodsfo0Qo9CU5Ed5Ctb6Jwcn66WEfcOm5fwKQIXJ8VkD1JMaqqcI15klEx+wrgCJ+/78do6vRk
        LQifYfrEPUdrmsbv6Xn+7RWcNNyYFnwWKUyMbmkJxQEIgQXdSlq+YZxx7tKO1GdEOjGYxVxhd7Bnn
        kkVE9upA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjk3M-0000hQ-4Y; Mon, 30 Nov 2020 14:21:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D080330477A;
        Mon, 30 Nov 2020 15:21:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1936203DFA1C; Mon, 30 Nov 2020 15:21:18 +0100 (CET)
Date:   Mon, 30 Nov 2020 15:21:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [RFC][PATCH 3/9] sh/mm: Make pmd_t similar to pte_t
Message-ID: <20201130142118.GO2414@hirez.programming.kicks-ass.net>
References: <20201130112705.900705277@infradead.org>
 <20201130113602.959570640@infradead.org>
 <e09e71048eb74d0c8eee68bf1f865d36@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09e71048eb74d0c8eee68bf1f865d36@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 02:10:42PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 30 November 2020 11:27
> > 
> > Just like 64bit pte_t, have a low/high split in pmd_t.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/sh/include/asm/pgtable-3level.h |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/sh/include/asm/pgtable-3level.h
> > +++ b/arch/sh/include/asm/pgtable-3level.h
> > @@ -28,9 +28,15 @@
> >  #define pmd_ERROR(e) \
> >  	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
> > 
> > -typedef struct { unsigned long long pmd; } pmd_t;
> > +typedef struct {
> > +	struct {
> > +		unsigned long pmd_low;
> > +		unsigned long pmd_high;
> > +	};
> > +	unsigned long long pmd;
> > +} pmd_t;
> 
> Would it be better to use u32 and u64?

That would be inconsistent with the rest of SH. If you want to go clean
up SH, have at, but that's not what this series is for.
