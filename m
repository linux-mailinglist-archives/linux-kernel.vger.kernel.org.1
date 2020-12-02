Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747842CBCE5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgLBMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLBMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:23:37 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:22:46 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g18so998941pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBSywCOSwE0u0i2hisJMUH3EnPlBCbjRBeAjFq6FlSk=;
        b=jaLLiSN2Prb75EHksD9UE9ZJZ1twfIt1QSGvWbruEz/LzTYkBri8Qnu1qf0l8LqAOS
         F4wX0+OyBVpUGWIwmZaoNywEwnBa/RYgND8/ItXf/8iJjx/BFCnGCDXwaUg88rUgwtZQ
         nLMSaFiRE7LJ9afvn+C+QDiuRCOJKnNlWlQGNAu3Ca1gJ7UpW52G13z9M8aq1798gdJ4
         ab28XWJN+SdBEJ95dBiRA9C4DQPpYIyn7e1p3p8QOwleh85ecl8h6irehQFMHucp4st1
         efh/BHKX/o3FtBTc3/AVccEifC2iBp5cDuBFy96KFp7zeDEgFssTQvyLT5GCSiZDP1ZK
         8pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBSywCOSwE0u0i2hisJMUH3EnPlBCbjRBeAjFq6FlSk=;
        b=O1dOzUC4aoKw9NvJkTgj+GpCeYAkPX08tBgn+llM78/FR23NmhtLhMPHRtcUT8F+Ow
         1ADXdY1att8CkGJo5AdA9cOBdIPgb6I/us/QuMXLR2dDwpjEc2tvaLCwPhrOCg8S6aYw
         1QAledbbr88IGNjPg9cdA86WSbsEfAXLq8Xl53DySRPNqyhPdokqvdBSykYiKsw+8DpB
         snOopLgwg/IZJzo5+hfnYexW5lU2EFj7LNqGJMouneOBXTbVvTjxGkGOyGeAFYhS6+1c
         kiNM1gHhLrdDBvQcPu79d5BJruQ7EUhDlUX5lM+DKPMNYFu/hHqJAam/qyuaogXCNRQj
         wptw==
X-Gm-Message-State: AOAM532MGb/ut+MMjGYUAhjvczXxaTGJsCUY6zNymEXcKDSHF3D4/ORy
        Y9pLfYQTwG0dvylGl4PXR4H/E6/wG9gW5RVj
X-Google-Smtp-Source: ABdhPJyUiTRhALAE2WFBe6YkdtiHfcSQxgDvycnw0vOE/v+EZMdbo5MEv2TOTRkAp1rkiZs7NHARCQ==
X-Received: by 2002:a63:4283:: with SMTP id p125mr2415639pga.26.1606911766038;
        Wed, 02 Dec 2020 04:22:46 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id q14sm2338663pfl.163.2020.12.02.04.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 04:22:45 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/page_isolation: do not isolate the max order page
Date:   Wed,  2 Dec 2020 20:21:14 +0800
Message-Id: <20201202122114.75316-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max order page has no buddy page and never merge to other order.
So isolating and then freeing it is pointless.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index a254e1f370a3..bddf788f45bf 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -88,7 +88,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 	 */
 	if (PageBuddy(page)) {
 		order = buddy_order(page);
-		if (order >= pageblock_order) {
+		if (order >= pageblock_order && order < MAX_ORDER - 1) {
 			pfn = page_to_pfn(page);
 			buddy_pfn = __find_buddy_pfn(pfn, order);
 			buddy = page + (buddy_pfn - pfn);
-- 
2.11.0

