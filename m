Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAD26E7F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQWJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQWJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:09:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:09:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so3262235qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=syUESK5T5X7qlZjNL/nndaanKVVB4DAYkuwRndzHwzo=;
        b=iJL/T4RAiIZAU6602tCLvBP50hv5qBv76+EgdhKhRXME6zWxoQabvFaCu+1qTaoWnX
         AWuNC/tAT6xLQTFRqG7GZ4M/np2CMnsOU4hPsrTsOeKzME99yE4c7FIEXHm8j6k/Z9HO
         ZqBERjkEW0E5Po1RrftxYM25gxONpEUPbouh0DrcalJMvveyuux2MP9ll3z3L/9PBMh3
         9CFiVaIUIDqrc+AMLpz4f0OIjLOYYbPtaF+jQSWCgYe6UQ+32kwW594XO6XKB7fSHFlk
         66nvhPYykaBc/IXnRg5zcRaRKM/dJ4sHyZJ/3uRP6vjeRYuOJJYZ3RYtH/SdKUwwsLF+
         5UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=syUESK5T5X7qlZjNL/nndaanKVVB4DAYkuwRndzHwzo=;
        b=gfQsf38dVcl0CGip6qVYRX0cMGLcY5EdlusySmDj62CtWbJ96WLsJN5Ob15QpYfqr1
         BuP2fROps18/Ks8GqRVZGAS0CSP2sRDRcDkA8ZxnHGeAMRiJi9llYIHEr2xLG6owJ+fV
         LD0qTyYk2+2wgjOHu7hlM/q0lsFytexf9O/QvGxEG9MXvGfTGb1gUFPIbe/RQV4yL41n
         Y9BynZDZylo6WtSgdLmbfbnsQexau52cqNdjho/sXhso/pRWYiVZqqsg0SDv3/pvxWb2
         gfQf7avWwJkOW/qZaX8EGmoQ+BbTQe2HUhWTrzqkLsrKTUNvcQp1qfVbyE6xFfRqT++S
         5xTw==
X-Gm-Message-State: AOAM531S2n0lNXlay9TmEyqKYV23vtFJgp8CZP2OCnDzsrWYsHap2dRH
        TpnM935Jxchh/4Vd1MPl69Xb6w==
X-Google-Smtp-Source: ABdhPJx/RswyKZ+BE7nlycFNmvYGJ+5hJ02F88qY2qiWW1+mgOJEaK3SuHEtv/XkJtmR/MmKNqCV+Q==
X-Received: by 2002:ac8:6f21:: with SMTP id i1mr28879258qtv.89.1600380541744;
        Thu, 17 Sep 2020 15:09:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b79sm825430qkg.10.2020.09.17.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:09:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJ25M-000mg0-H0; Thu, 17 Sep 2020 19:09:00 -0300
Date:   Thu, 17 Sep 2020 19:09:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20200917220900.GO8409@ziepe.ca>
References: <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
 <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
 <20200917200638.GM8409@ziepe.ca>
 <CAHk-=wh+qz0oOjyiQFXR_73RYSDUmJwHC8xd=KG0RzELnbS5OA@mail.gmail.com>
 <20200917214059.GA162800@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917214059.GA162800@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 05:40:59PM -0400, Peter Xu wrote:
> On Thu, Sep 17, 2020 at 01:35:56PM -0700, Linus Torvalds wrote:
> > For that to happen, we'd need to have the vma flag so that we wouldn't
> > have any worry about non-pinners, but as you suggested, I think even
> > just a mm-wide counter - or flag - to deal with the fast-bup case is
> > likely perfectly sufficient.
> 
> Would mm_struct.pinned_vm suffice?

I think that could be a good long term goal

IIRC last time we dug into the locked_vm vs pinned_vm mess it didn't
get fixed. There is a mix of both kinds, as you saw, and some
resistance I don't clearly remember to changing it.

My advice for this -rc fix is to go with a single bit in the mm_struct
set on any call to pin_user_pages*

Then only users using pin_user_pages and forking are the only ones who
would ever do extra COW on fork. I think that is OK for -rc, this
workload should be rare due to the various historical issues. Anyhow,
a slow down regression is better than a it is broken regression.

This can be improved into a counter later. Due to the pinned_vm
accounting all call sites should have the mm_struct at unpin, but I
have a feeling it will take a alot of driver patches to sort it all
out.

Jason
