Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4002F21AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbhAKVVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbhAKVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:21:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE360C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:21:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i9so248751wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEFDDHpww4S7jZVTaZD1icQ+na1aoV8Oo3KDfAMEdTk=;
        b=FK6zjLr4+E02JhNbMuXyh1qxoOhquU2JANb2OZm5+JP/nhIfFq6Fz2sYDDAVkW9aOw
         WLh5iRnl6EzlEiJzp9EHuFt05i+yP3VSFFr9z0eYz4zAJQZ3vCrKASMRirbwW9PKai81
         RfDGz/YouiXKy6UHlgMrsBs/By8zRfs5aBovI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEFDDHpww4S7jZVTaZD1icQ+na1aoV8Oo3KDfAMEdTk=;
        b=dKTSMsmrggf8DIzitc8+fpuZfI4EaTgnrDqqO0ADxd49qkPmmOiibp9+MGs//gLsKl
         sxS2kFjPtT+n8DSPrhA9RXfMsAnb6aGd59coX2kbEn4y0WBDuYp3mmy33+DcgZtxVbGC
         OpafhYJZ7b2oIFcAnqyRNgQmgY2L+Pd9S886VTLLKUosrcIcHmcj+6dKnwML6Qre3mSw
         OkNeH3scCkhPF9Hifp5CjLm88okilLWtDaRl7cOz3/jR0fUduBbx3tCdilSyDXiEPDds
         mbTK+9t9y/Jln4fu7K7FWK4Vhi7q/KzgpUCQQ845Fuc2FizL4LB3R6VAhTtR/dqwBVwh
         6JOQ==
X-Gm-Message-State: AOAM530pMX2EPhAOigh7ZKFE+6bClNu+7vYZ0+YvuWoKFHznNh5Qq4zl
        /SVr3eiJmK+1Ngs0i7HsRjMldA==
X-Google-Smtp-Source: ABdhPJxbI6qQSX+hgbuH8BGJTIUzRTH2XlCvZ2Conpe5ZrK82kVNAVyLheeTcmABEY4tEuX3KlAnpQ==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr976097wre.408.1610400064586;
        Mon, 11 Jan 2021 13:21:04 -0800 (PST)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id o74sm808960wme.36.2021.01.11.13.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:21:03 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        damien.lemoal@wdc.com, devicetree@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH] RISC-V: simplify BUILTIN_DTB processing
Date:   Mon, 11 Jan 2021 23:20:32 +0200
Message-Id: <20210111212031.2422-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide __dtb_start as a parameter to setup_vm() in case
CONFIG_BUILTIN_DTB is true, so we don't have to duplicate
BUILTIN_DTB specific processing in MMU-enabled and MMU-disabled
versions of setup_vm().

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 arch/riscv/kernel/head.S | 4 ++++
 arch/riscv/mm/init.c     | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 16e9941900c4..f5a9bad86e58 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -260,7 +260,11 @@ clear_bss_done:
 
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
+#ifdef CONFIG_BUILTIN_DTB
+	la a0, __dtb_start
+#else
 	mv a0, s1
+#endif /* CONFIG_BUILTIN_DTB */
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5b17f8d22f91..45faad7c4291 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -615,11 +615,7 @@ static void __init setup_vm_final(void)
 #else
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-#ifdef CONFIG_BUILTIN_DTB
-	dtb_early_va = (void *) __dtb_start;
-#else
 	dtb_early_va = (void *)dtb_pa;
-#endif
 	dtb_early_pa = dtb_pa;
 }
 
-- 
2.20.1

