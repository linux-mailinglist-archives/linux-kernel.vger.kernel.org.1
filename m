Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C674F1E8FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 10:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgE3IUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 04:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3IUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:20:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5605EC08C5C9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 01:20:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y189so5977100ybc.14
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SSDWtclczDAnQ3izYJ36eT/zTxSHgQUYdQ4BNnNP5dw=;
        b=SoZuqjk5wCdKvtt2ddSgwDKZis7gheSmPwJ7AOOh3BfSWl96OT2AGReCq+vKcRCx2o
         nS2/ujfZTHHjjLmqXySF9YvjljROUkkQhVsYWFUXFXlsqcBzBF83mOAPdhq0eHwY1gqT
         coP1er9OG7YnYuP6AXADx19U4g+5oBzkZF/lHTzUqy9E2E/uCD/PcYLBmMTm37oG24UH
         T3f2n8SCgMfJ30pAwdxYtQ9mbR4aCV3hF8JZ3iKmk1WMqT9VF1tlFyL4JgounxepZ7o7
         6YXUgettE4RUxDPkrBFoWL0ucGvjz7MMguEWAW4mJyhuD7hKgbdll7RhU34pPBJ17K/Z
         yuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SSDWtclczDAnQ3izYJ36eT/zTxSHgQUYdQ4BNnNP5dw=;
        b=Zzw9hHft1kGtGaKD0ksd1Onf6jfqDBSToXaBv59rME+EJW5IOkOF3qCSV90jgZfrZ6
         1ZzuS7AGblZi15MuiItbHsazYgQfH5H7wOqVrWtK2omO9nbvd9sp2ACwPxaHCYnoXZtA
         dcOe1AglgCUrkc8HpuefIVJgQD3EGWJTTiUCgmmmu73fXLbFaK3/Wju2Lk248NLaK0Bk
         JcQKUrkqExXCCy7lvdH+aXYFWSJvwyZpEUH4jQxBbTVsiW6anc5Bp8S0DYI5tA1lGiUL
         u1wNWt84+Ude/hO2SSH6As7V50AGP6d30vi6AbCQzb2CQSq4FQa6et5b56p8joAfJTXV
         mVDA==
X-Gm-Message-State: AOAM533uNln/fM6QpOrxSg1WR4amLVsYO99qnIBfJ9XIgaPTvek0/3Jk
        WjfkqJ3awLw/PbWubpeluxGHt7IRpH+d
X-Google-Smtp-Source: ABdhPJyknIKx/8oei4rFgCfB6/mK1DLhBeR7NpvGBRKxHJDwcvfouBhEWwYanp35pLkbRRpbzWq2cUZ56YQR
X-Received: by 2002:a25:3f41:: with SMTP id m62mr18219047yba.455.1590826837446;
 Sat, 30 May 2020 01:20:37 -0700 (PDT)
Date:   Sat, 30 May 2020 01:20:13 -0700
In-Reply-To: <20200530082015.39162-1-irogers@google.com>
Message-Id: <20200530082015.39162-2-irogers@google.com>
Mime-Version: 1.0
References: <20200530082015.39162-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH 1/3] tools compiler.h: Add attribute to disable tail calls
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tail call optimizations can remove stack frames that are used in
unwinding tests. Add an attribute that can be used to disable the tail
call optimization. Tested  on clang and GCC.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/compiler-gcc.h | 8 ++++++++
 tools/include/linux/compiler.h     | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index 95c072b70d0e..cda555b47d3d 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -27,6 +27,14 @@
 #define  __pure		__attribute__((pure))
 #endif
 #define  noinline	__attribute__((noinline))
+#ifdef __has_attribute
+#if __has_attribute(disable_tail_calls)
+#define __no_tail_call	__attribute__((disable_tail_calls))
+#endif
+#endif
+#ifndef __no_tail_call
+#define __no_tail_call	__attribute__((optimize("no-optimize-sibling-calls")))
+#endif
 #ifndef __packed
 #define __packed	__attribute__((packed))
 #endif
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 180f7714a5f1..9f9002734e19 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -47,6 +47,9 @@
 #ifndef noinline
 #define noinline
 #endif
+#ifndef __no_tail_call
+#define __no_tail_call
+#endif
 
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
-- 
2.27.0.rc2.251.g90737beb825-goog

