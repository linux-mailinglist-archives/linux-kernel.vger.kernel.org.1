Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDE8280F42
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJBIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:51:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:41404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBIva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:51:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E871EAC4D;
        Fri,  2 Oct 2020 08:51:28 +0000 (UTC)
Subject: Re: Linux 5.9-rc7 / VmallocTotal wrongly reported
To:     Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bastian Bittorf <bb@npl.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
References: <20201001065104.apevlkqrs6nid3r5@hp-nas.internet>
 <CAHk-=wixd9kUup4o1d1y9Wg9WoRt6_mN7kM5sPX=_nrgrkZzFg@mail.gmail.com>
 <20201001195610.GC2706729@carbon.DHCP.thefacebook.com>
 <CAHk-=whwbrbZbdqpXVd9LOG=J04BEVZcT+vT=nXry=XP1JWqYA@mail.gmail.com>
 <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9de0c0d4-15ac-bb7f-755b-849433da5ba4@suse.cz>
Date:   Fri, 2 Oct 2020 10:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 10:39 PM, Roman Gushchin wrote:
> On Thu, Oct 01, 2020 at 12:58:36PM -0700, Linus Torvalds wrote:
>> On Thu, Oct 1, 2020 at 12:56 PM Roman Gushchin <guro@fb.com> wrote:
>> >
>> > Bastian, can you, please, share your config?
>> 
>> Bastian actually did that in the original email, but that was only
>> sent to me and Andrew in private.
>> 
>> Here's that config replicated for your pleasure,
> 
> Thank you!
> 
>> 
>> #
>> # Processor type and features
>> #
>> # CONFIG_ZONE_DMA is not set
>> # CONFIG_SMP is not set
> 
> Yes, here is the deal.
> 
> The SMP-version of __mod_node_page_state() converts a passed value from bytes
> to pages, but the non-SMP doesn't.
> 
> Thanks!
> 
> 
> --
> 
> From 3d0233b37340c78012b991d3570b92f91cf5ebd2 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Thu, 1 Oct 2020 13:07:49 -0700
> Subject: [PATCH] mm: memcg/slab: fix slab statistics in !SMP configuration
> 
> Since ea426c2a7de8 ("mm: memcg: prepare for byte-sized vmstat items")
> the write side of slab counters accepts a value in bytes and converts
> it to pages. It happens in __mod_node_page_state().
> 
> However a non-SMP version of __mod_node_page_state() doesn't perform
> this conversion. It leads to incorrect (unrealistically high) slab
> counters values. Fix this by adding a similar conversion to the
> non-SMP version of __mod_node_page_state().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Bastian Bittorf <bb@npl.de>
> Fixes: ea426c2a7de8 ("mm: memcg: prepare for byte-sized vmstat items")

Acked-by: Vlastimil Babka <vbabka@suse.cz>

For consistency we could also duplicate the
"VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));" in !SMP variants of
__inc_node_state() and __dec_node_state(), but that's not urgent, and perhaps
SMP configs are enough to catch any bugs introduced in the future in this area...

> ---
>  include/linux/vmstat.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index d5431c1bf6e5..322dcbfcc933 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -312,6 +312,11 @@ static inline void __mod_zone_page_state(struct zone *zone,
>  static inline void __mod_node_page_state(struct pglist_data *pgdat,
>  			enum node_stat_item item, int delta)
>  {
> +	if (vmstat_item_in_bytes(item)) {
> +		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> +		delta >>= PAGE_SHIFT;
> +	}
> +
>  	node_page_state_add(delta, pgdat, item);
>  }
>  
> 

