Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471BE2FD302
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390449AbhATONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:13:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2384 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbhATNKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:10:19 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DLQkh0dJ6z67dkD;
        Wed, 20 Jan 2021 21:06:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Jan 2021 14:09:13 +0100
Received: from [10.47.7.185] (10.47.7.185) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 20 Jan
 2021 13:09:11 +0000
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
 <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
 <20210120125622.GE1760208@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0d064a9b-bbb6-4ef9-b959-d64c14850319@huawei.com>
Date:   Wed, 20 Jan 2021 13:07:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210120125622.GE1760208@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.185]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2021 12:56, Jiri Olsa wrote:
> that's fixing the issue for me, this was crashing:
>    # perf stat -a -I 1000 -M L1D_Cache_Fill_BW,L2_Cache_Fill_BW
> 
> could you please send it formaly, so it can be merged?
> 

I will do it today. But I want to make sure that the logic is correct, 
so checking it all again, i.e. I can fix the segfault but the logic may 
be wrong.

I think Ian wrote this code originally or made the most recent rework 
(which I tried to fix), so would like him to check also.

> I can't reproduce the original patch issue and I need
> to check the code in more depth

It should only occur for metrics when using system PMUs, i.e. match via 
identifier file, so I really doubt your system has them.

I'd like to add a test for this - I need to think how...

Cheers,
John
