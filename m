Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607922B3DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgKPHa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgKPHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:30:26 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E2C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 23:30:26 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id p68so1985398pga.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 23:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qE47fPw7Ssv/KFjA0L5dv63syn8BReivonGm+SniB8A=;
        b=h0+wlUkSs9l9wFOvTLSFGjlgYJP5CDxqYNejm8bqCkE2tXtTPtFB9VJLpwahg1lHsy
         MWV5oMMV4dMpCwFYwaUQbbK/EvTvQpSusTjnxqw83xeASmZRmAL9ySQS/zbyzkHWqDSa
         njlAIZCLDwUDHFqIMwtbYzAqCKGNoJhePKLlhoTsrrMAGCGhuOXNiQ/qGUxzcYzkuLtR
         OpcuwICWAsh1RP152nM5f11LmDzOTcnaBTm3B6y09lb9vLR+cswu36oSq3QbYL6jstbm
         +iGddyAG0tzzhVukqc2WIxK6N9zUni6s5a2LDxRYAsoB0WJqOjIYYpCqFkJwitMq4bg8
         pecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qE47fPw7Ssv/KFjA0L5dv63syn8BReivonGm+SniB8A=;
        b=n506pJE6KzL/YKPZTmvQBEZhVGlr3LHiTRtlxaCcWtF4WwV30+n9kynr1tPAC/+V6v
         jrzW/rMsQAFyXjUW5JMCilB8g5iamxCHcgylM5/EZ/CA2Rb8drY4vO9zdfaTsvp46Xdu
         iLPi+9gwQ8BX/A9Xdk6AbxE7reRmjj+lKU8FBn3AHCGFbrvAs+f/UPAkw1UYWB5sIbTI
         r1l/2sZehc2symY7c3yuHCaaxzGu6tfG4UwUXwKaM3af8oVZoXbEQnjrpTDus+deAiHV
         gU2OYn4nWk1ukGWY0Y0YDJY5h3/ReBMYIV+Esoc/rU+gEZS0A+8LcZ0R3FKaTjPVHP9c
         9R/w==
X-Gm-Message-State: AOAM5339YUsAvTAxQBX80+KrxfxQCy8rC15oTOr9rcpdyOYPRO1Vne7w
        MuS5VYRNhzKDz2OD2Gzhu8w=
X-Google-Smtp-Source: ABdhPJy9PjU7zc8oaoWL2URVsHZHrRT7EKvuD+h19fqF9heouoBF+iWw6QumYlZ9VQk3N935DYvang==
X-Received: by 2002:a17:90a:34c5:: with SMTP id m5mr14482406pjf.184.1605511826091;
        Sun, 15 Nov 2020 23:30:26 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id w196sm16746235pfd.177.2020.11.15.23.30.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Nov 2020 23:30:25 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: [PATCH] ipmi/watchdog: replace atomic_add() and atomic_sub()
Date:   Mon, 16 Nov 2020 15:30:07 +0800
Message-Id: <1605511807-7135-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_inc() and atomic_dec() looks better

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/char/ipmi/ipmi_watchdog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index f78156d..32c334e 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -495,7 +495,7 @@ static void panic_halt_ipmi_heartbeat(void)
 	msg.cmd = IPMI_WDOG_RESET_TIMER;
 	msg.data = NULL;
 	msg.data_len = 0;
-	atomic_add(1, &panic_done_count);
+	atomic_inc(&panic_done_count);
 	rv = ipmi_request_supply_msgs(watchdog_user,
 				      (struct ipmi_addr *) &addr,
 				      0,
@@ -505,7 +505,7 @@ static void panic_halt_ipmi_heartbeat(void)
 				      &panic_halt_heartbeat_recv_msg,
 				      1);
 	if (rv)
-		atomic_sub(1, &panic_done_count);
+		atomic_dec(&panic_done_count);
 }
 
 static struct ipmi_smi_msg panic_halt_smi_msg = {
@@ -529,12 +529,12 @@ static void panic_halt_ipmi_set_timeout(void)
 	/* Wait for the messages to be free. */
 	while (atomic_read(&panic_done_count) != 0)
 		ipmi_poll_interface(watchdog_user);
-	atomic_add(1, &panic_done_count);
+	atomic_inc(&panic_done_count);
 	rv = __ipmi_set_timeout(&panic_halt_smi_msg,
 				&panic_halt_recv_msg,
 				&send_heartbeat_now);
 	if (rv) {
-		atomic_sub(1, &panic_done_count);
+		atomic_dec(&panic_done_count);
 		pr_warn("Unable to extend the watchdog timeout\n");
 	} else {
 		if (send_heartbeat_now)
-- 
1.9.1

