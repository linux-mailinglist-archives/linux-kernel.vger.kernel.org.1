Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2725A2EB4EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbhAEVfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAEVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:35:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C5AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4fXXGhqhwyZOyY/MzNL+cRERt9hfQzFKJ23KP07oxrg=; b=PMmrvrHj+uqoxe55GQq/rvMKul
        vnT6PdTMKIcWp7KrN5DXA+ZEJiz3CBALxwj1Uqo8nFC1NGwaoyQK3Grlyl79zD5LUpt+4czdLxlL5
        2cFEeUZZwnxF78MglNWKES4nrdE+4r9hJ5R1kL+wG/6X9hXK474xKhoyFxg7D1uU8MqOh43ksyJKo
        pt+S0Vvu7wC+71IE0zC5Cjr7ZiWiLMcxNh1JE65auWFmVWs8sn/AVPG2ByO8YbpGMC92YxQdplu46
        h/1uASJyw59tHRhBS60tWeXSpBra+QkpGB8Fla2VFDBn/JzRJajbg7BlYVZ3xch6t6BGg+TbOCOvo
        dSjnFwNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kwtyL-001hQZ-DD; Tue, 05 Jan 2021 21:34:42 +0000
Date:   Tue, 5 Jan 2021 21:34:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
Message-ID: <20210105213433.GC175893@casper.infradead.org>
References: <000000000000886dbd05b7ffa8db@google.com>
 <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
 <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
 <alpine.LSU.2.11.2101041839440.3466@eggly.anvils>
 <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
 <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
 <alpine.LSU.2.11.2101051235500.5906@eggly.anvils>
 <CAHk-=wiGHdRRmZtrcUt6g6hmATkmueNVLNnSHSBoUp-v-Qy5sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGHdRRmZtrcUt6g6hmATkmueNVLNnSHSBoUp-v-Qy5sw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 01:22:49PM -0800, Linus Torvalds wrote:
> On Tue, Jan 5, 2021 at 1:13 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I was going to raise a question, whether you should now revert
> > 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)"):
> > which would not have gone in like that if c2407cf7d22d were already in.
> 
> Honestly, even if it wasn't for that PageTail issue, I think
> 073861ed77b6 is just the right thing to do anyway. It just feels _so_
> much safer to not have the possibility of that page wait thing
> following while the page is possibly then being free'd and re-used at
> the same time.
> 
> So I think the only reason to revert that commit would be if we were
> to find that it's a huge performance problem to raise the page
> refcount temporarily. Which I think is very unlikely (since we already
> dirty the page structure due to the page flags modification - although
> they are far enough apart that it might be a different cacheline).

struct pages _tend_ to be 64 bytes on 64-bit platforms (and i suspect
you're long past caring about performance on 32-bit platforms).
