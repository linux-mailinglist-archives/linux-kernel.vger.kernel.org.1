Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B449528B250
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgJLKhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:37:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2968 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387522AbgJLKhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:37:50 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B89ABBECC34FEB1508D9;
        Mon, 12 Oct 2020 11:37:48 +0100 (IST)
Received: from [127.0.0.1] (10.47.8.38) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 12 Oct
 2020 11:37:47 +0100
Subject: Re: [PATCH RFC v4 13/13] perf vendor events: Add JSON metrics for
 imx8mm DDR Perf
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
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
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
 <1602152121-240367-14-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67950A459A08343CA3A779A4E6070@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <14cf6eae-f865-bd0d-72c1-57aeb87f2570@huawei.com>
Date:   Mon, 12 Oct 2020 11:34:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67950A459A08343CA3A779A4E6070@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.38]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 11:03, Joakim Zhang wrote:
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
>> @@ -0,0 +1,39 @@
>> +[
>> +   {
>> +           "BriefDescription": "ddr cycles event",
>> +           "EventCode": "0x00",
>> +           "EventName": "imx8_ddr.cycles",
> Could you help change to imx8mm_ddr.cycles? Thanks a lot!

Can do.

Note that I want to improve perf list in future such that alias 
"imx8_ddr.cycles" removes kernel PMU events which this alias is 
matching. The motivation is that perf list can be swamped by kernel 
uncore PMU events listing.

> 
>> +           "Unit": "imx8_ddr",
>> +           "Compat": "i.MX8MM"

