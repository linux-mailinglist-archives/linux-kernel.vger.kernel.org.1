Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1727E2CF318
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgLDR0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:26:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:60776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbgLDR0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:26:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 316DFAD20;
        Fri,  4 Dec 2020 17:25:32 +0000 (UTC)
Subject: Re: [PATCH 3/7] mm,madvise: call soft_offline_page() without
 MF_COUNT_INCREASED
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-4-osalvador@suse.de>
 <2aa4bf71-443b-9b9b-b761-12761263dfec@suse.cz> <20201201113511.GA22242@linux>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <840d4669-ae3f-b7c4-6132-e20d1bf9e952@suse.cz>
Date:   Fri, 4 Dec 2020 18:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201113511.GA22242@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 12:35 PM, Oscar Salvador wrote:
> On Wed, Nov 25, 2020 at 07:20:33PM +0100, Vlastimil Babka wrote:
>> On 11/19/20 11:57 AM, Oscar Salvador wrote:
>> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> > 
>> > The call to get_user_pages_fast is only to get the pointer to a struct
>> > page of a given address, pinning it is memory-poisoning handler's job,
>> > so drop the refcount grabbed by get_user_pages_fast().
>> > 
>> > Note that the target page is still pinned after this put_page() because
>> > the current process should have refcount from mapping.
>> 
>> Well, but can't it go away due to reclaim, migration or whatever?
> 
> Yes, it can.
> 
>> > @@ -900,20 +900,23 @@ static int madvise_inject_error(int behavior,
>> >   		 */
>> >   		size = page_size(compound_head(page));
>> > +		/*
>> > +		 * The get_user_pages_fast() is just to get the pfn of the
>> > +		 * given address, and the refcount has nothing to do with
>> > +		 * what we try to test, so it should be released immediately.
>> > +		 * This is racy but it's intended because the real hardware
>> > +		 * errors could happen at any moment and memory error handlers
>> > +		 * must properly handle the race.
>> 
>> Sure they have to. We might just be unexpectedly messing with other process'
>> memory. Or does anything else prevent that?
> 
> No, nothing does, and I have to confess that I managed to confuse myself here.
> If we release such page and that page ends up in buddy, nothing prevents someone
> else to get that page, and then we would be messing with other process memory.
> 
> I guess the right thing to do is just to make sure we got that page and that
> that page remains pinned as long as the memory failure handling goes.

OK, so that means we don't introduce this race for MADV_SOFT_OFFLINE, but it's
already (and still) there for MADV_HWPOISON since Dan's 23e7b5c2e271 ("mm,
madvise_inject_error: Let memory_failure() optionally take a page reference") no?

> I will remove those patches from the patchset and re-submit with only the
> refactoring and pcp-disabling.
> 
> Thanks Vlastimil
> 

