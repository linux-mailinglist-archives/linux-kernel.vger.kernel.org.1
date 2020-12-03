Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C042CDB70
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgLCQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLCQld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:41:33 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02432C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:40:53 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ce23so652958ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScpuytyG6NLRNL7X2oNhk8CvwGk89oKl1c7QnQJXwzk=;
        b=L17/rVF3Xhc3L8P6V8zFE34V4ptIG/bCmTq6E1peP7hWNOhjGZuxW4wUxV8x2gJuLT
         h0pOM8fC67Cs4JphYZRhFK9ERmAvmgFmatc7g/+Gohq6HLEVVtv+IHaFFDcsHgoFIojn
         owcQsVHQY8iL5jrItIXaTb4Yy/GC1NwldRT5Kv4wGlkikkMzBK0/8mKapJ0IF5PGeNRR
         6cSe29FL+MTmIa1TkXKKknhhD/0K1v2g5TdU+uLfkz+lpAVyiv6PairUU8kligNVDx5d
         cizx9piiDlQ/+3+mBzUa45yob/ibHnv3iM2v6ZR5wyZb06kd4T7Rwz2pxmkKXJ8J8GJR
         i71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScpuytyG6NLRNL7X2oNhk8CvwGk89oKl1c7QnQJXwzk=;
        b=B4A+FxwMNK7QN5KYOMADbkM4J/SllKb1VVizLSHANwJ+59vvaycAkciE9SWxqcQ7ZB
         uZ46EtoBmJ4zxJCHT/CKUhbuB13JFolOCi29/sXdLgNIfMcFWUmXPdJvsOvMPR3eYppq
         AEfjeulxSSQYjDdavKASc2TJklL6C7vjfMVcGoDYT2IOqYuoZMqapK2k8BkugSiEGe40
         k2jWYDOKSDCDcDq6JcLn8nGMxRKr75nVnnFsc9gA2KRNfALdO/SdkqTQqG7oWbDIx4gI
         n+v62sGmfgEjosLJMUfa8EoXkOLEMxSizlRf5rVbu1DbdeGZW9Vg/ChT21//t3aP03wG
         FiNg==
X-Gm-Message-State: AOAM531LeW8gcRWX9FwQFHGwMyjuf2SWKRCqS9wXNEaNV9OLcQ3AlRnv
        nZh6l9r3qlO0LYXqmNEe3gpGoyTYG8qKiuOCOR1daw==
X-Google-Smtp-Source: ABdhPJweZzhaLuYS4oXjcPMboasHYjDF1XYNOK4O1QMIV986L6OhBriMHC+AldZq7MM3Xyyhx4DTrsMNDXmJ8P6WRNg=
X-Received: by 2002:a17:906:c04d:: with SMTP id bm13mr3225888ejb.519.1607013651675;
 Thu, 03 Dec 2020 08:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com> <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca> <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca>
In-Reply-To: <20201203141729.GS5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 11:40:15 -0500
Message-ID: <CA+CK2bA=Ahd4E=ebdJ7uwxPyQ1AEy_hxA+Tx+yAi92JcZsQsfA@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Looking at this code some more.. How is it even correct?
>
> 1633                            if (!isolate_lru_page(head)) {
> 1634                                    list_add_tail(&head->lru, &cma_page_list);
>
> Here we are only running under the read side of the mmap sem so multiple
> GUPs can be calling that sequence in parallel. I don't see any
> obvious exclusion that will prevent corruption of head->lru. The first
> GUP thread to do isolate_lru_page() will ClearPageLRU() and the second
> GUP thread will be a NOP for isolate_lru_page().
>
> They will both race list_add_tail and other list ops. That is not OK.

Good question. I studied it, and I do not see how this is OK. Worse,
this race is also exposable as a syscall instead of via driver: two
move_pages() run simultaneously. Perhaps in other places?

move_pages()
  kernel_move_pages()
    mmget()
    do_pages_move()
      add_page_for_migratio()
         mmap_read_lock(mm);
         list_add_tail(&head->lru, pagelist); <- Not protected

>
> > What I meant is the users of the interface do it incrementally not in
> > large chunks. For example:
> >
> > vfio_pin_pages_remote
> >    vaddr_get_pfn
> >         ret = pin_user_pages_remote(mm, vaddr, 1, flags |
> > FOLL_LONGTERM, page, NULL, NULL);
> > 1 -> pin only one pages at a time
>
> I don't know why vfio does this, it is why it so ridiculously slow at
> least.

Agreed.

>
> Jason
