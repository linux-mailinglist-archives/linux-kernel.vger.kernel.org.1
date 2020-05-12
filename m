Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8857D1CF229
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 12:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgELKOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 06:14:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbgELKOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:14:06 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C703479D73E2140BD683;
        Tue, 12 May 2020 11:14:04 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.134) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 12 May
 2020 11:14:03 +0100
Subject: Re: [PATCH RFC v3 00/12] perf pmu-events: Support event aliasing for
 system PMUs
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "irogers@google.com" <irogers@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB6795D56E9EC43949E5F40465E6BE0@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2642e2a6-9e44-79c4-2bf5-498cedd897a4@huawei.com>
Date:   Tue, 12 May 2020 11:13:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB6795D56E9EC43949E5F40465E6BE0@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.134]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I have an aside question, do you have any idea? Thanks a lot!
> 
> For DDR PMU, I want to add bandwidth usage metric, but it depends on DDR controller clock frequency.
> For example, we have i.MX8MM LPDDR4 board which DDR controller clock is 800MHZ, and i.MX8MM DDR4 board which DDR controller is 600MHZ, but the SoC is the same.
> 
> So they can share all JSON metrics with identifier "i.mx8mm", except bandwidth metric. 

what is the bandwidth metric? how is it supposed to be calculated?

If I add separate JOSN metrics files for identifier "i.mx8mm-lpddr4" and 
identifier "i.mx8mm-ddr4", then it's going to be very redundant, since 
most metrics are same just the identifier is different.
> 
> Do you know how perf tool handle such case?

jirka is supporting user-defined metric here:
https://lore.kernel.org/lkml/20200511205307.3107775-1-jolsa@kernel.org/

So maybe you can use that somehow with separate scripts.

Thanks,
John
