Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC878234E32
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 01:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGaXJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 19:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgGaXIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3FBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e22so8521366pjt.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p43AFz9HRqud3tDDBCvs6KJ6+7J0/pvbtdYqvC8Rrnc=;
        b=QTiM18PSD/w0hkz6+49dNjYlKqnnSgsV4sS24WSmwXoRugebRp4LKDfQC7nvp6fYrV
         gdiv/4zaHnvqjw3K3WBfdnbxIUyxILgPC3YvpRxpOfsr4hPlZh8d1/YuXCwOkuk052/e
         SICsCW+maimc1NEbdloMesBJxS2DekZEi7UuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p43AFz9HRqud3tDDBCvs6KJ6+7J0/pvbtdYqvC8Rrnc=;
        b=nZzs2ca9CDQRG6cQbABwaZKHxmaK8cpN53camgy05tOdR62SmZepWa/88W/OCEsPKn
         TgmlIPM1tpH/1EoOdpvEM9cztdm4Whtz/jjkLsDS4NBuSaVA63/9vFnaU1rbdFugQcT0
         w3o3RIW0fWKQXhcjgsSHtDb7snyxqvUAEBERhAEi9XLx3PNz4VbjeE2NC3dxKujZXxrr
         313jdMzCgpz/L9/2f5soHyTVXGidkj6NX4TF94CO4Pi4/mN/MQVWoBG+E4KxJp2zrAyt
         R21t5sKOgdap7gmiQvQTE/DpaOvKVsA8ruiMloNT8mG2QdqvXyCMgt1Mv6cGI4Aip4es
         900A==
X-Gm-Message-State: AOAM533OZ2LVrMrhJsX6ySQFyo5LNz3r1eXGJGlCtNLu2TjZrcVN62Xa
        qHIZsehJr92tRNF7Ocn2tjO3Eg==
X-Google-Smtp-Source: ABdhPJzHq2tL5hzE6rKPhC7MtWzPIpAWUv5VmdLKt6SWnFsYwK4Xv7tulB57SY0c8ooBQQDIA3loyw==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr5440472plo.89.1596236920452;
        Fri, 31 Jul 2020 16:08:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e26sm7106873pfj.197.2020.07.31.16.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/36] vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS
Date:   Fri, 31 Jul 2020 16:07:53 -0700
Message-Id: <20200731230820.1742553-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* sections,
so remove it via the COMMON_DISCARDS macro in preparation for adding
--orphan-handling=warn more widely. This is a work-around for what
appears to be a bug[1] in ld.bfd which warns for this synthetic section
even when none is found in input objects, and even when no section is
emitted for an output object[2].

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=26153
[2] https://lore.kernel.org/lkml/202006221524.CEB86E036B@keescook/

Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ff65a20faf4c..22985cf02130 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -933,7 +933,9 @@
 #define COMMON_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
-	*(.modinfo)
+	*(.modinfo)							\
+	/* ld.bfd warns about .gnu.version* even when not emitted */	\
+	*(.gnu.version*)						\
 
 #define DISCARDS							\
 	/DISCARD/ : {							\
-- 
2.25.1

