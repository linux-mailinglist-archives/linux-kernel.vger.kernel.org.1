Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8188825B6E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 01:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgIBXAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 19:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgIBW7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:59:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2528C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:59:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d26so819585yba.20
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hff3G+QLGxV/ViGmhPCtlvmXNd4WANBDwQ3lAuZV0Mw=;
        b=iwrw74Q1XQR8aetxPyj7X2JT/yrRvwxttKGJSalOf27LJjRNgw5LdTGmBi4zW87gzJ
         jWv/YEvq5Zbo3RpMnk5y1ZdPzkiOZbs0cuRfKqDKO8OW5mq+mZ+C2IIOaUyvJuJA5Ut+
         fwlpdlv6vAjbVeRBP48LkhTULyIMThwfS9on6nc6WyXEdbOeGL+I4M/jhT3zZTfZBxaa
         kr3EWqG+AfGLNAUy+Hg2rN/DMRWME1kQh61uaJzCU3+2chJMjZFw4rzpb0YIlTOoXn71
         sA9Cw+rDwZzpxHBgrbuHNCcWyIKv13brHg6X0t31wzmsHpHoImnLzA3eCHBWn09yRjrR
         T3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hff3G+QLGxV/ViGmhPCtlvmXNd4WANBDwQ3lAuZV0Mw=;
        b=qOdig8yTCJTWj8VEWdgSXLp90djEbsCS8PLpiFZOvJNl+25umTJn6Q752PWTflo1uE
         2qu0abzdp7cGDszbOXCWDAtBZSk1OY9NRouVYXgmH8CH4YV65+RZNwiDFh1ypd3Nivpy
         6wgiVdxvdKLQnTyz//4boKmpAi5x72n1QzDSEIxDAVI55yk5M5tXVASIdggZjVQKiZcx
         +sFiLiF+CV4oopHzSxq7kRdeuoyoTHORioBYEJB7+PjwzSmam5krdvy6YvhsGe5FnaRu
         pVwqZiYDKGi5muwl1a9t67V3UjHgTV5j58FtdyVNXMd2gzEyHGRpTVPblqZn7dQAD5UQ
         MJ3A==
X-Gm-Message-State: AOAM533HBVnQWv1sd5cu8uFdxG3CrQokcXI7tbXOCmYzUFOsTLhPUIBI
        DJ/ANU+geN8p+WUqfFH6nBrApZWAMMbNSGkTpmA=
X-Google-Smtp-Source: ABdhPJz8HsXqhbzv3WyaE2hRsJShfNIeKayY5AyYc2Ztb61p7tA6BncgoQhhEmGaA+pb9MRBq7EHu8ZTXm6gCOA9puw=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:8b09:: with SMTP id
 i9mr1782ybl.149.1599087574125; Wed, 02 Sep 2020 15:59:34 -0700 (PDT)
Date:   Wed,  2 Sep 2020 15:59:11 -0700
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
Message-Id: <20200902225911.209899-8-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 7/7] compiler-gcc: improve version error
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Kees suggests, doing so provides developers with two useful pieces of
information:
- The kernel build was attempting to use GCC.
  (Maybe they accidentally poked the wrong configs in a CI.)
- They need 4.9 or better.
  ("Upgrade to what version?" doesn't need to be dug out of documentation,
   headers, etc.)

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-gcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7a3769040d7d..d1e3c6896b71 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -12,7 +12,7 @@
 
 /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 */
 #if GCC_VERSION < 40900
-# error Sorry, your compiler is too old - please upgrade it.
+# error Sorry, your version of GCC is too old - please use 4.9 or newer.
 #endif
 
 /* Optimization barrier */
-- 
2.28.0.402.g5ffc5be6b7-goog

