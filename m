Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97C127EFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgI3RFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI3RFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:05:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601485519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZKcauAc0nfeHpM0es/OPCwFvNQgO5rpGzRp/Vk1ptw=;
        b=Bojdu6ZneaKg+3xW8y13nPXGyHebpdgUOCPPcpwhv+AyiU/K52txDR2FdLKGcDLwN0FXBK
        6nth/bcT6Lt1hXLmci4CQNzl/51C+V+hXAbQsvbR9rwnBppDyXMHVtTXezc+0WHdmDt3ZL
        7CS3MZzK5bngUcA58f/3JbeWOwrZ2ss=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-bvVgGqvJNpaSpdej6b8x9g-1; Wed, 30 Sep 2020 13:05:17 -0400
X-MC-Unique: bvVgGqvJNpaSpdej6b8x9g-1
Received: by mail-qt1-f197.google.com with SMTP id w3so1643911qtn.16
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CZKcauAc0nfeHpM0es/OPCwFvNQgO5rpGzRp/Vk1ptw=;
        b=gSDlI41IMTlndq/5UCCHjdPJrlJqe/kxN2XCGvVYcAesLPJuYRREGrArCMl6R1WED6
         2bVJSjNtk5FTLJMEIMF1Lzra6mVV+D1lo7Po2uBXrfdc7gz9Kncvn2dBQOv6ZgjBrG+B
         cb19flrMd6lBkl2XgzWLRvB66NII2+NPLxaoAi+k12AGNjd/M3lxg/jETy69Wtp3gIgG
         RyY1l2PrmQ6cPqeK8SunxPb7lkEA2ZC7euEVckKqAct5ShUPWLEqV8nNNWIxyrcVfzDz
         NGvReBVB5CeGa59SDPhxi2EbWAIzyjQXR82/PcAqNqtNmIps8NZX4HyL/K5gRt7Asmkh
         GqMw==
X-Gm-Message-State: AOAM530ikPiZSOT3bpzdR/w4yegR3FbA9ispT1Sm86PRbYBqAjxp/C8f
        1Qz9gEPpl2+wtGHFoAMc27ButMv6ktzuEh/p1CBoXyD6Kacucdbp/oGLpLJSBgLjuUrjUTy3AiV
        AVqpsM+bGgeSgqkcfaUQlOK8W
X-Received: by 2002:a05:620a:90c:: with SMTP id v12mr3462542qkv.16.1601485514543;
        Wed, 30 Sep 2020 10:05:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzfYHBUf5QfbzgCwdhaQpjv71pvcL4htrtAB8ovhm90oVovrzU1gnTHYUfvlNK2itvbmRDDA==
X-Received: by 2002:a05:620a:90c:: with SMTP id v12mr3462492qkv.16.1601485513923;
        Wed, 30 Sep 2020 10:05:13 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id l8sm3023315qtk.77.2020.09.30.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 10:05:13 -0700 (PDT)
Date:   Wed, 30 Sep 2020 13:05:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v2 2/4] mm/fork: Pass new vma pointer into
 copy_page_range()
Message-ID: <20200930170511.GA130406@xz-x1>
References: <20200925222600.6832-1-peterx@redhat.com>
 <20200925222600.6832-3-peterx@redhat.com>
 <20200930133055.sdejarcv7nyhc2yc@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930133055.sdejarcv7nyhc2yc@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:30:55PM +0300, Kirill A. Shutemov wrote:
> >  int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
> > -			struct vm_area_struct *vma);
> > +		    struct vm_area_struct *vma, struct vm_area_struct *new);
> 
> It makes dst/src mm_struct arguments redundant. There's always vma->vm_mm.

Indeed.  I'll post a patch later for it.  Thanks.

-- 
Peter Xu

