Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E4E1C47C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgEDUQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 16:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgEDUQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:16:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7717206B8;
        Mon,  4 May 2020 20:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588623401;
        bh=hW3ph/2nipyI/W/meM/WDNTKSi7aceHcjSkbjMyufdY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1EQzk4znGbAz09nsdoRftqs/Sa5D9kWPjAbeE5YpYm3+2nSmWArUogRM4z4iGwirr
         MQOcr6kFOgqG491UR+evJv2Ow3POLaGUM01JwBFee97EaII9yM8VAojpypHNe2I64G
         siSbK46R8pasfndQZqdPNAORSx9yueI4gc9kNqWs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B594135226F4; Mon,  4 May 2020 13:16:41 -0700 (PDT)
Date:   Mon, 4 May 2020 13:16:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504201641.GV2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72>
 <20200504174822.GA20446@pc636>
 <20200504180805.GA172409@google.com>
 <20200504190138.GU2869@paulmck-ThinkPad-P72>
 <CAEXW_YQmrfbaDocsc7bLULRR1yUv4=MMMEw3b0s1mXM8sEVVzQ@mail.gmail.com>
 <20200504195128.GA21830@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504195128.GA21830@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 09:51:28PM +0200, Uladzislau Rezki wrote:
> > > > Since we don't care about traversing backwards, isn't it better to use llist
> > > > for this usecase?
> > > >
> > > > I think Vlad is using locking as we're also tracking the size of the llist to
> > > > know when to free pages. This tracking could suffer from the lost-update
> > > > problem without any locking, 2 lockless llist_add happened simulatenously.
> > > >
> > > > Also if list_head is used, it will take more space and still use locking.
> > >
> > > Indeed, it would be best to use a non-concurrent singly linked list.
> > 
> > Ok cool :-)
> > 
> > Is it safe to say something like the following is ruled out? ;-) :-D
> > #define kfree_rcu_list_add llist_add
> > 
> In that case i think it is better just to add a comment about using
> llist_head. To state that it used as a singular list to save space
> and the access is synchronized by the lock :)
> 
> IMHO.

But adding such a comment would be fine as well.

							Thanx, Paul
