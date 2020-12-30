Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BAA2E79E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 15:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgL3OGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 09:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL3OGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:06:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F3C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 06:05:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x12so8704603plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 06:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fy/QSiWKrJJepxlTPsMdub2XRfCiCb86Kq4tKrXGspQ=;
        b=VHXb3Xx73aMQvDIgzvtdlOrc8Xfp5B4iTldMd2+8MIhzp7oEmttAbOHK1ZMk9Mt9L7
         8h6iFsaiLIoUeF3CEtqCjT9TtlSWpvOr8Y3qJjk38KtzL61cMr4MYjv20XpbW2mL1Ff5
         bX2Ws2+qqwGtD67oyq0Qlc2XA+U4uaedS6FEldonHMLhxZ5qBgS+RpalozClhAaJroM4
         xzaH5m/u1KmYYy+9QzvaQGRTHEgELW0O/iFYLRpfgmeV0nxCUdhQBPO+HGj/Iq7+9QEg
         BBehIE3xuQ5ovRV+Dpph8SHcu/y3uiyYtWY5plPIvZy4FA5QgMokj2+ueErDQYxEoU0b
         cdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fy/QSiWKrJJepxlTPsMdub2XRfCiCb86Kq4tKrXGspQ=;
        b=qAXfNfCx+pC2Oi/5tWJwkSlZmJyGSqLp72S7nbfZ5XX2z98UdFjM6a0hFaSJyeC5Kd
         JLqMFB/sQ2TgloMyeQwntdeq6FN9+tTq9SVMZbJwRVhRBdnPkg02DjEO4ZaYgifRLiMg
         rLzapA0irToFyO6aOhGsbNoVe3mwG07sCrZGgGY3WxUvXxaXRcl7LuMVVTF1tmS1KTPa
         JUQ1K4hWwv6fmSUbNA458NlVcRN33XQSQVSBZ7Qx2P9wbmGadqpOfwxBZeMtRQQWAS09
         Y+76HkJWrnNVfQna7wugNEBh6OVk+xIfSNLFzpBMGWMKz8Y4z513FKAEk/DFgY/lzpuh
         wvYw==
X-Gm-Message-State: AOAM532i651FOp5NO0Qw5bvlpT/Cofbnb16NAVD1TO+cUwLERMowcaw8
        S7Vrf2RsBme1xzGb1nzyd14=
X-Google-Smtp-Source: ABdhPJzeHxyhEjRCB6jljAHi0rPs9R6DKaZN9Qn7WhxR1Xdq+FucRj7ST5KNCtXOOtRjXju31b1mqA==
X-Received: by 2002:a17:902:eb53:b029:da:da92:c187 with SMTP id i19-20020a170902eb53b02900dada92c187mr53594914pli.34.1609337130329;
        Wed, 30 Dec 2020 06:05:30 -0800 (PST)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id 84sm44427633pfy.9.2020.12.30.06.05.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Dec 2020 06:05:29 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v2] trace: Remove get/put_cpu() from function_trace_init
Date:   Wed, 30 Dec 2020 22:05:21 +0800
Message-Id: <20201230140521.31920-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b6f11df26fdc ("trace: Call tracing_reset_online_cpus before
tracer->init()"), get/put_cpu() are not needed anymore.
We can use raw_smp_processor_id() instead.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
v2:
Use raw_smp_processor_id() instead of smp_processor_id()
---
 kernel/trace/trace_functions.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index c5095dd28e20..f67aec5bb771 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -106,8 +106,7 @@ static int function_trace_init(struct trace_array *tr)
 
 	ftrace_init_array_ops(tr, func);
 
-	tr->array_buffer.cpu = get_cpu();
-	put_cpu();
+	tr->array_buffer.cpu = raw_smp_processor_id();
 
 	tracing_start_cmdline_record();
 	tracing_start_function_trace(tr);
-- 
2.17.1

