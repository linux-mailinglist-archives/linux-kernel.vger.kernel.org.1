Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125B41DDC49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 02:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgEVArf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 20:47:35 -0400
Received: from foss.arm.com ([217.140.110.172]:55772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgEVArf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 20:47:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65CC230E;
        Thu, 21 May 2020 17:47:34 -0700 (PDT)
Received: from [10.163.76.230] (unknown [10.163.76.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 096B73F52E;
        Thu, 21 May 2020 17:47:31 -0700 (PDT)
Subject: Re: [PATCH mmotm] mm/vmstat: Add events for PMD based THP migration
 without split fix
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>, Zi Yan <ziy@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.LSU.2.11.2005210643340.482@eggly.anvils>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f1673e4f-64ca-9cf2-861c-7e8a7deeede1@arm.com>
Date:   Fri, 22 May 2020 06:16:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2005210643340.482@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2020 07:19 PM, Hugh Dickins wrote:
> Fix 5.7-rc6-mm1 page migration crash in unmap_and_move(): when the
> page to be migrated has been freed from under us, that is considered 
> a MIGRATEPAGE_SUCCESS, but no newpage has been allocated (and I don't
> think it would ever need to be counted as a successful THP migration).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Fix to mm-vmstat-add-events-for-pmd-based-thp-migration-without-split.patch
> 
>  mm/migrate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 5.7-rc6-mm1/mm/migrate.c	2020-05-20 12:21:56.117693827 -0700
> +++ linux/mm/migrate.c	2020-05-20 15:08:12.319476978 -0700
> @@ -1248,7 +1248,7 @@ out:
>  	 * we want to retry.
>  	 */
>  	if (rc == MIGRATEPAGE_SUCCESS) {
> -		if (PageTransHuge(newpage))
> +		if (newpage && PageTransHuge(newpage))
>  			thp_migration_success(true);
>  		put_page(page);
>  		if (reason == MR_MEMORY_FAILURE) {
> 

Thanks Hugh. I am preparing to respin the vmstat patch accommodating some
earlier comments. Wondering if I should also fold these changes here after
adding your signed-off-by ?

- Anshuman
