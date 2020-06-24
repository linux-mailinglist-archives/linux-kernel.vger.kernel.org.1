Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BC3207D55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 22:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406592AbgFXUdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 16:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406570AbgFXUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:33:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC07C061798
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:29 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id l6so2484258qkk.14
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0gnBAHJLx9lqO/s+HwJkcFCIJr1VhaUKeKhoSxpNVYo=;
        b=BZIaPVfK4mM5FaEgiOXOWzMHkzLTbGkEfiJOtrAEFVfi2gebzUCHiY5apTLMtfHkTM
         l75+dKXwrfuQQVQD2stOWlndadQB1Zc6NUYn/q6QeMRTQnSqWTMGKUHewmR4G35OHvGp
         b5/SiArvL0S+A3ZHxVqs+VYlHjtrFUCuNx8i9CZCiQNeqcMm9dSVbAn39gIUe0DUghnD
         /f5TKe7Xx1FfkMjgZr3OsJkbEjKTvqcrDihZLf9/s8waWGOostMsdN7liEE23xBIKS3z
         6Rz9E3efblWhUua9EUcgFt56u58fIXV0W2fm5zALG7kNoivW4ApgaZxGRBArCosaw+co
         NR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0gnBAHJLx9lqO/s+HwJkcFCIJr1VhaUKeKhoSxpNVYo=;
        b=aQmrnN5z1/MQBa8lcr2XjYZU0U/B2QzsZxOJWPhYQ7oRMYyU/h3/nT7JelLVMaXsf2
         AnNkTxaSfu8OWv/i5SCUSuYayBZ31XNnkI/6HBaWRqt4+K3imUct9FOPZzbu7RV1bCfD
         e7otu0CuCoWkdH8fuUwa3jN3t60cLGXUK4IPSxOXyqxo7XEAsgzcnYKGY5B37SWEsDH1
         +Vvr9P/hnkWICkHdJjIwjKsZxtQbeOT/wAkTkObvCgK5Ju9juNafT56xByatqVIRraeI
         LYoUlkmyqrwvyzokooft6QcId1u/ev3q8ZZxxLbE2B8m8UBDkJroukaUhKih9a5c4Yx1
         3dOA==
X-Gm-Message-State: AOAM532BWRTpUZlPGMfrCpRkyaUEkhmyELZ9Dvx0FCA+NGwDA1DWj3cx
        Y+2n0hFGabtzW0lqJG2z8KjJH7Mc9BqdlMUgvtc=
X-Google-Smtp-Source: ABdhPJxTPJmHGzX5Q2m0yR96w4zaIPYDqCpLQon4kItXV3AD16e4+1m+5QFH8jaic4yItHA3V16FC+0hhVHCKPD3doc=
X-Received: by 2002:a0c:ec4b:: with SMTP id n11mr33232031qvq.103.1593030808901;
 Wed, 24 Jun 2020 13:33:28 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:55 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 17/22] arm64: vdso: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filter out CC_FLAGS_LTO for the vDSO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 556d424c6f52..cfad4c296ca1 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -29,8 +29,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
-KBUILD_CFLAGS			+= $(DISABLE_LTO)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.27.0.212.ge8ba1cc988-goog

