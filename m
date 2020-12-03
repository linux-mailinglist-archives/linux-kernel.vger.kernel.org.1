Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B762CCAF8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgLCAVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgLCAVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:21:02 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B5AC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 16:20:22 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so797791ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 16:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiPBgP7DdxfOqaNnqn2QjWLvUmd4cmKVYw9/18ZZkzw=;
        b=RrGgKoNjA9sakFld2DgYNQqlCq10c1anK/oZaeSFZHCQgdqJE1+v+6z5TtBiV1vOg+
         chucFbEnWN2goQbdcJOcyT1XgDUkl8QvgswTkUXm4s3SNj4fKllQK9B7YURcoAPWPrkQ
         GvqIHePJhao+vF3Ad9hDhi796vaAkbno+9ONPOiLvNuPFBe9+P1vs8M502bVQKtsgDXY
         QyyHCqFMC1frtLa9YwqJGYIQHIz961+vVZjDxgFXg4521jnUyxCLFWsM38FyeH4QN/PZ
         j00AXtG0qtty25F2EaIHJvuOrnHLipnKd/Zx+loxQpS+sZrNFOi357o7aURkzodhvHTn
         4hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiPBgP7DdxfOqaNnqn2QjWLvUmd4cmKVYw9/18ZZkzw=;
        b=ONZ/P1x0JvMN+WPvme+0P8bW3wUtKl4pMKKjVNCTZ+bh/L6GI13GgECh2w0E2ajbd6
         XOtsy2mBWKHTR8izhMgzjFwdiDEciPEhUtjXKDXinx/5hkFfHC4VCQd3BYJrTkwOkk5x
         kgUJTmMxWxcJdfnNujeNhM69ymj/EsdpERqUZo/bMGEWfjmUn8jGcxAxaUOQq/tANYrJ
         u+j2H7u7peYYHdHUESXcxtNIbjJ5qQ50chEmFKcJkoOvvpl5yGD2ha4qbqDKeP7Qm4CV
         ERB1j6gF8FaCgPpjlxt63A59kFIt6QpF3jdN8NF8XkcTucCOsmle7R5MWSsVKBsW9RKG
         Rxug==
X-Gm-Message-State: AOAM530WCVDC4AMeGQcbSwr1zYBJTHMe3qxJbGuxgsTnuv/lgS8qlOSo
        uQQHnuXAJ4N9ak+fUYGUUWRvc17ESoO4lVBLBlzccg==
X-Google-Smtp-Source: ABdhPJwwdl7YLLCIGODiaqCSmqirYVISBEcm2GnTZz/wtia75XuprrcOofv26LOz83Y1rcxAFG6YRXhTgH+cMYpSMWc=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr272114ejh.383.1606954821170;
 Wed, 02 Dec 2020 16:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com> <20201202163507.GL5487@ziepe.ca>
In-Reply-To: <20201202163507.GL5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Dec 2020 19:19:45 -0500
Message-ID: <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
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

> It is a good moment to say, I really dislike how this was implemented
> in the first place.
>
> Scanning the output of gup just to do the is_migrate_movable() test is
> kind of nonsense and slow. It would be better/faster to handle this
> directly while gup is scanning the page tables and adding pages to the
> list.

Hi Jason,

I assume you mean to migrate pages as soon as they are followed and
skip those that are faulted, as we already know that faulted pages are
allocated from nomovable zone.

The place would be:

__get_user_pages()
      while(more pages)
          get_gate_page()
          follow_hugetlb_page()
          follow_page_mask()

          if (!page)
               faultin_page()

          if (page && !faulted && (gup_flags & FOLL_LONGTERM) )
                check_and_migrate this page

I looked at that function, and I do not think the code will be cleaner
there, as that function already has a complicated loop.  The only
drawback with the current approach that I see is that
check_and_migrate_movable_pages() has to check once the faulted pages.
This is while not optimal is not horrible. The FOLL_LONGTERM should
not happen too frequently, so having one extra nr_pages loop should
not hurt the performance. Also, I checked and most of the users of
FOLL_LONGTERM pin only one page at a time. Which means the extra loop
is only to check a single page.

We could discuss improving this code farther. For example, I still
think it would be a good idea to pass an appropriate gfp_mask via
fault_flags from gup_flags instead of using
PF_MEMALLOC_NOMOVABLE (previously PF_MEMALLOC_NOCMA) per context flag.
However, those changes can come after this series. The current series
fixes a bug where hot-remove is not working with making minimal amount
of changes, so it is easy to backport it to stable kernels.

Thank you,
Pasha



>
> Now that this becoming more general, can you take a moment to see if a
> better implementation could be possible?
>
> Also, something takes care of the gup fast path too?
>
> Jason
