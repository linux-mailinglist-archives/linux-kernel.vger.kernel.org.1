Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDAB23A090
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 10:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgHCICM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 04:02:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2553 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbgHCICM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:02:12 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id F11FFF6F6CA4A5CF8469;
        Mon,  3 Aug 2020 09:02:09 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.55) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 3 Aug 2020
 09:02:08 +0100
Subject: Re: [PATCH v2 2/2] perf pmu: Improve CPU core PMU HW event list
 ordering
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
 <1592384514-119954-3-git-send-email-john.garry@huawei.com>
 <CAM9d7cgqJzQJ7GfL6Q3VgARd1=rrkRYqOqSivZww-LOo+DvKFA@mail.gmail.com>
 <20200617121549.GA31085@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <74303789-6c06-574d-674b-202cf84a2018@huawei.com>
Date:   Mon, 3 Aug 2020 09:00:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200617121549.GA31085@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.55]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2020 13:15, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 17, 2020 at 08:31:02PM +0900, Namhyung Kim escreveu:
>> On Wed, Jun 17, 2020 at 6:06 PM John Garry <john.garry@huawei.com> wrote:
>>>
>>> For perf list, the CPU core PMU HW event ordering is such that not all
>>> events may will be listed adjacent - consider this example:
>>>    cstate_pkg/c6-residency/                           [Kernel PMU event]
>>>    cstate_pkg/c7-residency/                           [Kernel PMU event]
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks a lot, applied.

Hi Arnaldo,

I'm struggling to understand which branch we should base our development 
on. I don't see these patches in perf/core or linux-next. I saw someone 
mentioned tmp.perf/core as a baseline, but I can't see that branch in 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

Please let me know - it would be useful for any dev during the merge window.

Thanks,
John
