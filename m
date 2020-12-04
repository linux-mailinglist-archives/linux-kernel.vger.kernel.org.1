Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458CF2CF2D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbgLDRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388548AbgLDRKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7427C061A55
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:09:57 -0800 (PST)
Message-Id: <20201204170805.430113367@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607101796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Bipj6mIxF9JiCL+9yiLcDvRzSrC35SSBNjPV63nG7Hw=;
        b=xsyuN+xvQbSeFEjDr9k11KjmG8+U8ye1f5f0Vcb+GDCVfi2heA+uFiC5F1NBnVaEGUUHdT
        5fya6ujJESuwC35A2efxp9aDMBucHP4++/LYmUoODpn0OYO1/1fUqbuUu0HqRbJiaAMjM1
        yoX8QmPcdp7vYLLJVnHS0S8c2KiMmFFz+q3jFYe3H3A2rZY+PPATElmvqPSYeUuOl0S0Rp
        TN1j3SUGnytzmUP4BALUjtmvADIa3FfeENj9L/MbI30S+8D98el6rjKp88smIxsvOvrAUc
        oojPSbrCRK8GKbHg4id6B8HdZy8DsdyzrzsBEBLX/76Y9jFvV1ONkcc8i21TLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607101796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Bipj6mIxF9JiCL+9yiLcDvRzSrC35SSBNjPV63nG7Hw=;
        b=kjNCitz1tg/3VOCOjDidhroaZrMVv1VDh6IBtgFLz1OgWbRLG2i0zSCI99SAFEG06F3yjS
        SozJtsO2bgXTyMDA==
Date:   Fri, 04 Dec 2020 18:01:58 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 7/9] softirq: Replace barrier() with cpu_relax() in
 tasklet_unlock_wait()
References: <20201204170151.960336698@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

A barrier() in a tight loop which waits for something to happen on a remote
CPU is a pointless exercise. Replace it with cpu_relax() which allows HT
siblings to make progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -668,7 +668,8 @@ static inline void tasklet_unlock(struct
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state))
+		cpu_relax();
 }
 #else
 #define tasklet_trylock(t) 1


