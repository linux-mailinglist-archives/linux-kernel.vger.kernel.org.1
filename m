Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA128EDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgJOHu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:50:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2981 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729335AbgJOHu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:50:58 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6120F176195C93B0A632;
        Thu, 15 Oct 2020 08:50:56 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.103) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 15 Oct
 2020 08:50:54 +0100
Subject: Re: [PATCH RFC v4 06/13] perf vendor events arm64: Add hip09 SMMUv3
 PMCG events
To:     Robin Murphy <robin.murphy@arm.com>, <acme@kernel.org>,
        <will@kernel.org>, <mark.rutland@arm.com>, <jolsa@redhat.com>,
        <irogers@google.com>, <leo.yan@linaro.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>,
        <james.clark@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-imx@nxp.com>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
 <1602152121-240367-7-git-send-email-john.garry@huawei.com>
 <3929fa83-36e0-b739-ac18-331d96cd25a1@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bb7f4b11-57a0-1483-6f7f-c56b288045b3@huawei.com>
Date:   Thu, 15 Oct 2020 08:47:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3929fa83-36e0-b739-ac18-331d96cd25a1@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.169.103]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 19:06, Robin Murphy wrote:
>>
>> +        "EventCode": "0x8a",
>> +        "EventName": "smmuv3_pmcg.L1_TLB",
>> +        "BriefDescription": "SMMUv3 PMCG L1 TABLE transation",
>> +        "PublicDescription": "SMMUv3 PMCG L1 TABLE transation",
> 
> Those typos are either missing "c"s or "l"s, but with SMMU it's never 
> clear which ;)

Ha, I think either could work in this case.

The actual electronic translation I got is "command received by the L1 
TLB", so I'll stick with that until someone here wants to expand on that.

Cheers
