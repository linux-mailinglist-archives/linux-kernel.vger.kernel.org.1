Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC662AA1B2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 01:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgKGAO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 19:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgKGAO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:14:59 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8CC0613D3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 16:14:59 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so2078929qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xP+5n8avN9R0PMRHtfY/hU7jf10h4hT8Klf4TvQEgQ=;
        b=aokkElWMyWDPsBa6alzqFjXX6Ty/GtCdSx9WukymLV2/BbaYYEQkA6h6NtXkVdapG2
         f4KRlQs9Y+5DAc9+pE/HHKpJIyuCn91sXpwCSZ+08lhM8dAiFiLN7V2xrbpk6hfNSKic
         ieoBgAnzjzjw2iZmefkEtA4fme7kItwUr5LmWc4Urv+NDQjlRSC80EXdjXFB3UnTz0qc
         xUHsKwFfqKXXKxkjKflCvn5HeQw2iywmUCXpbij/QRJ/D8iwlPNvI/Ibqockn0S2v+qQ
         EoTvzw1G3AJLPsWVsVolt0ALyaAOomLE+whBhiXSdjlB8hbwuoItdTWe41htAX37ZvKD
         VHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xP+5n8avN9R0PMRHtfY/hU7jf10h4hT8Klf4TvQEgQ=;
        b=lZQfm9lIS6Az607AWKcOucfBi7pBsLSeJae8hc7ooVJtic1F1gDcvv6M/y3ELeIn0L
         8yxuAEiRtDvNZ9wybwHhY5QUpCdweYR7nzwkMWa7po2W105tZt1w/Av5etupjTzTYz0f
         pE2bFserKA7/ApYRfnx4/2HamUgrhmCIrfkWIOixBUx8OGu5eb+6ZRb/JgJ4XCjerWDs
         83pASMPD2nTMaFqHwIY8ispdOoAT1kg4VS/riW79j/jXImWD75Bzcqbl1JJCWUzjuUxD
         EDD/mSNbOuQuxRKt/fiGBr9xkc8AydSo001pa5YLvG4c2oDbI08PO/FdYtyb6QoBtrd/
         cP/w==
X-Gm-Message-State: AOAM531/YLlzPj2OV8e8a4zs9ws21fRFNMG501H9SrvdByoFfkpWBBcJ
        iL0rL78+jQqzqULY2rL/2x/abg==
X-Google-Smtp-Source: ABdhPJxMxLKgSiQ4x1Of97Fg4BcrbjDaTMOumnt9gw+omdxttGmxoTEsM80CNgLqS0LcZZvrtkPZNw==
X-Received: by 2002:aed:2c02:: with SMTP id f2mr4176029qtd.48.1604708098335;
        Fri, 06 Nov 2020 16:14:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u5sm1592838qtg.57.2020.11.06.16.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:14:57 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kbBsf-0015Rr-2V; Fri, 06 Nov 2020 20:14:57 -0400
Date:   Fri, 6 Nov 2020 20:14:57 -0400
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
Message-ID: <20201107001457.GB244516@ziepe.ca>
References: <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
 <20201106195341.GA244516@ziepe.ca>
 <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 01:03:26PM -0700, Logan Gunthorpe wrote:
> I don't think a function like that will work for the p2pmem use case. In
> order to implement proper page freeing I expect I'll need a loop around
> the allocator and vm_insert_mixed()... Something roughly like:
> 
> for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
>         vaddr = pci_alloc_p2pmem(pdev, PAGE_SIZE);
> 	ret = vmf_insert_mixed(vma, addr,
>   		       __pfn_to_pfn_t(virt_to_pfn(vaddr), PFN_DEV | PFN_MAP));
> }
> 
> That way we can call pci_free_p2pmem() when a page's ref count goes to
> zero. I suspect your use case will need to do something similar.

Yes, but I would say the pci_alloc_p2pmem() layer should be able to
free pages on a page-by-page basis so you don't have to do stuff like
the above.

There is often a lot of value in having physical contiguous addresses,
so allocating page by page as well seems poor.

Jason
