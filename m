Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7CE28E5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJNRob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:44:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2979 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbgJNRob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:44:31 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 74B7E1A2FE127C5E1B5C;
        Wed, 14 Oct 2020 18:44:29 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.149) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 14 Oct
 2020 18:44:28 +0100
Subject: Re: [PATCH RFC v4 00/13] perf pmu-events: Support event aliasing for
 system PMUs
To:     Jiri Olsa <jolsa@redhat.com>
CC:     kajoljain <kjain@linux.ibm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "irogers@google.com" <irogers@google.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
 <1f1c4537-2224-cd83-a10a-947ef8cd2864@linux.ibm.com>
 <2ca3d31e-478f-5e0a-dd36-37e84e4abf7c@huawei.com>
 <20201014111639.GA1375972@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6d385075-41a4-5614-6632-3a1449c73338@huawei.com>
Date:   Wed, 14 Oct 2020 18:41:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201014111639.GA1375972@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.149]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 12:16, Jiri Olsa wrote:
>> My thought was that since the kernel part needs acceptance first [0], which
>> is based on v5.9-rc7, I would just use the same baseline here.
>>
>> However I suppose I should still use Arnaldo's perf/core from now on as
>> baseline, so I'll look at that now.
> yes please, I can't already apply 2nd patch..
> 
> 	patching file pmu-events/jevents.c
> 	Hunk #1 succeeded at 82 with fuzz 2 (offset 29 lines).
> 	Hunk #2 FAILED at 335.
> 	Hunk #3 FAILED at 354.
> 	Hunk #4 succeeded at 406 (offset 22 lines).
> 	Hunk #5 FAILED at 439.
> 	Hunk #6 FAILED at 531.
> 	Hunk #7 FAILED at 555.
> 	Hunk #8 FAILED at 602.
> 	Hunk #9 FAILED at 698.
> 	Hunk #10 succeeded at 770 (offset 2 lines).
> 	Hunk #11 succeeded at 813 (offset 2 lines).
> 	Hunk #12 succeeded at 1075 (offset 2 lines).
> 	Hunk #13 succeeded at 1242 (offset 2 lines).
> 	Hunk #14 succeeded at 1273 (offset 2 lines).
> 	7 out of 14 hunks FAILED -- saving rejects to file pmu-events/jevents.c.rej
> 	can't find file to patch at input line 439

OK, so I already did the rebase and it was quite straightforward - the 
conflicts came with the recent changes in jevents.

I will send out soon.

Thanks,
John
