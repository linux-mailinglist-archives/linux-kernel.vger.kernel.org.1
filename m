Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9152ECEFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbhAGLsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:48:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbhAGLsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:48:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610020087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JGT2RjyddglUzk1Kg1KO4LzQvdRbbltQQiFhAYsVZVI=;
        b=GorHO5qIJXlyUVjnDS3n3lmLcO4FziOHTsPQFjVQ1C6OZnFyTU8UWW+MgsNgTvgpdrjLnI
        41sIVsnCh+T8tgjg3VJq0DscgryqBLTKVDxa7bidrMtYAzy8Zrkj7R3CM71Ni3sKSqDP3x
        iBiJJ57c7mVrEaqh9XgJ5kdEr85W1CI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73E5EAD12;
        Thu,  7 Jan 2021 11:48:07 +0000 (UTC)
Date:   Thu, 7 Jan 2021 12:48:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/6] mm: migrate: do not migrate
 HugeTLB page whose refcount is one
Message-ID: <20210107114806.GI13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-2-songmuchun@bytedance.com>
 <20210106161327.GR13207@dhcp22.suse.cz>
 <CAMZfGtUTkeeswiS8M1aq67JXztrjQwzqd0aZ9cgvgPZEEQQPEQ@mail.gmail.com>
 <20210107111642.GF13207@dhcp22.suse.cz>
 <CAMZfGtULi=E5pNoLciaedGfNpSdopzyOzFhnzALf+nCciFRUPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtULi=E5pNoLciaedGfNpSdopzyOzFhnzALf+nCciFRUPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-01-21 19:24:59, Muchun Song wrote:
> On Thu, Jan 7, 2021 at 7:16 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 07-01-21 10:52:21, Muchun Song wrote:
> > > On Thu, Jan 7, 2021 at 12:13 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 06-01-21 16:47:34, Muchun Song wrote:
> > > > > If the refcount is one when it is migrated, it means that the page
> > > > > was freed from under us. So we are done and do not need to migrate.
> > > >
> > > > Is this common enough that it would warrant the explicit check for each
> > > > migration?
> > >
> > > Are you worried about the overhead caused by the check? Thanks.
> >
> > I am not as worried as I would like to see some actual justification for
> > this optimization.
> 
> OK. The HugeTLB page can be freed after it was isolated but before
> being migrated. Right? If we catch this case, it is an optimization.
> I do this just like unmap_and_move() does for a base page.

If your only justification is that this path to be consistent with the
regular pages then make it explicit in the changelog. Please think of
people reading this code in the future and scratching their heads
whether this is something that can be altered and fail to find the
reasoning. Was this a huge optimization and some workload might suffer?
Can this happen in the first place or how likely it is?

-- 
Michal Hocko
SUSE Labs
