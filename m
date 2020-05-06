Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09251C690B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 08:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgEFGh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 02:37:56 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:23620 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEFGhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:37:55 -0400
X-Greylist: delayed 952 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2020 02:37:55 EDT
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 3D49CA4B28D30C576311;
        Wed,  6 May 2020 14:21:18 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 0466LBfx051075;
        Wed, 6 May 2020 14:21:11 +0800 (GMT-8)
        (envelope-from tan.hu@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020050614213042-3469837 ;
          Wed, 6 May 2020 14:21:30 +0800 
From:   Tan Hu <tan.hu@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Tan Hu <tan.hu@zte.com.cn>
Subject: [PATCH] lib/flex_proportions.c: aging counts when fraction smaller than max_frac/FPROP_FRAC_BASE
Date:   Wed, 6 May 2020 14:21:28 +0800
Message-Id: <1588746088-38605-1-git-send-email-tan.hu@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-05-06 14:21:30,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-05-06 14:21:14,
        Serialize complete at 2020-05-06 14:21:14
X-MAIL: mse-fl2.zte.com.cn 0466LBfx051075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the given type has fraction smaller than max_frac/FPROP_FRAC_BASE,
__fprop_inc_percpu_max should follow the design formula and aging
fraction too.

Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
---
 lib/flex_proportions.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 7852bfff5..451543937 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -266,8 +266,7 @@ void __fprop_inc_percpu_max(struct fprop_global *p,
 		if (numerator >
 		    (((u64)denominator) * max_frac) >> FPROP_FRAC_SHIFT)
 			return;
-	} else
-		fprop_reflect_period_percpu(p, pl);
-	percpu_counter_add_batch(&pl->events, 1, PROP_BATCH);
-	percpu_counter_add(&p->events, 1);
+	}
+
+	__fprop_inc_percpu(p, pl);
 }
-- 
2.19.1

