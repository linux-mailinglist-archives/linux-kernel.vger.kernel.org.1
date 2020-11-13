Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7E62B1AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKMMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgKMMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605269842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xp9qh1EbaUKfgVroCHBI6P3BnQzVe6f2/PUfddgShQA=;
        b=HKrfXTZsYWonHV1xlmnUJtecwuR/ajtl/aMLS1DSM8XK27Ao866fwQkwuU7HKqHBuLHDNd
        W3CM6/XGmflKpZAfdZB06Ep3eNzOa4ZcS4eTugqnDJ8XUhBmYMDLnf8AH8muSewxz+OSWk
        fzx8GStOmmr9lthBZCGKsb7yHUd2pOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-tiXD8sprO3iyc_DpKsC80w-1; Fri, 13 Nov 2020 07:17:20 -0500
X-MC-Unique: tiXD8sprO3iyc_DpKsC80w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDA8E80475A;
        Fri, 13 Nov 2020 12:17:18 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB28B75128;
        Fri, 13 Nov 2020 12:17:16 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] kernel/power: allow hibernation with page_poison
 sanity checking
To:     Vlastimil Babka <vbabka@suse.cz>,
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
 <c15ceaa4-c211-d95e-fb6c-3cb6c93b6549@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3028d955-5cc7-aa52-5c07-7109038fdd3e@redhat.com>
Date:   Fri, 13 Nov 2020 13:17:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c15ceaa4-c211-d95e-fb6c-3cb6c93b6549@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.20 13:15, Vlastimil Babka wrote:
> On 11/13/20 1:10 PM, David Hildenbrand wrote:
>>> @@ -1186,12 +1194,12 @@ void clear_free_pages(void)
>>>    	if (WARN_ON(!(free_pages_map)))
>>>    		return;
>>>    
>>> -	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
>>> +	if (page_poisoning_enabled() || want_init_on_free()) {
>>
>> Any reason why not to use the static version here?
> 
> It's a single check per resume, so not worth live-patching this place.

Agreed, thanks.


-- 
Thanks,

David / dhildenb

