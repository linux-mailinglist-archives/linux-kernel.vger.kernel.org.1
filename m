Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF752CAE03
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbgLAVFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:05:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2186 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLAVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:05:23 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ClvgF0wCPz67GVD;
        Wed,  2 Dec 2020 05:02:17 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 1 Dec 2020 22:04:36 +0100
Received: from [10.47.199.27] (10.47.199.27) by lhreml741-chm.china.huawei.com
 (10.201.108.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Dec 2020
 21:04:30 +0000
Subject: Re: [PATCH v2 1/3] Revert "perf session: Fix decompression of
 PERF_RECORD_COMPRESSED records"
To:     Jiri Olsa <jolsa@redhat.com>, Petr Malat <oss@malat.biz>,
        <alexey.bayduraev@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, <abudankov@huawei.com>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz> <20201124143645.GD2088148@krava>
 <20201124181519.GA29264@ntb.petris.klfree.czf>
 <20201130114020.GA29476@ntb.petris.klfree.czf>
 <20201201190928.GB3169083@krava>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <90d5469d-2591-44bf-70c4-edc1b2750935@huawei.com>
Date:   Wed, 2 Dec 2020 00:04:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201190928.GB3169083@krava>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.199.27]
X-ClientProxiedBy: braeml708-chm.china.huawei.com (10.226.71.36) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12.2020 22:09, Jiri Olsa wrote:
> On Mon, Nov 30, 2020 at 12:40:20PM +0100, Petr Malat wrote:
>> Hi Jiří,
>> were you able to reproduce the issue? I may also upload perf-archive
>> if that would help.
> 
> oh yea ;-) seems like those 2 commits you reverted broke 32 bits
> perf for data files > 32MB
> 
> but the fix you did does not work for Alexey's test he mentioned
> in the commit:
> 
>       $ perf record -z -- some_long_running_workload
>       $ perf report --stdio -vv
> 
> it's failing for me with:
> 
> 	# ./perf report
> 	Couldn't allocate memory for decompression
> 	0xfe6f3a [0x60]: failed to process type: 81 [Operation not permitted]
> 	Error:
> 	failed to process sample
> 	# To display the perf.data header info, please use --header/--header-only options.
> 	#
> 
> I think that's why here's special handling for compressed
> events, but I'll need to check on that in more detail,
> I was hoping for Alexey to answer ;-)

Sorry for delay. Alexey Bayduraev could possibly help with that sooner.
Alexey, could you please follow up.

Thanks,
Alexei
