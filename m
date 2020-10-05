Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41280282EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgJEC53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJEC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:57:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED161C061787
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 19:57:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so5808840pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGtLendMkx3eeiJ6VgZEb6Gt3GGRj2yTJFPvPu5CLd4=;
        b=RaF15Fd9rYMAFtanTSuiLem9OplLh2MzO6PBjm+lngJx9STARKCibEd3b0xHsunTvN
         7kiUTbR2+wm8WuBfQQO0XldpTAfbxT0hTaAQeAESh0fziqtK7T9vf4nwlgsOSi2UA8zb
         9kKQF2KzC/o+KXmnclK6xjAISy50b9I5axX18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGtLendMkx3eeiJ6VgZEb6Gt3GGRj2yTJFPvPu5CLd4=;
        b=K05wT0H2oYAQjX0qCzAVfdV67ov2QfFOFMgNK0ikRqj//at++UBLDXst3jNjYH72xQ
         2hRY6l4nk/gZ+z18j9LLquVHN8y2tXZ6Ehf4rVXE3PyXffKw/XqjGcz+KGURAw2lEOnv
         a+SV21EuwnfmuOkvJOnznenctoKLuqVmlrDFzav2/v0aghjL5V6LQ8058MLGK5zrGypd
         xuufLQVcyCP94a72GnlBUvTGwybloYfaGlbbf+RzmoRWzinFb8WZkjgfjcswMiFoGFoD
         /kY+ZCq7lTXxi6EGbiciO4h0pEKpkP2QaOM8//JBmYcXEFphxtVfi7h1YE2Hmc7MCCX/
         Wahw==
X-Gm-Message-State: AOAM532QPuWWUS29dm7zhbqNT02rymq2qUhd8JbiXFeXCoKXqMxyrn3l
        rWMQDbIjoV0C/drxxOig6O7VFEcGhAPfKejN
X-Google-Smtp-Source: ABdhPJzYZsOniKAdLpOGV0sZrQgSDI//LpzB3EcBLlQs0cCuAinuv387ORUReuh/aVhXmGOCp/qyJw==
X-Received: by 2002:a62:2985:0:b029:142:2501:34d6 with SMTP id p127-20020a6229850000b0290142250134d6mr14273789pfp.47.1601866648452;
        Sun, 04 Oct 2020 19:57:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g126sm9476727pfb.32.2020.10.04.19.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:57:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Date:   Sun,  4 Oct 2020 19:57:20 -0700
Message-Id: <20201005025720.2599682-1-keescook@chromium.org>
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
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 83109d5d5fba ("x86/build: Warn on orphan section placement")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: brown paper bag version: fix whitespace for proper backslash alignment
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5430febd34be..b83c00c63997 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -684,6 +684,7 @@
 #ifdef CONFIG_CONSTRUCTORS
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			__ctors_start = .;		   \
+			KEEP(*(SORT(.ctors.*)))		   \
 			KEEP(*(.ctors))			   \
 			KEEP(*(SORT(.init_array.*)))	   \
 			KEEP(*(.init_array))		   \
-- 
2.25.1

