Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3A2701FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIRQTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIRQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:19:04 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE84C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:19:04 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ef16so3185735qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zLNXVfhOqZbesiD1VsxL7HMR7LECZzIdNlUnQrHx58w=;
        b=E5NYlgMk2XaRvJel5WV78nbc+qpxMZkMSFF/S0Cpgikv5X7U6+icjtnZqtDJn5FzF5
         GF+TVgBFJ0AKl1ZkIshqAh/NClvK2pYkR7R6SMb7e8jDq2BgZBvzjaxramLaa6JHHIBy
         HwjbhRcdbZ0HFnVVdgHHG9Sd4cfW24TboGQyxKDmqGWKea+pHuYITS+xE5UHsfO5+wQG
         6SZcrfFwhhdjYcDZe851Sq0PmTRgjDhecXmW0Uyu8sX1BwCQQ7LOa0PwhV//tI+hIJTL
         AxKLhAHa5T40vqKZMKX4aT3MmJ3c1PlNnCcbZiojYtp7VXiq6EaTd/qrUfaQiTwsVRPz
         rkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLNXVfhOqZbesiD1VsxL7HMR7LECZzIdNlUnQrHx58w=;
        b=G6K+DsKGTBxLS2RiwgFMRHLyBmjsTEjONTiwZoUXCx+desiGvCM6D7zXssvOrQiJit
         98GhghIMUzT5KgcE/wI2VybRCZOm6e4c5+VIieYE4WKAIKgPDY3DGKocymfUlQfDWF8V
         wlbVxPPFpFsJJVFLR4nOZa9HSo24/bou5QMCx7xph0ovAewOPV2ndrlfzEx6WGcDHzyD
         WBOoMksjRUt6CTAOKC6q0NeJ8CM7B9wV0vYhiMDQk+D9NZWdOlqOyWcTYWQ1+kqxe/1D
         D7Ou826Utx2vc+Jn77GLxPcOSj8g1UrIiwMYvQBhaXBgq0jI9vgRLDXio3oqQ2zCira8
         iNAQ==
X-Gm-Message-State: AOAM531wdpUp50ZfabMpQq78dCb3fFr+I5VvvWTLbWSOi5jEAUVCO2Wc
        ymPLP1Md6zwpOD9MzMThO4JEng==
X-Google-Smtp-Source: ABdhPJxm39cKb8UHhsfKq9rTAjpTGqv/xgJ/R2qqt+5AV1kR1H5gUedgYjizF6h1ATAVVw+/Etd/jg==
X-Received: by 2002:a05:6214:1852:: with SMTP id d18mr18285935qvy.32.1600445943381;
        Fri, 18 Sep 2020 09:19:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w6sm2516554qti.63.2020.09.18.09.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:19:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJJ6E-001MXD-2I; Fri, 18 Sep 2020 13:19:02 -0300
Date:   Fri, 18 Sep 2020 13:19:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200918161902.GX8409@ziepe.ca>
References: <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917190332.GB133226@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:03:32PM -0400, Peter Xu wrote:

> Another side effect I can think of is that we'll bring some uncertainty to
> fork() starting from when page_maybe_dma_pinned() is used, since it's sometimes
> bogus (hpage_pincount_available()==false) so some COWs might be triggered
> during fork() even when not necessary if we've got some normal pages with too
> many refcounts (over GUP_PIN_COUNTING_BIAS).  But assuming that's not a big
> deal since it should be extremely rare, or is it?..

Looking at this a bit more.. A complete implementation will have to
touch all four places doing write protect during fork:

copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
		unsigned long addr, int *rss)
{
[..]
	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
		ptep_set_wrprotect(src_mm, addr, src_pte);
		pte = pte_wrprotect(pte);

int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
		  struct vm_area_struct *vma)
{
[..]
	pmdp_set_wrprotect(src_mm, addr, src_pmd);
	pmd = pmd_mkold(pmd_wrprotect(pmd));

int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
		  struct vm_area_struct *vma)
{
[..]
	pudp_set_wrprotect(src_mm, addr, src_pud);
	pud = pud_mkold(pud_wrprotect(pud));

int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
                            struct vm_area_struct *vma)
{
[..]
                        if (cow) {
                                huge_ptep_set_wrprotect(src, addr, src_pte);

As a regression I'm pretty sure we will hit only the PTE and PMD
cases.

Most likely the other two could be done outside the rc cycle

Jason
