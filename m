Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961952EF37F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbhAHNxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbhAHNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:53:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8493FC0612F8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 05:52:36 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 30so7704580pgr.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N80gZSJtD3sqRIKTg0+kuHqupK03C+4GqJPUMKGxVjo=;
        b=RjwwxxG9RdsovLTHrqvuicORcNaP2zRywzjXwm0T+Y+HV+uiIBdz7BoPUptz6Agvkv
         Zz9zkKx0LnoYw4pSfcY5DJymuoSxKL6aWqjllMuR37m0g8YIXPiK9jb3SsbDyohIK9Jg
         GIhbI0KUxy+fGwAmA62WHgW7lu5ygXM44s5PNMWHEbIyKAEQEVn1oiDM4q1Q7amXaZha
         v2Kz/HeM8X0GlfTUXvMFd+pAe540+LtDg3lsFFAko5g19bT6TImZuHadkKiwqS06UTvc
         TZP8p9aRye7ADNEwnj9aaj9DZiVvuSJvMiQ7lKp+dQG2bGm0e/hMdDeF8n48yEmJdZ73
         WoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N80gZSJtD3sqRIKTg0+kuHqupK03C+4GqJPUMKGxVjo=;
        b=FQLOvsB9/9mXrSxsIZvP2rew9UBRXYZQNucm6ibQfITlJDg4dVD4sFpcXxvbsGTJa+
         QtwCjX56C9wL9L63sE4qfgdGHdhWJK0ewwalV/jTknDBIC3iEADdJW/JbZf/JoMsVXdz
         dXgWQIylNEg753RAHFW2+Cu3gJOwSsHeK7ht+GNlfWvyAGTIb/0l330t0HHgNJiwHXCL
         TVlWdNyScPEoYNxyVlr2TMrhH8M/y+OTAeu/Ium6Q/1hLuoztjgSvatrokKfsIqNxvBf
         QR5JO7qWzaZNyASO3jLNIhx7hvdMISqg8epZ6ZsdlHA2EXilzhQ86PhAJEZyhIFTSTlE
         zhoQ==
X-Gm-Message-State: AOAM530pAD3/QXuYIjdNoO5PzAi18UHTmU59IbhQHbnZtmqLSOSwc2cS
        oXdM4aXND4TFm5Y59gOSRAl1og==
X-Google-Smtp-Source: ABdhPJwPMpwFfv9We2pWiH5vl2GZqYcxbmkp7GhhGclLrujLse7jwrz7ilEjL3gqatP5ymUO/o2JeQ==
X-Received: by 2002:a65:608e:: with SMTP id t14mr7135630pgu.436.1610113956080;
        Fri, 08 Jan 2021 05:52:36 -0800 (PST)
Received: from always-libai.bytedance.net ([153.254.110.96])
        by smtp.gmail.com with ESMTPSA id k64sm9401184pfd.75.2021.01.08.05.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:52:35 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v3 2/2] misc: pvpanic: introduce module parameter 'events'
Date:   Fri,  8 Jan 2021 21:52:23 +0800
Message-Id: <20210108135223.2924507-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108135223.2924507-1-pizhenwei@bytedance.com>
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested by Paolo, add a module parameter that can be used to limit
which capabilities the driver uses.

Finally, the pvpanic guest driver works by the limitation of both
device capability and user setting.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/misc/pvpanic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index e1023c7b8fb0..417f1086e764 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -19,6 +19,10 @@
 #include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
+static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+module_param(events, uint, 0644);
+MODULE_PARM_DESC(events, "set event limitation of pvpanic device");
+
 static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
 
 static ssize_t capability_show(struct device *dev,
@@ -48,7 +52,7 @@ MODULE_LICENSE("GPL");
 static void
 pvpanic_send_event(unsigned int event)
 {
-	if (event & capability)
+	if (event & capability & events)
 		iowrite8(event, base);
 }
 
-- 
2.25.1

