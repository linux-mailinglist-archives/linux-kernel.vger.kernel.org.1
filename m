Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747B32A7947
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgKEI3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:29:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgKEI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604564974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adPaZhsg9rSI30Nv3OJs5JJH153rGjOkRFJFWWaQFmA=;
        b=F4t49gzO2fGjlG7GxaQsy9n+52gF76H1x1s60Bi6s464qQCidV5eCSRe0FRUAvS//4vsAl
        vA603zpiWKcBllH7xlaRIgTh3ERe3oRFn6iZdadi+oYzCqB5oIYa2m1VpgKeKDh16Lr1uw
        cl9MhtRus7n5I1WiLzBrcRJUn7DGiSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-CtK-yL04MyeOSEuzIQi0Pg-1; Thu, 05 Nov 2020 03:29:32 -0500
X-MC-Unique: CtK-yL04MyeOSEuzIQi0Pg-1
Received: by mail-wm1-f69.google.com with SMTP id o19so316029wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=adPaZhsg9rSI30Nv3OJs5JJH153rGjOkRFJFWWaQFmA=;
        b=iyYM2X2LA6gDRhHpsDdZCT4eAtvwJTxlK/yZAII5uwVVeImNuTrkS7KdlzJof536dq
         /hfEB0+flYMDIvXfkaTFhLweeg4BC+cjsolRTBlBqxBYbV6tTyQftbk56i79zU7vjMDk
         FVFN15F6JiMTef/6dCBnTLJR4oUFAVbi+CCEDLZz7kTFZM4yjB29mO8friqXm8xHyFyF
         WQUEFEgF0EUGCJWeE9mblkgqCZJ0dhwoULXLzmBGQyM2afy2Q6W4Ci4mHrbovLQE46yO
         pp8BYFDKaC9qF8yw4bIOJGlxKnwoTRBPZuYOEX4RgAjLwQqZeAA997GSFmEyd8en31Wv
         xUMA==
X-Gm-Message-State: AOAM5304IHEydqfoWWcR3AN9pX9mF622eiEUQyIUBtTNcRmejOvpNFMN
        gn0ZQgJi5sHW9K1yCRlnodfRiV8ij2t2Zy77BXOK9F5dBvhH8UDLSG+uT1/KHyfaxN9YDzE0HP7
        znXc2Tc8Cq3MCdAGT/GA7iRH8
X-Received: by 2002:a5d:688c:: with SMTP id h12mr1528843wru.92.1604564970816;
        Thu, 05 Nov 2020 00:29:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa2txjVKqbSfl58jHdphu7Qv2zDJxMqnz9YHvcTy6jiI+C7kFhAWNcUEsLj0a4rpiZiHQbAQ==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr1528817wru.92.1604564970537;
        Thu, 05 Nov 2020 00:29:30 -0800 (PST)
Received: from ?IPv6:2003:d8:2f34:7900:7495:eb9e:985d:aaa0? (p200300d82f3479007495eb9e985daaa0.dip0.t-ipconnect.de. [2003:d8:2f34:7900:7495:eb9e:985d:aaa0])
        by smtp.gmail.com with ESMTPSA id e25sm1381379wrc.76.2020.11.05.00.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 00:29:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 4/4] powernv/memtrace: don't abuse memory hot(un)plug infrastructure for memory allocations
From:   David Hildenbrand <david@redhat.com>
In-Reply-To: <87o8kcttjp.fsf@mpe.ellerman.id.au>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Michal Hocko <mhocko@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Date:   Thu, 5 Nov 2020 09:29:29 +0100
Message-Id: <1D39DC0E-C07A-4B9E-B811-67684A4A0FE9@redhat.com>
References: <87o8kcttjp.fsf@mpe.ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 05.11.2020 um 03:53 schrieb Michael Ellerman <mpe@ellerman.id.au>:
>=20
> =EF=BB=BFDavid Hildenbrand <david@redhat.com> writes:
>> Let's use alloc_contig_pages() for allocating memory and remove the
>> linear mapping manually via arch_remove_linear_mapping(). Mark all pages
>> PG_offline, such that they will definitely not get touched - e.g.,
>> when hibernating. When freeing memory, try to revert what we did.
>> The original idea was discussed in:
>> https://lkml.kernel.org/r/48340e96-7e6b-736f-9e23-d3111b915b6e@redhat.com=

