Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9877A283CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgJEQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:56:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgJEQ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:56:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601917013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJvYds/wD1O5GvGho9OM+saELouoiP6YUhrMprYkKVw=;
        b=UXYAOqmyjGsMiq9yy7cAACto0hftLLoFY+YqsBV37MVrqnb+5noUWcCoMBajFhSoK2cNbX
        R6a+FEmKLEUgOUmG4DU82kG5FC/aiFo98tzbiiitvC58O3mf+n2rbPqTy0c/kz0TlfCVXP
        iJBUekiUeqxyvlcg7loqf8uLYvdq5LE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 406A9AB54;
        Mon,  5 Oct 2020 16:56:53 +0000 (UTC)
Date:   Mon, 5 Oct 2020 18:56:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 9/9] mm, page_alloc: optionally disable pcplists during
 page isolation
Message-ID: <20201005165651.GG4555@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-10-vbabka@suse.cz>
 <10cdae53-c64b-e371-1b83-01d1af7a131e@redhat.com>
 <e0ab17e9-6c05-cf32-9e2d-efbf011860a2@redhat.com>
 <2ce92f9a-eaa2-45b2-207c-46a79d6a2bde@suse.cz>
 <20201005140531.GE4555@dhcp22.suse.cz>
 <5ea97462-7924-e106-c486-2a0164ea27fb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea97462-7924-e106-c486-2a0164ea27fb@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-10-20 16:22:46, Vlastimil Babka wrote:
> On 10/5/20 4:05 PM, Michal Hocko wrote:
> > On Fri 25-09-20 13:10:05, Vlastimil Babka wrote:
> >> On 9/25/20 12:54 PM, David Hildenbrand wrote:
> >>
> >> Hmm that temporary write lock would still block new callers until previous
> >> finish with the downgraded-to-read lock.
> >>
> >> But I guess something like this would work:
> >>
> >> retry:
> >>   if (atomic_read(...) == 0) {
> >>     // zone_update... + drain
> >>     atomic_inc(...);
> >>   else if (atomic_inc_return == 1)
> >>     // atomic_cmpxchg from 0 to 1; if that fails, goto retry
> >>
> >> Tricky, but races could only read to unnecessary duplicated updates + flushing
> >> but nothing worse?
> >>
> >> Or add another spinlock to cover this part instead of the temp write lock...
> > 
> > Do you plan to post a new version or should I review this one?
> 
> I will, hopefully this week, but you could comment on other details and
> overall approach meanwhile? I don't think it will change significantly.

OK. I will have a look tomorrow.

-- 
Michal Hocko
SUSE Labs
