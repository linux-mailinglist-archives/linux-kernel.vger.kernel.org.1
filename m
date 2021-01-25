Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADE303637
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbhAZGE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:04:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2409 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbhAYMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:51:08 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPV3K404jz67gKV;
        Mon, 25 Jan 2021 20:46:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 25 Jan 2021 13:50:25 +0100
Received: from [10.47.2.25] (10.47.2.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 25 Jan
 2021 12:50:24 +0000
Subject: Re: [PATCH 0/4] perf vendor events arm64: Some tidy-up/refactoring
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <james.clark@arm.com>, <nakamura.shun@jp.fujitsu.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Yan <leo.yan@linaro.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>
References: <1611575600-2440-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a8533b41-ef64-4584-4a65-ca605d6e4acb@huawei.com>
Date:   Mon, 25 Jan 2021 12:49:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1611575600-2440-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.25]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2021 11:53, John Garry wrote:

+ Missed reviewers for 
https://lore.kernel.org/lkml/1611575600-2440-1-git-send-email-john.garry@huawei.com/T/#u

> There is much event duplication in the common and uarch events for A76
> and Ampere eMag support, so factor out into a common JSON.
> 
> Since the wording for events may differ between CPU datasheet and
> the architecture reference manual, the current wording is kept. This
> is unless there are minor differences. In addition, event names are
> renamed to be same as architecture reference manual, to keep commonality.
> 
> Also a minor fix is included for the Ampere eMag JSON.
> 
> John Garry (4):
>    perf vendor events arm64: Fix Ampere eMag event typo
>    perf vendor events arm64: Add common and uarch event JSON
>    perf vendor events arm64: Reference common and uarch events for Ampere
>      eMag
>    perf vendor events arm64: Reference common and uarch events for A76
> 
>   .../arch/arm64/ampere/emag/branch.json        |   8 +-
>   .../arch/arm64/ampere/emag/bus.json           |   5 +-
>   .../arch/arm64/ampere/emag/cache.json         |  58 +---
>   .../arch/arm64/ampere/emag/clock.json         |   4 +-
>   .../arch/arm64/ampere/emag/exception.json     |  10 +-
>   .../arch/arm64/ampere/emag/instruction.json   |  34 +--
>   .../arch/arm64/ampere/emag/memory.json        |  11 +-
>   .../arch/arm64/arm/cortex-a76-n1/branch.json  |  12 +-
>   .../arch/arm64/arm/cortex-a76-n1/bus.json     |  19 +-
>   .../arch/arm64/arm/cortex-a76-n1/cache.json   | 118 +++------
>   .../arm64/arm/cortex-a76-n1/exception.json    |  10 +-
>   .../arm64/arm/cortex-a76-n1/instruction.json  |  45 +---
>   .../arch/arm64/arm/cortex-a76-n1/memory.json  |   6 +-
>   .../arch/arm64/arm/cortex-a76-n1/other.json   |   4 +-
>   .../arm64/arm/cortex-a76-n1/pipeline.json     |  12 +-
>   .../arm64/armv8-common-and-microarch.json     | 248 ++++++++++++++++++
>   16 files changed, 356 insertions(+), 248 deletions(-)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
> 

