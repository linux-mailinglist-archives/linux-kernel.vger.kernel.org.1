Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B479A2E8E86
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 22:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbhACVmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 16:42:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:43341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbhACVmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609710022;
        bh=zZXgXDztYCQZUuO5penDfZaAGsGYDqeOH0szjY4nM+A=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=kcYwCFXBinOqsOEctvieyczL4OyvLQKspAzYjGOmoPUQq019fMyKe/xbLXvt/C0Bo
         dDTs1EqXGgcL60wx88aViC9mOcN/L5gtrvcsIPpOq+m6nFp2hQYJIlffkJBkpGCzyV
         CT+zeZei+pQcnpIRskRInHmsIZnYjjIUkppxHRuw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.6.135.89]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1kCKeV0DMn-00p4gk; Sun, 03
 Jan 2021 22:40:22 +0100
Subject: Re: [PATCH -mm] mm: readahead: apply a default readahead size
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org
References: <20201229212634.31307-1-rdunlap@infradead.org>
 <20201229222311.GD28221@casper.infradead.org>
 <ec3030fd-d549-99cf-fe47-703b1fbd678d@infradead.org>
 <361416d6-756d-e652-224d-03b56934030a@gmx.de>
Message-ID: <c891a27c-5d9e-6673-e508-aa62d6461892@gmx.de>
Date:   Sun, 3 Jan 2021 22:40:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <361416d6-756d-e652-224d-03b56934030a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uSqV7wu5rgJptqnysSwG/ANZqtCsGZAkajIQe5qTw6tm1gxleOn
 Y/cf1Y65UHz8ZTdE8+vhaAHR7wl5j0UBRWB61erf1kkI0TNKplwoUr/eM6y64xpISd4zkOv
 XOuDxxJ7Uh2DAuVI2p656r3Nl702AA+BuPOGg28XzITqvgJyEdWKbVyN1DkUYN+br0C5Y75
 MkJm0Ck1ikEDsEfShF7Rg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9q3K8HDNRWY=:S2+KI4GSYiqxvqZmhdfG6W
 TdbUN1DgewB/2ZACpVlot/94ZnY7xyQMDkYf7snM88UyfjcQm4cu/daUrr82goZQr0I2BzyRf
 C8qIPLh7tkn6jDeR36jo2tDeQ6w1rZO0L7ruixLTHqpSOtuKbBuxjvSlT18cqnM3dUNEIZbN3
 RG16TFDJ3kUJtEbEkbURYqmAaBAwDeigF3eWX7xLGXikpq3SLZoO71DrPHk+zP7sl+btWKMCC
 EVNxGxGn1DZNyyPOkoRGa1totKP+Q0apDJlNCDJjuoYGar5n4NskYOfeHGJIhB/a2QZzQAjj1
 LNWxet+wYTNQTxTXCI9V+48tywnUC/CO9kuRoW6ZiXt73IhZh1W6Te1zgMot4lYubXGgYNGmS
 OsnCzX+Fpct3NS4djTf9H/mkj5fjW9qEf6oiWX9pV8iIjf2FnVY2jlTxNdzDf03h3G83dq+8i
 JsH6QEbXDjDHtuuAM1vWQibGKx+3z3tNW3teeIY22zfSmdIftSUYexW6wdzRWLKhoAhTJb0nt
 vz+rMv51NT57d1DEPqwXfA9VRUBAsV+lopu+i4Vv+j78tC3ryQjvTcUCsd50hsVMxfagl78LM
 zjmyAFH/Urtj2m4V4rFDKwdpN8pYEi3Ergv3yBibXzso1df1Of7ooe1F7WwsqNJpbcZe94CXt
 IEKTV9p9DywNYjrQOu6BycWcg8UAjjr4C3eG40i7ZvvFGI+1lK+kOyoQxpps0j7oRBN8umREY
 e7IOxGaoxNHvxqokGgKFGw2g8Em8vJj5zygsBnxlJ53UsYhwYz0JQdkdYOdyXLcOwLqcrCJt8
 EDLdHsxwfHyGJK2lwnFV9PYskhsR2wNgCi4+7UmilrB2KqLDeXn1a95EHCsqjCQipTgn2fcck
 AUJJvAAiiyWLL2lMF5wg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/20 10:05 AM, Toralf F=C3=B6rster wrote:
