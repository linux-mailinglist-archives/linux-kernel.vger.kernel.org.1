Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB71B26D5B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIQIIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:08:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:33874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgIQIH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:07:58 -0400
X-Greylist: delayed 823 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:07:58 EDT
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E01A8B1AA;
        Thu, 17 Sep 2020 07:54:15 +0000 (UTC)
Date:   Thu, 17 Sep 2020 09:53:58 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/madvise: Remove set but not used variable 'zone'
Message-ID: <20200917075354.GA27201@linux>
References: <20200917071757.1915501-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917071757.1915501-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:17:57PM +0800, Liu Shixin wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> mm/madvise.c: In function 'madvise_inject_error':
> mm/madvise.c:882:15: warning: unused variable 'zone' [-Wunused-variable]
> 
> After 4b63fdbe2b25 ("mm: remove the now-unnecessary mmget_still_valid()
> hack"), variable 'zone' is never used. Remove it to avoid build warning.

Hi Liu,

Andrew already fixed that in the mmotm tree.

Thanks anyway

> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/madvise.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 460e19d60ba3..94b9d17331b9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -879,7 +879,6 @@ static long madvise_remove(struct vm_area_struct *vma,
>  static int madvise_inject_error(int behavior,
>  		unsigned long start, unsigned long end)
>  {
> -	struct zone *zone;
>  	unsigned long size;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> -- 
> 2.25.1
> 
> 

-- 
Oscar Salvador
SUSE L3
