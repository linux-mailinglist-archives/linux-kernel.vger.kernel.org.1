Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ADD2F9D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbhARLFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:05:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:60334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389870AbhARLEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:04:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610967801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5W00mM0W2ARkZcsvoX8bcZ7IgAD13G2pd2gzEzVBUvQ=;
        b=DQ/jFfa0hvY+5mY+nlNtharWGNqdVF2RL69jn57GiLFKG63Tci0B/zylHSGgQ3UjOYvYxU
        WVdNwMgP3qywcEgUX1Ihe0YrRSwlniEnZE1sbYfJRbnvkzNzqQUA2uzPG+yfuOMJsfJXeJ
        TS6pb4ZmNPsdBpU2aYqQfiyIrpdEKgk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA071ACF5;
        Mon, 18 Jan 2021 11:03:20 +0000 (UTC)
Date:   Mon, 18 Jan 2021 12:03:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>, Jann Horn <jannh@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: SLUB: percpu partial object count is highly inaccurate, causing
 some memory wastage and maybe also worse tail latencies?
Message-ID: <20210118110319.GC14336@dhcp22.suse.cz>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
 <alpine.DEB.2.22.394.2101121627490.20570@www.lameter.com>
 <e4d89d4f-62d4-43e3-9dd7-2496e955b437@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d89d4f-62d4-43e3-9dd7-2496e955b437@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-01-21 10:27:40, Vlastimil Babka wrote:
> On 1/12/21 5:35 PM, Christoph Lameter wrote:
> > On Tue, 12 Jan 2021, Jann Horn wrote:
> > 
> >> [This is not something I intend to work on myself. But since I
> >> stumbled over this issue, I figured I should at least document/report
> >> it, in case anyone is willing to pick it up.]
> > 
> > Well yeah all true. There is however a slabinfo tool that has an -s option
> > to shrink all slabs.
> > 
> > 	slabinfo -s
> > 
> > So you could put that somewhere that executes if the system is
> > idle or put it into cron or so.
> 
> Hm this would be similar to recommending a periodical echo > drop_caches
> operation. We actually discourage from that (and yeah, some tools do that, and
> we now report those in dmesg). I believe the kernel should respond to memory
> pressure and not OOM prematurely by itself, including SLUB.

Absolutely agreed! Partial caches are a very deep internal
implementation detail of the allocator and admin has no bussiness into
fiddling with that. This would only lead to more harm than good.
Comparision to drop_caches is really exact!

-- 
Michal Hocko
SUSE Labs
