Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64062969FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375494AbgJWG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373558AbgJWG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:58:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A462C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:58:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h6so482659pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWEgyRKyuD8Al2J5jv/DfuVXBHrVMDS7b+Ko3pQcdGs=;
        b=t3YqLDMe682M0O+O/QgLfaOkTW0bWUdMZZAkWQsRi9mAcQOOgztU1eepQDVe6eN6+c
         i7ZQLp+qYPBr01UClq0A/vSRkWEQXx6AjerYLDkcM2n+4yJgzWmy2VZhAHYwQcGveVVs
         gsfmQVko7SK0rSZ4rGdhc91MkQApNNhGSHzqahXFFKAiIU5MY4TYh0vpeQJobPY54KQH
         QPaVx7oH2wFPZMXm+jd0R8ucYTgJLqjgsG1rb56JGZ8cR4FFaV0ap0NRmeDU2URP8pMg
         3nEslED9SY+66lLO+NrO0FykbBiVXQ+JdqSNXqlWfsco28QWsi2thHLNCAQ84I5jnTHh
         cA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWEgyRKyuD8Al2J5jv/DfuVXBHrVMDS7b+Ko3pQcdGs=;
        b=C071J28cgwPHn0h3isyWcN335yIKzLTTEvkGyxxyIo/PR1yuKYDCwMieLVOQbflb6w
         hdOjwxP1FY50kJtRZutMsiD4aT382x11dsvGuqdeq3p7ukQuTGJAFe7IBWyYYFpC9Z7L
         S+gUDSYXxNqAZmGtNiHx1016pQsUa0KzOLDiPE6RLvv68TD+CkRlz3IWNZzgl9USdmnN
         z+InMkrWIcAmmZPneu+fLlWr4gQmiqhskkv4MYop0/0FIXMSQZEgKGg2n/N4i0AT9eA5
         pmFekXzY3lbaxfTO1SWTHRr/ApYGM9kcmlEFuRFpyDcGrChamnKxWxerxQJNCJBfiN2G
         y8gw==
X-Gm-Message-State: AOAM533wRMYef/Ww2bdV8Lkd1mCZtvUsQIr6pzXYW1NqyTqFZFwm2iQ5
        JLI0SVH+3DgSNw1Un7F/p1E=
X-Google-Smtp-Source: ABdhPJzGH/VcBiNeWPzvAkx/7KesWs5DP4LvuuoZQpRs/aVMBQbd5nQP3BzBSXC/64qM1M+ps7NtKg==
X-Received: by 2002:a17:90a:bc91:: with SMTP id x17mr877039pjr.113.1603436286598;
        Thu, 22 Oct 2020 23:58:06 -0700 (PDT)
Received: from nick-Blade-Stealth.lan ([2600:1700:6d11:6f:140b:65b9:cfba:15d7])
        by smtp.googlemail.com with ESMTPSA id v199sm875573pfc.149.2020.10.22.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 23:58:05 -0700 (PDT)
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bdi: fix -Wformat-security
Date:   Thu, 22 Oct 2020 23:57:54 -0700
Message-Id: <20201023065754.83084-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/backing-dev.c:810:57: warning: format string is not a string literal
(potentially insecure) [-Wformat-security]
dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
                                                       ^~~~~~~~~~~~~

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
Example patch showing off kernel development from a newly created twitch
stream! Check it out at: https://twitch.tv/ndesaulniers.

 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 408d5051d05b..5755578d671d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -807,7 +807,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 		return 0;
 
 	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
-	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
+	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, "%s", bdi->dev_name);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-- 
2.25.1

