Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146F027416E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgIVLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgIVLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600775333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQ6xAU5ZnYayBNRYBEJtPnFAgdA/Gx4Gks29IeOF6vc=;
        b=hQHYz1cuNxGSo0pv0u1abUwaW69z1LUbfOSudju20/Q3d5I87ZQEB56ZUZEeVUlO0iWsib
        JFyJ+WcQ/1tI8ATnUxrBFdEwVeYYthWu532Oguk7qYJcSUHqfyCaZswsmhuPMyyCfnuqVu
        Nhhj0gfgWsvMKEwUkJgR3oV6ZiiXHp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-IQMQgRZPNNOtLsI3btQlVg-1; Tue, 22 Sep 2020 07:48:51 -0400
X-MC-Unique: IQMQgRZPNNOtLsI3btQlVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 317ED57001;
        Tue, 22 Sep 2020 11:48:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4FBB57366B;
        Tue, 22 Sep 2020 11:48:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Sep 2020 13:48:47 +0200 (CEST)
Date:   Tue, 22 Sep 2020 13:48:40 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200922114839.GC11679@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921212028.25184-1-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21, Peter Xu wrote:
>
> @@ -859,6 +989,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
>  				break;
>  		}
> +
> +		if (unlikely(data.cow_new_page)) {
> +			/*
> +			 * If cow_new_page set, we must be at the 2nd round of
> +			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
> +			 * page now.  Note that in all cases page_break_cow()
> +			 * will properly release the objects in copy_mm_data.
> +			 */
> +			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
> +			if (pte_install_copied_page(dst_mm, new, src_pte,
> +						    dst_pte, addr, rss,
> +						    &data)) {
> +				/* We installed the pte successfully; move on */
> +				progress++;
> +				continue;

I'm afraid I misread this patch too ;)

But it seems to me in this case the main loop can really "leak"
COPY_MM_BREAK_COW. Suppose the the next 31 pte's are pte_none() and
need_resched() is true.

No?

Oleg.

