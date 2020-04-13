Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934F21A61C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 05:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgDMDiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 23:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgDMDiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 23:38:22 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CF9C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:38:20 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c21so3753353pfn.14
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QORZam2dJ5jBZKiVodgUF3UBGqcYPusEkvKEQouWzf0=;
        b=YtFBuwoMRABxnu7YQkBMvkcDlGBNKbBanbMYSFpY7TQd24/qiJB1hAHOcVeQgAYgq2
         VWMk8g8OBJl8eg04xKayAFnFhJwVMi8atooqHPSJTidvRaXtlIYjobw9j/YrCjiP9kv/
         mIFuej4k+hj2pomkTrcAD6k7y+SZTMrWOV7XlZdStuTjvaBgiXE2gXkqDFs9U7YQn7tQ
         mESBFUH3HbsahC/wiz27l185cCRqoSzB+rJpOfnaJQOOsI0k5qg9m96ECvoHEGeDT8eW
         OgDIJDgWwcHG0YPOS2Qa6rKLW7AAN7XU4rrRncXrD0wKe0bKb3a1/ykrSGZWOCNam1J/
         Z0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QORZam2dJ5jBZKiVodgUF3UBGqcYPusEkvKEQouWzf0=;
        b=bnoz2/tbHrD7XoKRNMqcv4oeZCmn6UBn8GyB19V1NMD4VndmTD3j1dLeKODde2VFmi
         WOnqkeyHJ7Xszwmw6BJOlVHCfCJUcCYT+BTWfDLzkRI1LGHCLEVxp9WWys4sqsfdSpqS
         kSdHsNJOXUDy/xgmoWECOLRTppQMw9rek9fKKarYetwlzWZ+GQhNn4ezxr2OufKS4/5I
         hoKgaBdSXiM9EWDUK0erxkpKteUQTrcrcaUXVvxiHYNEI9wVzLERsu2hpPJNibYD5jnD
         4XXUFL7f5jkibLs/tqnMsX/Kst5W+q5fIKXqnQ2Yf9JoW5E47Jh2hrGJ/Y03mEE3WCIt
         HMBA==
X-Gm-Message-State: AGi0PubJA6KaTpS+YHk3KIJSBXNMzZucsbF+KtstT1x9LN3nvEbaz55j
        q5InoRfhs/vGAUuSSMMgwsRaOTQcW88r
X-Google-Smtp-Source: APiQypKeuifjgteDaCs6+s6xezS8EBZr8x4/+p3bT6L6DUgg35T0PVJh8ppYM7VeNyE+wu2mmfKscn8R8KQK
X-Received: by 2002:a17:90b:3752:: with SMTP id ne18mr20616356pjb.143.1586749099419;
 Sun, 12 Apr 2020 20:38:19 -0700 (PDT)
Date:   Sun, 12 Apr 2020 20:38:11 -0700
Message-Id: <20200413033811.75074-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] arm64: Delete the space separator in __emit_inst
From:   Fangrui Song <maskray@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many instances of __emit_inst(x) expand to a directive. In a few places
it is used as a macro argument, e.g.

  arch/arm64/include/asm/sysreg.h
  #define __emit_inst(x)                       .inst (x)

  arch/arm64/include/asm/sysreg.h
  #define SET_PSTATE_PAN(x)            __emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))

  arch/arm64/kvm/hyp/entry.S
  ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)

Clang integrated assembler parses `.inst (x)` as two arguments passing
to a macro. We delete the space separator so that `.inst(x)` will be
parsed as one argument.

Note, GNU as parsing `.inst (x)` as one argument is unintentional (for
example the x86 backend will parse the construct as two arguments).
See https://sourceware.org/bugzilla/show_bug.cgi?id=25750#c10

Link: https://github.com/ClangBuiltLinux/linux/issues/939
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/arm64/include/asm/sysreg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index ebc622432831..af21e2ec5e3e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -49,7 +49,9 @@
 #ifndef CONFIG_BROKEN_GAS_INST
 
 #ifdef __ASSEMBLY__
-#define __emit_inst(x)			.inst (x)
+// The space separator is omitted so that __emit_inst(x) can be parsed as
+// either a directive or a macro argument.
+#define __emit_inst(x)			.inst(x)
 #else
 #define __emit_inst(x)			".inst " __stringify((x)) "\n\t"
 #endif
-- 
2.26.0.110.g2183baf09c-goog

