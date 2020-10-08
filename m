Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1F28739B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgJHLw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:52:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2965 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729056AbgJHLwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:52:23 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id ECF6381D48C2EA3B2156;
        Thu,  8 Oct 2020 12:52:20 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.237) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 8 Oct 2020
 12:52:19 +0100
Subject: Re: [PATCH RFC v4 00/13] perf pmu-events: Support event aliasing for
 system PMUs
To:     kajoljain <kjain@linux.ibm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
 <1f1c4537-2224-cd83-a10a-947ef8cd2864@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2ca3d31e-478f-5e0a-dd36-37e84e4abf7c@huawei.com>
Date:   Thu, 8 Oct 2020 12:49:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1f1c4537-2224-cd83-a10a-947ef8cd2864@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.237]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2020 12:27, kajoljain wrote:
> Hi John,
>    I am looking into these patches, it seems they are not re-based on top of
> latest Arnaldo's perf/core branch. Can you rebase these changes. I think we are missing
> multiple updates.
> 
> 
> Thanks,
> Kajol Jain
> 

Hi Kajol Jain,

My thought was that since the kernel part needs acceptance first [0], 
which is based on v5.9-rc7, I would just use the same baseline here.

However I suppose I should still use Arnaldo's perf/core from now on as 
baseline, so I'll look at that now.

Thanks,
John

[0] 
https://lore.kernel.org/lkml/1602149181-237415-1-git-send-email-john.garry@huawei.com/T/#mc34f758ab72f3d4a90d854b9bda7e6bbb90835b2
