Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2AC2DF28F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgLTBKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 20:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgLTBKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 20:10:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2858C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 17:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=D7fV6i243PUByZ2aWIAxx7aXHH/rWVIhgPMnRukR5Y0=; b=OYOwe6ycSnm39H3hNeAXsLwVpZ
        HHuj8/J5rbL7Ia3MTZPSr2ye3mBJfWetMsK02qwWmTgjnvSsCbXbF5SUxaMiCAC3KAuEGqnkPDtOp
        OpV3OkTXY/zC2rA0qvnqVNMX0DvjesehNnwkr2MoSdqUduXvzFsca3zWx98bcuMLovOOb14DDo9bj
        sa5yuDCXIHVskvqA+sOK2f1m/mR44J8ZxxOjhVKbgUqeaS8DKNVL9IZp+44o97SOTiQop72IX+Kv5
        5JwgChu5R5nNywFfYpQU6dpxCI23X12wIo2rHSx2cg9kVtTpJ8oUNCSthHfRKzKEqz9hULhQ3RJwf
        9YOaDn4w==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqnEU-0003dj-MC; Sun, 20 Dec 2020 01:09:59 +0000
Subject: Re: 5.10.1: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:1
To:     =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        jgg@ziepe.ca
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        axboe <axboe@kernel.dk>
References: <c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de>
 <5c172fad-a9cf-c29d-0a27-f2b0505dc33d@infradead.org>
 <43d52285-a10e-692d-daa6-6f5eb07e3132@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1affc309-709b-556e-fe51-72e59e83f90c@infradead.org>
Date:   Sat, 19 Dec 2020 17:09:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <43d52285-a10e-692d-daa6-6f5eb07e3132@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/20 2:20 AM, Toralf Förster wrote:
> On 12/18/20 7:54 AM, Randy Dunlap wrote:
>> Hi,
>>
>> [adding linux-mm]
>>
>> On 12/16/20 1:54 AM, Toralf Förster wrote:
>>> Hi,
>>>
>>> I got this recently at this hardened Gentoo Linux server:
>>>
>>> Linux mr-fox 5.10.1 #1 SMP Tue Dec 15 22:09:42 CET 2020 x86_64 Intel(R)
>>> Xeon(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux
>>>
>>>
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206972]
>>> ================================================================================
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206977] UBSAN: shift-out-of-bounds
>>> in ./include/linux/log2.h:57:13
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206980] shift exponent 64 is too
>>> large for 64-bit type 'long unsigned int'
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206982] CPU: 11 PID: 21051 Comm:
>>> cc1 Tainted: G                T 5.10.1 #1
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206984] Hardware name: ASUSTeK
>>> COMPUTER INC. Z10PA-U8 Series/Z10PA-U8 Series, BIOS 3703 08/02/2018
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206985] Call Trace:
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206993]  dump_stack+0x57/0x6a
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206996]  ubsan_epilogue+0x5/0x40
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206999]
>>> __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207002]
>>> ondemand_readahead.cold+0x16/0x21
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207007]
>>> generic_file_buffered_read+0x452/0x890
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207011]  new_sync_read+0x156/0x200
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207014]  vfs_read+0xf8/0x190
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207016]  ksys_read+0x65/0xe0
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207018]  do_syscall_64+0x33/0x40
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207021]
>>> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207024] RIP: 0033:0x7f01b2df198e
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207026] Code: c0 e9 b6 fe ff ff 50
>>> 48 8d 3d 66 c3 09 00 e8 59 e2 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04
>>> 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f
>>> 84 00 00 00 00 00 48 83 ec 28
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207028] RSP: 002b:00007fff2167e998
>>> EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207030] RAX: ffffffffffffffda RBX:
>>> 0000000000000000 RCX: 00007f01b2df198e
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207032] RDX: 0000000000000000 RSI:
>>> 00000000054dcc50 RDI: 0000000000000004
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207033] RBP: 00000000054dcc50 R08:
>>> 00000000054dcc50 R09: 0000000000000000
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207034] R10: 0000000000000000 R11:
>>> 0000000000000246 R12: 00000000054dc3b0
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207035] R13: 0000000000008000 R14:
>>> 00000000054c9800 R15: 0000000000000000
>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207037]
>>> ================================================================================
>>>
>>>
>>> Known issue ?
>>
>> Not that I have heard about, but that's not conclusive.
>>
>> Looks to me like this is in mm/readahead.c:
>>
>> static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
>> {
>>     unsigned long newsize = roundup_pow_of_two(size);
>>
>>
>> What filesystem?  What workload?
> 
> / is a 32 GB ext4 filesystem.
> Data are at 3 BTRFS filesystems, 1x 500 GB and 2x 1.6TB.
> 
> 2 Tor relays run at 100% each and utilizes the 1 GBit/s by 50%-60% [1]
> 
> 7 build bots are running over the Gentoo software repostory [2]
> 1 AFL bot fuzzies the Tor sources.
> Those 8 jobs are contained by a cgroup of 9 CPUs and 120 GB RAM [3],
> each job is contained further by an own sub cgroup of 1.5 CPU and 20 GB
> RAM [4]
> 
> The host is monitored using sysstat, the load is about 11.8, CPU[all] at
> 80%, proc/s at 1800, cswchs/s at 20000 and so on.
> 
> 
> [1] https://metrics.torproject.org/rs.html#search/zwiebeltoralf
> [2] https://zwiebeltoralf.de/tinderbox.html
> [3] https://github.com/toralf/tinderbox/blob/master/bin/cgroup.sh
> [4] https://github.com/toralf/tinderbox/blob/master/bin/bwrap.sh#L15
> 
> -- 

Hi Toralf,

Is this something that happens more than once?
I think we would like to find out what is causing it.
I see a couple of problems.

(a)
  UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
  shift exponent 64 is too large for 64-bit type 'long unsigned int'

<linux/log2.h>:57: is like so:

    50	/**
    51	 * __roundup_pow_of_two() - round up to nearest power of two
    52	 * @n: value to round up
    53	 */
    54	static inline __attribute__((const))
    55	unsigned long __roundup_pow_of_two(unsigned long n)
    56	{
    57		return 1UL << fls_long(n - 1);
    58	}

It's OK/valid for fls_long() [fls64()] to return 64 for a bit
position -- it just means the high-order bit in a 64-bit value.
So this code should either always subtract 1 from fls_long() or
do that if fls_long() == 64.


(b) in mm/readahead.c:get_init_ra_size():

   305	/*
   306	 * Set the initial window size, round to next power of 2 and square
   307	 * for small size, x 4 for medium, and x 2 for large
   308	 * for 128k (32 page) max ra
   309	 * 1-8 page = 32k initial, > 8 page = 128k initial
   310	 */
   311	static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
   312	{
   313		unsigned long newsize = roundup_pow_of_two(size);

It looks like 'size' is either extremely large or it might be negative if
it were a signed long instead of unsigned, so maybe it's 0x80000000_00000000
or 0xffffffff_ffffffff or something similar. I think that we should add a
WARN_ON_ONCE() there to try to catch whatever it is.


Is this something that you could test if I send some patches?

Unless other people have some other ideas, that is...

thanks.
-- 
~Randy

