Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EA12C1EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgKXHVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgKXHVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:21:21 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF17C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:21:21 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b144so5085886qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hwdzYO346UPH60KVdrJ8QmKLumNSrWcU3AoIlBFc2rA=;
        b=Uq5oLkUEgN/xeTlb8kqe1FzJiCXT8XQK6oP0fgFnSM7HjShXe6GAKNxF0V79V+LmDE
         cc03QMu9Wim0GaVjxArrVhWs5UMHxOt0K6XNFiOUvbICbtTaiC0jHDKkBwzfrHRPAS1I
         Kphg5BdZxND8OJFyn/ly20+lRk8Evyn4FP0vASdcrgm0U3PS/Z6sdhFex/OP0clQWXta
         AN4j/HQ1cb/VFo3oHGjg5UsHO6SGqeng1Kt3LZuDH9LouKvuBCRpWGWUkY2pghUH3jX5
         AFXwQixYaRldt0QLteRkRJwXySBIi91PdPVdRAwGGD4JABqGW2GfqHQKpMzvn9eYWABA
         /imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hwdzYO346UPH60KVdrJ8QmKLumNSrWcU3AoIlBFc2rA=;
        b=ZSMB4pBVpdSc31DF01+P777i7w02RCtuy4rlt2cpATM8bETj3tRk4PgT2DzVjFcvFP
         sSVN3/EDh+ANPKGt2LF1ai4p7cHOa8hQjA6NefIZDAMicFGg4rZGJLDKVxObPV/mPB0w
         6r7Vpm9HMY0uX8g/VyewKuoY0Nogc7Nb4JQJtBOlc82cqwFPNkxYdhqiHhO+PN9Cobsu
         kB4G7H9pPnfkgw7XNRPjsPtwkkLlxmgViChmZ4dviazfe37MUMLGO9hM+igSuLRQTeVs
         X79nIzQ8BEHl387bpE+PZfc+WSr+JfqCI05BqXpGbF0jPdyMpeJ8bHmzZX10xGaYLCv8
         KzXg==
X-Gm-Message-State: AOAM530kmYXaJlOU+qu7QZD5nFIUsSnyUFIFKoZOK7UwJzS7Mg66/HT4
        8Tv1nswEEjiSG0ynNFLF2Nkoy6OfG1XvXom3Z8RnsZdnQtyEog==
X-Google-Smtp-Source: ABdhPJwXReb6PD+u0kjaMqn5kr+/X6Q1ukB2j7HBi88G+OCvOswXGEU91yPGqV4NQR2roDiwf9epmg63es4dJbeybbY=
X-Received: by 2002:a37:6c41:: with SMTP id h62mr3416405qkc.401.1606202480482;
 Mon, 23 Nov 2020 23:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20201105000439.1491243-1-atish.patra@wdc.com>
In-Reply-To: <20201105000439.1491243-1-atish.patra@wdc.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 24 Nov 2020 15:21:08 +0800
Message-ID: <CAHCEehJnnytcvRr9OdXbdvzjJ9M2D4LBq4rN7TUXoW65nLx2ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Improve kernel section protections
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Guo Ren <ren_guo@c-sky.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atish Patra <atish.patra@wdc.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=885=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This series aims at improving kernel permissions by doing following thing=
s.
>
> 1. Protect kernel sections early instead of after /init.
> 2. Protect .init.text & .init.data sections with appropriate permissions.
> 3. Move dynamic relocation section to _init.
> 4. Moved .init sections after .text. This is what most of the other archs
>    are also doing.
>
> After applying this patch, here are the linear mapped sections with non-u=
efi boot.
>
> ---[ Linear mapping ]---
> 0xffffffe000000000-0xffffffe000800000    0x0000000080200000         8M PM=
D     D A . . X . R V
> 0xffffffe000800000-0xffffffe000c00000    0x0000000080a00000         4M PM=
D     D A . . . W R V
> 0xffffffe000c00000-0xffffffe001200000    0x0000000080e00000         6M PM=
D     D A . . . . R V
> 0xffffffe001200000-0xffffffe03fe00000    0x0000000081400000      1004M PM=
D     D A . . . W R V
>
> Linear mapping with uefi boot.
>
> ---[ Linear mapping ]---
> 0xffffffe000000000-0xffffffe000800000    0x0000000080200000         8M PT=
E     D A . . X . R V
> 0xffffffe000800000-0xffffffe000c00000    0x0000000080a00000         4M PT=
E     D A . . . W R V
> 0xffffffe000c00000-0xffffffe001200000    0x0000000080e00000         6M PT=
E     D A . . . . R V
> 0xffffffe001200000-0xffffffe03e534000    0x0000000081400000   1002704K PT=
E     D A . . . W R V
> 0xffffffe03e538000-0xffffffe03e539000    0x00000000be738000         4K PT=
E     D A . . . W R V
> 0xffffffe03e53a000-0xffffffe03e53c000    0x00000000be73a000         8K PT=
E     D A . . . W R V
> 0xffffffe03e540000-0xffffffe03e541000    0x00000000be740000         4K PT=
E     D A . . . W R V
> 0xffffffe03e545000-0xffffffe03e546000    0x00000000be745000         4K PT=
E     D A . . . W R V
> 0xffffffe03e549000-0xffffffe03e54a000    0x00000000be749000         4K PT=
E     D A . . . W R V
> 0xffffffe03e54b000-0xffffffe03fd6d000    0x00000000be74b000     24712K PT=
E     D A . . . W R V
> 0xffffffe03fd6e000-0xffffffe03fdee000    0x00000000bff6e000       512K PT=
E     D A . . . W R V
>
>
> Changes from v2->v3:
> 1. Added few extra comments to clarify rodata permissions.
> 2. Changed the name of the functions set_memory_default to set_memory_rw_=
nx.
> 3. Squashed patch 3&5 together as they depend on each other to allow
>    bisectability.
> 4. Removed redundant arguments in protect_kernel_text_data.
>
> Changes from v1->v2:
> 1. .init.text section is aligned with SECTION_ALIGN.
> 2. .init.text is moved to below of .text so that .head.text & .text are i=
n
>    one section.
> 3. We don't need Guo's fix for static object issue.
> 4. Rebased on 5.10-rc1.
>
> Atish Patra (5):
> RISC-V: Move __start_kernel to .head.text
> RISC-V: Initialize SBI early
> RISC-V: Align the .init.text section
> RISC-V: Protect all kernel sections including init early
> RISC-V: Move dynamic relocation section under __init
>
> arch/riscv/include/asm/sections.h   |  2 +
> arch/riscv/include/asm/set_memory.h |  4 ++
> arch/riscv/kernel/head.S            |  1 -
> arch/riscv/kernel/setup.c           | 19 +++++++--
> arch/riscv/kernel/vmlinux.lds.S     | 63 +++++++++++++++++------------
> arch/riscv/mm/init.c                | 21 +++++++---
> arch/riscv/mm/pageattr.c            |  6 +++
> 7 files changed, 80 insertions(+), 36 deletions(-)
>

Test this series in v5.10-rc3 in Qemu and it works.
Tested-by: Greentime Hu <greentime.hu@sifive.com>

Thank you. :)
