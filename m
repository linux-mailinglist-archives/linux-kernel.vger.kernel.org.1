Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE92C60A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405362AbgK0HwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:52:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:55658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392782AbgK0HwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:52:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606463535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dv338FZywGqGP/dCr519csJ4GRHLbufPxoxUCPl8E0E=;
        b=m276pUsuAkFOuJ+rOcffnleR3l126vOOLZcm8JOk1O9J6DGquPKwgvru4d66ATO1lvnTKE
        Z8Rqvmp+s/krb+Hm07ZcyIB1Fsj+qQeJPdxNbe0AwGac6mQYtbbRXDH1bunjQur6mLAdFY
        WxzDjwvP/UMy6P+ZdWlTtJE+bhBNxzo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 632D5AC2F;
        Fri, 27 Nov 2020 07:52:15 +0000 (UTC)
Date:   Fri, 27 Nov 2020 08:52:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Subject: Re: [PATCH 2/3] mm,thp,shm: limit gfp mask to no more than specified
Message-ID: <20201127075214.GK31550@dhcp22.suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
 <20201124194925.623931-3-riel@surriel.com>
 <20201126134034.GI31550@dhcp22.suse.cz>
 <920c627330f3c7d295ab58edd1b62f28fdbd14bc.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920c627330f3c7d295ab58edd1b62f28fdbd14bc.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-11-20 13:04:14, Rik van Riel wrote:
> On Thu, 2020-11-26 at 14:40 +0100, Michal Hocko wrote:
> > On Tue 24-11-20 14:49:24, Rik van Riel wrote:
> > > Matthew Wilcox pointed out that the i915 driver opportunistically
> > > allocates tmpfs memory, but will happily reclaim some of its
> > > pool if no memory is available.
> > > 
> > > Make sure the gfp mask used to opportunistically allocate a THP
> > > is always at least as restrictive as the original gfp mask.
> > 
> > I have brought this up in the previous version review and I feel my
> > feedback hasn't been addressed. Please describe the expected behavior
> > by
> > those shmem users including GFP_KERNEL restriction which would make
> > the
> > THP flags incompatible. Is this a problem? Is there any actual
> > problem
> > if the THP uses its own set of flags?
> 
> In the case of i915, the gfp flags passed in by the i915
> driver expect the VM to easily fail the allocation, in
> which case the i915 driver will reclaim some existing
> buffers and try again.

The existing code tries hard to prevent from the oom killer AFAIU.
At least that is what i915_gem_object_get_pages_gtt says. And that is
ok for order-0 (or low order) requests. But THPs are costly orders and
therefore __GFP_NORETRY has a different meaning. It still controls how
hard to try compact but this is not a OOM control. ttm_tt_swapout is
similar except it chosen to try harder for order-0 cases but still want
to prevent the oom killer. 

> Trying harder than the original gfp_mask would change the OOM behavior
> of systems using the i915 driver.
> 
> > I am also not happy how those two sets of flags are completely
> > detached
> > and we can only expect surprises there. 
> 
> I would be more than happy to implement things differently,
> but I am not sure what alternative you are suggesting.

Simply do not alter gfp flags? Or warn in some cases of a serious mismatch.
E.g. GFP_ZONEMASK mismatch because there are already GFP_KERNEL users of
shmem.

-- 
Michal Hocko
SUSE Labs
