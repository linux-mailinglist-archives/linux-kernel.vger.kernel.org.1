Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF2273F76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIVKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgIVKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600769908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yig2CHMy1DCWUocmah5PYJd5rjJ2nX0sDMIw4Q0i9ks=;
        b=XhFZZoOdknpLtqciEytVFvsDEI/jEOzmLt1wkhKo5Ujl3kTuNJ+CnjiwcwYDPj9HzOD8aZ
        AlR869KBRn1JdoeyC0ucGem9gmjul8HV3bPNMG7yA1u3niqOwxsGniSftVQ5UizbGUkGSw
        79I8O50WrzyfcT9kd2wuojPjrtU8EXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-H8zRloPhPZurR0Hfnt0nmg-1; Tue, 22 Sep 2020 06:18:26 -0400
X-MC-Unique: H8zRloPhPZurR0Hfnt0nmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 588C0801AE1;
        Tue, 22 Sep 2020 10:18:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5F05B9CBA;
        Tue, 22 Sep 2020 10:18:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Sep 2020 12:18:24 +0200 (CEST)
Date:   Tue, 22 Sep 2020 12:18:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200922101815.GB11679@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
 <20200922100840.GA11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922100840.GA11679@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22, Oleg Nesterov wrote:
>
> On 09/21, Peter Xu wrote:
> >
> > @@ -866,13 +877,18 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  	pte_unmap_unlock(orig_dst_pte, dst_ptl);
> >  	cond_resched();
> >
> > -	if (entry.val) {
> > -		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
> > +	switch (copy_ret) {
> > +	case COPY_MM_SWAP_CONT:
> > +		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
> >  			return -ENOMEM;
> > -		progress = 0;
> > +		break;
>
> Note that you didn't clear copy_ret, it is still COPY_MM_SWAP_CONT,
>
> > +	default:
> > +		break;
> >  	}
> > +
> >  	if (addr != end)
> >  		goto again;
>
> After that the main loop can stop again because of need_resched(), and
> in this case add_swap_count_continuation(data.entry) will be called again?

No, this is not possible, copy_one_pte() should be called at least once,
progress = 0 before restart. Sorry for noise.

Oleg.

