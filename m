Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E629D786
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbgJ1WZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732785AbgJ1WY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:24:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDB2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:24:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x13so625538pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gP9leRSqd8Nt5uw/ZcHLxalg6StnlmANhYwqDz5BamY=;
        b=GnFZV28/BNLRDucvzLESFv3OK7W6Iffx80nxt4gJX1KhQieE7APUfRH855/sp8RpMp
         cgkPejLvI+G6njV9mAmeo8VpZR4SfRadMjAssX2yRNc0iM3vyKnAhArixSQD58RO3L72
         Z0dOyUvEwxRX46FND2HUmFnhDDWdGNDCh5D+vNMyuk0wOXQ0ey1QMESV6UzxiDxR0yMU
         I/NSyZH3V7OUkd/ZNH6L5ToixcPb8J95qJPY7X1JOPEGvzroGJRZk1n/vBLocJO8sU4I
         fcnSEqdRLC/8x96lYmo1J1CBnTvGU14rV/VVdMwwMHdnccSu1XPj2SlK3p3yIP7wc1RY
         4KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gP9leRSqd8Nt5uw/ZcHLxalg6StnlmANhYwqDz5BamY=;
        b=lULs5rqNqXeZQUpQUcee+KRRqBuL8V7umNlGZ4eeonUfJGS4m092VmPtLLSgYhW+xx
         RuW48AccsYNy4bou3775hR1ZQAPFgQMryvY4R+hFqiEjFUfEXCeAZR8krE2ejRTMGxYo
         kQ+UVLkquyjgcRyr13X4k/mB5/5pHTm32DzxVvtrVNOl7HsnVNdk9xYmBsrYnMcCdJiO
         MHNEvFDEEKWR/os2RzR0LKFacPETZ8++Ub75yXlig7Yop+Gw3puAnxz35NQfM9JiW08e
         qcCtsIiuN1qhJY5ZYI++Dz7SEMILuvO9r8TXyqnVwo02581C0AzLqLHFe9v2hcaWa0bc
         4aLQ==
X-Gm-Message-State: AOAM532KhowI+V2uvNXtkOwTfwH617P50pyfi7BmiILxj5fYN0Hvr0oX
        zhV1lSeY/VzRjnRQLfVuWjlBDKUghenzGHK9
X-Google-Smtp-Source: ABdhPJzaRhN3aDdXWQ0D5XcrckptuF92X7FGcRacXma9zoZkUg7BhB9XvJmIZJEeUtmL/cOvXiejSQ==
X-Received: by 2002:a63:4c19:: with SMTP id z25mr4603006pga.58.1603857050037;
        Tue, 27 Oct 2020 20:50:50 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id s8sm3412273pjn.46.2020.10.27.20.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 20:50:49 -0700 (PDT)
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
Subject: [PATCH v2] mm: memcg/slab: Fix return child memcg objcg for root memcg
Date:   Wed, 28 Oct 2020 11:50:10 +0800
Message-Id: <20201028035013.99711-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
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
 changelog in v2:
 1. Do not use a comparison with the root_mem_cgroup

 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1337775b04f3..8c8b4c3ed5a0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 		objcg = rcu_dereference(memcg->objcg);
 		if (objcg && obj_cgroup_tryget(objcg))
 			break;
+		objcg = NULL;
 	}
 	rcu_read_unlock();
 
-- 
2.20.1

