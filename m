Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9C2AAD64
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 21:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgKHUhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 15:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHUhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 15:37:45 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B808C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 12:37:45 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so6206727qkb.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWSW4z4tc076kKwNGtL/so7sEYIZnv1CKrVVWPooetI=;
        b=b74gdFy3pCe9zaPemkbiKhO3SwxwW0a3dLIX5XlpuDCn4Wo1SaMTTHVcGYBouJ1+Zj
         FiWq0xudKzDqpK+O0l+0zn7PZNSwZKNyGy7Z8Iaia4d9rqoWaA0IcG7cHFSxmdSMnSoU
         XaweMDexvhdhtXztS2WS5vMjDwHxsyKphb4Z/L29ixLXe/3e+ubCgkgBRl9wan1ROC/D
         kzDVu/Z2IhFcyN3CMlQ8NqEjkfRHo8xcf58iuxQH0oDVbxToT/qQOUNp+peoDb0g+41h
         EM9M+feP9dFB0CBScDGBdmsvxVGR0RkXZxBtivZtCA+fshPrSCAu4NGEckQ1LxyopaVT
         NKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWSW4z4tc076kKwNGtL/so7sEYIZnv1CKrVVWPooetI=;
        b=nIucEnFYgfjEGW0P++nd0fYPTTzGIaTc2v1R4lPXiGo5uGwVNwgLA7AAHwCzva2HpM
         L/gDlKfSV5Z/cP8DPhYamBpTK5KCJicaX6zkreG5obT7zYr/QrNAMeaFya2gnwj4PtuW
         w9GQNxTLSNbl7jLidbFPOy+RNFmTx03ABL1UUawhiKILSsz1IM9+aO+hg5SSqh3Ca2Zf
         dL4+1be+RtVK5YFlnF8xNjdwBiKQVcdxDrJ2WJzoIuYP9OxPlRyqPxO7Xb08s6SO/Vr1
         D+PnKmJ3yX4b9S0diwlAMorFjF86mGDbOJO2unUIWQnWHmUtvh3fRgQ1GE2OVm0kh2Eu
         Vt8Q==
X-Gm-Message-State: AOAM5308GmDbTkvp7NYe+T5R7cgh4LzwHqqBQ+a+LG9mqeK9tjaWSizH
        E/LM7a9tZ3g9c1wx9TW0zc4=
X-Google-Smtp-Source: ABdhPJyvfPVuTOdD+abYtY71MC+HK3WvITafyZ6+mJl5HWJMJv7ef5YsIyK62UMmNyzmiYg2QbJItA==
X-Received: by 2002:a05:620a:5a5:: with SMTP id q5mr2937252qkq.199.1604867864596;
        Sun, 08 Nov 2020 12:37:44 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id n6sm4849150qkk.6.2020.11.08.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 12:37:43 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] riscv: Explicitly specify the build id style in vDSO Makefile again
Date:   Sun,  8 Nov 2020 13:37:37 -0700
Message-Id: <20201108203737.94270-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a96843372331 ("kbuild: explicitly specify the build id style")
explicitly set the build ID style to SHA1. Commit c2c81bb2f691 ("RISC-V:
Fix the VDSO symbol generaton for binutils-2.35+") undid this change,
likely unintentionally.

Restore it so that the build ID style stays consistent across the tree
regardless of linker.

Fixes: c2c81bb2f691 ("RISC-V: Fix the VDSO symbol generaton for binutils-2.35+")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/riscv/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index cb8f9e4cfcbf..0cfd6da784f8 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -44,7 +44,7 @@ SYSCFLAGS_vdso.so.dbg = $(c_flags)
 $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
 SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
-	-Wl,--build-id -Wl,--hash-style=both
+	-Wl,--build-id=sha1 -Wl,--hash-style=both
 
 # We also create a special relocatable object that should mirror the symbol
 # table and layout of the linked DSO. With ld --just-symbols we can then

base-commit: c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c
-- 
2.29.2

