Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA52B1681
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgKMHdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKMHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:33:45 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0755C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:33:35 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y22so4160943plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QvQ428TJx+KV17p9c5/mcXZnocTLEPy4VRjPQYxd+7A=;
        b=sK8EHjrrFkG766nxBzkfKyXLUMUGCZMvQsUO+k7dxJoVttYEhGrsNLFX0jjaIECL89
         bZN0CL/GOHMF5N7x08l8dVc0gq5tSwWr7Nm7eP0V5TPE0wKdlnN9TBsdjWC04VqbaWan
         WyYvJZiS7OCeppr73KWyzafRNkBUYQSHkLCVl7T/fxrujevw4Qr25Vw2JtICs9uumhkq
         KaY8oWozkcn+x/KHyGFV9HXSla5hCtsrG9Pu9SEYhIvMb5iXtnAK8lB9SHIS65qSZZXO
         mtbsl45rddxeKoa4s9CAQygUvPd/rCP7xvjcZRwDOwjFTtCIgVvUspXO4GtnnJ8iRchM
         3etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QvQ428TJx+KV17p9c5/mcXZnocTLEPy4VRjPQYxd+7A=;
        b=FQKRf7+zBo8kWYnyx7mrygkkloN27R4u8D9p6cWji+JtEJkguFtm2r/YcmYXodSfP+
         mW00fKnDP9uOVa98sTpqXuRh1NOrDeEXJy6XFLUGfuxighpXV1TJhurMbE1RBuslaCLr
         d3H3ATF56VSBbZchxj/jsJDi2SOlBv2Rj3cZ9IBglk9rrUVB0mR12F4COPT99/J/lnFO
         ShIAGsc2mIc806sl1IO4aGX/xHFaxLvewX7eNd/6TD6sp1avP6l8dkzPIGmH0F8qOhv0
         UKbsu2JeuQat/BwhvPS9DPtu4fsseDmw5u8MkDErDtzUhxjf7KPJdyTV67n0zBAwAUfx
         uAYA==
X-Gm-Message-State: AOAM5336mXXzihOinEyPNo/CFMLlqFfdx071NsksSpbLPjcaNRyxQMrs
        DYCRGSh0Daav9xBaXAc6wg==
X-Google-Smtp-Source: ABdhPJzBYoRJXA8e6EjLEIO4xfTux6bk38StKI5ulb0WYlPXTMG6IFSHyXECVaAW/NVo1EmXu/Kxjg==
X-Received: by 2002:a17:902:7c14:b029:d4:d894:7eed with SMTP id x20-20020a1709027c14b02900d4d8947eedmr898510pll.81.1605252815233;
        Thu, 12 Nov 2020 23:33:35 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id t9sm9590577pjo.4.2020.11.12.23.33.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 23:33:34 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] tracing: remove the unused value assignment in test_create_synth_event
Date:   Fri, 13 Nov 2020 15:33:30 +0800
Message-Id: <1605252810-4669-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of variable ret is overwritten on the delete branch in the
test_create_synth_event(), so here the value assignment is useless.
Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 kernel/trace/synth_event_gen_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index edd912cd14aa..c76b4c189560 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -276,10 +276,8 @@ static int __init test_create_synth_event(void)
 	 */
 	create_synth_test = trace_get_event_file(NULL, "synthetic",
 						 "create_synth_test");
-	if (IS_ERR(create_synth_test)) {
-		ret = PTR_ERR(create_synth_test);
+	if (IS_ERR(create_synth_test))
 		goto delete;
-	}
 
 	/* Enable the event or you won't see anything */
 	ret = trace_array_set_clr_event(create_synth_test->tr,
-- 
2.20.0

