Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444242DE0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbgLRKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:22:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:47619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732938AbgLRKWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608286851;
        bh=fKWuu7R0/DAQXyYQ05r+vlyvSs4al0erSCJKH0onFIA=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Ko0xDgohW9/Rbo3g1T4O8EVAPvERTh3lxVWu+0TWSp6jDrKBXn9aRGl2gz0FLUwef
         RzzmqZEPiwLY6VmwK2LAEujR2WIg8796nJ7c+3ix7jAa4rNT3S104Ts2WW5OTlTK3K
         nbgrhb6/WnilvDDT2PY4Xo840ZwVAUGm5R8Dd5Jw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.8.212.24]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1kEgCh1oNs-00bary; Fri, 18
 Dec 2020 11:20:51 +0100
To:     Randy Dunlap <rdunlap@infradead.org>, jgg@ziepe.ca
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de>
 <5c172fad-a9cf-c29d-0a27-f2b0505dc33d@infradead.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: Re: 5.10.1: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:1
Message-ID: <43d52285-a10e-692d-daa6-6f5eb07e3132@gmx.de>
Date:   Fri, 18 Dec 2020 11:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5c172fad-a9cf-c29d-0a27-f2b0505dc33d@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TPNQN46B5WgEoZp9vG+bj0t4o69maBowzdifN1O0gn3i4VyTg26
 r+vT8yHRC6BroBkV0go2XwZRf5FVncAq3fsX15FbMkR9CaMvky9u97nc4xrmEOvrh/DRG5D
 sWWenK7UjXll5bwDgvnjrC924ZwgNcvZwhDxmH/MYmkChO+M9JdPbGnLUuIcpQNjbfrTUlv
 L0d3OdZm2WoovATI9EaYQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:saCbT7iKshk=:HXabUr0uFjAbfO8XeuSUTe
 qBpKyW8qmFbMAbZmuJa7iW44OOFzaT14Mvvb3ImkjR3KpVBQT4MWQ8UDDGOCyIknwzMl+AOZi
 A2EaF/JZq4TBTLCm/XFovQmViFui9qgfNVYJzJAn5TVCLW0VLGUYcdxrPRlk7+rEgx457Ekgj
 wRmMrrg+Eti7GVjxvGha++pPZJ4yEck4pPxiFnTgxMz40yLk4ehXxZ/joJcX3JKkz+WBh5pyw
 S/4n3MYcG9sVRNc6xccDGPV7QiNspoKrKprAzAIrbk31MA5M3x97VMyeh2PQfvKIl9bKMqDHU
 TuBnWoalXmLOlWfQR6CCKUHjsN/l/etHdA7RepILLhsrC6GMSZRMz9AVieDUsj5igaqnAyVeQ
 jMu+2dB4XGcxGAQ4DKLA5/mSGQcrk18/y5zdRp3JNs8sWH7JAvNbt0livRhwnVAZ7lHmvlHrT
 4ts4R88ud0L36ng6MDzmz+dLrQYEXgl3CNXQzwuVqbl3PclOexxlvvNXfzMZw/A+MlhWpUEQF
 TbwdR1sIKOUyMbl1mMuMdT/UXXberx0jMbgNUtILNOX2kYC7a8BwkkatpFzfG/Motbg+G+PTg
 ofTcKY7T5EkNgDkea3LzgeTHV5tTU5Rmp+C0Zx828bquH4SZ4uxgqg5YtdYDSce/InfW47OGA
 Qp6NAVwtZckAXxlTZLBKEJv3ugLO03K1FbbrqfVAl0EW/FxrTn45Wzjx9wEfWOnSWqD1WgemL
 WgPVT9dmfXYrSSGsu3UEg0EdULpEGfX5X91YJ8m4FxEwK8tvvNRcR/Jwwc/HS5Ww7JBfb4gIj
 pU60mnr7nTlh6zF+07k+Qar9iLW5W0HuTxTBszxReHmZ1/W/EJhjbHsEESHc6Orhpb26t//x8
 5I7ekHXSbKCu2hps6R1g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/20 7:54 AM, Randy Dunlap wrote:
