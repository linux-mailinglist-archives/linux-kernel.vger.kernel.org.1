Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369972748D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIVTLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVTLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:11:17 -0400
Received: from [192.168.0.20] (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9C62068D;
        Tue, 22 Sep 2020 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600801877;
        bh=2+LOS2Y0GLUTkbHcwy/Lo5qiZDvBCdGrQz6BIl7BQ80=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To:From;
        b=G1KG2ksSXdNganwYDw5Gm6M4fQrjvBIocwmsnTCw7rlskyEdlL9x8QBLjCu43UMbW
         ZRWM5sV96uo6MsoxDw5lDfnUmKUcZ+vKM7zvv/9Pa9rVPAeDAxkI6nWaj9t+L1uwRw
         GBuE/M1RWlDBDi1AG0h6f6RDuOnPAinRVqisuXdY=
Reply-To: kbingham@kernel.org
Subject: Re: [PATCH] scripts/gdb: fix list_for_each
To:     "Prekas, George" <prekageo@amazon.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org
References: <3b382958-9f1d-a3d2-a239-09ba084227e6@amazon.com>
 <2516a051-306f-670b-1f9e-d46fc577c7f8@siemens.com>
 <109fe98d-4143-cfd3-b145-8d5fee189f63@amazon.com>
From:   Kieran Bingham <kbingham@kernel.org>
Autocrypt: addr=kbingham@kernel.org; keydata=
 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
Message-ID: <25111834-a414-e380-1e61-c1b1c0e766cb@kernel.org>
Date:   Tue, 22 Sep 2020 20:11:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <109fe98d-4143-cfd3-b145-8d5fee189f63@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On 22/09/2020 18:17, Prekas, George wrote:
> 
> On 9/22/2020 9:32 AM, Jan Kiszka wrote:
>>
>> On 22.09.20 16:28, George Prekas wrote:
>>> If the next pointer is NULL, list_for_each gets stuck in an infinite
>>> loop.
>>>
>>> Signed-off-by: George Prekas <prekageo@amazon.com>
>>> ---
>>>   scripts/gdb/linux/lists.py | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
>>> index c487ddf09d38..424a91c1aa8b 100644
>>> --- a/scripts/gdb/linux/lists.py
>>> +++ b/scripts/gdb/linux/lists.py
>>> @@ -27,6 +27,8 @@ def list_for_each(head):
>>>           raise TypeError("Must be struct list_head not {}"
>>>                              .format(head.type))
>>>
>>> +    if head['next'] == 0:
>>> +        return
>>>       node = head['next'].dereference()
>>>       while node.address != head.address:
>>>           yield node.address
>>
>> Obviously, infinite loops are bad and should be avoided. But NULL is
>> bug, isn't it? Shouldn't we report such a corruption?
>>
> 
> Hi Jan,
> 
> Is it a bug? Or does it mean that the list is empty?

A correctly initialised (empty) list_head has the next, and prev
pointers pointing to itself

See:

 https://elixir.bootlin.com/linux/latest/source/include/linux/list.h#L33

You can see that the implementation of list_empty() checks for this at:

https://elixir.bootlin.com/linux/latest/source/include/linux/list.h#L280

/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
	return READ_ONCE(head->next) == head;
}

> Let me give some background. If you do the following:
> 
> $ qemu-system-x86_64 -nographic -m 1024 -kernel
> build/arch/x86/boot/bzImage -s -S < /dev/null > /dev/null &
> $ gdb -q build/vmlinux -ex 'target remote localhost:1234' -iex 'set
> auto-load safe-path /' -ex 'lx-symbols'

I suspect this is trying to load modules before the kernel is actually
fully loaded and running, so nothing is yet initialised.


> You will see:
> 
> loading vmlinux
> scanning for modules in /home/ubuntu/linux-5.8.10
> no module object found for ''
> 
> And the last line repeats forever. This happens because modules.next ==
> NULL. This is the Python stack trace:
> 
>   File ".../symbols.py", line 174, in invoke
>     self.load_all_symbols()
>   File ".../symbols.py", line 161, in load_all_symbols
>     [self.load_module_symbols(module) for module in module_list]
>   File ".../symbols.py", line 161, in <listcomp>
>     [self.load_module_symbols(module) for module in module_list]
>   File ".../modules.py", line 30, in module_list
>     for module in lists.list_for_each_entry(modules, module_ptr_type,
> "list"):
>   File ".../lists.py", line 41, in list_for_each_entry
>     for node in list_for_each(head):
>   File ".../lists.py", line 31, in list_for_each
>     traceback.print_stack()
> 
> This patch tries to fix the above problem.

Does it fix it for you ?

I expect it allows the boot process to continue, but the lx-symbols
command will not have completed successfully (or rather I expect it will
not have found anything to load).

I suspect adding defensive checks in here might be helpful but I think
the reality is the code is being called at the wrong time.

The fact that it 'can' be called at the wrong time is where we might
need to be more defensive.


> George

--
Kieran
