Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE802F99D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbhARGWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbhARGV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:21:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D56A02256F;
        Mon, 18 Jan 2021 06:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610950845;
        bh=bE6z4vwevMCwIw3AY9V3tR79VELiXPkOI9dQ368YjhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/G6McLeWplCOSzIwytUBIwrbuX4RPiljho8QlBAftC8E0qis0XrmZwLciqXmAZCr
         mowwYwkEuPp3JkNN9kpsmC1P/J6/jyBhFk8W7Xo7s9JH56qRD81Y4BZFSOa5hRqPd7
         9ccVL9kINnICZxl7TVLWFCv5+Z3MA2B847TD+7y0FOhG32bYZiJIgGM7071c6VspAX
         DLS4AORIof886KaL2wzg2QvYPH+ZA643ImH8Wd2pcb9XEgx+8VcTMzmUoK86eMulUj
         d0v1+xnpAPrc2czfAOjT9TW6Oh7Yd2ixAeZ5y3zXzJFzxsJHlXRGm6EUhn7ueEKmq+
         z6TB0lb4GWMYg==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/4] x86/mmx: Use KFPU_MMX for MMX string operations
Date:   Sun, 17 Jan 2021 22:20:39 -0800
Message-Id: <233a815f5c34cdefb25628fead19b6789b8bd273.1610950681.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610950681.git.luto@kernel.org>
References: <cover.1610950681.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default kernel_fpu_begin() doesn't work on systems that support XMM but
haven't yet enabled OSFXSR.  This causes crashes when _mmx_memcpy() is
called too early.

Fix it by using kernel_fpu_begin(KFPU_MMX) explicitly.  This should also be
faster, since it skips both the reasonably fast LDMXCSR and also the rather
slow FNINIT instructions.

Fixes: 7ad816762f9b ("x86/fpu: Reset MXCSR to default in kernel_fpu_begin()")
Reported-by: Krzysztof Mazur <krzysiek@podlesie.net>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/lib/mmx_32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/mmx_32.c b/arch/x86/lib/mmx_32.c
index 4321fa02e18d..daa80fa005fb 100644
--- a/arch/x86/lib/mmx_32.c
+++ b/arch/x86/lib/mmx_32.c
@@ -37,7 +37,7 @@ void *_mmx_memcpy(void *to, const void *from, size_t len)
 	p = to;
 	i = len >> 6; /* len/64 */
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_MMX);
 
 	__asm__ __volatile__ (
 		"1: prefetch (%0)\n"		/* This set is 28 bytes */
@@ -127,7 +127,7 @@ static void fast_clear_page(void *page)
 {
 	int i;
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_MMX);
 
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
@@ -160,7 +160,7 @@ static void fast_copy_page(void *to, void *from)
 {
 	int i;
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_MMX);
 
 	/*
 	 * maybe the prefetch stuff can go before the expensive fnsave...
@@ -247,7 +247,7 @@ static void fast_clear_page(void *page)
 {
 	int i;
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_MMX);
 
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
@@ -282,7 +282,7 @@ static void fast_copy_page(void *to, void *from)
 {
 	int i;
 
-	kernel_fpu_begin();
+	kernel_fpu_begin_mask(KFPU_MMX);
 
 	__asm__ __volatile__ (
 		"1: prefetch (%0)\n"
-- 
2.29.2

