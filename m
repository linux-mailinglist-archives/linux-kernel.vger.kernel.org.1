Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0216F1B996E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD0IKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 04:10:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbgD0IKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:10:36 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 2EE6FD676F2D184C0CE3;
        Mon, 27 Apr 2020 09:10:35 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.137) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Apr
 2020 09:10:24 +0100
Subject: Re: [RFC PATCH v2 09/13] perf vendor events: Add JSON metrics for
 imx8mm DDR Perf
From:   John Garry <john.garry@huawei.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "irogers@google.com" <irogers@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-10-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67959336311C0CF525BB24ADE6D40@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <3486ee3b-7240-d5a7-5a3c-952133a5e9f0@huawei.com>
 <DB8PR04MB679576DAC6EBFFD13F129488E6D40@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <d54e6c6b-0fe6-0cda-e93e-151ce50d0f66@huawei.com>
 <DB8PR04MB6795E2C668C959D4B551F9C3E6D50@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <9c82611a-f9ef-7286-8ab7-f7b7ace680ce@huawei.com>
Message-ID: <c199f6d7-156a-d1c9-fa59-7cbe92c37c96@huawei.com>
Date:   Mon, 27 Apr 2020 09:09:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <9c82611a-f9ef-7286-8ab7-f7b7ace680ce@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.137]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2020 13:28, John Garry wrote:
>> cles(event=0x00), read-cycles(event=0x2a), write-cycles(event=0x2b), 
>> read(event=0x35), write(event=0x38), all these events listed in file 
>> (tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json) are 
>> compatible for all i.MX8 DDR Perf, only AXI events are various from 
>> each SoC. These events tested okay for MX8MM and MX8QM.
>>
>> Same situation, metrics listed in file 
>> (tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json) 
>> is also compatible for all i.MX8 DDR Perf, since metric expression 
>> only contains read-cycles(event=0x2a) and write-cycles(event=0x2b).
>>
>> Generally speaking, now pmu events and metrics on your branch should 
>> support both MX8MM and MX8QM without any change, as long as they 
>> export "i.mx8mm" identifier.
> 
> Right, but MX8QM should export "i.mx8qm" identifier for upstream 
> eventually.
> 
>>
>> As I mentioned before, pmu events tested okay for MX8MM and MX8QM. 
>> Metric also tested okay for MX8MM.
>> For MX8QM which has two HW PMU(ddr0/ddr1), metric can work, but it 
>> would add metric twice which I think if it is possible to improve it 
>> in your serials.
>>
>> I guess the root cause is that "imx8_ddr.read_cycles" contains two HW 
>> PMU events (imx8_ddr0/read-cycles/ and imx8_ddr1/read-cycles/) and 
>> metricgroup can't handle it at present.
> 
> It should be ok, but I'll check it.
> 

ok, I think I see the issue here. We add a metric per PMU erroneously. 
We don't see an issue for printing metrics, as the code does not error 
when adding clones when printing (which we do).

I'll try to fix this week.

Thanks,
John

>>
>> 8QM:
>> root@imx8qmmek:~# ./perf stat -v -a -I 1000 -M imx8mm_ddr_read.all
>> Using CPUID 0x00000000410fd030
>> metric expr imx8_ddr.read_cycles * 4 * 4 for imx8mm_ddr_read.all
>> found event imx8_ddr.read_cycles
>> metric expr imx8_ddr.read_cycles * 4 * 4 for imx8mm_ddr_read.all
>> found event imx8_ddr.read_cycles
>> adding {imx8_ddr.read_cycles}:W,{imx8_ddr.read_cycles}:W
>> imx8_ddr.read_cycles -> imx8_ddr0/event=0x2a/
>> imx8_ddr.read_cycles -> imx8_ddr1/event=0x2a/
>> imx8_ddr.read_cycles -> imx8_ddr0/event=0x2a/
>> imx8_ddr.read_cycles -> imx8_ddr1/event=0x2a/
>> imx8_ddr.read_cycles: 22748 1000378750 1000378750
>> imx8_ddr.read_cycles: 24640 1000376625 100

