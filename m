Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F802C4BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgKZAHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgKZAHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:07:16 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914EBC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:07:16 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so242845plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lXKGFwlwk5BhnLTOpbOaW2N4zPIH8hU8zMiJmAIHSzM=;
        b=UcNa1hiKKrFYlPeAOBA52BSPUa2xFQ4A3OyNKpIrp7OUj0PSUhb9nDuKEjKwvz/aP1
         /Bx/xrcz2r/u24ScMRL7as3hV0D1TieEglnop9SXMgZJMPOkN3DtdaNbfsOJXvVSIU7X
         AAFvP8OmJ93oDMXs+llXaO+OWqwt0rTTjFn8yWM+/+KGqsY5je9IXlkWOG08aPU/HrmR
         P562toTIhxvVevj4sot64sz5Nur9qIkcjcxM89afF/W8RjYISkH1ukUqaH6+tep1Qr9s
         c0dybXURey+1cz6LU/rE0K+QLrbf0b2Km/So4KumMJ0bT6ypq8Go7O2jPHR3sb+9npoU
         iqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lXKGFwlwk5BhnLTOpbOaW2N4zPIH8hU8zMiJmAIHSzM=;
        b=T8cPhZh39TqwoJ/sA2pDiiLRycfkiAKoupiEwxF62Bzbhx/cNSe+MEo2eoCSjeHwkT
         Mb9iWAaDtBWIpCxwO9OxfChD6pmLLl+4ZfTl4AvtoiKyn6YPCuTGnM16ognoOutg8qfQ
         WXDZK+iCtSN4Z+gCWjIx9BTUvZ6fgb+m7l2HbWQpPkfsCd7zwiYaI5CePjXdSzy9q0+g
         iDDZKVBN1a+9/WniuhgGJ10vtN7y7nuDxXmQe+haDZj4TVPdrfg5LsIiOMSfY9mB7Zg/
         9TxsuIjaSP+V8XAxlNz5UCuhcaY1h3OLID5EnAdLNICanI+tVYxizp35McQlZiI6OXr9
         BX0w==
X-Gm-Message-State: AOAM531H2U6r9fG6PDTX5bJkmxb+kQbK/0xMeeGNsAAbnLL18F8/70VT
        S26ya1XzmhFBImTNlm+WWXASAQ==
X-Google-Smtp-Source: ABdhPJyvB7YW85IRla3uGns9Rt1ES3C2J2rlLJ6FQ6Vz6Un6ISz46ng2k6fWeN359MQKL8ccHtX9aA==
X-Received: by 2002:a17:902:b604:b029:da:3006:696e with SMTP id b4-20020a170902b604b02900da3006696emr344981pls.34.1606349235954;
        Wed, 25 Nov 2020 16:07:15 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e5sm196699pjl.51.2020.11.25.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:07:15 -0800 (PST)
Date:   Wed, 25 Nov 2020 16:07:15 -0800 (PST)
X-Google-Original-Date: Wed, 25 Nov 2020 16:07:12 PST (-0800)
Subject:     Re: [PATCH v3 0/5] Improve kernel section protections
In-Reply-To: <CAHCEehJnnytcvRr9OdXbdvzjJ9M2D4LBq4rN7TUXoW65nLx2ZQ@mail.gmail.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        anup@brainfault.org, ardb@kernel.org, ren_guo@c-sky.com,
        linux-riscv@lists.infradead.org, walken@google.com,
        ojeda@kernel.org, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-82cf34ec-f691-4aaa-a702-c2a5bb91e59b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 23:21:08 PST (-0800), greentime.hu@sifive.com wrote:
