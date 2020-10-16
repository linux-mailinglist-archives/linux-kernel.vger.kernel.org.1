Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D11290058
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405279AbgJPJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732226AbgJPJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602838826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oygrWY6toZNj3SgGz0MClMg8QLNvLxYmh1V2FbmIngc=;
        b=U4MYi8FEj3OzoqfTXlsO6zcdt7JhHJjIl+xUnhHfX2q8Fy60CpOzIf3DCE9jIctKroUepa
        +7kfb39DqpMT9053qz8Uo24oLAEox6aFcLrze4H6V0dc1cWcU3gKd8e2KzbZmpn+5yylLl
        bC7qJZve9trPvm78aJ0gGRymB1+RC9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-r8JX7_GHM5e6gXIzLgalbw-1; Fri, 16 Oct 2020 05:00:24 -0400
X-MC-Unique: r8JX7_GHM5e6gXIzLgalbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D180D186DD27;
        Fri, 16 Oct 2020 09:00:22 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 882605D9D5;
        Fri, 16 Oct 2020 09:00:18 +0000 (UTC)
Subject: Re: [PATCH v1 02/29] virtio-mem: simplify calculation in
 virtio_mem_mb_state_prepare_next_mb()
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-3-david@redhat.com>
 <CAM9Jb+h=2Wg3qAggjAfBf7yyvL9HU6xns7_giJfw6smkCAJ6SQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <09e63b8a-fb46-c8ae-7512-84b1dd234075@redhat.com>
Date:   Fri, 16 Oct 2020 11:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+h=2Wg3qAggjAfBf7yyvL9HU6xns7_giJfw6smkCAJ6SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.20 22:24, Pankaj Gupta wrote:
>> We actually need one byte less (next_mb_id is exclusive, first_mb_id is
>> inclusive). Simplify.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/virtio/virtio_mem.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index a1f5bf7a571a..670b3faf412d 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -257,8 +257,8 @@ static enum virtio_mem_mb_state virtio_mem_mb_get_state(struct virtio_mem *vm,
>>   */
>>  static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
>>  {
>> -       unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id + 1;
>> -       unsigned long new_bytes = vm->next_mb_id - vm->first_mb_id + 2;
>> +       unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id;
>> +       unsigned long new_bytes = old_bytes + 1;
> 
> Maybe we can avoid new_bytes & old_bytes variables, instead use single
> variable. Can later be used with PFN_UP/PFN_DOWN.

I'll see if it fits into a single line now - if it does, I'll move it
there. Thanks!

-- 
Thanks,

David / dhildenb

