Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD99272C55
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgIUQbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgIUQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600705879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCM4fKtgeOMOirEKB7YXGA+aIYpRp3p+tCGoFRLfrkc=;
        b=EBmfATeK1oTkwL10gSyX5k1DEbhL06jkIByCpMMfsSIvLwwOQ7Gaw4YNN08D+8sH4NJhQJ
        NWjrhaXkRWi3fBuhUqykwta9oBu/9R4uSDJ2WtmTwByZy2znQEME34p8qTzu7Sblv6TXJc
        ntn1soSEvItvPYCfyeMycz9+XSexing=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-ouIWdwa4NP6RtCpqDEncEA-1; Mon, 21 Sep 2020 12:31:16 -0400
X-MC-Unique: ouIWdwa4NP6RtCpqDEncEA-1
Received: by mail-qv1-f72.google.com with SMTP id k14so9439263qvw.20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YCM4fKtgeOMOirEKB7YXGA+aIYpRp3p+tCGoFRLfrkc=;
        b=mMi+DBBe3qAZ2l1f9q9PsC52eVMlUlHxTvp189PwfDQZPuvAMrqjUcxD0XKkX10KIw
         zAqTMkzgCWjGhxcHgBhk2OW+5JmhL1SbD01aWHbc7nwPVrtgsOCjeM5MGqxo/rJXDsSk
         PstmndsT4r6EvHm6sgSmAlh0BnJDzaflWACXYitB1OIR9+YSol7xf0J1HLDFoNTUafIO
         WAxe1/+em3giUaFRaD2BGg9TXxGgBOn7AHGyaybz0UkDj6ukdj3Zri1UTaHlHv4dhOf5
         gWnnHekh3CaVmABk0zvE6hf9+QMEYle9UBnu8BZ8ff3uchUJg+fMRS1okJ2+pWnTCskb
         Ee9w==
X-Gm-Message-State: AOAM533AwPc1t38xq5C0nKI4jurYlFWWyUKiVU+weQMaJSgoslqQg3BX
        W0BR8jfUXjiYyQpq1XpdZXBXT6ItXOtKp1EKdQQUBYwN2z/GNDhQ5VVQzd2PCABjzd0wWvobLts
        ZR4U/jLNni3kLk6CmxBCuW0ry
X-Received: by 2002:a05:620a:1f2:: with SMTP id x18mr623976qkn.150.1600705876037;
        Mon, 21 Sep 2020 09:31:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5i8SjLtXMnIDDkKkJKM0liSfJpsqpbKyLvEjynpyJz3EWrpexOnbBkvIlIYOJfOiJCk2DQQ==
X-Received: by 2002:a05:620a:1f2:: with SMTP id x18mr623933qkn.150.1600705875707;
        Mon, 21 Sep 2020 09:31:15 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t11sm10214526qtp.32.2020.09.21.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:31:14 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:31:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tejun Heo <tj@kernel.org>,
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
Message-ID: <20200921163112.GF5962@xz-x1>
References: <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200921134200.GK12990@dhcp22.suse.cz>
 <20200921144134.fuvkkv6wgrzpbwnv@wittgenstein>
 <20200921145738.GN12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921145738.GN12990@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 04:57:38PM +0200, Michal Hocko wrote:
> Switching the order wouldn't make much of a difference right. At least
> not for memcg where all the accounted allocations will still go to
> current's memcg.

I think I'll make it simple to charge the parent directly just like what we do
right now.  I do expect that the charged amount could be quite some when
there're a lot pinned pages on the parent process, however hopefully it's
acceptable as it's still a very rare case, and proper MADV_DONTFORK upon pinned
pages on the parent process will eliminate all these charges too.

I actually already prepared some patches.  It's definitely bigger than expected
due to the complexity that we held page table locks in copy_one_pte() when
trying to break the cow pages.  I don't know whether it would be proper any
more for rc, especially the ending of rcs.  Anyway I'll post them out soon
after I did some basic tests, because I think that's something right to do
irrelevant to when it will be merged.

Thanks,

-- 
Peter Xu