> On 12/29/20 11:55 PM, Randy Dunlap wrote:
>>> No, this is wrong.=C2=A0 'size' in this case is the size of the read.
>>> And it's zero.=C2=A0 Is this fixed by commit
>>> 3644e2d2dda78e21edd8f5415b6d7ab03f5f54f3
>>>
>> Toralf, can you test with 5.11-rc1 (or later)?
>>
>> thanks.
>
> My plan was to apply that commit on top of the upcoming 5.10.4 and test
> that, just waiting in moment for Greg to release the stable version.
>
I commit 3644e2d2dda on top of 5.10.4 at my server - no issue so far. I
did NOT patched my desktop (same stable hardened Gentoo Linux, same
software and kernel versions) - and there it happened under 5.10.4 too:

Jan  3 20:54:59 t44 kernel: [126159.494365] UBSAN: shift-out-of-bounds
in ./include/linux/log2.h:57:13
Jan  3 20:54:59 t44 kernel: [126159.494371] shift exponent 64 is too
large for 64-bit type 'long unsigned int'
Jan  3 20:54:59 t44 kernel: [126159.494378] CPU: 0 PID: 16651 Comm: cc1
Tainted: G        W       T 5.10.4 #5
Jan  3 20:54:59 t44 kernel: [126159.494381] Hardware name: LENOVO
20AQCTO1WW/20AQCTO1WW, BIOS GJETA4WW (2.54 ) 03/27/2020
Jan  3 20:54:59 t44 kernel: [126159.494383] Call Trace:
Jan  3 20:54:59 t44 kernel: [126159.494397]  dump_stack+0x57/0x6a
Jan  3 20:54:59 t44 kernel: [126159.494402]  ubsan_epilogue+0x5/0x40
Jan  3 20:54:59 t44 kernel: [126159.494408]
__ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
Jan  3 20:54:59 t44 kernel: [126159.494419]
ondemand_readahead.cold+0x16/0x21
Jan  3 20:54:59 t44 kernel: [126159.494427]
generic_file_buffered_read+0x43d/0x880
Jan  3 20:54:59 t44 kernel: [126159.494437]  new_sync_read+0x15d/0x1f0
Jan  3 20:54:59 t44 kernel: [126159.494442]  vfs_read+0xf5/0x190
Jan  3 20:54:59 t44 kernel: [126159.494447]  ksys_read+0x65/0xe0
Jan  3 20:54:59 t44 kernel: [126159.494453]  do_syscall_64+0x33/0x40
Jan  3 20:54:59 t44 kernel: [126159.494460]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan  3 20:54:59 t44 kernel: [126159.494466] RIP: 0033:0x7feace476dfe
Jan  3 20:54:59 t44 kernel: [126159.494472] Code: c0 e9 c6 fe ff ff 50
48 8d 3d de d6 09 00 e8 89 e4 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04
25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f
84 00 00 00 00 00 48 83 ec 28
Jan  3 20:54:59 t44 kernel: [126159.494476] RSP: 002b:00007ffe122f4318
EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Jan  3 20:54:59 t44 kernel: [126159.494483] RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007feace476dfe
Jan  3 20:54:59 t44 kernel: [126159.494486] RDX: 0000000000000000 RSI:
00000000047971a0 RDI: 0000000000000008
Jan  3 20:54:59 t44 kernel: [126159.494489] RBP: 00000000047ba600 R08:
00000000047971a0 R09: 000000000470d010
Jan  3 20:54:59 t44 kernel: [126159.494492] R10: 00007feace543a00 R11:
0000000000000246 R12: 0000000004721610
Jan  3 20:54:59 t44 kernel: [126159.494495] R13: 00000000047971a0 R14:
0000000000000000 R15: 0000000000000000
Jan  3 20:54:59 t44 kernel: [126159.494499]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D



=2D-
Toralf
