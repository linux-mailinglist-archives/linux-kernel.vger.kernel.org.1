Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA0302738
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbhAYPth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbhAYPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:48:00 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4FC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:47:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d15so9932481qtw.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WYtrk+5jMyfHMrIk+GFUJtKNShhaML4SL+BF9mnl4ek=;
        b=mEv+bdSqBPdjlX/bdjKIR3SI9YdPtbWuLoQeE76ZBBDrifSvgzpKe2Al9843jB5V2y
         jYAIfZmPEPaeZ5Oqkxoy8QvIVo91+adpqZujygppxIvbax/2vGxGjT3BDnBJ9PYWOzUB
         rbyhx9bsrcmb2rCRD0697Qhj/mNjh0DJinCAfGOX+TjDxCgWsCHPHxm7IgD04aftGPv0
         oJKvBKP3SKQlHkfSkivNxC9jF2Z+VXgar36M3oCMSTRxG3OdArdOxVO+jBLutbLw40hm
         Ywjxl5S6mpTmxxEMrSa2iGbxjeJX6ur9qiCgicoYFfxnWO/esqBDF0MtydZh82NCSBKW
         jxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WYtrk+5jMyfHMrIk+GFUJtKNShhaML4SL+BF9mnl4ek=;
        b=E8Jvs1lMcCSt2zlAVfVm322x2Meqv0wm6BGntRHPhm4xgapXxqxU2R24gFlBRopdO8
         y/tEw/8PAE83oiw7z319xKiNAI7RcVCFBPaqxA3ln/d0Y5vEC+3HxoQwfMjP/nj9Cngg
         N+BRc9LPLcwEfEe5/EfosXr1KwHYfl//8MAVMauzRuTv+FRdHQN5rg5N1Vtl8lgeYOoN
         BaBkoUTueYCA2ocRlSz54lE8hkJUEgr+kZjAgDqEdp6xNB7UaDWlOYRglg7XJrjGVvhE
         4a6jT3JylCrP717UBZoAYNn8IsC7Y8NyoPdF4ocD8kmLZ0v8gD3EGVdNSlPW8KHg+sI1
         gtKQ==
X-Gm-Message-State: AOAM531HPe8D6NM/CdrlNc0zBeOOPLi1rAv0Mtm8nnnQvsJbbbVndZzy
        s8eaWp65nYJq2fueAFUwrdezVA==
X-Google-Smtp-Source: ABdhPJxr0w4GGj4XFZfzo1ZpWgm8ksFBdTqQ/q89OryNoBYa59S4vVi7J2T2VaunByVM7HxRC+LHEw==
X-Received: by 2002:ac8:6987:: with SMTP id o7mr977438qtq.295.1611589638773;
        Mon, 25 Jan 2021 07:47:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id o76sm409454qke.104.2021.01.25.07.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:47:18 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l445F-006YE8-Qg; Mon, 25 Jan 2021 11:47:17 -0400
Date:   Mon, 25 Jan 2021 11:47:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, liguozhu@hisilicon.com,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <20210125154717.GW4605@ziepe.ca>
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

This needs to copy the RLIMIT_MEMLOCK and can_do_mlock() stuff from
other places, like ib_umem_get

> +	ret = xa_err(xa_store(&priv->array, p->first, p, GFP_KERNEL));

And this is really weird, I don't think it makes sense to make handles
for DMA based on the starting VA.

> +static int uacce_unpin_page(struct uacce_pin_container *priv,
> +			    struct uacce_pin_address *addr)
> +{
> +	unsigned long first, last, nr_pages;
> +	struct pin_pages *p;
> +
> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> +	nr_pages = last - first + 1;
> +
> +	/* find pin_pages */
> +	p = xa_load(&priv->array, first);
> +	if (!p)
> +		return -ENODEV;
> +
> +	if (p->nr_pages != nr_pages)
> +		return -EINVAL;
> +
> +	/* unpin */
> +	unpin_user_pages(p->pages, p->nr_pages);

And unpinning without guaranteeing there is no ongoing DMA is really
weird

Are you abusing this in conjunction with a SVA scheme just to prevent
page motion? Why wasn't mlock good enough?

Jason
