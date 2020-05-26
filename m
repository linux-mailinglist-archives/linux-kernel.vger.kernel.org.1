Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7294B1C307F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 02:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgEDAbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 20:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgEDAbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 20:31:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89581C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 17:31:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 23so15122144qkf.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ta4uElbW6xoU05q9EisNotKHdMyGumUpwIk7d429KuY=;
        b=bK4+bwjsosYkVretPd6KcRggU2QP2snaoUIf8XtHrfU8iS5FxMrzm9JXspfXNRa3mq
         zWxEMdySKXcr1xJbtgmua5JYKkfZdBR69+G/2DYgIiyCkBS4LETSIV6qrhYP/N7PCMne
         O6wB/HGOVETLt+qigIeouS4qxNslp5SM/7Ppo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ta4uElbW6xoU05q9EisNotKHdMyGumUpwIk7d429KuY=;
        b=WkH2nMnOlD64674DejubpZs5N1HsKn6bK90P2ABzDFLVNDMGV24BCJPce6gcLd8qpL
         g3rdIqOBdlHBtrGQ321hpYl9eAUigdU+oO3sLFj/f/Ir579aTn/bUP2kB65PVHjbzYe8
         lzNIkp/hNx6K78a8c0LxJwsFbn9NrHh+CdUjUPHIo58LsVIh+VmmhIenwlzhEq3u05xf
         s2tulonAqZJDbI/k8fKagDtrZpE2U/2sCTrfSzkXoFjgRDd28vAf5EGnyVCpeXxiuqTs
         fI/bFRROsWQlN9p1KNrQw3JdJXKnWoXq2RcHWbLwNesb1JLKQqWoBTxslPISUV+S6Snm
         mHrA==
X-Gm-Message-State: AGi0PuaMAKi80UP4xouRkAZmDErTAJIIcfYolydURfWbTy+GzqAPSACu
        js5E7K4XhX/lEsxeyXKRLmjjyA==
X-Google-Smtp-Source: APiQypKMQfD3xwkZfKm7FXlyJStZaazEGR14S1Id8dbivLXWPQcn6uUzQHuucRtz3t1o8R1jlyjSsA==
X-Received: by 2002:a37:804:: with SMTP id 4mr6151611qki.405.1588552267701;
        Sun, 03 May 2020 17:31:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y185sm8705031qkd.29.2020.05.03.17.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 17:31:07 -0700 (PDT)
Date:   Sun, 3 May 2020 20:31:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 20/24] rcu/tree: Make kvfree_rcu() tolerate any alignment
Message-ID: <20200504003106.GC212435@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-21-urezki@gmail.com>
 <20200501230052.GG7560@paulmck-ThinkPad-P72>
 <20200504002437.GA212435@google.com>
 <20200504002947.GG2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504002947.GG2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 03, 2020 at 05:29:47PM -0700, Paul E. McKenney wrote:
> On Sun, May 03, 2020 at 08:24:37PM -0400, Joel Fernandes wrote:
> > On Fri, May 01, 2020 at 04:00:52PM -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 28, 2020 at 10:58:59PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > 
> > > > Handle cases where the the object being kvfree_rcu()'d is not aligned by
> > > > 2-byte boundaries.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 9 ++++++---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 501cac02146d..649bad7ad0f0 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2877,6 +2877,9 @@ struct kvfree_rcu_bulk_data {
> > > >  #define KVFREE_BULK_MAX_ENTR \
> > > >  	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
> > > >  
> > > > +/* Encoding the offset of a fake rcu_head to indicate the head is a wrapper. */
> > > > +#define RCU_HEADLESS_KFREE BIT(31)
> > > 
> > > Did I miss the check for freeing something larger than 2GB?  Or is this
> > > impossible, even on systems with many terabytes of physical memory?
> > > Even if it is currently impossible, what prevents it from suddenly
> > > becoming all too possible at some random point in the future?  If you
> > > think that this will never happen, please keep in mind that the first
> > > time I heard "640K ought to be enough for anybody", it sounded eminently
> > > reasonable to me.
> > > 
> > > Besides...
> > > 
> > > Isn't the offset in question the offset of an rcu_head struct within
> > > the enclosing structure? If so, why not keep the current requirement
> > > that this be at least 16-bit aligned, especially given that some work
> > > is required to make that alignment less than pointer sized?  Then you
> > > can continue using bit 0.
> > > 
> > > This alignment requirement is included in the RCU requirements
> > > documentation and is enforced within the __call_rcu() function.
> > > 
> > > So let's leave this at bit 0.
> > 
> > This patch is needed only if we are growing the fake rcu_head. Since you
> > mentioned in a previous patch in this series that you don't want to do that,
> > and just rely on availability of the array of pointers or synchronize_rcu(),
> > we can drop this patch. If we are not dropping that earlier patch, let us
> > discuss more.
> 
> Dropping it sounds very good to me!

Cool ;-) Thanks,

 - Joel

