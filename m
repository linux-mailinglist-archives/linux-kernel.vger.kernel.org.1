Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170482CC0B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgLBPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:22:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2194 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgLBPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:22:04 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmN0h5SFmz67Kll;
        Wed,  2 Dec 2020 23:19:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 2 Dec 2020 16:21:22 +0100
Received: from [10.47.3.233] (10.47.3.233) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Dec 2020
 15:21:20 +0000
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
To:     Will Deacon <will@kernel.org>
CC:     <robin.murphy@arm.com>, <joro@8bytes.org>,
        <xiyou.wangcong@gmail.com>, <linuxarm@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        yuqi jin <jinyuqi@huawei.com>, <dima@arista.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <d87ceec4-b7a1-c600-3b78-6852f0320ce2@huawei.com>
 <20201201210215.GB28178@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <627436e2-ae2b-afeb-915c-b6d460d813f8@huawei.com>
Date:   Wed, 2 Dec 2020 15:20:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201201210215.GB28178@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2020 21:02, Will Deacon wrote:

cc'ing some more people who have touched iova code recently

> On Tue, Dec 01, 2020 at 03:35:02PM +0000, John Garry wrote:
>> On 17/11/2020 10:25, John Garry wrote:
>> Is there any chance that we can get these picked up for 5.11? We've seen
>> this issue solved here for a long time.
>>
>> Or, @Robin, let me know if not happy with this since v1.
>>
>> BTW, patch #4 has been on the go for ~1 year now, and is a nice small
>> optimisation from Cong, which I picked up and already had a RB tag.
> I can pick the last patch up, but I'd really like some reviewed/tested-bys
> on the others.
> 

ok, fair enough.

Considering the extremes required to unearth the main problem, it'll be 
hard to get testers, but, fwiw, I can provide a tested-by from the reporter:

Tested-by: Xiang Chen <chenxiang66@hisilicon.com>

@Robin, You originally had some interest in this topic - are you now 
satisfied with the changes I am proposing?

Please let me know.

Thanks,
John
