Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC564271BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIUHYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIUHYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:24:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so11438814wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z5w3E0XQlEXnlWZ+ijkSjUv112MRkj3fJBN/hk9++P8=;
        b=AZbgPuncnxXB75o4WbsfN939ARrzEsCKoffZtrVvEvZvEkUT96aNii8Bpu9X4YWdxP
         0bPewaTcXwZy38Jv+c7Eza4PsiEcoALd++4dHmC0nXC3/7JhdFEBW+3sLipdtFXKyZBq
         fZ1LG5dtSQQa5cJxeSO0rpwWKfUJXRC1Q5hHBznLEzS/otZOpLhiFwKDJPE7vbb5pz3w
         GZHwRay5e8fmQnykd6QBUZPfCqHkHgGb4OeJ9jxe0Rp6rBI78W3FlCmtDfeYe0FuHtHv
         oD/99ZoDDUDs+rv/4R4zASMyVdcTGejEMDiTLz3nEwNKrxb805hCbMcTZ0nYRrsM2AIV
         KVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z5w3E0XQlEXnlWZ+ijkSjUv112MRkj3fJBN/hk9++P8=;
        b=hUAbBmnQ81Z/Z8UPOcWEtqlxktCtGAjDvch0aD0396FsI/9Eqj9T3YA5gfHU9XHpqQ
         nGyFV9zwNaG7oD9t08+PjUn/7zh99LTJ1KDLYvsHcG8vxLJZYwGTwREh/3lFwhs6i15R
         62QU0GwxvSEkqiO/yAxeb/4PtPk+3dDhUQSKU2AXy+Io+slOrnl9Y1IDs2uAv//Bl7bA
         EJDpRJ4kHNzLYDT42jGbXgK3kHHP7ChV6LUztpHBgB3xf02iNqLXyhRVABXQci1eDH77
         U4qhb7D5w+MfSbjrAd7PzTLcxS00xapu5bejN+UG+LAzHGnGlAKQ3XDThNBxQGoeVZEE
         zVzw==
X-Gm-Message-State: AOAM532aB1mbumC/BHK1VwZHlTyh3NZY0rR2JaJa26nSCY/h6VMuw7BU
        Prp2Plo0sE8/EFezsz/PXMKP/w==
X-Google-Smtp-Source: ABdhPJxq9MuG6fRHCgsXC/knfxl1FvYPCvieG38KVOyI0RI+hvc/QF52/H34bEOo/XsmWgkDXBrI6A==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr30148506wmi.53.1600673076497;
        Mon, 21 Sep 2020 00:24:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:157d:a871:1ab2:f67c])
        by smtp.gmail.com with ESMTPSA id k6sm17888651wmi.1.2020.09.21.00.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:24:35 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, pauld@redhat.com, hdanton@sina.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/4 v2] sched/fair: reduce busy load balance interval
Date:   Mon, 21 Sep 2020 09:24:24 +0200
Message-Id: <20200921072424.14813-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921072424.14813-1-vincent.guittot@linaro.org>
References: <20200921072424.14813-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The busy_factor, which increases load balance interval when a cpu is busy,
is set to 32 by default. This value generates some huge LB interval on
large system like the THX2 made of 2 node x 28 cores x 4 threads.
For such system, the interval increases from 112ms to 3584ms at MC level.
And from 228ms to 7168ms at NUMA level.

Even on smaller system, a lower busy factor has shown improvement on the
fair distribution of the running time so let reduce it for all.

Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 41df62884cea..a3a2417fec54 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1348,7 +1348,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	*sd = (struct sched_domain){
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
-		.busy_factor		= 32,
+		.busy_factor		= 16,
 		.imbalance_pct		= 117,
 
 		.cache_nice_tries	= 0,
-- 
2.17.1

