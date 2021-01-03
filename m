Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EF02E8D8F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 18:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbhACRNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 12:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbhACRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 12:13:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B315DC0617B9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 09:13:02 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id h186so14915407pfe.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 09:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJN/Pu+8mLKZ+B4Z+Om7De+VUDyUCro4rXn59AnfrE4=;
        b=GJ5A/1auzoduEeasEqtvu6hr2Gs+drY4Z01k6WXJ2D0EaD0TxZpf80iuC/SBcfu7Kb
         hXyPC3xEMoHL/mgBh6vg/GZfWEibhw/I4yDdJRXQ8Yt9oW/rFji7DYEgtbvRlAKYL4By
         b/gJD/6JFcbSBIpVUjlL6DhJ5fhxZTR7Sla9lgdVXU1mMNFIKRm5anKzzOVNDwfXX1XU
         gCDzb2f6wfp4r9vsDorKGW3kakon1w2NTvb/PUjFtuPv+ghU1N5U9Dcn6V+zl7GFCwr5
         9myPOPcGdnFPuk9yF/SSMGbjOnj0N29Z3+HjPDhCf05bEwLSdjP3BpbLNi0UnIHBwFf6
         zePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJN/Pu+8mLKZ+B4Z+Om7De+VUDyUCro4rXn59AnfrE4=;
        b=HwG9pFP1NPvGqqUcyIK72xtU1hn9+B4+lS2HxEsadpjSit08T7flV5xJ9KS+Mmx3ho
         nzKzL2Hq+EKc92o4iAB7yR/UDdy09VtQxg16LRsLYt8pPqPzmJ4zUR96eVD1M7HaggYs
         z/XmuH5pJsFDEAqu7PwusQcz9u+wE85SzrZ8kVRqUDN06vP4B4ux+UG5N5vQshiFUOM+
         /+3Xd22md6A5rrhd2z1fN8KFKHtig2uXo0b+yRMuiNGywsBzeeTKrnhhbWOP3FOnkmgX
         X2z1cU4NDd9LsouMQuuQQSxfYJk6uq74e9jmdanDly50lQhNDG+yP63AJl9SE1pFYcUg
         UuEA==
X-Gm-Message-State: AOAM530QY0WS1rrorVkswAiJv5DrLUWZ1EE8+vIfYo4pMUiaMWRCjJD4
        HNOddXQD8E0vUQkH9BUpdqvJXSzs/ng=
X-Google-Smtp-Source: ABdhPJyrjwRxNiXYf74ApoL/95Jw1Unu7nMqfXQ+KrD97MJV6r4/uJZcqZdl4vapaCluE9JG/ag4iQ==
X-Received: by 2002:aa7:86d5:0:b029:1a3:61b6:9c1 with SMTP id h21-20020aa786d50000b02901a361b609c1mr61911995pfo.55.1609693982185;
        Sun, 03 Jan 2021 09:13:02 -0800 (PST)
Received: from localhost.localdomain (61-230-37-4.dynamic-ip.hinet.net. [61.230.37.4])
        by smtp.gmail.com with ESMTPSA id y3sm19771657pjb.18.2021.01.03.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:13:01 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org
Cc:     dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        will@kernel.org, catalin.marinas@arm.com,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH 3/3] arm64: Kconfig: support CONFIG_KASAN_VMALLOC
Date:   Mon,  4 Jan 2021 01:11:37 +0800
Message-Id: <20210103171137.153834-4-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103171137.153834-1-lecopzer@gmail.com>
References: <20210103171137.153834-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now I have no device to test for HW_TAG, so keep it not selected
until someone can test this.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 05e17351e4f3..29ab35aab59e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -136,6 +136,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_VMALLOC if (HAVE_ARCH_KASAN && !KASAN_HW_TAGS)
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KGDB
-- 
2.25.1

