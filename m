Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E09280C67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 05:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbgJBDCN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Oct 2020 23:02:13 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727780AbgJBDCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 23:02:13 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 123423830BCA024DEA9A;
        Fri,  2 Oct 2020 11:02:11 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 2 Oct 2020 11:02:10 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 2 Oct 2020 11:02:10 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 2 Oct 2020 11:02:10 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Alexey Budankov" <alexey.budankov@linux.intel.com>
Subject: RE: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
Thread-Topic: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
Thread-Index: AQHWl+qFe9svqgT9AUqxYD+FeGRiAamC2SiAgADF+DA=
Date:   Fri, 2 Oct 2020 03:02:10 +0000
Message-ID: <dc9c24dcc58d477fa7e9c1a2ea246791@hisilicon.com>
References: <20201001115729.27116-1-song.bao.hua@hisilicon.com>
 <20201001230653.GM50079@tassilo.jf.intel.com>
In-Reply-To: <20201001230653.GM50079@tassilo.jf.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.246]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andi Kleen [mailto:ak@linux.intel.com]
> Sent: Friday, October 2, 2020 12:07 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Peter
> Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Arnaldo
> Carvalho de Melo <acme@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@redhat.com>;
> Namhyung Kim <namhyung@kernel.org>; Adrian Hunter
> <adrian.hunter@intel.com>; Alexey Budankov
> <alexey.budankov@linux.intel.com>
> Subject: Re: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
> 
> On Fri, Oct 02, 2020 at 12:57:29AM +1300, Barry Song wrote:
> > Commit 7736627b865d ("perf stat: Use affinity for closing file
> > descriptors") will use FD(evsel, cpu, thread) to read and write file
> > descriptors xyarray. For a kernel PMU event, this leads to serious
> > memory corruption and perf crash.
> > I have seen evlist->core.cpus->nr is 1 while evsel has cpus->nr with
> > the total number of CPUs. so xyarray which is allocated by
> > evlist->core.cpus->nr will get overflow. This leads to various
> > segmentation faults in perf tool for kernel PMU events, eg:
> > ./perf stat -e bus_cycles  sleep 1
> > *** Error in `./perf': free(): invalid next size (fast):
> > 0x00000000401e6370 *** Aborted (core dumped)
> 
> Thanks.
> 
> I believe there is already a patch queued for this.

Andi, thanks! Could you share the link or the commit ID? I'd like to take a look at the fix.
I could still reproduce this issue in the latest linus' tree and I didn't find any commit
related to this issue in linux-next and tip/perf/core.

> 
> The problem seems to only happen on ARM64.

My platform which has this issue is really ARM64.

Thanks
Barry
