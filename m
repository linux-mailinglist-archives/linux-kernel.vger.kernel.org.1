Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1EE2808EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbgJAU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C142C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 13:59:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5D3A329D101
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 4/9] x86: elf: Use e_machine to choose DLINFO in compat
Date:   Thu,  1 Oct 2020 16:58:14 -0400
Message-Id: <20201001205819.27879-5-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001205819.27879-1-krisman@collabora.com>
References: <20201001205819.27879-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since TIF_X32 is going away, avoid using it to find the ELF type on
ARCH_DLINFO.

According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
differentiate a x32 object from a IA32 object when loading ARCH_DLINFO
in compat mode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index b9a5d488f1a5..9220efc65d78 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -361,7 +361,7 @@ do {									\
 #define AT_SYSINFO		32
 
 #define COMPAT_ARCH_DLINFO						\
-if (test_thread_flag(TIF_X32))						\
+if (exec->e_machine == EM_X86_64)					\
 	ARCH_DLINFO_X32;						\
 else									\
 	ARCH_DLINFO_IA32
-- 
2.28.0

