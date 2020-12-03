Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4262CDBC9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgLCRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgLCRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:06:33 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369CC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 09:05:53 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id j1so1567593qtd.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Qbrb8i2YfiEPDxlw+wvNXikUmpcEcy9BW/zou/d27Yk=;
        b=ePOWK2/6kYVxket/SF6GfcbuPmPOmPzeA0baqmNP01ITblvLvShxFFmoPKNtQzqnFS
         Ei4LY+4oiS1Imvj50qvIeZ36Eey3/jBj55dZ2Aqzy3cCb6pfDMjo7i/EorJB8qqI6IHD
         fDXsbdfkGNlDikFblIPQX6pBzHAMcsH2pFYtJk3yX/xR88kg0xj5p5SsEw+evXlB2Weh
         8MlQMNjgMg3ZyF+SM5K3RFg/t+ueLH0avRip+UruPkJMHnoAtkqQbheRgLVFuyQ4zI0j
         5LOonZvHwrKTAthhe+z/0qOfrBebuMfH8Dmmvw4YMV7Tbg4Ev848ay/N3eEVwuzabYAo
         w6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Qbrb8i2YfiEPDxlw+wvNXikUmpcEcy9BW/zou/d27Yk=;
        b=oRPrUnPwRXNuEh5ri5GYaOIvupOBYXm/wYuifq7GAEKxKZDbW2LQ2xhSUZPL+7TZq5
         SmNsD1fwSHkhjUHvKf5EG5Pwz9G61EJglhRBCZtr9jki+hqvEAA7cNayQzNga2iTPLLf
         DCdWDjAJMQuxTzpRqRlikOuknuBJXy6Qlhvl7CuM1WLIFJD8Q3GVpVMr0PTycZPjx9Kf
         +wvbsShDv2oKXth+8YFl2LZEalPs7CJNBvs08TPkAJlDYrycJgiE6BTHob3yeaD2tIhS
         Wc51WU91a40Wpqrarl5FqLPK/WysBH0pgb15jsJU7ivMF/piSFOfqOoPAu4WjO8SPw7N
         V1wA==
X-Gm-Message-State: AOAM533v664SjjIziM02l0gRLjW9yPVjjxso8RUepQrjnKiKdFRgVX2H
        XBO5qNhLNZPHaJgHs1MS75sP6aOOTTtR
X-Google-Smtp-Source: ABdhPJxGXVmtu+oxyefg+ZGKiE48BU6y2F2sV+Thn8pEv3LX2+dqa0OSHJPRXJkG6qV6uNtFPTOxRPh1qmvJ
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a0c:b18a:: with SMTP id
 v10mr4180101qvd.46.1607015152255; Thu, 03 Dec 2020 09:05:52 -0800 (PST)
Date:   Thu,  3 Dec 2020 09:05:29 -0800
Message-Id: <20201203170529.1029105-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] firmware_loader: Align .builtin_fw to 8
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
Unconditionally align .builtin_fw to fix the linker error.

Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
Link: https://github.com/ClangBuiltLinux/linux/issues/1204
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fangrui Song <maskray@google.com>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..3cd4bd1193ab 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -459,6 +459,7 @@
 	}								\
 									\
 	/* Built-in firmware blobs */					\
+	ALIGN_FUNCTION();						\
 	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
 		__start_builtin_fw = .;					\
 		KEEP(*(.builtin_fw))					\
-- 
2.29.2.576.ga3fc446d84-goog

