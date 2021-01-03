Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C432E8D85
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 18:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbhACRNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 12:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbhACRNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 12:13:20 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC75C0613C1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 09:12:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n25so17260321pgb.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 09:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/GeiIxcJ64ZQ6SmObKp07RN0gB/xHVcCELrAtFy6J8=;
        b=j9nC8spDRsbKIqITtcFVK5qfNVqGd72bWGhC3L39q82R8010SlWb58g4xtF50sisUa
         CfMxfvTnGgeJKwMLbxYvaE5kCZi0IvGeR3BidI8+fAl8OE1m9ex3PjGA7l5UqpCdsT8S
         CClk/1SFkcl8k97Jxq7SWRUVMGeCADSH2ApMpuinr1XvsQiYSvwvzasCmOh+FDJUp0Om
         TodXjnTwaBrW6MTUzvvXn9BG1fUoJ7hC0QKUOPOOXCdJtwB3gmstUWRzTpxCBS6Pdftp
         tj0cJiWF3qGNKeBorCQmV3YLO1jiIhCt7sTf6RH4bjvwmI5zU4UBNxMvwPLlw0T5wOYt
         PsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/GeiIxcJ64ZQ6SmObKp07RN0gB/xHVcCELrAtFy6J8=;
        b=o4AA8E1uHkNYKZj18e6gAxtyoFbvpKQB5ZwoS5t7Pkw3z94q4yR1lGFwDcgj6k/9uU
         AcldvE8n3RjU1MoYt7XQBSFd1oZhIobJRwSWEM6OC2mtM44yEg0HmdhCF9Y97n+tFZEC
         +bdogh6kB8I3a8+l/ReSs/hq6e04YYPpzlk/PeOGE3+KvUWSAt6022cVLTImRQ+T5wt6
         iMxVkCbt1K2wdmBqVaIKgFQppuHOlrp6AUf0P0m+89muy+EhlT6W3jgko5F4pU4WJKG9
         3ZRbTq1qc0BK4gxX2nO+5Z/wLZkYdZPVmXhinkN4wP+iViNdAg0ZIhU2s8kPrBInwypk
         E8yQ==
X-Gm-Message-State: AOAM533IqjmeOBOnIrU0xC5Lt5o+OgKkJbjKECoDD1uUhbP6EfnEY/WE
        iNdY44/WGko7STh6rVztTi/C+vkOZrA=
X-Google-Smtp-Source: ABdhPJwVkKI1/s0n073MJPATBjaxsZ36JasEetjbvlDaf7VaG92vb5iUjgmHPzD5NvQlqz5H++LpZA==
X-Received: by 2002:aa7:9619:0:b029:1ae:33b2:780f with SMTP id q25-20020aa796190000b02901ae33b2780fmr7380595pfg.26.1609693951614;
        Sun, 03 Jan 2021 09:12:31 -0800 (PST)
Received: from localhost.localdomain (61-230-37-4.dynamic-ip.hinet.net. [61.230.37.4])
        by smtp.gmail.com with ESMTPSA id y3sm19771657pjb.18.2021.01.03.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:12:31 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org
Cc:     dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        will@kernel.org, catalin.marinas@arm.com,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH 0/3] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Mon,  4 Jan 2021 01:11:34 +0800
Message-Id: <20210103171137.153834-1-lecopzer@gmail.com>
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

It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL,
but not test for HW_TAG(I have no proper device), thus keep
HW_TAG and KASAN_VMALLOC mutual exclusion until confirming
the functionality.


[1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>


Lecopzer Chen (3):
  arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
  arm64: kasan: abstract _text and _end to KERNEL_START/END
  arm64: Kconfig: support CONFIG_KASAN_VMALLOC

 arch/arm64/Kconfig         |  1 +
 arch/arm64/mm/kasan_init.c | 29 +++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.25.1

