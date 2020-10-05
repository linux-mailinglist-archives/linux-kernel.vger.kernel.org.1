Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90C282EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJECwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJECwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:52:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4609C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 19:52:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so5037450pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 19:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IciHQ57heACOgQ9PC/WQNL2sEIEWQWn+OKT+AO4y60=;
        b=LRvEZ8zpjZa9iws3k1kqhxIuv+LUoqY7rPOE5iQhDSqNQgQA+Wz7eobrYV57c6G7zc
         rz592NrXEpqUGr/8TRoDwOga6VETgAEtksSa0bC8MFrck4LgWBajHHdkkWIo0EoTh9zD
         pb1WPerZkRLrnS9rICIEQBhXS5pEP2vq4OOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IciHQ57heACOgQ9PC/WQNL2sEIEWQWn+OKT+AO4y60=;
        b=ThfNggBZ3/q/e+ooSLMtWGHJMSyRrcB8jVaelGAZAdrxPAIdv/1ejw4sT63G3Sbq9v
         jnJMicexUtq56GIFmfJOVqBaKUtJqbmNrV+DZv0K8DIWCLUhr2BUrGQgXUOGxDTxljq9
         q4SZLTJqlU8oDE6FEfDeik4lIZTmLzy2onKpgDV79aF9HZU76WhYwNvtAPBsp9CYElCQ
         xzY5hFDehMJDvDp9KsC5gmYOPM6NGc3II9AynrN6xrdQzz3vWifvg+1ya2mT27Y/Um2s
         QSRtc2HqcfvjM8Y/BHFWiQzWpqZpeDHHE9MwxA9ZbyrrE9R+pBVl7IcmvcauX35O5hVp
         5Cxw==
X-Gm-Message-State: AOAM530gMRwaU2Akq8ewxZVTKsHvpJI298+2AU27uEz36r3TmEemxyUu
        0OwEETuhB68HUErBtnt4NrfXdw==
X-Google-Smtp-Source: ABdhPJwrfDf3JzEwDE2YM9/KbmpWBOTABz2Rs41fp6ejRSjaMIZwttbPkItPcfdn37XRe9FjRs3H2Q==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr12908598pgq.325.1601866374381;
        Sun, 04 Oct 2020 19:52:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t13sm1875164pfc.1.2020.10.04.19.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:52:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vmlinux.lds.h: Keep .ctors.* with .ctors
Date:   Sun,  4 Oct 2020 19:52:47 -0700
Message-Id: <20201005025247.2599175-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under some circumstances, the compiler generates .ctors.* sections. This
is seen doing a cross compile of x86_64 from a powerpc64el host:

x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/trace_clock.o' being
placed in section `.ctors.65435'
x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ftrace.o' being
placed in section `.ctors.65435'
x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ring_buffer.o' being
placed in section `.ctors.65435'

Include these orphans along with the regular .ctors section.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/20200914132249.40c88461@canb.auug.org.au
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/20201004210018.5bbc6126@canb.auug.org.au
Fixes: 83109d5d5fba ("x86/build: Warn on orphan section placement")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5430febd34be..45c8b362ca45 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -684,6 +684,7 @@
 #ifdef CONFIG_CONSTRUCTORS
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			__ctors_start = .;		   \
+			KEEP(*(SORT(.ctors.*)))	   \
 			KEEP(*(.ctors))			   \
 			KEEP(*(SORT(.init_array.*)))	   \
 			KEEP(*(.init_array))		   \
-- 
2.25.1

