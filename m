Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7D2AE6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKKDGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgKKDGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:06:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:06:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b25so960493ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=C8NYwKKk49NFdXJwjh7kRkQTeN13dEWuqSXpliOzs8c=;
        b=Kdl36wFgKAtm4JzH8t5rC3JCmD/OhgiWGJOZTTFihNxoHeOxJxRZx0KVQv8AwH2SKH
         skiwes1aiADrJmDbrawQvdunX71GS48OLN4/Lk3muc3b+v7TQbU2gH6qjab9SvxhqX5w
         bW5iaiEP/y11sN/xtrIP8jLG+nJNqESyKghWBpechXF0FAszfC33PCq2aGJmRv2dWM57
         bdY1EeqeQ+gHyOdiUy/rCDrM/PQ04NCUGWAPBrbBmMJoC1FPmk72ZwuU+09AauU0yBrL
         modTNTIq+6ZeMGrKSNQ3VMk5ZBi+NWCadgiqsvMdu2Z3f992zDPlEEYqDH0RTW3Q9Bjm
         +IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=C8NYwKKk49NFdXJwjh7kRkQTeN13dEWuqSXpliOzs8c=;
        b=T6sbc4irCfKn8ZZ5NVp0yMuGWuDJLG8lvcAxdNPD3UqpOf/pVIVFPK1oq53poZudsy
         bmBWg+ikzNWW3ay97qT8NIV4SeS77PgFsebgx3e6plTxwkcj8XRHpfQkz+KtqasRLZWt
         DzA/jk26Xe1TeZTPNaLCXQ7DR3douQeCyam1zCcclO7EZv0GZPTWBxFRtuY71N62hJDc
         tLhhCFvOMpgZ9/5x9T47WdCgHQmX2pSa69A0eByWqg0CVQKD64ph3bKdwkZIh5CUgvj7
         iUuRYC0wuZ69wKIpwy3+wWXSGV+8ixqPlXBhhe8YN5EoHlJPh9PcqDKxE8YnF8xE4CyD
         wrrw==
X-Gm-Message-State: AOAM533/1DQ3lvxv0Y+oo5hHIpVFjjkfaq95vVYr0Si0EgCgLzyeXXQK
        eLbye7jWI14vdgUoGC55WBLYaTsx2jhtDXJvSMA=
X-Google-Smtp-Source: ABdhPJy+qlSZpik2EfqZHCgoiDjlaglRr/S0JJfzYCKniiwVuAMdv21KYm7QiJqXimCZx842oXt/sGqSNII5bVLvLl0=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:3342:: with SMTP id
 z63mr25038540ybz.393.1605063969086; Tue, 10 Nov 2020 19:06:09 -0800 (PST)
Date:   Tue, 10 Nov 2020 19:05:56 -0800
Message-Id: <20201111030557.2015680-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] gcov: remove support for GCC < 4.9
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since
commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
the minimum supported version of GCC is gcc-4.9. It's now safe to remove
this code.

Similar to
commit 10415533a906 ("gcov: Remove old GCC 3.4 support")
but that was for GCC 4.8 and this is for GCC 4.9.

Link: https://github.com/ClangBuiltLinux/linux/issues/427
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/gcov/gcc_4_7.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 53c67c87f141..0da0aacc1f26 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -25,10 +25,8 @@
 #define GCOV_COUNTERS			9
 #elif (__GNUC__ > 5) || (__GNUC__ == 5 && __GNUC_MINOR__ >= 1)
 #define GCOV_COUNTERS			10
-#elif __GNUC__ == 4 && __GNUC_MINOR__ >= 9
-#define GCOV_COUNTERS			9
 #else
-#define GCOV_COUNTERS			8
+#define GCOV_COUNTERS			9
 #endif
 
 #define GCOV_TAG_FUNCTION_LENGTH	3
-- 
2.29.2.222.g5d2a92d10f8-goog

