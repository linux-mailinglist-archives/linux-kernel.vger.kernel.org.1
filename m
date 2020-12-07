Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000C02D182B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgLGSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:05:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2218 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:05:36 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CqWPS0Kgjz67McX;
        Tue,  8 Dec 2020 02:02:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 19:04:55 +0100
Received: from [10.210.169.98] (10.210.169.98) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 18:04:53 +0000
Subject: Re: [PATCH v6 08/10] perf metricgroup: Support printing metric groups
 for system PMUs
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
 <1607080216-36968-9-git-send-email-john.garry@huawei.com>
 <20201207172319.GD129853@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a47b44ba-320e-88fe-300f-193996fc067a@huawei.com>
Date:   Mon, 7 Dec 2020 18:04:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201207172319.GD129853@kernel.org>
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

On 07/12/2020 17:23, Arnaldo Carvalho de Melo wrote:
>> +struct metricgroup_print_sys_idata {
>> +	struct strlist *metriclist;
>> +	bool metricgroups;
>> +	char *filter;
>> +	bool raw;
>> +	bool details;
>> +	struct rblist *groups;
>> +};
> I'm doing some reorg to avoid these holes:
> 
> [acme@five perf]$ pahole -C metricgroup_print_sys_idata ~/bin/perf
> struct metricgroup_print_sys_idata {
> 	struct strlist *           metriclist;           /*     0     8 */
> 	_Bool                      metricgroups;         /*     8     1 */
> 
> 	/* XXX 7 bytes hole, try to pack */
> 
> 	char *                     filter;               /*    16     8 */
> 	_Bool                      raw;                  /*    24     1 */
> 	_Bool                      details;              /*    25     1 */
> 
> 	/* XXX 6 bytes hole, try to pack */
> 
> 	struct rblist *            groups;               /*    32     8 */
> 
> 	/* size: 40, cachelines: 1, members: 6 */
> 	/* sum members: 27, holes: 2, sum holes: 13 */
> 	/* last cacheline: 40 bytes */
> };
> [acme@five perf]$
> 
> It ended up as:
> 
> [acme@five perf]$ pahole -C metricgroup_print_sys_idata ~/bin/perf
> struct metricgroup_print_sys_idata {
> 	struct strlist *           metriclist;           /*     0     8 */
> 	char *                     filter;               /*     8     8 */
> 	struct rblist *            groups;               /*    16     8 */
> 	_Bool                      metricgroups;         /*    24     1 */
> 	_Bool                      raw;                  /*    25     1 */
> 	_Bool                      details;              /*    26     1 */
> 
> 	/* size: 32, cachelines: 1, members: 6 */
> 	/* padding: 5 */
> 	/* last cacheline: 32 bytes */
> };
> [acme@five perf]$o
> 

Hi Arnaldo,

OK, I'll be less wasteful in my struct organization.

Thanks,
John

