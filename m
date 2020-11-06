Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD42A8F74
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgKFG3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFG3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:29:14 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE15C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 22:29:12 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so195802pls.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 22:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ttWMFPMQOjA7u/QHyTF932LbAZwRDjJ4PzdIhk8wiqM=;
        b=fTxSe/iSrOrAqHqfNjvXvlPO1SxsjeOCCF3JZjmFsTTwAA5+pjlWCuQM3vyRSpFjHL
         EGYIHANMC/kizflAv/e9zeUHAmbi2APa/oJnFIP29CmKETF4RNdF8/1TPOsWheEIaikg
         QcPOGf7IGM0drk2uleE289PvXQrmko9JjoSDAC2n3JOnmY8slr5Kg5nuCDyYUwikdwKC
         P+Kd7x+pJm1NzZLfbnjPowjMUbu2fHbTU/ls4o8c41H2e+yNpcYeLQbaefVaefkOWop4
         JwRhZ5O1HcsdSK+OoJQWvGuL4j2ZRuV9U8v7D5ImuKh1auy09kmYSF3aK7P6tJyrPg1h
         YxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ttWMFPMQOjA7u/QHyTF932LbAZwRDjJ4PzdIhk8wiqM=;
        b=HaCBonDhVDHTEllmwZEI7rDhCy7baiZvYN7qXLS+oa0fKpcG8oe1hYl5A/+lVYeZfe
         PfQnPBXu4ugHv3mP0+6ugfRIclE7vZHswH7p45XinXBjVh0XnJE2oTUam7JytfC2wBgA
         VVzOamPPzq9yuUm3O5zR9x1IbuNpnrLHluiHvgZuP0fLWg8jF1KBoDrtotgI2MMYyROx
         E55wOzIqFfK+KWBF/m6Lxq7IsePs+coN55Q5oWuIQ4sGTaMA3/AQB5Nm5VrmEeN0tzFt
         ZqLqHW9bCYNkj6Xp6XQpRUU/TBfSoyXRU/QqavMdwa7BuDRISiQvlXsRZIeR3E2dwaib
         NHzQ==
X-Gm-Message-State: AOAM530eky01zIUnI/HQug2mJiQz83oGRyY4ttdgigWN7uCpRVGC3FOR
        6R+m8+Xt4QPoBnPBul/rvg==
X-Google-Smtp-Source: ABdhPJw5/XQf16tPs9Sj1RqtYAUnQuz7ERmwvyrxdpeeL9gPESHETrBc9eXTcSwii7xXd+7xPzxKww==
X-Received: by 2002:a17:902:8c82:b029:d6:df6e:54ac with SMTP id t2-20020a1709028c82b02900d6df6e54acmr522725plo.29.1604644152462;
        Thu, 05 Nov 2020 22:29:12 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id s6sm486605pgo.8.2020.11.05.22.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 22:29:11 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] perf intel-bts: Use true,false for bool variable
Date:   Fri,  6 Nov 2020 14:29:06 +0800
Message-Id: <1604644146-598-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle reports:

./tools/perf/util/intel-bts.c:472:3-13: WARNING: Assignment of 0/1 to bool variable
./tools/perf/util/intel-bts.c:515:3-13: WARNING: Assignment of 0/1 to bool variable

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 tools/perf/util/intel-bts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index af1e78d76228..aa4fad92c79b 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -469,7 +469,7 @@ static int intel_bts_process_queue(struct intel_bts_queue *btsq, u64 *timestamp)
 
 	if (!buffer) {
 		if (!btsq->bts->sampling_mode)
-			btsq->done = 1;
+			btsq->done = true;
 		err = 1;
 		goto out_put;
 	}
@@ -512,7 +512,7 @@ static int intel_bts_process_queue(struct intel_bts_queue *btsq, u64 *timestamp)
 			*timestamp = btsq->buffer->reference;
 	} else {
 		if (!btsq->bts->sampling_mode)
-			btsq->done = 1;
+			btsq->done = true;
 	}
 out_put:
 	thread__put(thread);
-- 
2.20.0

