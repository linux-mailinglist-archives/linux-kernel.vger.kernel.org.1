Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59032924C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgJSJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:40:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgJSJkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:40:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5452AB1E1;
        Mon, 19 Oct 2020 09:40:08 +0000 (UTC)
Subject: Re: [PATCH v2] mm/compaction: Rename 'start_pfn' to
 'iteration_start_pfn' in compact_zone()
To:     yanfei.xu@windriver.com, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201019083632.25417-1-yanfei.xu@windriver.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <57730b8a-f5d7-d6c7-3961-3fa95701aba5@suse.cz>
Date:   Mon, 19 Oct 2020 11:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201019083632.25417-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 10:36 AM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> There are two 'start_pfn' declared in compact_zone() which have
> different meaning. Rename the second one to 'iteration_start_pfn'
> to prevent trace_mm_compaction_end() from tracing an undesirable
> value.

"to prevent confusion.", because trace_mm_compaction_end() has the
correct value even before the patch - the second start_pfn is out
of scope at that point.

Thanks

> BTW, remove an useless semicolon.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
> v1->v2:
> Rename 'start_pfn' to 'iteration_start_pfn' and change commit messages.
> 
>   mm/compaction.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 176dcded298e..ccd27c739fd6 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2272,7 +2272,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   
>   	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
>   		int err;
> -		unsigned long start_pfn = cc->migrate_pfn;
> +		unsigned long iteration_start_pfn = cc->migrate_pfn;
>   
>   		/*
>   		 * Avoid multiple rescans which can happen if a page cannot be
> @@ -2284,7 +2284,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   		 */
>   		cc->rescan = false;
>   		if (pageblock_start_pfn(last_migrated_pfn) ==
> -		    pageblock_start_pfn(start_pfn)) {
> +		    pageblock_start_pfn(iteration_start_pfn)) {
>   			cc->rescan = true;
>   		}
>   
> @@ -2308,8 +2308,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   			goto check_drain;
>   		case ISOLATE_SUCCESS:
>   			update_cached = false;
> -			last_migrated_pfn = start_pfn;
> -			;
> +			last_migrated_pfn = iteration_start_pfn;
>   		}
>   
>   		err = migrate_pages(&cc->migratepages, compaction_alloc,
> 

