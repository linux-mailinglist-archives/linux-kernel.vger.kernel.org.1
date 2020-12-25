Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A122E2BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 15:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgLYOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 09:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgLYOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:24:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4286AC061573
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:24:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c12so2596620pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3LUL3IPs2u23VYZHBG54hTti07wvEPOalMEvUvJcwVI=;
        b=f5f9WFuoVFmsmAqIDEloL8BngBGC/IaiPrJRZocFb/TwBZ66msttbSGO9ljswY5fz0
         JcdCX4NTSUcxRYO21KApj2HB7RHNwr9MAMUhjpZZVWNX4kgxCYq94YEjAdJxPp1s/gxn
         NjgkAeUJqah27rrc2NXmfy91luD3G0u9VSAG0SQikDqsVGcptNaDJ6Ot63HV43uKB6rs
         2RkNqOKCZYOLKzPAUtUrUoFEa4Bh6ZrHW97UJGy6ASF0meSEvGHe0d0/8TmsK6S1dUfN
         iUgYgJPOcdDJMcZzA8ChzShatM37bzbgJ9dbRkwKEohoPRb8XrcXbyvdgNXsKFXjNX3V
         gI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3LUL3IPs2u23VYZHBG54hTti07wvEPOalMEvUvJcwVI=;
        b=J9I3SZF1ydBWufzydLW7944yeQyPtNer/PHMA+aOeHXyu3o1KSI44/NPBvUxde0SCR
         ccvtXmS7j4djDYWWThlPieaM4WLHU1BWgbG/xYaSFWboQtwH8V6+XsM55oJITCboxl70
         7L9ae9Xg1i6zz1NnXjyR4jSK3HkelBCgXXT/1Dz/9GNI4uu2TDqM3viHyWpXEkoww7kI
         YyvsmOQnVixqDnXONbccW85E5bzxKcAUbzvpimzajv84lPFxhEhnrC1UMqCaUqnLHHze
         Q0PIOyKP1fUnTA2U45RrTO2wtzgAXW2f/lkVjomZJrRttbIm6piaQeQB95+9sE425q0K
         YcRA==
X-Gm-Message-State: AOAM53205P0d3hG51R5xIiSZ2DBZfxuo8eDn6t/3lpB5mtUpuDMIfiBo
        sdsWRYojWVbpLvVB8FIzvHg2RoeMbc4=
X-Google-Smtp-Source: ABdhPJwgshlhRsAL3a93kKqWdcKazXezUM5jjRioc+Zz4nQxzqxENk5RS4jfGIFXLF3SEBAy+DBkYQ==
X-Received: by 2002:a65:450d:: with SMTP id n13mr33010899pgq.208.1608906246912;
        Fri, 25 Dec 2020 06:24:06 -0800 (PST)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id e5sm28766113pfc.76.2020.12.25.06.24.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Dec 2020 06:24:06 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] trace: Remove get/put_cpu() from function_trace_init
Date:   Fri, 25 Dec 2020 22:23:47 +0800
Message-Id: <20201225142347.27204-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b6f11df26fdc ("trace: Call tracing_reset_online_cpus before
tracer->init()"), get/put_cpu() are not needed anymore.
We can use smp_processor_id() instead.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace_functions.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index c5095dd28e20..e36fbb935017 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -106,8 +106,7 @@ static int function_trace_init(struct trace_array *tr)
 
 	ftrace_init_array_ops(tr, func);
 
-	tr->array_buffer.cpu = get_cpu();
-	put_cpu();
+	tr->array_buffer.cpu = smp_processor_id();
 
 	tracing_start_cmdline_record();
 	tracing_start_function_trace(tr);
-- 
2.17.1

