Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467042F40C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393656AbhAMAnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392018AbhAMAOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:14:39 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD82C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:13:59 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r9so553916ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtzmkKAKIsKUQbcgnYgSWKmk6z6gl62X3y6GDOrXpNk=;
        b=FyywR9ImI13qhE1y1dqcqWVjaYpgu/9m6CA47pIpp/60fD8sBsM671PaTCYtQ+CncT
         U8RTdvqIrEDPj00J1zOtNZ2755RrrXdWxCgKPjwSYUHIsOjpztYx7EnHWzQR5BRxTtl6
         MtneYX9PbwchBL4fQQb06Nk+4cxbjpVpvfW1eAWgmPmw6lh8j/KuYXJdXGRFJ6Egt1v7
         ENf6rW16/BY/FC/I422iL/58ENX4P+7Miv/6BkguSdfGr42umsm+T9gwdQbKcS4xfO3F
         gxQUddpnSd5m0UqsGZFu3EVAVT1MQz0CdkxpVm3B+MBHB3b+u+c3kE5TRL5UPj+N4M4G
         s+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtzmkKAKIsKUQbcgnYgSWKmk6z6gl62X3y6GDOrXpNk=;
        b=uF3Vq5TRkbzb8nyAW+Vcy9njEiZzW8wNpGv03z95leNq/D4gQ5fgNngBIynp2nnDq4
         kwxfwlugPCqaJa6kDHAFaIz3q/yjLDjKniO7sBXs2heC6WBZCVZ9FgpyXV/g9wJ5k/0t
         H44n1aTn3i2d3jtnABVAcca6YW/Pghre0vIr1v9DOCuqnhz/k6G5YxgC0XNPq1y2rg64
         EPbaNxGDKBi+35iIBvu7AyNmeLdbLjYBY4ikt2QbO+aywmtw/Itg3/aLHf6kIdmqsJaj
         ShjAVHJkTKuSjPuf2wjwnuJbp6FmZajNCjQEsZiV2uBzO12+yjs8dXOkmkwyl4t7HSqV
         HCnA==
X-Gm-Message-State: AOAM530lqfQQVAsJEr57XghChxyXl5hLa6GkSFiEpLCDgjiIx4vWxDno
        lDe5CMMp133shrRyV/t9LmA=
X-Google-Smtp-Source: ABdhPJxt8Ue99Ig0i9LBigyltIzUTwUmvq2cvex79KNnl9OzsVob6yHUm0UJ7rw6B/M887T413ch5g==
X-Received: by 2002:a02:1007:: with SMTP id 7mr1929669jay.73.1610496838645;
        Tue, 12 Jan 2021 16:13:58 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 8sm280985ill.13.2021.01.12.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 16:13:57 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] ubsan: Implement __ubsan_handle_alignment_assumption
Date:   Tue, 12 Jan 2021 17:12:43 -0700
Message-Id: <20210113001242.1662786-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112205542.1375847-1-natechancellor@gmail.com>
References: <20210112205542.1375847-1-natechancellor@gmail.com>
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
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Use __ffs instead of ffs because due to size of input (unsigned long
  vs int) and we want a zero based index (Nick Desaulniers).

* Pick up Kees's ack.

 lib/ubsan.c | 28 ++++++++++++++++++++++++++++
 lib/ubsan.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 3e3352f3d0da..1432a8645224 100644
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
+	       offset ? "offset " : "", BIT(real_ptr ? __ffs(real_ptr) : 0),
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

