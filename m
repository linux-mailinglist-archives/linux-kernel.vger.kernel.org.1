Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7751B50BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 01:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDVXQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 19:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVXQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:16:43 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772CB20724;
        Wed, 22 Apr 2020 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587597402;
        bh=fGGayOuQA8eNh3azqpJ6Mnsr9UJv0qauowcJNqXgdoQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CrikSTmAs4rknYwbtS6BT9f7CD49A6wmTO6Y6YJzjPrqFouCEU4qjv5YvCVvnfoSC
         +eJLbFg0r2cabY9PkiY7J4rUxphVaHl6EeygTj8zWIFzkehJ21FBZ8f3k9aGdsJJfP
         Y2gRUqYq++mD9zdaJdvjBKbK5Fv0MtoZgbcEKD9Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 608DE35227C1; Wed, 22 Apr 2020 16:16:42 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:16:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 5/6] rcu: rename kfree_call_rcu()/__kfree_rcu()
Message-ID: <20200422231642.GJ17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-6-urezki@gmail.com>
 <20200316152541.GD190951@google.com>
 <20200316190144.GB10577@pc636>
 <20200420201527.679247f6fa76cba4331f3cd3@linux-foundation.org>
 <20200421120358.GA5117@pc636>
 <20200422230322.GA100393@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422230322.GA100393@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 07:03:22PM -0400, Joel Fernandes wrote:
> On Tue, Apr 21, 2020 at 02:03:58PM +0200, Uladzislau Rezki wrote:
> > Hello, Andrew.
> > 
> > > > > I based the kfree_rcu shrinker patches on an 'rcu/kfree' branch in my git
> > > > > tree: https://github.com/joelagnel/linux-kernel/tree/rcu/kfree
> > > > > 
> > > > > For now I manually applied 5/6. All others applied cleanly.
> > > > > 
> > > > > Updated the tree as I continue to review your patches.
> > > > >
> > > 
> > > I'm not sure what's happening here - these patches aren't yet in
> > > linux-next.
> > > 
> > Please have a look here, i explained in detail in my cover latter
> > what we would like to achieve: https://lkml.org/lkml/2020/3/23/242
> > 
> > > A couple of thoughts:
> > > 
> > > - Please cc linux-mm@kvack.org on this patchset and anything else
> > >   which impacts MM.
> > > 
> > OK. I thought that is related to RCU, therefore i did not want to
> > spam, but i included you :) Next time we will keep linux-mm@kvack.org
> > in a loop. Sorry for that.
> 
> Sorry from my side as well. Will keep linux-mm in the loop henceforth.

I must confess that it came as a bit of a surprise to me as well.

But what is life without a surprise or two along the way?  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > >
> > > - It's a bit strange to create new infrastructure which has but a
> > >   single call site.  Please tell us much more about "there was also
> > >   request/interest so there will be new comers" to set minds at ease. 
> > > 
> > >   Who/where are these possible new callsites and when can we expect to
> > >   see that code?
> > > 
> > https://lkml.org/lkml/2020/3/23/242 here i wrote motivation. Please
> > check it. If you have some questions please ask.
> > 
> > --
> > Vlad Rezki
