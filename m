Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49AF1A3388
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDILtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 07:49:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDILtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T7RovBNTm93gHpCFIjf9x4gbspde05eEfozfmq8ZK24=; b=bXwfJCg7HPdgShtDyaX15C/qJU
        WNewdVuNMkc9h0JKj1xvNDRDxRlOVsMHlBMgCZ196dNI2bYjaBG8WZeetxj4Tam6gCzFf/jmFi1ul
        NRlSFI/tt0vyYqYacQGvoBO8rxSfYhwV2kLi41QsWOqQOgeKXyqdJTPFa1pbJ4o1oLJLcFgrew8M+
        E31koRZddoWkoRv0EU0x63wWI6kniYYtXDb8rmh6rYGmPaTss2M9GV5DVlgy740amyBXRmuUG5Ufe
        lC92uL9zwf0y7EUvGW9bpsBvjEgXkSV4a42yX2TcK5hmvyeAbdbL66ewbbx35Jv42uv2yD/q8Lqgm
        5wRem42g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMVgi-0006A7-Rn; Thu, 09 Apr 2020 11:49:40 +0000
Date:   Thu, 9 Apr 2020 04:49:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200409114940.GT21484@bombadil.infradead.org>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:47:32PM -0700, Andrew Morton wrote:
> On Tue,  7 Apr 2020 21:40:08 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > The two patches should fix below syzbot reports:
> > 
> >   BUG: unable to handle kernel paging request in kernel_get_mempolicy
> >   https://lore.kernel.org/lkml/0000000000002b25f105a2a3434d@google.com/
> > 
> >   WARNING: bad unlock balance in __get_user_pages_remote
> >   https://lore.kernel.org/lkml/00000000000005c65d05a2b90e70@google.com/
> 
> (Is there an email address for the syzbot operators?)

I'd suggest syzkaller-bugs@googlegroups.com (added to the Cc).

But there's a deeper problem in that we don't have anywhere to stash
that kind of information in the kernel tree right now.  Perhaps a special
entry in the MAINTAINERS file for bot operators?  Or one entry per bot?

> sysbot does test linux-next, yet these patches sat in linux-next for a
> month without a peep, but all hell broke loose when they hit Linus's
> tree.  How could this have happened?
> 
> Possibly I've been carrying a later patch which fixed all this up, but
> I'm not seeing anything like that.  Nothing at all against mm/gup.c.
> 
> 
