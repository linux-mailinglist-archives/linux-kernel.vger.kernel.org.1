Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7C1CDDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgEKOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 10:52:57 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730251AbgEKOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:52:57 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9E81F9E1ADD340018546;
        Mon, 11 May 2020 15:52:55 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.142) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 11 May
 2020 15:52:54 +0100
Subject: Re: [PATCH RFC v3 02/12] perf jevents: Add support for system events
 tables
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <qiangqing.zhang@nxp.com>, <irogers@google.com>,
        <robin.murphy@arm.com>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-3-git-send-email-john.garry@huawei.com>
 <20200511110127.GB2986380@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7d416932-12a0-8130-354a-f0a9898d9bf6@huawei.com>
Date:   Mon, 11 May 2020 15:52:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200511110127.GB2986380@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.142]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 12:01, Jiri Olsa wrote:
> On Thu, May 07, 2020 at 07:57:41PM +0800, John Garry wrote:
> 
> SNIP
> 
>>   
>> +static bool is_sys_dir(char *fname)
>> +{
>> +	char *pos;
>> +
>> +	while (true) {
>> +		pos = strchr(fname, '/');
> 
> would strrchr be faster?

maybe, I'll check the logic here to see if it can be reduced

  also I thought there's something like
> basename function that could be usable in here?

it's tricky, as we support putting JSONs in ./, or ./sys, or ./cpu

But I'll revisit this, as I cannot understand the logic at a glance, 
which is not good...

Thanks,
John

> 
> jirka
> 
>> +
>> +		if (!pos) {
>> +			if (!strcmp(fname, "sys"))
>> +				return true;
>> +			return false;
>> +		}
>> +
>> +		fname = pos + 1;
>> +	}
>> +
>> +	return false;
>> +}
> 
> .
> 

