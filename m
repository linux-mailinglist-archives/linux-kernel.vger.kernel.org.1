Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5227CD07
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbgI2MlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgI2LOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:14:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12323C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:14:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y17so5011273lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZ4P5eCNZlIGtDfFRqaX5188qIJ0Vd0GiDBdv3mnk2A=;
        b=CuDfLigkzrEE4BwFSYuMI1CE2TAXddfC2W4sMUVP2B78n8wvCD3c0UcaD2dtzvWr/X
         Z8/+8I5bhKS4pQHy6t3vEKFJ/x42hdPx4mQkwNgM4q5jVQZo9wh3ABeM706zzaRX9bKA
         zFLm5+BXNtjaBTFkC+mn7cM1eAu59isJ1zepfEX5F4x7JVc8R6GnvPXQTh6ILsK9hsv7
         oGZQOrqrs1IiPsdftd762nGKhPhC40X1SIJP00N3DEhCV0AJ+5b7W15fI5vAMk8mE1OY
         2JXDnxyzRSliB6jOpsnKamDB+jkjscry0cUEifAj+jtNGkdZEcNGlUIgvGpUFaoKjTwY
         bIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZ4P5eCNZlIGtDfFRqaX5188qIJ0Vd0GiDBdv3mnk2A=;
        b=GMdpN81gndJcO5zYV1XlKWRAxgzWPExC8LeBIM0b1PFVR5mRkbnDocP6Aqq3ZlNwUR
         ftLjUCRSyB03MtYqjFpWcRpr2tK3QiGDL0Sdzp2Toh7ixPNLIHu+zf6kfZxJngtV+kEK
         SeI8fDNI70B4JYyMnULdzvtv6Oo4BOZZoS8+npA6NOwbg4GohuDc2W+A92h+tG+VPhcs
         wruiiwzJFDkivbtUcgJwmMQ0JUOgGN6vxWhNB/PKSaZaq8SFyjtcKoTU0f28/Dp0i1ya
         31ZMtpVIAXD6HVWAitnvY3P6SdSsiHa+f4B2vC0tQyWzFWV9Nn/Zw8B+U/277BhLbUzh
         SfJQ==
X-Gm-Message-State: AOAM532+8EsinqTaMbajteTt9Dr4VMgrqTvyU+llr3t48R/x5u1cqHyw
        /sMo7tALCLaigZQG++HwA6Y=
X-Google-Smtp-Source: ABdhPJwbsr4KqP9lUr/SPd0wqLe4sfUt3aQq9LtrAq87Ab3XluvBzFUACLuvEsdnhnPUmq2oWiBA5g==
X-Received: by 2002:a19:be0b:: with SMTP id o11mr963382lff.117.1601378043293;
        Tue, 29 Sep 2020 04:14:03 -0700 (PDT)
Received: from localhost.localdomain ([149.255.130.5])
        by smtp.gmail.com with ESMTPSA id z7sm3199419lfb.221.2020.09.29.04.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 04:14:02 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     Roman Stratiienko <r.stratiienko@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        megous@megous.com
Subject: [PATCH] RFC: arm64: arch_timer: Fix timer inconsistency test for A64
Date:   Tue, 29 Sep 2020 14:13:47 +0300
Message-Id: <20200929111347.1967438-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes linux_kselftest:timers_inconsistency-check_arm_64

Test logs without the fix:
'''
binary returned non-zero. Exit code: 1, stderr: , stdout:
Consistent CLOCK_REALTIME
1601335525:467086804
1601335525:467087554
1601335525:467088345
1601335525:467089095
1601335525:467089887
1601335525:467090637
1601335525:467091429
1601335525:467092179
1601335525:467092929
1601335525:467093720
1601335525:467094470
1601335525:467095262
1601335525:467096012
1601335525:467096804
--------------------
1601335525:467097554
1601335525:467077012
--------------------
1601335525:467099095
1601335525:467099845
1601335525:467100637
1601335525:467101387
1601335525:467102179
1601335525:467102929
'''

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
CC: linux-sunxi@googlegroups.com
CC: megous@megous.com
---
 drivers/clocksource/arm_arch_timer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6c3e841801461..d50aa43cb654b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -346,16 +346,17 @@ static u64 notrace arm64_858921_read_cntvct_el0(void)
  * number of CPU cycles in 3 consecutive 24 MHz counter periods.
  */
 #define __sun50i_a64_read_reg(reg) ({					\
-	u64 _val;							\
+	u64 _val1, _val2;						\
 	int _retries = 150;						\
 									\
 	do {								\
-		_val = read_sysreg(reg);				\
+		_val1 = read_sysreg(reg);				\
+		_val2 = read_sysreg(reg);				\
 		_retries--;						\
-	} while (((_val + 1) & GENMASK(9, 0)) <= 1 && _retries);	\
+	} while (((_val2 - _val1) > 0x10) && _retries);			\
 									\
 	WARN_ON_ONCE(!_retries);					\
-	_val;								\
+	_val2;								\
 })
 
 static u64 notrace sun50i_a64_read_cntpct_el0(void)
-- 
2.25.1

