Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D553045D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbhAZR5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:57:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390770AbhAZJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:01:29 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQ0zL3bJpz15yjp;
        Tue, 26 Jan 2021 16:59:26 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 26 Jan 2021
 17:00:30 +0800
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-mm@kvack.org>, <song.bao.hua@hisilicon.com>,
        <liguozhu@hisilicon.com>, Sihang Chen <chensihang1@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <c20b0894-dd04-cf67-0975-7219f95bcaae@hisilicon.com>
Date:   Tue, 26 Jan 2021 17:00:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210125154717.GW4605@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/25 23:47, Jason Gunthorpe wrote:
> On Mon, Jan 25, 2021 at 04:34:56PM +0800, Zhou Wang wrote:
> 
>> +static int uacce_pin_page(struct uacce_pin_container *priv,
>> +			  struct uacce_pin_address *addr)
>> +{
>> +	unsigned int flags = FOLL_FORCE | FOLL_WRITE;
>> +	unsigned long first, last, nr_pages;
>> +	struct page **pages;
>> +	struct pin_pages *p;
>> +	int ret;
>> +
>> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
>> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
>> +	nr_pages = last - first + 1;
>> +
>> +	pages = vmalloc(nr_pages * sizeof(struct page *));
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	if (!p) {
>> +		ret = -ENOMEM;
>> +		goto free;
>> +	}
>> +
>> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
>> +				  flags | FOLL_LONGTERM, pages);
> 
> This needs to copy the RLIMIT_MEMLOCK and can_do_mlock() stuff from
> other places, like ib_umem_get

I am confused as can_do_mlock seems to be about the limitation of mlock,
which has different meaning with pin memory?

> 
>> +	ret = xa_err(xa_store(&priv->array, p->first, p, GFP_KERNEL));
> 
> And this is really weird, I don't think it makes sense to make handles
> for DMA based on the starting VA.

Here starting VA is used as an index of pinned pages. When doing unpinning,
starting VA is used to get pinned pages, check unpinned VA/size.

But it has problem here to use xa_store here as new one will replace old one :(
Seems we can use xa_insert here, which returns -EBUSY if the entry at one
index is not empty. The design here will be that we only support to pin same
VA once.

> 
>> +static int uacce_unpin_page(struct uacce_pin_container *priv,
>> +			    struct uacce_pin_address *addr)
>> +{
>> +	unsigned long first, last, nr_pages;
>> +	struct pin_pages *p;
>> +
>> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
>> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
>> +	nr_pages = last - first + 1;
>> +
>> +	/* find pin_pages */
>> +	p = xa_load(&priv->array, first);
>> +	if (!p)
>> +		return -ENODEV;
>> +
>> +	if (p->nr_pages != nr_pages)
>> +		return -EINVAL;
>> +
>> +	/* unpin */
>> +	unpin_user_pages(p->pages, p->nr_pages);
> 
> And unpinning without guaranteeing there is no ongoing DMA is really
> weird
> 
> Are you abusing this in conjunction with a SVA scheme just to prevent
> page motion? Why wasn't mlock good enough?

Just as Barry said, mlock can not avoid IOPF from page migration.

Best,
Zhou

> 
> Jason
> 
> .
> 

