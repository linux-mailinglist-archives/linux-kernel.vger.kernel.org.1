Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE261266A32
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgIKVm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIKVm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:42:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66A8C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=g8BpUJdVHYsNXF6gHjO0GR/Q6nl0WaZJWgbbEoTmDZ4=; b=f0jQbWYkPJ7YmvRa7tWtj84l5I
        OaXeNIB+4QlkuEMHInuLhn1wzWCdF9z+y+OhaieTTYyZOodcdQgjxHYKsmhJdEYNOThsM18dkVw3X
        7sEXW9Rx5CDigMnOrrcFf0VHYuHXpeMWqfmPMx1bLdWbkO2uUCyFfXJiIrexqYuindc0VCiBK6okT
        m0XuFbroxdQYTT4HzYAx9MaAMDGVkzumaYoPMD+0M0abP6ymaZ4MDakzpUE+iOgO/AnCwi92Iu5GV
        nmGrMr29D11ABCDqO2QLNqTSmDD4/0+cpeFfCeJLWg/YAZxsmFfDy/2q4ifPxXlQ/iqAOknWtJm0/
        cywDoGgg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGqoJ-0003AM-Rd; Fri, 11 Sep 2020 21:42:24 +0000
Subject: Re: [PATCH v2] mm: cma: indefinitely retry allocations in cma_alloc
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     Vinayak Menon <vinmenon@codeaurora.org>
References: <1599857630-23714-1-git-send-email-cgoldswo@codeaurora.org>
 <010101747ef2b8fc-a5e44a5a-dcf4-4828-a1d4-a099df63f2df-000000@us-west-2.amazonses.com>
 <410a4e0c-f924-4564-ae1e-cc9f6292c88e@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <60e99abb-7f69-c585-ff9f-76ebe6a81de6@infradead.org>
Date:   Fri, 11 Sep 2020 14:42:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <410a4e0c-f924-4564-ae1e-cc9f6292c88e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 2:37 PM, Florian Fainelli wrote:
> 
> 
> On 9/11/2020 1:54 PM, Chris Goldsworthy wrote:
>> CMA allocations will fail if 'pinned' pages are in a CMA area, since we
>> cannot migrate pinned pages. The _refcount of a struct page being greater
>> than _mapcount for that page can cause pinning for anonymous pages.  This
>> is because try_to_unmap(), which (1) is called in the CMA allocation path,
>> and (2) decrements both _refcount and _mapcount for a page, will stop
>> unmapping a page from VMAs once the _mapcount for a page reaches 0.  This
>> implies that after try_to_unmap() has finished successfully for a page
>> where _recount > _mapcount, that _refcount will be greater than 0.  Later
>> in the CMA allocation path in migrate_page_move_mapping(), we will have one
>> more reference count than intended for anonymous pages, meaning the
>> allocation will fail for that page.
>>
>> One example of where _refcount can be greater than _mapcount for a page we
>> would not expect to be pinned is inside of copy_one_pte(), which is called
>> during a fork. For ptes for which pte_present(pte) == true, copy_one_pte()
>> will increment the _refcount field followed by the  _mapcount field of a
>> page. If the process doing copy_one_pte() is context switched out after
>> incrementing _refcount but before incrementing _mapcount, then the page
>> will be temporarily pinned.
>>
>> So, inside of cma_alloc(), instead of giving up when alloc_contig_range()
>> returns -EBUSY after having scanned a whole CMA-region bitmap, perform
>> retries indefinitely, with sleeps, to give the system an opportunity to
>> unpin any pinned pages.
> 
> I am by no means an authoritative CMA person but this behavior does not seem acceptable, there is no doubt the existing one is sub-optimal under specific circumstances, but an indefinite retry, as well as a 100ms sleep appear to be arbitrary at best. How about you introduce a parameter that allows the tuning of the number of retries and/or delay between retries?

Also:

You should send your patch to linux-mm@kvack.org -- that's where
most memory management type patches are reviewed.

You should also send your patch to someone who could actually merge
it into the kernel source tree -- assuming that's what you want to happen.

Try scripts/get_mainttainer.pl on your patch to see what it says.

And if you are going to use a "cover letter" or "introductory email" before
the actual patch, the second (patch(es)) should be sent chained to the
first email.  git send-email should do this for you.

-- 
~Randy

