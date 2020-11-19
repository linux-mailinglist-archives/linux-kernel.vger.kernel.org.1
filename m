Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BDC2B8F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgKSJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:37:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:55038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgKSJhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:37:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605778625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rvZpREnf2ZBqTsPqNdHkc6HulpfCj66OhqW0/gv6vro=;
        b=OHU/Nk7y4PKSF6tWK9/YtZd2KlJEkBtLlkagrl7IwAy6Fm4XXriExwpCgfaKeTIHGhSBpg
        F7NYujm25ZUKtUmRC4oDsf4okuLBLsKRbCodSySmEEhSvveCc8f6yQcOzKpPJitl2+fZs3
        nhm/G8eWul/7U/pWd81FmgxYohN2r9I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FF00AA4F;
        Thu, 19 Nov 2020 09:37:05 +0000 (UTC)
Date:   Thu, 19 Nov 2020 10:37:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Subject: Re: [PATCH 1/2] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201119093703.GB12284@dhcp22.suse.cz>
References: <20201105191508.1961686-1-riel@surriel.com>
 <20201105191508.1961686-2-riel@surriel.com>
 <20201112105258.GZ12240@dhcp22.suse.cz>
 <84effe90c3ee13fbfa6e732d2e3b3d9b557d1be1.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84effe90c3ee13fbfa6e732d2e3b3d9b557d1be1.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-11-20 22:44:20, Rik van Riel wrote:
> On Thu, 2020-11-12 at 11:52 +0100, Michal Hocko wrote:
> > On Thu 05-11-20 14:15:07, Rik van Riel wrote:
> > > 
> > > This patch applies the same configurated limitation of THPs to
> > > shmem
> > > hugepage allocations, to prevent that from happening.
> > 
> > I believe you should also exaplain why we want to control defrag by
> > the
> > global knob while the enable logic is per mount.
> 
> I added that to the changelog for the next version of
> the patches.
> 
> > > This way a THP defrag setting of "never" or "defer+madvise" will
> > > result
> > > in quick allocation failures without direct reclaim when no 2MB
> > > free
> > > pages are available.
> > > 
> > > With this patch applied, THP allocations for tmpfs will be a little
> > > more aggressive than today for files mmapped with MADV_HUGEPAGE,
> > > and a little less aggressive for files that are not mmapped or
> > > mapped without that flag.
> > 
> > This begs some numbers. A little is rather bad unit of performance. I
> > do
> > agree that unifying those makes sense in general though.
> 
> The aggressiveness is in changes to the gfp_mask, eg by
> adding __GFP_NORETRY. How that translates into THP
> allocation success rates is entirely dependent on the
> workload and on what else is in memory at the time.

Yes and that is why I would argue about consistency with THP rather than
put claims that hard to back by numbers.

-- 
Michal Hocko
SUSE Labs
