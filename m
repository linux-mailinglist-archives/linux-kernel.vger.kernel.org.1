Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437202C610E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgK0IkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:40:14 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7997 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgK0IkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:40:14 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cj7NW0109zhjXC;
        Fri, 27 Nov 2020 16:39:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.208) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 27 Nov 2020
 16:40:08 +0800
Subject: Re: [PATCH 1/1] perf diff: fix error return value in __cmd_diff()
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201124103652.438-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bcd5f5f7-6d07-8cf8-8297-ff573bbded51@huawei.com>
Date:   Fri, 27 Nov 2020 16:40:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201124103652.438-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody:
  Can any one review it?


On 2020/11/24 18:36, Zhen Lei wrote:
> An appropriate return value should be set on the failed path.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  tools/perf/builtin-diff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 584e2e1a3793..cefc71506409 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1222,8 +1222,10 @@ static int __cmd_diff(void)
>  		if (compute == COMPUTE_STREAM) {
>  			d->evlist_streams = evlist__create_streams(
>  						d->session->evlist, 5);
> -			if (!d->evlist_streams)
> +			if (!d->evlist_streams) {
> +				ret = -ENOMEM;
>  				goto out_delete;
> +			}
>  		}
>  	}
>  
> 

