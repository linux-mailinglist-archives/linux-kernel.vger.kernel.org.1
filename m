Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29A277815
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgIXRzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbgIXRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600970136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ClAO9/rtMU5sQd9Xp4+E5kyKR/mhYS+71Ql/VjPPsQ=;
        b=exWMxIXWzlNwehesb/+KsnHws+f1duOjKByy31E2m48EEJw6Rf/45kvYGdJTIHl/6rQxlX
        44gZJDBUdzVVt9bJ4/KfR6QlO/lWmmtj51eQQtCmqtCkKmIRvhvO+ytxZ0ef0VWBHXgO7W
        QMNZZtDONjLhdub3ftibE7fCz5gOiS4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-r3SJMCa9PEGQJhsH59hgPg-1; Thu, 24 Sep 2020 13:55:35 -0400
X-MC-Unique: r3SJMCa9PEGQJhsH59hgPg-1
Received: by mail-qk1-f198.google.com with SMTP id u23so176930qku.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 10:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ClAO9/rtMU5sQd9Xp4+E5kyKR/mhYS+71Ql/VjPPsQ=;
        b=LS3zrJNWlXlS2fbzwqyxqOBT8sUjKoAWAKJCdEDdXqf9i11hYiHh0LWw9g7u2ZZX+W
         2oePbxkBIjRdJ+uO6l6ZICeUto0sw6pQRLjfxBDvCNRtPpaF8H8F3bEv4dwL7sLHy9EN
         TlmviHjRRShOnbIRoiKxhH8j3lCDGdezzSUYoSC5ODxJ8h1H/3GfJMcWkCtbYEw54rIV
         MTeOQ4cHaMRnfeXnAbQeF1qM/EGsBuxxB9DaM+UHpLg/wgFbC2Qp7FW6w1bkfLU8tjOa
         wIbc9lu56qRohyxQQybz0z4/q88ERsvDV/xY7KMF/uZq+Lm4sFxnQzEuZWVNyW1JQh0l
         TTOQ==
X-Gm-Message-State: AOAM531cYrtgVbwTC8UNd2CRaOmttS9h5UE9P6JUPIAxw79TG9dSVL1F
        w0cy8viZPHKDJvDhMjbtqVS9lzRAIAP5IjacTDfVS/WivhoobAWwL1dwcLXTQybzGKOqBd/YOJN
        3JePANtLo5A7cCuZvl/Ar7zx+
X-Received: by 2002:a37:cd5:: with SMTP id 204mr230118qkm.303.1600970134549;
        Thu, 24 Sep 2020 10:55:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSX4aE/PDsFbydVy5j0qbhmvcf/zPbMUXgOKfhUZVfLgyDoQnDeX5yi7cXkFzkVEYCYycIoA==
X-Received: by 2002:a37:cd5:: with SMTP id 204mr230076qkm.303.1600970134154;
        Thu, 24 Sep 2020 10:55:34 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id v16sm118868qkg.37.2020.09.24.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 10:55:33 -0700 (PDT)
Date:   Thu, 24 Sep 2020 13:55:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20200924175531.GH79898@xz-x1>
References: <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924165152.GE9916@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:51:52PM -0300, Jason Gunthorpe wrote:
> > Regarding the solution here, I think we can also cover read-only fast-gup too
> > in the future - IIUC what we need to do is to make it pte_protnone() instead of
> > pte_wrprotect(), then in the fault handler we should identify this special
> > pte_protnone() against numa balancing (change_prot_numa()).  I think it should
> > work fine too, iiuc, because I don't think we should migrate a page at all if
> > it's pinned for any reason...

[1]

> 
> With your COW breaking patch the read only fast-gup should break the
> COW because of the write protect, just like for the write side. Not
> seeing why we need to do something more?

Consider this sequence of a parent process managed to fork() a child:

       buf = malloc();
       // RDONLY gup
       pin_user_pages(buf, !WRITE);
       // pte of buf duplicated on both sides
       fork();
       mprotect(buf, WRITE);
       *buf = 1;
       // buf page replaced as cow triggered

Currently when fork() we'll happily share a pinned read-only page with the
child by copying the pte directly.  However it also means that starting from
this point, the child started to share this pinned page with the parent.  Then
if we can somehow trigger a "page unshare"/"cow", problem could occur.

In this case I'm using cow (by another mprotect() to trigger).  However I'm not
sure whether this is the only way to replace the pinned page for the parent.

As a summary: imho the important thing is we should not allow any kind of
sharing of any dma page, even it's pinned for read.

If my above understanding is correct - Above [1] may provide a solution for us
(in the future) when we want to block read-only fast-gup too in this patch just
like how we do that using wrprotect().

-- 
Peter Xu

