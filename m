Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347F120E1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgF2VAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbgF2TM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E81C08EAF4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so5417566pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpUogxOiAtRCZJbpj/Xg6f5qeGiNnaYs3fJRPX/karM=;
        b=DI7brhSnHEPnBP9EF9Z149tETyybTm/vRuuRi3kQWF9laFLVbRO/B6ZFFy2PkayzvX
         qgx3F8e8SkuKXWe2A3IX2ProSRkfDVOaK8mA4F+DyfAsVYLwYcBEByyEiOgr1O2AbpW0
         znz0jgmgOzhpF8f9lW/RNJGa3YYwNNvYQnG4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpUogxOiAtRCZJbpj/Xg6f5qeGiNnaYs3fJRPX/karM=;
        b=PfK25BI7RFLmXTX/0KF+HzjkYE4UHniLS+vNL3sEoHIh04j4inD3QStV2GD8+oQdFz
         GmeiVxX3Hjp3JuCj+Eotc87vukBqd5jdn6j4UIqVLUda2av8x4UOM9eE6Rn4jlVJSk1e
         eDE3xh236DVFpWBsPaKi/6dcnIhdj5QVzZeKsa7DOqrb0VQ+EO9AtSNrDRjbko+ieGDC
         ihltBypIGyHm18brFV1W4QEhc1mzA08LIC57UnUPNj4TAieCsisJh7Yq4FEZigo7mUD6
         nms1Gw/L3vEgNTwvKxv+zvKMUy7COiePRPlEq5cyWVvoS7mOiBEHw3m4f9Fvnx/BO6oE
         dzWg==
X-Gm-Message-State: AOAM5321delJLvw6Ktm0Sjq/ZBKVQbSa+OurpQS45bpTMnqJ3tfGjeMy
        rKXiH/BUjqHvlqDtydmHtu39rQ==
X-Google-Smtp-Source: ABdhPJyNl9M0hTPrxGqQML+GMiPdMMkdmcUuHH+RPVHgnToWI0RwZQKETihD6gi3OjkvTsW/Fi4SHQ==
X-Received: by 2002:a63:fc1f:: with SMTP id j31mr9226331pgi.104.1593411526749;
        Sun, 28 Jun 2020 23:18:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nv9sm19380828pjb.6.2020.06.28.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/17] vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
Date:   Sun, 28 Jun 2020 23:18:27 -0700
Message-Id: <20200629061840.4065483-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
and .shstrtab are listed as orphaned. Add them to the ELF_DETAILS section
so there will be no warnings when --orphan-handling=warn is used more
widely. (They are added above comment as it is the more common
order[1].)

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

[1] https://lore.kernel.org/lkml/20200622224928.o2a7jkq33guxfci4@google.com/

Reported-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c5d10bc53996..9477359278a2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -796,7 +796,10 @@
 
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
-		.comment 0 : { *(.comment) }
+		.comment 0 : { *(.comment) }				\
+		.symtab 0 : { *(.symtab) }				\
+		.strtab 0 : { *(.strtab) }				\
+		.shstrtab 0 : { *(.shstrtab) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
-- 
2.25.1

