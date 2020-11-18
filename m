Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3657C2B79D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgKRI77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:59:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgKRI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605689998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gxx/VvkoJZ4QkIxP+qyRXmDmA8Z61VJCEEV8lV2lfkE=;
        b=CUQenL0tsEeJCscxfnIkkjF1lMlx2bL6H9BP7i1XTjxW4zP/61+bUovGUtY5wpzTTnA2Xt
        ue7uEjde/qz3KmbYWL8ijPHsCpzOtM8kIkk0ZAbIZF3Irn+WOeOThp4OHe/7wQp3J0tUOM
        GrweTCVd/WycaLRkk4gHL+uY2hdgdcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-RRR1uNM8PaKjgEH3DAAXIA-1; Wed, 18 Nov 2020 03:59:54 -0500
X-MC-Unique: RRR1uNM8PaKjgEH3DAAXIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD26110074B1;
        Wed, 18 Nov 2020 08:59:52 +0000 (UTC)
Received: from [10.36.114.231] (ovpn-114-231.ams2.redhat.com [10.36.114.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD2C360C43;
        Wed, 18 Nov 2020 08:59:46 +0000 (UTC)
Subject: Re: [PATCH v2 27/29] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20201112133815.13332-1-david@redhat.com>
 <20201112133815.13332-28-david@redhat.com>
 <20201117205301.bcef9773f3557a764d17b8df@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <842683af-0a1e-78ea-5b94-178eaf8f3239@redhat.com>
Date:   Wed, 18 Nov 2020 09:59:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201117205301.bcef9773f3557a764d17b8df@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.20 05:53, Andrew Morton wrote:
> On Thu, 12 Nov 2020 14:38:13 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> virtio-mem soon wants to use offline_and_remove_memory() memory that
>> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
>> remove that restriction.
>>
>> Let's remember the old state and try to restore that if anything goes
>> wrong. While re-onlining can, in general, fail, it's highly unlikely to
>> happen (usually only when a notifier fails to allocate memory, and these
>> are rather rare).
>>
>> This will be used by virtio-mem to offline+remove memory ranges that are
>> bigger than a single memory block - for example, with a device block
>> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
>> block size of 128MB.
>>
>> While we could compress the state into 2 bit, using 8 bit is much
>> easier.
>>
>> This handling is similar, but different to acpi_scan_try_to_offline():
>>
>> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
>> optimization is still relevant - it should only apply to ZONE_NORMAL
>> (where we have no guarantees). If relevant, we can always add it.
>>
>> b) acpi_scan_try_to_offline() simply onlines all memory in case
>> something goes wrong. It doesn't restore previous online type. Let's do
>> that, so we won't overwrite what e.g., user space configured.
>>
>> ...
>>
> 
> uint8_t is a bit of a mouthful.  u8 is less typing ;)  Doesn't matter.

In case I have to resend, I'll change it :)

> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Thanks!


-- 
Thanks,

David / dhildenb

