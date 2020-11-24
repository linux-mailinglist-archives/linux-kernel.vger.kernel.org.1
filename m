Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3302C238A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbgKXLCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732466AbgKXLCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:02:22 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78336C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:02:20 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id e15so746556wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ejkit5vRg/6bjTr9vpzggkXDL+i3cvGQkbbhHweAAWw=;
        b=BsMKMOtjB1k5P51Npe8s3UFKCot7yEPLGhajCO5NAF5rti479sZhhMxLzTR2xE8GOQ
         /tWORGPLO70ut/Rc9t9Odw3fMtC244qecQcLZh725u93aukLQidqHuaRCL7g/M0RCQvf
         yCzq2WLgkEZkv1/VaqXZiSrYSEJhlWo8xAqyJUv8qhen2KagOmrkxEDIMN6RMGj76+X7
         TpVH9olAyNPX8lSMFr6+UxpqN9volYrvdCV6FkL0BUP/EkpsyP5RHusWZQa9wqB6c4lY
         xZeAebDZ6ZoZ1EJB2TIrxuZfBpKFARQbEkam0ao0GfYjxImcAlXw14dGmVctHDjaLOT+
         IFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ejkit5vRg/6bjTr9vpzggkXDL+i3cvGQkbbhHweAAWw=;
        b=pp4ZcZq0Trlj/Wa6aEeaq+swIR2NkcQVgogx70j50Zb/yZoZNbdvRqtPWhGvh1wXTJ
         Gj84p3noN5EhtKpGy6j94fXCRlfNHJfV4kVr2LF1mMMKF/ROtS4i0+Xr2KyTduXu3D+S
         b2PuW7JzD9THK0646C98Q3I+zEzhZtC7ThIq70lSims+X0duYhfwv1SuOD4JNIF1QGQc
         4hyCiJ4KJs4gSpyd4GfMssxkfgclSgameNlsOttVux2dFOFF4W5Cyv4wPQBn+ynKo4qu
         shaqWMmzb8S35JcKYqVABOClrCyAIEU9DgF76ZosdPCgxT3CvINRAqv9yfccvM/G4yM5
         AGRg==
X-Gm-Message-State: AOAM532Wfh03N3IHRncgAar30l4e2BEBnSToGQryv89jg/9oRmxzqKjJ
        MqFnLXvjCg4jEN8C1T1t0nn60gbLIQ==
X-Google-Smtp-Source: ABdhPJwz1ArdbEA7KdXEa/ZK9nibpYtFPr6yrzSKrf5cxXV725on9gzEM/WpK7hRokE4iaYvKOOfJIODng==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:790b:: with SMTP id l11mr3880480wme.53.1606215739090;
 Tue, 24 Nov 2020 03:02:19 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:02:10 +0100
In-Reply-To: <20201124110210.495616-1-elver@google.com>
Message-Id: <20201124110210.495616-2-elver@google.com>
Mime-Version: 1.0
References: <20201124110210.495616-1-elver@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 2/2] random32: Re-enable KCSAN instrumentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, mark.rutland@arm.com, boqun.feng@gmail.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-enable KCSAN instrumentation, now that KCSAN no longer relies on code
in lib/random32.c.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Add patch to series, since KCSAN no longer needs lib/random32.c.
---
 lib/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index ce45af50983a..301020c49533 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -27,9 +27,6 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o += -fno-stack-protector
 endif
 
-# Used by KCSAN while enabled, avoid recursion.
-KCSAN_SANITIZE_random32.o := n
-
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
-- 
2.29.2.454.gaff20da3a2-goog

