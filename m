Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954B9283797
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgJEOWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:22:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgJEOWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:22:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B877B50C;
        Mon,  5 Oct 2020 14:22:47 +0000 (UTC)
Subject: Re: [PATCH 9/9] mm, page_alloc: optionally disable pcplists during
 page isolation
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-10-vbabka@suse.cz>
 <10cdae53-c64b-e371-1b83-01d1af7a131e@redhat.com>
 <e0ab17e9-6c05-cf32-9e2d-efbf011860a2@redhat.com>
 <2ce92f9a-eaa2-45b2-207c-46a79d6a2bde@suse.cz>
 <20201005140531.GE4555@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5ea97462-7924-e106-c486-2a0164ea27fb@suse.cz>
Date:   Mon, 5 Oct 2020 16:22:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005140531.GE4555@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 4:05 PM, Michal Hocko wrote:
> On Fri 25-09-20 13:10:05, Vlastimil Babka wrote:
>> On 9/25/20 12:54 PM, David Hildenbrand wrote:
>>
>> Hmm that temporary write lock would still block new callers until previous
>> finish with the downgraded-to-read lock.
>>
>> But I guess something like this would work:
>>
>> retry:
>>   if (atomic_read(...) == 0) {
>>     // zone_update... + drain
>>     atomic_inc(...);
>>   else if (atomic_inc_return == 1)
>>     // atomic_cmpxchg from 0 to 1; if that fails, goto retry
>>
>> Tricky, but races could only read to unnecessary duplicated updates + flushing
>> but nothing worse?
>>
>> Or add another spinlock to cover this part instead of the temp write lock...
> 
> Do you plan to post a new version or should I review this one?

I will, hopefully this week, but you could comment on other details and
overall approach meanwhile? I don't think it will change significantly.

