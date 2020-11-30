Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090C32C8F15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbgK3UYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:24:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387451AbgK3UYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:24:45 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 452A72073C;
        Mon, 30 Nov 2020 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606767838;
        bh=HTJqRVsgfUeZtj17KLMMjxYqtajqMkjp6XIIbCE7RzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uZKCv7OKfKjj9GaHvFseeYGnE+4o99b5bUcQNnGXPIyV1d6EH5yU83QKsZcxJVcIc
         /Xv+JeTtQiib1dDMBFhmAKp5hxB+jfqYfQULCCPJTPGRiN6ud7Gv2Z8HlWUuPCNpF5
         Ub4CJ+kZKkgKooyz7fQT+D1CKLJDPQLCN0AsZ0eg=
Date:   Mon, 30 Nov 2020 12:23:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alex.shi@linux.alibaba.com, alexander.h.duyck@linux.intel.com,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [External] Re: [PATCH] mm/memcg: fix NULL pointer dereference
 at workingset_eviction
Message-Id: <20201130122357.cadd134cbad3130abfce618d@linux-foundation.org>
In-Reply-To: <eab0b852-9f62-5fc3-6a2f-aae358bc3a98@suse.cz>
References: <20201130131512.6043-1-songmuchun@bytedance.com>
        <20201130132345.GJ17338@dhcp22.suse.cz>
        <CAMZfGtWSLeiNcPYaAnOyv_fy9_rxHn0kA2Vzn=i+B8ngc61_4Q@mail.gmail.com>
        <20201130134514.GL17338@dhcp22.suse.cz>
        <eab0b852-9f62-5fc3-6a2f-aae358bc3a98@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 16:57:37 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/30/20 2:45 PM, Michal Hocko wrote:
> > On Mon 30-11-20 21:36:49, Muchun Song wrote:
> >> On Mon, Nov 30, 2020 at 9:23 PM Michal Hocko <mhocko@suse.com> wrote:
> >> >
> >> > On Mon 30-11-20 21:15:12, Muchun Song wrote:
> >> > > We found a case of kernel panic. The stack trace is as follows
> >> > > (omit some irrelevant information):
> >> > >
> >> > >     BUG: kernel NULL pointer dereference, address: 00000000000000c8
> >> > >     RIP: 0010:workingset_eviction+0x26b/0x450
> >> > >     Call Trace:
> >> > >      __remove_mapping+0x224/0x2b0
> >> > >      shrink_page_list+0x8c2/0x14e0
> >> > >      shrink_inactive_list+0x1bf/0x3f0
> >> > >      ? do_raw_spin_unlock+0x49/0xc0
> >> > >      ? _raw_spin_unlock+0xa/0x20
> >> > >      shrink_lruvec+0x401/0x640
> >> > >
> >> > > This was caused by commit 76761ffa9ea1 ("mm/memcg: bail out early when
> >> > > !memcg in mem_cgroup_lruvec"). When the parameter of memcg is NULL, we
> >> > > should not use the &pgdat->__lruvec. So this just reverts commit
> >> > > 76761ffa9ea1 to fix it.
> >> > >
> >> > > Fixes: 76761ffa9ea1 ("mm/memcg: bail out early when !memcg in mem_cgroup_lruvec")
> >> >
> >> > I do not see any commits like that in the current Linus tree. Is this a
> >> > commit id from the linux-next? If yes, can we just fold it into the
> >> > respective patch in mmotm tree please?
> >> 
> >> Yes. This commit is on the linux-next tree.
> > 
> > FYI, patches coming from mmotm are constantly rebased in linux-next so
> > the sha1 is meaningless and shouldn't be added as a reference in the
> > changelog.
> > 
> >> Of course can.
> > 
> > Thanks! I believe Andrew should be able to just pick up the patch and
> > make it -fix patch.
> 
> Well the fix is a revert, so just remove the patch from mmotm/next?
> BTW, looks like it wasn't sent to linux-mm [1], looks like missing To: header.
> 
> [1] 
> https://lore.kernel.org/lkml/1606446515-36069-1-git-send-email-alex.shi@linux.alibaba.com/

Yes, I've dropped "mm/memcg: bail out early when !memcg in
mem_cgroup_lruvec", thanks.

