Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF60026E6BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIQUZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgIQUZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:25:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D99C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:25:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t138so3736503qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hb/NvhxGlTQOGkAb8QBT51mnjZK7SELytRM7upeU+SA=;
        b=X+99c5GW9un6SPrnLDbMdN14ayb+SsTeBo9tqOEEjShXWP8rdjTHbV90pOoeoDgyNk
         ao0fgmrXUoeFtpWjllc9gAtOT+spEEIrvjk14HjI3Ly6STtEGcUk0KpcNj6ZeSVz0hzI
         i7MFkMUXe0waOZjJ9PDTdmuyrZR34oRufqXayFubinza8YjyuW8QUSwhoJ55Fu8/pVBI
         jh8p7U5AgM1bMpGL/N81LSN2xyGJNZ6cW9+M5fXg3MDhl1BJE2uDDbgSgYKDUL9sbpDb
         EOqbO0Zf5weKeut8h6vWmA1jVK6fohi5Y8GFrZNPfFvZDKg+s8weru+1lIDBRiW0lhT4
         kgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hb/NvhxGlTQOGkAb8QBT51mnjZK7SELytRM7upeU+SA=;
        b=pco633rorQCwW6rJzg0NvYLVjq6nRNJ5ZcVZ0MjZk1eo8V2yyeSu31WzkNC26PdAOW
         2C4XwlCXRrIQ7iJeyemtq2kKPRnu8E6FChcr/5QHgKkWgwP4Knv/25bOurUuFqLt/+zh
         3sj/kCiNH9VjRpiPHI5X9+xJuUl6329ByRfsegm4bCuadeRfW6ZO3rlvQ+Xyi2mS8NG5
         Ht4KnQ99bj8n9gHlDdMESLKnijkEAC/ykXG3xahzDWgGZ+/l5C/rvXCEaKSKiOd6lGuv
         pb+IvNhtf55JGewFXys4Muugt85nI1gIjrevQMJiURlbRSKbJ2mPtp8f+Do7gqCmZxee
         aOyQ==
X-Gm-Message-State: AOAM532ynL7d2Kse5JOrf85OsIC+boFVS/g+YLhQ9pkBVa138MjoBaDJ
        QgrDWmu2/ThNW+2Xgl9lpNIing==
X-Google-Smtp-Source: ABdhPJyGHFVbWVpn7pUZNbKM3NvObWEGi7YtDcOpfmlW7eJyn5NktwnpqKLnTt/1radk9XI0Vr5Hqg==
X-Received: by 2002:a37:54a:: with SMTP id 71mr26830800qkf.407.1600374316326;
        Thu, 17 Sep 2020 13:25:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z3sm583141qkf.92.2020.09.17.13.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 13:25:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJ0Sw-000lSJ-U4; Thu, 17 Sep 2020 17:25:14 -0300
Date:   Thu, 17 Sep 2020 17:25:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200917202514.GN8409@ziepe.ca>
References: <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
 <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
 <20200917200638.GM8409@ziepe.ca>
 <24b8ad6b-4e4c-4651-86e6-bc2232fce772@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b8ad6b-4e4c-4651-86e6-bc2232fce772@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:19:02PM -0700, John Hubbard wrote:
> On 9/17/20 1:06 PM, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2020 at 12:42:11PM -0700, Linus Torvalds wrote:
> ...
> > > Is there possibly somethign else we can filter on than just
> > > GUP_PIN_COUNTING_BIAS? Because it could be as simple as just marking
> > > the vma itself and saying "this vma has had a page pinning event done
> > > on it".
> > 
> > We'd have to give up pin_user_pages_fast() to do that as we can't fast
> > walk and get vmas?
> 
> oops, yes. I'd forgotten about that point. Basically all of the O_DIRECT
> callers need _fast. This is a big problem.

What about an atomic counter in the mm_struct? 

# of pages currently under pin.

The use case Linus is worried about will never have any pins, so it
would be 0 and it could skip this entire test.

Jason
