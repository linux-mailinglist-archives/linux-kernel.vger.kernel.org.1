Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5C302534
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbhAYMze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:55:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11157 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbhAYMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:49:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DPV496csnz15yFb;
        Mon, 25 Jan 2021 20:46:49 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 25 Jan 2021
 20:47:52 +0800
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <YA6PWSs8dxsHEpY+@kroah.com>
CC:     <song.bao.hua@hisilicon.com>,
        Sihang Chen <chensihang1@hisilicon.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        <liguozhu@hisilicon.com>, <linux-accelerators@lists.ozlabs.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <8e49eaf8-64d3-c25a-9e65-5461a1af7941@hisilicon.com>
Date:   Mon, 25 Jan 2021 20:47:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YA6PWSs8dxsHEpY+@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/25 17:28, Greg Kroah-Hartman wrote:
> On Mon, Jan 25, 2021 at 04:34:56PM +0800, Zhou Wang wrote:
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
>> +	if (ret != nr_pages) {
>> +		pr_err("uacce: Failed to pin page\n");
>> +		goto free_p;
>> +	}
>> +	p->first = first;
>> +	p->nr_pages = nr_pages;
>> +	p->pages = pages;
>> +
>> +	ret = xa_err(xa_store(&priv->array, p->first, p, GFP_KERNEL));
>> +	if (ret)
>> +		goto unpin_pages;
>> +
>> +	return 0;
>> +
>> +unpin_pages:
>> +	unpin_user_pages(pages, nr_pages);
>> +free_p:
>> +	kfree(p);
>> +free:
>> +	vfree(pages);
>> +	return ret;
>> +}
> 
> No error checking on the memory locations or size of memory to be
> 'pinned', what could ever go wrong?

These problems has been considered if I understand it right.

I have checked pin_user_pages_fast, it checks memory location by access_ok.
For the size of memory to pin, we added a limitation, like limiting pin
page size to 1GB, however, it has been removed in the post patch. The
reason is the permission of /dev/uacce_ctrl is 600 root:root, /dev/uacce_ctrl
has to been added to trusted groups by root to be used.

> 
> Note, this opens a huge hole in the kernel that needs to be documented
> really really really well somewhere, as it can cause very strange
> results if you do not know exactly what you are doing, which is why I am
> going to require that the mm developers sign off on this type of thing.
> 
> And to give more context, I really don't think this is needed, but if it

Maybe I do not explain the problem clearly. Let us see it again.

From the view of functionality, pin page is no needed at all, however,
from the view of performance, we need make DMA physical pages fixed as
the latency of IO page fault currently is relatively high, for example
for ARM SMMUv3 IO page fault, it will be at least 20us+. When a DMA
transaction triggers a IO page fault, the performance will be bad. See
from a long term, the DMA performance will be not stable.

Here we use pinned pages to create a memory pool in user space, users'
lib/app can use the memory in above pinned pages based memory pool to
avoid IO page fault.

Best,
Zhou

> is, it should be a new syscall, not buried in an ioctl for a random
> misc driver, but the author seems to want it tied to this specific
> driver...
> 
> thanks,
> 
> greg k-h
> 
> .
> 

