Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035F127D666
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgI2THU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2THT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:07:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7FCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:07:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z40so5854364ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=kK71kCSNGJVaDe2pNd17eTqrSe4R+0MFugjIL4jzDFc=;
        b=PfsZalFhEeBQpiATmlrk+FX19iTeTafrV6ltkUFI1L81IdRa3RE5BQxWSIu1MC9LGu
         At+oUMALCekjXOZdxE7QjZm9osZl6Bvt/Ec6HQwLSMvPKIMa0W3A1hIyHf2O03QcpOsu
         mPpIzo6bE1e9k1Pu2EpWJXZQtEWR0JXr/8YxSEPpCQRXIxVwnsQ7y1ZolUvb6fU9Kxxd
         ZTGv6E3a/FiaB1jzEhtKI5BiOazL7bMK/Ew7EQ/z3wMS+b+6vIZFtUO7/dXf+aD0W3EG
         UMD6cz2QzOBvjM9zP/aTFx8TrHrZgq3y0BAQ3JuaCk+VIPEf5di6QGR+HltkTNOfLLn7
         eF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=kK71kCSNGJVaDe2pNd17eTqrSe4R+0MFugjIL4jzDFc=;
        b=kCLmyRkeTjsXA2kir7hi5Ob9H8lXISP6mDPFdj6jcfGOcMUiMQJKdChlXRUwychvdN
         kRt2pfjvxNh/1/od1nD3cAe5BgnN8Lexvs30kPiPQZVcUHE0hixU6pD8PisYukYtdDrA
         4lcxrL8MM8yl6l4ToOdFvKd6CeSOT+MIV47JNOUMxHuERFMBsp/qEM/YcyXD6wFP71IO
         SSOG6WcVyqJc6X159fHni97BQmMd5kF9kZ7tm8zPZGbARQF6qSzsbIsHrjsQ1J3Vephq
         +nLnIULyTxzaoh6nQwveuy+BgatXzODGN2t0lN1O0Lh2Mf7aWjaCDGZETZo6o7JAypmD
         46PA==
X-Gm-Message-State: AOAM530W4wzrnvXnDnjSE1wox8OoB4P+u2wUqfO9jDCuaW1qFK0KPFIz
        /FXXY4meYvA7muAikySrvH04PbBMcuaYGZ8+X5E=
X-Google-Smtp-Source: ABdhPJw31sfhQW0vMWLByBsMSjvUhsNEts7FFT3qqiTNiPW2cZz9iOfXZOfOS7C5ctLXlN0Juf/BuXQ2cnpyoFtBRuk=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:ba4f:: with SMTP id
 z15mr8385000ybj.408.1601406438780; Tue, 29 Sep 2020 12:07:18 -0700 (PDT)
Date:   Tue, 29 Sep 2020 12:07:00 -0700
Message-Id: <20200929190701.398762-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH] export.h: fix section name for CONFIG_TRIM_UNUSED_KSYMS for Clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kbuild test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling CONFIG_TRIM_UNUSED_KSYMS, the linker will warn about the
orphan sections:
(".discard.ksym") is being placed in '".discard.ksym"'
repeatedly when linking vmlinux. This is because the stringification
operator, `#`, in the preprocessor escapes strings.  GCC and Clang
differ in how they treat section names that contain \".

The portable solution is to not use a string literal with the
preprocessor stringification operator.

Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://github.com/ClangBuiltLinux/linux/issues/1166
Fixes: commit bbda5ec671d3 ("kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS")
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/export.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index fceb5e855717..8933ff6ad23a 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -130,7 +130,7 @@ struct kernel_symbol {
  * discarded in the final link stage.
  */
 #define __ksym_marker(sym)	\
-	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
+	static int __ksym_marker_##sym[0] __section(.discard.ksym) __used
 
 #define __EXPORT_SYMBOL(sym, sec, ns)					\
 	__ksym_marker(sym);						\
-- 
2.28.0.709.gb0816b6eb0-goog

