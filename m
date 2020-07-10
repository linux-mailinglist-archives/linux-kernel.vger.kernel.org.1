Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A481221BB64
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgGJQwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgGJQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:52:36 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F9820874;
        Fri, 10 Jul 2020 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399956;
        bh=0ddB4nB8xvkRzosqnCLtYbbkuDFtWWfHraJbh6SPJb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNB0k5WKE8LUxXBlSBVjGZVKtO5lq8jeqkQ5MqWCSyjxry5pHBfrGHXuOMaxyF3Zj
         1PiYSOGjnGuKARE4F2MX3Iu7uVYAV4mF3SptJ7n4dSo7s4QnjeD3oyfIZ3gdLK48qY
         VFXaV0oJBiIGP8+ZjIEuoztf54X9JbzKht4crhzw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH v3 06/19] asm/rwonce: Don't pull <asm/barrier.h> into 'asm-generic/rwonce.h'
Date:   Fri, 10 Jul 2020 17:51:50 +0100
Message-Id: <20200710165203.31284-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 'smp_read_barrier_depends()' has gone the way of the Norwegian
Blue, drop the inclusion of <asm/barrier.h> in 'asm-generic/rwonce.h'.

This requires fixups to some architecture vdso headers which were
previously relying on 'asm/barrier.h' coming in via 'linux/compiler.h'.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm/include/asm/vdso/gettimeofday.h          | 1 +
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 +
 arch/arm64/include/asm/vdso/gettimeofday.h        | 1 +
 arch/riscv/include/asm/vdso/gettimeofday.h        | 1 +
 include/asm-generic/rwonce.h                      | 2 --
 include/linux/nospec.h                            | 2 ++
 6 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 36dc18553ed8..1b207cf07697 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -7,6 +7,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/barrier.h>
 #include <asm/errno.h>
 #include <asm/unistd.h>
 #include <asm/vdso/cp15.h>
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index b6907ae78e53..bcf7649999a4 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -7,6 +7,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/barrier.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
 
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index afba6ba332f8..127fa63893e2 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -7,6 +7,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/barrier.h>
 #include <asm/unistd.h>
 
 #define VDSO_HAS_CLOCK_GETRES		1
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/asm/vdso/gettimeofday.h
index c8e818688ec1..3099362d9f26 100644
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/barrier.h>
 #include <asm/unistd.h>
 #include <asm/csr.h>
 #include <uapi/linux/time.h>
diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index cc810f1f18ca..cd0302746fb4 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -26,8 +26,6 @@
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
 
-#include <asm/barrier.h>
-
 /*
  * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
  * atomicity. Note that this may result in tears!
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index 0c5ef54fd416..c1e79f72cd89 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,8 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+
+#include <linux/compiler.h>
 #include <asm/barrier.h>
 
 struct task_struct;
-- 
2.27.0.383.g050319c2ae-goog

