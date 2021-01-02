Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA522E877B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 14:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbhABN0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 08:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbhABN0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 08:26:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF2A0224D2;
        Sat,  2 Jan 2021 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609593942;
        bh=TVsidi0zzSt/PgVGHSye3zjeAkDC4WSqDayvsSzjYbE=;
        h=From:To:Cc:Subject:Date:From;
        b=etiRHgnGy4cY/GQAen8hsZsp0G2TlXhAWwSmpk6YPupEvE8OAY4/t6ZoObClBymsG
         tEFudifXAeESBt8pyZTKKZBKg8KUFFT0fNjSZzKqQpPbE6+i+u85lBccXkqbz51E6B
         d4NQpqKMTiqKMBJznTqoC/Q7NE9eLPYZ+RQyUsRoJrNHtol8EVUOmm5u3aaxGsWt/F
         MXXuYjMRi8ss1VQt8lpKu4QZuCSWL4DC/QI70NTXGjXhu3Hu4oM0iOml4YqzpqwsWw
         rOIKb2J19ViqEYkBQdOX2pIkTdWrhWnOhC/GPu8X3wXumS9RlAWYxCH/C6uHSUoCo0
         DwMchROSS1NMA==
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH] riscv: Fixup CONFIG_GENERIC_TIME_VSYSCALL
Date:   Sat,  2 Jan 2021 13:24:34 +0000
Message-Id: <1609593874-64422-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The patch fix commit: ad5d112 ("riscv: use vDSO common flow to
reduce the latency of the time-related functions").

The GENERIC_TIME_VSYSCALL should be CONFIG_GENERIC_TIME_VSYSCALL
or vgettimeofday won't work.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/vdso.h | 2 +-
 arch/riscv/kernel/vdso.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 8454f74..1453a2f 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -10,7 +10,7 @@
 
 #include <linux/types.h>
 
-#ifndef GENERIC_TIME_VSYSCALL
+#ifndef CONFIG_GENERIC_TIME_VSYSCALL
 struct vdso_data {
 };
 #endif
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 6782042..3f1d35e 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -12,7 +12,7 @@
 #include <linux/binfmts.h>
 #include <linux/err.h>
 #include <asm/page.h>
-#ifdef GENERIC_TIME_VSYSCALL
+#ifdef CONFIG_GENERIC_TIME_VSYSCALL
 #include <vdso/datapage.h>
 #else
 #include <asm/vdso.h>
-- 
2.7.4

