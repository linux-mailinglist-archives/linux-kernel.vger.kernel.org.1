Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18F2DAFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgLOPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:06:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2259 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgLOPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:06:13 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CwM0r5vV8z67Q4G;
        Tue, 15 Dec 2020 23:01:48 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 15 Dec 2020 16:05:27 +0100
Received: from [10.199.170.166] (10.199.170.166) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 15 Dec 2020 15:05:20 +0000
Subject: Re: [PATCH v3 00/12] Introduce threaded trace streaming for basic
 perf record operation
To:     Namhyung Kim <namhyung@kernel.org>,
        "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        <abudankov@huawei.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <20201120094512.GA94830@google.com>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <54c121cf-1295-30b4-adc3-c96c2e91ca55@huawei.com>
Date:   Tue, 15 Dec 2020 18:05:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201120094512.GA94830@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.170.166]
X-ClientProxiedBy: braeml703-chm.china.huawei.com (10.226.71.47) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20.11.2020 12:45, Namhyung Kim wrote:
> Hi,
> 
> Thanks for working on this!

Thanks for your review.
Just spotted comments for this version.
Sorry for delay.

> 
> On Mon, Nov 16, 2020 at 03:12:47PM +0300, Alexey Budankov wrote:
>>
>> Changes in v3:
>> - avoided skipped redundant patch 3/15
>> - applied "data file" and "data directory" terms allover the patch set
>> - captured Acked-by: tags by Namhyung Kim
>> - avoided braces where don't needed
>> - employed thread local variable for serial trace streaming 
>> - added specs for --thread option - core, socket, numa and user defined
>> - added parallel loading of data directory files similar to the prototype [1]
> 
> Can you please consider splitting tracing records (FORK/MMAP/...) into
> a separate file?  I think this change would put too much burden to the
> perf report side.  I'm saying this repeatedly because I'm afraid that
> it'd be harder to change later once we accept this approach/format..

Alexey Bayduraev in To/Cc is going to proceed with this work
so there are chances to have updated version soon.

Thanks,
Alexei
