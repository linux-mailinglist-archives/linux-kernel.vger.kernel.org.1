Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB0F27788D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgIXSj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:39:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F15C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:39:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so3784229qtj.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6kbTN227ky6se6GWSxv41w9bcLrPJYb+hPK0FBP3Lg8=;
        b=gWVZzyi+aAbtDvJswci5KIVx20vljopjCPq9XTRfZQcpoUp6L/NpC+o8fz/o8v+djp
         P8kwqc3LM0DEHmxKFsPUZn0HgipLID3Q4GATLkjQqmbbv8NXLgCRiHYbtP7OApNNAUFg
         taF2/VN5MUeTgDcMiVkcWoPS5GoFDY2cDEELqVmXJH3c4n5VtJVyUm/cw2y/0oHM+4Me
         rb1gw+R5+irhjXNZzpTV8tRKd0rh/IrYatrYQxI2GChtmQtogPnwvB0C2TZpu4Nhob3G
         q+TeJX6KHRT9tMbE+WAZHsWfS+OXEE6gb9jwyc6XrB40S8K+ksJOVhlOJdhqRNLtBdho
         1bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6kbTN227ky6se6GWSxv41w9bcLrPJYb+hPK0FBP3Lg8=;
        b=SZ7fGlp74bGN3fKKlk4dA3zIDmlsi8jU+rl7uZm0zPxSfvlizT6FXUFo6nj2fGbBf+
         L2Lsj5Ixc7LpXkjFVt25SLqA1JjVljTTayWS7mTNvaD+FlhfFWjXPWuwnvJF1RUptVUr
         ik6UV0C5TxwcxlZAGqSnAl27zjr1MWJrP314NttEtf0/o6/bVkxWHDA4UmsIeJVjjK1D
         Rff+fXyqx2Nq2BJ3pBDVxIz4jKJL2toPD2CoDyVq4c+bihKcnDNwBQKy9lfBfn6fKZUn
         pGDFl7bROGwxGkt8cWvMJMXoMaFFhcCkU4ijO6cHHUo2jbPwCfFIQHqCe0NfMfyDOFoz
         M3oQ==
X-Gm-Message-State: AOAM531JFxKxylB5EhAw8cq18J+KTWyFxBz3q3+OMJbJIl3FeBJYZLDj
        bEy72ULL6+LeifkIf1EQ/nve9g==
X-Google-Smtp-Source: ABdhPJx/nzPF1+mMk4wCyfDA/nz8skTDrljJDGUq+fRssNEpMom5E/VQfo1/HE+wA3mhVgTkXlbjYA==
X-Received: by 2002:ac8:75d2:: with SMTP id z18mr504702qtq.346.1600972795287;
        Thu, 24 Sep 2020 11:39:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n203sm193262qke.66.2020.09.24.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 11:39:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kLW9p-000RJr-PH; Thu, 24 Sep 2020 15:39:53 -0300
Date:   Thu, 24 Sep 2020 15:39:53 -0300
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
Message-ID: <20200924183953.GG9916@ziepe.ca>
References: <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1>
 <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924183418.GJ79898@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:34:18PM -0400, Peter Xu wrote:

> > >        // RDONLY gup
> > >        pin_user_pages(buf, !WRITE);
> > >        // pte of buf duplicated on both sides
> > >        fork();
> > >        mprotect(buf, WRITE);
> > >        *buf = 1;
> > >        // buf page replaced as cow triggered
> > > 
> > > Currently when fork() we'll happily share a pinned read-only page with the
> > > child by copying the pte directly.  
> > 
> > Why? This series prevents that, the page will be maybe_dma_pinned, so
> > fork() will copy it.
> 
> With the extra mprotect(!WRITE), I think we'll see a !pte_write() entry.  Then
> it'll not go into maybe_dma_pinned() at all since cow==false.

Hum that seems like a problem in this patch, we still need to do the
DMA pinned logic even if the pte is already write protected.

Jason
