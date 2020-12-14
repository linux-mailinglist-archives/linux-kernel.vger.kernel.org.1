Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF82D9964
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408082AbgLNOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:04:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:56586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbgLNOEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:04:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607954619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQdxKLHG4KjlshDHSNjNPPhYXulApwPDLbssolkNoJc=;
        b=L9W6oCEnlei941fAO1yaDiBi6ShMzHnjLWPYxRNiO8oW6mgu9B+R/YTld8mjdQ8fkNR9id
        4lA2Ww+eln8GMpgkgtQnTSspzwujFVpahvAxsfhxjSDa+hoARP92giv+dgs+h1Bd9LAQKj
        Bd9eQerASJ3qrOz4Veqr3i70vvChixc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF3A1AEA2;
        Mon, 14 Dec 2020 14:03:38 +0000 (UTC)
Date:   Mon, 14 Dec 2020 15:03:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        osalvador@suse.de, dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mm cma: rename PF_MEMALLOC_NOCMA to
 PF_MEMALLOC_PIN
Message-ID: <20201214140337.GD32193@dhcp22.suse.cz>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211202140.396852-3-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-12-20 15:21:36, Pavel Tatashin wrote:
> PF_MEMALLOC_NOCMA is used ot guarantee that the allocator will not return
> pages that might belong to CMA region. This is currently used for long
> term gup to make sure that such pins are not going to be done on any CMA
> pages.
> 
> When PF_MEMALLOC_NOCMA has been introduced we haven't realized that it is
> focusing on CMA pages too much and that there is larger class of pages that
> need the same treatment. MOVABLE zone cannot contain any long term pins as
> well so it makes sense to reuse and redefine this flag for that usecase as
> well. Rename the flag to PF_MEMALLOC_PIN which defines an allocation
> context which can only get pages suitable for long-term pins.
> 
> Also re-name:
> memalloc_nocma_save()/memalloc_nocma_restore
> to
> memalloc_pin_save()/memalloc_pin_restore()
> and make the new functions common.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Michal Hocko <mhocko@suse.com>

with one comment below
[...]
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1576,7 +1576,7 @@ extern struct pid *cad_pid;
>  #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
> -#define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
> +#define PF_MEMALLOC_PIN		0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */

This comment is not really helpeful. I would go with
/* Allocation context constrained to zones which allow long term
 * pinning.
 */

Something similar would be useful for memalloc_pin* functions as well.
-- 
Michal Hocko
SUSE Labs
