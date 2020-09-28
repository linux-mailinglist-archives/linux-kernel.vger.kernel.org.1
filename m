Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F28627AE18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1MpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1MpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:45:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F7C061755;
        Mon, 28 Sep 2020 05:45:07 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i26so8246190ejb.12;
        Mon, 28 Sep 2020 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eDbNGoXjUOxyTq/2/7gQ4AH74xLZ8mTu0ngi+MaAE+k=;
        b=uCS0qWvuD09wigPlBYfAAAyoZyfjUT2Xc99XxqOxnCIlYvflGWoHp0ftk6mZH5d/uT
         3Q5APB8NEVGPO20LVhDzCsYjZACyTTRbVfXtTp9ttdpHA+8P+WIwl0wBdAQXlumqmfid
         prEWKXdYRBu6R2rDyNiN+EM4Whl6dk3xbOhxSvs2rmI2rzxjo1EbwIWjgPhmmwS0SDhz
         NjYspqFgLLmxjrijp5cYue/6BehuzCNHBInqzGbbw46DaPO+BPYv6kotgwRBQPGQ8uFw
         I7YROKBUhceRMTsDZHCKtWzjjmQ8/Rcz8scWhZCYqgg01BbE8tCpTZ0J217sajEvMiUt
         8DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eDbNGoXjUOxyTq/2/7gQ4AH74xLZ8mTu0ngi+MaAE+k=;
        b=eA0QukvaPZ9dK6D52lS6yQyDsca2QDby1+1CVYz2L+FeGbBUIJ0Q23sBvvP57wIvbT
         h6AD5JYvvfZ05hnik7gxVqWKoPrtFkhqkcy2xGJQaks5FA466p2osaNlpEb3wL4GPy6z
         qfjd0+2bunMFeLXMzH3wJH2cMg9lBKvMbGeU3yCqunJfkpyVqrP4oxm843tuQXK5PUVK
         hATjtZl34lh6ziVcYXXAFsXNuYxc861zZeacR/m+obNCujZjumPQ/isSDQ9h86WMvhJC
         vjZpwKJJqVf4yXi0W17cYiygSvlGvM4qRi/bqVOUnM/9aNyqsMlYycsbs0I/0vFS6WLR
         3Vhg==
X-Gm-Message-State: AOAM533quDL6444zjz3J6OniXf9b6thhop+CYes023yvxk7h9hHO+sm7
        QtNJ3jps92eLdesXeo3toZ8=
X-Google-Smtp-Source: ABdhPJwrcAeGcgwC0x4c6zDkB9w6jAFa372e6W6yiAT/BrBcUqZaC6/RpiOAZ9gQGwQKzlOFDOyv0w==
X-Received: by 2002:a17:906:1192:: with SMTP id n18mr1527579eja.515.1601297106102;
        Mon, 28 Sep 2020 05:45:06 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d9d:5000:7872:7299:adfa:b749])
        by smtp.gmail.com with ESMTPSA id m4sm1589214ede.70.2020.09.28.05.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:45:05 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH -next for tip:x86/pti] x86/tlb: drop unneeded local vars in enable_l1d_flush_for_task()
Date:   Mon, 28 Sep 2020 14:44:57 +0200
Message-Id: <20200928124457.27289-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b6724f118d44 ("prctl: Hook L1D flushing in via prctl") checks the
validity for enable_l1d_flush_for_task() and introduces some superfluous
local variables for that implementation.

make clang-analyzer on x86_64 tinyconfig caught my attention with:

  arch/x86/mm/tlb.c:332:2: warning: Value stored to 'cpu' is never read \
  [clang-analyzer-deadcode.DeadStores]

Compilers will detect these superfluous local variables and assignment and
optimize this anyway. So, the resulting binary is identical before and
after this change.

Simplify the code and remove superfluous local variables to make
clang-analyzer happy.

No functional change. No change in binary with supported compilers.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20200925

Balbir, please review and ack.
Thomas, please pick this minor non-urgent clean-up patch into the x86/pti
branch of tip as follow-up to: 
https://lore.kernel.org/lkml/160026187842.15536.285514864386042510.tip-bot2@tip-bot2/

I quickly confirmed that the binary did not change with this change to the
source code; The hash of tlb.o remained the same before and after the change.

So, in my setup:
md5sum tlb.o
7c7e096bab0fd87bd2c8437d8c7dc3fa  tlb.o

linux-safety, please verify and validate this change.

 arch/x86/mm/tlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6b0f4c88b07c..90515c04d90a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -316,7 +316,7 @@ EXPORT_SYMBOL_GPL(leave_mm);
 
 int enable_l1d_flush_for_task(struct task_struct *tsk)
 {
-	int cpu, ret = 0, i;
+	int i;
 
 	/*
 	 * Do not enable L1D_FLUSH_OUT if
@@ -329,7 +329,7 @@ int enable_l1d_flush_for_task(struct task_struct *tsk)
 			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
 		return -EINVAL;
 
-	cpu = get_cpu();
+	get_cpu();
 
 	for_each_cpu(i, &tsk->cpus_mask) {
 		if (cpu_data(i).smt_active == true) {
@@ -340,7 +340,7 @@ int enable_l1d_flush_for_task(struct task_struct *tsk)
 
 	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
 	put_cpu();
-	return ret;
+	return 0;
 }
 
 int disable_l1d_flush_for_task(struct task_struct *tsk)
-- 
2.17.1

