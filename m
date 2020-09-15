Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B565426ABE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgIOS3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgIOS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:29:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:29:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j2so5197669ioj.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QH0oevRAXAfKjkr8xwGWq7ufd7Zmd6cGXZiCflHDesA=;
        b=a5D8w8T9XU1Z5Sg3El875tpdfLEgvabG4sAGeB37Wr1WfMICFJ1rqI8EuyKuvKFyqh
         ctfGnliM0miH9CluA8q6wGyqcv8uoRUwKJv4avYtqpZD4YJzJvlGvHh7shIPeYLjqfgE
         YWl+Ati9kVlc7YjQcKkn5lzOIe8Uj0vt1ho1m5QvYhc2Zg+nCk6WumnncLPwfApQaP1F
         yG2TXV8o1w0tAlJFQs0tVe0boOSeXBXHzCsx258y4QSFvQAYGV8CAz/85XFxMjNvjqXu
         Xw8I17Y/orn+PMg2qFeslypqX86SNsS23BXpBGNhN7R1tKvT2A/i8kTfmSrXRM2T9Nyb
         U5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QH0oevRAXAfKjkr8xwGWq7ufd7Zmd6cGXZiCflHDesA=;
        b=lQswLdshwSNkrdAjWmzVE2Cf7ytCCQFwVKm6yopCK8eDzQK2jdllC/ZDb2qiRrZ3Rk
         flfNO2vmt8hDWKRl0MZ5mccplSFOG1iRxnLp+WhE0UeTeGkXYmjyYnDBHtWXuTruIO2z
         mhJ20p71JoFJa1262wvtH61SFefnpe+K9/jule885GZglkuf8ybHdzcj0pA4MBR3u45O
         o/qh0SLJxqrNI11ORnC9CI/YHvbcikRd7PAcFf0yzCE8i22eVkIf5f75jwpc33JRMxbd
         lD2fYp+1jeusYuAqqhgZYP8tLBcrqhRSBUMHnocpLrBkUAYt9ZSIDvrqkrzMM3p9EDMg
         3pCw==
X-Gm-Message-State: AOAM530Rz34pa+H1X+8f35cUWVXhmELo3+DqITDsTe/uTDPrpc3kCzOa
        N7AYa3mmEUzmLpWuqgKfrVI6UQ==
X-Google-Smtp-Source: ABdhPJwmx/LUpglx7XpAipNeMR+kHJPe2QCViaCkWocmK98vW3k5whvbv4Z0KH1re3/hxdhjxsU/yw==
X-Received: by 2002:a05:6638:24c1:: with SMTP id y1mr18589650jat.119.1600194575776;
        Tue, 15 Sep 2020 11:29:35 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p17sm9234963ilj.81.2020.09.15.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 11:29:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIFht-006eMK-OT; Tue, 15 Sep 2020 15:29:33 -0300
Date:   Tue, 15 Sep 2020 15:29:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200915182933.GM1221970@ziepe.ca>
References: <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915160553.GJ1221970@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 01:05:53PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 10:50:40AM -0400, Peter Xu wrote:
> > On Mon, Sep 14, 2020 at 08:28:51PM -0300, Jason Gunthorpe wrote:
> > > Yes, this stuff does pin_user_pages_fast() and MADV_DONTFORK
> > > together. It sets FOLL_FORCE and FOLL_WRITE to get an exclusive copy
> > > of the page and MADV_DONTFORK was needed to ensure that a future fork
> > > doesn't establish a COW that would break the DMA by moving the
> > > physical page over to the fork. DMA should stay with the process that
> > > called pin_user_pages_fast() (Is MADV_DONTFORK still needed with
> > > recent years work to GUP/etc? It is a pretty terrible ancient thing)
> > 
> > ... Now I'm more confused on what has happened.
> 
> I'm going to try to confirm that the MADV_DONTFORK is actually being
> done by userspace properly, more later.

It turns out the test is broken and does not call MADV_DONTFORK when
doing forks - it is an opt-in it didn't do.

It looks to me like this patch makes it much more likely that the COW
break after page pinning will end up moving the pinned physical page
to the fork while before it was not very common. Does that make sense?

Given that the tests are wrong it seems like broken userspace,
however, it also worked reliably for a fairly long time.

I'm waiting for confirmation that adding the missing MADV_DONTFORKS
restores all tests to success even with this patch.

Regards,
Jason
