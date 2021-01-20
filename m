Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47E72FC871
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbhATDFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732622AbhATCwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 21:52:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32D7C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 18:51:21 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so11703881plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 18:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHx/ED+Lhky+fKAMNldRxPi7qVINm/3SLdq3SrEUWhI=;
        b=Pymh4J+/84mmPjflVp1/iwM8SnKh7BGCxuFxIx+s6urUTZOgENI7/GDGwAtaVGuGrb
         Iz0ZTO9xWyBuHORKDpDPKFRuir+JDLGOIadaUwAXQWc4MUbp7DDEHvw+z9hl3xPYp2sa
         ONyAPXNoSk5MiJ4Tjl8galLl10z/L+l0eUiOnsEZ6vxuWL2/vfYNR+pN7NQEN+8h/0xE
         +cf9+YeO9RnEw7ybfABBD+KwY/VJpGX+saPTfM54nGGhush656zxzjmfGpXEv5xD4JGg
         ozot1DDpJkO0MsI+QSIpUPz1s5hS8ccQiyht5Xz/WCYGq08MzCDdUNOm5L+GmCponWgw
         AW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHx/ED+Lhky+fKAMNldRxPi7qVINm/3SLdq3SrEUWhI=;
        b=ID5wMBDjZ0+yHi7pEhs/rHemm+GOX0rwk1Fx8g4QT6X4qaWJeMapic+RV1CJxpqMl9
         3fi0VVCsqojZkkpBDSiTb8olrjWvZsMLI8oE/9ztK9gUBXypsfyWSLGed6XzqMmV23rv
         AZ3S+FdJjV/tFPnnUs5baoOi7g/BAUgGQsMlbGLecfQEtnvmqjZ+B1faZp4QdxiQd8Cv
         XT/Ctx2sFEp9J8X3yGvCZxJ6doF1KPoq+YWlLrOtdg9ak+hgHBE255J8oUna7pPk82qs
         k2AT42rF7Qci1VfidYsIUAai0y3l77gGxomLKaWAU53JYlAQiYOnSshgVYz1ycc1cwge
         bSRg==
X-Gm-Message-State: AOAM531NwEVd2XqZys69dF+fxH59DfR7RNi0ZAYHcMfF9FZxG8g8bahK
        sFFjgjpA2d44ldBcYV2eNKk=
X-Google-Smtp-Source: ABdhPJxUitc6Pnd+GZVVHrs2A7CUgEXtJSw0HD1O3CZDaYpFv6tExxskvHSy/WdDI8YLMQjUCjdO2w==
X-Received: by 2002:a17:90a:8996:: with SMTP id v22mr3051734pjn.235.1611111081429;
        Tue, 19 Jan 2021 18:51:21 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id g17sm371197pgg.78.2021.01.19.18.51.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 18:51:20 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] ntp: use memset and offsetof init
Date:   Wed, 20 Jan 2021 10:51:14 +0800
Message-Id: <20210120025114.16294-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pps_fill_timex(), use memset and offsetof instead of '= 0'.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 kernel/time/ntp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 87389b9e21ab..3416c0381104 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -225,14 +225,11 @@ static inline int is_error_status(int status)
 static inline void pps_fill_timex(struct __kernel_timex *txc)
 {
 	/* PPS is not implemented, so these are zero */
-	txc->ppsfreq	   = 0;
-	txc->jitter	   = 0;
-	txc->shift	   = 0;
-	txc->stabil	   = 0;
-	txc->jitcnt	   = 0;
-	txc->calcnt	   = 0;
-	txc->errcnt	   = 0;
-	txc->stbcnt	   = 0;
+	int offset, len;
+
+	offset = offsetof(struct __kernel_timex, ppsfreq);
+	len    = offsetof(struct __kernel_timex, tai) - offset;
+	memset(txc + offset, 0, len);
 }
 
 #endif /* CONFIG_NTP_PPS */
-- 
2.29.0

