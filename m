Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27622EFEFB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 11:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbhAIKeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 05:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAIKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 05:34:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B879C0617A3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 02:33:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f14so5028325pju.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLn/SnoBrp3vqZ9sozuXKpJ43I84HTjowTO19xhLeG0=;
        b=AG/rOYoYRKgzWfqA56Rn+dg5UnJabvU6av5xhDPFM2zF5AyoVz1q4ouIgLU0rUwCf3
         GE8L0v5F5suRbnCEyfCMP1LYdLPT803JePm75nQeC45cv+2eRuIQcfrmVMx5rrX+vPmY
         VT7lek/olVSJGVT0tcb00utrd6oGbaL5pHfK6zrQOtvzLyTdtYKbTpRrbv9AlKg09v8V
         0HPUv2qKxgiSlO55/8VstzjDuZ/VK/nPdFqQyg4lXo/KwkkrKd+FfsCQ4tcvXso/m+9A
         IOk1rWNImSptf2gNWjE//OXdLb34y0erVoZB4eVGCeMN2E52fpzqD9DIII2Fd+vuN3ZQ
         3eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLn/SnoBrp3vqZ9sozuXKpJ43I84HTjowTO19xhLeG0=;
        b=L+K+S5BbGz5LIK+MWQfYiHUJuxScfvzt+ay3I7rmLY5quHHsN+SpeFD5SSVnKTZNmH
         eezdlzP4YWAC4LM5rWHBl85TWba5gwT1Pn4FrBGgEnfa7Jp0kv8OfE5rewgjiHwlLnMk
         zZFBgVz4/sHR6PgX9AQ8L73uYudXcwqCthnHtw7VIGWLX34qX2ucthW3kEO8u+NlRS1f
         Bm/EC52OJhJJp4LOWAMv5d5KuXovTgNFUt8OBTbWK76pjQ6gHSAeiVFT+8j1+62o7iO+
         QXGQfKZME60PeE8BFzq7pu0hB89BCOhqI4rV1sIeE3maM7m5s/gPCTS5sxiOWY88hJuS
         0VUg==
X-Gm-Message-State: AOAM533t3kH0YjAXwI3J1xDz0Li7urJYChcDqES6Ke+Ilya/qQt5XhaD
        Z9kBgEsOn1PolRDOHEolMyyT9kEgw3MDjw==
X-Google-Smtp-Source: ABdhPJxIH5S3lPWz6xhxfymgG03a6AwgPQzKq4F2KcokdfmaTtrNpjtkVrmnEo0bgoXAa0A0Gz4I5Q==
X-Received: by 2002:a17:902:bb95:b029:dc:e7b:fd6e with SMTP id m21-20020a170902bb95b02900dc0e7bfd6emr11108147pls.12.1610188416663;
        Sat, 09 Jan 2021 02:33:36 -0800 (PST)
Received: from localhost.localdomain (61-230-13-78.dynamic-ip.hinet.net. [61.230.13.78])
        by smtp.gmail.com with ESMTPSA id w200sm11691572pfc.14.2021.01.09.02.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 02:33:36 -0800 (PST)
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
Subject: [PATCH v2 3/4] arm64: Kconfig: support CONFIG_KASAN_VMALLOC
Date:   Sat,  9 Jan 2021 18:32:51 +0800
Message-Id: <20210109103252.812517-4-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109103252.812517-1-lecopzer@gmail.com>
References: <20210109103252.812517-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

now we can backed shadow memory in vmalloc area,
thus support KASAN_VMALLOC in KASAN_GENERIC mode.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 05e17351e4f3..ba03820402ee 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -136,6 +136,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KGDB
-- 
2.25.1

