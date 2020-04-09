Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C61A3A36
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 21:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDITMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 15:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgDITMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:51 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C26C3206F5;
        Thu,  9 Apr 2020 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586459571;
        bh=w5tU/kCw38RyRoJYkhBQPrjFX7acMPUYMj5VnLDqmh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ew7YWipmFdFw4ZOnEXmu0u65SxULek0wfv6Jk8IjmIKOipMxjFau7kSH7UHYeTZJW
         i67trMoIuv24VkZQR7FBSeXO5+RBTyTelyPHlv3RsCZ7st2lqoCM+AQpQ2Oo/iE4UL
         ah9QPejmMx9hdvMjpr5OqvcZbIPm/sdAdp4q/tWc=
Date:   Thu, 9 Apr 2020 12:12:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-Id: <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
In-Reply-To: <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
References: <20200408014010.80428-1-peterx@redhat.com>
        <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
        <20200409114940.GT21484@bombadil.infradead.org>
        <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
        <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
        <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 11:53:33 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Apr 9, 2020 at 11:16 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Could I please direct attention back to my original question regarding
> > the problems we've recently discovered in 4426e945df58 ("mm/gup: allow
> > VM_FAULT_RETRY for multiple times") and 71335f37c5e8 ("mm/gup: allow to
> > react to fatal signals")?
> 
> What earlier question? The "how could this happen" one?
> 
> Dmitry already answered that one - are you perhaps missing the emails?

Yup, email threading got broken.

> linux-next has apparently not worked at all for over a month. So it
> got no testing at all, and thus also all the gup patches got no
> testing in linux-next.
> 
> Only when they hit my tree, did they start getting testing. Not
> because my tree is the only thing getting tested, but because my tree
> is the only tree that _works_.
> 

And now the challenge is to protect your tree from the bad patches.

https://groups.google.com/forum/#!msg/syzkaller-bugs/phowYdNXHck/qU1P0TsjBAAJ
points at

net/openvswitch/conntrack.c
net/bluetooth/l2cap_sock.c
sound/core/oss/pcm_plugin.c

and other things, but it's 2+ weeks old.
