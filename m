Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC4B300BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbhAVSsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbhAVSNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:13:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36AC623AA1;
        Fri, 22 Jan 2021 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611339135;
        bh=H6L86AoTyE/hqmip5biwOJIAV+COzy3z1pHTxe6CyKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOzCO5VcEuc+6C7UFnok8XLPyEJ2/Tq5ZFVSvPY+N6mWPSG1/zaluhDnCTdpM1jfx
         OOnJ2lZWbI7xBcU3gL+CPDN2WbA7I4eFr3e+LeJI075kWgB+NJtL5bw3nje1llmxXF
         aC6Rbiv6HFEnYG9BnIEyWvMDKCo9zdTLTD63s4UAbpWOSzkC3CiIpygK2GVOXX4DRJ
         CsANkW4CNVmJITDaNlpAoo7SYLF0MovPyE4SgYVmOLl2epMgnbvw1VqmwMleYCja6r
         erHqZsQZxhoVDp83eNVnXU0ryjL6ssuZU4qNd4o/1h6t56X5rEe0RMh+2GQKG4w4sK
         Ktk3bL7vGjysg==
Date:   Fri, 22 Jan 2021 20:12:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, lkp@intel.com
Subject: Re: [PATCH v5 0/5] mm: clean up names and parameters of
 memmap_init_xxxx functions
Message-ID: <20210122181209.GD6332@kernel.org>
References: <20210122135956.5946-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122135956.5946-1-bhe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 09:59:51PM +0800, Baoquan He wrote:
> This patchset is correcting inappropriate function names of
> memmap_init_xxx, and simplify parameters of functions in the code flow.
> And also fix a prototype warning reported by lkp.
> 
> This is based on the latest next/master.
> 
> V4 can be found here:
> https://lore.kernel.org/linux-mm/20210120045213.6571-1-bhe@redhat.com/
> 
> v4->v5:
>  - Add patch 1 into series which fixes a prototype warning from kernel
>    test robot. Then rebase the v4 patches on top of it.
> 
> v3->v4:
>  - Rebased patch 1, 2 on top of Mike's below new patch.
>    [PATCH v3 0/2] mm: fix initialization of struct page for holes in  memory layout
> 
>  - Move the code of renaming function parameter 'range_start_pfn' and local
>    variable 'range_end_pfn' of memmap_init() from patch 1 to patch 2
>    according to David's comment.
> 
>  - Use the reverse Christmas tree style to reorder the local variables
>    in memmap_init_zone() in patch 2 accodrding to David's comment.
> 
> Baoquan He (5):
>   mm: fix prototype warning from kernel test robot
>   mm: rename memmap_init() and memmap_init_zone()
>   mm: simplify parater of function memmap_init_zone()
>   mm: simplify parameter of setup_usemap()
>   mm: remove unneeded local variable in free_area_init_core

For the series:

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> 
>  arch/ia64/include/asm/pgtable.h |  6 -----
>  arch/ia64/mm/init.c             | 14 +++++-----
>  include/linux/mm.h              |  3 ++-
>  mm/memory_hotplug.c             |  2 +-
>  mm/page_alloc.c                 | 46 ++++++++++++++-------------------
>  5 files changed, 31 insertions(+), 40 deletions(-)
> 
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.
