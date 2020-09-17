Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51FE26D0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgIQBcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:32:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:36979 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgIQBch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:32:37 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:32:37 EDT
IronPort-SDR: PRdfZAkSqCte8tPA3DTEL3g5Y2VbXdQzeh7pvRieNTyDgbEv4glOnVNMi8lfv517Xa2/iuusUe
 vt36/MF2I6gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="139111879"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="139111879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 18:25:30 -0700
IronPort-SDR: Fcrmoel/737e3wECpopU3F4AZnWUrECkqiiJYi97M+pcQYYLbWFzMtnvsu/JwY9NzeE8ykUzFA
 vUmIWQJZNC3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="346429280"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2020 18:25:28 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <yang.shi@linux.alibaba.com>,
        <rientjes@google.com>, <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 4/9] mm/migrate: make migrate_pages() return nr_succeeded
References: <20200818184122.29C415DF@viggo.jf.intel.com>
        <20200818184129.14758DAD@viggo.jf.intel.com>
Date:   Thu, 17 Sep 2020 09:25:27 +0800
In-Reply-To: <20200818184129.14758DAD@viggo.jf.intel.com> (Dave Hansen's
        message of "Tue, 18 Aug 2020 11:41:29 -0700")
Message-ID: <87lfh9ry7s.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> diff -puN mm/migrate.c~migrate_pages-add-success-return mm/migrate.c
> --- a/mm/migrate.c~migrate_pages-add-success-return	2020-08-18 11:36:51.284583183 -0700
> +++ b/mm/migrate.c	2020-08-18 11:36:51.295583183 -0700
> @@ -1432,6 +1432,7 @@ out:
>   * @mode:		The migration mode that specifies the constraints for
>   *			page migration, if any.
>   * @reason:		The reason for page migration.
> + * @nr_succeeded:	The number of pages migrated successfully.
>   *
>   * The function returns after 10 attempts or if no pages are movable any more
>   * because the list has become empty or no retryable pages exist any more.
> @@ -1442,11 +1443,10 @@ out:
>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		free_page_t put_new_page, unsigned long private,
> -		enum migrate_mode mode, int reason)
> +		enum migrate_mode mode, int reason, unsigned int *nr_succeeded)
>  {
>  	int retry = 1;
>  	int nr_failed = 0;
> -	int nr_succeeded = 0;
>  	int pass = 0;
>  	struct page *page;
>  	struct page *page2;
> @@ -1500,7 +1500,7 @@ retry:
>  				retry++;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> -				nr_succeeded++;
> +				(*nr_succeeded)++;

I think now we should consider THP in counting now.  Because later
nr_succeeded will be used to counting the number of reclaimed pages,
and THP is respected for that.

Best Regards,
Huang, Ying

>  				break;
>  			default:
>  				/*
> @@ -1517,11 +1517,11 @@ retry:
>  	nr_failed += retry;
>  	rc = nr_failed;
>  out:
> -	if (nr_succeeded)
> -		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> +	if (*nr_succeeded)
> +		count_vm_events(PGMIGRATE_SUCCESS, *nr_succeeded);
>  	if (nr_failed)
>  		count_vm_events(PGMIGRATE_FAIL, nr_failed);
> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
> +	trace_mm_migrate_pages(*nr_succeeded, nr_failed, mode, reason);
>  
>  	if (!swapwrite)
>  		current->flags &= ~PF_SWAPWRITE;
