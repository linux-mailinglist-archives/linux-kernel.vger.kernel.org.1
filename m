Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A255F27E9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgI3NbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgI3NbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CB5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:30:59 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 197so1545036lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JfK3MmLNn/xikiHKUDkDYMDDzeu40/mWS8wJhCh6qYc=;
        b=M/saRZPo7pkqFqy6qBsQswXcNt1edm1zwI0b80Y4eCdlbAPOuDjTN9Xq4g66qvpLDm
         RPCAzNaGKRIWDJkpWF5WoSdOir88M7/gJuP/NULBNwjr2mYsuj26ELEWlnbR9G+cfgu9
         oUwq2zsJnsqcG7IsUsXlaLkAaEvUv40x8XUT8g5ayBThP7S1k24zihlRTpTh2Zu7xDbT
         p6wzRKRU2wQpQ6+29Fai0m6iGiwFXLO8UQ4i1a9ECzn8hWNekmb/XEPQdLiT/mZT1Q4l
         WI8xCpvN2yn3p+9WcPaKS2k6SJ/QnrInh4aO5xlEzlWAP6+RwQVLlYuQW+CxVuiRs9yr
         JUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JfK3MmLNn/xikiHKUDkDYMDDzeu40/mWS8wJhCh6qYc=;
        b=bDrZSLerS+04MFhudlMHksEOeLA0nos4NFc4lyJoWcubMRzrAMD1+JF75wyIJqlJM2
         FJSh/Y7C3p3V61yOWYSgYIxfJxyfb8Ef7GDxfl9VA4TiqK6Rln9kwDKf3H0PmWXvqiYQ
         TT6ZUZcrU7nsYHmxP3+SL9V5208q8oJRjc5rvXmner1K3e2C8eWBmscG5ON6kp91eE6P
         /bkFqKrR0fHRuDuYVMF0bYoYboNjBZ5Cv2hRx0qVC+p0z+0vNcRWOuSGu4dMfG7F9ZXs
         1+QTYsAyPX9APbswvGW8C2KgpRwBKaWn7V/tMko4rTfBAV59ZmBpVapr9/qMPmfDoY3Y
         4kMg==
X-Gm-Message-State: AOAM532FBz4dymocDfH5mdH0AjnMLIUlt0xM9XpO1mmEGyOt5mfJYJwd
        8/K6CGxFwz70ejjKaKUtVx7OtA==
X-Google-Smtp-Source: ABdhPJwrXY1wLIXcf7JPwbiSvbd/tSSquCR/9ybr4j/zHR05Jp4GC6jcA/TXr/MFpA24JNrnjlDRHw==
X-Received: by 2002:a19:890b:: with SMTP id l11mr808529lfd.355.1601472657882;
        Wed, 30 Sep 2020 06:30:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t5sm157267ljg.111.2020.09.30.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 06:30:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4F1C4102BAF; Wed, 30 Sep 2020 16:30:55 +0300 (+03)
Date:   Wed, 30 Sep 2020 16:30:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200930133055.sdejarcv7nyhc2yc@box>
References: <20200925222600.6832-1-peterx@redhat.com>
 <20200925222600.6832-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925222600.6832-3-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 06:25:58PM -0400, Peter Xu wrote:
> This prepares for the future work to trigger early cow on pinned pages during
> fork().  No functional change intended.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h |  2 +-
>  kernel/fork.c      |  2 +-
>  mm/memory.c        | 14 +++++++++-----
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b2f370f0b420..ae914be004b3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1646,7 +1646,7 @@ struct mmu_notifier_range;
>  void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>  		unsigned long end, unsigned long floor, unsigned long ceiling);
>  int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
> -			struct vm_area_struct *vma);
> +		    struct vm_area_struct *vma, struct vm_area_struct *new);

It makes dst/src mm_struct arguments redundant. There's always vma->vm_mm.

-- 
 Kirill A. Shutemov
