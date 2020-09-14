Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91BD268CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgINOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgINOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:08:19 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71557C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:08:19 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a8so16904782ilk.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fctxu7rmqR9iwM1SRRmUo1RPPdPeoBrrnFYgiya+56E=;
        b=grP9mBb4KNUrt6s5j5aZDliofeFad5VWpNdpG7QV94Lq30LC+iL4EExE7kyGKWB5Gf
         /gSh5AyuAed2NYgfVl+TGjM6+PvxmXzc4hKIQBH3SfoUY3P3t1LV4232yJI75e/YJNG6
         Q+FpLdX/A/RXeNFtq9e2HUk91tNk7d+VWEdYqzgF6WJmp5TR26CFRkEIeLDEiTdr9ACA
         91aJyHqx2eQWN4Z4enVwN2LT4t1ICt9n0QjRRgL80aVofbYWfiyzEIrTWcE0URGKvlZS
         8W5ulQtbKbTyaYpofTmquomWBpZFd+9ywGLaRsd5cZ9vgh5cJeBQ4LzVp0OOFE78katd
         Sm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fctxu7rmqR9iwM1SRRmUo1RPPdPeoBrrnFYgiya+56E=;
        b=pt/D/gwtC86h42zplvZTiRsvIHE0yDahSHkQ50Z8/ElzrdNWrp7LiVlDxo9curdtDi
         OzK77Id2xCMbpbAAbsG0nAIXootRzRVpeP3clJmIHe4BNiWazV2qJ+VhT/K4PU4C6Ik9
         Z9soe3Z4yJLy7dTSG+TSW0FtlBtk5hx/uRVOhlpMYWXFs1V8tXXe2eQyjXkMVRiM7p3D
         8YkavMLH/stUe4mDtEIoIV3R+Y4b82oTIytSDYWVQQlApqrWVEPY+Gm9y0brLSfTdks1
         74t6RdYfyDr+5CSN+S6TSiB+Oe5a8Zh0yF56RKPwQPNpgSJPlUrSjRBNePTon2iiFovS
         rLTw==
X-Gm-Message-State: AOAM530pGumF9zD95x3xErl6sI3rF8S7N4d4vEjMPpiV/g+NzqwVm/VA
        zgcIv4Kc2s6gBdV4h41Noy3hIw==
X-Google-Smtp-Source: ABdhPJxqHuHFmUi4XSYUrDn5jbXri907X+UgEsG3mAQAgDE1Hk4Av6GNH2lJfQO/tH0rRUWPkMdG3w==
X-Received: by 2002:a92:5893:: with SMTP id z19mr3854498ilf.158.1600092495877;
        Mon, 14 Sep 2020 07:08:15 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c12sm6771213ilm.17.2020.09.14.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:08:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kHp9S-005y8Y-9k; Mon, 14 Sep 2020 11:08:14 -0300
Date:   Mon, 14 Sep 2020 11:08:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/gup.c: Handling ERR within unpin_user_pages()
Message-ID: <20200914140814.GE1221970@ziepe.ca>
References: <1600007555-11650-1-git-send-email-jrdr.linux@gmail.com>
 <20200913145520.GH6583@casper.infradead.org>
 <CAFqt6zYru2VfaBFHEB6+7vMPXUbgX8R5f+GHqxaGjhP8QZEyzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYru2VfaBFHEB6+7vMPXUbgX8R5f+GHqxaGjhP8QZEyzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:20:34AM +0530, Souptick Joarder wrote:
> On Sun, Sep 13, 2020 at 8:25 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Sep 13, 2020 at 08:02:35PM +0530, Souptick Joarder wrote:
> > > It is possible that a buggy caller of unpin_user_pages()
> > > (specially in error handling path) may end up calling it with
> > > npages < 0 which is unnecessary.
> > > @@ -328,6 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
> > >  {
> > >       unsigned long index;
> > >
> > > +     if (WARN_ON_ONCE(npages < 0))
> > > +             return;
> >
> > But npages is unsigned long.  So it can't be less than zero.
> 
> Sorry, I missed it.
> 
> Then, it means if npages is assigned with -ERRNO by caller, unpin_user_pages()
> may end up calling a big loop, which is unnecessary.

How will a caller allocate memory of the right size and still manage
to call with the wrong npages? Do you have an example of a broken caller?

Jason
