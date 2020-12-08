Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3632D234F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 06:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgLHFrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 00:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLHFrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 00:47:35 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBCC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 21:46:55 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id v18so13065334qta.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 21:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=e1pDmuZWJgETEHbU+21FKLtGXbFndqwbo33SoyyNrOA=;
        b=I4pGl9G+/ClTNHjjMWUUmjtSXe/KWlnklWFAGVruixzJ9ve1HKTFph5J7/+L7CQ1eM
         enCTzlPt6VMoKaxfarFSHypXGTG5f2bXP7LSKasBrsZgIeaA3h7v3/jXSllSTmsrL9q4
         f0EMIhE+TrKstlvPRLehje0YKMuu99R62Oc58ziQV/oVRCfoMxpyQtmaQ/oVATruw8gx
         44dr+OlKv3K5cfIRBUcsGtV/XnXKbplNp6v9eB3FsnKqYLrym4w7yUmAMeaDwVMn5xRo
         FP+owZ35Kgp5aAbP/fCgsme+64nA8KZsWUmEWS14LmBNfBXDfTdPK51JcOZlzdcxZrI8
         U71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e1pDmuZWJgETEHbU+21FKLtGXbFndqwbo33SoyyNrOA=;
        b=poelaeK7mEQX27BrUpDka+Wlx1/5B6C3Oa3703Xjmjm+e4tXjsFoHXEoRvA3wgD2UC
         Ram3jVfzgxG16DLlajPVVQUFgPdKSwCZom9WB7j8lur/kj+56v6B8isTPiP9zi2e2FpH
         V3IwY7p6FJarOiozw4FpRbCBY3uaby5wJzNlPViubjultEX/43XqDYuyF+POrMGNc3HX
         8Qka+gcRWX+flQTbjer7rqE4JHW4PAE9HBOshQVT8/N/8gu8blEpCfnQ7ArTmVOu2ZKF
         3dTizeamS4VJBW76Na7f6I8gLWfEmuK+H72GFLqB/rS+Oja6Wny9ZKr+7t70Un2CCTYH
         1JlA==
X-Gm-Message-State: AOAM533SGCuvzqHdAZD8ltlB0707MBRW0l4WpLLJN3vp2+EMUD7XQ0YB
        MutCAOW4BJnMe6sQp+grZ0+hgy27ptnu
X-Google-Smtp-Source: ABdhPJyJCc0PRQKEaD0Sa/sjBmCtKwQ59nrH4O31YhEiHPcTt3PNHnsxhFeMkS19ZaunISqbWwS9B4Bc0nqH
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a0c:a8d4:: with SMTP id
 h20mr7977172qvc.52.1607406414446; Mon, 07 Dec 2020 21:46:54 -0800 (PST)
Date:   Mon,  7 Dec 2020 21:46:46 -0800
In-Reply-To: <20201203202737.7c4wrifqafszyd5y@google.com>
Message-Id: <20201208054646.2913063-1-maskray@google.com>
Mime-Version: 1.0
References: <20201203202737.7c4wrifqafszyd5y@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v2] firmware_loader: Align .builtin_fw to 8
From:   Fangrui Song <maskray@google.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 references the start address of .builtin_fw (__start_builtin_fw)
with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
relocations. The compiler is allowed to emit the
R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
include/linux/firmware.h is 8-byte aligned.

The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
multiple of 8, which may not be the case if .builtin_fw is empty.
Unconditionally align .builtin_fw to fix the linker error. 32-bit
architectures could use ALIGN(4) but that would add unnecessary
complexity, so just use ALIGN(8).

Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
Link: https://github.com/ClangBuiltLinux/linux/issues/1204
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fangrui Song <maskray@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

---
Change in v2:
* Use output section alignment instead of inappropriate ALIGN_FUNCTION()
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..b97c628ad91f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -459,7 +459,7 @@
 	}								\
 									\
 	/* Built-in firmware blobs */					\
-	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
+	.builtin_fw : AT(ADDR(.builtin_fw) - LOAD_OFFSET) ALIGN(8) {	\
 		__start_builtin_fw = .;					\
 		KEEP(*(.builtin_fw))					\
 		__end_builtin_fw = .;					\
-- 
2.29.2.576.ga3fc446d84-goog

