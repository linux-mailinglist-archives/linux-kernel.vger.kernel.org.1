Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB0F2735C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgIUWaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgIUWaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600727409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSApC7Na2CgdhhBi62TssFqLybrjuoTgagPGcr/kNG4=;
        b=Le/enJncr4ewaFF11MXFJdqayyrQBL/vpmuxUY8KTuKUEnvIhN+Rys7C4+4bpkVIjk4nxX
        BKwi33DIMWVQpyGBAVD8RDiaBrX/Mhvz/okMH148/NGT/TAvXp/j5RPEiCVKfGwbIdZSMZ
        iyvAxUSlpCVshaZp44f1VP+GAylflJ0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-Ylkwg5dbP5W25us6ZSsKtg-1; Mon, 21 Sep 2020 18:30:07 -0400
X-MC-Unique: Ylkwg5dbP5W25us6ZSsKtg-1
Received: by mail-qt1-f199.google.com with SMTP id o13so14240965qtl.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KSApC7Na2CgdhhBi62TssFqLybrjuoTgagPGcr/kNG4=;
        b=lJp9WaU3WmPB/9dNaaLAComuo+XHBbBEcZnJ/CJ2CR8iZyytn3XGeE4jLVpNtJUI6I
         jSR2IfkyXwBjxpzx7BxInxJNzQ83e5t+QkP0TnOOkp7aPdW8Xh06lBRyW0CL6gqWHtSt
         vrkv4u6dbfK1Sd2OksGXBneenpVKoUwR1rkHFBmueeJVaU8XKYF0pt96s5HVl/JxiNZ+
         7ySORJ8au64fYVQm12WEcQCRT39zJ6d453rmccfB6INP1L8PInfg1nlyym3sXoVmWSs9
         ICgpdKjuPQeleEMBiWOxmrl57IznyHe3FX+XufJ9iPcM/vBalvA5O63Bogdv3HjqngiO
         9Nhg==
X-Gm-Message-State: AOAM531NPg04w/g3h8X4WT4jdKASg0nAlqMHX4sIWBJrdzvkou/RF+gi
        jXTyIjBwgydQnyxQ3GaUjFrkXbFUv01GzmpijxOM4b+9Xox7DwzY+GqOxDNtYsu2jo1uYR+iqvL
        QCUnqlAYY6UzUsG0gRWiDVyHq
X-Received: by 2002:ad4:58e3:: with SMTP id di3mr2546930qvb.54.1600727407405;
        Mon, 21 Sep 2020 15:30:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7yDDqzQavxj1WSxnVtoFxmUhMLJhJEAPcYlCLMX1JHtL7k7rPnfP18HWufMRHg6GHUe4vtQ==
X-Received: by 2002:ad4:58e3:: with SMTP id di3mr2546913qvb.54.1600727407197;
        Mon, 21 Sep 2020 15:30:07 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id o4sm10218609qkk.75.2020.09.21.15.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:30:06 -0700 (PDT)
Date:   Mon, 21 Sep 2020 18:30:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200921223004.GB19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <CAG48ez0o+yBpYdzR_-bU3A0nrpzXyM+c+Yk=ZtOZ92qe5x0izA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0o+yBpYdzR_-bU3A0nrpzXyM+c+Yk=ZtOZ92qe5x0izA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:43:38PM +0200, Jann Horn wrote:
> On Mon, Sep 21, 2020 at 11:17 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > (Commit message collected from Jason Gunthorpe)
> >
> > Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
> > track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> > that have never been passed to pin_user_pages() cannot have a positive
> > page_maybe_dma_pinned() by definition.
> 
> There are some caveats here, right? E.g. this isn't necessarily true
> for pagecache pages, I think?

Sorry I didn't follow here.  Could you help explain with some details?

Thanks,

-- 
Peter Xu

