Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC4268CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgINOJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:09:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgINNsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:48:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9250CB197;
        Mon, 14 Sep 2020 13:47:37 +0000 (UTC)
Date:   Mon, 14 Sep 2020 15:47:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Chunxin Zang <zangchunxin@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [External] Re: [PATCH v2] mm/vmscan: fix infinite loop in
 drop_slab_node
Message-ID: <20200914134713.GS16999@dhcp22.suse.cz>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
 <20200914093032.GG16999@dhcp22.suse.cz>
 <CAKRVAeP1yPDTcdcW+H6EnMrDHsWGNkooGcSyeYWHi8CXCc+u4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKRVAeP1yPDTcdcW+H6EnMrDHsWGNkooGcSyeYWHi8CXCc+u4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 21:25:59, Chunxin Zang wrote:
> On Mon, Sep 14, 2020 at 5:30 PM Michal Hocko <mhocko@suse.com> wrote:
> 
> > The subject is misleading because this patch doesn't fix an infinite
> > loop, right? It just allows the userspace to interrupt the operation.
> >
> >
> Yes,  so we are making a separate patch follow Vlastimil's recommendations.
> Use double of threshold to end the loop.

That still means the changelog needs an update
 
> On Thu, Sep 10, 2020 at 1:59 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > From: Chunxin Zang <zangchunxin@bytedance.com>
> > >
> > ...
> > - IMHO it's still worth to bail out in your scenario even without a
> > signal, e.g.
> > by the doubling of threshold. But it can be a separate patch.
> > Thanks!
> > ...
> 
> 
> 
> On Wed 09-09-20 23:20:47, zangchunxin@bytedance.com wrote:
> > > From: Chunxin Zang <zangchunxin@bytedance.com>
> > >
> > > On our server, there are about 10k memcg in one machine. They use memory
> > > very frequently. When I tigger drop caches，the process will infinite loop
> > > in drop_slab_node.
> >
> > Is this really an infinite loop, or it just takes a lot of time to
> > process all the metadata in that setup? If this is really an infinite
> > loop then we should look at it. My current understanding is that the
> > operation would finish at some time it just takes painfully long to get
> > there.
> >
> 
> Yes,  it's really an infinite loop.  Every loop spends a lot of time. In
> this time,
> memcg will alloc/free memory,  so the next loop, the total of  'freed'
> always bigger than 10.

I am still not sure I follow. Do you mean that there is somebody
constantly generating more objects to reclaim?
Maybe we are just not agreeing on the definition of an infinite loop but
in my book that means that the final condition can never be met. While a
busy adding new object might indeed cause drop caches to loop for a long
time this is to be expected from that interface as it is supposed to
drop all the cache and that can grow during the operation.
-- 
Michal Hocko
SUSE Labs
