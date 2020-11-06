Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9512A9AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgKFRWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:22:11 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE7C0613D3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 09:22:09 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id h12so1266219qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y11rYbDMlG4Jq6y1mMF8XHIQBRgQTi4LgEIfp1+Fy2I=;
        b=Z5hliPe42ZhsJgIpO8yM/A/BmnWabQMZyxH3x1SujgBdxmpQeo1iLC7dJllfTWrgs+
         ckOwCsKncKsZUSkDwm+CRG+PtHOhk6vGyhb3vaWmExO06uZRfYDDy4x0lNtyZAxfIGSF
         TzNe/ATxzOTxeiv/h6NniXGC8bMAeaQsSamd0SJaMbdJqgcKE7FX8hgittLCSxWN+Hk0
         aEVb3jWNuQ84GZTQ7t0z2P0KnBO9475+HL13KJpZeDMWi657ip/5nImwsscD/jRB/6+1
         tzYyPHfeLOmV9kq1MtWUFMAFC/4Mt9DF6Qfy0pjFFXFFgIEb7ZfC/ufepIEP0MSbyLqW
         1mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y11rYbDMlG4Jq6y1mMF8XHIQBRgQTi4LgEIfp1+Fy2I=;
        b=mLxx4G++XEleXNg9ArifMbq/BlTyKwWaOmQWpv83lDPVPOjPLwUbKFASMr8rz3c606
         jJoHb3ZQyyIiJJx4yUyRYFu6cPghHqh59SqYR3BgAyrDbUsYia6d2WXaoe7ya1/7OFkG
         mIHRTxB2EwhZi+KO+Q0V7ST0mEEBlj4WbfXn75JX7ldMK0o8tkAKzKwKzGEuRGqkcqyF
         G0Gsy1fhrUK70/GMIJPMZPTQjHgnz0eKGJ9RrITmrMrmC8QViYOSTM0CvaTsxuoxe87p
         wgCwCsQB9MwCDeRNl8xpYof5w06I8A4EghLal7twBSoBDNPkNoF8w1bBdM46xrQSeDtN
         espw==
X-Gm-Message-State: AOAM5303iobNczmVnJxqyBa1rPIkzhq1gnVJnuBpzQ2xi1YasxIwHBtA
        Xi9p/JHYWfuG4uY5t7nxY3kvlg==
X-Google-Smtp-Source: ABdhPJyiYapImJ+Y336x/nMMBsQzuXDQ9V5MrPZLPGSARv/D7dBPhFBvVcl8QNPKfF7/i3znPagsCA==
X-Received: by 2002:ac8:4d4d:: with SMTP id x13mr2465811qtv.72.1604683328177;
        Fri, 06 Nov 2020 09:22:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w45sm942700qtw.96.2020.11.06.09.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:22:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb5R8-000z7J-TY; Fri, 06 Nov 2020 13:22:06 -0400
Date:   Fri, 6 Nov 2020 13:22:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106172206.GS36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-15-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
> a hunk of p2pmem into userspace.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h |   6 +++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9961e779f430..8eab53ac59ae 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -16,6 +16,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/memremap.h>
>  #include <linux/percpu-refcount.h>
> +#include <linux/pfn_t.h>
>  #include <linux/random.h>
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> +
> +struct pci_p2pdma_map {
> +	struct kref ref;
> +	struct pci_dev *pdev;
> +	void *kaddr;
> +	size_t len;
> +};

Why have this at all? Nothing uses it and no vm_operations ops are
implemented?

This is very inflexable, it would be better if this is designed like
io_remap_pfn where it just preps and fills the VMA, doesn't take
ownership of the entire VMA

Jason
