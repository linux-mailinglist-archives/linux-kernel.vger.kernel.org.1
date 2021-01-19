Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED02FBBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbhASPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:50:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2380 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbhASPtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:49:09 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKtHX22Xtz67bGm;
        Tue, 19 Jan 2021 23:44:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 16:48:15 +0100
Received: from [10.210.167.214] (10.210.167.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 15:48:14 +0000
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
Date:   Tue, 19 Jan 2021 15:47:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.214]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2021 10:56, Joakim Zhang wrote:
> It seems have other issue compared to 5.10 kernel after switching to this framework, below metric can't work.
> "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 4 / duration_time) / (750 * 1000000 * 4 * 4)"
> After change to:
> "MetricExpr": "(( imx8mm_ddr.read_cycles + imx8mm_ddr.write_cycles ) * 4 * 4 / duration_time) / (750 * 1000000 * 4 * 4)",

It seems that any metric which includes "duration_time" is broken, even 
on x86:

john@localhost:~/acme/tools/perf> sudo ./perf stat -v -M 
L1D_Cache_Fill_BW sleep 1
Using CPUID GenuineIntel-6-3D-4
metric expr 64 * l1d.replacement / 1000000000 / duration_time for 
L1D_Cache_Fill_BW
found event duration_time
found event l1d.replacement
adding {l1d.replacement}:W,duration_time
l1d.replacement -> cpu/umask=0x1,(null)=0x1e8483,event=0x51/
Segmentation fault


Seems to be from my commit c2337d67199 ("perf metricgroup: Fix metrics 
using aliases covering multiple PMUs")

I'll look to fix it now.

Thanks,
John

