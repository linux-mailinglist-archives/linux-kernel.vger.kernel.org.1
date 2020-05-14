Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72D1D2AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 11:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgENJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 05:00:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbgENJAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:00:07 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E1EF7EEC6174B837C45D;
        Thu, 14 May 2020 10:00:02 +0100 (IST)
Received: from [127.0.0.1] (10.47.3.198) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 14 May
 2020 10:00:01 +0100
Subject: Re: [PATCH 2/2] perf test: Improve pmu event metric testing
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20200513062236.854-1-irogers@google.com>
 <20200513062236.854-2-irogers@google.com>
 <ac88604a-56c2-b632-57c2-3bee316dcea7@huawei.com>
 <CAP-5=fVkD+0wCMcBBHWM8djsnn2KsshOyK_XcjNDTsiVo04vwQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5264e16c-fb1a-4bbc-96b5-1d867e38902e@huawei.com>
Date:   Thu, 14 May 2020 09:59:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVkD+0wCMcBBHWM8djsnn2KsshOyK_XcjNDTsiVo04vwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.198]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2020 17:10, Ian Rogers wrote:
>> Out of interest, if we could move the validation of metrics to jevents,
>> how much functionality would we still have here?
> If we add checking to jevents then the MetricExpr would be known to be
> valid, however, the events (aka ids) within the expression could be
> invalid.

So I think that has some value. I mean, just to detect syntax errors, 
like those remedied in "perf metrics: fix parse errors in power8 metrics".

> I'm not sure we could realistically check the events at
> jevents (build) time as there is no guarantee that the machine we run
> on is the same as the one we compile on.

But we could at least check that there are event aliases for that CPU, 
right? (by examining the JSONs for that cpu). If the event alias does 
not actually match on the target CPU, then that can't be helped.

Cheers,
John

