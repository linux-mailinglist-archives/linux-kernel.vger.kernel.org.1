Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1882705DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRT5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgIRT5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600459065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/g7ZSNROlpJMrEUtWDRpRe5vjuvZ4Kcl9hqq8QxtxyA=;
        b=i/Tn5CQ16xbxaiYs6VntWtxbL9yMvfNa3w2rFt+/F841302X3X5d82iW2jOtkcr0rBEb3C
        SDDaKcc5mSIHykUyiKHcii7lUxi+YIZUm2s6t7qZ3cAM5c7UiYwPvgFPmBt0+1czHCSZqI
        4pb6ihp6xNmQPmylEE/FJticu8LeK8Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-35SujhhWNs-ckbv6cKddhg-1; Fri, 18 Sep 2020 15:57:43 -0400
X-MC-Unique: 35SujhhWNs-ckbv6cKddhg-1
Received: by mail-qv1-f70.google.com with SMTP id p20so4589440qvl.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/g7ZSNROlpJMrEUtWDRpRe5vjuvZ4Kcl9hqq8QxtxyA=;
        b=ipkytUOMZ5RixL8p4p6dA6ldaBd4cThmfLvS13SfvtN64f5kUqWnVKKXb6uHo1DNFu
         79ZpV6XxKI2TyJeIxSj54RO9XiQSADshQIqGDVW36rKyL3jhSv7Wh3o0gX66uRF3aYd0
         0lo34IbyUAr/XaSGuHxxWSQlqQgbW1JmUQ2x7m7Q7JQyme54y3HasBnWa71gZMUiSS9D
         vBxE680hpJV1OcwTf2R9xGnCCWZnMCQQEwpQezuA2weGXQKAeJR+djSlW/Xy2zutb+45
         LcrLCuuo+dYx0gHGNifJkwAGdAYz3bPb308jEOQsreHJBor0Q0Q8DTjgh/pj4zXSvH6p
         1N5Q==
X-Gm-Message-State: AOAM531EHUGDCvV2YrTqIvstOvw6HQj1mh2AmQSG5lkbo6fwuJsDlaHu
        UpKR66BnPg+8MRmGy5gopwp4l4ki5jo1xBBsjGe2W/vizSLpSVv0Bm9eY4Oi1iFEvzWD9PClBh9
        bS+uanAXtPC5UoSp4Pe03W/XX
X-Received: by 2002:a37:aca:: with SMTP id 193mr35797831qkk.149.1600459062901;
        Fri, 18 Sep 2020 12:57:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrSCIo7RHMYY3CDjs/ANl3bd11aNIAfLAaxeB9KNGSSGUQAU8xnC5IuWMh44vt17aA9xbXdg==
X-Received: by 2002:a37:aca:: with SMTP id 193mr35797817qkk.149.1600459062592;
        Fri, 18 Sep 2020 12:57:42 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id n7sm2919885qtf.27.2020.09.18.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 12:57:41 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:57:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20200918195740.GB5962@xz-x1>
References: <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <CAHk-=whL44VySgScXjvCQ4VkeaW3nOcPMn0UwnY03iOE=1T7VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whL44VySgScXjvCQ4VkeaW3nOcPMn0UwnY03iOE=1T7VQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:16:19AM -0700, Linus Torvalds wrote:
> The only change I'd make is to make it a "int" and put it next to the
> "int map_count", since that will pack better on 64-bit (assuming you
> don't do the randomize_layout thing, in which case it's all moot).

Will do.

[...]

> > One issue is when we charge for cgroup we probably can't do that onto the new
> > mm/task, since copy_namespaces() is called after copy_mm().
> 
> That cannot possibly matter as far as I can see.
> 
> Copying the page in between those two calls is already possible since
> we've already dropped the mmap_lock by the time copy_namespaces() is
> called. So if the parent was threaded, and another thread did a write
> access, the parent would have caused that COW that we did early.
> 
> And any page copying cost should be to the parent anyway, since that
> is who did the pinning that caused the copy in the first place.
> 
> So for both of those reasons - the COW can already happen between
> copy_mm() and copy_namespaces(), *and* charging it to the parent
> namespace is proper anyway - I think your cgroup worry is not
> relevant.
> 
> I'm not even sure anything relevant to accounting is created, but my
> point is that even if it is, I don't see how it could be an issue.

The parent process should be fine to do any COW and do its accounting right,
which I agree.  But the new COW that we're adding here is for the child process
rather than the parent.

I'm just afraid the parent process's accounting number could go very high after
it pinned some pages and fork()ed a few more times, since those extra
accountings will accumulate even after the children die, if I'm not wrong...

Actually I tend to move copy_namespaces() to be before copy_mm() now..  I know
nothing about namespaces, however I see that copy_namespaces() seems to be
quite self-contained.  But I'm always ready for a "no, you can't"...

> 
> > The other thing is on how to fail.  E.g., when COW failed due to either
> > charging of cgroup or ENOMEM, ideally we should fail fork() too.  Though that
> > might need more changes - current patch silently kept the shared page for
> > simplicity.
> 
> We already can fail forkind due to memory allocations failing. Again,
> not an issue. It happens.

Yes.  I didn't change this only because I thought it could save quite a few
lines of codes.  However after I notice the fact that this patch will probably
grow bigger no matter what, I'm kind of not worrying on this any more..

-- 
Peter Xu

