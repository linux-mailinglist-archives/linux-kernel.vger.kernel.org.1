Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB527B8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgI2AbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbgI2AbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:31:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601339459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KvjrWxE7p1uKtiSqam0MWPYzBBvAKlG+w6tiS6hXtPk=;
        b=dSAdYZc8jkHGWuw6QAh4OlD68YmFQkijAlE/ZUGasCnsZ3GhaqxLAOXmBgVK7tErkY87AI
        A14vQE7Gfku/E8Et3Rs6Q0H5k0IcCcqHiF6pnaDMZkvntWXCZCTqCp18FmOdkIJQOCXxp6
        8bbB6yaC1ur3lj5vywZ7MMhvjCwsmv4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-jh_4Ny3aOcWnb99bnyVOpA-1; Mon, 28 Sep 2020 20:30:57 -0400
X-MC-Unique: jh_4Ny3aOcWnb99bnyVOpA-1
Received: by mail-qv1-f69.google.com with SMTP id t4so1607807qvr.21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KvjrWxE7p1uKtiSqam0MWPYzBBvAKlG+w6tiS6hXtPk=;
        b=tIFprM0tAD0Ah7kMPFQqtykA/oYTbUSTrv30/bxX+r5WWTm1omH2aLkzGQbxFsCLED
         HJ5pOChngG6YeEdFWK982qDzpCmwkwNYRzCphfN88N9SuuYs6cElNK/lET+bU+G+Shcz
         no6JAz9Ywk+i9kETRmzNgAWlvTxLnrzPlTu2z8i9cwRh/sZGCJ++ljTyuE0y9D50qU6K
         GKZRetc8PPGHqTWCY63PEpHLHb82BlOnwXkr/7Fno4Xm+F533pfyB3C0+sTuu38/Re9Y
         z7WgDij2a/i697bUDx3bJ+dTtF58YuAoiHXVj+NlJrq1Sup4h43D2viPXii+dl4MUeBz
         44dQ==
X-Gm-Message-State: AOAM530JNBNBcxjYtn5jrcszdpByGa8Pkejv0QacBbkfxfiE2b1lvbcC
        M/M6XavZnHKjQ4zV4rFNW3L6MGhf1pwLluIZAcLr1wGvZnLAFEr7t41lqLLoyv+PMbEV0VcJByH
        Ap9MgM6Yk261cwtvk/7WtYO7e
X-Received: by 2002:a05:620a:90c:: with SMTP id v12mr1991746qkv.16.1601339457230;
        Mon, 28 Sep 2020 17:30:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHeZrzQ/HEjSKQSGh/rUbEibZNnnTqxnzr1D8d9WoObhlHFSBrnpHBk8nv3jfeNY1xFdhQOg==
X-Received: by 2002:a05:620a:90c:: with SMTP id v12mr1991683qkv.16.1601339456339;
        Mon, 28 Sep 2020 17:30:56 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id m18sm2804062qkg.77.2020.09.28.17.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:30:55 -0700 (PDT)
Date:   Mon, 28 Sep 2020 20:30:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200929003054.GF59869@xz-x1>
References: <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca>
 <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1>
 <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
 <20200928183928.GR9916@ziepe.ca>
 <CAHk-=wgu+6Cx_=U1Vh4Fzm97JA1k76fS905uEAVK-2eJ_1KukQ@mail.gmail.com>
 <CAHk-=wiWr+gO0Ro4LvnJBMs90OiePNyrE3E+pJvc9PzdBShdmw@mail.gmail.com>
 <20200928225107.GT9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200928225107.GT9916@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 07:51:07PM -0300, Jason Gunthorpe wrote:
> > So I'll attach my suggested patch, but I won't actually commit it. I'd
> > really like to have this tested, possibly _together_ with the sequence
> > count addition..
> 
> Ok, we will do this once the holidays are over. If Peter doesn't take
> it I can look at the seqcount too.

Please feel free to.  I can definitely test against the vfio test I used to
run, but assuming the rdma test would be more ideal.  Just let me know if
there's anything else I can help.

Thanks,

-- 
Peter Xu

