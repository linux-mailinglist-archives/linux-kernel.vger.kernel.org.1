Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B73303406
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbhAZFMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbhAYJja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:39:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEFAC22472;
        Mon, 25 Jan 2021 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611566940;
        bh=wF0JYx7C+UwAIZY8ksPAuFgLqtbCeO/VruEju37N6uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVmpbLLUS17+Ue9duoUlgwPZAao35PSkhItEGsD+FSck0iLnOluYZsuOCgXE0g4wP
         hnC+b2Znk45U2PhKkTOSc/4ceGhIqgsz6tRKk3YKakkpX4LC3bDpYNsNZEW3EsXbZA
         pwRl84JwfoH8fc2R3mBJb8Zj75Gsf4+nt7Qi4xSQ=
Date:   Mon, 25 Jan 2021 10:28:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, liguozhu@hisilicon.com,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <YA6PWSs8dxsHEpY+@kroah.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:34:56PM +0800, Zhou Wang wrote:
> +static int uacce_pin_page(struct uacce_pin_container *priv,
> +			  struct uacce_pin_address *addr)
> +{
> +	unsigned int flags = FOLL_FORCE | FOLL_WRITE;
> +	unsigned long first, last, nr_pages;
> +	struct page **pages;
> +	struct pin_pages *p;
> +	int ret;
> +
> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> +	nr_pages = last - first + 1;
> +
> +	pages = vmalloc(nr_pages * sizeof(struct page *));
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
> +				  flags | FOLL_LONGTERM, pages);
> +	if (ret != nr_pages) {
> +		pr_err("uacce: Failed to pin page\n");
> +		goto free_p;
> +	}
> +	p->first = first;
> +	p->nr_pages = nr_pages;
> +	p->pages = pages;
> +
> +	ret = xa_err(xa_store(&priv->array, p->first, p, GFP_KERNEL));
> +	if (ret)
> +		goto unpin_pages;
> +
> +	return 0;
> +
> +unpin_pages:
> +	unpin_user_pages(pages, nr_pages);
> +free_p:
> +	kfree(p);
> +free:
> +	vfree(pages);
> +	return ret;
> +}

No error checking on the memory locations or size of memory to be
'pinned', what could ever go wrong?

Note, this opens a huge hole in the kernel that needs to be documented
really really really well somewhere, as it can cause very strange
results if you do not know exactly what you are doing, which is why I am
going to require that the mm developers sign off on this type of thing.

And to give more context, I really don't think this is needed, but if it
is, it should be a new syscall, not buried in an ioctl for a random
misc driver, but the author seems to want it tied to this specific
driver...

thanks,

greg k-h
