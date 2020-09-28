Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8427B818
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgI1X2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI1X2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:28:42 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF53C0613B9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:49:10 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so2116536qtv.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4y6sLld/wj75bLQXPRA2CM02Tu/AhXKlM+xG5SZVcBI=;
        b=o5hwB45B4AbcP/BDToNvIGEeSXi9/bifLalWJ6PDgznNZtFOYQdhYmDun/7vRPrIWp
         xnNhy0L9RN6CMZJEMzcFfFPRRQwwu6RA/XpT7uQNvrd5CAM6ikIV7CKY6aYOBSF6M32R
         /bP9iw8sPgM6Xy0N1Q4B+GvcROrkrWLIWe3ZZfLZAbqH804JeDh0qkhdj1wDo5mLW+PD
         w07cmj8B3ChhW8StpqgCeQ/A0IIUo//8+9ZdG/hV1hxn2XgjuJkZ08j+kEAbLos3tl1o
         A2um5YByRUj37TIA9FzgPvM5mv7Ug1It0zHvWH1nFgIR2OTMD5N/miz6DGeR0swh3Wze
         1Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4y6sLld/wj75bLQXPRA2CM02Tu/AhXKlM+xG5SZVcBI=;
        b=e5FwsveecPoYwNQgP2SIqCmHH9vQFaY/XSTvVbKi75tOCYkPQLWmpX7jngmLrdyYlx
         ZIn7jIhTtklVD4iOQTdqsMT3UbWbQQiwcegndlZnubZWZF7xv2IFBtuBXujNdLzGmPds
         S20z5umPepdh0ZVkC7RWXKKC2qRMMM+O6X+PbrnsD0OL5RrfmTG86CEr0YAPlNwyb8dl
         TuVOqcV9HfKQXa1Vc4eglZO61iTZy77M7lw8b1vHcINxlMDsLxDbtA2f4/lfwjaCV0CM
         amAFwt7N+xZdmvv3m3GsUJwEvaOIhAUHUC7FZUEC6fwZa06mAu/cmWRxCGuivAFxlLHW
         rYuw==
X-Gm-Message-State: AOAM5324eFxmLTh3Yh6Mu/iAWFSUq62LX84nOI0h79w8uN/I1szGDLbm
        gW56tTPUd9xL6asCwAzm+Po=
X-Google-Smtp-Source: ABdhPJx+YGLvJvQta7YZ4ZbuUuqCYj8MpbgOhLflTLqr6ep9sljJpW5dnzCaCz8TC2ieXohqCxs2mQ==
X-Received: by 2002:ac8:4e31:: with SMTP id d17mr396331qtw.43.1601333349929;
        Mon, 28 Sep 2020 15:49:09 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id g5sm2528959qtx.43.2020.09.28.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 15:49:09 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] arm/build: Always handle .ARM.exidx and .ARM.extab sections
Date:   Mon, 28 Sep 2020 15:48:54 -0700
Message-Id: <20200928224854.3224862-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After turning on warnings for orphan section placement, enabling
CONFIG_UNWINDER_FRAME_POINTER instead of CONFIG_UNWINDER_ARM causes
thousands of warnings when clang + ld.lld are used:

$ scripts/config --file arch/arm/configs/multi_v7_defconfig \
                 -d CONFIG_UNWINDER_ARM \
                 -e CONFIG_UNWINDER_FRAME_POINTER
$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=1 defconfig zImage
ld.lld: warning: init/built-in.a(main.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.ref.text) is being placed in '.ARM.extab.ref.text'
ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: init/built-in.a(do_mounts_initrd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab) is being placed in '.ARM.extab'

These sections are handled by the ARM_UNWIND_SECTIONS define, which is
only added to the list of sections when CONFIG_ARM_UNWIND is set.
CONFIG_ARM_UNWIND is a hidden symbol that is only selected when
CONFIG_UNWINDER_ARM is set so CONFIG_UNWINDER_FRAME_POINTER never
handles these sections. According to the help text of
CONFIG_UNWINDER_ARM, these sections should be discarded so that the
kernel image size is not affected.

Fixes: 5a17850e251a ("arm/build: Warn on orphan section placement")
Link: https://github.com/ClangBuiltLinux/linux/issues/1152
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 5f4922e858d0..a2c0d96b0580 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -40,6 +40,10 @@ SECTIONS
 		ARM_DISCARD
 #ifndef CONFIG_SMP_ON_UP
 		*(.alt.smp.init)
+#endif
+#ifndef CONFIG_ARM_UNWIND
+		*(.ARM.exidx*)
+		*(.ARM.extab*)
 #endif
 	}
 

base-commit: 6e0bf0e0e55000742a53c5f3b58f8669e0091a11
-- 
2.28.0

