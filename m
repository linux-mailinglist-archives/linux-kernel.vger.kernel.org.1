Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA38274752
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIVRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:17:37 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:8088 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgIVRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600795056; x=1632331056;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HN/3INYpkkEkVuXVTMcZLyB76gj/EZwzK/U53lRqnzA=;
  b=WyrtapbFYqgaQIaDWEBlHrUys7xWfJEkjFtaojeW6hvarOiR636H5LiA
   A3S4Fers+B6BnKPZWrV68Dgh/1zyFriIBwWBqr6v7FFaKOI7kfj9IKUMf
   9Bp9rDLCPh1vqgc5N+I86YYA0BY/K0q+S6cvdK+XIa1CL1i+wt1sdG4ov
   c=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="78328752"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Sep 2020 17:17:04 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 2B90FA205A;
        Tue, 22 Sep 2020 17:17:04 +0000 (UTC)
Received: from EX13D12UWC002.ant.amazon.com (10.43.162.253) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 17:17:03 +0000
Received: from [10.88.31.162] (10.43.160.185) by EX13D12UWC002.ant.amazon.com
 (10.43.162.253) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Sep
 2020 17:17:02 +0000
Subject: Re: [PATCH] scripts/gdb: fix list_for_each
To:     Jan Kiszka <jan.kiszka@siemens.com>, <linux-kernel@vger.kernel.org>
CC:     Kieran Bingham <kbingham@kernel.org>
References: <3b382958-9f1d-a3d2-a239-09ba084227e6@amazon.com>
 <2516a051-306f-670b-1f9e-d46fc577c7f8@siemens.com>
From:   "Prekas, George" <prekageo@amazon.com>
Message-ID: <109fe98d-4143-cfd3-b145-8d5fee189f63@amazon.com>
Date:   Tue, 22 Sep 2020 12:17:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2516a051-306f-670b-1f9e-d46fc577c7f8@siemens.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.160.185]
X-ClientProxiedBy: EX13D40UWC002.ant.amazon.com (10.43.162.191) To
 EX13D12UWC002.ant.amazon.com (10.43.162.253)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/22/2020 9:32 AM, Jan Kiszka wrote:
 >
 > On 22.09.20 16:28, George Prekas wrote:
 >> If the next pointer is NULL, list_for_each gets stuck in an infinite
 >> loop.
 >>
 >> Signed-off-by: George Prekas <prekageo@amazon.com>
 >> ---
 >>   scripts/gdb/linux/lists.py | 2 ++
 >>   1 file changed, 2 insertions(+)
 >>
 >> diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
 >> index c487ddf09d38..424a91c1aa8b 100644
 >> --- a/scripts/gdb/linux/lists.py
 >> +++ b/scripts/gdb/linux/lists.py
 >> @@ -27,6 +27,8 @@ def list_for_each(head):
 >>           raise TypeError("Must be struct list_head not {}"
 >>                              .format(head.type))
 >>
 >> +    if head['next'] == 0:
 >> +        return
 >>       node = head['next'].dereference()
 >>       while node.address != head.address:
 >>           yield node.address
 >
 > Obviously, infinite loops are bad and should be avoided. But NULL is
 > bug, isn't it? Shouldn't we report such a corruption?
 >

Hi Jan,

Is it a bug? Or does it mean that the list is empty?

Let me give some background. If you do the following:

$ qemu-system-x86_64 -nographic -m 1024 -kernel 
build/arch/x86/boot/bzImage -s -S < /dev/null > /dev/null &
$ gdb -q build/vmlinux -ex 'target remote localhost:1234' -iex 'set 
auto-load safe-path /' -ex 'lx-symbols'

You will see:

loading vmlinux
scanning for modules in /home/ubuntu/linux-5.8.10
no module object found for ''

And the last line repeats forever. This happens because modules.next == 
NULL. This is the Python stack trace:

   File ".../symbols.py", line 174, in invoke
     self.load_all_symbols()
   File ".../symbols.py", line 161, in load_all_symbols
     [self.load_module_symbols(module) for module in module_list]
   File ".../symbols.py", line 161, in <listcomp>
     [self.load_module_symbols(module) for module in module_list]
   File ".../modules.py", line 30, in module_list
     for module in lists.list_for_each_entry(modules, module_ptr_type, 
"list"):
   File ".../lists.py", line 41, in list_for_each_entry
     for node in list_for_each(head):
   File ".../lists.py", line 31, in list_for_each
     traceback.print_stack()

This patch tries to fix the above problem.

George

