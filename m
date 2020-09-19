Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6960270A23
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgISCqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgISCqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:46:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC657C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IqGNJCHkPeeEzn4NZlU91gM1WIifD6Ne5eGwToLNy+M=; b=gtXloL/e0Kvaq/QDn0ut5wgWxH
        pUgd7WNS1TYv4EPwksDQv4wRtU/ABSj2FZZKs3Ro769lszzyWDli9JsID75OJPO93KeciullZhnK9
        oiYR7LwIJR1bAD+k7f8wF8BTYmz/GdCY9F/CvF5/FfNisiw/JcmtY+L6eMtWXFXfEm4u9OSavDvUH
        M0xkGhOfp/k0PUY3MzhqO3TwQ1fnJWbLnFAJ6+8Ij6CsZmFgzHzOuhdaI3X8x0S7g8ttdZC9jKkGU
        VHzhWzDHHXe6Io4gI1xZ1SreCnXrLA3Oi/TYk2qZHnVfAiiNCqbNsGpEZgMn51tr2IcPw23yhxIMk
        xYJ/ZgGw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJSsu-0000w8-Ip; Sat, 19 Sep 2020 02:45:56 +0000
Date:   Sat, 19 Sep 2020 03:45:56 +0100
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
Message-ID: <20200919024556.GJ32101@casper.infradead.org>
References: <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor>
 <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
 <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan>
 <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan>
 <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
 <20200918223957.GA2964553@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918223957.GA2964553@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:39:57PM -0400, Arvind Sankar wrote:
> On Fri, Sep 18, 2020 at 02:18:20PM -0700, Linus Torvalds wrote:
> > On Fri, Sep 18, 2020 at 2:00 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > You could just assert that offsetof(typeof(s),flex) == sizeof(s), no?
> > 
> > No, because the whole point is that I want that "sizeof(s)" to *WARN*.
> 
> Ouch, offsetof() and sizeof() will give different results in the
> presence of alignment padding.
> 
> https://godbolt.org/z/rqnxTK

We really should be using offsetof() then.  It's harmless because we're
currently overallocating, not underallocating.  The test case I did was:

struct s {
        int count;
        char *p[];
};

struct_size(&s, p, 5); (48 bytes)
struct_size2(&s, p, 5); (also 48 bytes)

struct_size2 uses offsetof instead of sizeof.

Your case is different because the chars fit in the padding at the end
of the struct.
