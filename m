Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73C2DDE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 07:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbgLRGCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 01:02:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9539 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgLRGCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 01:02:50 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cxyt204T3zhttS;
        Fri, 18 Dec 2020 14:01:30 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 18 Dec 2020
 14:02:03 +0800
Subject: Re: [PATCH 1/1] device-dax: avoid an unnecessary check in
 alloc_dev_dax_range()
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jane Chu <jane.chu@oracle.com>
References: <20201120092251.2197-1-thunder.leizhen@huawei.com>
 <CAPcyv4jxgbawSbYF39g857fiDCRmMACr1u-OiSWkz4M0+2UPbQ@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <946f9111-f799-38a1-a185-d882668fa725@huawei.com>
Date:   Fri, 18 Dec 2020 14:02:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jxgbawSbYF39g857fiDCRmMACr1u-OiSWkz4M0+2UPbQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/18 11:10, Dan Williams wrote:
> On Fri, Nov 20, 2020 at 1:23 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> Swap the calling sequence of krealloc() and __request_region(), call the
>> latter first. In this way, the value of dev_dax->nr_range does not need to
>> be considered when __request_region() failed.
> 
> This looks ok, but I think I want to see another cleanup go in first
> before this to add a helper for trimming the last range off the set of
> ranges:
> 
> static void dev_dax_trim_range(struct dev_dax *dev_dax)
> {
>         int i = dev_dax->nr_range - 1;
>         struct range *range = &dev_dax->ranges[i].range;
>         struct dax_region *dax_region = dev_dax->region;
> 
>         dev_dbg(dev, "delete range[%d]: %#llx:%#llx\n", i,
>                 (unsigned long long)range->start,
>                 (unsigned long long)range->end);
> 
>         __release_region(&dax_region->res, range->start, range_len(range));
>         if (--dev_dax->nr_range == 0) {
>                 kfree(dev_dax->ranges);
>                 dev_dax->ranges = NULL;
>         }
> }
> 
> Care to do a lead in patch with that cleanup, then do this one?

I don't mind! You can add above helper first. After that, I'll update
and send this patch again.

> 
> I think that might also cleanup a memory leak report from Jane in
> addition to not needing the "goto" as well.
> 
> http://lore.kernel.org/r/c8a8a260-34c6-dbfc-1f19-25c23d01cb45@oracle.com
> 
> .
> 

