Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B7D26E77F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIQVlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgIQVlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600378864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQ1n2NAsz3VF5VdxDZBasnfNcenN2+9JB5WfZ+Z/fJA=;
        b=eLizkE+Ln3vDJ0rWGTGL2gsLT5pahnRW4oc8UJTFEOAsbdeoC2LWRWxFCzPL6xFw8aVROZ
        LEAac81dk0VFrtSKllWZLJ9K1/vrSIi08kuU87mY7BoaImdGAMawX2pKnps7Ypz54ycXkd
        zNm4Y6zWHc8X0LavtoQ0yjMSvxBUQg0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-IzYW6Qi4MVO3WwfWzGAWPw-1; Thu, 17 Sep 2020 17:41:03 -0400
X-MC-Unique: IzYW6Qi4MVO3WwfWzGAWPw-1
Received: by mail-qk1-f199.google.com with SMTP id 139so2755613qkl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 14:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQ1n2NAsz3VF5VdxDZBasnfNcenN2+9JB5WfZ+Z/fJA=;
        b=kWE+3CeWGwbxhaaEAl2oopW7dVeVW29WQ40bpM0w7+LMtTQIReMuE6PJFZb2NswzDJ
         DbA/oMl2j36quwZ8ndlk8omVI7CArQhCLrYjiyjoD80fJjKqw6Z5MWhb23drLI8NIvhd
         zMtJgtJuaiNdUsavjg3l37f5EvmHlHs4+g4eM3MvqGrrewEK2fa/1x8V/H9Ly+SK/Qc5
         BcFwh4vZ2toqdVFdkK0yVJIZRCXZ/4DkV2aKUU5JhsFS3vlvA/+pkOsLkBsBXfJPXPdg
         gooCpvPGQrMv7xqxhylX2LQWhy0zqILpm+Cp/TB/6gS/Qemi10K2OdB12pgOPWQv3Si0
         xVZg==
X-Gm-Message-State: AOAM530L+3FAQj5v/K3iEv6W+5Hq1cjCmP/DDuysMmgpNuVGSKVO3ow/
        7hQVHr13hs3vXigCNcAT9LhpUxOqKiCBA6UuXnj+sWqaS9QNex+tol1tltnkDyxvQwtGC8VlYi5
        NMuhw0KZtCdx+GpkuDysiCvi6
X-Received: by 2002:ac8:2934:: with SMTP id y49mr16991423qty.202.1600378862612;
        Thu, 17 Sep 2020 14:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsMO7lJNEG6rp/cRDai03s8C8GWzPhRnPgWZqUSSBWMOqA8cQnSYxe/cCO2Iqx4US8S+xJCw==
X-Received: by 2002:ac8:2934:: with SMTP id y49mr16991404qty.202.1600378862360;
        Thu, 17 Sep 2020 14:41:02 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id x197sm791645qkb.17.2020.09.17.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 14:41:01 -0700 (PDT)
Date:   Thu, 17 Sep 2020 17:40:59 -0400
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
Message-ID: <20200917214059.GA162800@xz-x1>
References: <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
 <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
 <20200917200638.GM8409@ziepe.ca>
 <CAHk-=wh+qz0oOjyiQFXR_73RYSDUmJwHC8xd=KG0RzELnbS5OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+qz0oOjyiQFXR_73RYSDUmJwHC8xd=KG0RzELnbS5OA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:35:56PM -0700, Linus Torvalds wrote:
> For that to happen, we'd need to have the vma flag so that we wouldn't
> have any worry about non-pinners, but as you suggested, I think even
> just a mm-wide counter - or flag - to deal with the fast-bup case is
> likely perfectly sufficient.

Would mm_struct.pinned_vm suffice?

Though now I'm not 100% certain whether all pin_user_pages*() callers are
accounting correctly upon pinned_vm.  My gut feeling is that bc3e53f682d93df67
does not convert all the old locked_vm users with page pinnings (e.g.,
mm_iommu_do_alloc, vaddr_get_pfn, etc.; didn't try harder).

-- 
Peter Xu

