Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF02FCFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbhATLky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:40:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:41800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388839AbhATLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:05:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA644AC63;
        Wed, 20 Jan 2021 11:04:45 +0000 (UTC)
To:     David Rientjes <rientjes@google.com>,
        Charan Teja Reddy <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, khalid.aziz@oracle.com,
        ngupta@nitingupta.dev, vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1610989938-31374-1-git-send-email-charante@codeaurora.org>
 <af22a056-5c27-256f-74d-63de8fd33084@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH V3] mm/compaction: correct deferral logic for proactive
 compaction
Message-ID: <80a1a433-c520-4c73-61ce-55cf33739fc5@suse.cz>
Date:   Wed, 20 Jan 2021 12:04:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <af22a056-5c27-256f-74d-63de8fd33084@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 8:26 PM, David Rientjes wrote:
> On Mon, 18 Jan 2021, Charan Teja Reddy wrote:
> 
>> should_proactive_compact_node() returns true when sum of the
>> weighted fragmentation score of all the zones in the node is greater
>> than the wmark_high of compaction, which then triggers the proactive
>> compaction that operates on the individual zones of the node. But
>> proactive compaction runs on the zone only when its weighted
>> fragmentation score is greater than wmark_low(=wmark_high - 10).
>> 
>> This means that the sum of the weighted fragmentation scores of all the
>> zones can exceed the wmark_high but individual weighted fragmentation
>> zone scores can still be less than wmark_low which makes the unnecessary
>> trigger of the proactive compaction only to return doing nothing.
>> 
>> Issue with the return of proactive compaction with out even trying is
>> its deferral. It is simply deferred for 1 << COMPACT_MAX_DEFER_SHIFT if
>> the scores across the proactive compaction is same, thinking that
>> compaction didn't make any progress but in reality it didn't even try.
> 
> Isn't this an issue in deferred compaction as well?  It seems like 
> deferred compaction should check that work was actually performed before 
> deferring subsequent calls to compaction.

Direct compaction does, proactive not.

> In other words, I don't believe deferred compaction is intended to avoid 
> checks to determine if compaction is worth it; it should only defer 
> *additional* work that was not productive.

Yeah, that should be more optimal.

> Thoughts?
> 

