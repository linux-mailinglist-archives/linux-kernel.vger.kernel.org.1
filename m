Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3AD2FC314
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbhASWM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbhASWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:08:55 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661EBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:08:15 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 11so13160461pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEjzhBF98dbnk/5sluVZcbU0ionst0PLBmFjjcrt57Y=;
        b=ifhiFkSVwmYAsIe1NEgU5OALrc/J1v23nOR45sANQBnTdYx1fozTj2YZ15HE9Y0h5n
         265nWrcPvnLDq0tp9Rsb9uqbjPvnStApYh+UYe073uI4h4sf4MuayxPQHconDOJ2SJyv
         mG7Dg1hx0g7qmaMdqRcojS7WunD9wEJ5hFRpDaZLGxwrg4ogoHHObswAB6W4pO3sNX4v
         eQwBDl8UCudP8e6Fi52iq+Wgu0J9uk34V0hecy1BB00mfqlxpn93pQYuYK7HK6S2IYX2
         yf3H1cl7hQhwoITK5G505Fr3Pt0jfBTfRumNm6R8EPMdJ4VU7vfS/MKT8OnFx5yleor2
         wV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEjzhBF98dbnk/5sluVZcbU0ionst0PLBmFjjcrt57Y=;
        b=MO4bXV7TFxw02Fl7fggIU9kC/DrjnYyM3Vg4gZ+RbXLaRoaz8/ewYYS16mM5FdWJAs
         zgPsPLPT/+O8ah2ZHiEtsVvloq8Ek8G/a853rGDvnutQMxOULKdPObhQXKk1q1PPWpaP
         nxB46PSGOm+KCN7eolNmXfBJiF/SfK/I8fO0eaWOnSjIoW31vIsNyfeA/1Sm9xNJ/ELw
         AlWxTemc7f5AuaORfRrG2fHtmc3hHGk0Y3uKR6nqXdqB3Z4nnDoBAShDotg1cqAb2Z3I
         furDNwiaTVQwoP+HffJ4S/LhKzsOX/Jbc5q23bwOGnEk6klj6LwKDntIx0AZuIFsrzqQ
         rc4g==
X-Gm-Message-State: AOAM533Hcu9QsukUsQ2Oz4o8ePsloLlg/hFWBYreaB1b9YpiAPhrOpbp
        Z+cQ23chkxY5iknLKEsuDok=
X-Google-Smtp-Source: ABdhPJx6MCEYaTID6s+WBoU2uXbCUoUXXBLV2f8FF4ky28Djnk9NNEUtda6tRGnAf8LPk7FFWow5dA==
X-Received: by 2002:a63:e22:: with SMTP id d34mr6305898pgl.142.1611094094931;
        Tue, 19 Jan 2021 14:08:14 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id 72sm95196pfw.170.2021.01.19.14.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 14:08:14 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/3] arm64/ptrace: introduce NT_ARM_PRSTATUS to get a full set of registers
Date:   Tue, 19 Jan 2021 14:06:36 -0800
Message-Id: <20210119220637.494476-3-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119220637.494476-1-avagin@gmail.com>
References: <20210119220637.494476-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an alternative to NT_PRSTATUS that clobbers ip/r12 on AArch32,
x7 on AArch64 when a tracee is stopped in syscall entry or syscall exit
traps.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/ptrace.c | 39 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1863f080cb07..b8e4c2ddf636 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -591,6 +591,15 @@ static int gpr_get(struct task_struct *target,
 	return ret;
 }
 
+static int gpr_get_full(struct task_struct *target,
+		   const struct user_regset *regset,
+		   struct membuf to)
+{
+	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
+
+	return membuf_write(&to, uregs, sizeof(*uregs));
+}
+
 static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
@@ -1088,6 +1097,7 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
 
 enum aarch64_regset {
 	REGSET_GPR,
+	REGSET_GPR_FULL,
 	REGSET_FPR,
 	REGSET_TLS,
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
@@ -1119,6 +1129,14 @@ static const struct user_regset aarch64_regsets[] = {
 		.regset_get = gpr_get,
 		.set = gpr_set
 	},
+	[REGSET_GPR_FULL] = {
+		.core_note_type = NT_ARM_PRSTATUS,
+		.n = sizeof(struct user_pt_regs) / sizeof(u64),
+		.size = sizeof(u64),
+		.align = sizeof(u64),
+		.regset_get = gpr_get_full,
+		.set = gpr_set
+	},
 	[REGSET_FPR] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_fpsimd_state) / sizeof(u32),
@@ -1225,6 +1243,7 @@ static const struct user_regset_view user_aarch64_view = {
 #ifdef CONFIG_COMPAT
 enum compat_regset {
 	REGSET_COMPAT_GPR,
+	REGSET_COMPAT_GPR_FULL,
 	REGSET_COMPAT_VFP,
 };
 
@@ -1285,6 +1304,18 @@ static int compat_gpr_get(struct task_struct *target,
 	return 0;
 }
 
+/* compat_gpr_get_full doesn't  overwrite x12 like compat_gpr_get. */
+static int compat_gpr_get_full(struct task_struct *target,
+			  const struct user_regset *regset,
+			  struct membuf to)
+{
+	int i = 0;
+
+	while (to.left)
+		membuf_store(&to, compat_get_user_reg(target, i++));
+	return 0;
+}
+
 static int compat_gpr_set(struct task_struct *target,
 			  const struct user_regset *regset,
 			  unsigned int pos, unsigned int count,
@@ -1435,6 +1466,14 @@ static const struct user_regset aarch32_regsets[] = {
 		.regset_get = compat_gpr_get,
 		.set = compat_gpr_set
 	},
+	[REGSET_COMPAT_GPR_FULL] = {
+		.core_note_type = NT_ARM_PRSTATUS,
+		.n = COMPAT_ELF_NGREG,
+		.size = sizeof(compat_elf_greg_t),
+		.align = sizeof(compat_elf_greg_t),
+		.regset_get = compat_gpr_get_full,
+		.set = compat_gpr_set
+	},
 	[REGSET_COMPAT_VFP] = {
 		.core_note_type = NT_ARM_VFP,
 		.n = VFP_STATE_SIZE / sizeof(compat_ulong_t),
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 30f68b42eeb5..a2086d19263a 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -426,6 +426,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
 #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
 #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
+#define NT_ARM_PRSTATUS		0x410   /* ARM general-purpose registers */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
-- 
2.29.2

