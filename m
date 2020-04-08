Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A141A1F5B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 13:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgDHLCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 07:02:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgDHLCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GD71D59AgaOqFSvCquM7BUVUSlVfoP9TEUeRcfsGZNM=; b=u35GVzSC/UxKPwCls8nXbD0A6i
        KaGKWlRCKfuOTl9hvmzjvCr0ljppXB4Edcw/WQI4si+onIg1uCCmfBRjBUtiUZed/uZKu/UxDeTS/
        mmwr9Rx2Tj6grg/Sw6tF1Mx4dGrfGinJltTjrltY8ADobuYCe0BwmVhdB8qiUbqkxVkOdqFuxHo+B
        ZP4IuncqqO1W++KgDWhNrCcOGDpyI919AlCWkR3Fhs1KdVVUPdk14diIdAihN+0PiCuXJHuc8+d/c
        9vu9+dpPvDMRMMNLYiXw5T5O7rQ42FIndMaAtPf6pw9pcn32FojZeASp42P23gz4WH7AXnsMVqXba
        NSLaiDiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM8TB-0007NO-KK; Wed, 08 Apr 2020 11:02:09 +0000
Date:   Wed, 8 Apr 2020 04:02:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
Message-ID: <20200408110209.GA6579@infradead.org>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org>
 <20200406140403.GL20730@hirez.programming.kicks-ass.net>
 <20200406152411.GA25652@infradead.org>
 <20200406153902.GA9939@infradead.org>
 <20200406160157.GS20730@hirez.programming.kicks-ass.net>
 <20200406171058.GA5352@infradead.org>
 <20200408091214.GK20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408091214.GK20730@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 11:12:14AM +0200, Peter Zijlstra wrote:
> > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sanitize-vmalloc-api
> 
> Should we not also apply pgprot_nx() to __vmalloc(), that's also
> EXPORT_SYMBOL().

__vmalloc has lost the pgprot argument in the latest version.  And
based on the other thread it seems I need to take a look at ioremap
as well.
