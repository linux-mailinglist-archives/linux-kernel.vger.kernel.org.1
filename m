Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1972CCCB6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgLCCez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgLCCex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:34:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A9DC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 18:34:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k14so318394wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 18:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iSo6Bihl0p1Pv0+PVWNn7FM1Z5jV8m/qQOBvcLnlUQ=;
        b=SQ/7HJfnbK0zfiemZKWeEVhC75I7zulxJfoIv38QH7n2Ve+CBNyrQadGpTANUCPCY6
         Kx/oKvfCHRLgr/6GyTR94LkfOahsVXJQzilWG+cAZEgWsZZXUxZX3fYAnJF5ZStStL8G
         lMD0rNAywEqNWoPlESCMEkwFskKRrS0U+2DQi7LtlGWOJISNgI2N/cqbTOWVKNsN8m7U
         froXwJ3Zn5Uu+Gcgw1dteW1mLOwvRPdKp/FZ+d/DFUNt2TAgX33+OqeWFVQAdPfQN4j5
         C8bj519V+wlPnR3DL0iv++QMREKo17OycRQZ+oO28FFCrl0M/p/3PBi44dKjAIJAl3nU
         Nk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iSo6Bihl0p1Pv0+PVWNn7FM1Z5jV8m/qQOBvcLnlUQ=;
        b=iPi6+KPIlt5aBPPhTjRmxNzF6sswoJbiwelr+onk6vLZefFE5K1qR8twGBEKhAaGPO
         vSQys9uX9xvQ/QnCFx1j5i6Vt2FBle60I4+L6r60akSUbOUT2ZOSF8LDLwQy9NVStEOo
         Pw3h0Ymc4kMxXsdK1wpU6N/pbjs4OCu7EHNZ1bnUUIdctYB38ia73GjtOHWkAn4OmEsc
         p3U814GB3emb+d3IaQA5he+q/vH/jFnRNAz3FHg5x9pQk3KxUgot5il1fbCt9UjdCu+n
         a/VunjeMJf018iYKjNxMVAKaivjErxYg7yh3VAs8UUjokm08JA+xTYAp8RGG+e3goTgk
         JU1w==
X-Gm-Message-State: AOAM531IyKCitoFeLxwIP4kp9QjEicwc7I6SV3fZ04f1oEmRnSFA4aHh
        DDHWlTEq6KYUOFr9BJIoGB0Mwq9fe7bsVg==
X-Google-Smtp-Source: ABdhPJxKx/H1QOIKiEjeet7OYOQ4vzmmhyTP20rPzJwDv/tWVZVkejPWprvX4MGc4DR4gT+4sd/F3A==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr1056005wrq.224.1606962846920;
        Wed, 02 Dec 2020 18:34:06 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id e1sm663500wra.22.2020.12.02.18.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 18:34:06 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [RFC] exit: do exit_task_work() before shooting off mm
Date:   Thu,  3 Dec 2020 02:30:46 +0000
Message-Id: <abab9af4e0d26358538a45a2826650e9cefd2924.1606961931.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle task works and lock it earlier before it starts killing off
task's resources like mm. io_uring makes use of it a lot and it'd
nicer to have all added task_work finding tasks in a consistent state.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

Would it be correct? I clearly don't know all the exit invariants, but
can't find any users relying on task_works in-between.

 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 1f236ed375f8..c2a0cffd824d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -763,6 +763,7 @@ void __noreturn do_exit(long code)
 	}
 
 	exit_signals(tsk);  /* sets PF_EXITING */
+	exit_task_work(tsk);
 
 	/* sync mm's RSS info before statistics gathering */
 	if (tsk->mm)
@@ -806,7 +807,6 @@ void __noreturn do_exit(long code)
 	if (group_dead)
 		disassociate_ctty(1);
 	exit_task_namespaces(tsk);
-	exit_task_work(tsk);
 	exit_thread(tsk);
 
 	/*
-- 
2.24.0

