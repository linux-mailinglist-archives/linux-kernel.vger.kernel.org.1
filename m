Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4F1C1008
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgEAIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgEAIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:50:05 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 May 2020 01:50:04 PDT
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D87C035494
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 01:50:04 -0700 (PDT)
Received: from mxback27j.mail.yandex.net (mxback27j.mail.yandex.net [IPv6:2a02:6b8:0:1619::227])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 17D8367418E1;
        Fri,  1 May 2020 11:42:42 +0300 (MSK)
Received: from sas8-b61c542d7279.qloud-c.yandex.net (sas8-b61c542d7279.qloud-c.yandex.net [2a02:6b8:c1b:2912:0:640:b61c:542d])
        by mxback27j.mail.yandex.net (mxback/Yandex) with ESMTP id SUQtlbkE3G-gf7WPW96;
        Fri, 01 May 2020 11:42:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=golovin.in; s=mail; t=1588322562;
        bh=gan9a/JARj/+uZ3h35bsl+BDo6XiSEqZSpSCQqcjDAA=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=ARiE+ETtWtuGINV5klL98d9ZvWL/iVptFaDgh8qjjv1/oUOxXqzTHCVJqIOVRjbHd
         rAVoHhk0TEx3w2Hp15CKf34pPinyFErR3+iBSdGlzbD0VsUR/93i2VR9L2rHmNdC1c
         wOpYREBHQDZlP/bAoldT9LcbSHdFGCM4/cfGQmVY=
Authentication-Results: mxback27j.mail.yandex.net; dkim=pass header.i=@golovin.in
Received: by sas8-b61c542d7279.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 8KmUsRmuq5-ge5iAngf;
        Fri, 01 May 2020 11:42:40 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Dmitry Golovin <dima@golovin.in>
To:     clang-built-linux@googlegroups.com
Cc:     Dmitry Golovin <dima@golovin.in>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot: allow a relocatable kernel to be linked with lld
Date:   Fri,  1 May 2020 08:42:13 +0000
Message-Id: <20200501084215.242-1-dima@golovin.in>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLD by default disallows relocations in read-only segments. For a
relocatable kernel, we pass -z notext to the linker to explicitly
allow relocations. This behavior is the default for BFD.

Link: https://github.com/ClangBuiltLinux/linux/issues/579
Signed-off-by: Dmitry Golovin <dima@golovin.in>
---
 arch/x86/boot/compressed/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5f7c262bcc99..7214751e1671 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -57,6 +57,9 @@ else
 KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
 endif
+ifeq ($(CONFIG_RELOCATABLE), y)
+KBUILD_LDFLAGS += -z notext
+endif
 LDFLAGS_vmlinux := -T
 
 hostprogs	:= mkpiggy
-- 
2.25.1

