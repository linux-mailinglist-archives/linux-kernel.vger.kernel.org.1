Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574302CF2CE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgLDRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:10:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731192AbgLDRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:39 -0500
Message-Id: <20201204170805.535920431@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607101797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sCjEAo7PXYGtuOfndYeVtCu06KHMeYV/70/xL6X2eNE=;
        b=X46fflSP9QJOpjXm6VyXn1JcE3XXNe9KsBh6Zmej1XoL4IdzYEX8jgrEYUs1cnq03QHfzM
        Z8IICR3PYyaVR/ebL2/IHROagyZ2/XwPdxieYhdZwqNgkIVWwbGVwfUCkR7GHBspDLnIc2
        OWJSVWlrCPpj1Iexx+dJjItmiQvRZ4BjazHJ5mrAiC+zHTR8slkUWHtI8oucMkTfsBWv9P
        095TeL6ZkkTw2M8gYuUjReo5njDBMdnEFAv9rHCEDTRfUHgrvdVDhk7I6zV/oDTh5Dw2Gd
        58/6Ly708BYi1YvEp/aeCScoU6I/tGemCf3OJG1bdnaoKmVoWN2vpxOvEKHZCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607101797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sCjEAo7PXYGtuOfndYeVtCu06KHMeYV/70/xL6X2eNE=;
        b=ifQddLxCsxf9Ol3XrASvWZOKqQarU2oHkn+iYyno8+PLCRgxjmKOxBVgj/RJOdELnWNldb
        tMBWrJYxJ4mDx2BQ==
Date:   Fri, 04 Dec 2020 18:01:59 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 8/9] tasklets: Use static inlines for stub implementations
References: <20201204170151.960336698@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Inlines exist for a reason.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -672,9 +672,9 @@ static inline void tasklet_unlock_wait(s
 		cpu_relax();
 }
 #else
-#define tasklet_trylock(t) 1
-#define tasklet_unlock_wait(t) do { } while (0)
-#define tasklet_unlock(t) do { } while (0)
+static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
+static inline void tasklet_unlock(struct tasklet_struct *t) { }
+static inline void tasklet_unlock_wait(struct tasklet_struct *t) { }
 #endif
 
 extern void __tasklet_schedule(struct tasklet_struct *t);


