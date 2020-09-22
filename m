Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0202747FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIVSNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:13:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgIVSNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600798396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=71Fdmnk5+zjGGKXcJZwLvS205zm9cv4AZ4wruSNhUcM=;
        b=Cazc8AqYLJvKQ/gcaVfX3rFU3QapKw1aozlEoJdBT9X8s4Wodww8xXX78Bc3wYBkNESpuI
        Td2/L+6fJ5XIr/wV2Oc2bH9fiBs/QxcKqO3d5yD6PkzeUH6b9xp0o69GErMlqkFPd+RA6o
        CdXd3wDTjtvQlYo47ies2BQNu/RpbqY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-7gzpWfp5P6GigcwWrgJJIQ-1; Tue, 22 Sep 2020 14:13:09 -0400
X-MC-Unique: 7gzpWfp5P6GigcwWrgJJIQ-1
Received: by mail-qk1-f197.google.com with SMTP id m23so14366031qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=71Fdmnk5+zjGGKXcJZwLvS205zm9cv4AZ4wruSNhUcM=;
        b=Ka+ubo3Z+1Y0DKW4SRXAXf42nBqMA1UqrNYYwvWwhUPQ4mI/52t+DzCfKxu/b0oHwI
         n98E1pzWuPStuwnTyrKbxsNmVRxghiF5b1H64rt7XZUDcXV35I8WjCjIvYxwLDiFD9pK
         DbytYlmbaId6k8oIM+9cuWqNRWE03CKoXolTUgfeCxBPZL7pQRv55j5rNe6CguW9AJ4w
         UjaTKCv7Xi1SMH7+3wVo5EbTdiLV1l1KsjqZ5VspepL1a5HAAH7SG+o4cyPMe2PmRAcS
         7kRyOP18GAV6Y5uk7zj9/PJdu8GMQjnpnzOz7uHul0oO6EB/h3asNurc3SeXTQv8bSbl
         GyoQ==
X-Gm-Message-State: AOAM530dQMBea7F3bbUa8+rSyl+b5qAEWCxm82snGA18zQ+p6uk+BVMa
        KflUJXs75W0IoelY7tPIRt798OSIh3KqUHx2umaee+J6u0QrbySc6cl/0kYtna9XafeGziesmFa
        Luw2yezTjhEUG5Z9Gh1l2JRUf
X-Received: by 2002:ac8:4059:: with SMTP id j25mr6042660qtl.155.1600798389097;
        Tue, 22 Sep 2020 11:13:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfvmGh7iELa5nbikWtKbuG7m8huILlGOMffTQ2A5cRtCL5n4tlxPOqOgSKoAAjJj4AgN1MAw==
X-Received: by 2002:ac8:4059:: with SMTP id j25mr6042636qtl.155.1600798388868;
        Tue, 22 Sep 2020 11:13:08 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id h18sm11699096qkl.12.2020.09.22.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:13:08 -0700 (PDT)
Date:   Tue, 22 Sep 2020 14:13:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
Message-ID: <20200922181306.GJ19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
 <20200922100840.GA11679@redhat.com>
 <20200922101815.GB11679@redhat.com>
 <20200922153612.GF19098@xz-x1>
 <20200922154845.GE11679@redhat.com>
 <20200922160330.GH19098@xz-x1>
 <20200922165354.GG11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922165354.GG11679@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 06:53:55PM +0200, Oleg Nesterov wrote:
> On 09/22, Peter Xu wrote:
> >
> > On Tue, Sep 22, 2020 at 05:48:46PM +0200, Oleg Nesterov wrote:
> > > > However since I didn't change this logic in this patch, it probably means this
> > > > bug is also in the original code before this series...  I'm thinking maybe I
> > > > should prepare a standalone patch to clear the swp_entry_t and cc stable.
> > >
> > > Well, if copy_one_pte(src_pte) hits a swap entry and returns entry.val != 0, then
> > > pte_none(*src_pte) is not possible after restart? This means that copy_one_pte()
> > > will be called at least once.
> >
> > Note that we've released the page table locks, so afaict the old swp entry can
> > be gone under us when we go back to the "do" loop... :)
> 
> But how?
> 
> I am just curious, I don't understand this code enough.

Me neither.

The point is I think we can't assume *src_pte will read the same if we have
released the src_ptl in copy_pte_range(), because imho the src_ptl is the only
thing to protect it.  Or to be more explicit, we need pte_alloc_map_lock() to
read a stable pmd/pte or before update (since src_ptl itself could change too).

Thanks,

-- 
Peter Xu

