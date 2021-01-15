Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460FA2F8530
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbhAOTOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732702AbhAOTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:14:14 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CBDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:13:34 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id n8so2768328ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PftEDz+QoIuMD7vFvCCvvry9AT4u1Otsfrl7LAEO2DM=;
        b=e7I/8+0QvWciJwJHjYocoB/Sg05ul/a7lpQKebKIuyVkAqM/jxAc2FD5yjXDRci1IZ
         ld19f8724W4QnUgvHUIvL4Wz5vcrxLMGa++CSO4K594lvJUjAYGVcdsYOy9DaEOhFSY0
         eJhbmQ2FFUH1ChR9vKuRiQ1wyHmiSiMWXy4EKZhTCPe8QwoK/hzR93e04UoHmNbqLy6k
         hz6Sl+aRItr8IfwatmIuIlWYJ0V8/K2vZ3qTiNzmqw3AT5f1G95Ljvj7djaJXBlHMdhT
         uPgl5lcq5abEIDY7xpIFeU42QowkQKcsnCLDPCOfH7SZwjHgWv6h/ZXs9fkN/rAItn6s
         rMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PftEDz+QoIuMD7vFvCCvvry9AT4u1Otsfrl7LAEO2DM=;
        b=QjWObqMfGaoQDnJGC3AenmqKE9evG0DKs8PZKc/EfQr8w40mxUCWaB9W4i9MDwvx97
         b2o8tKFTdo3etrKGOycpsAyPTkkrNt7YSiLB3xZWgNarhWA+03J9k7MDRarLqWj53ngv
         V0Abzf/HPU72daSj4RytUYuHPgBsDvdKrvecokLyajG2gS9DYhXiJqAax77d7w4N7I78
         HwooGuxg2bI9NbdgykFUIt1Focb232drvtKbIiUpMqQZQQL08mC2oPMjWxAHuxb404yz
         7T0on3xKWhSg6fkNrvOz1gFDemSzOzcNh7qlbBSbGgnE3gWoU86ytdfbfJXe2ldL/TbO
         VSCw==
X-Gm-Message-State: AOAM532Mw0TsSYGDVUFLu7yGnXyMhDYLUqQPTFNHgu4UJahAyb+lO6lY
        OAjmO6VCPTxp2/j1MEK81Ey25w==
X-Google-Smtp-Source: ABdhPJxbPRHWjL6kx/iZHWN3F1EaM4GLuZEgGUuQDMr5sDZhXuds79Cgh3mUSIpAdCcq2XUgVC5lOg==
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr5594493ljj.208.1610738012915;
        Fri, 15 Jan 2021 11:13:32 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id t17sm998823lfr.5.2021.01.15.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:13:32 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tsbogend@alpha.franken.de, natechancellor@gmail.com,
        ndesaulniers@google.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] mips: vdso: fix DWARF2 warning
Date:   Fri, 15 Jan 2021 20:13:30 +0100
Message-Id: <20210115191330.2319352-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building mips tinyconifg the following warning show up

make --silent --keep-going --jobs=8 O=/home/anders/src/kernel/next/out/builddir ARCH=mips CROSS_COMPILE=mips-linux-gnu- HOSTCC=clang CC=clang
/srv/src/kernel/next/arch/mips/vdso/elf.S:14:1: warning: DWARF2 only supports one section per compilation unit
.pushsection .note.Linux, "a",@note ; .balign 4 ; .long 2f - 1f ; .long 4484f - 3f ; .long 0 ; 1:.asciz "Linux" ; 2:.balign 4 ; 3:
^
/srv/src/kernel/next/arch/mips/vdso/elf.S:34:2: warning: DWARF2 only supports one section per compilation unit
 .section .mips_abiflags, "a"
 ^

Rework so the mips vdso Makefile adds flag '-no-integrated-as' unless
LLVM_IAS is defined.

Link: https://github.com/ClangBuiltLinux/linux/issues/1256
Cc: stable@vger.kernel.org # v4.19+
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/mips/vdso/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 5810cc12bc1d..83e8cf216ac8 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -26,6 +26,10 @@ ifdef CONFIG_CC_IS_CLANG
 ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
 endif
 
+ifneq ($(LLVM_IAS),1)
+ccflags-vdso += -no-integrated-as
+endif
+
 #
 # The -fno-jump-tables flag only prevents the compiler from generating
 # jump tables but does not prevent the compiler from emitting absolute
-- 
2.29.2