> Atish Patra <atish.patra@wdc.com> 於 2020年11月5日 週四 上午8:05寫道：
>>
>> This series aims at improving kernel permissions by doing following things.
>>
>> 1. Protect kernel sections early instead of after /init.
>> 2. Protect .init.text & .init.data sections with appropriate permissions.
>> 3. Move dynamic relocation section to _init.
>> 4. Moved .init sections after .text. This is what most of the other archs
>>    are also doing.
>>
>> After applying this patch, here are the linear mapped sections with non-uefi boot.
>>
>> ---[ Linear mapping ]---
>> 0xffffffe000000000-0xffffffe000800000    0x0000000080200000         8M PMD     D A . . X . R V
>> 0xffffffe000800000-0xffffffe000c00000    0x0000000080a00000         4M PMD     D A . . . W R V
>> 0xffffffe000c00000-0xffffffe001200000    0x0000000080e00000         6M PMD     D A . . . . R V
>> 0xffffffe001200000-0xffffffe03fe00000    0x0000000081400000      1004M PMD     D A . . . W R V
>>
>> Linear mapping with uefi boot.
>>
>> ---[ Linear mapping ]---
>> 0xffffffe000000000-0xffffffe000800000    0x0000000080200000         8M PTE     D A . . X . R V
>> 0xffffffe000800000-0xffffffe000c00000    0x0000000080a00000         4M PTE     D A . . . W R V
>> 0xffffffe000c00000-0xffffffe001200000    0x0000000080e00000         6M PTE     D A . . . . R V
>> 0xffffffe001200000-0xffffffe03e534000    0x0000000081400000   1002704K PTE     D A . . . W R V
>> 0xffffffe03e538000-0xffffffe03e539000    0x00000000be738000         4K PTE     D A . . . W R V
>> 0xffffffe03e53a000-0xffffffe03e53c000    0x00000000be73a000         8K PTE     D A . . . W R V
>> 0xffffffe03e540000-0xffffffe03e541000    0x00000000be740000         4K PTE     D A . . . W R V
>> 0xffffffe03e545000-0xffffffe03e546000    0x00000000be745000         4K PTE     D A . . . W R V
>> 0xffffffe03e549000-0xffffffe03e54a000    0x00000000be749000         4K PTE     D A . . . W R V
>> 0xffffffe03e54b000-0xffffffe03fd6d000    0x00000000be74b000     24712K PTE     D A . . . W R V
>> 0xffffffe03fd6e000-0xffffffe03fdee000    0x00000000bff6e000       512K PTE     D A . . . W R V
>>
>>
>> Changes from v2->v3:
>> 1. Added few extra comments to clarify rodata permissions.
>> 2. Changed the name of the functions set_memory_default to set_memory_rw_nx.
>> 3. Squashed patch 3&5 together as they depend on each other to allow
>>    bisectability.
>> 4. Removed redundant arguments in protect_kernel_text_data.
>>
>> Changes from v1->v2:
>> 1. .init.text section is aligned with SECTION_ALIGN.
>> 2. .init.text is moved to below of .text so that .head.text & .text are in
>>    one section.
>> 3. We don't need Guo's fix for static object issue.
>> 4. Rebased on 5.10-rc1.
>>
>> Atish Patra (5):
>> RISC-V: Move __start_kernel to .head.text
>> RISC-V: Initialize SBI early
>> RISC-V: Align the .init.text section
>> RISC-V: Protect all kernel sections including init early
>> RISC-V: Move dynamic relocation section under __init
>>
>> arch/riscv/include/asm/sections.h   |  2 +
>> arch/riscv/include/asm/set_memory.h |  4 ++
>> arch/riscv/kernel/head.S            |  1 -
>> arch/riscv/kernel/setup.c           | 19 +++++++--
>> arch/riscv/kernel/vmlinux.lds.S     | 63 +++++++++++++++++------------
>> arch/riscv/mm/init.c                | 21 +++++++---
>> arch/riscv/mm/pageattr.c            |  6 +++
>> 7 files changed, 80 insertions(+), 36 deletions(-)
>>
>
> Test this series in v5.10-rc3 in Qemu and it works.
> Tested-by: Greentime Hu <greentime.hu@sifive.com>
>
> Thank you. :)

Thanks, this is on for-next.
