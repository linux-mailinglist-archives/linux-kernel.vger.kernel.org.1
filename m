Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DADD2FAA66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394100AbhARTlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437636AbhARTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:40:56 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0578C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:40:15 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id n142so19784449qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m0HuzB+USgUnbgOX7HG0Sx20ihZJUFQB5a8QjnGYmeo=;
        b=A+hqRW9O5yvkiX1OyU7UPWhIpta3IllcQ2sXxl2fVCFmkMSizioqELhPp3e2QoM8f7
         igMw3Y6He8BvwWUdsVy3CxQdQojMpuHcG4WfivJ4tSXJranc1V7oTQIrLYjDXgMRS9rZ
         eIvTPEUqyxUBEVfO59ojHS/5uCPArVxP/FQr7OUq/yC4yYtu1SDfRPsj5T6lofbCPCXq
         qduo+tHn38eMxkGjHzU5srg9cOC/U10mM3Fii/Taczf+JD9p/uUF2NaBKt/x3jce2WeS
         u0yHgBwQT0bMeiNBcdl3buKIjV760UbTRMqor3+98AT65Q7cxyepGuxL50LFar+zxYQc
         TTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0HuzB+USgUnbgOX7HG0Sx20ihZJUFQB5a8QjnGYmeo=;
        b=nSK1NpbJaUKNm0VAiPWAu08ShvOO3vgi4nUJRFbjVzIwrQs/2YErCgKFrz/7eDq8cH
         ewy1oa8Sg5AkqcVp9vek1Bo/0XqS4zBQXXc76R683PCRyv7PS1ZqnA795nQ0w5pQQhok
         z6jEtsmlEXZ3PFjT1/7fq7Z539O6t5HQi+vERgn9Y3WR4NWFk0+nb2t9ao/lavO2G3U2
         ymvU6Va2d0Fg4BJ0Sz7G6+A4ogUprYvYDg5DeDFZuosYc9BofVZZYOBnPGQqWFtxUypE
         dlq1LQps8k5lKlCykmFFf78KkFVlrrVZ/9Va6O8pojwg52PhLXjITA0CrRTlboBslaAe
         +lig==
X-Gm-Message-State: AOAM53213M5b0LuptGD903dtWOhpJYhtyp3u3qFCKd17KzOTaDwfEVdE
        aOLL9K+87TyOJCVNaaHCv+WMfg==
X-Google-Smtp-Source: ABdhPJzBAWArmZw0A7cIsAoeqD8Frz7SjorZ9wI33QSkMgZ7Y0Jmmhu+pSwL5XOpa+cqadMWu5cNrg==
X-Received: by 2002:a05:620a:12e5:: with SMTP id f5mr1087103qkl.331.1610998815056;
        Mon, 18 Jan 2021 11:40:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id e38sm10788881qtb.30.2021.01.18.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:40:14 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1aNp-00335L-Os; Mon, 18 Jan 2021 15:40:13 -0400
Date:   Mon, 18 Jan 2021 15:40:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 07/30] mm/swap: Introduce the idea of special swap
 ptes
Message-ID: <20210118194013.GM4605@ziepe.ca>
References: <20210115170907.24498-1-peterx@redhat.com>
 <20210115170907.24498-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115170907.24498-8-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:08:44PM -0500, Peter Xu wrote:
> We used to have special swap entries, like migration entries, hw-poison
> entries, device private entries, etc.
> 
> Those "special swap entries" reside in the range that they need to be at least
> swap entries first, and their types are decided by swp_type(entry).
> 
> This patch introduces another idea called "special swap ptes".
> 
> It's very easy to get confused against "special swap entries", but a speical
> swap pte should never contain a swap entry at all.  It means, it's illegal to
> call pte_to_swp_entry() upon a special swap pte.
> 
> Make the uffd-wp special pte to be the first special swap pte.
> 
> Before this patch, is_swap_pte()==true means one of the below:
> 
>    (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
>          example, when an anonymous page got swapped out.
> 
>    (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
>          example, a migration entry, a hw-poison entry, etc.
> 
> After this patch, is_swap_pte()==true means one of the below, where case (b) is
> added:
> 
>  (a) The pte contains a swap entry.
> 
>    (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
>          example, when an anonymous page got swapped out.
> 
>    (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
>          example, a migration entry, a hw-poison entry, etc.
> 
>  (b) The pte does not contain a swap entry at all (so it cannot be passed
>      into pte_to_swp_entry()).  For example, uffd-wp special swap pte.

Does the stuff in hmm.c need updating too?

        if (!pte_present(pte)) {
                swp_entry_t entry = pte_to_swp_entry(pte);

Jason
