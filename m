Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61663240445
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 11:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHJJxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 05:53:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgHJJxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:53:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D3E7AD65;
        Mon, 10 Aug 2020 09:53:31 +0000 (UTC)
Date:   Mon, 10 Aug 2020 11:53:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: remove useless check on page->mem_cgroup
Message-ID: <20200810095310.GD4773@dhcp22.suse.cz>
References: <1596166480-22814-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200731151655.GB491801@cmpxchg.org>
 <9338716f-ca0e-057f-8d94-03e2b3f70281@linux.alibaba.com>
 <20200803081815.GD5174@dhcp22.suse.cz>
 <bd61e672-b997-c4cd-2047-fca9dc11cc4c@linux.alibaba.com>
 <92dd8e68-8095-72c5-0144-2a084e4d5993@linux.alibaba.com>
 <5622ef68-5e70-d1a9-d1be-b45411b6be5c@linux.alibaba.com>
 <20200810095201.GC4773@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810095201.GC4773@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-08-20 11:52:02, Michal Hocko wrote:
> On Wed 05-08-20 21:02:30, Alex Shi wrote:
> > 
> > 
> > 在 2020/8/5 下午8:28, Alex Shi 写道:
> > > The last patch has a problem on define. this version could fix it.
> > > 
> > > BTW, I see some !memcg happens when MEMCG compilered but disabled by cgroup_disable
> > > 
> > > 
> > > [   94.657666] ---[ end trace f1f34bfc3b32ed2f ]---
> > > [   95.138995] anon flags: 0x5005b48008000d(locked|uptodate|dirty|swapbacked)
> > > [   95.146220] raw: 005005b48008000d dead000000000100 dead000000000122 ffff8897c7c76ad1
> > > [   95.154549] raw: 0000000000000022 0000000000000000 0000000200000000 0000000000000000
> > > [   95.162876] page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
> > > 
> > > 
> > 
> > The following patch may helpful.
> > 
> > >From 8bfb26a2e37e08dc61d20212bcfa5812a367ba94 Mon Sep 17 00:00:00 2001
> > From: Alex Shi <alex.shi@linux.alibaba.com>
> > Date: Wed, 5 Aug 2020 20:32:12 +0800
> > Subject: [PATCH] mm/memcg: don't try charge swap if memcg disabled
> > 
> > If we disabled memcg by cgroup_disable=memory, the swap charges are
> > still called. Let's return from the funcs earlier and keep WARN_ON
> > monitor.
> 
> Do I get it right that this is on top of your patch to remove the memcg
> check or a preparatory work?

Sorry meant to say - add the warning rather than drop the check.

> Both are good but it would be better to
> call that out specifically for clarity (along with the warning if that
> is a follow up fix).
-- 
Michal Hocko
SUSE Labs
