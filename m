Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943A729F003
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgJ2PdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgJ2Pb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:31:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5A5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:31:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x13so2623709pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=POKnlFfl2V9OZ8B9RgrGBFa9+xh/s0EHhEzNswRMK4M=;
        b=K3SW5pIn8+AD+g1YUYPABSi42jUMlyuzFTRT/i8n+Ek/EUQB7SJ2J4FvGqydWiksCh
         fcXA7XFB7oTReWhWTSuk//Kosg0zlPQhNlhwpTWWd72mvhBkRUFNYHmAJOpHpJ7ooz+E
         FY8S0ArE1emZGYXGciswq4B2nQFs7Wy+hlBgdwbtCX76UK7oQLm2XTfMn/20eRqZIqbW
         Zk/jCWo4zrrENF2BN4CRy4UxCU6tBfN6HHANo+8+1gapPfFS4ZB9mH2CgKF60wNPnDDJ
         sOzSOXd6J905skl73ffKv5/lk7X7ngcg4hxGsiXRiRMwc65LYthTFAKSFNZc0tzLOOPT
         qdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=POKnlFfl2V9OZ8B9RgrGBFa9+xh/s0EHhEzNswRMK4M=;
        b=PpfraunMrN+Cq1JCDQFh1S2ouexIj1FWXwj3QdBxF24o1l887OnwpKwEMgSesO2aAU
         8wdkZCitlCa8P4rckKtCbKGVhuOStwKAil6DhEAcr7IqORNs8GB6LHhu7sJg+w9Exaeg
         1g2r9n/UO+P09IchDi/JyHjPK8KHqyhB1mF+VDGSvYcCC2tjYRTBDhr13oOr2WeOrxlA
         WBB8ssXnBdGiV99aJSIim1BPE4XyAQv4Fq4la1/dFvVU/8qMKayDtO0fcDfq+0krvqcn
         G9KJFJiphxjRum6T/fqYoiOpc6ZloiV2Pj/DhzUQqwyXyQUsGSVyTZY+W8VxUzZdPZ+q
         vJPg==
X-Gm-Message-State: AOAM532OWGWNYeEzPv+YyiEbgUSEsHnpkDPkZ+cS0nWcGGS2tmExU+fB
        suZ1BHsncLsg+kBmovQYz94=
X-Google-Smtp-Source: ABdhPJyYhoO9QxGQkc2+glDzbmnxc1qp3YlVE1fEs0lilptHSHDQYk6yq9xzZObfxXuO9xYED2Wx4Q==
X-Received: by 2002:a63:e542:: with SMTP id z2mr4606132pgj.320.1603985518584;
        Thu, 29 Oct 2020 08:31:58 -0700 (PDT)
Received: from localhost (42-3-19-186.static.netvigator.com. [42.3.19.186])
        by smtp.gmail.com with ESMTPSA id a22sm3382229pfk.29.2020.10.29.08.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 08:31:58 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v2] tracing: Fix out of bounds write in get_trace_buf
Date:   Thu, 29 Oct 2020 23:31:40 +0800
Message-Id: <20201029153140.3643-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boundary condition should be 3 as we access
buffer[buffer->nesting][0].

Fixes: e2ace001176dc ("tracing: Choose static tp_printk buffer by explicit nesting count")
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
v2:
Fix a typo in the title.
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 528971714fc6..196a4b7de48a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3125,7 +3125,7 @@ static char *get_trace_buf(void)
 {
 	struct trace_buffer_struct *buffer = this_cpu_ptr(trace_percpu_buffer);
 
-	if (!buffer || buffer->nesting >= 4)
+	if (!buffer || buffer->nesting >= 3)
 		return NULL;
 
 	buffer->nesting++;
-- 
2.17.1

