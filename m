Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B64235389
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHARA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 13:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgHARA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:00:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C05C061756
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 10:00:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so9225897pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/D7/FfQ1Ltj6WdbQKk8TMQQCM7kUJkJu5n5ITi6p5M=;
        b=nf5shMCj4bShg5x+zZCskQiNzfZ8qyPQVISXNbW+Z6cbkXIP9xVOuriJUd6ZTjpwz7
         4pjDRJ7SQCxp+GKrTXzBzU+aNG847lbcH2xIQFmjcWiYSn1xr2Z3b9QZ7Y5XfUMBdOkZ
         qzp96SSI4Hb4TLl/fLISsP+MhwBkfWPlVjab5BGvJPvcMHd99c94g350g9ycpJfXm8wu
         i2XgkznV8yRgJyO5hwwzJUkQ/KvyX3Pi1dXDyJD3mULUSM9TlzXzgeMDobD696O5ESbT
         mJmtSF8SWt4NJb7RGm0VzKn5UcwZoOA89r92YMCBxpOrfxIg9dJKjSkBtdidUWoyUJ4r
         2BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/D7/FfQ1Ltj6WdbQKk8TMQQCM7kUJkJu5n5ITi6p5M=;
        b=Nrzkun+62FzkFyD9erljjQMqOIZs1ErjOhLNJPyNUbBVwkix75vzET/GdMyMACtVRs
         46lDGu/gz7Ba60NcDBuJrZm+36Vbb2POFX/o9q2ruM3/sxbcaXu1b/QK/r6p9onX8L1S
         ic676B4WvfMVppqIXPc9P9HrMIA+6vEAxqrn/3Rwl5UXohoEa6i2XtBnyMpBWr83Pf7x
         +f1wUFEc6p0sqvLwP5TPvD2nvi71IUlG0ETxGR/fC6PYCXF7oZY5u+30AMqM+LH6f0BE
         0/o3a5f1ALCWHBl4cLMHl73HPH4yMZktiReoUtc4eVyzMSkbiBHSxL+B7WMDgeHMBAke
         vr3A==
X-Gm-Message-State: AOAM5330YcuSNql1BSfNGOcOrOCF+BE71F7VHduQ0KoOS0U6hE/bNQs6
        HXQreSUMajcIewXoM8im2YEdHg==
X-Google-Smtp-Source: ABdhPJwkeDbDdvqxK60zxHTFCDdZrzmwAg7beOH7Dz2g4Ez5yrp+5y/zRbyQ6ZJJIuGMYltUsAyNsA==
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr9845766pjz.176.1596301227876;
        Sat, 01 Aug 2020 10:00:27 -0700 (PDT)
Received: from C02CV1DAMD6P.sso.bytedance.com ([103.136.220.71])
        by smtp.gmail.com with ESMTPSA id k42sm1274607pjb.52.2020.08.01.10.00.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Aug 2020 10:00:27 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] iocost: Only inc nr_shortages when have io waited
Date:   Sun,  2 Aug 2020 01:00:21 +0800
Message-Id: <20200801170021.76756-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last else branch of current code may have not io waited in iocg,
in which case we should not inc nr_shortages, or the device vrate
will speed up even this iocg is not shortage of vtime.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 86ba6fd254e1..ce68b5749364 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1485,7 +1485,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 				__propagate_active_weight(iocg, iocg->weight,
 							  new_inuse);
 			}
-		} else {
+		} else if (waitqueue_active(&iocg->waitq)) {
 			/* genuninely out of vtime */
 			nr_shortages++;
 		}
-- 
2.20.1

