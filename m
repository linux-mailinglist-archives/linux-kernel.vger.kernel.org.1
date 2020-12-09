Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB52D3F73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgLIKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbgLIKCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:02:37 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24306C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 02:01:57 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id e13so698088qvl.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 02:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tU0bH/ZopN0B+Ye8Q+EH0DzWrhlff2/lJmGr/Ir10cg=;
        b=jbjrQ7nKnTCEa9Q/zsYxYG1cRke4B6Nx3Kj8ebj1UTdl+dpvUQOXTDtZQ4g5Rt5lxF
         F1MEfFGvmfBY9nWVV9+kQqW1hfvZTLaVfrLi86O5MjUzEFQqFCi3SJ4CDN8VcE8M6ZFC
         oHN/xghGYIv4xgC+ZMCS98O2IF16MXznMrlI49mPJ+CoJ535BnDRRf1MfJjo0IIx2YoF
         9Ec5G0CfRG6MuNu8x7WW9hTeGt/xpH7PH36J/Mv35Jlmyj4geDvi44v3yJwgoDnJr2Zn
         YEaY12kVpBFLJflIBcKbF1Us1T4EUdkVo6YJVRTLK6WRhajTs3d2aUnPI+eJsHxY/hW/
         5wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tU0bH/ZopN0B+Ye8Q+EH0DzWrhlff2/lJmGr/Ir10cg=;
        b=EIIs5Mowi1GNm3NxlmaMBBG+jKHs8ARUFI0bfjeZ6sjeHLGej0c77BXgA+D/JJozoU
         eXQOJlYyvlNGyIyACRgHDuqx/xfVPmTd6nau3L9/gN+mAJ1NraKLoX1j1wNbeDAhEyrp
         Q/Dxks3J4Uqak7s5Q64P3ZMJ0a0/bAuDhzwGZ40nTpz8CgMpLIzqVtc4f1v+uMTE5+4w
         +cstK3FtZ/7I5KiuPdp6nRMNRbb8XVZ7d1NN5ZZh0Y2XG+t9LiolqF6GMpqV9sCo6+Dz
         GTC/7UKkGpAFayfnkSnID8KphNUBv6NQJABy74VX+ZeyYDrIJVA/idielBFob+tr+QGW
         lqbA==
X-Gm-Message-State: AOAM531jU5xfMBNeeb+w3WC0Th0NBX3TV0q9N/ZLg9Qz63+90eLHqOiP
        yhdodDZt0wFWm6NecYfbeKSvGnaFgj5C
X-Google-Smtp-Source: ABdhPJz1ztB2YS7DZ6K0X7ovGKfEW5/GocUTsWl5sXT9phgWkOUSXmjUvJkOXtzSvjImYEGO22JvrhVTpalN
Sender: "dvyukov via sendgmr" <dvyukov@dvyukov-desk.muc.corp.google.com>
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:a2ec])
 (user=dvyukov job=sendgmr) by 2002:ad4:4ee3:: with SMTP id
 dv3mr2224365qvb.58.1607508116142; Wed, 09 Dec 2020 02:01:56 -0800 (PST)
Date:   Wed,  9 Dec 2020 11:01:52 +0100
Message-Id: <20201209100152.2492072-1-dvyukov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] kcov: don't instrument with UBSAN
From:   Dmitry Vyukov <dvyukov@google.com>
To:     akpm@linux-foundation.org
Cc:     andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both KCOV and UBSAN use compiler instrumentation. If UBSAN detects a bug
in KCOV, it may cause infinite recursion via printk and other common
functions. We already don't instrument KCOV with KASAN/KCSAN for this
reason, don't instrument it with UBSAN as well.

As a side effect this also resolves the following gcc warning:

conflicting types for built-in function '__sanitizer_cov_trace_switch';
expected 'void(long unsigned int,  void *)' [-Wbuiltin-declaration-mismatch]

It's only reported when kcov.c is compiled with any of the sanitizers
enabled. Size of the arguments is correct, it's just that gcc uses 'long'
on 64-bit arches and 'long long' on 32-bit arches, while kernel type is
always 'long long'.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index aac15aeb9d69..efa42857532b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -34,8 +34,11 @@ KCOV_INSTRUMENT_extable.o := n
 KCOV_INSTRUMENT_stacktrace.o := n
 # Don't self-instrument.
 KCOV_INSTRUMENT_kcov.o := n
+# If sanitizers detect any issues in kcov, it may lead to recursion
+# via printk, etc.
 KASAN_SANITIZE_kcov.o := n
 KCSAN_SANITIZE_kcov.o := n
+UBSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
 
 obj-y += sched/
-- 
2.29.2.576.ga3fc446d84-goog

