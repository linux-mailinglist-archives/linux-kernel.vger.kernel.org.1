Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC8295C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896123AbgJVJrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:47:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2509987AbgJVJrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:47:06 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5C76F6BEFE8400EDCBF0;
        Thu, 22 Oct 2020 10:47:05 +0100 (IST)
Received: from [10.47.5.196] (10.47.5.196) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 22 Oct
 2020 10:47:03 +0100
Subject: Re: [PATCH 1/2] perf jevents: Tidy error handling
To:     kajoljain <kjain@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Yao Jin <yao.jin@linux.intel.com>, <yeyunfeng@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1603121908-53543-1-git-send-email-john.garry@huawei.com>
 <1603121908-53543-2-git-send-email-john.garry@huawei.com>
 <CAM9d7cg0j3j-EXY2MULYWpyMri5_GxBnHVNvrHN4UG0pwsa=mw@mail.gmail.com>
 <eb3073cd-7184-58f3-f03f-b094abaff007@linux.ibm.com>
 <3fda581b-3f2b-5dce-b388-916117d20e7c@huawei.com>
 <7e7c5aeb-5c9b-727a-d605-e871007af34a@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <348855b5-d109-3e30-a669-d4e2c766ad30@huawei.com>
Date:   Thu, 22 Oct 2020 10:43:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7e7c5aeb-5c9b-727a-d605-e871007af34a@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.5.196]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2020 14:37, kajoljain wrote:
>>> May be we can use similar checks:
>>>
>>> if( verbose)
>>>     pr_info("%s: Error walking file tree %s%s\n", prog, ldirname,err_string_ext);
>>> if(rc > 0)
>>>      empty_map = 1;
>>> else
>>>     ret = 1;
>>>
>> Not that it matters much, this logic is slightly different for verbose set and rc < 0. I don't mind going with that, so let me know.
> Yes right. Sure if required we can made changes on these checks and include appropriate condition for verbose set and rc < 0. Seems fine to me.

I will just revert to the original logic for now. Someone can try to 
change later if they want.

Thanks
