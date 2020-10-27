Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46129A89C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896694AbgJ0KAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2896568AbgJ0J7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603792747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLtSmreGZ8ivBs0p74ioOfMSZEASbgeofS5XUTejfho=;
        b=TB834nodNCTfsqAEgotY3j5TlPWF0zO6828DwP+NItZLsyHg7wUnKCG7Wa5NFPFrUACC4L
        5GBs5VTWAKkKC9yhfYOvd1V34SC4qSc4lqgAyvfRdgrUV5Rpp68KKwwzEIH2tLktdC4izm
        MIpnX4Ow3pnktvoAJwV2/Cwrqu9+4+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-mluE0FvaPgadKX6t8AC3zg-1; Tue, 27 Oct 2020 05:59:05 -0400
X-MC-Unique: mluE0FvaPgadKX6t8AC3zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 853901009636;
        Tue, 27 Oct 2020 09:59:00 +0000 (UTC)
Received: from [10.36.113.185] (ovpn-113-185.ams2.redhat.com [10.36.113.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD79C610F3;
        Tue, 27 Oct 2020 09:58:58 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm, page_alloc: do not rely on the order of
 page_poison and init_on_alloc/free parameters
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-2-vbabka@suse.cz>
 <3784dac7-49cb-006b-7b9d-1244d5c59935@redhat.com>
 <9a2b88de-3c01-21d0-69ff-08643f7c4b68@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c14170b8-9705-f9ac-bcb0-aaa623de903d@redhat.com>
Date:   Tue, 27 Oct 2020 10:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9a2b88de-3c01-21d0-69ff-08643f7c4b68@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.20 10:58, Vlastimil Babka wrote:
> On 10/27/20 10:03 AM, David Hildenbrand wrote:
>> On 26.10.20 18:33, Vlastimil Babka wrote:
>>> Enabling page_poison=1 together with init_on_alloc=1 or init_on_free=1 produces
>>> a warning in dmesg that page_poison takes precendence. However, as these
>>> warnings are printed in early_param handlers for init_on_alloc/free, they are
>>> not printed if page_poison is enabled later on the command line (handlers are
>>> called in the order of their parameters), or when init_on_alloc/free is always
>>> enabled by the respective config option - before the page_poison early param
>>> handler is called, it is not considered to be enabled. This is inconsistent.
>>>
>>> We can remove the dependency on order by making the init_on_* parameters only
>>> set a boolean variable, and postponing the evaluation after all early params
>>> have been processed. Introduce a new init_mem_debugging() function for that,
>>> and move the related debug_pagealloc processing there as well.
>>
>> init_mem_debugging() is somewhat sub-optimal - init_on_alloc=1 or
>> init_on_free=1 are rather security hardening mechanisms.
> 
> Well yeah, init_mem_debugging_and_hardening()?

Would work for me.

-- 
Thanks,

David / dhildenb

