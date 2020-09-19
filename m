Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF7270A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 05:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISDCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 23:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISDCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 23:02:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF38C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hHLRJYRyLvyIi3qhTA2v07I6meTEq9wQRnMdQHFqLUM=; b=kPwKmBGUzyvgAdyJ4zKTtLjMea
        JkkzqYMRkvWLb0eqBagDLnkeZq4HYmxYTbLLW2qE1Vxnm8+q/k6IekMqcPamr4rEaRWF3YOOK/UIW
        V22xtjGPQcPCFdsyg59TZ+ys2iNm/jwB40twlnbcIFEdKnrN0+BkpBwr+ASzivw/gujxexEf/yd2g
        TDAD5cIoCV3bn0mtiGNpHaIq8mVZLZmSdxtPXLIrxqinxQ5YCNe6AhaI7f69SCLbRVpaOrGu1MzvB
        eMfOcjFDMF3kCXcAFYsSCRiXbj9QGVDSynI6g+dxiqechWaAaCd/pyshj/7rR7cjEZ50TZ3UOnCkc
        P15UpPiA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJT8e-0001nD-6H; Sat, 19 Sep 2020 03:02:12 +0000
Date:   Sat, 19 Sep 2020 04:02:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200919030212.GK32101@casper.infradead.org>
References: <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
 <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan>
 <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan>
 <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
 <20200918223957.GA2964553@rani.riverdale.lan>
 <CAHk-=wg+3Poqh_HQ93nPMWOXLQHZhvYNuwScoQ-WaYWuriLYAg@mail.gmail.com>
 <20200919025336.GA3008405@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919025336.GA3008405@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:53:36PM -0400, Arvind Sankar wrote:
> I think you can't do this in standard C. It's a GCC extension.
> 
> 	A structure containing a flexible array member, or a union
> 	containing such a structure (possibly recursively), may not be a
> 	member of a structure or an element of an array. (However, these
> 	uses are permitted by GCC as extensions.)

I actually have a patch in the works which wants to do this.

 struct pagevec {
-       unsigned char nr;
-       bool percpu_pvec_drained;
-       struct page *pages[PAGEVEC_SIZE];
+       union {
+               struct {
+                       unsigned char sz;
+                       unsigned char nr;
+                       bool percpu_pvec_drained;
+                       struct page *pages[];
+               };
+               void *__p[PAGEVEC_SIZE + 1];
+       };
 };

I don't think ANSI C permits this, but it's useful to be able to declare
a pagevec on the stack and be guaranteed to get enough memory to hold
a useful sized array of pointers (as well as be able to dynamically
allocate a larger pagevec for the cases which want such a thing).

We could certainly split pagevec into a variable length array version
and have a struct stack_pagevec which had the extra padding, but that
involves changing a lot more code.
