Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C22FA7BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407083AbhARRm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:42:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:33290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407199AbhARRl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:41:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96710AFEF;
        Mon, 18 Jan 2021 17:41:13 +0000 (UTC)
Subject: Re: [PATCH V3] mm/compaction: correct deferral logic for proactive
 compaction
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, mhocko@suse.com, khalid.aziz@oracle.com,
        ngupta@nitingupta.dev, vinmenon@codeaurora.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1610989938-31374-1-git-send-email-charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <dfedd14c-01a3-75f7-c180-74b74c120da3@suse.cz>
Date:   Mon, 18 Jan 2021 18:41:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1610989938-31374-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 6:12 PM, Charan Teja Reddy wrote:
> should_proactive_compact_node() returns true when sum of the
> weighted fragmentation score of all the zones in the node is greater
> than the wmark_high of compaction, which then triggers the proactive
> compaction that operates on the individual zones of the node. But
> proactive compaction runs on the zone only when its weighted
> fragmentation score is greater than wmark_low(=wmark_high - 10).
> 
> This means that the sum of the weighted fragmentation scores of all the
> zones can exceed the wmark_high but individual weighted fragmentation
> zone scores can still be less than wmark_low which makes the unnecessary
> trigger of the proactive compaction only to return doing nothing.
> 
> Issue with the return of proactive compaction with out even trying is
> its deferral. It is simply deferred for 1 << COMPACT_MAX_DEFER_SHIFT if
> the scores across the proactive compaction is same, thinking that
> compaction didn't make any progress but in reality it didn't even try.
> With the delay between successive retries for proactive compaction is
> 500msec, it can result into the deferral for ~30sec with out even trying
> the proactive compaction.
> 
> Test scenario is that: compaction_proactiveness=50 thus the wmark_low =
> 50 and wmark_high = 60. System have 2 zones(Normal and Movable) with
> sizes 5GB and 6GB respectively. After opening some apps on the android,
> the weighted fragmentation scores of these zones are 47 and 49
> respectively. Since the sum of these fragmentation scores are above the
> wmark_high which triggers the proactive compaction and there since the
> individual zones weighted fragmentation scores are below wmark_low, it
> returns without trying the proactive compaction. As a result the
> weighted fragmentation scores of the zones are still 47 and 49 which
> makes the existing logic to defer the compaction thinking that
> noprogress is made across the compaction.
> 
> Fix this by checking just zone fragmentation score, not the weighted, in
> __compact_finished() and use the zones weighted fragmentation score in
> fragmentation_score_node(). In the test case above, If the weighted
> average of is above wmark_high, then individual score (not adjusted) of
> atleast one zone has to be above wmark_high. Thus it avoids the
> unnecessary trigger and deferrals of the proactive compaction.
> 
> Fix-suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Thanks!
