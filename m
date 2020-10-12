Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CF728C3DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbgJLVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgJLVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:14:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3AC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:14:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u8so25239822ejg.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+E/x/oIv2ijFm2c9w4wv62KEKilXSc7t2Sb9ekDFptw=;
        b=Edzs632po8qKWgO3YwL1+/WtB+jp3E2Vu3gnBGR3UWRBL5wqJFRo1ZiouYvd1j7hdU
         Ixp12qDDQ78vGjE3OV/Lj7aXRatwmUPIiEL72PLClFVepJZovvzodPZGKEyxKZ9N3xzC
         /wGWB0EZXZiyIIdnohsdUSrkF2j3ljeNYyfJpgOxpuRecdCzWN9MlXi1HxwYn3AG3Y+j
         Ez7G84Q3qjBphLh3URy4AEUUlcVBgQlK2HwfEj6iwS7/1bTQlNl3JMbkVP+uoaeiZmrz
         LYmcl5Q9ho6uVvcilbmyEJCZ07yD0pc3UEOxk5BWy9nUQ1CumAEd4X0Eyuz1wzQmRqHk
         qAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+E/x/oIv2ijFm2c9w4wv62KEKilXSc7t2Sb9ekDFptw=;
        b=GF7AbqvXNpRZ/k0HMkVLtJ9vqB2uRrPdQWA+dFz4ZKtoQLFhuVQP+qJeQ6+xEW2W5E
         nyRqQjITdW1Mf6uoftxFr8zTZJb5tlrJz2GB+9ZJiPEjulO4ePBGaz5KwpbWi799/cnb
         0tfhvyIXjpgyMR4xHMNDSAN09IMN9YoQP4fI3Zlli8i7kXwwIFVKx8sUX8wJgs4Vn0zl
         tFhoBJQHcz6k7YVG3Q8OeuRs1j8mO6reKjZMaYko2oak1vt6rSFtW/l8RgEYPGrb7+Vq
         tbQpRA38YFSetfj1UWemDbQCQuZAOnqBxn2DurklqqM9gTcnE6/I9peNbj/5vM0AsfXc
         48OQ==
X-Gm-Message-State: AOAM533pgh1KIAHtQEa/AZQu2azv0OOUrgYDpsSyGBIO+MhyzqNwA+I5
        4gi0/z9v0xhRxeXbNWoFSqrLpa8uf9yPSVFTqE5JnVjKkp+1hA==
X-Google-Smtp-Source: ABdhPJz02OtB37X1Kl6Yw4VB2J5fzc4t6W8lA+4qFWxSxgpuA/gexEv+m5h1tqboEVvNq9alpAfTRLuAH8zdbpyQqLs=
X-Received: by 2002:a17:906:b88f:: with SMTP id hb15mr29759160ejb.45.1602537258704;
 Mon, 12 Oct 2020 14:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201012174540.17328-1-rcampbell@nvidia.com>
In-Reply-To: <20201012174540.17328-1-rcampbell@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 12 Oct 2020 14:14:07 -0700
Message-ID: <CAPcyv4ijD+=3rje1CfSG4XKuRNfuAWOui93NQV09NmBte_gc0w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hmm: make device private reference counts zero based
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>, kvm-ppc@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:46 AM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> ZONE_DEVICE struct pages have an extra reference count that complicates the
> code for put_page() and several places in the kernel that need to check the
> reference count to see that a page is not being used (gup, compaction,
> migration, etc.). Clean up the code so the reference count doesn't need to
> be treated specially for device private pages, leaving DAX as still being
> a special case.

Please no half-step to removing the special casing...

[..]
> +void free_zone_device_page(struct page *page)
> +{
> +       if (!is_device_private_page(page))
>                 return;

That seems too subtle to be acceptable to me. All ZONE_DEVICE pages
need to have the same relationship with respect to idle-ness and the
page reference count.
