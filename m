Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7D2B1F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgKMQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgKMQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:02:53 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A8C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:02:53 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so7941584pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xKCKF8CdOdsYeVuRA+/C1nKU3t1+HQCbHBG+vyQ+EJ0=;
        b=Spd0kd8OYNy4igils98t1rBlE2qPIC+q58ZdTklFYFFLlPUyFmvGLPflQON+07YVbF
         6+9rTT03mHmMtr2Zrk6CeHfppU2Bn4zuOcyy4/NBijC5BWtSRG5dWn8Q4ED/bCqL379v
         jZo0GxItUjzDlDJXm5wu099y7Vf9fuFOJKKkFxK966ckX/x7xn+18a1bajO3Z2/bH0iS
         4KjSprn4vn7aV7JbsTl9Ztw50h6sGHky/qHy6VCmpuO4Aa7GFxM1wdpK52F3pMwTtUdz
         e35FrAt3QVwJ5bZHvjWAFiZbks5FsxIbPg0SnXzc24O1cbyWZ9zuHfeFH3TdFUJ74OoI
         yn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xKCKF8CdOdsYeVuRA+/C1nKU3t1+HQCbHBG+vyQ+EJ0=;
        b=P6dE/Q44gNQ/fjqmCuwjSQSSQDmLc4Hcrnq+sWLNmuSFrDIlGaZDESuaXi2j69n/Ua
         pTy9LMerlrTvoxb4jFFBsN25W8NHl6zSapbMjJ6p3uA7KCUjFNJ4V2+jjxfOtJATJjFN
         ehC7RuC+UsCP1dCMwBdXEslY5re/qANXWxX+ecM53cea6rci1tGJfYTvgVtbvANdGf3C
         EBx1622farnuYJgbY/JqiMq24UCkOsfyZvTc0s50sdJUHeYPxZarIXqH7RS4gfYnDygZ
         PL5SNXW0120RrisUx8RNdY8KIt2S9fFIyB8lAMPRR36Ba2nYITwv68dCp+/1/luyu7XJ
         DVYw==
X-Gm-Message-State: AOAM533cqaq9w+d/gJGDb4ydTPeu0zV4i7AINTtd/vberKvh/UBoSzGM
        lrtyDpUTit3zfVbYBtUisS4wfE3ItF+O
X-Google-Smtp-Source: ABdhPJwOl/FvIiJSSmPdfVegs7CLfWakn60pZmgGJ5Sydvo4QuW83dIDTFsHBGV5OePwwTp9BDxmZQ==
X-Received: by 2002:a62:e516:0:b029:156:3b35:9423 with SMTP id n22-20020a62e5160000b02901563b359423mr2596357pff.19.1605283368436;
        Fri, 13 Nov 2020 08:02:48 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id h9sm11625117pjs.26.2020.11.13.08.02.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 08:02:47 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] tracing: remove the useless value assignment in test_create_synth_event
Date:   Sat, 14 Nov 2020 00:02:40 +0800
Message-Id: <1605283360-6804-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of variable ret is overwritten on the delete branch in the
test_create_synth_event() and we care more about the above error than
this delete portion. Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
v2:
 -remove the useless assignment in the delete portion.

 kernel/trace/synth_event_gen_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index edd912cd14aa..a4b4bbf8c3bf 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -307,7 +307,7 @@ static int __init test_create_synth_event(void)
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
-	ret = synth_event_delete("create_synth_test");
+	synth_event_delete("create_synth_test");
 
 	goto out;
 }
-- 
2.20.0

