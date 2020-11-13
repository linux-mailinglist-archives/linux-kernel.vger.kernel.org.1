Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382BC2B2202
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKMRUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgKMRUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:20:10 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDCDC0613D1;
        Fri, 13 Nov 2020 09:20:22 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id y17so8905332ejh.11;
        Fri, 13 Nov 2020 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sjc8KniBtNjED/lBoWeTXk5F0n8iK1Duyq0rjSX4Y94=;
        b=hRL+SO3Mj1STQTn+Ism6mIuT45SR6dDFOrEjt4N15P6O2reg/rJDNIK9fqNVqQLz3Q
         0tsRjJfVKWjz5uunupGeIj9HAuUqz7tZkXzXMO6PRaS2OCgpw1vi0EDqT5oosN1bQIP9
         k0stku+xCMVMVIDTM165rS6MXyIMF/mSM1JS/7fcys2/Qe/49Px/6tjjXdzlswoxg+E2
         siAN/gGlmRdeeD/B8b+HKFNd2mCbvalL4NHo0c44UboKIoanBlJPeOcF1d1aYp6gzgAH
         ftgB/1bmlL14c6xROWIZhZ62UDA+0MdLvm1KldI9Y5aEL28CwU1HBDputuX0PrB7d7Tl
         HUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sjc8KniBtNjED/lBoWeTXk5F0n8iK1Duyq0rjSX4Y94=;
        b=BnuBvAeJsTQEmCDxfwvJ40kubj31vBIn31h+7sCV7XM3fQQbZ5lX8GpKinKqPyJHG7
         quprPmP/chgkVnAmIDydZL9QpJq43ihgZedbhYZ2uHzDQ3JSAz0261PdVNZCYBY/O7DO
         tPzc9lW3bMH8vj9SZTFV0GJgyvnNtY2M2zxVlV/Mz3q783pP6+Vh731HYvJWsqo1XXAL
         LBv9J2U6PGi+UcwSlAa2wEvsRGl00Dnq4slN3guVehT2clZpTdGJnNwfBghbJZi81D57
         k3ncD0kav+EYL7phWzQot1qongnRnazbVTXs3DFTib8euT2PdBpFFPGoWiEUcX7e6wNY
         GkJg==
X-Gm-Message-State: AOAM532qQUzjDRbvBs5BGVKUf+LHWDapgSt3NjeWFdWBGl0lnh4pSFZS
        N84k7LrU2s40/maidYK7YmwlcItiXfEH5VUn
X-Google-Smtp-Source: ABdhPJwuDaTxb0lO0Wnuj5q68KUEAxyMowFqWC9oYietaqCcwXHI/GIzLiarYE8HhzEyNgDRaoDOnQ==
X-Received: by 2002:a17:906:3813:: with SMTP id v19mr3050721ejc.462.1605288021328;
        Fri, 13 Nov 2020 09:20:21 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de6:6700:3137:43ab:602a:9934])
        by smtp.gmail.com with ESMTPSA id rv19sm4152379ejb.38.2020.11.13.09.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:20:20 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Darren Hart <dvhart@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] futex: remove unused empty compat_exit_robust_list()
Date:   Fri, 13 Nov 2020 18:20:12 +0100
Message-Id: <20201113172012.27221-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ba31c1a48538 ("futex: Move futex exit handling into futex code")
introduced compat_exit_robust_list() with a full-fledged implementation for
CONFIG_COMPAT, and an empty-body function for !CONFIG_COMPAT.
However, compat_exit_robust_list() is only used in futex_mm_release() under
ifdef CONFIG_COMPAT.

Hence for !CONFIG_COMPAT, make CC=clang W=1 warns:

  kernel/futex.c:314:20:
    warning: unused function 'compat_exit_robust_list' [-Wunused-function]

There is no need to declare the unused empty function for !CONFIG_COMPAT.
Simply, remove it to address the -Wunused-function warning.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201113

Thomas, please pick this minor non-urgent clean-up patch.

 kernel/futex.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 00259c7e288e..c47d1015d759 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -310,8 +310,6 @@ static inline bool should_fail_futex(bool fshared)
 
 #ifdef CONFIG_COMPAT
 static void compat_exit_robust_list(struct task_struct *curr);
-#else
-static inline void compat_exit_robust_list(struct task_struct *curr) { }
 #endif
 
 /*
-- 
2.17.1

