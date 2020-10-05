Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA268283E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgJESYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJESYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:24:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EDFC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 11:24:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 188so2234126qkk.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCSLqGNh9b5YSmYsk1DlWKJeyULS7OR1a85rgALsc9w=;
        b=MCDa+1cwmN3uqvhljUtqnjRDTYQZ/bi0REuAsgRPHawGFRLu9yuU9WlllBKYKSYWoC
         COppqAsu3MTAife2gP8sPBj5BM2BbGaDJxEwZvtuafwP4a4hdfpwdn/NGDE42M6wmPYx
         w6RKz8PK1yLHK6fqWqsgZhdkxQJNKhX5RC2wxagFLtzU3TwNIOuknrBo7berTriabUSB
         qqTiGv8KasNRDd1sfsDjr2lO2IxW1f9KChgBRQcBUplHmmgGaWF66ZIebhDq1VNBfLXS
         ScC9FSdcE4fiChkQkPfTWWSWJq5i1UZonfVL4S1jsX1F1gH31b2ZbJ02j2EKwtYWInDJ
         gSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCSLqGNh9b5YSmYsk1DlWKJeyULS7OR1a85rgALsc9w=;
        b=UCatfvQjC7Rn4jEzy8key/d3+ViLy3U1koyny+yl89Tr/hjbBMpHb/NIEGURCzvpsu
         bTlkyMFRmnDAcqcO+nRXTYe6a+fatGfGeSyi5lsNTxREuD8d2FssnppIN36xmg0dSgh+
         ugfa1mAzM7sJp1dBarwLbljmi6yywycj5QHFI2L2rRJGLKMmXvB9qGHdeiusNjxu884j
         J1NcZK6NvAYAD+zjajORtbH2pvF1srS77TuM9f9j6H8tT0f4v5R/kXg6nDDAHN59CSXa
         126l1hBHcgFBmwO/a/DMiXxxzdKbtZIPhX9OkVHsYjYfC8/TFcVyQlq+/6oOpQefq8EC
         7h5g==
X-Gm-Message-State: AOAM530IB/rm/69rfSpJFLNz/59+FjuVwgWdOVJJxtJxwp9NqCrTTnP9
        S/e1hI5/FGrXdnH7/OrpQc1uxoUfd2qYez29mIoOQg==
X-Google-Smtp-Source: ABdhPJxukAgIYi20kSI9kjVPF33fEc4rKpb9eQYgj02bTfT4kUplSjOE1HGcZ8LTlpn7FoBl8beo3/6xylx4QC83AAg=
X-Received: by 2002:a05:620a:4d0:: with SMTP id 16mr1333224qks.200.1601922258954;
 Mon, 05 Oct 2020 11:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201001181715.17416-1-rcampbell@nvidia.com>
In-Reply-To: <20201001181715.17416-1-rcampbell@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 5 Oct 2020 11:24:07 -0700
Message-ID: <CAPcyv4gu=So5PgQU9LezhW4vUQt+paaUr1T6CAvQYjh0XzkkgQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/2] mm: remove extra ZONE_DEVICE struct page refcount
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
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 11:17 AM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> This is still an RFC because after looking at the pmem/dax code some
> more, I realized that the ZONE_DEVICE struct pages are being inserted
> into the process' page tables with vmf_insert_mixed() and a zero
> refcount on the ZONE_DEVICE struct page. This is sort of OK because
> insert_pfn() increments the reference count on the pgmap which is what
> prevents memunmap_pages() from freeing the struct pages and it doesn't
> check for a non-zero struct page reference count.
> But, any calls to get_page() will hit the VM_BUG_ON_PAGE() that
> checks for a reference count == 0.
>
> // mmap() an ext4 file that is mounted -o dax.
> ext4_dax_fault()
>   ext4_dax_huge_fault()
>     dax_iomap_fault(&ext4_iomap_ops)
>       dax_iomap_pte_fault()
>         ops->iomap_begin() // ext4_iomap_begin()
>           ext4_map_blocks()
>           ext4_set_iomap()
>         dax_iomap_pfn()
>         dax_insert_entry()
>         vmf_insert_mixed(pfn)
>           __vm_insert_mixed()
>             if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) &&
>                 !pfn_t_devmap(pfn) && pfn_t_valid(pfn))
>               insert_page()
>                 get_page(page) // XXX would trigger VM_BUG_ON_PAGE()
>                 page_add_file_rmap()
>                 set_pte_at()
>             else
>               insert_pfn()
>                 pte_mkdevmap()
>                 set_pte_at()
>
> Should pmem set the page reference count to one before inserting the
> pfn into the page tables (and decrement when removing devmap PTEs)?
> What about MEMORY_DEVICE_GENERIC and MEMORY_DEVICE_PCI_P2PDMA use cases?
> Where should they icrement/decrement the page reference count?
> I don't know enough about how these are used to really know what to
> do at this point. If people want me to continue to work on this series,
> I will need some guidance.

fs/dax could take the reference when inserting, but that would mean
that ext4 and xfs would need to go back to checking for 1 to be page
idle. I think that's ok because the filesystem is actually not
checking for page-idle it's checking for "get_user_pages()" idle.
