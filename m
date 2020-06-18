Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C501FFA61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 19:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgFRRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFRRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:35:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E78BC06174E;
        Thu, 18 Jun 2020 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wKqNA3EeTkgG7RP/Q9T1JShDJKFnZTf+jj7QQYV4wkU=; b=qDyD8J2esdxA0WqhPixbQMugAB
        xett1RLL/j/foQDTYaVAx9vQqCwLW+SY7Vf4XlVNjaKuN3LL0BP9JSYwNs/+W1loT+akTcHMexJwC
        g2LCkmvVZ9mR+uCaYeh4EP1D8QTppiO3JqpAoiirWy3hkntYHZreyDfW12kHpPoDEeTjHGOtTEauk
        i2UxH1xejM6pFRDCezcjehVPbZgcjp2QgiXfEf09qDO+N+6JNWA/OlWaZRKxN9lqmqMHhdt4bjige
        p/ILAtdvmhpKIqeYcEVCJYTag3c0PHdSVkH5aooEpQ6UDqRgx4p7GNBxKMLJX+d7dWnz6rj6ymzLa
        d0I5zGtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlyRj-0006ek-EB; Thu, 18 Jun 2020 17:35:27 +0000
Date:   Thu, 18 Jun 2020 10:35:27 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618173527.GR8681@bombadil.infradead.org>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618173049.GB14613@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618173049.GB14613@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:30:49PM +0200, Uladzislau Rezki wrote:
> > I'd suggest:
> > 
> >  			rcu_lock_acquire(&rcu_callback_map);
> > 			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
> > 				bkvhead[i]->nr_records, bkvhead[i]->records);
> >  			if (i == 0) {
> >  				kfree_bulk(bkvhead[i]->nr_records,
> >  					bkvhead[i]->records);
> >  			} else {
> >  				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> >  					vfree(bkvhead[i]->records[j]);
> >  				}
> >  			}
> >  			rcu_lock_release(&rcu_callback_map);
> >
> There are two different trace functions, one for "bulk" tracing
> messages, and another one is per one call of kfree(), though we use 
> to indicate vfree() call.
> 
> Probably we can rename it to: trace_rcu_invoke_kvfree_callback();
> 
> What do you think?

Works for me!

> > But I'd also suggest a vfree_bulk be added.  There are a few things
> > which would be better done in bulk as part of the vfree process
> > (we batch them up already, but i'm sure we could do better).
> 
> I was thinking to implement of vfree_bulk() API, but i guess it can
> be done as future work.
> 
> Does that sound good?

Yes, definitely a future piece of work.
