Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7382FA51E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405908AbhARPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:48:43 -0500
Received: from gentwo.org ([3.19.106.255]:52088 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405834AbhARPra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:47:30 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id DAB243F806; Mon, 18 Jan 2021 15:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id D7E153EB3B;
        Mon, 18 Jan 2021 15:46:43 +0000 (UTC)
Date:   Mon, 18 Jan 2021 15:46:43 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@suse.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
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
In-Reply-To: <20210118110319.GC14336@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.22.394.2101181537150.69690@www.lameter.com>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com> <alpine.DEB.2.22.394.2101121627490.20570@www.lameter.com> <e4d89d4f-62d4-43e3-9dd7-2496e955b437@suse.cz> <20210118110319.GC14336@dhcp22.suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021, Michal Hocko wrote:

> > Hm this would be similar to recommending a periodical echo > drop_caches
> > operation. We actually discourage from that (and yeah, some tools do that, and
> > we now report those in dmesg). I believe the kernel should respond to memory
> > pressure and not OOM prematurely by itself, including SLUB.
>
> Absolutely agreed! Partial caches are a very deep internal
> implementation detail of the allocator and admin has no bussiness into
> fiddling with that. This would only lead to more harm than good.
> Comparision to drop_caches is really exact!

Really? The maximum allocation here has a upper boundary that depends on
the number of possible partial per cpu slabs. There is a worst case
scenario that is not nice and wastes some memory but it is not an OOM
situation and the system easily recovers from it.

The slab shrinking is not needed but if you are concerned about reclaiming
more memory right now then I guess you may want to run the slab shrink
operation.

Dropping the page cache is bad? Well sometimes you want more free memory
due to a certain operation that needs to be started and where you do not
want the overhead of page cache processing.

You can go crazy and expect magical things from either operation. True.





