Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E71A2B7085
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgKQU5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKQU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:57:05 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D46C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:57:04 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so7593786pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf9n4l7EOSL8uXdRL9UcruoyeN94agPo5jcXDhX5nJY=;
        b=jMJNd1lM27olGuBxYU0sDngc2zuZeRq5lDKU5rOo2wtnUwZ4jfa4T725Tygz07t15a
         TU8VyMCTM6dXGgeiravn3uQtZjP7pKLH09v76BS/6su0Z2BSW+JB0UMbeI5eZalXmiF0
         8TSnButTlMZ/XkuaWmMlqSrWxG85xBInJUGVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf9n4l7EOSL8uXdRL9UcruoyeN94agPo5jcXDhX5nJY=;
        b=ecqzWqbYBDFbzhhAjPafrg3VRCJmmD/7F5duvz/wwLnvD/Ps9YT2JnXrGEvFxYEy24
         eYq26Ym2hMG/AAqTLfp05dAA9d/vqce25qHAEXr5hTHK5LSI56T8mn+Hxo2QQguzJRMW
         4mrsDLsyI5GEGQwMO9CjnAGY9R1TjI+b326897GQDJSHYBpksujdeGnKTr0BKXZsOF+R
         NlZC5X7Js+gD8S8zwYEj8auy6FqewYBCmK0bSsS4+YcjDMyslsDZ+wNqBqmhe/DLkNii
         g6zfLacNPGh4PcHMIyJSH8pM1p4DzyzugpjDO3acr9jz822R2WiLaCZSrEhqi4eRSZEk
         JqYQ==
X-Gm-Message-State: AOAM533tsr9vIPvJ/n3mw0Np5Bpu/mK1zmv8Yfnr7Qi5sUQJMnLKQu+E
        a9jTOYkjBWXqbHUWDeWIfQhwYQ==
X-Google-Smtp-Source: ABdhPJw3j1XCkoo/ADs9hWbTzIJn4p6GlAXgdrb/on1MkteJCUDhZcYZTutrBGXrcTCm/MG8EIRZZA==
X-Received: by 2002:a63:1a1e:: with SMTP id a30mr5301001pga.168.1605646623572;
        Tue, 17 Nov 2020 12:57:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12sm4412524pjl.41.2020.11.17.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 12:57:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/seccomp: sh: Fix register names
Date:   Tue, 17 Nov 2020 12:56:56 -0800
Message-Id: <20201117205656.1000223-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the seccomp selftests were never actually built for sh.
This fixes it, though I don't have an environment to do a runtime test
of it yet.

Fixes: 0bb605c2c7f2b4b3 ("sh: Add SECCOMP_FILTER")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 7f7ecfcd66db..26c72f2b61b1 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1804,8 +1804,8 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 #define SYSCALL_RET(_regs)	(_regs).a[(_regs).windowbase * 4 + 2]
 #elif defined(__sh__)
 # define ARCH_REGS		struct pt_regs
-# define SYSCALL_NUM(_regs)	(_regs).gpr[3]
-# define SYSCALL_RET(_regs)	(_regs).gpr[0]
+# define SYSCALL_NUM(_regs)	(_regs).regs[3]
+# define SYSCALL_RET(_regs)	(_regs).regs[0]
 #else
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
-- 
2.25.1

