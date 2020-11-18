Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A942B72DD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgKRAIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKRAIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:08:02 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:08:02 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 198so201814qkj.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=60RDm9GZdiDvHOVTVOgnNPhDb7lpPTDsg7QOSfebuy4=;
        b=eHi14+wzHA3GWNL69Egy8TJVe0yzRQoR91adGg656Kp/8QG7pQZoGOT91k6ka6w6Fr
         +sP0fkZBSd0zQ/JWhtkfQ0/NecTiOyHSXm2rzOgmaSubxI2y0f5Wvl45NXgBYqiaBza1
         3Z6NCFLdM4+m+oYnxqhtSifKMOm5GCRHyLMlxA4RJLEAQk7iBlCzdLdjawsaylu+S9/m
         BgxE756zWYZtQ/v28Vg3RXRB5u5GIpeRGxAg2hNTVU4eAB5JKAYRCiZKwWdeRChd3p4I
         z+GJjq4PbppqAfNtKx2K8bS70rw9vWX/52pFYj4KfXGZ2MKiCiHt7zb7204HqB1vVwZK
         JGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=60RDm9GZdiDvHOVTVOgnNPhDb7lpPTDsg7QOSfebuy4=;
        b=k8nmH3NO/jDz7sNnR6j67i39eKEfedeIJm8NM4xlzz8/+J5zP+k7spUKq9A+4lSEz7
         MhJzpoeUan2Dy5H3J8guo1vPWubcAilsY6ydROuqXWO8+O2Yt9lkmotJoDGWFouLt3Y3
         T1zeRRF9VYDaJdcwLj2nFIbDPh5NCKSX2kx9MrHJ2oTbYnT82QzaZBttppubygCzhRSy
         d4LUvwP0fEIp0xqVdnGf69HMnXQCvKTnBMT61+s7J8TBlTBiHqsSUqFFznndrx8iW/Ra
         vrE07kQ6zkegaHYHs7hfv+h8RYjDLWJq4LPi+hmFrcnXpvupx+Z5MTFZgBSIb5ioFYXd
         yo5Q==
X-Gm-Message-State: AOAM531HFJAP9qmt0JnI/yPn1CEfZKdir915nI1+aIlVO7MSe4tCa/qk
        trcPErTFEp844qU2JK2/ClmIYsj1HlkKPlgk1EE=
X-Google-Smtp-Source: ABdhPJzmlVGZoccUlD7B14kIiKYBXJ8LMSWJfZ77mc02Pp7puSP6ttSA82K5uXIAgrM5ZNnwIz+UFgG10oc/SIHOvY8=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:53c8:: with SMTP id
 k8mr1987233qvv.40.1605658082001; Tue, 17 Nov 2020 16:08:02 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:07:49 -0800
In-Reply-To: <20201118000751.845172-1-ndesaulniers@google.com>
Message-Id: <20201118000751.845172-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201118000751.845172-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 1/3] powerpc: boot: include compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
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
compiler_attributes.h via `-include`.

It was also noted in 6a9dc5fd6170 that we could -D__KERNEL__ and
-include compiler_types.h like the main kernel does, though testing that
produces a whole sea of warnings to cleanup. This approach is minimally
invasive.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://github.com/ClangBuiltLinux/linux/issues/236
---
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

