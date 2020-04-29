Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC91BD229
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 04:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgD2CTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgD2CTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:19:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E49C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 19:19:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p25so332837pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 19:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yliQJbnfEYsEii+8z3aBoGQQNvsBG+whiVnwBChCNWA=;
        b=tAavYxYKE34MWcTAGwCgbZhjvK5+1sZ7DqCjjiXZXFa/9BNhjZrjSdl0aOjT0yt8v0
         CKS/78B0KHpc9T6KhW29Tv3rkRayHtSAaZx5s0XdqLwAYkq8+2sj4aa8jzu5dpe5x8Ua
         g8ptE/gNDz+lHsAUfQFQECiOLG++ZiHJDi3xIrMsGF8yBwqOM+anZEVoof7Y16jLorLV
         mSPZamxrkzlMLtVXwozc1X2y15wKPJwAT5ZfMjPWfeqHBKI1ITyQEZR/WGIy3yh3i0JZ
         D7nLc7xqG0ZxUAodKgrzeBD4W+gqgsfzPK167kW/IALFX8pjKFNOy0TbwsSAv9/gzIs8
         Az2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yliQJbnfEYsEii+8z3aBoGQQNvsBG+whiVnwBChCNWA=;
        b=D/yRYiAtvY3dZ4GsAijACkXPOsxtMsmz/6GI6y4N34F3NcvAzWSs9Jr7t49hyzdEVh
         DO0eJLgJCQMo1IvmG02xascFTxiv0gExBL/Uz99d7Trd+YP2ts0pW2bs0+xDVQhrP8Lr
         wgtfwKooNvbSTUm9PtK7HfffKZWP298Fzs8S1J1lJZExgORXYH56FxB/ZMx2PUNsSSXO
         3h26S2sDereDRJ55NHJ5lN8WCqcWk1LCt4AqknJciUAH31LAb3Ea64ecyiKgmjPAd9eo
         nmt1pI5tBg4ZMi1AhJGnMqN2x2wjkbLwMohRUsVl8HOaFF8ECHj8U/Nr3WRYmOJy3HWM
         JD3w==
X-Gm-Message-State: AGi0PuYeXtnKqT4vFvg7pzr3GDd004o89qESQrPu918sPB758JJ2zTWk
        xC2dos8xj/qe1kL2euDhyfg=
X-Google-Smtp-Source: APiQypKTUNaIKtRITy7gON5NjIw7Xf8GTmUBx4DfFY8sIWNfV9LxBoYFX9MaDpnCTkHIz9uXbpLP5A==
X-Received: by 2002:aa7:9724:: with SMTP id k4mr33177893pfg.309.1588126768306;
        Tue, 28 Apr 2020 19:19:28 -0700 (PDT)
Received: from localhost ([159.203.232.101])
        by smtp.gmail.com with ESMTPSA id b24sm16257206pfd.175.2020.04.28.19.19.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 19:19:27 -0700 (PDT)
From:   Sean Fu <fxinrong@gmail.com>
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Sean Fu <fxinrong@gmail.com>
Subject: [PATCH] workqueue: Use IS_ERR and PTR_ERR instead of PTR_ERR_OR_ZERO to remove redundant definitions and checks.
Date:   Wed, 29 Apr 2020 10:19:05 +0800
Message-Id: <20200429021905.10639-1-fxinrong@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce code size.
Before:
   text	   data	    bss	    dec	    hex	filename
  47510	   5979	    840	  54329	   d439	kernel/workqueue.o
After:
   text	   data	    bss	    dec	    hex	filename
  47474	   5979	    840	  54293	   d415	kernel/workqueue.o

Signed-off-by: Sean Fu <fxinrong@gmail.com>
---
 kernel/workqueue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f271..ddf0537dce14 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4197,7 +4197,6 @@ static int wq_clamp_max_active(int max_active, unsigned int flags,
 static int init_rescuer(struct workqueue_struct *wq)
 {
 	struct worker *rescuer;
-	int ret;
 
 	if (!(wq->flags & WQ_MEM_RECLAIM))
 		return 0;
@@ -4208,10 +4207,9 @@ static int init_rescuer(struct workqueue_struct *wq)
 
 	rescuer->rescue_wq = wq;
 	rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", wq->name);
-	ret = PTR_ERR_OR_ZERO(rescuer->task);
-	if (ret) {
+	if (IS_ERR(rescuer->task)) {
 		kfree(rescuer);
-		return ret;
+		return PTR_ERR(rescuer->task);
 	}
 
 	wq->rescuer = rescuer;
-- 
2.16.4

