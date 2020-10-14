Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5224D28E34A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbgJNP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgJNP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:28:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:28:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so564pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qSDcEWWvwHOxnheEAr7MXUYKCuSbeqeTsFhggvLr2+E=;
        b=E4ekMek7TuSmxYxOO+DHiKQPTTWQQ6cNz1jLogp+WIMmOVK+PWa5pzZhdUmRX5k1oJ
         PmEGVdzgmzmQn3EmhcdLFU7LjKMNcmYOviDEUDfBcyvMipEdo04Z6b38YmudEPVXD0YQ
         AwqaD16TWvnnpI6Cq0lfK6zWaXiGGEvvpdw16uknxlB5xe7kPRYMrsncAral46jnBLL8
         Zbe92vPcy0PyayHrLh765dMe+lSullp2123+E8SnhovMSoXjthMz7nsssRzuF9CXDPoj
         9/+y2SA0lSZ6pTZkgsS8A3HTZHcibsqi49bE/sDh8nUoqltFSr8KzZ77P2szrSZTanBm
         sC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qSDcEWWvwHOxnheEAr7MXUYKCuSbeqeTsFhggvLr2+E=;
        b=O0j2VJqtmxI03IUtfIFXN18Qwr5YEyV9HCOmnetnqeaOzTN2CVpLy0WN8+iRkTdJ9g
         kawyi3B2pzvKL8ji/CYcaeaBX+Uo4rjYyCIoH7DHyFAPTtQZJfuKGPVS+Fei4YbXWKMY
         i5zvDB98U5eoF68ocTBtzI4o2wolSAryaAlVGZmvx2eEpGqiMAa5lBjofQb7JGSU2B4r
         pZ/iNB5glFXsld7ElcjXI45XhZJJQTzK8EB9O7h/fNJVmZFPgf4GEyzk4d0jWGiYaoFQ
         5hDMnl3/AnOHYdOauIHNMBAw4ERIIQORax9zXtukDppeg/Vms0/LWdRf0Pq6AKxtyEjM
         rqUw==
X-Gm-Message-State: AOAM533PZOGVdcD7SQ5tofTgsW2cDAu6SS2xTQE58Koy9nmGQ2QGbLHM
        MKJH9giPc9UU+Hbw1wYvJHU=
X-Google-Smtp-Source: ABdhPJyJnVrfvWcW6LQ+ON2v4Na2HZ63zsgl0dHhLiTMLzdRsJMh4bATvJ642aixdQVWh8/DE9jYMQ==
X-Received: by 2002:a17:902:7c83:b029:d3:cc6e:6dae with SMTP id y3-20020a1709027c83b02900d3cc6e6daemr4824851pll.13.1602689280086;
        Wed, 14 Oct 2020 08:28:00 -0700 (PDT)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id l13sm3832472pgq.33.2020.10.14.08.27.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Oct 2020 08:27:59 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ring-buffer: Fix two typos in comments
Date:   Wed, 14 Oct 2020 23:27:49 +0800
Message-Id: <20201014152749.29986-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/inerrupting/interrupting/
s/beween/between/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 93ef0ab6ea20..87bfc59679fb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3225,7 +3225,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			/* This did not interrupt any time update */
 			info->delta = info->ts - info->after;
 		else
-			/* Just use full timestamp for inerrupting event */
+			/* Just use full timestamp for interrupting event */
 			info->delta = info->ts;
 		barrier();
 		if (unlikely(info->ts != save_before)) {
@@ -3261,7 +3261,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			info->ts = ts;
 		} else {
 			/*
-			 * Interrupted beween C and E:
+			 * Interrupted between C and E:
 			 * Lost the previous events time stamp. Just set the
 			 * delta to zero, and this will be the same time as
 			 * the event this event interrupted. And the events that
-- 
2.17.1

