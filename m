Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DBF1A7A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440051AbgDNMX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 08:23:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39031 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728983AbgDNMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586867003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fpseKc6ywGDER8kAmnKmYvU1ghYRRYY5UPIWKqFMjts=;
        b=MORyXCYHDwmBs8W2HyPXnGZlx2TB1Ir+n/RcH8gWrzEYQPgQ9OZe3fzhE5YWWmtOm9VdL4
        3JHFw7tLGKTcKJOsVMXQm6Dw8a4lzoz3CN53U0FTBONj+T61lkgATKmGFSRT5Tz9E9mhpw
        0DVtfmJTw+Q6rBU/Uc9Lne+lffq4mlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-hBQCPcAaMLCRNwsReqeUtQ-1; Tue, 14 Apr 2020 08:23:17 -0400
X-MC-Unique: hBQCPcAaMLCRNwsReqeUtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AFDE8026BC;
        Tue, 14 Apr 2020 12:23:16 +0000 (UTC)
Received: from [10.36.113.201] (ovpn-113-201.ams2.redhat.com [10.36.113.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3A5F11A030;
        Tue, 14 Apr 2020 12:23:14 +0000 (UTC)
Subject: Re: [External] Re: [PATCH] mm/ksm: Fix kernel NULL pointer
 dereference at 0000000000000040
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Markus Elfring <Markus.Elfring@web.de>
References: <20200414062050.66644-1-songmuchun@bytedance.com>
 <ecfc9354-5dba-8e24-f9db-295a2a5d1b4f@redhat.com>
 <CAMZfGtXnVG8Uny5qnFvHuJqu8UBnatDbfx5kyRQZfDtrGoqwvA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <f4657c41-b724-30df-86c2-cf3de1873fd9@redhat.com>
Date:   Tue, 14 Apr 2020 14:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXnVG8Uny5qnFvHuJqu8UBnatDbfx5kyRQZfDtrGoqwvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.20 14:09, Muchun Song wrote:
> On Tue, Apr 14, 2020 at 7:48 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 14.04.20 08:20, Muchun Song wrote:
>>> The find_mergeable_vma can return NULL. In this case, it leads
>>> to crash when we access vma->vm_mm(which's offset is 0x40) in
>>> write_protect_page. And this case did happen on our server. The
>>> following calltrace is captured in kernel 4.19 with ksm enabled.
>>> So add a vma check to fix it.
>>>
>>> --------------------------------------------------------------------------
>>>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
>>>   PGD 0 P4D 0
>>>   Oops: 0000 [#1] SMP NOPTI
>>>   CPU: 9 PID: 510 Comm: ksmd Kdump: loaded Tainted: G OE 4.19.36.bsk.9-amd64 #4.19.36.bsk.9
>>>   Hardware name: FOXCONN R-5111/GROOT, BIOS IC1B111F 08/17/2019
>>>   RIP: 0010:try_to_merge_one_page+0xc7/0x760
>>>   Code: 24 58 65 48 33 34 25 28 00 00 00 89 e8 0f 85 a3 06 00 00 48 83 c4
>>>         60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 46 08 a8 01 75 b8 <49>
>>>         8b 44 24 40 4c 8d 7c 24 20 b9 07 00 00 00 4c 89 e6 4c 89 ff 48
>>>   RSP: 0018:ffffadbdd9fffdb0 EFLAGS: 00010246
>>>   RAX: ffffda83ffd4be08 RBX: ffffda83ffd4be40 RCX: 0000002c6e800000
>>>   RDX: 0000000000000000 RSI: ffffda83ffd4be40 RDI: 0000000000000000
>>>   RBP: ffffa11939f02ec0 R08: 0000000094e1a447 R09: 00000000abe76577
>>>   R10: 0000000000000962 R11: 0000000000004e6a R12: 0000000000000000
>>>   R13: ffffda83b1e06380 R14: ffffa18f31f072c0 R15: ffffda83ffd4be40
>>>   FS: 0000000000000000(0000) GS:ffffa0da43b80000(0000) knlGS:0000000000000000
>>>   CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   CR2: 0000000000000040 CR3: 0000002c77c0a003 CR4: 00000000007626e0
>>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>   PKRU: 55555554
>>>   Call Trace:
>>>     ? follow_page_pte+0x36d/0x5e0
>>>     ksm_scan_thread+0x115e/0x1960
>>>     ? remove_wait_queue+0x60/0x60
>>>     kthread+0xf5/0x130
>>>     ? try_to_merge_with_ksm_page+0x90/0x90
>>>     ? kthread_create_worker_on_cpu+0x70/0x70
>>>     ret_from_fork+0x1f/0x30
>>> --------------------------------------------------------------------------
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Signed-off-by: Xiongchun duan <duanxiongchun@bytedance.com>
>>
>> ^ why this signed-off ?
>>
> 
> Because I have a partner. And I just sent the v2 patch which updates the
> commit message and patch subject. Thanks for your review.

Then we use Co-developed-by AFAIK instead.


-- 
Thanks,

David / dhildenb

