Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173F4302D30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbhAYVDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732089AbhAYTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:46:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D807FC061788
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:45:18 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611603917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+19JPvUeEPz3buNdrU4/rwbMP83cWYc5rUDipvmbJA=;
        b=LkCUhikzMxHbxgQqUWYhL5yHUaIPlvz7fZEXS+dH1qV7jDgyOxszPrHQOPDuP/5Ul9Z3MB
        Lbtc9VQjEIJBrEDCLIvpK652BDXv3M5nYQBWjyB5I9eM4SI26nNKDswf1JIn/KRmYzPSOo
        go9VV5I0xYJY5LQ1PyhyB/LJCUItHIm8FjF8R3B7rhqCgE/9xozjRXmkog3JHTsKBat581
        1aPQ+3YkYwLfJN21xQvJaCkD19eQIqisxt5eVLjpWFQJOK2+YwMQRX87/tgxqy9JzOG4IZ
        FWw5KX4/RTflRj3bDGbsqPHJCY1e4o2B5A8yAo8tOsHlm9xY6d3XNT2kbKz+YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611603917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+19JPvUeEPz3buNdrU4/rwbMP83cWYc5rUDipvmbJA=;
        b=7ngGw6xOfD56rGDoDEJWxrD/oe1GIqeQQbOEAceTVAwNhjkQ6nyYkmgGtSyVOuxgbbuNub
        Hr18UKU/g8CiyYCA==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] tracing: Remove NULL check from current in tracing_generic_entry_update().
Date:   Mon, 25 Jan 2021 20:45:11 +0100
Message-Id: <20210125194511.3924915-5-bigeasy@linutronix.de>
In-Reply-To: <20210125194511.3924915-1-bigeasy@linutronix.de>
References: <20210125140323.6b1ff20c@gandalf.local.home>
 <20210125194511.3924915-1-bigeasy@linutronix.de>
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
index 67ae708de40d6..5d1eeac4bfbea 100644
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

