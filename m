Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C16A2F3FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395102AbhALXBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:01:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbhALXBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:01:44 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610492462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ScsfJIzxSa6NiYKubN0cGbswUB5FVUDdRx6xbWjqok=;
        b=rgP4QV5ufIsNcuoPssU8REPcbojGJxN3db2jabEB563h7MUcECIABnJV8qCv2kXNGtCMf1
        WOlXALKLX+skxkBGA5GzFwTK69Wwwm3m6+sdiz+ADTUyk1vTe57enUCPSDeNIHaQfClvA4
        FE0p5wYx6RzrbTNLnp5Ojvud7v0l9T1uNaglVjyvEIIpQZ8lxS9bLDGXSHF9NQa9kTDqMG
        P3MyQM2EMyKBXCmTMCWgGlvHLE4EL/ZYIgSN31iSy/FMfLIFRpaOvYoUMmVyS11tpFm1ku
        hvaGjpkdO6Z3K2CLGBFGSfzAjf4e4JtbVEmyxHskkx6wZ27NTs4f3YFv8jj6AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610492462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ScsfJIzxSa6NiYKubN0cGbswUB5FVUDdRx6xbWjqok=;
        b=i2AOOt25IEBUU5zKipVxtfgA4G7hNYV3Wd0wSXkPXOrRJ4P+mhqqKo+yq5rWc+jfAvLxrV
        JOv924qVLkrMzIBw==
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] tracing: Remove NULL check from current in tracing_generic_entry_update().
Date:   Wed, 13 Jan 2021 00:00:57 +0100
Message-Id: <20210112230057.2374308-4-bigeasy@linutronix.de>
In-Reply-To: <20210112230057.2374308-1-bigeasy@linutronix.de>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't imagine when or why `current' would return a NULL pointer. This
check was added in commit
      72829bc3d63cd ("ftrace: move enums to ftrace.h and make helper functi=
on global")

but it doesn't give me hint why it was needed.

Assume `current' never returns a NULL pointer and remove the check.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index aa9123878e126..252dfcabda3c1 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -152,10 +152,8 @@ static inline void tracing_generic_entry_update(struct=
 trace_entry *entry,
 						unsigned short type,
 						unsigned int trace_ctx)
 {
-	struct task_struct *tsk =3D current;
-
 	entry->preempt_count		=3D trace_ctx & 0xff;
-	entry->pid			=3D (tsk) ? tsk->pid : 0;
+	entry->pid			=3D current->pid;
 	entry->type			=3D type;
 	entry->flags =3D			trace_ctx >> 16;
 }
--=20
2.30.0

