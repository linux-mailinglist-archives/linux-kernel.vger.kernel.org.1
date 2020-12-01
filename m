Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085EB2C9E62
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgLAJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgLAJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:53:21 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423E1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 01:52:35 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id s63so887332pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LU3g5vLQzyZTf7HTUB9fYI1m4LLPCMslXZ4eYrSd/Gs=;
        b=QpxOp8O9D09OZheOETrWj8vosanB4xtAj4Dgf5Qf5TzGz8C5zdIlT3bJKlDln6uohR
         No+zAjeGfAbI0osNbNwcdzBYJm+8iUfKYfbpmh+SDkinlEOwygRVoBq/kb/w/VEbm3AB
         k3J90iIeJF6bjvH0JAxPlQWRBYLW3pxy3Z49Z+b/UbI09HSwE3flTwt/jollrhqpg2yv
         qEcAKIPdhDSg+1t5nNoIMIfdKrADOegAzkTkfl+m3Vx+6ftOCQahOOpchCT+LikpgBp9
         MkKx9YqCvveCXMxFOMxyH7WPX46TuctjQpy6Vj/ZjrfeHJh0y63Zl+71I/pbrJkUl893
         JuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LU3g5vLQzyZTf7HTUB9fYI1m4LLPCMslXZ4eYrSd/Gs=;
        b=X6WAkv0gdyyhwzEvoReqGhf3K+bLE9C3C5TdoQaTehyQZWSYAuTOW/JLKmIftN0J6J
         fXebwpIzGQkOWQ6kNt4BGYIzlPZ/4NnnHKsl/f1gEFFKuAZ4e6FGL2Cl3GYtzvzfz90/
         DjnpKI0JiJjVECKkAWAxwWB+Y1lfmSX1pe2xjO/dQn/HgRXNEv+Mxt19EEUeSbdEStl2
         +0l6ZDol1eRfOq0DfVt0wD7Foad6pRf60AcKn5n5+Blw3ibMszTnsjfzC26DH5M7zfFu
         tl3hi2Z3EfAbpFQ2lucon/E4PtbP1Z0yFOx2tVeF5tVvfKrOp6UkVIYbkUp8wfVjf7kr
         enmg==
X-Gm-Message-State: AOAM533DFcb17StgPlNekdZCnPLOduwCpXwb8UD0CmofX0PiXFNFvMvb
        UEjSkR3S41CVqXEn6sVFl8pK7XRceko=
X-Google-Smtp-Source: ABdhPJxa57Fj8KJTrmvAkbEo2xOnWpDqcbJ/4QTO/PNl5oG+6ogXHk+2a/HE81F8QgbxEexVH+aKeQ==
X-Received: by 2002:a63:484d:: with SMTP id x13mr1523893pgk.301.1606816354819;
        Tue, 01 Dec 2020 01:52:34 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id g8sm2013199pgn.47.2020.12.01.01.52.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2020 01:52:34 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     sboyd@kernel.org
Cc:     tglx@linutronix.de, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] timekeeping: remove unused get_seconds()
Date:   Tue,  1 Dec 2020 17:52:31 +0800
Message-Id: <1606816351-26900-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The get_seconds() cleanup seems to have been completed, now it is
time to delete the legacy interface to avoid misuse later.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/ktime.h         |  1 -
 include/linux/timekeeping32.h | 14 --------------
 kernel/time/timekeeping.c     |  3 +--
 3 files changed, 1 insertion(+), 17 deletions(-)
 delete mode 100644 include/linux/timekeeping32.h

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index a12b552..73f20de 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -230,6 +230,5 @@ static inline ktime_t ms_to_ktime(u64 ms)
 }
 
 # include <linux/timekeeping.h>
-# include <linux/timekeeping32.h>
 
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
deleted file mode 100644
index 266017f..0000000
--- a/include/linux/timekeeping32.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef _LINUX_TIMEKEEPING32_H
-#define _LINUX_TIMEKEEPING32_H
-/*
- * These interfaces are all based on the old timespec type
- * and should get replaced with the timespec64 based versions
- * over time so we can remove the file here.
- */
-
-static inline unsigned long get_seconds(void)
-{
-	return ktime_get_real_seconds();
-}
-
-#endif
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6858a31..0a95bb2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -995,8 +995,7 @@ time64_t ktime_get_seconds(void)
 /**
  * ktime_get_real_seconds - Get the seconds portion of CLOCK_REALTIME
  *
- * Returns the wall clock seconds since 1970. This replaces the
- * get_seconds() interface which is not y2038 safe on 32bit systems.
+ * Returns the wall clock seconds since 1970.
  *
  * For 64bit systems the fast access to tk->xtime_sec is preserved. On
  * 32bit systems the access must be protected with the sequence
-- 
1.8.3.1

