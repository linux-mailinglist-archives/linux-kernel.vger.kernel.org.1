Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00629ECB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgJ2NTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:19:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6932 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgJ2NTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:19:16 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMQyD4Gzyz70Kr;
        Thu, 29 Oct 2020 21:19:16 +0800 (CST)
Received: from [10.174.179.62] (10.174.179.62) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 21:19:05 +0800
Subject: Re: [PATCH] iommu/rockchip: check return value of
 of_find_device_by_node() in rk_iommu_of_xlate()
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <heiko@sntech.de>, <jeffy.chen@rock-chips.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20201029092202.900218-1-yukuai3@huawei.com>
 <98dec09e-08a1-6550-fa4e-85a8104b90e1@arm.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <35ff5111-1270-fc88-788c-4fb9e38faa85@huawei.com>
Date:   Thu, 29 Oct 2020 21:19:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <98dec09e-08a1-6550-fa4e-85a8104b90e1@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.62]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/10/29 18:08, Robin Murphy wrote:
> On 2020-10-29 09:22, Yu Kuai wrote:
>> If of_find_device_by_node() failed in rk_iommu_of_xlate(), null pointer
>> dereference will be triggered. Thus return error code if
>> of_find_device_by_node() failed.
> 
> How can that happen? (Given that ".suppress_bind_attrs = true")
> 
> Robin.

I'm not sure if that could happen...

My thought is that it's better to do such checking to aviod any possible
problem.

Thanks!
Yu Kuai
