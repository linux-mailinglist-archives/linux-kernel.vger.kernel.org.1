Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC12CF11F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbgLDPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgLDPtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:49:04 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB59C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 07:48:17 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so5786943qkq.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nwbnY1/AV2FFPs1NQO0btBf2+S5LCFRr1hUU4wSaSQQ=;
        b=hCSiWy3HwYppo4VxA8ax1Gw1Vky5CN2uyplFnDzpqV5sUx45gMT5u+D0dKhPJ24uif
         kIt5r7osKzB/LNSMvClSCCCssvQzyFWpZQv3zDXaOEQ+TAgDUgVWwAG5Oce2rARebo/d
         vQURlgZ1gSdu9kqPR5StVTkj0ZweBohSOI7GmsAVPmNQA381cNF36vu69Rx274gnYPcT
         wv6jNjFjq+av4h9y9xgXEd9gJeMEhxlBtk/aK85wocMiN3/bu3/3pGxuv8ngHrADpn9L
         il4t1Kuv5lvozpqGBjLp80sk0hh4vVAU/asrOM38P16qlOEXKmQrDaSAydzjpZzXaHDo
         N8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nwbnY1/AV2FFPs1NQO0btBf2+S5LCFRr1hUU4wSaSQQ=;
        b=XjAhRt/CXFYafgBr467YuiLelEoKIHhtHwSFwc7VVJA6akSSFSx2cBR2BaSqtOGwUz
         dofY2/FnbkDRHDPCueW3IEm9g+ErQiBl//cL64c3t/pyo8c0vs0/JywLlYRGMFNKYLYB
         w53CeZmni9OgV/rVtD94jkh8BogTrhWnpaokqYNKn99+gVZHA3CuNET6F5vRsEx0Zc0r
         4WDj3OQg7Tz1+72kOUXXu7RVlkg3NhEhPXHWVajcXRYjsU/1Bipj2Modsd+PJJqGveFH
         sk+KODZ3OMkftWyh6jgEVbGZZUUOWg8+2VEUWbWjBRtgnc/dNuIruTU0H9ooKAq5XnUh
         77uA==
X-Gm-Message-State: AOAM532KYJ1QxhCkVXMN6igVwe+u3OssvFD4fZjgomyXFX+qwPn2yIUd
        cGNcxB+QcPN76VRBbJZFA5XeYg==
X-Google-Smtp-Source: ABdhPJxZFIK3nn3G4ETckmaEhVgiyEWH/TFZK8Hci3TIRjQKM3LGbZ/qCwehoOQoWqjgaO7ap1vnWA==
X-Received: by 2002:a05:620a:8d9:: with SMTP id z25mr146661qkz.127.1607096897156;
        Fri, 04 Dec 2020 07:48:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a180])
        by smtp.gmail.com with ESMTPSA id o23sm5340401qkk.84.2020.12.04.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:48:16 -0800 (PST)
Date:   Fri, 4 Dec 2020 10:46:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2] mm/memcontrol: make the slab calculation consistent
Message-ID: <20201204154613.GA176901@cmpxchg.org>
References: <20201203031111.3187-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203031111.3187-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:11:11AM +0800, Muchun Song wrote:
> Although the ratio of the slab is one, we also should read the ratio
> from the related memory_stats instead of hard-coding. And the local
> variable of size is already the value of slab_unreclaimable. So we
> do not need to read again. Simplify the code here.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

I agree that ignoring the ratio right now is not very pretty, but

		size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
		       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
		seq_buf_printf(&s, "slab %llu\n", size);

is way easier to understand and more robust than using idx and idx + 1
and then requiring a series of BUG_ONs to ensure these two items are
actually adjacent and in the right order.

There is a redundant call to memcg_page_state(), granted, but that
function is extremely cheap compared with e.g. seq_buf_printf().

>  mm/memcontrol.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

IMO this really just complicates the code with little discernible
upside. It's going to be a NAK from me, unfortunately.


In retrospect, I think that memory_stats[] table was a mistake. It
would probably be easier to implement this using a wrapper for
memcg_page_state() that has a big switch() for unit
conversion. Something like this:

/* Translate stat items to the correct unit for memory.stat output */
static unsigned long memcg_page_state_output(memcg, item)
{
	unsigned long value = memcg_page_state(memcg, item);
	int unit = PAGE_SIZE;

	switch (item) {
	case NR_SLAB_RECLAIMABLE_B:
	case NR_SLAB_UNRECLAIMABLE_B:
	case WORKINGSET_REFAULT_ANON:
	case WORKINGSET_REFAULT_FILE:
	case WORKINGSET_ACTIVATE_ANON:
	case WORKINGSET_ACTIVATE_FILE:
	case WORKINGSET_RESTORE_ANON:
	case WORKINGSET_RESTORE_FILE:
	case MEMCG_PERCPU_B:
		unit = 1;
		break;
	case NR_SHMEM_THPS:
	case NR_FILE_THPS:
	case NR_ANON_THPS:
		unit = HPAGE_PMD_SIZE;
		break;
	case NR_KERNEL_STACK_KB:
		unit = 1024;
		break;
	}
	
	return value * unit;
}

This would fix the ratio inconsistency, get rid of the awkward mix of
static and runtime initialization of the table, is probably about the
same amount of code, but simpler and more obvious overall.
