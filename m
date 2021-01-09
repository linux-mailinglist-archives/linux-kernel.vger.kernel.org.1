Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641E42EFEF8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 11:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbhAIKdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 05:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAIKds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 05:33:48 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD09C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 02:33:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s15so7005329plr.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 02:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=REJcHYfVpby7r9Plat861Deb3UCTNl3jWnkLKDVNOTw=;
        b=Kor0HaVeHVs7YYUOQZ05gUWuNtOwjxDYJqWrgBtIAReqrojCFtPViV7k6RPsAv6KD+
         f3IMeYXvvn1OfPUsolfH+e6FpkPp3SRA3NbBmcDgWzOQx/iUnhc/KMx0UZmDIBmSYEEW
         hLZFffygYj/kiMSxPIfZ9uuc330Ur7esfHBk3+ac035nG2W9MG9VrCZdpsun99HqjhyS
         ToVa3OiwtZxg2MPh03Cj6VtFS01xIZmWga7Ym75rEvfoDaTBbxuU2tUQNnTI7mI7Tu2o
         K09njQke4fOs1NAcnnhRwaTawGcK0IQxkfgY71NVOV2FMbuc0n9Z99ICnLp4kEBSkyGi
         TcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=REJcHYfVpby7r9Plat861Deb3UCTNl3jWnkLKDVNOTw=;
        b=Ea9JVpZIcizhTgTYlBJX2fVUaKbP0CnLMvvzIu6Ma4qZCpkA4Zbzyvk+B0xgmJHJuc
         /AUItSJ665Sj4ykfQ6nhIFK3/zbL3BIa+TY+8z7i8uBlYKwEa871jd2DIHymjnqhtn7M
         OzXQmQ0veBAGz3x7GQNy1NAiKuEjpYDMM3UNknxOaIjJxiNVVSwj2exA83U0Z/Nmpvdq
         NydZp5iaQixHMnNS/ItVluzL8YJa+ecMgb1OgNSA5F1hlDOwyyr/hnQoL9Srrk7VRPu0
         mAVTRVGbtu9Rr9wPVOfcpzwwA7UEGcVgJAWGwkU6b+vBnRWCvbWlYD/Y3yfqmx/9WSgW
         lrFg==
X-Gm-Message-State: AOAM531mYtbuZ5oMneeJiatGQNzdelKo/1uWAKsWRpVf67Dc/CpL1RLK
        SU+iVvy4Ld8fGtgobtwYk5aMlSeOyAg=
X-Google-Smtp-Source: ABdhPJyq/Xepgo8/6OP79ismqH9P0ePsxiRCe0nTJ19J50oo5g+37mqRX3WbEC47TgFeliE56SPwKw==
X-Received: by 2002:a17:90b:512:: with SMTP id r18mr7980605pjz.166.1610188387613;
        Sat, 09 Jan 2021 02:33:07 -0800 (PST)
Received: from localhost.localdomain (61-230-13-78.dynamic-ip.hinet.net. [61.230.13.78])
        by smtp.gmail.com with ESMTPSA id w200sm11691572pfc.14.2021.01.09.02.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 02:33:07 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org
Cc:     dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        will@kernel.org, catalin.marinas@arm.com, ardb@kernel.org,
        andreyknvl@google.com, broonie@kernel.org, linux@roeck-us.net,
        rppt@kernel.org, tyhicks@linux.microsoft.com, robin.murphy@arm.com,
        vincenzo.frascino@arm.com, gustavoars@kernel.org,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Sat,  9 Jan 2021 18:32:48 +0800
Message-Id: <20210109103252.812517-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
("kasan: support backing vmalloc space with real shadow memory")

Acroding to how x86 ported it [1], they early allocated p4d and pgd,
but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
by not to populate the vmalloc area except for kimg address.

Test environment:
    4G and 8G Qemu virt, 
    39-bit VA + 4k PAGE_SIZE with 3-level page table,
    test by lib/test_kasan.ko and lib/test_kasan_module.ko

It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL
and randomize module region inside vmalloc area.


[1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>


v2 -> v1
	1. kasan_init.c tweak indent
	2. change Kconfig depends only on HAVE_ARCH_KASAN
	3. support randomized module region.

v1:
https://lore.kernel.org/lkml/20210103171137.153834-1-lecopzer@gmail.com/

Lecopzer Chen (4):
  arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
  arm64: kasan: abstract _text and _end to KERNEL_START/END
  arm64: Kconfig: support CONFIG_KASAN_VMALLOC
  arm64: kaslr: support randomized module area with KASAN_VMALLOC

 arch/arm64/Kconfig         |  1 +
 arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
 arch/arm64/kernel/module.c | 16 +++++++++-------
 arch/arm64/mm/kasan_init.c | 29 +++++++++++++++++++++--------
 4 files changed, 41 insertions(+), 23 deletions(-)

-- 
2.25.1

