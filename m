Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821E92A5B4C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 01:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgKDAxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 19:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbgKDAxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 19:53:53 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35E6C0401C2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 16:53:52 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s130so4616280pgc.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 16:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sEoLa2K7mY/J71l6bRl2EaWMrBUYyyUbe4HY5uHEuDw=;
        b=PhJTUPR2xqSR+ujql+GZQjnimaFdfxKUJ4XBGPiMU7prjL2P411miMnABec+34UJbU
         lEKGHURwGefRBq0nC27kvgNP0xItZS+Geo1izk8BzrbEPCv3GMCtWSi4afJ4+s8nDp8R
         GPdIImMke9cA45MztHtbStm/oIZa+tOk98FuUFW8lrt1YVWJKPllBYXv1fTeWzAIGAE/
         3OxNZXZYsXnSXm+yHf1uIb1CdtnXvZkoOOzAA4Kj7XcI1h1ncA2G3+zz5/GrHiyZhE0d
         jwDvwi96cUT951aVwsQpUcDe85Bwkvgq2ANfgKPah+IgoW0/usGq2KDrIADGoimjN5He
         38KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sEoLa2K7mY/J71l6bRl2EaWMrBUYyyUbe4HY5uHEuDw=;
        b=Zg+KH54kQgFxUWmBPhRHTLcrGFZK7SHAGw9B3N5qmy5RQ8NYGmXbwuCmPzE/8J3+JB
         u/AgDAQX4ww8VzE4EHKT7knYCI3Qrq/sebuXMHgCciOTxbBcQ54jxNAKhDjKIBKsRUOE
         VoFe3uJ6KzMj3Y/UtB4SVij00kbob+U1CsiF0dLSUT3l67RM4Ovc6/DNvG3mBBMr8kJ6
         dxItrNXZVlaZ6rA0GxZWZ6mQjnjz8ugo95goRw6fFEghh72fAJf7Nsfu+oTaheFjRyOv
         Lc8NmnHW5KMtQzURTqnS7yT0Dr8poAde+O07hkTpOFSMiBNtZ/iL5tVwbOOYevUHI8Uo
         Zuxw==
X-Gm-Message-State: AOAM530lb00mjYAh9ZKCjVl6pHEjFoUybkTCzrNGbxHbVa2Sk3VVfDZS
        A+YR41dgnCTnuFYB5H5T8JJOzly8YhgNLGahEXI=
X-Google-Smtp-Source: ABdhPJx+vniXuliRZxPCV1tJZAPoVtuEyLpBn4TU0/yRbnY3b+b6/tkfu9lmHs2Ad8bg5JYW4wiKwzEQK/rjF7E9tPE=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a65:50c5:: with SMTP id
 s5mr18813679pgp.399.1604451232483; Tue, 03 Nov 2020 16:53:52 -0800 (PST)
Date:   Tue,  3 Nov 2020 16:53:42 -0800
In-Reply-To: <20201104005343.4192504-1-ndesaulniers@google.com>
Message-Id: <20201104005343.4192504-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAK7LNAST0Ma4bGGOA_HATzYAmRhZG=x_X=8p_9dKGX7bYc2FMA@mail.gmail.com>
 <20201104005343.4192504-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 3/4] Kbuild: make DWARF version a choice
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
way that's forward compatible with existing configs, and makes adding
future versions more straightforward.

Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile          | 14 ++++++++------
 lib/Kconfig.debug | 19 +++++++++++++++----
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 75b1a3dcbf30..e23786a4c1c7 100644
--- a/Makefile
+++ b/Makefile
@@ -826,12 +826,14 @@ else
 DEBUG_CFLAGS	+= -g
 endif
 
-ifndef LLVM_IAS
-KBUILD_AFLAGS	+= -Wa,-gdwarf-2
-endif
-
-ifdef CONFIG_DEBUG_INFO_DWARF4
-DEBUG_CFLAGS	+= -gdwarf-4
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
+ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
+# Binutils 2.35+ required for -gdwarf-4+ support.
+dwarf-aflag	:= $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
+DEBUG_CFLAGS	+= $(dwarf-aflag)
+KBUILD_AFLAGS	+= $(dwarf-aflag)
 endif
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 83a860126897..03c494eefabd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -256,14 +256,25 @@ config DEBUG_INFO_SPLIT
 	  to know about the .dwo files and include them.
 	  Incompatible with older versions of ccache.
 
+choice
+	prompt "DWARF version"
+	help
+	  Which version of DWARF debug info to emit.
+
+config DEBUG_INFO_DWARF2
+	bool "Generate DWARF v2 debuginfo"
+	help
+	  Generate DWARF v2 debug info.
+
 config DEBUG_INFO_DWARF4
 	bool "Generate dwarf4 debuginfo"
 	depends on $(cc-option,-gdwarf-4)
 	help
-	  Generate dwarf4 debug info. This requires recent versions
-	  of gcc and gdb. It makes the debug information larger.
-	  But it significantly improves the success of resolving
-	  variables in gdb on optimized code.
+	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+	  It makes the debug information larger, but it significantly
+	  improves the success of resolving variables in gdb on optimized code.
+
+endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-- 
2.29.1.341.ge80a0c044ae-goog

