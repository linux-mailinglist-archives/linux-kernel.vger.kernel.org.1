Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8839027463C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIVQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:10:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:10:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k25so15978023qtu.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Vl0iSMcOXyao6qb+mlx5tyYrlNVljHFBTvCu/sbwcE=;
        b=DQmup5IacmK0M1JgFhK8SgL6Orwefv8vRSFfd4Utb6UlC/AtTAq3uWvYcoCsPXoO+0
         jSHSc/lDrYcODasxoB6mCfSdgciqS9yar5ov7yS/52yEYdaSNz0VR8xVTcbROjBEFo6G
         zyOiOJgfn2SPh4dvpeK8JyCG4VW8l3kLXNeO8cYku4OlUbhERNC4yuqrCobVzauG4FYt
         tIr4cp+pW2aVx44S8cDUBH6hRcvDV/gYZ5xKTJvmZ6anyZAeB4PXvOqdljKM72xS4oWf
         fKDbNqCODLJq2zuD46CWwlDZt0igf5EDNTP+GE9KbGwpB+N6jMBQTLiO7ihOFLoFR7gM
         Sk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Vl0iSMcOXyao6qb+mlx5tyYrlNVljHFBTvCu/sbwcE=;
        b=ISgntfcYVe+4LnU9IUso9AuGMDJmDxcF0SFZuppWdkCohYmnHe0dIzHTJ8vowA5aOe
         DVcDw3Yr69AR9NJuLLvqroYL1/R6ImvTa/qAdM3J5QtBdZsUZwboKc8lPnT1vh09lL6s
         c0JtcDqBOgup3kPSjPvwDZ23jToqYhUSeG/wfbNgAlmzNDjsaQlSccOl6pYdRTCQpex/
         IwnWyT9VeYDuvxJoPuALvNtZjVMxA/8d7hGlUzu/zJC3FIxZyeYhliAvdh9A/kavTFjo
         GS0RNes/AeYGvXoGZ6z4tHXbXicCSe4USgsIm7PWsy8b7iC7BgHhwSMTKGv98cVITqHa
         pAWg==
X-Gm-Message-State: AOAM531ZCKbIID7QgcX/sbT06cOq71j1t+Z9U6om1jiKuERGfpH6UZUo
        8bIWxZ4S9GByV3T4zl3P5oGh2A==
X-Google-Smtp-Source: ABdhPJx3MvXCkuW79dduAHvbtsPt1XZsdujt1v708ppwo5lOljCguasgspUqIMVvVIokdZHpdoWy5Q==
X-Received: by 2002:ac8:1a48:: with SMTP id q8mr5508936qtk.240.1600791048289;
        Tue, 22 Sep 2020 09:10:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 202sm11573021qkg.56.2020.09.22.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:10:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kKksQ-0034i7-Mt; Tue, 22 Sep 2020 13:10:46 -0300
Date:   Tue, 22 Sep 2020 13:10:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200922161046.GB731578@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922151736.GD19098@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:17:36AM -0400, Peter Xu wrote:

> > But it's admittedly a cosmetic point, combined with my perennial fear that
> > I'm missing something when I look at a READ_ONCE()/WRITE_ONCE() pair. :)
> 
> Yeah but I hope I'm using it right.. :) I used READ_ONCE/WRITE_ONCE explicitly
> because I think they're cheaper than atomic operations, (which will, iiuc, lock
> the bus).

It is worth thinking a bit about racing fork with
pin_user_pages(). The desired outcome is:

  If fork wins the page is write protected, and pin_user_pages_fast()
  will COW it.

  If pin_user_pages_fast() wins then fork must see the READ_ONCE and
  the pin.

As get_user_pages_fast() is lockless it looks like the ordering has to
be like this:

  pin_user_pages_fast()                   fork()
   atomic_set(has_pinned, 1);
   [..]
   atomic_add(page->_refcount)
   ordered check write protect()
                                          ordered set write protect()
                                          atomic_read(page->_refcount)
                                          atomic_read(has_pinned)

Such that in all the degenerate racy cases the outcome is that both
sides COW, never neither.

Thus I think it does have to be atomics purely from an ordering
perspective, observing an increased _refcount requires that has_pinned
!= 0 if we are pinning.

So, to make this 100% this ordering will need to be touched up too.

Jason
