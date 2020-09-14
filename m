Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F149268D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgINO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:29:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27821 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726691AbgINO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600093656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vbjdsDyKQAMF1IWmc/SZZDWufYvYJBspJjcAsQFTx5Q=;
        b=BtXCbegd6IwT5htQft0w8ybQ7+3W0EPlcuzWUk12kVUGH91Tzq2sf9gb7tQJ7mM/HoLzL6
        nOpJji58SIqlpGVDrFa9QllobeSz4KtLCjIsxnZOAqtw0zZhUjPrppErTdooJ3DFmWot7a
        jBbMd5om6fI9ZojzoSXtfcX2rRvr8H0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-5t0SsAqaPrOI2e9_LMXynA-1; Mon, 14 Sep 2020 10:27:34 -0400
X-MC-Unique: 5t0SsAqaPrOI2e9_LMXynA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F180518B9F40;
        Mon, 14 Sep 2020 14:27:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.129])
        by smtp.corp.redhat.com (Postfix) with SMTP id 267A860C0F;
        Mon, 14 Sep 2020 14:27:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Sep 2020 16:27:31 +0200 (CEST)
Date:   Mon, 14 Sep 2020 16:27:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] mm/gup: Remove enfornced COW mechanism
Message-ID: <20200914142722.GA21906@redhat.com>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821234958.7896-4-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21, Peter Xu wrote:
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -381,22 +381,13 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>  }
>  
>  /*
> - * FOLL_FORCE or a forced COW break can write even to unwritable pte's,
> - * but only after we've gone through a COW cycle and they are dirty.
> + * FOLL_FORCE can write to even unwritable pte's, but only
> + * after we've gone through a COW cycle and they are dirty.
>   */
>  static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
>  {
> -	return pte_write(pte) || ((flags & FOLL_COW) && pte_dirty(pte));
> -}
> -
> -/*
> - * A (separate) COW fault might break the page the other way and
> - * get_user_pages() would return the page from what is now the wrong
> - * VM. So we need to force a COW break at GUP time even for reads.
> - */
> -static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned int flags)
> -{
> -	return is_cow_mapping(vma->vm_flags) && (flags & (FOLL_GET | FOLL_PIN));
> +	return pte_write(pte) ||
> +		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));

Do we really need to add the FOLL_FORCE check back?

Afaics, FOLL_COW is only possible if FOLL_FORCE was set.

Oleg.

