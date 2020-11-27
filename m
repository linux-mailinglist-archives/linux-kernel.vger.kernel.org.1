Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEA2C6C59
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 21:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgK0T6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730461AbgK0Tu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=fZr76kxy0g9tmUeP1oCucnoxg13U+KOxXCfO18cIlKs=;
        b=a4F8GhnYpmixMcCI/+IWjRl0hwBRJh0lTuUmWp9qdL6rH3+LOvde2ewDcNqhXrbPjQcIrS
        XMdrF3uJw4ZVQY1v7bstLUXBBt8tNt4qD60pBQgRQlZGyOZdnOP1oBTeDsjBMGhNYKYnc+
        626ZWr9RDzeNnLvcbLABJDxNcxRmoFA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-qjijVd6FMtWe17V8eFJJow-1; Fri, 27 Nov 2020 14:36:10 -0500
X-MC-Unique: qjijVd6FMtWe17V8eFJJow-1
Received: by mail-qt1-f200.google.com with SMTP id y5so3785107qtb.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fZr76kxy0g9tmUeP1oCucnoxg13U+KOxXCfO18cIlKs=;
        b=eKKHPPG4Hobt6DzontOEqJjGnp641Q2mFnTE85EMAIa15CRtrqFqpDxv+cJFmz7fDY
         GoHhHO1V8Dcjyb4H8x6IVmwC1RIhDxMVGqoN5ZTcjOrEH3LP2Lzc/Y2QYVvUZmC1Jd+X
         vkcB8TJGKzbtRM5+3e87n5oI/SXP+vqXMjIIdCvs7lAN5CVPva/D2ky52swcfr+VGyEZ
         mnbNDGsLsM9R+QeN9PjHjbHGvsdcAyO/LMImji8rBNI1Kk9jRrjlU29yS8VoPiLXWW9J
         lnVTmmftOJv2mxwcqpzsHvK2u3fe4JsqocW0H777so6Ada2KCnYt7SAasZGHkHVhFkav
         uhnw==
X-Gm-Message-State: AOAM530+pg7CJ91EDCU/12WTDvTTDI12PEp41wdJT4ULUSFQIRZtu5T6
        2r+VMLT8N9B+hgOUteQ5isp3iZlt6PfNPWFq34/3Il2Wcy1TYEKSZSxU9+ZuUGqYURokcu+Pt64
        4pztxBS3CJHWCcYZeHYBgwypC
X-Received: by 2002:a37:6296:: with SMTP id w144mr10440136qkb.312.1606505770348;
        Fri, 27 Nov 2020 11:36:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmNRm8+t9/Z9sF2VADZibkWi1lXG7aGwsSizzWAW8YOfIlRU0G5cFanib1n2E8LRWm5cWM7A==
X-Received: by 2002:a37:6296:: with SMTP id w144mr10440119qkb.312.1606505770160;
        Fri, 27 Nov 2020 11:36:10 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t126sm7325284qkc.76.2020.11.27.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:36:09 -0800 (PST)
From:   trix@redhat.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] locking/selftest: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:36:04 -0800
Message-Id: <20201127193604.2873370-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 lib/locking-selftest.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index a899b3f0e2e5..69b4a1160094 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -935,7 +935,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 	LOCK(B);			\
 	UNLOCK(B);			\
 	UNLOCK(A);			\
-	IRQ_ENABLE();
+	IRQ_ENABLE()
 
 #define E2()				\
 	LOCK(B);			\
@@ -995,7 +995,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_wlock)
 	LOCK(B);			\
 	UNLOCK(B);			\
 	WU(A);				\
-	IRQ_ENABLE();
+	IRQ_ENABLE()
 
 #define E2()				\
 					\
@@ -1170,7 +1170,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(W1W2_R2R3_R3W1)
 	IRQ_DISABLE();			\
 	WL(A);				\
 	WU(A);				\
-	IRQ_ENABLE();
+	IRQ_ENABLE()
 
 #define E2()				\
 					\
@@ -1218,7 +1218,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_wlock)
 	LOCK(A);			\
 	UNLOCK(A);			\
 	U(B);				\
-	IRQ_ENABLE();
+	IRQ_ENABLE()
 
 #define E2()				\
 					\
@@ -1272,7 +1272,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
 	LOCK(A);			\
 	UNLOCK(A);			\
 	WU(B);				\
-	IRQ_ENABLE();
+	IRQ_ENABLE()
 
 #define E2()				\
 					\
-- 
2.18.4

