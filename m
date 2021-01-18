Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE1B2FA0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391974AbhARNDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:03:45 -0500
Received: from foss.arm.com ([217.140.110.172]:35252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390332AbhARNAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:00:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52AC731B;
        Mon, 18 Jan 2021 04:59:31 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E36F3F719;
        Mon, 18 Jan 2021 04:59:30 -0800 (PST)
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
To:     John Garry <john.garry@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
 <YAHRKCkcHAEUdRNT@larix.localdomain>
 <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com> <YAVeDOiKBEKZ2Tdq@myrica>
 <cdc77ccd-823d-464b-fe3c-2a9da17bcb61@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <69614e38-fcc0-4220-e1cd-15de91dd61ef@arm.com>
Date:   Mon, 18 Jan 2021 12:59:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cdc77ccd-823d-464b-fe3c-2a9da17bcb61@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-18 10:55, John Garry wrote:
> On 18/01/2021 10:08, Jean-Philippe Brucker wrote:
>>>> Any idea why that's happening?  This fix seems ok but if we're 
>>>> expecting
>>>> allocation failures for the loaded magazine then we could easily get it
>>>> for cpu_rcaches too, and get a similar abort at runtime.
>>> It's not specifically that we expect them (allocation failures for the
>>> loaded magazine), rather we should make safe against it.
>>>
>>> So could you be more specific in your concern for the cpu_rcache 
>>> failure?
>>> cpu_rcache magazine assignment comes from this logic.
>> If this fails:
>>
>> drivers/iommu/iova.c:847: rcache->cpu_rcaches = 
>> __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
>>
>> then we'll get an Oops in __iova_rcache_get(). So if we're making the
>> module safer against magazine allocation failure, shouldn't we also
>> protect against cpu_rcaches allocation failure?
> 
> Ah, gotcha. So we have the WARN there, but that's not much use as this 
> would still crash, as you say.
> 
> So maybe we can embed the cpu rcaches in iova_domain struct, to avoid 
> the separate (failable) cpu rcache allocation.

Is that even possible? The size of percpu data isn't known at compile 
time, so at best it would add ugly runtime complexity to any allocation 
of a struct iova_domain by itself, but worse than that it means that 
embedding iova_domain in any other structure becomes completely broken, no?

Robin.

> Alternatively, we could add NULL checks __iova_rcache_get() et al for 
> this allocation failure but that's not preferable as it's fastpath.
> 
> Finally so we could pass back an error code from init_iova_rcache() to 
> its only caller, init_iova_domain(); but that has multiple callers and 
> would need to be fixed up.
> 
> Not sure which is best or on other options.
> 
> Thanks,
> John
