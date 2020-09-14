Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739682694F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgINSep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:34:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbgINSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600108481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoDQ2n0CqfZHa9Xxpu2Rfnih0N+SlKozEUzu09fQF50=;
        b=h2mtNXNGj4fzDCmzNQbUbox0MNxOxNW2b7/PCQg8MdhPRUjih9mD/HsoyxuJt0Bb9ZNV9W
        sBc/kN2dYCC3uKEURsuFlZRRCM1f8c1aKYOPuuLdeyTWVMA2LgRiuZfjMRVC4LqKXDHL4f
        fp5+cTy6MrKQPKkrQNifyhimZB7XYwo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-k6QmwDzoNxijhJY4HgJNgg-1; Mon, 14 Sep 2020 14:34:40 -0400
X-MC-Unique: k6QmwDzoNxijhJY4HgJNgg-1
Received: by mail-qk1-f198.google.com with SMTP id c19so811003qkk.20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qoDQ2n0CqfZHa9Xxpu2Rfnih0N+SlKozEUzu09fQF50=;
        b=RjukHVBXBwZxpCM/HY12WoQfLR1uySZx8Ux02PUL87aV1vnBqUa3jh/VmXA0fXVnU8
         Uz/VWoNENt9ddRUCOC4JRQEL0e6K8tx3AfhTJZIYl+IiiF1pdn2GsxbfToAwY+vic6zo
         hWmxV2YYXMWH9HdTzyhmNfR/+Z7uNWTvD8n0lp3a+qsLI1yMvSdWYUm8qOGKdAbHTpib
         vQcKER1MackLm2xBE3lXop4bwbUYXFxk/OjFPQEVr7tJvjIrXl9ZYXZVfzsKRb0U2yW5
         Pd9WjBA6rYDJ/feKAgEeasmO9zsjs6YZFPACCTXqCOfm88p9HSgw5YGzvZTJkzfLuHQR
         9IIg==
X-Gm-Message-State: AOAM532mrLJPaK6Z7PBPY+e8fLcHhwbwbDjpcfIQ4Ujlf9VD015RUFlV
        rueyVYz7cnsKfRijpOP0TypzBIAZ6xXAyCltiuRMjMJqavSwR4UFfuyaUhsrlrrwooi5ibBv9Rr
        5A3QwQ+FDzd5MfG9NlD2dOgUE
X-Received: by 2002:a05:620a:5b1:: with SMTP id q17mr14021824qkq.384.1600108479683;
        Mon, 14 Sep 2020 11:34:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgg3KGB3Cx7ac3y4P5dlwu5/pwToaZolHCYh05g9Q/t03ZMWjqQGk8dssdZSZqTOTuDfNrOA==
X-Received: by 2002:a05:620a:5b1:: with SMTP id q17mr14021800qkq.384.1600108479412;
        Mon, 14 Sep 2020 11:34:39 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id k72sm13594099qke.121.2020.09.14.11.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:34:38 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:34:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20200914183436.GD30881@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:32:11AM -0700, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 7:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > I don't have a detailed explanation right now, but this patch appears
> > to be causing a regression where RDMA subsystem tests fail. Tests
> > return to normal when this patch is reverted.
> >
> > It kind of looks like the process is not seeing DMA'd data to a
> > pin_user_pages()?
> 
> I'm a nincompoop. I actually _talked_ to Hugh Dickins about this when
> he raised concerns, and I dismissed his concerns with "but PAGE_PIN is
> special".
> 
> As usual, Hugh was right. Page pinning certainly _is_ special, but
> it's not that different from the regular GUP code.
> 
> But in the meantime, I have a lovely confirmation from the kernel test
> robot, saying that commit 09854ba94c results in a
> "vm-scalability.throughput 31.4% improvement", which was what I was
> hoping for - the complexity wasn't just complexity, it was active
> badness due to the page locking horrors.
> 
> I think what we want to do is basically do the "early COW", but only
> do it for FOLL_PIN (and not turn them into writes for anything but the
> COW code). So basically redo the "enforced COW mechanism", but rather
> than do it for everything, now do it only for FOLL_PIN, and only in
> that COW path.
> 
> Peter - any chance you can look at this? I'm still looking at the page
> lock fairness performance regression, although I now think I have a
> test patch for Phoronix to test out.

Sure, I'll try to prepare something like that and share it shortly.

Thanks,

-- 
Peter Xu

