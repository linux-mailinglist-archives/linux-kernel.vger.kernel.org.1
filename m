Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F8E29D373
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgJ1VoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgJ1VoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:05 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E8AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:44:05 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k27so1095842oij.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f42zNGuydbxsMprn7/o4rTiW5Mh/YrWQVTbGkrcpGAU=;
        b=JRG9qhqWVdv+qAPGEyd6hAeN94upYYLiFE/8ziCyK2IfmG0KH0vcgx4BU3gjZFhSCf
         OEaj1GD1WXVm1jmeXl1DAWeAzX9Lob3XEKoPsdIGbnDQ1EZlxhf90ONNi7wNxTQIRxa9
         JYfxxPzpE73/OCT2b00zuaCJtatE4mhFQZTM1zuzRudG7zsEUnH4gtecsO/0Msaf4j7w
         CHNZUDlEGkeM+dWh/h54KR874ZVAd/8idZH6gFDdGIdh0J1HKh15Z6JSbBjt3nBo17Ag
         izJQJtcjN0Ho2qCL3Miw31aUHdSVubCbCTwrcvEvzj7CbUF9eK85qoW+4YUKLq/JBNAg
         8XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f42zNGuydbxsMprn7/o4rTiW5Mh/YrWQVTbGkrcpGAU=;
        b=Jm5miAZl6YoFkViWmD+cAOtQwvi1lS65bnHlSOoh7dFsLNNTcfFTVTb5YdYDl8Oa8M
         McHbW0UBxD2skHocv3OQZbkw1fisQ1FgRfQ1K64j+zTGYOnPUwfJEcAWorJtAA7EAluM
         K6+wNUML9SWOzLr0519MMag3b9ikfyIEcSqL7LIJTtSL+0meSNdg7+r1egw32DJFnUdp
         y+6GZmoRLEhYSUjLYefqJ131uiJUuYwnzGVJFTea1/IOl94dp9FyGHKv7Qw4TdlIZ4RC
         wK8u/5E71BbOpuJNs90Yl09uEn4qM9ZVvbIG90YU0J3xFp7w0I/zfeuubsL/WX7AiC9S
         oyEQ==
X-Gm-Message-State: AOAM5310q63C0Q2+zghzGkO3y/wMSpV8m2lYT8epjJywaaROlhHnBeqo
        A8JadfypfSxeuiz9NBi9QFp5KdT0Ud4H5sJx
X-Google-Smtp-Source: ABdhPJyMlM5OFcaQWKTSVzpQLorRg0eUkIPGImJyauZgOd1B4JNiA5dI9gI84a4KFGgTpJ2ovwTXOA==
X-Received: by 2002:a17:90b:1392:: with SMTP id hr18mr4756699pjb.182.1603857057592;
        Tue, 27 Oct 2020 20:50:57 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id s8sm3412273pjn.46.2020.10.27.20.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:50:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        esyr@redhat.com, surenb@google.com, areber@redhat.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: memcg/slab: Fix use after free in obj_cgroup_charge
Date:   Wed, 28 Oct 2020 11:50:11 +0800
Message-Id: <20201028035013.99711-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201028035013.99711-1-songmuchun@bytedance.com>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_read_lock/unlock only can guarantee that the memcg will
not be freed, but it cannot guarantee the success of css_get to
memcg.

If the whole process of a cgroup offlining is completed between
reading a objcg->memcg pointer and bumping the css reference on
another CPU, and there are exactly 0 external references to this
memory cgroup (how we get to the obj_cgroup_charge() then?),
css_get() can change the ref counter from 0 back to 1.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 changelog in v2:
 1. Add unlikely and update the commit log suggested by Roman.

 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c8b4c3ed5a0..d9cdf899c6fc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3221,8 +3221,10 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 	 * independently later.
 	 */
 	rcu_read_lock();
+retry:
 	memcg = obj_cgroup_memcg(objcg);
-	css_get(&memcg->css);
+	if (unlikely(!css_tryget(&memcg->css)))
+		goto retry;
 	rcu_read_unlock();
 
 	nr_pages = size >> PAGE_SHIFT;
-- 
2.20.1

