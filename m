Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17502D1820
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgLGSD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:03:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2217 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGSD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:03:26 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CqWLL6NyGz67M0N;
        Tue,  8 Dec 2020 02:00:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 7 Dec 2020 19:02:43 +0100
Received: from [10.210.169.98] (10.210.169.98) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 18:02:41 +0000
Subject: Re: [PATCH v6 06/10] perf metricgroup: Fix metrics using aliases
 covering multiple PMUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <irogers@google.com>, <qiangqing.zhang@nxp.com>,
        <kjain@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <kan.liang@linux.intel.com>, <kim.phillips@amd.com>,
        <ak@linux.intel.com>
References: <1607080216-36968-1-git-send-email-john.garry@huawei.com>
 <1607080216-36968-7-git-send-email-john.garry@huawei.com>
 <20201207171914.GC129853@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <af5c5712-c6cf-6b22-12b6-7e7d7672ab13@huawei.com>
Date:   Mon, 7 Dec 2020 18:02:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201207171914.GC129853@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.98]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2020 17:19, Arnaldo Carvalho de Melo wrote:
> Next time please try to provides a Fixes: tag to help with
> backporting/stable@kernel.org  work.
> 

Hi Arnaldo,

I know you asked me this before Re. fixes tags ... but I don't know any 
cases of "metrics using aliases covering multiple PMUs" in mainline 
today (which this patch addresses). If there are some, then I guess that 
they are broken and we should seek them out.

Note that this topic was discussed here initially:
https://lore.kernel.org/linux-perf-users/CAP-5=fUy6FOszNRwJF6ZNpqQSSyrnLPV6GbkEcZMqAhUp3X0ZA@mail.gmail.com/

There has been much churn on the metric code recently, so prob not a 
straight stable backport; as such, I would prefer to know some metric 
was broken and verify we fix it.

If you have any better ideas to handle this, then please let me know.

Cheers,
John
