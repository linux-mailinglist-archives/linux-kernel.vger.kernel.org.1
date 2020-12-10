Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD73F2D5374
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 06:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgLJFsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 00:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgLJFsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:48:35 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC99C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 21:47:55 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so2227575plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 21:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqfQ0H085YyswsYjlG/LMOHHjFKZeIKe7fDW3bYC1us=;
        b=OvqJ9Zo8LX6mbR4YCHZnxCYrjii0KcrLAcheqfJTH/hDLLalPwKyZO1dBRXao0njA8
         Q6mqqRqhw6h1jL1f7HSkhN8ehGx9LxrjSgxPjhwHi0/UJnLHLHj6wF1oqRy/ATVohoFB
         kO94h2ihLj0RvLSYcJpKqinZ7cjAl6HqLMzf+jfsPYy/z0QV1EhOyTxDhD2f2OIAVNdY
         5fiBPCDwzDItFmdKdkciNCst7GPCRFVZ1lvYBIXVGLU7t8IZDbDlf+NjF8InjB1rLpFQ
         Den4/sB+K9mVTFrKkkIzTlfz4zov1Op657fB2JVljUCf9TNzyrOJfKAzm2abSrN6Ap9k
         eX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqfQ0H085YyswsYjlG/LMOHHjFKZeIKe7fDW3bYC1us=;
        b=jB4vKRBK4Az//E0vazI6ey3BdEqwdSVofktoaIUgt1LM7l6zr3akTeyvAgcndkM/p8
         ck/1nOy81v/uZaQ8jlIOghuQGKNZFzsnHZTp2tY5QaWz2iLzIjgMa7cby154sDHLsS5d
         +nAkInpLgev4jzKhdP82ZLC5edDxH+CoKAzO6gF/u57F0iLhrrPI4c90YgnCkNNt6Oou
         qsHwHU+pk7vwvxLcH4QG6JGYaBXwB17/P7VfClg6HMRDh+dCqFKsPoz0vQoCEHuEKC4m
         4C8x9m+helMF4oQ4wuCSIIJZrwo+3KATFbIA9YANWeOXs8zkKS7oKbU2tZvZARRZcE6E
         jjqg==
X-Gm-Message-State: AOAM530L60OjOsdq2EL4tkxkBIZlUC6uQqQqWSDAmL9iHTp76LDJa8pO
        FdMLTxns4Cy6iGedV52ujr+t4ZEPKd2qsg==
X-Google-Smtp-Source: ABdhPJz9s3He4dsrbNUL30WbsEGDj6KL5BGM9k6vFnpjcv6B2364ws+25ls9tFXDIqoWWd4cKy3WmA==
X-Received: by 2002:a17:902:8649:b029:d9:fcd9:522a with SMTP id y9-20020a1709028649b02900d9fcd9522amr5231708plt.83.1607579274879;
        Wed, 09 Dec 2020 21:47:54 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id h11sm4456652pfn.27.2020.12.09.21.47.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 21:47:54 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: topology: Drop the useless update to per-cpu cycles
Date:   Thu, 10 Dec 2020 11:17:40 +0530
Message-Id: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous call to update_freq_counters_refs() has already updated the
per-cpu variables, don't overwrite them with the same value again.

Fixes: 4b9cf23c179a ("arm64: wrap and generalise counter read functions")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index c8308befdb1e..f6faa697e83e 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -314,7 +314,7 @@ void topology_scale_freq_tick(void)
 
 	if (unlikely(core_cnt <= prev_core_cnt ||
 		     const_cnt <= prev_const_cnt))
-		goto store_and_exit;
+		return;
 
 	/*
 	 *	    /\core    arch_max_freq_scale
@@ -331,10 +331,6 @@ void topology_scale_freq_tick(void)
 
 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
 	this_cpu_write(freq_scale, (unsigned long)scale);
-
-store_and_exit:
-	this_cpu_write(arch_core_cycles_prev, core_cnt);
-	this_cpu_write(arch_const_cycles_prev, const_cnt);
 }
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-- 
2.25.0.rc1.19.g042ed3e048af

