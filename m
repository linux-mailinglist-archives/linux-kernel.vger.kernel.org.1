Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20A21C4720
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 21:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEDThr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 15:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgEDThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:37:46 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F05C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:37:46 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so13697305ion.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdWMO0GZMNFscZNybGWQG3ITswtupKPg+QTxQVbhP58=;
        b=GObmazAbydGljs6lUpNTgX82Yj9VICjxvJsXCRjiEN/IiUC4gN8U8xjGFwFx9O7ill
         ZFs+VP0q2tO0znb2WC0f2LJP3cMcp+e1Muf7XNyClzKjOuvajCxdLCIVo5W1RvjY4uOd
         sLQwXUEOzKPvuukgNeSceNmqwReuSA9lOcGCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdWMO0GZMNFscZNybGWQG3ITswtupKPg+QTxQVbhP58=;
        b=hJEnjMaILrkpr9vgcqypYEywr9n/jYgNj+k3kvimt1UbAMTgjcXwDGoAYP1Tx7uNih
         QR5Ma7NaUQ/jIvGUn61KXsJUCL/y0YeuEfTFiFpWDb3ltEGN3eEu4nZy7dN2n2J1E7jY
         a/8GSFi9BN9HtgMBoE8JMX+EZYX+4cNxgNOl+j8AczFDhEbugF1OwpXoD/L6UEYbWae1
         nXs7ha4sh1pHkkPHM0kYOOp51//wJ19291rXPPeJ7+D4OGkXLbHAzsP5r5vtrrp4oyJT
         695+WqHyHGT6d31YGiL8etTzLAeh+tYubyxvesd8puavNx5DVeGPoLOQG9u/I/G5GdTi
         jjiQ==
X-Gm-Message-State: AGi0Pub4Jlc5qyNfPecwtZgMp8PuMfutg6L7ki4Rj80Mz7KuIlQetBQ1
        /A/Q9G0VxRs30vvQzbpxwXMRYlMBAkcThg+X7ZA8ZelMVi4=
X-Google-Smtp-Source: APiQypLQSD4iaEpIO5FjQ3ZmMTHwJnzzJlOFWYJXTb12bjeP6SAD28w06feWRZUOQRwbhUf9KFyI72uv/kTlXn/A57o=
X-Received: by 2002:a6b:bc85:: with SMTP id m127mr3389827iof.89.1588621065701;
 Mon, 04 May 2020 12:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200428205903.61704-1-urezki@gmail.com> <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72> <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72> <20200504174822.GA20446@pc636>
 <20200504180805.GA172409@google.com> <20200504190138.GU2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200504190138.GU2869@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 4 May 2020 15:37:33 -0400
Message-ID: <CAEXW_YQmrfbaDocsc7bLULRR1yUv4=MMMEw3b0s1mXM8sEVVzQ@mail.gmail.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, May 4, 2020 at 3:01 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, May 04, 2020 at 02:08:05PM -0400, Joel Fernandes wrote:
> > On Mon, May 04, 2020 at 07:48:22PM +0200, Uladzislau Rezki wrote:
> > > On Mon, May 04, 2020 at 08:24:37AM -0700, Paul E. McKenney wrote:
> > [..]
> > > > > > Presumably the list can also be accessed without holding this lock,
> > > > > > because otherwise we shouldn't need llist...
> > > > > >
> > > > > Hm... We increase the number of elements in cache, therefore it is not
> > > > > lockless. From the other hand i used llist_head to maintain the cache
> > > > > because it is single linked list, we do not need "*prev" link. Also
> > > > > we do not need to init the list.
> > > > >
> > > > > But i can change it to list_head. Please let me know if i need :)
> > > >
> > > > Hmmm...  Maybe it is time for a non-atomic singly linked list?  In the RCU
> > > > callback processing, the operations were open-coded, but they have been
> > > > pushed into include/linux/rcu_segcblist.h and kernel/rcu/rcu_segcblist.*.
> > > >
> > > > Maybe some non-atomic/protected/whatever macros in the llist.h file?
> > > > Or maybe just open-code the singly linked list?  (Probably not the
> > > > best choice, though.)  Add comments stating that the atomic properties
> > > > of the llist functions aren't neded?  Something else?
> > > >
> > > In order to keep it simple i can replace llist_head by the list_head?
> >
> > Just to clarify for me, what is the disadvantage of using llist here?
>
> Are there some llist APIs that are not set up for concurrency?  I am
> not seeing any.

llist deletion racing with another llist deletion will need locking.
So strictly speaking, some locking is possible with llist usage?

The locklessness as I understand comes when adding and deleting at the
same time. For that no lock is needed. But in the current patch, it
locks anyway to avoid the lost-update of the size of the list.

> The overhead isn't that much of a concern, given that these are not on the
> hotpath, but people reading the code and seeing the cmpxchg operations
> might be forgiven for believing that there is some concurrency involved
> somewhere.
>
> Or am I confused and there are now single-threaded add/delete operations
> for llist?

I do see some examples of llist usage with locking in the kernel code.
One case is: do_init_module() calling llist_add to add to the
init_free_list under module_mutex.

> > Since we don't care about traversing backwards, isn't it better to use llist
> > for this usecase?
> >
> > I think Vlad is using locking as we're also tracking the size of the llist to
> > know when to free pages. This tracking could suffer from the lost-update
> > problem without any locking, 2 lockless llist_add happened simulatenously.
> >
> > Also if list_head is used, it will take more space and still use locking.
>
> Indeed, it would be best to use a non-concurrent singly linked list.

Ok cool :-)

Is it safe to say something like the following is ruled out? ;-) :-D
#define kfree_rcu_list_add llist_add

Thanks,

 - Joel
