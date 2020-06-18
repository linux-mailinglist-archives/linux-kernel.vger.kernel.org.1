Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950B01FFB74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 21:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgFRTEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 15:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgFRTD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:03:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0B7207DD;
        Thu, 18 Jun 2020 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592507039;
        bh=FcKGLNRNqI63/khvEfTqTTG7E7jDUOi4glDel5vUcmk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P4Z9iGwPuioH4OpAG4O0cRH6EmTmmFsbompSyHYUNcVMFj4kIXBJZ4NxzU5HDUTbA
         tz+yfLch74E8uSVbm5UjQqxFX5apaeZzAQs6RVZ5M1PYrWVZPhCfKQ5XalneP6oJ13
         yDxiCjOkY7eQ3gnqN5itSjKTn3IAbkzRhbCJEMrU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 149FD35229B4; Thu, 18 Jun 2020 12:03:59 -0700 (PDT)
Date:   Thu, 18 Jun 2020 12:03:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618190359.GU2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618183448.GA15136@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 08:34:48PM +0200, Uladzislau Rezki wrote:
> > > > 
> > > > I suspect that he would like to keep the tracing.
> > > > 
> > > > It might be worth trying the branches, given that they would be constant
> > > > and indexed by "i".  The compiler might well remove the indirection.
> > > > 
> > > > The compiler guys brag about doing so, which of course might or might
> > > > not have any correlation to a given compiler actually doing so.  :-/
> > > > 
> > > > Having a vfree_bulk() might well be useful, but I would feel more
> > > > confidence in that if there were other callers of kfree_bulk().
> > > >
> > > Hmm... I think replacing that with vfree_bulk() is a good idea though.
> > 
> > In other words, get rid of kfree_bulk() in favor of vfree_bulk()?
> > 
> kfree_bulk() does not understand vmalloc memory. vfree_bulk() should
> be implemented to release vmalloc's pointers. On i high level it will
> be used the same way as kfree_bulk() but for vmalloc ptrs. only.

Ah, I thought that you guys were proposing something that did bulk
free of both kmalloc and vmalloc memory.

							Thanx, Paul

> > > > But again, either way, future work as far as this series is concerned.
> > > > 
> > > What do you mean: is concerned?
> > 
> > Apologies for the strange English.  How about this?
> > 
> > "This series is OK as is.  Any comments above did not prevent me from
> > taking these patches, but instead discuss possible future work."
> > 
> That is perfectly clear to me :)
> 
> > > We are planning to implement kfree_rcu() to be integrated directly into
> > > SLAB: SLAB, SLUB, SLOB. So, there are plenty of future work :)
> >
> > And I am glad that this is still the goal.  ;-)
> >
> :)
> 
> --
> Vlad Rezki
