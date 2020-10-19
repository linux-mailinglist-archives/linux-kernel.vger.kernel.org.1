Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB6292304
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgJSHiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:38:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:55741 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbgJSHiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:38:01 -0400
IronPort-SDR: diJQwlBGyldHljXBcaKF1AdlW/CMKPGs6kbZuyTLXHNE/Z/S/WcLa01w83nXFBv6ZJTaJ4M99S
 Jk7cHBYaEQ0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="146280001"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="146280001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 00:37:59 -0700
IronPort-SDR: v8n1GIO3V1Krbh0UsCrd3j9O/YLzI+PkbPAIwaMn10BgwQfpOzLrEVWroHYqT9DOXKJnq/gbGb
 up0eraJF1i/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="347328811"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2020 00:37:55 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yang.shi@linux.alibaba.com>, <rientjes@google.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>
Subject: Re: [RFC][PATCH 6/9] mm/vmscan: add page demotion counter
References: <20201007161736.ACC6E387@viggo.jf.intel.com>
        <20201007161747.FE7288F0@viggo.jf.intel.com>
Date:   Mon, 19 Oct 2020 15:37:55 +0800
In-Reply-To: <20201007161747.FE7288F0@viggo.jf.intel.com> (Dave Hansen's
        message of "Wed, 7 Oct 2020 09:17:47 -0700")
Message-ID: <87v9f6hdik.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> From: Yang Shi <yang.shi@linux.alibaba.com>
>
> Account the number of demoted pages into reclaim_state->nr_demoted.

It appears that you don't add "nr_demoted" into struct reclaim_state.

> Add pgdemote_kswapd and pgdemote_direct VM counters showed in
> /proc/vmstat.
>
> [ daveh:
>    - __count_vm_events() a bit, and made them look at the THP
>      size directly rather than getting data from migrate_pages()

It appears that we get the data from migrate_pages() now.

> ]
>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>
>  b/include/linux/vm_event_item.h |    2 ++
>  b/mm/vmscan.c                   |    6 ++++++
>  b/mm/vmstat.c                   |    2 ++
>  3 files changed, 10 insertions(+)
>
> diff -puN include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter include/linux/vm_event_item.h
> --- a/include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter	2020-10-07 09:15:32.171642439 -0700
> +++ b/include/linux/vm_event_item.h	2020-10-07 09:15:32.179642439 -0700
> @@ -33,6 +33,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
>  		PGREUSE,
>  		PGSTEAL_KSWAPD,
>  		PGSTEAL_DIRECT,
> +		PGDEMOTE_KSWAPD,
> +		PGDEMOTE_DIRECT,
>  		PGSCAN_KSWAPD,
>  		PGSCAN_DIRECT,
>  		PGSCAN_DIRECT_THROTTLE,
> diff -puN mm/vmscan.c~mm-vmscan-add-page-demotion-counter mm/vmscan.c
> --- a/mm/vmscan.c~mm-vmscan-add-page-demotion-counter	2020-10-07 09:15:32.173642439 -0700
> +++ b/mm/vmscan.c	2020-10-07 09:15:32.180642439 -0700
> @@ -147,6 +147,7 @@ struct scan_control {
>  		unsigned int immediate;
>  		unsigned int file_taken;
>  		unsigned int taken;
> +		unsigned int demoted;

It appears that this newly added field isn't used in the patch.

>  	} nr;
>  
>  	/* for recording the reclaimed slab by now */
> @@ -1134,6 +1135,11 @@ static unsigned int demote_page_list(str
>  			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
>  			    &nr_succeeded);
>  
> +	if (current_is_kswapd())
> +		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
> +	else
> +		__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
> +
>  	return nr_succeeded;
>  }
>  
> diff -puN mm/vmstat.c~mm-vmscan-add-page-demotion-counter mm/vmstat.c
> --- a/mm/vmstat.c~mm-vmscan-add-page-demotion-counter	2020-10-07 09:15:32.175642439 -0700
> +++ b/mm/vmstat.c	2020-10-07 09:15:32.181642439 -0700
> @@ -1244,6 +1244,8 @@ const char * const vmstat_text[] = {
>  	"pgreuse",
>  	"pgsteal_kswapd",
>  	"pgsteal_direct",
> +	"pgdemote_kswapd",
> +	"pgdemote_direct",
>  	"pgscan_kswapd",
>  	"pgscan_direct",
>  	"pgscan_direct_throttle",
> _

Best Regards,
Huang, Ying
