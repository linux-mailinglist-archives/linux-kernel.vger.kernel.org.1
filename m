Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A652C6AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbgK0Rw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:52:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:43062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbgK0Rw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:52:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97D16AC0C;
        Fri, 27 Nov 2020 17:52:55 +0000 (UTC)
Subject: Re: [PATCH] mm/page_owner: Record timestamp and pid
To:     Andrew Morton <akpm@linux-foundation.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sudaraja@codeaurora.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
References: <20201112184106.733-1-georgi.djakov@linaro.org>
 <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <02f682e2-0e9b-76a8-04fa-487891e18bdf@suse.cz>
Date:   Fri, 27 Nov 2020 18:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 8:14 PM, Andrew Morton wrote:
> On Thu, 12 Nov 2020 20:41:06 +0200 Georgi Djakov <georgi.djakov@linaro.org> wrote:
> 
>> From: Liam Mark <lmark@codeaurora.org>
>> 
>> Collect the time for each allocation recorded in page owner so that
>> allocation "surges" can be measured.
>> 
>> Record the pid for each allocation recorded in page owner so that
>> the source of allocation "surges" can be better identified.
> 
> Please provide a description of why this is considered useful.  What
> has it been used for, what problems has it been used to solve?

Worth noting that on x86_64 it doubles the size of struct page_owner
from 16 bytes to 32, so it better be justified:

struct page_owner {
         short unsigned int         order;                /*     0     2 */
         short int                  last_migrate_reason;  /*     2     2 */
         gfp_t                      gfp_mask;             /*     4     4 */
         depot_stack_handle_t       handle;               /*     8     4 */
         depot_stack_handle_t       free_handle;          /*    12     4 */
         u64                        ts_nsec;              /*    16     8 */
         int                        pid;                  /*    24     4 */

         /* size: 32, cachelines: 1, members: 7 */
         /* padding: 4 */
         /* last cacheline: 32 bytes */
};


> Are there userspace tools which aid in the processing of this new
> information?
> 
> Can/should Documentation/vm/page_owner.rst be updated?
> 
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/migrate.h>
>>  #include <linux/stackdepot.h>
>>  #include <linux/seq_file.h>
>> +#include <linux/sched/clock.h>
>>  
>>  #include "internal.h"
>>  
>> @@ -25,6 +26,8 @@ struct page_owner {
>>  	gfp_t gfp_mask;
>>  	depot_stack_handle_t handle;
>>  	depot_stack_handle_t free_handle;
>> +	u64 ts_nsec;
>> +	int pid;
> 
> pid_t would be nicer?
> 
> 
> 

