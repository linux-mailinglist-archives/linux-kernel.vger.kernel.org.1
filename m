Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A504A275873
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIWNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:13:18 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:10283 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWNNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600866798; x=1632402798;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=b9FOTIom2yG/uJ7oPQq+RshGS0t1Ir+1vbRjTPkEr4E=;
  b=nqmfA9paoneWX72ghO4cuFPoS23OoXLs4g7MEOy+0LEREa/sN82qS+5W
   B5ogYf9OQc4sT0BLT4YHKjCUm+uYYcwB1rCxzxrlMFGUq+IuYYZmshE+8
   DP4Byn5rbn8ZSOYfvMvR/52c7rj3J0hPdPf2Mvly39eUJKcaasrMcPY1b
   E=;
X-IronPort-AV: E=Sophos;i="5.77,293,1596499200"; 
   d="scan'208";a="77379363"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Sep 2020 13:13:04 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 032B41A1A8D;
        Wed, 23 Sep 2020 13:13:03 +0000 (UTC)
Received: from EX13D12UWC002.ant.amazon.com (10.43.162.253) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 23 Sep 2020 13:13:03 +0000
Received: from [10.95.178.71] (10.43.160.137) by EX13D12UWC002.ant.amazon.com
 (10.43.162.253) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Sep
 2020 13:13:02 +0000
Subject: Re: [PATCH] scripts/gdb: fix list_for_each
To:     <kbingham@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>
References: <3b382958-9f1d-a3d2-a239-09ba084227e6@amazon.com>
 <2516a051-306f-670b-1f9e-d46fc577c7f8@siemens.com>
 <109fe98d-4143-cfd3-b145-8d5fee189f63@amazon.com>
 <25111834-a414-e380-1e61-c1b1c0e766cb@kernel.org>
From:   George Prekas <prekageo@amazon.com>
Message-ID: <d694a1f7-e1c9-2631-12e2-a17abaf004da@amazon.com>
Date:   Wed, 23 Sep 2020 08:13:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <25111834-a414-e380-1e61-c1b1c0e766cb@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.160.137]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D12UWC002.ant.amazon.com (10.43.162.253)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On 9/22/2020 2:11 PM, Kieran Bingham wrote:
 > Hi George,
 >
 > On 22/09/2020 18:17, Prekas, George wrote:
 >>
 >> On 9/22/2020 9:32 AM, Jan Kiszka wrote:
 >>>
 >>> On 22.09.20 16:28, George Prekas wrote:
 >>>> If the next pointer is NULL, list_for_each gets stuck in an infinite
 >>>> loop.
 >>>>
 >>>> Signed-off-by: George Prekas <prekageo@amazon.com>
 >>>> ---
 >>>>    scripts/gdb/linux/lists.py | 2 ++
 >>>>    1 file changed, 2 insertions(+)
 >>>>
 >>>> diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
 >>>> index c487ddf09d38..424a91c1aa8b 100644
 >>>> --- a/scripts/gdb/linux/lists.py
 >>>> +++ b/scripts/gdb/linux/lists.py
 >>>> @@ -27,6 +27,8 @@ def list_for_each(head):
 >>>>            raise TypeError("Must be struct list_head not {}"
 >>>>                               .format(head.type))
 >>>>
 >>>> +    if head['next'] == 0:
 >>>> +        return
 >>>>        node = head['next'].dereference()
 >>>>        while node.address != head.address:
 >>>>            yield node.address
 >>>
 >>> Obviously, infinite loops are bad and should be avoided. But NULL is
 >>> bug, isn't it? Shouldn't we report such a corruption?
 >>>
 >>
 >> Hi Jan,
 >>
 >> Is it a bug? Or does it mean that the list is empty?
 >
 > A correctly initialised (empty) list_head has the next, and prev
 > pointers pointing to itself
 >

You are right, actually.

 >
 >> Let me give some background. If you do the following:
 >>
 >> $ qemu-system-x86_64 -nographic -m 1024 -kernel
 >> build/arch/x86/boot/bzImage -s -S < /dev/null > /dev/null &
 >> $ gdb -q build/vmlinux -ex 'target remote localhost:1234' -iex 'set
 >> auto-load safe-path /' -ex 'lx-symbols'
 >
 > I suspect this is trying to load modules before the kernel is actually
 > fully loaded and running, so nothing is yet initialised.
 >
 >
 >> You will see:
 >>
 >> loading vmlinux
 >> scanning for modules in /home/ubuntu/linux-5.8.10
 >> no module object found for ''
 >>
 >> And the last line repeats forever. This happens because modules.next ==
 >> NULL. This is the Python stack trace:
 >>
 >>[...]
 >>
 >> This patch tries to fix the above problem.
 >
 > Does it fix it for you ?
 >
 > I expect it allows the boot process to continue, but the lx-symbols
 > command will not have completed successfully (or rather I expect it will
 > not have found anything to load).
 >
 > I suspect adding defensive checks in here might be helpful but I think
 > the reality is the code is being called at the wrong time.
 >
 > The fact that it 'can' be called at the wrong time is where we might
 > need to be more defensive.
 >

At that point in time, the kernel has not even started so it does not 
have any loaded modules. In fact, as you said, the modules linked list 
is uninitialized. So with this patch, lx-symbols does not get stuck in 
an infinite loop and loads only the vmlinux symbols.

Maybe, I should rephrase the commit message to say that list_for_each 
gets stuck in an infinite loop on uninitialized linked lists.

Do you think that list_for_each should handle uninitialized lists? If 
yes, how do you propose to handle them?

1. Treat them as empty lists (this patch).
2. Print a warning and treat them as empty lists.
3. Raise exception and treat them as empty lists.

I would go with option 1. For traversal purposes an uninitialized list 
is the same as an empty list; it has no elements. I am happy, though, to 
change the patch to another option if you believe it would be better.

--
George

