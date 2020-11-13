Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9125A2B1AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:15:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:55054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgKMMPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:15:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD998ABD1;
        Fri, 13 Nov 2020 12:15:45 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] kernel/power: allow hibernation with page_poison
 sanity checking
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20201113104033.22907-1-vbabka@suse.cz>
 <20201113104033.22907-4-vbabka@suse.cz>
 <751f6a7b-afa3-fe8f-5df2-5a604b762d6a@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c15ceaa4-c211-d95e-fb6c-3cb6c93b6549@suse.cz>
Date:   Fri, 13 Nov 2020 13:15:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <751f6a7b-afa3-fe8f-5df2-5a604b762d6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 1:10 PM, David Hildenbrand wrote:
>> @@ -1186,12 +1194,12 @@ void clear_free_pages(void)
>>   	if (WARN_ON(!(free_pages_map)))
>>   		return;
>>   
>> -	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
>> +	if (page_poisoning_enabled() || want_init_on_free()) {
> 
> Any reason why not to use the static version here?

It's a single check per resume, so not worth live-patching this place.

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> 

