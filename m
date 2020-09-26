Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF22795A4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgIZAlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZAlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:41:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3026C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:41:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so4815132qki.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z03jhkM5FKCSytBVpDf3SoLlQk6jxAYhSPYM141uH90=;
        b=FTPekw7lMtsQCdEiTyzoxRlbkw5QfkvghMrgncYfcqWss9HCGNjDu5TPKURgdy7D/g
         RizmwtJOAtmIQO9Dk5cAiVA1o/Z+vP5RbGJKDG76FrHiTzJnXQmlbnWkbDFs0AMi0ml0
         jR1WZ+Y3Vkpa0RTGcGM9my9UNuP9EXrKWvVd1v97fKTUV66bQMFWMNEVoQciMzWauzDL
         uf3yfHiB0Bze+EdrIkXWEYvgA8R4DpqwsPjW8WcyZf8q8AHbix89dYta56oYhew5xIOC
         F7jXpOwPGYWyDw+78ISqo4uDkRvISrtAYYNwgJk6YY11jgqoFxh8QZC6bFIagIlyBldZ
         gtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z03jhkM5FKCSytBVpDf3SoLlQk6jxAYhSPYM141uH90=;
        b=Y0uKJscZQgbHAVbUFUfmLriPxV3rW9r1qVqweejKau2Brr3ghR3A4nE8Pz6alOXbmU
         /4FM9XupVEuy5dtH7hjBj3ozGzY8XEgb4HZm3ROwJTgeA3ly+JjiQIGZhsSFnjcO3Uci
         VdCdsq1ViE3lHoFtq7Qnl0BvfP5CzFhGQJy0OugJpWFliudYLnYrFxAc72hDNH0Bi4tP
         riojWfL52d2zn6wAHfInknQXf/g9pilB7XDfjO7pBwTYGbVWnpUZVaAArtV9Xq2U9Sf9
         mQEuCBPEvcQTItkNInHUNwI2eX2bsS8PVST+uTOb75JsYi4cZcSAE01NnYPbgm2BuN1X
         VX8w==
X-Gm-Message-State: AOAM533Cp/604cjoWbtHFDDS78ewCS+KIUQlf4DAFDzqP+yBM195m5VH
        z8bF4ZmhWAqirRsPxK9qwEi+qw==
X-Google-Smtp-Source: ABdhPJzezC9vwnwQ2IkSDwPBL44Lz64ZH+hLN4/gvamgv6OT5N1b1qb0I/1kjNXvldA5bLCpTp1QAg==
X-Received: by 2002:a37:9f07:: with SMTP id i7mr2632006qke.440.1601080898519;
        Fri, 25 Sep 2020 17:41:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t10sm2868220qkt.55.2020.09.25.17.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 17:41:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kLyHQ-001DeG-L7; Fri, 25 Sep 2020 21:41:36 -0300
Date:   Fri, 25 Sep 2020 21:41:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200926004136.GJ9916@ziepe.ca>
References: <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1>
 <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1>
 <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1>
 <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 02:06:59PM -0700, Linus Torvalds wrote:
> On Fri, Sep 25, 2020 at 12:56 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And honestly, since this is all getting fairly late in the rc, and it
> > took longer than I thought, I think we should do the GFP_ATOMIC
> > approach for now - not great, but since it only triggers for this case
> > that really should never happen anyway, I think it's probably the best
> > thing for 5.9, and we can improve on things later.
> 
> I'm not super-happy with this patch, but I'm throwing it out anyway, in case
> 
>  (a) somebody can test it - I don't have any test cases

It looks like it will work and resolve the RDMA case that triggered
this discussion. I will send it to our testers, should hear back
around Monday.

They previously said Peter's v1 patch worked, expecting the same here,
unless something unexpected hits the extra pre-conditions.

Though, we might hit the THP case and find it fails...

>  (b) somebody can find issues and improve on it

The THP hunks from Peter's series looked pretty straightforward, I'd
include at least the PMD one.

As a tiny optimization, the preconditions in copy_normal_page() could
order the atomics last to try and reduce the atomics done per fork.

> I'm happy to take Peter's series too, this is more of an alternative
> simplified version to keep the discussion going.

I don't completely grok the consequences of the anon_vma check. We
can exclude file backed mappings as they are broken for pinning
anyhow, so what is left that could be MAP_PRIVATE of a non-anon_vma?

Feels obscure, probably OK. If something does break userspace could
use MAP_SHARED and be fixed.

Otherwise, I do prefer Peter's version because of the GFP_KERNEL. To
touch on your other email..

It was my hope we could move away from the "This should never
happen". From a RDMA POV this idea was sort of managable years ago,
but now I have folks writing data science/ML software in Python that
deep under the libraries use RDMA and has pinned pages. It was a
Python program that detected this regression.

Having all that "just work" regardless of what foolish stuff happens
in the Python layer is very appealing.

Jason
