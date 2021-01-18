Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25DC2F99D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbhARGWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbhARGV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:21:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 361DC22583;
        Mon, 18 Jan 2021 06:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610950846;
        bh=/Y8ouPlqMWUZR7Fcd1lZA6ZxI0V0/5/SN2MiDQxmA8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J65M9sE1dMcL2dVpMxCmhu2TOg1q5jhYP1XaTHLWm4+tVJ1ad2hMDJGQQ9dUeEhpM
         rFMrZUW+vo29DJyyTOtlfVBpvcQRUgMLPvJuNP4Uu/UoQvxKTwEjIauMasnrMezU0T
         goG7MeibRwjSrZsm0c54R+3UOjxs47MBDYtme5jNwHMOOFx+hki1XdiOz1oFr0gAkf
         r4WdYbzeVowFeBinkCuY1/5hvNpxvXETioYjCVliCkw9D/gnfzLC1L5S1gowvtOAEe
         +TmrJwFWGRzJ9Pxq9frtqgXsSkUXG6lglStW59NkznbhS3WAfrCfQkLfa1+yhRy0/a
         LPK5Phgh8A5nQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4/4] x86/fpu/64: Don't FNINIT in kernel_fpu_begin()
Date:   Sun, 17 Jan 2021 22:20:41 -0800
Message-Id: <7f668aa760d847f8777371e03a39c4d6373f88ee.1610950681.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610950681.git.luto@kernel.org>
References: <cover.1610950681.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remaining callers of kernel_fpu_begin() in 64-bit kernels don't use 387
instructions, so there's no need to sanitize FCW.  Skip it to get the
performance we lost back.

Reported-by: Krzysztof Olędzki <ole@ans.pl>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/fpu/api.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index e95a06845443..6e826796a734 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -40,7 +40,19 @@ extern void fpregs_mark_activate(void);
 /* Code that is unaware of kernel_fpu_begin_mask() can use this */
 static inline void kernel_fpu_begin(void)
 {
+#ifdef CONFIG_X86_64
+	/*
+	 * Any 64-bit code that uses 387 instructions must explicitly request
+	 * KFPU_387.
+	 */
+	kernel_fpu_begin_mask(KFPU_XYZMM);
+#else
+	/*
+	 * 32-bit kernel code may use 387 operations as well as SSE2, etc,
+	 * as long as it checks that the CPU has the required capability.
+	 */
 	kernel_fpu_begin_mask(KFPU_387 | KFPU_XYZMM);
+#endif
 }
 
 /*
-- 
2.29.2

