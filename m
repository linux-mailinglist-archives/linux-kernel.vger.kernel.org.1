Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2998A2F0104
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 16:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAIP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 10:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAIP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 10:56:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF9CC06179F;
        Sat,  9 Jan 2021 07:55:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g185so11002882wmf.3;
        Sat, 09 Jan 2021 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8STdSgjj6xHtdroJXzvV/+CmMSDy9uhx89zUkl0AAc=;
        b=cRpXTD96vs3MdnSGTa27Xv+AIxUuYhFyOwWDj+WwNvnk5LCMe5AZDH4wYDrjaGiEce
         nxJFB/I+n3W5agVDHZ3Z7z0llGXn7E1ivl9RKFL9NWxkRvp6cd/LcXAMW4r3GfN7GnFG
         mh0fZucprQReiWQwrjbD1YjlPgCvEwn6w1i8iU3En2G5wE4P5FGXp0vvlaR/xRB97AfV
         t0wHCGemXlPjhadEJvIR9sFphP1SC/KcoMZAppNY3Z3MqXVG4wWBKBn61fmcK4LwRbtG
         TTkNNCLh7S9LOjhHHtuvmNrDguGebveLf24vJXTwlA1MfYnw4XDt/MNBFWEhi6GTshD5
         V6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8STdSgjj6xHtdroJXzvV/+CmMSDy9uhx89zUkl0AAc=;
        b=AVDdPZ5lQhNufgCwPp9chY9JT9xBJFHBEqRiKe1fwqWOoo+A85MO60YvnWwgUB8gXQ
         HpmbA/hMha1zfoNboGkKdnHMRecoberGdvle67HjQ5UIN4RY4hUOl8exTeh+t75fpDO2
         YLbjLt1DNTEMrpJMpEH8qOlYGa20DcQyOGs1kk70grY1D8OYYMNbc5mTueEutn0hBxM0
         SOMrZyxr/zTZKPlD96deRfJSnAd8/a0OH1Yuf9vEJn6QhctsxG3A0ZEOWSTCKKc9mwOI
         wpvy9/QNc8za+M9hGRDpMJTIozk0JVCl9DhcUODVWbm1my0/4i2ALxG2yeJF5NmbxWu5
         Eefw==
X-Gm-Message-State: AOAM533I0rFdheQwBwWRDYIcst/YPZgPNI7/2uE0tCt5mzPP0Fx7JjwK
        2G1BfwO91MTpBVonpQeR8rZOOy94INrPRw==
X-Google-Smtp-Source: ABdhPJwnH0NKNkhe/qju/0QkhNCh99e/OkwsfGdbhjqJQ0o+hdvBm1FFhRPa0L3J/GuUZ/hMuINf3g==
X-Received: by 2002:a1c:790f:: with SMTP id l15mr7798475wme.188.1610207718749;
        Sat, 09 Jan 2021 07:55:18 -0800 (PST)
Received: from localhost.localdomain ([185.69.144.125])
        by smtp.gmail.com with ESMTPSA id l8sm16605266wmf.35.2021.01.09.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 07:55:18 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] loop: devirtualise ki_complete call
Date:   Sat,  9 Jan 2021 15:51:38 +0000
Message-Id: <5e84ffb95a722c510674a319d9223a1add42ef14.1610207408.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lo_rw_aio() knows what iocb.ki_complete it set, so instead of an
expensive indirect call it can call lo_rw_aio_complete() directly.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e5ff328f0917..113d87f3b194 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -588,7 +588,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	kthread_associate_blkcg(NULL);
 
 	if (ret != -EIOCBQUEUED)
-		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
+		lo_rw_aio_complete(&cmd->iocb, ret, 0);
 	return 0;
 }
 
-- 
2.24.0

