Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB202726D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgIUOSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgIUOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600697916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kc3JtLhbC99DIB1MGA9gsNfzzfbDbT5HNfRaQ0VV0ag=;
        b=UFS8ZxSvrxsV8QphnvJTcq4qhgpOEKNaVqu4keCCTRbF28U8etOeNo5KAQLPEbYFO34efm
        pU6yIqZ/1QhygmO45xSv/2UKhMWeQ4kc74PUk54viE83zOJc5jo1o/+dDVMFr1xPy8dt65
        SdYHZCxRiJt+90ezXBRoJiDYgoSBU2E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-UULx97uLPoyViVlZKFAeTg-1; Mon, 21 Sep 2020 10:18:34 -0400
X-MC-Unique: UULx97uLPoyViVlZKFAeTg-1
Received: by mail-qk1-f200.google.com with SMTP id r184so10950781qka.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kc3JtLhbC99DIB1MGA9gsNfzzfbDbT5HNfRaQ0VV0ag=;
        b=e7SnA+RXDXJaDcG/cEY3PfNTQeTDbMTm3kRqROmONYooJsVDZw9YpUiBACUfiVTLCC
         xt3boW6Ncn8M6dS1upKFbjLUadeAXQPLOR/vjJQ1W1VfY6yECLb4f8xNLYbjmIcosO93
         bx7PH0Mar5tV9WHGdyljz7mkKSYbOk6oUHsmbkFqxozouUBcIIoqOQqEbChQi0R52bBH
         d2iaqixUOsRffzLnMtTHWKol6+IHR+eAXiLOUNqndPI32xwIoA1Yx4wLX3uNn9Lh8Dn2
         Pqyjb9KPKI8mYUBM/wsVoTzS+Kmik+lboIMIv8ciEV0j47/cpNxkvLsi/04jsGJaAIKe
         9RsQ==
X-Gm-Message-State: AOAM530HVuf47Y9XmPrRy69HuKTGlI5NMEDjIGQhnh0rxOiyFlD4K3Lw
        uaPJNY+EhsaU+YbZ3+ByEm5WJaHV+FFLL5vzoK09wFAgkF2dc9xGrLgrJNthV9DAsgOOZAyWXFH
        v+r5iJmEtoVkFlAP0YDq+7XFy
X-Received: by 2002:a0c:9142:: with SMTP id q60mr114206qvq.13.1600697913976;
        Mon, 21 Sep 2020 07:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6ccKm9BmtEHfecT9fiekz74G47EtfQogzuefL3Myj9gAvsauASmDwjZk7yiMlLcXPgS5ULg==
X-Received: by 2002:a0c:9142:: with SMTP id q60mr114162qvq.13.1600697913640;
        Mon, 21 Sep 2020 07:18:33 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id c11sm9620762qkb.58.2020.09.21.07.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 07:18:32 -0700 (PDT)
Date:   Mon, 21 Sep 2020 10:18:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20200921141830.GE5962@xz-x1>
References: <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200921134200.GK12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921134200.GK12990@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal,

On Mon, Sep 21, 2020 at 03:42:00PM +0200, Michal Hocko wrote:
> [Cc Tejun and Christian - this is a part of a larger discussion which is
>  not directly related to this particular question so let me trim the
>  original email to the bare minimum.]
> 
> On Fri 18-09-20 12:40:32, Peter Xu wrote:
> [...]
> > One issue is when we charge for cgroup we probably can't do that onto the new
> > mm/task, since copy_namespaces() is called after copy_mm().  I don't know
> > enough about cgroup, I thought the child will inherit the parent's, but I'm not
> > sure.  Or, can we change that order of copy_namespaces() && copy_mm()?  I don't
> > see a problem so far but I'd like to ask first..
> 
> I suspect you are referring to CLONE_INTO_CGROUP, right?

Thanks for raising this question up to a broader audience.

I was not referring to that explicilty, but it would definitely be good to know
this new feature before I post the (probably stupid :) patch. Because I noticed
it's only done until cgroup_can_fork() or later, so it's definitely also later
than copy_mm() even if I do the move.

> I have only now
> learned about this feature so I am not deeply familiar with all the
> details and I might be easily wrong. Normally all the cgroup aware
> resources are accounted to the parent's cgroup. For memcg that includes
> all the page tables, early CoW and other allocations with __GFP_ACCOUNT.
> IIUC CLONE_INTO_CGROUP properly then this hasn't changed as the child is
> associated to its new cgroup (and memcg) only in cgroup_post_fork. If
> that is correct then we might have quite a lot of resources bound to
> child's lifetime but accounted to the parent's memcg which can lead to
> all sorts of interesting problems (e.g. unreclaimable memory - even by
> the oom killer).

Right that's one of the things that I'm confused too, on that if we always
account to the parent, then when the child quits whether we uncharge them or
not, and how..  Not sure whether the accounting of the parent could steadily
grow as it continues the fork()s.

So is it by design that we account all these to the parents?

> 
> Christian, Tejun is this the expected semantic or I am just misreading
> the code?

I'll try to summarize the question here too - what we'd like to do right now is
to do cgroup accounting (e.g., mem_cgroup_charge()) upon the newly created
process within copy_mm().  A quick summary of why we want to do this is to
"trigger early copy-on-write for pinned pages during fork()".

Initially I thought moving copy_mm() to be after copy_namespaces() would be the
right thing to do, but now I highly doubt it..

Thanks,

-- 
Peter Xu

