Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0992DF507
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgLTKgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 05:36:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:37703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgLTKgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 05:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608460474;
        bh=T3tvc13X96jYmLdbmV+DJl2kKQzkqTs1dBrFBXng1bQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PtlL9g7uz8mucHimzJJ4/YFlMnkNHtXscaR0LFUJYq1IvQ5QHmsaZqJU0MTkJL5yO
         qhDG+HsVNoYutH7aq65WAFtzVNVkJ+iJPoYM8a7NUn1ZYXyXJAcCKkjvtqAuFFwKId
         9PT9yRmVRYx7VKbqe43w/Xqz3+WAih0hpvP8dmA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.6.90.85]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1kFfLm05d2-00baUG; Sun, 20
 Dec 2020 11:34:34 +0100
Subject: Re: 5.10.1: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:1
To:     Randy Dunlap <rdunlap@infradead.org>, jgg@ziepe.ca
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        axboe <axboe@kernel.dk>
References: <c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de>
 <5c172fad-a9cf-c29d-0a27-f2b0505dc33d@infradead.org>
 <43d52285-a10e-692d-daa6-6f5eb07e3132@gmx.de>
 <1affc309-709b-556e-fe51-72e59e83f90c@infradead.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Message-ID: <84c7a7e1-5f19-2578-3274-4b1bf4f348f6@gmx.de>
Date:   Sun, 20 Dec 2020 11:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1affc309-709b-556e-fe51-72e59e83f90c@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v2yAsVxiGHkb8L4dUOon/VUqHaPZVnaTk7IZGyVahCJyi89RcvT
 L+HUdJiyzYsRz5/6lVmyVxc74+rlOYTWMbNThfzqszQr/pO8UDsoR5uuUGSw2PKtOeEyEBP
 QcgkugwlFBH2dRvQoIPaxSVH7DclHcwi9uQL5sWbdFXGgyKzQIofk1IjAJTV0FcP5tPlGHr
 3+YK+955WyO74xpDXJwXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HlbHWoWCjaw=:/bR1q7JJwW4c8fbAInBcka
 LJ/Ym7Y1O2TnQ0+PR/T5/P4mmTLUx4ZKPHcUrI9H0xf+WaJuiap/DV21Ot/+FGbkApuV4CVab
 OC5fJBMq+53JJcBvPaCYm9TiQDCKJAc6hCtkTNNe/on6+aHsjSBQf9tZLm116QGGE1moMgL1o
 nbOiZ4ZFeOfuGMqjOjZ159O4iZwYeIQBgcQ7m6+SjRDuV7JfHDMFz7kAgFLChEZCMGy2HzK1w
 KVODJAakmTC/wQkqyZRZGF3rnT4BDLEkBvPnCkpKB7Jscp3lsHPdowDx6zUL8EPKicqMELC07
 wlGs8+7Ad+5CIhIIgUncgpjOURcH7hGBZe50uKC1RlclURSAy6t19c2R9CgyRBQwGK4wxhnM8
 vQ3DKFRg4g8GFTsaEVc4705JVj8I8FymEmdYgGV+K4G0tpKcooi+Jke+tJHvwgjGoYtlIfUhL
 VCBB23kp8L9ox40P8ByYnRT28RLNPU4WiHmMULPBIFPB4Tuu2LFEZ/g0i8H2kqAKxEph8RdEr
 DCC/S+VRdnl1LW+hdluRTQ+LDpaB0hJDh+G7y2rwXpAsSLytcH+L7NpoBPefilE7aljg69uxJ
 Lu6QtKg9pVBaAyXiIxoxYY0CHmB9Y3Spodr70Ws3XbtQQwPHjbLO3WOopAD6lnyMr82Ee+/qb
 EQ+mCZREmNVwuhRtojLrFauCI5avCSeQcOMQznI0c8bIRZvOnjbB8GCoQb3bZA9Xw8WBx3flY
 p7OMrAbSBNd9J4yfYxSbhgrD2zsEoH4Rw0SrYH015FLUx8+bH5GsR65ezf9np+5Y4xbKvG2GJ
 kPjCYU6LfmKkA49JJJ/6eEHibQ+Bbec/uwb+NC6bX4COIrpL5RDhHMjywrNk8fbjQ4m2SBT8P
 MNHn6Ux4FvLIcPFihtbQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/20 2:09 AM, Randy Dunlap wrote:
> On 12/18/20 2:20 AM, Toralf F=C3=B6rster wrote:
>> On 12/18/20 7:54 AM, Randy Dunlap wrote:
>>> Hi,
>>>
>>> [adding linux-mm]
>>>
>>> On 12/16/20 1:54 AM, Toralf F=C3=B6rster wrote:
>>>> Hi,
>>>>
>>>> I got this recently at this hardened Gentoo Linux server:
>>>>
>>>> Linux mr-fox 5.10.1 #1 SMP Tue Dec 15 22:09:42 CET 2020 x86_64 Intel(=
R)
>>>> Xeon(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux
>>>>
>>>>
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206972]
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206977] UBSAN: shift-out-of-bou=
nds
>>>> in ./include/linux/log2.h:57:13
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206980] shift exponent 64 is to=
o
>>>> large for 64-bit type 'long unsigned int'
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206982] CPU: 11 PID: 21051 Comm=
:
>>>> cc1 Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T 5.10.1 #1
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206984] Hardware name: ASUSTeK
>>>> COMPUTER INC. Z10PA-U8 Series/Z10PA-U8 Series, BIOS 3703 08/02/2018
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206985] Call Trace:
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206993]=C2=A0 dump_stack+0x57/0=
x6a
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206996]=C2=A0 ubsan_epilogue+0x=
5/0x40
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206999]
>>>> __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207002]
>>>> ondemand_readahead.cold+0x16/0x21
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207007]
>>>> generic_file_buffered_read+0x452/0x890
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207011]=C2=A0 new_sync_read+0x1=
56/0x200
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207014]=C2=A0 vfs_read+0xf8/0x1=
90
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207016]=C2=A0 ksys_read+0x65/0x=
e0
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207018]=C2=A0 do_syscall_64+0x3=
3/0x40
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207021]
>>>> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207024] RIP: 0033:0x7f01b2df198=
e
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207026] Code: c0 e9 b6 fe ff ff=
 50
