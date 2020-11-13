Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D862B1E78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgKMPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgKMPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:21:29 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:21:28 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id j19so517891pgg.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hRq5gupgdZ9QFzQ7R7Gj9jMw4zXfd000qEqyyyCrYMI=;
        b=RRAIf7Dc402cOQVjpfcmIsVhu6ikjT2PBEc4QjcTlrIfpV+DZtlEasPMzO8P7kfO1x
         TcLpEtiWd9PSwjDCna5EV2jXFRX1txa+8YU6K0X++rQ6CMAqwXmnwvecSC49XN0shANJ
         4sEezWOHrFR1DdLfwrjc+u5PTI7g54o9XIToz1YBln9zeTac4uOTjjRT972odKOU7xjH
         6vswg+fP25TGpUwfwIMrIAyAwwd2UQpIA1FoHfTjrmhuWlvWbYPRAQcIgeO0zBFOei47
         FJH7IuocxxZu+9QfQIWoTownpoiOjq2WHt4lR9jPU/zfIi06mX/2TraWxgTqi+gNeCms
         YpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hRq5gupgdZ9QFzQ7R7Gj9jMw4zXfd000qEqyyyCrYMI=;
        b=qriDrxWKPbpX3B42HWbSzB1B2OTwErZqxGCjCuCPQea5tNZDhojWnbo7Y7Jp7k1NVx
         w7Fry/bq7Rlkvg6MIE+dq9Uiwdb9IGVg6wrvZ2Le+UCyojyMBJwOcmZyPZqzbO4z3aVr
         Vp+ozPvHw4TUBY8udaxrUeNWP8+0wS6mrVbaTD4q2dH0A6bwE+xWJZMk6xAkYsYwl9X1
         /Mbxo684Iq8Oz1LA3qBrqtNKTtYdKeIysDlfOj3pP9uv9r+sCpIU35rdMIatQt3GAJxl
         vOE0pPECH7X5OhWtLsc6VeBn9bIovp66Wgb/Js9nxolMAk8B086PTwHWJKCXTLtvbxwK
         usEg==
X-Gm-Message-State: AOAM530Bm6KsJo/xZsdG5+n0uwb7KSFceOkk/RhR2pAP/xuxsD5o2g25
        C2c7F84n3zp2ddfbWPolSw==
X-Google-Smtp-Source: ABdhPJwMInQ4bmHkOc4AUo23Fg63tCg1OzmBaPEfYVqQS1wnqy3iBsty4bydI8c/N/RAqjHU8tfFFw==
X-Received: by 2002:a17:90b:1011:: with SMTP id gm17mr3409202pjb.73.1605280883746;
        Fri, 13 Nov 2020 07:21:23 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id h5sm9786615pfn.12.2020.11.13.07.21.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:21:23 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] tracing: remove the useless value assignment in test_create_synth_event
Date:   Fri, 13 Nov 2020 23:21:18 +0800
Message-Id: <1605280878-6612-1-git-send-email-kaixuxia@tencent.com>
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

