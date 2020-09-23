Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32901275E63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIWRMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWRMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:12:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95ACC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:12:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id p65so532686qtd.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YH/9x4YduAyQyFROAONGfUKpUo9D+DQjCl2dO1jW42c=;
        b=TRkNPai+t1R0PtqPcyqs6KRV5QEbc5x6RwYBkbneOVWJUErvcMuwUfidTUu24hxvyM
         QWWezsITBu4MtvOSn52tUC4S+bParRapl0X1mF37RPWvx1qRmxnLLM8IoCpXai2n27mH
         Xntw7cmjEgXr3GjsThBy3MziR0NoftOW9lGqsGcjV+yx8u8QFsgjEkSpNGzJIVb4yV/T
         c64V+znpcZwKsPdgLyasu5JkVCGdiuwpf3EiT3C8lUdLMDdxp8CZ3+br0S6bmNmQHaZT
         /E9bdFiaO7KOWdWGOeoqG7XI9coRz+0HTBpiS3k9dlSFxGSMAv7gKooWZfQwiV2Qj9Go
         ChwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YH/9x4YduAyQyFROAONGfUKpUo9D+DQjCl2dO1jW42c=;
        b=PhYiWxbUwxsvjTnM/RNGgkUcqXPZwESPEBFhg+e5aGRYzNH8kY3c7gWwn7J5Ol0BMf
         57cyQY44Z90MV1jRsxbh5/OmO0QdcLEN+vAmtQHDlbFUq2C6gpWwLYzS868LL0JgJu/o
         UHu/zkfnvsoLbQyE0UUcIDohvXNfY37HPTcSxdcsVVvFN0V+S2mA0NLTnF8xbbnhw7R6
         qAUZN63Atjayvww1R9WIP79XB0iGb3IHS/K54BW33LexQ/DirUBbIGXwJSCPodFkCvXx
         CSea45xgnYjoiu02Gi1CKunVaYXHp85QxgVOcgKKRuhVr38B43jOmUhC1uCQB1HGLt7o
         rxpQ==
X-Gm-Message-State: AOAM532eLNmTKfGGoyVLtPwqF85PqND14TZeRRKva02ml/onzG3Dxbq2
        uonWeH4EVoBGgsTsvbjpoVmR6SrhR+U2tGi+
X-Google-Smtp-Source: ABdhPJxhAjIHv39LR6OHwFCOae6z68HtgCbw+0HGYa1v5jIrIg/spi3GmVBR2szfKKNfPUBjRm5YCQ==
X-Received: by 2002:ac8:1c5a:: with SMTP id j26mr1153667qtk.48.1600881129105;
        Wed, 23 Sep 2020 10:12:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g25sm259170qto.47.2020.09.23.10.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 10:12:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kL8JL-0006N8-Pz; Wed, 23 Sep 2020 14:12:07 -0300
Date:   Wed, 23 Sep 2020 14:12:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200923171207.GB9916@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923131043.GA59978@xz-x1>
 <20200923142003.GB15875@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923142003.GB15875@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 04:20:03PM +0200, Jan Kara wrote:

> I'd hate to take spinlock in the GUP-fast path. Also I don't think this is
> quite correct because GUP-fast-only can be called from interrupt context
> and page table locks are not interrupt safe. 

Yes, IIRC, that is a key element of GUP-fast. Was it something to do
with futexes?

> and then checking page_may_be_dma_pinned() during fork(). That should work
> just fine AFAICT... BTW note that GUP-fast code is (and this is deliberated
> because e.g. DAX depends on this) first updating page->_refcount and then
> rechecking PTE didn't change and the page->_refcount update is actually
> done using atomic_add_unless() so that it cannot be reordered wrt the PTE
> check. So the fork() code only needs to add barriers to pair with this.

It is not just DAX, everything needs this check.

After the page is pinned it is prevented from being freed and
recycled. After GUP has the pin it must check that the PTE still
points at the same page, otherwise it might have pinned a page that is
alreay free'd - and that would be a use-after-free issue.

ason
