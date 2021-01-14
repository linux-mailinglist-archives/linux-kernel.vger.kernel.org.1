Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38162F5D65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbhANJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:28:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:60614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbhANJ2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:28:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8FA2B27D;
        Thu, 14 Jan 2021 09:27:40 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: SLUB: percpu partial object count is highly inaccurate, causing some
 memory wastage and maybe also worse tail latencies?
To:     Christoph Lameter <cl@linux.com>, Jann Horn <jannh@google.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
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
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
 <alpine.DEB.2.22.394.2101121627490.20570@www.lameter.com>
Message-ID: <e4d89d4f-62d4-43e3-9dd7-2496e955b437@suse.cz>
Date:   Thu, 14 Jan 2021 10:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2101121627490.20570@www.lameter.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 5:35 PM, Christoph Lameter wrote:
> On Tue, 12 Jan 2021, Jann Horn wrote:
> 
>> [This is not something I intend to work on myself. But since I
>> stumbled over this issue, I figured I should at least document/report
>> it, in case anyone is willing to pick it up.]
> 
> Well yeah all true. There is however a slabinfo tool that has an -s option
> to shrink all slabs.
> 
> 	slabinfo -s
> 
> So you could put that somewhere that executes if the system is
> idle or put it into cron or so.

Hm this would be similar to recommending a periodical echo > drop_caches
operation. We actually discourage from that (and yeah, some tools do that, and
we now report those in dmesg). I believe the kernel should respond to memory
pressure and not OOM prematurely by itself, including SLUB.
