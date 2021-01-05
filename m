Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B9C2EADEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhAEPJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbhAEPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609859299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Il8hr7wLf2mLphtD87oDHygkD/T/28vf7dmL69XSemI=;
        b=XN+CCBt5dWScQbG+sV1Ht4mAcaPpkzMrYK0KKLlNpN7r5lBkAA2N8aM15ek1VriEDvWvGV
        Z1uvH+Vnce3sQUaBZlJPzMYbUli/ybxhWr/2nwGKRwdwSfPOSso1fPz4cOOx1y8WalavOG
        wxhYC0pmJsU+hC3GGDPZqfg6O7aBkq4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-ck8EXQYrNLWkcXNNrwUZ4A-1; Tue, 05 Jan 2021 10:08:17 -0500
X-MC-Unique: ck8EXQYrNLWkcXNNrwUZ4A-1
Received: by mail-qk1-f199.google.com with SMTP id l138so49691qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 07:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Il8hr7wLf2mLphtD87oDHygkD/T/28vf7dmL69XSemI=;
        b=Gj7UggZwrdBVzZa02YHiF/cqT2H5j2BexxIgPC5w9WROz0XdD63TCROdD74isShnYp
         w8+5XGmFKztQtQkLlp2dDRDpqAsiPc1ruOKMco9HUTySF+fCzRjiWY7JLIKyRzNs2bMJ
         U4OKaK0NS6eLqeH4c6ijfWhHoHVDr+trICELsFvtUJ4WV2efhDMo1cMZcht+mbos1RxY
         YCm0sXJpTlZ2nh+Iv7SQ5yXWOTyJy4V5/c99xCllEfQgYabIGipcucTPB/Xo7fAAjOeB
         mLTSjl1lJgZu/p1V11LLHtdNimAEszbLTQWYjovE6uCvhYsLfHy7Ev+cGExo6OT+YTNt
         xFAQ==
X-Gm-Message-State: AOAM530mSpygx3ShtCncRYzu9SaeZ+Y7SeIBjRdN14DZU/caCNuJcPfs
        DdJ4AzxJedkRx7JYmE2ThpH9Kk46UVdn/KsTGX32MSW/1kth5AEUCu2Hx7XEDVO5T2lucbxTcsT
        js8jCTC9980FmQuMDNMhqmewO
X-Received: by 2002:ac8:7601:: with SMTP id t1mr76309076qtq.323.1609859296852;
        Tue, 05 Jan 2021 07:08:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzp+lVmcL8qYOjocLDZQq1MhjmhAcKocjxHH9hVgaT+EXCdRx0D2tTRuz1UkwXAYCBXzPnZA==
X-Received: by 2002:ac8:7601:: with SMTP id t1mr76309049qtq.323.1609859296649;
        Tue, 05 Jan 2021 07:08:16 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id c20sm7537qtj.29.2021.01.05.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 07:08:15 -0800 (PST)
Date:   Tue, 5 Jan 2021 10:08:13 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <20210105150813.GB149908@xz-x1>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201225092529.3228466-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ab709023e9aa..c08c4055b051 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -75,7 +75,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  		oldpte = *pte;
>  		if (pte_present(oldpte)) {
>  			pte_t ptent;
> -			bool preserve_write = prot_numa && pte_write(oldpte);
> +			bool preserve_write = (prot_numa || uffd_wp_resolve) &&
> +					      pte_write(oldpte);

Irrelevant of the other tlb issue, this is a standalone one and I commented in
v1 about simply ignore the change if necessary; unluckily that seems to be
ignored..  so I'll try again - would below be slightly better?

    if (uffd_wp_resolve && !pte_uffd_wp(oldpte))
        continue;

Firstly, current patch is confusing at least to me, because "uffd_wp_resolve"
means "unprotect the pte", whose write bit should mostly be cleared already
when uffd_wp_resolve is applicable.  Then "preserve_write" for that pte looks
odd already.

Meanwhile, if that really happens (when pte write bit set, but during a
uffd_wp_resolve request) imho there is really nothing we can do, so we should
simply avoid touching that at all, and also avoid ptep_modify_prot_start,
pte_modify, ptep_modify_prot_commit, calls etc., which takes extra cost.

Thanks,

-- 
Peter Xu

