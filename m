Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B553C270BBA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgISIJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 04:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 04:09:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55036C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:09:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so4972055pfd.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMKhkoJCE/QZIc6UvQcdP3LO8gmH7llVShi2zkc8C3U=;
        b=D5YVb54XNuD1ARljgYfBwz9gbl3NLtYcRQkU2ClwQffl2bvq/W+++c8l7QVvoA98pH
         bCkRzo7Xr9zMwMtEF56TwMvi3DPPsGQYzrQGhEeZ5TZ1M5boD+Z15dh1UhPC44ZOgFR/
         yCZj8/90Q8fmd6/mXLkKupEAtr76yzuD+k+yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMKhkoJCE/QZIc6UvQcdP3LO8gmH7llVShi2zkc8C3U=;
        b=JE4W3r4QQR4M8imlvaYFw9iKvBy+/uDG7UFMQhbCO7xmb0svkvhFKdEWgDzs9G6htb
         WfJ0+DjLwFUJzddLKCRnqZaPypEH0ACeSr6NN1eziY3eICrBmXnYg7iAHL0P5yjifdGJ
         Al+olnJ0NNqLb4xHKdliMTzkLg61IzEGO1l0W9D9Z3jPYYl4udBU/K8I3hRiHxQMopQG
         8hpnZaJGzK/bLVWBDY6jniYfF7nZejjhoLWkdQdzTGrYeyLCJJN0Y3EhKn0uu6RVVv3o
         tcmQw0UtX0CkFYOnmyVIsfY6TedQ88YPPWrz9U3Z8rRqoLxcUWMW2kHfZCOzMBwGLCd7
         qmQQ==
X-Gm-Message-State: AOAM532hmO0PwBzdxA9v783ZvhzhMLljACpw1+/2qtxTpGRksmigj82y
        uk1TE5S1PEd5gCPNgzpnkYgjGw==
X-Google-Smtp-Source: ABdhPJy1CmJ50FnyrQ1y9/PbOWOGYu4F6DXCS/LLy0T914PU782pMmYjnP6El383y40Vz76+eAFQGA==
X-Received: by 2002:a63:ec54:: with SMTP id r20mr29213231pgj.430.1600502983856;
        Sat, 19 Sep 2020 01:09:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f4sm2652865pgr.68.2020.09.19.01.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:09:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] entry: Fix typo in comments for syscall_enter_from_user_mode()
Date:   Sat, 19 Sep 2020 01:09:36 -0700
Message-Id: <20200919080936.259819-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to help myself and others with finding the correct function names,
fix a typo for "usermode" vs "user_mode".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/entry-common.h | 2 +-
 kernel/entry/common.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 159c7476b11b..474f29638d2c 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -38,7 +38,7 @@
 #endif
 
 /*
- * TIF flags handled in syscall_enter_from_usermode()
+ * TIF flags handled in syscall_enter_from_user_mode()
  */
 #ifndef ARCH_SYSCALL_ENTER_WORK
 # define ARCH_SYSCALL_ENTER_WORK	(0)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 18683598edbc..52f7f503a68b 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -206,7 +206,7 @@ static inline bool report_single_step(unsigned long ti_work)
 /*
  * If TIF_SYSCALL_EMU is set, then the only reason to report is when
  * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_usermode().
+ * instruction has been already reported in syscall_enter_from_user_mode().
  */
 #define SYSEMU_STEP	(_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)
 
-- 
2.25.1

