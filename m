Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B794303E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404008AbhAZNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403767AbhAZNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:12:55 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FCCC0611BD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:12:15 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 31so9727389plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4yz02GiswhidfSCxDhxsCfQ1U1OCeS05kp58XLLSkHI=;
        b=t5ymdC5k3D/PxMaII0V9xfDDw5xB7oE+g56DDyCOGPByJJyF2qnyn8jIFCCFwwl+Kw
         mHQxkHzyv7y9Mx8zMT19wDeNLM/PAS9GQXi17OZng5fUdylqVwpzLt367fQNaLfw+L2a
         nxccuFK/3bB0+cPdfVgZsGtfKltUS6ieFg7PoobiyDn/0/GpEchZhQkISwkOl7CzcXJ8
         BgoMywAbmliZnPDNsyp1V5uNiOEh6rd2tJ0QcDlBwrZFapgaTXqPJyUI35xr1GCy8ueu
         OPHG7IpTLnkHPh2dnIc6h4h27631H2Kwhov/bO27MNXDolmVqK5rlj/5OoXyiaNuGUtf
         05bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4yz02GiswhidfSCxDhxsCfQ1U1OCeS05kp58XLLSkHI=;
        b=ox4n+JAqn7ho5fFazLnh/L3vGhl2AwCIt0iF26ybtAwRGx+uqRKMQl9tiNPBQnCt56
         a8G7BQvOVYJLejnQdYYx7xHwieSF4sXFiyFQaFVEsYe/cKzQu344XTqWFf7w8AyPIOxh
         4y9a4CvpoPInZ+wVqjZkgph9hKIz7JhvlW5UzHJ+YKdLSPhMQUGn2MdHnw/eQ34wKvc1
         4W7DaPrCRQYgpINTCBvmOPuV/KFMox1S7rdquiIgQ7dS5/id/y31sNVN0M23vDPISB0U
         3dmYdTLIMex6WLq0mzKwNfKR011ykGyGct5JNJN/B70jEwkkzAls7ZqNDmIr3Hx7iWPP
         Nkrg==
X-Gm-Message-State: AOAM533F+11MNUvxvggWoBxuewZzxBSVZt4uk20CW/KkRUVXxjDL2DWO
        VhT8IIVr0bRt83NTJKq2V9c=
X-Google-Smtp-Source: ABdhPJzR8wLYLQsVYfj6qAZehYyx0M0CxHOpePj7UPFJ275CZUvDY46ClZK7fuw8mjexl0G/+t+Nkg==
X-Received: by 2002:a17:902:b692:b029:de:43aa:6537 with SMTP id c18-20020a170902b692b02900de43aa6537mr6137430pls.65.1611666734751;
        Tue, 26 Jan 2021 05:12:14 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id bt8sm2549205pjb.0.2021.01.26.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 05:12:14 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     paul@paul-moore.com
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] audit: Make audit_filter_syscall() return void
Date:   Tue, 26 Jan 2021 05:11:51 -0800
Message-Id: <20210126131151.10418-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

No invoker users the return value of audit_filter_syscall().
So make it return void.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/auditsc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ce8c9e2279ba..c8e16b9c0f21 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -804,7 +804,7 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
  * also not high enough that we already know we have to write an audit
  * record (i.e., the state is AUDIT_SETUP_CONTEXT or AUDIT_BUILD_CONTEXT).
  */
-static enum audit_state audit_filter_syscall(struct task_struct *tsk,
+static void audit_filter_syscall(struct task_struct *tsk,
 					     struct audit_context *ctx,
 					     struct list_head *list)
 {
@@ -812,7 +812,7 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
 	enum audit_state state;
 
 	if (auditd_test_task(tsk))
-		return AUDIT_DISABLED;
+		return;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, list, list) {
@@ -821,11 +821,11 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
 				       &state, false)) {
 			rcu_read_unlock();
 			ctx->current_state = state;
-			return state;
+			return;
 		}
 	}
 	rcu_read_unlock();
-	return AUDIT_BUILD_CONTEXT;
+	return;
 }
 
 /*
-- 
2.25.1

