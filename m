Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2142902D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395334AbgJPKdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 06:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395327AbgJPKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 06:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602844384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cG+u7UAAOPIg1MHG159pbyZWQJrtO6RNWf/EPwIxAOc=;
        b=Bpak9ggyS76E8GwZXv7/RltfxwoAIyRhCdmM6C0qj0Vk0rf1U+c9h5SW8GeORdFexdrQ9G
        5cpNKrzzGO7ZgwbAlE4FZ5uxjUhTfj+d04uvh3AZ43nNzAxrt+MwgAeUVo77EZmUzAtD1U
        SIeFFKnEVNT39Ww4mFFTemXycsPbTCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-QefDyz4ZPAG0u3sryVe0XQ-1; Fri, 16 Oct 2020 06:33:00 -0400
X-MC-Unique: QefDyz4ZPAG0u3sryVe0XQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4447564092;
        Fri, 16 Oct 2020 10:32:56 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 685B45D9DD;
        Fri, 16 Oct 2020 10:32:51 +0000 (UTC)
Subject: Re: [PATCH v1 05/29] virtio-mem: generalize check for added memory
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-6-david@redhat.com>
 <20201015082808.GE86495@L-31X9LVDL-1304.local>
 <994394f3-c16d-911c-c9fc-d2280f32e7b1@redhat.com>
 <20201016021651.GI86495@L-31X9LVDL-1304.local>
 <5caec772-295c-436a-2b19-ca261ea1ad0c@redhat.com>
 <20201016100211.GI44269@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <be3dca3d-f5e1-c2d6-460b-04e666619db8@redhat.com>
Date:   Fri, 16 Oct 2020 12:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016100211.GI44269@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Ok, I seems to understand the logic now.
>>>
>>> But how we prevent ONLINE_PARTIAL memory block get offlined? There are three
>>> calls in virtio_mem_set_fake_offline(), while all of them adjust page's flag.
>>> How they hold reference to struct page?
>>
>> Sorry, I should have given you the right pointer. (similar to my other
>> reply)
>>
>> We hold a reference either via
>>
>> 1. alloc_contig_range()
> 
> I am not familiar with this one, need to spend some time to look into.

Each individual page will have a pagecount of 1.

> 
>> 2. memmap init code, when not calling generic_online_page().
> 
> I may miss some code here. Before online pages, memmaps are allocated in
> section_activate(). They are supposed to be zero-ed. (I don't get the exact
> code line.) I am not sure when we grab a refcount here.

Best to refer to __init_single_page() -> init_page_count().

Each page that wasn't onlined via generic_online_page() has a refcount
of 1 and looks like allocated.

-- 
Thanks,

David / dhildenb

