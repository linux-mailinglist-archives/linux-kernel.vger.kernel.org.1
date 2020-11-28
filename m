Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC172C6E4A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 02:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgK1Bxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 20:53:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8441 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbgK1BwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 20:52:08 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CjYSg1Dcszhjwx;
        Sat, 28 Nov 2020 09:14:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.208) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 28 Nov 2020
 09:15:13 +0800
Subject: Re: [PATCH 1/1] perf diff: fix error return value in __cmd_diff()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201124103652.438-1-thunder.leizhen@huawei.com>
 <CAM9d7cgKDMCst2jEmHMHT7MC0DaTg1naNTt3cZnRepiNkmF-VA@mail.gmail.com>
 <20201127172202.GL70905@kernel.org> <20201127172544.GM70905@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2f491206-5f36-61c5-f133-03afe8234c0f@huawei.com>
Date:   Sat, 28 Nov 2020 09:15:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201127172544.GM70905@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/28 1:25, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 27, 2020 at 02:22:02PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Nov 27, 2020 at 10:35:37PM +0900, Namhyung Kim escreveu:
>>> On Tue, Nov 24, 2020 at 7:37 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>>>> An appropriate return value should be set on the failed path.
> 
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>  
>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>  
>> Thanks, applied.
> 
> I also added this:
> 
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Fixes: 2a09a84c720b436a ("perf diff: Support hot streams comparison")
> 
> Please add the fixes line and CC the author of the patch introducing the
> bug next time,

Okay, I'll do that next time. Thanks for the heads-up.

> 
> Thanks
> 
> - Arnaldo
> 
> .
> 

