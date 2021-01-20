Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA72FCC35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbhATH7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:59:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:55868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbhATH4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:56:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611129362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10TNc64vcvmY4BmMGIrygVrVOvqidXtSKL+wsXLD8iQ=;
        b=H36PWmR8WR91rEaz+VyKGTRDpLTkbRJr0CVQ7gnv765XueOy9Nm3t9V1y2h1wqCtOzdgsH
        qAoDbaxhhuPPZ12iuQxQ6fw69nNx5Mp9mvfGQob0EOVki8MDaQFWdux8z9iDob5JNCla3r
        tuomjMw366uAvUFpYiUdSm4wQ4nAgIY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FDE3ACAD;
        Wed, 20 Jan 2021 07:56:02 +0000 (UTC)
Date:   Wed, 20 Jan 2021 08:56:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: page_counter: relayout structure to reduce false
 sharing
Message-ID: <20210120075601.GC9371@dhcp22.suse.cz>
References: <1611040814-33449-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1611040814-33449-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-01-21 15:20:14, Feng Tang wrote:
> When checking a memory cgroup related performance regression [1],
> from the perf c2c profiling data, we found high false sharing for
> accessing 'usage' and 'parent'.
> 
> On 64 bit system, the 'usage' and 'parent' are close to each other,
> and easy to be in one cacheline (for cacheline size == 64+ B). 'usage'
> is usally written, while 'parent' is usually read as the cgroup's
> hierarchical counting nature.
> 
> So move the 'parent' to the end of the structure to make sure they
> are in different cache lines.
> 
> Following are some performance data with the patch, against
> v5.11-rc1. [ In the data, A means a platform with 2 sockets 48C/96T,
> B is a platform of 4 sockests 72C/144T, and if a %stddev will be
> shown bigger than 2%, P100/P50 means number of test tasks equals
> to 100%/50% of nr_cpu]
> 
> will-it-scale/malloc1
> ---------------------
> 	   v5.11-rc1			v5.11-rc1+patch
> 
> A-P100	     15782 ±  2%      -0.1%      15765 ±  3%  will-it-scale.per_process_ops
> A-P50	     21511            +8.9%      23432        will-it-scale.per_process_ops
> B-P100	      9155            +2.2%       9357        will-it-scale.per_process_ops
> B-P50	     10967            +7.1%      11751 ±  2%  will-it-scale.per_process_ops
> 
> will-it-scale/pagefault2
> ------------------------
> 	   v5.11-rc1			v5.11-rc1+patch
> 
> A-P100	     79028            +3.0%      81411        will-it-scale.per_process_ops
> A-P50	    183960 ±  2%      +4.4%     192078 ±  2%  will-it-scale.per_process_ops
> B-P100	     85966            +9.9%      94467 ±  3%  will-it-scale.per_process_ops
> B-P50	    198195            +9.8%     217526        will-it-scale.per_process_ops
> 
> fio (4k/1M is block size)
> -------------------------
> 	   v5.11-rc1			v5.11-rc1+patch
> 
> A-P50-r-4k     16881 ±  2%    +1.2%      17081 ±  2%  fio.read_bw_MBps
> A-P50-w-4k      3931          +4.5%       4111 ±  2%  fio.write_bw_MBps
> A-P50-r-1M     15178          -0.2%      15154        fio.read_bw_MBps
> A-P50-w-1M      3924          +0.1%       3929        fio.write_bw_MBps

Thanks for making results easier to read and understand.

> [1].https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> Changelogs:
>   
>   v2:
>   * Adjust the format of performance data to be more readable,
>     as suggested by Michal Hocko
> 
>  include/linux/page_counter.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 85bd413..6795913 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -12,7 +12,6 @@ struct page_counter {
>  	unsigned long low;
>  	unsigned long high;
>  	unsigned long max;
> -	struct page_counter *parent;
>  
>  	/* effective memory.min and memory.min usage tracking */
>  	unsigned long emin;
> @@ -27,6 +26,14 @@ struct page_counter {
>  	/* legacy */
>  	unsigned long watermark;
>  	unsigned long failcnt;
> +
> +	/*
> +	 * 'parent' is placed here to be far from 'usage' to reduce
> +	 * cache false sharing, as 'usage' is written mostly while
> +	 * parent is frequently read for cgroup's hierarchical
> +	 * counting nature.
> +	 */
> +	struct page_counter *parent;
>  };
>  
>  #if BITS_PER_LONG == 32
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
