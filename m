Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E22F3D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437875AbhALVei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437074AbhALU4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:56:36 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:55:56 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id o6so7004176iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xQAjZcdO2TrQnB+fHDjBj7ZI3sRYW3buKazkY/+leg=;
        b=OR6/VYazAiJwRhCvmQD/WUA+Uv/7S+xpTVUroXDbWJokFA3RJ7g3JGg69IXqW6eE3Q
         ihZUA7c51NDinZJIZ0tcdKCGwDwD6jWKhryCKSBHdpXyRlIfIqHSo9L4LUO1039t3sao
         DATsRMBCDdnlQpcClOZeqV+VDVfrwk6oZMjaylbCqWvs1VDWRhzMeOqNwLtWKQsspFua
         1HzN3eosx75G9W3SqpJM6ujG+J+9vY2baxUjmGFevQ6/xNXUUhlpqy3KEZVpjZOQbfZm
         FknnkORngUHr/JFJw6jiiawY3OmrRPT9HsWQpCzwUYkroSQwWUQ/Dm94DHTXFJq2kqdq
         YSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xQAjZcdO2TrQnB+fHDjBj7ZI3sRYW3buKazkY/+leg=;
        b=ktt15q4qNfJIFCCeS+gGHi0XVXCmuy359tXUB8/vCNigh+U7GWfDXjQfr3cvLKYbzB
         yLRzz+XBeUEa3rGZtuZkDEtog2D6pQ3vOopnej91IEoOoAB7TTNNaXCrQ9nbTZndlcnz
         jXPUURXHoM8+ifg4BLe1VfcBdEyi7O6VUbDsiY/WeJGN0p3b5LzOvEpJOUaqjbU5pUU9
         1uxEiAJr4L1qpYUI14cjM5QhUqCYt8Oz+3a1332bU/nf0VGYt7B3kIRd4VLCNnLMy0dL
         Nkl4JtfBMdJXqT7eMmHA4nQDwzGKYO7L5Rh77gneXjFNa/cX5oxzqF3n49Bjv8or6rK/
         C1Ww==
X-Gm-Message-State: AOAM531lSezhWM1WicHqmMai74CCmmIypVhDzurqQ5iywoMC9ZIfIBbv
        SoOvymSf/Qtvbl3s80OcJD0=
X-Google-Smtp-Source: ABdhPJzw8qgadJzodJv6KQguGC+urtPsSoipUCh7zja2rMUvNDqq2PfeRoI253H5Eyrx7RedE7Cr+Q==
X-Received: by 2002:a6b:7a0c:: with SMTP id h12mr745554iom.162.1610484955698;
        Tue, 12 Jan 2021 12:55:55 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 17sm3193856ilt.15.2021.01.12.12.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:55:54 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
Date:   Tue, 12 Jan 2021 13:55:42 -0700
Message-Id: <20210112205542.1375847-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=mips 32r2el_defconfig with CONFIG_UBSAN_ALIGNMENT:

ld.lld: error: undefined symbol: __ubsan_handle_alignment_assumption
>>> referenced by slab.h:557 (include/linux/slab.h:557)
>>>               main.o:(do_initcalls) in archive init/built-in.a
>>> referenced by slab.h:448 (include/linux/slab.h:448)
>>>               do_mounts_rd.o:(rd_load_image) in archive init/built-in.a
>>> referenced by slab.h:448 (include/linux/slab.h:448)
>>>               do_mounts_rd.o:(identify_ramdisk_image) in archive init/built-in.a
>>> referenced 1579 more times

Implement this for the kernel based on LLVM's
handleAlignmentAssumptionImpl because the kernel is not linked against
the compiler runtime.

Link: https://github.com/ClangBuiltLinux/linux/issues/1245
Link: https://github.com/llvm/llvm-project/blob/llvmorg-11.0.1/compiler-rt/lib/ubsan/ubsan_handlers.cpp#L151-L190
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 lib/ubsan.c | 28 ++++++++++++++++++++++++++++
 lib/ubsan.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 3e3352f3d0da..a1e6cc9993f8 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -427,3 +427,31 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
 	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
+
+void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
+					 unsigned long align,
+					 unsigned long offset)
+{
+	struct alignment_assumption_data *data = _data;
+	unsigned long real_ptr;
+
+	if (suppress_report(&data->location))
+		return;
+
+	ubsan_prologue(&data->location, "alignment-assumption");
+
+	if (offset)
+		pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed",
+		       align, offset, data->type->type_name);
+	else
+		pr_err("assumption of %lu byte alignment for pointer of type %s failed",
+		       align, data->type->type_name);
+
+	real_ptr = ptr - offset;
+	pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes",
+	       offset ? "offset " : "", BIT(ffs(real_ptr)),
+	       real_ptr & (align - 1));
+
+	ubsan_epilogue();
+}
+EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
diff --git a/lib/ubsan.h b/lib/ubsan.h
index 7b56c09473a9..9a0b71c5ff9f 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -78,6 +78,12 @@ struct invalid_value_data {
 	struct type_descriptor *type;
 };
 
+struct alignment_assumption_data {
+	struct source_location location;
+	struct source_location assumption_location;
+	struct type_descriptor *type;
+};
+
 #if defined(CONFIG_ARCH_SUPPORTS_INT128)
 typedef __int128 s_max;
 typedef unsigned __int128 u_max;

base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
-- 
2.30.0

