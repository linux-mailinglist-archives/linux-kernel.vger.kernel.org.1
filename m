Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFAC230BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgG1NxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 09:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbgG1NxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:53:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F9C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:53:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l23so18700871qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EtW0ADoRwQtOsaGG7oJlooe3S87y53RN1USDHS3OX1k=;
        b=n1QWWvhgXYfYFQhyOqcZpff1NCZlRpZRU+M57YX8VkjXTtd3GqfnDkYU0Ml146ZUTZ
         EMUF3jGXqq0ZC+jlxfvAVMjoHJNWyaygZPYp4hXRevNGlGHVvpyCD8PlVbquWCb5nH4w
         UzI+8KI2BOpWhsINM70UMwN4agULCxVCtHtZj8ZAUgZk2Mz6MbJ3wids2nV60eUD5OT2
         G5sgsBxiIAMoMM42EOEJipYA/duIJUeWlfrsrEeW+/D40GXy1ycVavy2AIRGeLsLtIh6
         AUs2Y7iVWX1FTqBsZUxSi2UE2j1cv4OU9emJT+b4CA49q6ooCVZ3b/20TcvF6D0xPnw0
         Q+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EtW0ADoRwQtOsaGG7oJlooe3S87y53RN1USDHS3OX1k=;
        b=n+wdYD+Q5X8jnKTA4ZL/rlFDg99GThSWkF1Dq+oUagrnG9gFbEPQT5tzWiKnMh1lH1
         A+s+9JVhqYYJKdC9sg8mlUmPMBwJ9IsrZLcVEgAshxUHFZCMOAK/Yyy2FVepgRnKF6fD
         IVkh7muAx/eJY97M3XUFW8JLe52FsUfi8TJRSqDezF09knSutA0YMPbukNDcNa0YlEk6
         4AO/KWU+wnPOkokj/ktcOF+y+sDJzuHGwSAAFIpGxVVp8h3nO9UGFRPAEOHZbMwjHe+M
         Cb51qjeNI0tmI/J9+ZUQRQGYdczboz4rbyWTWUnFuA4nB0vvM584CRStPUM5aZlrWbNs
         XsZw==
X-Gm-Message-State: AOAM530BcK1IRZCqukHamNRk5cD8mqlq8OY5V3OKcPoj2JclJCVk9pGU
        7eX3Q/tD9Hddh2FqDoyjGpC5VQ==
X-Google-Smtp-Source: ABdhPJxZsi0XICMqQarFdnuS1OZe7mHQHY0H8FNy5g+HSZY1D4xOeR6LwKFX9mCFezvWZybWBLoj9w==
X-Received: by 2002:a05:620a:132d:: with SMTP id p13mr8925316qkj.161.1595944391174;
        Tue, 28 Jul 2020 06:53:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:53c1])
        by smtp.gmail.com with ESMTPSA id g24sm19970608qta.27.2020.07.28.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 06:53:10 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: memcontrol: restore proper dirty throttling when memory.high changes
Date:   Tue, 28 Jul 2020 09:52:09 -0400
Message-Id: <20200728135210.379885-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c8c383c04f6 ("mm: memcontrol: try harder to set a new
memory.high") inadvertently removed a callback to recalculate the
writeback cache size in light of a newly configured memory.high limit.

Without letting the writeback cache know about a potentially heavily
reduced limit, it may permit too many dirty pages, which can cause
unnecessary reclaim latencies or even avoidable OOM situations.

This was spotted while reading the code, it hasn't knowingly caused
any problems in practice so far.

Fixes: 8c8c383c04f6 ("mm: memcontrol: try harder to set a new memory.high")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 13f559af1ab6..805a44bf948c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6071,6 +6071,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 			break;
 	}
 
+	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
 }
 
-- 
2.27.0

