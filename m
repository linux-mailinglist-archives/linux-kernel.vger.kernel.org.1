Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B9A2D5ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbgLJMpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732260AbgLJMpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:45:08 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9EC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:44:26 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f11so6505398ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXISkJRfuu29yjZKwNcwIYWwxoidthXqPj4iaxzKDlc=;
        b=Fz8/+pHJLyY0S6eIVmi7KN83r5sa2zEd+2fV9GFcAdBbY/A5VTUhlzKFQgXgA+3MjL
         bcCILtKcRi/c4GFV9iif2seMC3bJe5ExwfFFzODPnVcCgFxSmGkfhn8nZSl2xv9JDzEf
         0VQdIb3MZPmod0JAUZ4i9dz3dZE+rUCEvbNRUqGxPSMOMC4upWNHFho+uDGvtMdYHr6s
         c+mCRuUxxREqNPFasZ+aktHEHECgvuZJenlS5S4sPRtE5aH9ZWV/pMqZaS4m80xo2so4
         mTe1qMoIO0CBwBOkiRK87fBvmofjsAoOHt3xEh/MxZBHjm+AZnWlPPRJ8l867VrkTOU3
         lKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXISkJRfuu29yjZKwNcwIYWwxoidthXqPj4iaxzKDlc=;
        b=TJXh4YZzH3zyOEaQcpFPPFm37obIzMwq0Lb9kBpcUgyRZQp9wL6exOojHx99Bnb0ZU
         qb6Zmjoj4z8bYo7EZBovEBRIhaE4kNA7t7Hvp67yx+AAH5nuCxRTIUD70H0l8ac9cK6p
         rjhwOqwDOsEzS2G+qvyB9aiBSWvBGoVVTBIGCMkgR0KiEqdHqSOy7sDmyJNuErv+XQ6L
         rX53pJQg60Sc5x/f7wKn5ebHAnZKtkLhhzYkeHwJ8BUPlyURzGn+Uox1cryhBNprM1p+
         3IrFP7pBkzhCyrzoY8RNN5lIgVbPUPs+Wa2XVJgJvnwDE9mA9ppU2gwOaYIWIjlSRcPU
         3NVQ==
X-Gm-Message-State: AOAM530dzaxJ5njuugjcmKubwdBPolQifswIbP3VSPQ5DGQdRFn+Doni
        VK8vVI7Jnd+I45cVzlR/RCnQ6w==
X-Google-Smtp-Source: ABdhPJyeTzvL/BAx+p7eJgSGOi/kKBb47wPWWLFHxAznS7LBli9DuRslR/mTlbFqG9Sx4biauKJtkg==
X-Received: by 2002:a2e:1657:: with SMTP id 23mr2951196ljw.12.1607604264913;
        Thu, 10 Dec 2020 04:44:24 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id z20sm592544ljh.86.2020.12.10.04.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:44:24 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] sh: kernel: traps: remove unused variable
Date:   Thu, 10 Dec 2020 13:44:22 +0100
Message-Id: <20201210124422.3858524-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building defconfig the following warning shows up:

arch/sh/kernel/traps.c: In function 'nmi_trap_handler':
arch/sh/kernel/traps.c:183:15: warning: unused variable 'cpu' [-Wunused-variable]
  unsigned int cpu = smp_processor_id();
               ^~~

Remove an unused variable 'cpu'.

Fixes: fe3f1d5d7cd3 ("sh: Get rid of nmi_count()")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/sh/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index f5beecdac693..e76b22157099 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -180,7 +180,6 @@ static inline void arch_ftrace_nmi_exit(void) { }
 
 BUILD_TRAP_HANDLER(nmi)
 {
-	unsigned int cpu = smp_processor_id();
 	TRAP_HANDLER_DECL;
 
 	arch_ftrace_nmi_enter();
-- 
2.29.2

