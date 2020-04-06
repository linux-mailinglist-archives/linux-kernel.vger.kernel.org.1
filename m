Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37E119FB0F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgDFRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 13:11:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgDFRLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H/9yUTGbiW+Mt33a2w6p2OQISeTcsMPMBVRQJap+M4Y=; b=CiRddd1OP/FiQbxtalr8Ww9fNI
        Tfgzd+1iLdzJm6CAUgS0AKh1sIosMFBkSsf0uocieJoaUbhQXIl6wKxMDFgAAaX4of+Yk0hHg8JaR
        nfa6Upbi2hiPXTUc1nFjsH1QGFpqp59RwylHSa0Q98n6LAOBMIcWeD0zEOFZEnT9TwrxBhGRE4VjB
        YRaPRIWYJJCW79ao88yQIrBPI5hJx0kgZf8Nhtu51rzydFKezFVahngw33wFQMBiT0SzfW8ruOVgL
        AMpGQcgJLWPf1PJz4V6yX/pFawzym9jGWgmMKN3fpRlVe3IDDCbO5+XpxtbwRCAH17yEY7czC8X3T
        2lAhjjag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLVH0-0004Cq-1f; Mon, 06 Apr 2020 17:10:58 +0000
Date:   Mon, 6 Apr 2020 10:10:58 -0700
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
Message-ID: <20200406171058.GA5352@infradead.org>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org>
 <20200406140403.GL20730@hirez.programming.kicks-ass.net>
 <20200406152411.GA25652@infradead.org>
 <20200406153902.GA9939@infradead.org>
 <20200406160157.GS20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406160157.GS20730@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:01:57PM +0200, Peter Zijlstra wrote:
> Please feel free to use my pgprot_nx() and apply liberally on any
> exported function.
> 
> But crucially, I don't think any of the still exported functions allows
> getting memory in the text range, and if you want to run code outside of
> the text range, things become _much_ harder. That said, modules
> shouldn't be able to create executable code, full-stop (IMO).

This is what i've got for now:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sanitize-vmalloc-api
