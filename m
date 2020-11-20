Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8032BA607
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgKTJYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgKTJYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:24:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD98C0617A7;
        Fri, 20 Nov 2020 01:24:30 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605864269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZK1ZQAJK0YFuKDRqLDBqeq+cdk+V8TA2LiKuEK4hA0=;
        b=QdQkoXLdDw+CnWlsb27giYSPgEhQFYBU94hVTEYcpN0n0dmiidPjZoWh63+U2VzjCLqHzQ
        T0DZsru432UHNUEEUcQ3k4d4IVDEZezwL2tO6L1sRZRb/YX9BXW2A9X7pCuMbUYA1zm3gg
        9ydjex1VHwCWLW41kt+UqdMVdug1YhZDAetRAI0zLh/oyx1+1mcwEFJDsJGhIDEia4P6DF
        d/vKLu3H1gCGirmVF6+eFS0l5LAfWyTlMcmt0gEIaDAIWIQeFku3uCj685VAF3TAZ+iCpT
        yAwu7W+JIpEEHWEZTHb5hjxjQkV77tGO7nghEJtl6jVKEUUsglO0ps83SrGOTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605864269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZK1ZQAJK0YFuKDRqLDBqeq+cdk+V8TA2LiKuEK4hA0=;
        b=BLdvAgn5pWIEsv2E4BTGgH03VHGCL2Cvir0i273ARp5LtnySylOtzxGwCxWBjqk5Umme6J
        +qZiuTdqJ3iczMDQ==
To:     linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/2] ide: Remove BUG_ON(in_interrupt() || irqs_disabled()) from ide_unregister()
Date:   Fri, 20 Nov 2020 10:24:21 +0100
Message-Id: <20201120092421.1023428-3-bigeasy@linutronix.de>
In-Reply-To: <20201120092421.1023428-1-bigeasy@linutronix.de>
References: <20201120092421.1023428-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both BUG_ON() were introduced in commit
   4015c949fb465 ("[PATCH] update ide core")

when ide_unregister() was extended with semaphore based locking. Both
checks won't complain about disabled preemption which is also wrong.

The might_sleep() in today's mutex_lock() will complain about the
missuses.

Remove the BUG_ON() statements.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/ide/ide-probe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 1c1567bb51942..aefd74c0d8628 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1539,9 +1539,6 @@ EXPORT_SYMBOL_GPL(ide_port_unregister_devices);
=20
 static void ide_unregister(ide_hwif_t *hwif)
 {
-	BUG_ON(in_interrupt());
-	BUG_ON(irqs_disabled());
-
 	mutex_lock(&ide_cfg_mtx);
=20
 	if (hwif->present) {
--=20
2.29.2