>> This is similar to CONFIG_DEBUG_PAGEALLOC handling on other
>> architectures, whereby only single pages are unmapped from the linear
>> mapping. Let's mimic what memory hot(un)plug would do with the linear
>> mapping.
>> We now need MEMORY_HOTPLUG and CONTIG_ALLOC as dependencies.
>> Simple test under QEMU TCG (10GB RAM, single NUMA node):
>> sh-5.0# mount -t debugfs none /sys/kernel/debug/
>> sh-5.0# cat /sys/devices/system/memory/block_size_bytes
>> 40000000
>> sh-5.0# echo 0x40000000 > /sys/kernel/debug/powerpc/memtrace/enable
>> [   71.052836][  T356] memtrace: Allocated trace memory on node 0 at 0x00=
00000080000000
>> sh-5.0# echo 0x80000000 > /sys/kernel/debug/powerpc/memtrace/enable
>> [   75.424302][  T356] radix-mmu: Mapped 0x0000000080000000-0x00000000c00=
00000 with 64.0 KiB pages
>> [   75.430549][  T356] memtrace: Freed trace memory back on node 0
>> [   75.604520][  T356] memtrace: Allocated trace memory on node 0 at 0x00=
00000080000000
>> sh-5.0# echo 0x100000000 > /sys/kernel/debug/powerpc/memtrace/enable
>> [   80.418835][  T356] radix-mmu: Mapped 0x0000000080000000-0x00000001000=
00000 with 64.0 KiB pages
>> [   80.430493][  T356] memtrace: Freed trace memory back on node 0
>> [   80.433882][  T356] memtrace: Failed to allocate trace memory on node 0=

>> sh-5.0# echo 0x40000000 > /sys/kernel/debug/powerpc/memtrace/enable
>> [   91.920158][  T356] memtrace: Allocated trace memory on node 0 at 0x00=
00000080000000
>=20
> I gave this a quick spin on a real machine, seems to work OK.
>=20
> I don't have the actual memtrace tools setup to do an actual trace, will
> try and get someone to test that also.
>=20
> One observation is that previously the memory was zeroed when enabling
> the memtrace, whereas now it's not.
>=20
> eg, before:
>=20
> # hexdump -C /sys/kernel/debug/powerpc/memtrace/00000000/trace=20
> 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.............=
...|
> *
> 10000000
>=20
> whereas after:
>=20
> # hexdump -C /sys/kernel/debug/powerpc/memtrace/00000000/trace
> 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.............=
...|
> *
> 00000080  e0 fd 43 00 00 00 00 00  e0 fd 43 00 00 00 00 00  |..C.......C..=
...|
> 00000090  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.............=
...|
> *
> 00000830  98 bf 39 00 00 00 00 00  98 bf 39 00 00 00 00 00  |..9.......9..=
...|
> 00000840  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.............=
...|
> *
> 000008a0  b0 c8 47 00 00 00 00 00  b0 c8 47 00 00 00 00 00  |..G.......G..=
...|
> 000008b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.............=
...|
> ...
> 0fffff70  78 53 49 7d 00 00 29 2e  88 00 92 41 01 00 49 39  |xSI}..)....A.=
.I9|
> 0fffff80  b4 07 4a 7d 28 f8 00 7d  00 48 08 7c 0c 00 c2 40  |..J}(..}.H.|.=
..@|
> 0fffff90  2d f9 40 7d f0 ff c2 40  b4 07 0a 7d 00 48 8a 7f  |-.@}...@...}.=
H..|
> 0fffffa0  70 fe 9e 41 cc ff ff 4b  00 00 00 60 00 00 00 60  |p..A...K...`.=
..`|
> 0fffffb0  01 00 00 48 00 00 00 60  00 00 a3 2f 0c fd 9e 40  |...H...`.../.=
..@|
> 0fffffc0  00 00 a2 3c 00 00 a5 e8  00 00 62 3c 00 00 63 e8  |...<......b<.=
.c.|
> 0fffffd0  01 00 20 39 83 02 80 38  00 00 3c 99 01 00 00 48  |.. 9...8..<..=
..H|
> 0fffffe0  00 00 00 60 e4 fc ff 4b  00 00 80 38 78 fb e3 7f  |...`...K...8x=
...|
> 0ffffff0  01 00 00 48 00 00 00 60  2c fe ff 4b 00 00 00 60  |...H...`,..K.=
..`|
> 10000000
>=20
>=20
> That's a nice way for root to read kernel memory, so we should probably
> add a __GFP_ZERO or memset in there somewhere.

Thanks for catching that! Will have a look on Monday if alloc_contig_pages()=
 already properly handled __GFP_ZERO so we can use it, otherwise I=E2=80=98l=
l fix that.

I don=E2=80=98t recall that memory hotunplug does any zeroing - that=E2=80=98=
s why I didn=E2=80=98t add any explicit zeroing. Could be you were just luck=
y in your experiment - I assume we=E2=80=98ll leak kernel memory already.

Thank!

> cheers

