Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3962774D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgIXPIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728296AbgIXPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600960113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQoQDFgY9yaaRRiEJU3spleYVLTHQmZvjCiRju5YF+Q=;
        b=IEnrwnaSlnAk+kuVAacWmmWO5mBqwgeed9VR4vWq0uwk0Gm7i9ljvfCIB6MpU8Dz+neHZ/
        yvRMUyWfzxumjoSqbSA1H4YnzQJKjiVAlP0Meh4dUDnO033TnhTmsYJWIKTzw1qeCKnC3j
        rw2s0FmTdF6Ev1vNqp+flzI1rxBaQUY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-4uNmq2zHOfONkY5duQnPkA-1; Thu, 24 Sep 2020 11:08:30 -0400
X-MC-Unique: 4uNmq2zHOfONkY5duQnPkA-1
Received: by mail-qt1-f199.google.com with SMTP id a16so2654328qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MQoQDFgY9yaaRRiEJU3spleYVLTHQmZvjCiRju5YF+Q=;
        b=amWGzmLCvcIU24szuWUnOy4JQSbL457q64SWDTjQ8s/XFfSWoZd2QLztAXk3onq+Z3
         uD/7C986fAWIJpoZcJ5NQNPbYXFjQGssB4+OxDp5LgNgxAsKA8TmjL30yUzCPdwIK+E8
         dWcJRqgzal7+B6aViuoKXg+XkAaIQJWFJiTnmpPLtsR42UjI/ElYC0/Dry1GZV2kyfX6
         rNGsltqm6KqLKx94GmxvsamAlr8Fz/d5jw4ochIb0IGOqjOu8wN9mAWycdN0K17CkB3B
         2v9jI3D/NdRFeVyXc+sEOJ06NlCou/oUQHLUtc0bRRIAjAQIg/rfd9hvnGznbr8t4rsj
         gh8w==
X-Gm-Message-State: AOAM532V0QsKAF3v5sw+9oTVaFk5mRpFbZvbVmzX1yDbWhGipuRP+yNH
        SOf51ElXPBJT2mCjA0ipgxuwph7xMHXaF71rIfO9y2d0/mcxLgE02vl1bNoCVyd5hgCzUQGE5Hd
        GVBWQ+rh9LhPHL/IIWOZ99EAt
X-Received: by 2002:a05:620a:919:: with SMTP id v25mr46595qkv.461.1600960110108;
        Thu, 24 Sep 2020 08:08:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPKyFUERco+7cJyYy2qb6iiaNZvQWTPdRkcsArJJYM6TktrNZefehjko3nxuDJ6Se8rtvUPA==
X-Received: by 2002:a05:620a:919:: with SMTP id v25mr46579qkv.461.1600960109906;
        Thu, 24 Sep 2020 08:08:29 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id w6sm2456247qti.63.2020.09.24.08.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:08:29 -0700 (PDT)
Date:   Thu, 24 Sep 2020 11:08:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
Message-ID: <20200924150827.GE79898@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <20200922114839.GC11679@redhat.com>
 <20200922124013.GD11679@redhat.com>
 <20200922155842.GG19098@xz-x1>
 <20200922165216.GF11679@redhat.com>
 <20200922183438.GL19098@xz-x1>
 <20200922184359.GI11679@redhat.com>
 <20200923010332.GP19098@xz-x1>
 <CAHk-=whBth_SpXYCmYLiZTRadAvncCDAmK_Kw1QNTg-HS23aKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whBth_SpXYCmYLiZTRadAvncCDAmK_Kw1QNTg-HS23aKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 01:25:52PM -0700, Linus Torvalds wrote:
> IOW, the third patch would be something (COMPLETELY UNTESTED) like the attached.

Thanks.  I'll rework on top.

-- 
Peter Xu