>>>> 48 8d 3d 66 c3 09 00 e8 59 e2 01 00 66 0f 1f 84 00 00 00 00 00 64 8b =
04
>>>> 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1=
f
>>>> 84 00 00 00 00 00 48 83 ec 28
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207028] RSP: 002b:00007fff2167e=
998
>>>> EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207030] RAX: ffffffffffffffda R=
BX:
>>>> 0000000000000000 RCX: 00007f01b2df198e
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207032] RDX: 0000000000000000 R=
SI:
>>>> 00000000054dcc50 RDI: 0000000000000004
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207033] RBP: 00000000054dcc50 R=
08:
>>>> 00000000054dcc50 R09: 0000000000000000
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207034] R10: 0000000000000000 R=
11:
>>>> 0000000000000246 R12: 00000000054dc3b0
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207035] R13: 0000000000008000 R=
14:
>>>> 00000000054c9800 R15: 0000000000000000
>>>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207037]
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>>
>>>> Known issue ?
>>>
>>> Not that I have heard about, but that's not conclusive.
>>>
>>> Looks to me like this is in mm/readahead.c:
>>>
>>> static unsigned long get_init_ra_size(unsigned long size, unsigned lon=
g max)
>>> {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0unsigned long newsize =3D roundup_pow_of_two(=
size);
>>>
>>>
>>> What filesystem?=C2=A0 What workload?
>>
>> / is a 32 GB ext4 filesystem.
>> Data are at 3 BTRFS filesystems, 1x 500 GB and 2x 1.6TB.
>>
>> 2 Tor relays run at 100% each and utilizes the 1 GBit/s by 50%-60% [1]
>>
>> 7 build bots are running over the Gentoo software repostory [2]
>> 1 AFL bot fuzzies the Tor sources.
>> Those 8 jobs are contained by a cgroup of 9 CPUs and 120 GB RAM [3],
>> each job is contained further by an own sub cgroup of 1.5 CPU and 20 GB
>> RAM [4]
>>
>> The host is monitored using sysstat, the load is about 11.8, CPU[all] a=
t
>> 80%, proc/s at 1800, cswchs/s at 20000 and so on.
>>
>>
>> [1] https://metrics.torproject.org/rs.html#search/zwiebeltoralf
>> [2] https://zwiebeltoralf.de/tinderbox.html
>> [3] https://github.com/toralf/tinderbox/blob/master/bin/cgroup.sh
>> [4] https://github.com/toralf/tinderbox/blob/master/bin/bwrap.sh#L15
>>
>> --
>
> Hi Toralf,
>
> Is this something that happens more than once?

Till now only once.

> I think we would like to find out what is causing it.
> I see a couple of problems.
>
> (a)
>    UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>    shift exponent 64 is too large for 64-bit type 'long unsigned int'
>
> <linux/log2.h>:57: is like so:
>
>      50	/**
>      51	 * __roundup_pow_of_two() - round up to nearest power of two
>      52	 * @n: value to round up
>      53	 */
>      54	static inline __attribute__((const))
>      55	unsigned long __roundup_pow_of_two(unsigned long n)
>      56	{
>      57		return 1UL << fls_long(n - 1);
>      58	}
>
> It's OK/valid for fls_long() [fls64()] to return 64 for a bit
> position -- it just means the high-order bit in a 64-bit value.
> So this code should either always subtract 1 from fls_long() or
> do that if fls_long() =3D=3D 64.
>
>
> (b) in mm/readahead.c:get_init_ra_size():
>
>     305	/*
>     306	 * Set the initial window size, round to next power of 2 and squ=
are
>     307	 * for small size, x 4 for medium, and x 2 for large
>     308	 * for 128k (32 page) max ra
>     309	 * 1-8 page =3D 32k initial, > 8 page =3D 128k initial
>     310	 */
>     311	static unsigned long get_init_ra_size(unsigned long size, unsign=
ed long max)
>     312	{
>     313		unsigned long newsize =3D roundup_pow_of_two(size);
>
> It looks like 'size' is either extremely large or it might be negative i=
f
> it were a signed long instead of unsigned, so maybe it's 0x80000000_0000=
0000
> or 0xffffffff_ffffffff or something similar. I think that we should add =
a
> WARN_ON_ONCE() there to try to catch whatever it is.
>
>
> Is this something that you could test if I send some patches?

Sure, no problem

> Unless other people have some other ideas, that is...
>
> thanks.
>


=2D-
Toralf
