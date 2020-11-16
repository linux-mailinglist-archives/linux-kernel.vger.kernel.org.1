Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83A42B3C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKPEfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgKPEfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:35:40 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A010C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 20:35:40 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id s9so10850050qks.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 20:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PcaGZc6YEOa/upx9Lq4nvAAaktl5oI7rmAzxmSmunYg=;
        b=IvTiaILv6o6vnqxABrEeyP2OMeqO/3EX3J6QRuqZyxRsA35iW4xnt6GHlb4Czp+BIf
         MuTyZxG+S5m/+T1R7J6OCfKslikVSjpnm2YUV2iEL+JVdyEHXyfFuYKqp22x6w392Cry
         vLpa5Op2KviOrR3eR2cotrH7krvJubYlycA224sF4yZMJ6cFhlEyR/lDNLwtPEfqrw1V
         UET9RdgoKLBrbvxRDLj7YN/EkbJ41+Us2UsgR474itfhk9RY8kqT/4LIB4lk8ZINwgc1
         BOHkbIM1HgmyuWM87FIBfBOyk+i12o5YaymFOHgD2mXqNPAlb2+UtcdyTidTRWQMopRM
         2qvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PcaGZc6YEOa/upx9Lq4nvAAaktl5oI7rmAzxmSmunYg=;
        b=ndTgZfQUZLr9unJOkTgncFOL8MwMGbAN8nNCJDFO7TrcQFT+Rrq3GG55DCPRepkJ8b
         +yzxKvBra9iyUWz+JnGje5d6PHGL45fyLm5bfGhs/lKad+PSqUPMgcI835xD1taJJH8W
         qtKrRoAtN8EbJEtVNeRFEr/Nk6/g0oVc5gTqoht3YdtrJUqrUML9cNhjwChXJ7M1NHms
         648IEsCnbxiRwVgMc9GtZWrrEiJeAH/gAL4cb3cAhLEavdnEvDSmUCRq0a2QLFevzjYF
         +byerpEEkvzfSyeJdq89InjJY6h3aPA4bHkOJKKz/aUNASl2tm4ux+mi57U7mHuYyxIM
         jJEw==
X-Gm-Message-State: AOAM533X6lRDD5px6yR3xai4wW/jj4Rl1ztz/XID+GROjhCL4dyAUruQ
        yjQeTy1flMjC4LdKQWa7SbxTIRMPZiAzfcuiJVk=
X-Google-Smtp-Source: ABdhPJy2bHsPOn15HLl05w92gsUQjUlJnWRrJ/pAei6VtA5MZWwb7lRPf7PerV7mX+jsiPU8dnMxscRw1eG8k6ZAH08=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:fb4a:: with SMTP id
 b10mr13942185qvq.1.1605501339502; Sun, 15 Nov 2020 20:35:39 -0800 (PST)
Date:   Sun, 15 Nov 2020 20:35:30 -0800
In-Reply-To: <20201116043532.4032932-1-ndesaulniers@google.com>
Message-Id: <20201116043532.4032932-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH 1/3] powerpc: boot: include compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel uses `-include` to include include/linux/compiler_types.h
into all translation units (see scripts/Makefile.lib), which #includes
compiler_attributes.h.

arch/powerpc/boot/ uses different compiler flags from the rest of the
kernel. As such, it doesn't contain the definitions from these headers,
and redefines a few that it needs.

For the purpose of enabling -Wimplicit-fallthrough for ppc, include
compiler_types.h via `-include`.

Link: https://github.com/ClangBuiltLinux/linux/issues/236
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
We could just `#include "include/linux/compiler_types.h"` in the few .c
sources used from lib/ (there are proper header guards in
compiler_types.h).

It was also noted in 6a9dc5fd6170 that we could -D__KERNEL__ and
-include compiler_types.h like the main kernel does, though testing that
produces a whole sea of warnings to cleanup. This approach is minimally
invasive.

 arch/powerpc/boot/Makefile     | 1 +
 arch/powerpc/boot/decompress.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f8ce6d2dde7b..1659963a8f1d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -31,6 +31,7 @@ endif
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx \
 		 -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
+		 -include $(srctree)/include/linux/compiler_attributes.h \
 		 $(LINUXINCLUDE)
 
 ifdef CONFIG_PPC64_BOOT_WRAPPER
diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
index 8bf39ef7d2df..6098b879ac97 100644
--- a/arch/powerpc/boot/decompress.c
+++ b/arch/powerpc/boot/decompress.c
@@ -21,7 +21,6 @@
 
 #define STATIC static
 #define INIT
-#define __always_inline inline
 
 /*
  * The build process will copy the required zlib source files and headers
-- 
2.29.2.299.gdc1121823c-goog

