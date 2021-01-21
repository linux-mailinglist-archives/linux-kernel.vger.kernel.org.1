Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1C72FF788
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbhAUVp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:45:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2398 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhAUVnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:43:00 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMG3z1ZVcz67dZs;
        Fri, 22 Jan 2021 05:38:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 22:42:06 +0100
Received: from [10.47.10.180] (10.47.10.180) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 21 Jan
 2021 21:42:04 +0000
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
 <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
 <DB8PR04MB67951BF5DBE4524CB13BAAE4E6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <c3d8d635-33ab-8d7e-6efc-6a589aebeb52@huawei.com>
 <20210121203136.GD356537@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f4e26095-c172-cf32-cb6e-3baaf6d739cd@huawei.com>
Date:   Thu, 21 Jan 2021 21:40:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210121203136.GD356537@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.180]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 20:31, Arnaldo Carvalho de Melo wrote:
>> They are not normally broken like that. Normally we test beforehand, but
>> these cases were missed here by me. However if you were testing them
>> previously, then it would be expected that you had tested them again for the
>> final patchset which was merged.
>   
>> Anyway, we can look to add metric tests for these.
>   
>> @Arnaldo, I will send separate formal patch for this today.
> Hi John, can you please take a look at my tmp.perf/urgent branch and see
> if all is well, i.e. the versions of these patches are the ones that
> should be merged and that all the patches discussed are there?
> 
> For your convenience:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/urgent

Hi Arnaldo,

Yeah, that looks fine. I gave it a quick spin also without issue.

Cheers,
John
