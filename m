Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A522D0578
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 15:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgLFOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 09:23:50 -0500
Received: from m12-12.163.com ([220.181.12.12]:44845 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgLFOXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 09:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=9cAxU
        htoE5Qpump3E5/vxi8l0YodYgsXLG/mkoXZ9bI=; b=nU6O+SK2UZkrzZMDwg169
        n59yVwz+g3MrXyPed/ors2f5a6L74RKCn5x2RevxgRG4/eTGcPIjjRFxyllwGC91
        XugIZj4NupwcSvLl7bw7xwCGOgyRfrk6lD6iRfjsXY9ouP1EQSwduAaWqPvSjyv1
        vpaYNbBvAX1fI726Ey1gZs=
Received: from [192.168.31.187] (unknown [223.87.230.17])
        by smtp8 (Coremail) with SMTP id DMCowABnqeTQ6Mxf9oywFg--.23021S2;
        Sun, 06 Dec 2020 22:21:05 +0800 (CST)
Subject: Re: [PATCH] mm/memblock:use a more appropriate order calculation when
 free memblock pages
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
References: <20201203152311.5272-1-carver4lio@163.com>
 <20201206115517.GL751215@kernel.org>
From:   carver4lio@163.com
Message-ID: <adfe7852-b390-b8c1-cd9f-36de00e5d882@163.com>
Date:   Sun, 6 Dec 2020 22:21:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201206115517.GL751215@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DMCowABnqeTQ6Mxf9oywFg--.23021S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1UWryxGF4kCFyUtFWUArb_yoW5CF4fpF
        y8Xw1Skrs3Ww1kXa1xJ3WYk348JwnYka4FyFy8Xr42kay3Kr1avrW2gr1IvryDJ3yxXw4Y
        vFZ8trWjganrZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jWuWLUUUUU=
X-Originating-IP: [223.87.230.17]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/1tbiWA3ynVuHulEzYgABsd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/20 7:55 PM, Mike Rapoport wrote:
> On Thu, Dec 03, 2020 at 11:23:10PM +0800, carver4lio@163.com wrote:
>> From: Hailong Liu <liu.hailong6@zte.com.cn>
>>
>> When system in the booting stage, pages span from [start, end] of a memblock
>> are freed to buddy in a order as large as possible (less than MAX_ORDER) at
>> first, then decrease gradually to a proper order(less than end) in a loop.
>>
>> However, *min(MAX_ORDER - 1UL, __ffs(start))* can not get the largest order
>> in some cases.
> 
> Do you have examples?
> What is the memory configration that casues suboptimal order selection
> and what is the order in this case?
> 
I'm sorry for my careless and inadequate testing(I just test it on my x86
machine with 8 cores).

On my x86_64 machine, the layout of RAM looks like:
/ # cat /proc/iomem
00000100-00000fff : reserved
00001000-0009c7ff : System RAM
0009c800-0009ffff : reserved
.....
100000000-22dffffff : System RAM
  22c600000-22d0e01c0 : Kernel code
  22d0e01c1-22d96af3f : Kernel data
  22dae5000-22dbdcfff : Kernel bss
22e000000-22fffffff : RAM buffer

On my machine, I noticed that when the order of an start pfn in is less than
MAX_ORDER, e.g: the start phy_addr 0x00001000, then the return value *order*
of *min(MAX_ORDER - 1UL, __ffs(start))* will be 1, but the free pages span
of the memblock is more than order 1, it's should be (end - start), I guess.

I tested my ideas with some record code like this:
diff --git a/mm/memblock.c b/mm/memblock.c
index b68ee86788af..b0143e3f75db 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1928,18 +1928,23 @@ early_param("memblock", early_memblock);

 static void __init __free_pages_memory(unsigned long start, unsigned long end)
 {
-       int order;
+       int order, loop_cnt, adjust_cnt;
+

        while (start < end) {
                order = min(MAX_ORDER - 1UL, __ffs(start));

-               while (start + (1UL << order) > end)
+               while (start + (1UL << order) > end) {
                        order--;
-
+                       adjust_cnt++;
+               }
                memblock_free_pages(pfn_to_page(start), start, order);

                start += (1UL << order);
+               loop_cnt++;
        }
+       pr_info("TST:[start %lu, end %lu]: loop cnt %d, adjust cnt %d\n",
+               loop_cnt++, adjust_cnt++);
 }

If I change __ffs(start) to __ffs(end - start), the print info show less
loop_cnt and adjust_cnt  on my machine.
 
>> Instead, *__ffs(end - start)* may be more appropriate and meaningful.
> 
> As several people reported using __ffs(end - start) is not correct.
> If the order selection is indeed suboptimal we'd need some better
> formula ;-)
> 
>> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
>> ---
>>  mm/memblock.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index b68ee8678..7c6d0dde7 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1931,7 +1931,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>>  	int order;
>>  
>>  	while (start < end) {
>> -		order = min(MAX_ORDER - 1UL, __ffs(start));
>> +		order = min(MAX_ORDER - 1UL, __ffs(end - start));
>>  
>>  		while (start + (1UL << order) > end)
>>  			order--;
>> -- 
>> 2.17.1
>>
>>
> 


