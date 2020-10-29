Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7429F0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgJ2QJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgJ2QJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:09:45 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCD1C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:09:43 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o11so1025987pgj.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=M5ZYnY3+Esbb7Wzf3rbFgZzcgHLDPaDcLNV16K0VsQk=;
        b=TkD7sB+lP2yjvB0Gn0LUz1ZODCeWbb3o5+lnejOZhE+jvkt4r05YDH3rPa98mrHJ2C
         KXmSJyYJ57SAGMkmu/Z0F7JDtTXTG2GCkITcGFpmImYXiyrwTpSBlN9fNZMYyXRFMeIy
         AgEzX+9j08TZDbrZs4O0e2qGpPHAhU0mNA9AYKmXoqQg+1/zlQ0h6N0DlJUMXP0yN1cL
         Hk7ywZGSyVsXhivYWHj4aZ6lE/LguaopaSvmTW1vVdphKsbV9sTvx0HxpMe0n/4BTTKC
         4dgK1V1IizyRITrQLKfjBsdmQHqr8sBSXvFk/WUmaMzzypabYkwcGX7NktWevFA/hBBs
         mNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=M5ZYnY3+Esbb7Wzf3rbFgZzcgHLDPaDcLNV16K0VsQk=;
        b=PMsKZTq210PsoppBnjNWc+C5GRvYOpPmiq12P1COfnXgHwMYTQr8uy3ud5K3FJmuNM
         QVP2V3ds9Ev/xy6/tGR3XWT6P35qF+ZjIAr9AtZvxfzUy3NS6fD31o0lT/7AmthWfkz6
         wDFby9ACmYzY6czmIkBpR0sKhgP3oFDXUlwUaE26Nv9PKQQ4iYOj+AKEJvR6rpuCHeZZ
         1EZO1e2tkykEExyWOtDLY1p68f5J4dgHy8PsosulbuNzbrdu2GucXRkSo8QT3styxd0P
         N40J2VjeryVYyU4tcM3G9rzHwubCCc0T3r0VL+5iHKjmf205FMF0Jh3DkEQqZz1EAVH9
         r/yg==
X-Gm-Message-State: AOAM533AIji++yuuc7govjA0cYBPSXTmfc4akdolzCjYxc4+T0dJiiog
        gDMd13wxYmbSn/9HScSYQXnJ4BK6XJXw
X-Google-Smtp-Source: ABdhPJxxxja0byw0woovLqKs/U5wkLuHYPqEf0rerA1ne8mXTfKCoHV8TAnXpLkAJj3iQyXXo0gccX84HqgW
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a62:3815:0:b029:152:80d4:2a6f with SMTP id
 f21-20020a6238150000b029015280d42a6fmr5004920pfa.72.1603987783316; Thu, 29
 Oct 2020 09:09:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:09:38 -0700
Message-Id: <20201029160938.154084-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] libbpf hashmap: Fix undefined behavior in hash_bits
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bits is 0, the case when the map is empty, then the >> is the size of
the register which is undefined behavior - on x86 it is the same as a
shift by 0. Fix by handling the 0 case explicitly when running with
address sanitizer.

A variant of this patch was posted previously as:
https://lore.kernel.org/lkml/20200508063954.256593-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index d9b385fe808c..27d0556527d3 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -12,9 +12,23 @@
 #include <stddef.h>
 #include <limits.h>
 
+#ifdef __has_feature
+#define HAVE_FEATURE(f) __has_feature(f)
+#else
+#define HAVE_FEATURE(f) 0
+#endif
+
 static inline size_t hash_bits(size_t h, int bits)
 {
 	/* shuffle bits and return requested number of upper bits */
+#if defined(ADDRESS_SANITIZER) || HAVE_FEATURE(address_sanitizer)
+	/*
+	 * If the requested bits == 0 avoid undefined behavior from a
+	 * greater-than bit width shift right (aka invalid-shift-exponent).
+	 */
+	if (bits == 0)
+		return -1;
+#endif
 #if (__SIZEOF_SIZE_T__ == __SIZEOF_LONG_LONG__)
 	/* LP64 case */
 	return (h * 11400714819323198485llu) >> (__SIZEOF_LONG_LONG__ * 8 - bits);
-- 
2.29.1.341.ge80a0c044ae-goog

