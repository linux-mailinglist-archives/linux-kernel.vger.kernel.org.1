Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DBD28A521
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgJKDEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 23:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgJKDEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 23:04:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5EC0613D0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 20:04:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p11so6584091pld.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qO6nuQUyuGyserco0gU3gcCQDY2NGTr1pWvbXyeqv+A=;
        b=t81ebUlJb42YhvlO/hFbSD98Qc9uHt47kxM/QdCwPpQt1acNswG6v9rINqAsVk4P9D
         t5u06PBpJEIixpXlFfwGiENCo9fwl34i999jJpl34iu5YA+GrgTMUsZj8GXGdC1SsmdM
         niRjVe+2F21FJwvW4owFYNKJrO7gJ2/aum0vaiokMrF9k5AuADRWBhd8c6PeN8t986N8
         6AdUCfG5tehKX+po5fqEIJ83DPRPl90Wo+yxQ1CI0nc/FPV0v4HDjicCM/5MlIHc4pFY
         3LgvYC/WGHh9i+qrfIIBLhT0VqREGV+TKL8qi0j12XLq0DMunMIrd/WrO5UzDW31Isci
         nWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qO6nuQUyuGyserco0gU3gcCQDY2NGTr1pWvbXyeqv+A=;
        b=YKkLS4hYytpaYjf2Wf7rLDtEv2CgQAGUaMmGR5BmltF0u42bvXWMlNrRn+3BD46dNn
         8WemXBcUcjZrfsCtA09FHLJkY87EHX4jRufMx9jxyNxCfMmQZlTdMz2S/7vPd7jFVJoY
         L4Uoay17lNh/6vTtDdp4gSF3n1pi+fJllt/3nxUHZJD0kqTImhioCvfe8TzpQxMNI6Qo
         gwax+3OY5ekDut8zbFkPX3+lmZ1DkmUbGaPjgxy34oFLXWgqFBXRucbfPSkWAtVm4ar/
         Ne2xrQkNMXqBseU8Qdo12yefinIBxPZDp0sdmIGEHmaaaDVMk9xYN2d0NMVSNbxHWUJm
         l7vQ==
X-Gm-Message-State: AOAM5326ePfz64RviH0V01h7LaD7fgI8YgXurAt9DxMEKzoc2a+63H+M
        Vnch1XL6lQfakVawr89x2To=
X-Google-Smtp-Source: ABdhPJyehudg9KH8YKCqKKFWN3Sq5s9woTPhA1B1g5ujCDIm+hymvjVj3M+KVTvzLxt3dAnRdn7AWg==
X-Received: by 2002:a17:902:b611:b029:d3:89e2:7957 with SMTP id b17-20020a170902b611b02900d389e27957mr18227295pls.19.1602385493628;
        Sat, 10 Oct 2020 20:04:53 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-95-82-187.san.res.rr.com. [70.95.82.187])
        by smtp.gmail.com with ESMTPSA id m4sm14601218pgv.87.2020.10.10.20.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 20:04:53 -0700 (PDT)
From:   Ryan Kosta <ryanpkosta@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ryan Kosta <ryanpkosta@gmail.com>
Subject: [PATCH] risc-v: kernel: ftrace: Fixes improper SPDX comment style
Date:   Sat, 10 Oct 2020 20:03:51 -0700
Message-Id: <20201011030351.4619-1-ryanpkosta@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Kosta <ryanpkosta@gmail.com>
---
 arch/riscv/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 99e12faa549..765b62434f3 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2013 Linaro Limited
  * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
-- 
2.20.1

