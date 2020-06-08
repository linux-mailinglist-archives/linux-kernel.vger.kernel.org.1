Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A75A1F1327
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 09:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgFHHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgFHHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:04:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DE9C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kOgcUHX0zNsLgrzKIZZVZ5HbxzYUV6u6MWDbb+56ot4=; b=K6P/0nS7ZwAPQ6b6LI1ZuIGzyy
        ZsIOCpn8sIKiwGcRm/viCmJMlJo1qAUGgZGwQiu6PxEL0xZYhDh1APKzKZmtiFiyds86D/Jy++Q2J
        obCYjtQP8fFufQa0NW/FUBuBr3eplMnoM1YyDMB+VqppJJ1pxfKZDFUc9V0Ma4EfL2d64Ok5cSzLv
        ymfhxvD2A20eHhIay4/PnULLqqE3bh19DaICVqjssKuxl4nIN0T2TBnA9p+u+TRd1jQoNtzOmbmOD
        o2F1k1ZEvu/MlL9t7pjju9m0J/YJoZBe5fIonIAs2eTO+qHFoWilwSzMI/oWm6SCU77ywPLyTbth7
        +jNXKQNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiBpL-0000kv-Rr; Mon, 08 Jun 2020 07:04:11 +0000
Date:   Mon, 8 Jun 2020 00:04:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 01/11] swiotlb-xen: use vmalloc_to_page on vmalloc
 virt addresses
Message-ID: <20200608070411.GA15742@infradead.org>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
 <20200603222247.11681-1-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603222247.11681-1-sstabellini@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this isn't just RPi4, but basically any ARM or ARM64 system
with non-coherent DMA (which is most of them).

> +	struct page *pg;

Please spell out page.

>  
>  	if (hwdev && hwdev->coherent_dma_mask)
>  		dma_mask = hwdev->coherent_dma_mask;
> @@ -346,9 +347,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> +	pg = is_vmalloc_addr(vaddr) ? vmalloc_to_page(vaddr) :
> +				      virt_to_page(vaddr);

Please use plain old if/else to make this more readable.
