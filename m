Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10A72C85D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgK3NqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:46:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:59048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgK3NqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:46:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606743916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojz128YKCFFdep4BZ1CKiek73Rh9QqjkeI5UTEAWsaU=;
        b=u3W3A8Fp0+LbKmcZkVQ1RUx7GMVkKRXUOXnLgnsSy8R94josJSpaRQJZOZo3/Kkf4HOFNM
        Wxpl4bJFzTp56sY1+WoLhhhtRqb6xQw3FHyUeFJ3qfuN6JyyFHYC1EEv1xUEm/dox+Xw/q
        ifH/OdlBxixoWcAMfZtIA0FMVjoWRM4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39379ABD2;
        Mon, 30 Nov 2020 13:45:16 +0000 (UTC)
Date:   Mon, 30 Nov 2020 14:45:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alex.shi@linux.alibaba.com, alexander.h.duyck@linux.intel.com,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH] mm/memcg: fix NULL pointer dereference at
 workingset_eviction
Message-ID: <20201130134514.GL17338@dhcp22.suse.cz>
References: <20201130131512.6043-1-songmuchun@bytedance.com>
 <20201130132345.GJ17338@dhcp22.suse.cz>
 <CAMZfGtWSLeiNcPYaAnOyv_fy9_rxHn0kA2Vzn=i+B8ngc61_4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWSLeiNcPYaAnOyv_fy9_rxHn0kA2Vzn=i+B8ngc61_4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-11-20 21:36:49, Muchun Song wrote:
> On Mon, Nov 30, 2020 at 9:23 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 30-11-20 21:15:12, Muchun Song wrote:
> > > We found a case of kernel panic. The stack trace is as follows
> > > (omit some irrelevant information):
> > >
> > >     BUG: kernel NULL pointer dereference, address: 00000000000000c8
> > >     RIP: 0010:workingset_eviction+0x26b/0x450
> > >     Call Trace:
> > >      __remove_mapping+0x224/0x2b0
> > >      shrink_page_list+0x8c2/0x14e0
> > >      shrink_inactive_list+0x1bf/0x3f0
> > >      ? do_raw_spin_unlock+0x49/0xc0
> > >      ? _raw_spin_unlock+0xa/0x20
> > >      shrink_lruvec+0x401/0x640
> > >
> > > This was caused by commit 76761ffa9ea1 ("mm/memcg: bail out early when
> > > !memcg in mem_cgroup_lruvec"). When the parameter of memcg is NULL, we
> > > should not use the &pgdat->__lruvec. So this just reverts commit
> > > 76761ffa9ea1 to fix it.
> > >
> > > Fixes: 76761ffa9ea1 ("mm/memcg: bail out early when !memcg in mem_cgroup_lruvec")
> >
> > I do not see any commits like that in the current Linus tree. Is this a
> > commit id from the linux-next? If yes, can we just fold it into the
> > respective patch in mmotm tree please?
> 
> Yes. This commit is on the linux-next tree.

FYI, patches coming from mmotm are constantly rebased in linux-next so
the sha1 is meaningless and shouldn't be added as a reference in the
changelog.

> Of course can.

Thanks! I believe Andrew should be able to just pick up the patch and
make it -fix patch.

-- 
Michal Hocko
SUSE Labs
