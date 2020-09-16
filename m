Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EF826BE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIPH7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:59:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPH7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:59:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FC68AFF8;
        Wed, 16 Sep 2020 07:59:18 +0000 (UTC)
Date:   Wed, 16 Sep 2020 09:59:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v2 2/2] mm: khugepaged: avoid overriding min_free_kbytes set by
 user
Message-ID: <20200916075900.GE18998@dhcp22.suse.cz>
References: <1600204258-13683-1-git-send-email-vijayb@linux.microsoft.com>
 <1600204258-13683-2-git-send-email-vijayb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600204258-13683-2-git-send-email-vijayb@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-09-20 14:10:58, Vijay Balakrishna wrote:
> set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
> user.  Post start-of-day THP enable or memory hotplug operations can
> lose user specified min_free_kbytes, in particular when it is higher than
> calculated recommended value.  Also modifying "recommended_min" variable
> type to "int" from "unsigned long" to avoid undesired result noticed
> during testing.  It is due to comparing "unsigned long" with "int" type.
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/khugepaged.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4f7107476a6f..b4b753ba411a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2253,7 +2253,7 @@ static void set_recommended_min_free_kbytes(void)
>  {
>  	struct zone *zone;
>  	int nr_zones = 0;
> -	unsigned long recommended_min;
> +	int recommended_min;
>  
>  	for_each_populated_zone(zone) {
>  		/*
> @@ -2280,12 +2280,12 @@ static void set_recommended_min_free_kbytes(void)
>  
>  	/* don't ever allow to reserve more than 5% of the lowmem */
>  	recommended_min = min(recommended_min,
> -			      (unsigned long) nr_free_buffer_pages() / 20);
> +			      (int) nr_free_buffer_pages() / 20);

nr_free_buffer_pages can oveflow in int on very large machines.

>  	recommended_min <<= (PAGE_SHIFT-10);
>  
> -	if (recommended_min > min_free_kbytes) {
> +	if (recommended_min > user_min_free_kbytes) {

This can decrease the size theoretically. Because user_min_free_kbytes
is -1 by default and recommended_min might be <= min_free_kbytes.

You need to check both. Also can we make user_min_free_kbytes 0 by
default? From a quick look, nobody should really care.

>  		if (user_min_free_kbytes >= 0)
> -			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
> +			pr_info("raising min_free_kbytes from %d to %d to help transparent hugepage allocations\n",
>  				min_free_kbytes, recommended_min);
>  
>  		min_free_kbytes = recommended_min;
> -- 
> 2.28.0
> 

-- 
Michal Hocko
SUSE Labs
