Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BED29AA39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898896AbgJ0LFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:05:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:43474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896940AbgJ0LFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:05:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7CD1AAF1;
        Tue, 27 Oct 2020 11:05:21 +0000 (UTC)
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-4-vbabka@suse.cz>
 <93ab79df-cf8c-294b-3ed1-8a563e4a452b@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 3/3] mm, page_alloc: reduce static keys in prep_new_page()
Message-ID: <1fc7ec3a-367c-eb9f-1cb4-b9e015fea87c@suse.cz>
Date:   Tue, 27 Oct 2020 12:05:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <93ab79df-cf8c-294b-3ed1-8a563e4a452b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 10:10 AM, David Hildenbrand wrote:
> On 26.10.20 18:33, Vlastimil Babka wrote:
>> prep_new_page() will always zero a new page (regardless of __GFP_ZERO) when
>> init_on_alloc is enabled, but will also always skip zeroing if the page was
>> already zeroed on free by init_on_free or page poisoning.
>> 
>> The latter check implemented by free_pages_prezeroed() can involve two
>> different static keys. As prep_new_page() is really a hot path, let's introduce
>> a single static key free_pages_not_prezeroed for this purpose and initialize it
>> in init_mem_debugging().
> 
> Is this actually observable in practice? This smells like
> micro-optimization to me.
> 
> Also, I thought the whole reason for static keys is to have basically no
> overhead at runtime, so I wonder if replacing two static key checks by a
> single one actually makes *some* difference.

You're right, the difference seems to be just a single NOP. The static key 
infrastructure seems to be working really well.
(At least the asm inspection made me realize that kernel_poison_pages() is 
called unconditionally and the static key is checked inside, not inline so I'll 
be amending patch 2...)

Initially I thought I would be reducing 3 keys to 1 in this patch, but I got the 
code wrong. So unless others think it's a readability improvements, we can drop 
this patch.

Or we can also reconsider this whole optimization. If the point is to be 
paranoid and enable both init_on_free and init_on_alloc, should we trust that 
nobody wrote something after the clearing on free via use-after-free? :) Kees/Alex?


