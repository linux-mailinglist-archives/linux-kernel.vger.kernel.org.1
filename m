Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632C82D424F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgLIMm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:42:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2233 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730929AbgLIMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:42:29 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Crc7d1LLcz67JqH;
        Wed,  9 Dec 2020 20:39:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 9 Dec 2020 13:41:46 +0100
Received: from [10.210.171.175] (10.210.171.175) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 12:41:46 +0000
Subject: Re: [RESEND PATCH v3 1/4] iommu/iova: Add free_all_cpu_cached_iovas()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <xiyou.wangcong@gmail.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <1605608734-84416-2-git-send-email-john.garry@huawei.com>
 <0ae7688c-10b7-aa6b-c398-ac0917f7ae71@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5c6b4411-f711-773b-3378-e7c20b7c11f1@huawei.com>
Date:   Wed, 9 Dec 2020 12:41:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <0ae7688c-10b7-aa6b-c398-ac0917f7ae71@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.175]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2020 08:58, Leizhen (ThunderTown) wrote:
>>   		goto retry;
>>   	}
>>   
> Reviewed-by: Zhen Lei<thunder.leizhen@huawei.com>
> 


Thanks, incidentally this needs to be rebased, which I'll do now.
