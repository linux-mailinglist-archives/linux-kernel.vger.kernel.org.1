Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0F21CDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 06:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGMEEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 00:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgGMEEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:04:32 -0400
Received: from localhost.localdomain (unknown [42.120.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F36B72068F;
        Mon, 13 Jul 2020 04:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594613072;
        bh=O+jw074gG5NLA3KWbpk115l+I7y00D2c/QoGxkEJctc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZSOc14oG4hnaC9gnGlXBLjLgW1e7oh/AvMg/2wPkCUZzMJGGrShuTD6vsnG3CTxTN
         UBXEh0zKh2Hqnjy+Wuc6vn/LXAc4YBYbAx6myCXZ4pBdOoIPKelbE8Qw0U6f5uPP3n
         Y/ZoqpjsdMnEhdfqQ1Mn/MQN74AftungizjGvFi4=
From:   guoren@kernel.org
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] arm64: Make TSK_STACK_CANARY more accurate defined
Date:   Mon, 13 Jul 2020 04:03:33 +0000
Message-Id: <1594613013-13059-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

TSK_STACK_CANARY only used in arm64/Makefile with
CONFIG_STACKPROTECTOR_PER_TASK wrap. So use the same policy in
asm-offset.c.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/asm-offsets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 0577e21..37d5d3d 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -39,7 +39,7 @@ int main(void)
   DEFINE(TSK_TI_SCS_SP,		offsetof(struct task_struct, thread_info.scs_sp));
 #endif
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
-#ifdef CONFIG_STACKPROTECTOR
+#ifdef CONFIG_STACKPROTECTOR_PER_TASK
   DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
 #endif
   BLANK();
-- 
2.7.4

