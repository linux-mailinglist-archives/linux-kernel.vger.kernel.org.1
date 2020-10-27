Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1B229A611
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508675AbgJ0IDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:03:34 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51549 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508651AbgJ0IDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:03:25 -0400
Received: by mail-pj1-f65.google.com with SMTP id a17so366170pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkKyxTwl8ekG841RoN58bB0vzsrEHZTiUbsxmBIxH0Y=;
        b=J7QFPcYyl+Rudib/U00XRzim7IuwfNQtPAZP0xb+Mv5iSY4+XHq5yo6c5JpkrTzH+x
         zMqLgUYoRMW6RLuijAzEUXPiwdUAv0OlP018X16jtfAE4iCBozAlIGusVJ379BvQF4ex
         euMiQdjzZbooFeBqwPBtKiAAMXvQMYa2laliQtiAMGa7S2aFAmb0VdDszsuq2FBeQIrn
         6sGs6A7g90DTQsM0B1cOt3EBBB544p5q7HmT5QI3C7xvTdM987JLsiQjWQblfV4fCci2
         1R7xoknLsUCfNO9cESLng0m+PikAlEnM8DcLgi/D28YoWPYN5FGqJexP7SZNeepLSpx9
         bcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkKyxTwl8ekG841RoN58bB0vzsrEHZTiUbsxmBIxH0Y=;
        b=jk7mCRttBT1ePmQQGVYGLAPh9Qq2pNGwh9JHGS/XjtrZ6RCaonaGGHfBhuEHQV1ddC
         Z2accTG9nBOD+PQ1jTyA52UXyQteZcnGDxH5Oef8MYjUJrhwjCs3bn45y18f2ybj10c/
         KmfLlwrx/Kpd4F+BGta0/v4SspVtFu6fNrBcTEU9tcUwvW8A9G9HHHnoBn2MobLPp08A
         LvXkZmXMTCJasc3pcPSXlA4CQzruD/jZHBwJoMIcoHrAUvsIQozhatZ6wvIixotZGnhT
         eDhlrQARtLIVyu6Gy1E14Cj9HXsq50nwAD+Ynlria920FipT9lsBZ2zD0Bu94cNTEhIo
         33Iw==
X-Gm-Message-State: AOAM5338qTAc6UU4HnoLsGOgdswXsT6pjL5N3BONGW7IeuJJyDyx2Fr4
        Vz2znJe3wupfABkBgDQYsuz5NA==
X-Google-Smtp-Source: ABdhPJykmbE8wdjYC2X2wAsrBvfaEdwwrwqA0TK0rjcGxYjqEk01eqrw7luf4X70zO+qxkB7CaqFXg==
X-Received: by 2002:a17:902:468:b029:d5:ad3c:cf52 with SMTP id 95-20020a1709020468b02900d5ad3ccf52mr1397871ple.7.1603785801285;
        Tue, 27 Oct 2020 01:03:21 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id p8sm1039580pgs.34.2020.10.27.01.03.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:03:20 -0700 (PDT)
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
Subject: [PATCH 1/5] mm: memcg/slab: Fix return child memcg objcg for root memcg
Date:   Tue, 27 Oct 2020 16:02:52 +0800
Message-Id: <20201027080256.76497-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201027080256.76497-1-songmuchun@bytedance.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following memcg hierarchy.

                    root
                   /    \
                  A      B

If we get the objcg of memcg A failed, the get_obj_cgroup_from_current
can return the wrong objcg for the root memcg.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1337775b04f3..fcbd79c5023e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2945,7 +2945,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
-	struct obj_cgroup *objcg = NULL;
+	struct obj_cgroup *objcg;
 	struct mem_cgroup *memcg;
 
 	if (memcg_kmem_bypass())
@@ -2964,6 +2964,9 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 	}
 	rcu_read_unlock();
 
+	if (memcg == root_mem_cgroup)
+		return NULL;
+
 	return objcg;
 }
 
-- 
2.20.1

