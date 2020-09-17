Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4026D261
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 06:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIQEWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 00:22:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54824 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQEWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 00:22:09 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id 85C0120B7178;
        Wed, 16 Sep 2020 21:22:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85C0120B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600316528;
        bh=aHUbevYdWmKrFZGfOI0mJZjZ/P3yx7HaG2fed8pEhpk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C2TUWasXDiSCaF5VxUH5Hq4626eyjfTM+sqWFATYgD2rP17oNZdor5lCOpfq1I97z
         aDS+qPb1gxwATfCAea4kohOytxw5Pcofx7vASeoRLOVSKMQq0CKYQ7tYKIts8xRWWo
         EyNkMtYxVghHzItOeDK4QxhB2ihd9qlQD/EOoPrk=
Subject: Re: [v3 2/2] mm: khugepaged: avoid overriding min_free_kbytes set by
 user
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1600305709-2319-1-git-send-email-vijayb@linux.microsoft.com>
 <1600305709-2319-3-git-send-email-vijayb@linux.microsoft.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <a9b53080-9dc3-c1ee-8126-eaf8e38ce736@linux.microsoft.com>
Date:   Wed, 16 Sep 2020 21:22:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1600305709-2319-3-git-send-email-vijayb@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch.  I forgot to run scripts/checkpatch.pl and see

CHECK: Alignment should match open parenthesis
#30: FILE: mm/khugepaged.c:2287:
+       if (recommended_min > min_free_kbytes ||
+               recommended_min > user_min_free_kbytes) {

ERROR: do not initialise globals to 0
#43: FILE: mm/page_alloc.c:318:
+int user_min_free_kbytes = 0;

Sorry for trouble, I will send a new version.

Vijay

On 9/16/2020 6:21 PM, Vijay Balakrishna wrote:
> set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
> user.  Post start-of-day THP enable or memory hotplug operations can
> lose user specified min_free_kbytes, in particular when it is higher than
> calculated recommended value.  user_min_free_kbytes initialized to 0
> to avoid undesired result when comparing with  "unsigned long" type.
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/khugepaged.c | 3 ++-
>   mm/page_alloc.c | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4f7107476a6f..3c1147816d12 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2283,7 +2283,8 @@ static void set_recommended_min_free_kbytes(void)
>   			      (unsigned long) nr_free_buffer_pages() / 20);
>   	recommended_min <<= (PAGE_SHIFT-10);
>   
> -	if (recommended_min > min_free_kbytes) {
> +	if (recommended_min > min_free_kbytes ||
> +		recommended_min > user_min_free_kbytes) {
>   		if (user_min_free_kbytes >= 0)
>   			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
>   				min_free_kbytes, recommended_min);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fab5e97dc9ca..7b81fb139034 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -315,7 +315,7 @@ compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
>   };
>   
>   int min_free_kbytes = 1024;
> -int user_min_free_kbytes = -1;
> +int user_min_free_kbytes = 0;
>   #ifdef CONFIG_DISCONTIGMEM
>   /*
>    * DiscontigMem defines memory ranges as separate pg_data_t even if the ranges
> 
