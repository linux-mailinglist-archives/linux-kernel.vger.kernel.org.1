Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8A2F0CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 07:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbhAKGC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 01:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKGC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 01:02:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB2C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 22:02:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y8so8935510plp.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 22:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/AoJk0of7L6YqGciHe1xUy+pPj4pfPePXIjX/yt0mA=;
        b=s0qnhNHtdUgphP5LnXk4cqvt5+nwvrW4vJSLwFj9H+tWTbDG1X+BFFo/wAGmKDthzk
         GLIxkOA4PZHr2wpzekt2pU0eDvI71ruTdsZJ6Kfv7H+fKhmAF5yf9YZ54ooeAUqug9dg
         19XNT/UVbTKDAY3v/YHXU2H6f1HK1xNADTKLTMstXBGVjlokWQ/AmwPSUdEWh1dIxwvw
         tNjgMQ/VfmnqEnnm/rnFUffcKLWtd+MoXLQWBdd35ly3R2BqyOqnwMVG6rqppRiVECXn
         uuXEGd2v2bJyX1XCith6DxTYXTv1hbZaxqJq1eLoQI5B6yhg9q7bJwaGjqdXiKRlNDaQ
         wvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/AoJk0of7L6YqGciHe1xUy+pPj4pfPePXIjX/yt0mA=;
        b=hCq6SBpE7asrsxCIMU1UDvbehpZD3rQqmeEaJHGxSNlFymyyHpflcNrfs+4vji7sIy
         NTm2IDgF4FjBAaILM1Yxj3yVq8Hb9LtFcCmPLcugIENLD4MFlQ6O7FiMtBl1CPms8EWq
         ks43ZIypvWbGEetgl8Ve1v73cJmWuZuPIJeFMGqhGbhh3IrgQCTr4HsWZn7FqcrvX7oc
         wOR5ViQCDWuc0hxG1dUt9KoL2XVtdsxr6t0rfvoGgj/5TVEhqAc5o32UbXsWl2/1wzyo
         4xnEemlwKMwD422FFp92UHujeOvENBIJxq2lq+74pWLCnopfDYl9IJWjnZHJbmP2/mto
         x/tg==
X-Gm-Message-State: AOAM533fkagI4CZ8hHNyBBPM7gFFbOmiUzgbW4e5LdWqmrDPtTWxJIo2
        wu73EOYuEwGcLr+9aer0Kn+RmQ==
X-Google-Smtp-Source: ABdhPJwvdPJrFFOsuFWXU5qTgjG7JOhiD34cuMXbgV7xOts22tPL3BNTWY/6N+o0y1Cr/CyZPyhjaQ==
X-Received: by 2002:a17:902:9e18:b029:dc:50ed:8ef2 with SMTP id d24-20020a1709029e18b02900dc50ed8ef2mr15233275plq.64.1610344936298;
        Sun, 10 Jan 2021 22:02:16 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id b6sm17389569pfd.43.2021.01.10.22.02.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 22:02:15 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 resend] dcookies: Make dcookies depend on CONFIG_OPROFILE
Date:   Mon, 11 Jan 2021 11:07:49 +0530
Message-Id: <fd68dae71cbc1df1bd4f8705732f53e292be8859.1610343153.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dcookies stuff is used only with OPROFILE and there is no need to
build it if CONFIG_OPROFILE isn't enabled. Build it depending on
CONFIG_OPROFILE instead of CONFIG_PROFILING.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ Viresh: Update the name in #endif part ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 fs/Makefile              | 2 +-
 include/linux/dcookies.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 999d1a23f036..0e85d1ae20da 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -64,7 +64,7 @@ obj-$(CONFIG_SYSFS)		+= sysfs/
 obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-y				+= devpts/
 
-obj-$(CONFIG_PROFILING)		+= dcookies.o
+obj-$(CONFIG_OPROFILE)		+= dcookies.o
 obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
diff --git a/include/linux/dcookies.h b/include/linux/dcookies.h
index ddfdac20cad0..8617c1871398 100644
--- a/include/linux/dcookies.h
+++ b/include/linux/dcookies.h
@@ -11,7 +11,7 @@
 #define DCOOKIES_H
  
 
-#ifdef CONFIG_PROFILING
+#ifdef CONFIG_OPROFILE
  
 #include <linux/dcache.h>
 #include <linux/types.h>
@@ -64,6 +64,6 @@ static inline int get_dcookie(const struct path *path, unsigned long *cookie)
 	return -ENOSYS;
 }
 
-#endif /* CONFIG_PROFILING */
+#endif /* CONFIG_OPROFILE */
 
 #endif /* DCOOKIES_H */
-- 
2.25.0.rc1.19.g042ed3e048af

