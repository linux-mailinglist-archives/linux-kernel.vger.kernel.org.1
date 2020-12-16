Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11F82DBE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLPJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:55:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:38095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgLPJzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608112447;
        bh=dSISTEnvl+4VkXEs8MsOJ1hG3tOG7dMTh4sw6Foa/Y8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=SGMmKzUciebMY8qA5O6P6uDUv3ulfJtDILWTWh2uyod5pkib9toHAohVbbGSW1Z9+
         l4JoW8TOeMdmYLuWbCzGK7T7nWDR2apq1l7aZhS+aeREUJiU5xxfuSfOg1f63hk+Sv
         M/nO0+vuGTORYb9QapHOHpkWOxXpBAsp1t5OP3rY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([95.116.36.244]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1jussE1MlZ-00wnTf; Wed, 16
 Dec 2020 10:54:07 +0100
To:     jgg@ziepe.ca
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: 5.10.1: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:1
Message-ID: <c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de>
Date:   Wed, 16 Dec 2020 10:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8hsTuzfvfFoxIZYn0UMYki7i6Ad7bUTAJDKjlvoI9PzfhYVBGwV
 rpk4gsIvRiDpJXDVSplSssxxLqUrzqA0letiPZfkdkFkfTvWqvWjWxi+GWP5PrfvlBYAtJm
 oJOW8Ml2B2JpdSthYNYM3HikQ1J8wiSnLtaEYY/pYNqHMvlilN09Rp1aRLJ52HYLZE40CcI
 tWGCHAixW4YNVhKM2rsDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6xBjxxs1ZBs=:dmzx7DEJr8ettrtkaPqDAo
 X5GDtOAWMtlRAhttORwRuWe6PUbLsC5dySfZ2huyF3ZIxGjvz5asLJoD6YNZVWIQnltxHeN0Z
 MAUVX1skraPeUISMopCzoeQl5saAlDRrDo1C2iPIKOKwSlwEmO8fb6HS+IwY8fM2OhBgigVnc
 8SohB2RpflCTpb7MmkjqOUnMlDfSmkJtl+bHvwOYfFpLhTXK+uQ90JmoKq8PE8IGa5nGswidh
 kSdM+KQ5iWFVsMVUuGgYnTKB0Uw/jDpuEFxUlRupUBjnZV7y5N+gXzdlLQKwIml8aikY+F/ip
 5nNUAUFTRqPwL0M6vIUYk3CM3WMYZsEIMFz2MQwXUgIKl7cnJWS0OobprmzbiuzKI/JPOA8da
 hhyKOkGRfeT59l+tjJRgpPP95cu7Y1xKACgVatDeJ/acV9cEt84AK6VsnJUUttf/d1379rrf8
 jG1B/dEbrsTnCOuqRXGFfpnfAHLBflfzbFedFXldO0IkrIC023Kd9WpXxAgwlf8QZURymq5/Y
 Y4D2zSeFR28icwcZn+c2H5XnWLM+QbOOkFFtB0ZzhsIXJcVyZbyoAyREO6lvQ7eKEN1aLQ1o9
 GIhsR/5dU5NhKKl1zKk3RregpudPlOgicnSU8LFkVtaM9BdiOw2J2GVweErWl9HFqVrGy7/Tg
 x/unZaqrJM3EEK9grL1Nnm5/1eK5GqMk5zZBLThyDpbB66SJefvB/KjvcZtBUk3tTM9Z3tk0K
 X3YBtrXM68DuiJtuuVJw1pBLhoQ1MMNSOhwvDTVmafjmqBrDRlEsohnKFfvGK/q6FjtdPXSrv
 XKyorhJdMwaTDJoOEMrYQKWZ2CesdS0LfT/jBfhB+J5pxR+dtvqQPuT3dfR3V+RshKTRvZohx
 cXfMAuxzk4Q3TKi/UWAw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this recently at this hardened Gentoo Linux server:

Linux mr-fox 5.10.1 #1 SMP Tue Dec 15 22:09:42 CET 2020 x86_64 Intel(R)
Xeon(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux


Dec 15 23:31:51 mr-fox kernel: [ 1974.206972]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
Dec 15 23:31:51 mr-fox kernel: [ 1974.206977] UBSAN: shift-out-of-bounds
in ./include/linux/log2.h:57:13
Dec 15 23:31:51 mr-fox kernel: [ 1974.206980] shift exponent 64 is too
large for 64-bit type 'long unsigned int'
Dec 15 23:31:51 mr-fox kernel: [ 1974.206982] CPU: 11 PID: 21051 Comm:
cc1 Tainted: G                T 5.10.1 #1
Dec 15 23:31:51 mr-fox kernel: [ 1974.206984] Hardware name: ASUSTeK
COMPUTER INC. Z10PA-U8 Series/Z10PA-U8 Series, BIOS 3703 08/02/2018
Dec 15 23:31:51 mr-fox kernel: [ 1974.206985] Call Trace:
Dec 15 23:31:51 mr-fox kernel: [ 1974.206993]  dump_stack+0x57/0x6a
Dec 15 23:31:51 mr-fox kernel: [ 1974.206996]  ubsan_epilogue+0x5/0x40
Dec 15 23:31:51 mr-fox kernel: [ 1974.206999]
__ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
Dec 15 23:31:51 mr-fox kernel: [ 1974.207002]
ondemand_readahead.cold+0x16/0x21
Dec 15 23:31:51 mr-fox kernel: [ 1974.207007]
generic_file_buffered_read+0x452/0x890
Dec 15 23:31:51 mr-fox kernel: [ 1974.207011]  new_sync_read+0x156/0x200
Dec 15 23:31:51 mr-fox kernel: [ 1974.207014]  vfs_read+0xf8/0x190
Dec 15 23:31:51 mr-fox kernel: [ 1974.207016]  ksys_read+0x65/0xe0
Dec 15 23:31:51 mr-fox kernel: [ 1974.207018]  do_syscall_64+0x33/0x40
Dec 15 23:31:51 mr-fox kernel: [ 1974.207021]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec 15 23:31:51 mr-fox kernel: [ 1974.207024] RIP: 0033:0x7f01b2df198e
Dec 15 23:31:51 mr-fox kernel: [ 1974.207026] Code: c0 e9 b6 fe ff ff 50
48 8d 3d 66 c3 09 00 e8 59 e2 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04
25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f
84 00 00 00 00 00 48 83 ec 28
Dec 15 23:31:51 mr-fox kernel: [ 1974.207028] RSP: 002b:00007fff2167e998
EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Dec 15 23:31:51 mr-fox kernel: [ 1974.207030] RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007f01b2df198e
Dec 15 23:31:51 mr-fox kernel: [ 1974.207032] RDX: 0000000000000000 RSI:
00000000054dcc50 RDI: 0000000000000004
Dec 15 23:31:51 mr-fox kernel: [ 1974.207033] RBP: 00000000054dcc50 R08:
00000000054dcc50 R09: 0000000000000000
Dec 15 23:31:51 mr-fox kernel: [ 1974.207034] R10: 0000000000000000 R11:
0000000000000246 R12: 00000000054dc3b0
Dec 15 23:31:51 mr-fox kernel: [ 1974.207035] R13: 0000000000008000 R14:
00000000054c9800 R15: 0000000000000000
Dec 15 23:31:51 mr-fox kernel: [ 1974.207037]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


Known issue ?

=2D-
Toralf