> Hi,
>
> [adding linux-mm]
>
> On 12/16/20 1:54 AM, Toralf F=C3=B6rster wrote:
>> Hi,
>>
>> I got this recently at this hardened Gentoo Linux server:
>>
>> Linux mr-fox 5.10.1 #1 SMP Tue Dec 15 22:09:42 CET 2020 x86_64 Intel(R)
>> Xeon(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux
>>
>>
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206972]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206977] UBSAN: shift-out-of-bound=
s
>> in ./include/linux/log2.h:57:13
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206980] shift exponent 64 is too
>> large for 64-bit type 'long unsigned int'
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206982] CPU: 11 PID: 21051 Comm:
>> cc1 Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T 5.10.1 #1
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206984] Hardware name: ASUSTeK
>> COMPUTER INC. Z10PA-U8 Series/Z10PA-U8 Series, BIOS 3703 08/02/2018
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206985] Call Trace:
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206993]=C2=A0 dump_stack+0x57/0x6=
a
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206996]=C2=A0 ubsan_epilogue+0x5/=
0x40
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.206999]
>> __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207002]
>> ondemand_readahead.cold+0x16/0x21
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207007]
>> generic_file_buffered_read+0x452/0x890
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207011]=C2=A0 new_sync_read+0x156=
/0x200
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207014]=C2=A0 vfs_read+0xf8/0x190
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207016]=C2=A0 ksys_read+0x65/0xe0
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207018]=C2=A0 do_syscall_64+0x33/=
0x40
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207021]
>> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207024] RIP: 0033:0x7f01b2df198e
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207026] Code: c0 e9 b6 fe ff ff 5=
0
>> 48 8d 3d 66 c3 09 00 e8 59 e2 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04
>> 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f
>> 84 00 00 00 00 00 48 83 ec 28
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207028] RSP: 002b:00007fff2167e99=
8
>> EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207030] RAX: ffffffffffffffda RBX=
:
>> 0000000000000000 RCX: 00007f01b2df198e
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207032] RDX: 0000000000000000 RSI=
:
>> 00000000054dcc50 RDI: 0000000000000004
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207033] RBP: 00000000054dcc50 R08=
:
>> 00000000054dcc50 R09: 0000000000000000
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207034] R10: 0000000000000000 R11=
:
>> 0000000000000246 R12: 00000000054dc3b0
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207035] R13: 0000000000008000 R14=
:
>> 00000000054c9800 R15: 0000000000000000
>> Dec 15 23:31:51 mr-fox kernel: [ 1974.207037]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>
>> Known issue ?
>
> Not that I have heard about, but that's not conclusive.
>
> Looks to me like this is in mm/readahead.c:
>
> static unsigned long get_init_ra_size(unsigned long size, unsigned long =
max)
> {
> 	unsigned long newsize =3D roundup_pow_of_two(size);
>
>
> What filesystem?  What workload?

/ is a 32 GB ext4 filesystem.
Data are at 3 BTRFS filesystems, 1x 500 GB and 2x 1.6TB.

2 Tor relays run at 100% each and utilizes the 1 GBit/s by 50%-60% [1]

7 build bots are running over the Gentoo software repostory [2]
1 AFL bot fuzzies the Tor sources.
Those 8 jobs are contained by a cgroup of 9 CPUs and 120 GB RAM [3],
each job is contained further by an own sub cgroup of 1.5 CPU and 20 GB
RAM [4]

The host is monitored using sysstat, the load is about 11.8, CPU[all] at
80%, proc/s at 1800, cswchs/s at 20000 and so on.


[1] https://metrics.torproject.org/rs.html#search/zwiebeltoralf
[2] https://zwiebeltoralf.de/tinderbox.html
[3] https://github.com/toralf/tinderbox/blob/master/bin/cgroup.sh
[4] https://github.com/toralf/tinderbox/blob/master/bin/bwrap.sh#L15

=2D-
Toralf
