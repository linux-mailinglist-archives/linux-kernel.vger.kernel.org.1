Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD632CCB24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgLCApf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgLCAp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:45:28 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5EC061A04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 16:44:48 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so136526pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 16:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRr7mYLqkJh9ZS5e88iIisISPz90UDtap+MXccYRY0c=;
        b=Cu3txwmM9L0Et0fJH8IoAet6yyQ45awEeS2IvEN9eZ3t+2BUdTbcGdjV6zQL50F6z2
         BepwR5GGPU4tUfeIemqLYZGa01qWnISnY/bgQjRqIcs8dvpt8kxFWwXwBPcz3k6IAjBt
         ktY1ul4dKagosMycRI0EML92cS4vRAfGIuoZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRr7mYLqkJh9ZS5e88iIisISPz90UDtap+MXccYRY0c=;
        b=mfRmMHKyU8DC45Yv2rU+4azcq67BSpeWrGjPZYpBnkbMLdF8CZYOWe3wKncKAbCyqx
         KYwK6r2Sl3X1fu4kK95nQfOCOphNQGtHP1ukzHqDR35EqXUnLYtPoHrycbd+SmeDhTlF
         OsQzQ89mqYE6SazQ8uE9vVZ5Ye2F2IaFg1X3HbEYnc+66SRy71geCpSqXDsda6AFH19j
         kCz0FNfenCzijOcleiWioIqo8x/bh54V4CFV+QKc6nawSxNIL9nR8w80Zk18dBSgFQqd
         fyH4/msPVN0uPxuU3i+E5CFN5l7MgsnCJDU8Ue+HIOe4kpaQpliJ28zIjIJ+J5PaHKiA
         69Fg==
X-Gm-Message-State: AOAM5304LHjhHsSTtlOW+YuJopKbjaSgOd6kLH2rrVUrOqKgUd2j9UMT
        A0tug/9XYWg+UdAiPa3BrX2WgA==
X-Google-Smtp-Source: ABdhPJwdDXWg2OKGgjRlcJO+km1WMMWpfuYnvRzFihiv5/Yr6V3754zxNcB71q0sVnOmBJf9S7gO3g==
X-Received: by 2002:a62:8c08:0:b029:197:491c:bab1 with SMTP id m8-20020a628c080000b0290197491cbab1mr792967pfd.49.1606956288226;
        Wed, 02 Dec 2020 16:44:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1sm184483pgm.21.2020.12.02.16.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:44:46 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        George Popescu <georgepope@android.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] ubsan: Remove redundant -Wno-maybe-uninitialized
Date:   Wed,  2 Dec 2020 16:44:31 -0800
Message-Id: <20201203004437.389959-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203004437.389959-1-keescook@chromium.org>
References: <20201203004437.389959-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=2428e02de8b30f15f15bc076dd88e170ee9eea11; i=tpvA3+fDxfvnjYyYEKdmdqLWx/khXLfRHgeeHKGh3Vo=; m=OMBuArH9nHFHNkTHOfr/Yb/WsrRHnLzoto2YCF8BEV8=; p=EMeFqCFTi1hC44l8oQ2Bi9blFo1D8E+67Yi9oa+iGTQ=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAl/INPMACgkQiXL039xtwCZx2g//QBg FTuWhD0o/zTNyMw/Qi9B+fGJLdV7PU0UJcWeheVINnp5Glwm6ycnOs71nNBqYzAwL8xWBJ79QEaRi DgQGlEItQQbq6NkkdnMk7eYUJJPeiDDcRBHYPZIsKS37llGUmhLCoMHDAPeLpWVOgRd7vH3yGFMw8 eTQTMszn6DXNhGx9s8mNGvK/nR8L5Vqncnw3s2zAENb9TpMUnasUbK9IKarPEmob4opb2UYI0clVr AnnuK/HO0Cnn1+zXSJbiwuiCGy3xBacnxhSUm78iNCjkIOau7X7H6qvUAj/cu6OxsYbY4OzCFYmLS sdBtaCRhwwBAXIFHuif85o0WX1rLRv8XsFPDXjbP1JA7K/RPnHPgSgVu69DXr6e0RXM2VhATpzECI 0v5NuhVqhYovZOGEb+QH2I+UJNFBND/8j3Rygr5YivuRVNfoKGFnkRFg9Zxe7xteFDHNLXMcYa48w ZlXZskdEcKlSbCwchYuPOVHsrvwKp6yjwCuejp/otAU3xl5NWVwN2gfOlFn7RbuTGo4L7kBSXVMb3 zPZhMm1sTKqUDM6F/0S9uq7z3KaqTqpmic6qEGM1MTZgn21MhB2XqpbwM01jj9fuokKxAtGFQ9pgO bwL1j50imJgh62z2kNREDuY0zMe98wZzmUGJn4ICZCMUXXYma5yVUpZ2ljoFrw1o=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized")
-Wmaybe-uninitialized was disabled globally, so keeping the disabling logic
here too doesn't make sense.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.ubsan      | 4 ----
 scripts/Makefile.ubsan | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 58f8d03d037b..d8d4d6557b80 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -72,10 +72,6 @@ config UBSAN_MISC
 config UBSAN_SANITIZE_ALL
 	bool "Enable instrumentation for the entire kernel"
 	depends on ARCH_HAS_UBSAN_SANITIZE_ALL
-
-	# We build with -Wno-maybe-uninitilzed, but we still want to
-	# use -Wmaybe-uninitilized in allmodconfig builds.
-	# So dependsy bellow used to disable this option in allmodconfig
 	depends on !COMPILE_TEST
 	default y
 	help
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 9716dab06bc7..c18fecc53605 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -31,7 +31,3 @@ endif
 ifdef CONFIG_UBSAN_TRAP
       CFLAGS_UBSAN += $(call cc-option, -fsanitize-undefined-trap-on-error)
 endif
-
-      # -fsanitize=* options makes GCC less smart than usual and
-      # increase number of 'maybe-uninitialized false-positives
-      CFLAGS_UBSAN += $(call cc-option, -Wno-maybe-uninitialized)
-- 
2.25.1

