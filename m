Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9AA3013EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 09:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAWIfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 03:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAWIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 03:34:52 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB0C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 00:34:10 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w18so5369909pfu.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xDOkp1Lj/6RkXiLeExopeEGisiCPpjXDMNcBiNnj1b8=;
        b=GgJQz0ZrDFeLLaRo33VdCvSQOSlkTt9azfPEGqVEjbiaMpSMFihPnir1J2hOc/WL0g
         3mi/v1bh/VQ1y8PJmlw1JiS9508YeGN1FrUv5/siYb3LWGTuLLiuBXKkUd0Mn+gv6veY
         BmrnheLfg243AAP5yCz8i9NNqJA7szBJamBathyTQC4rTzwJECesdRNa3NOWkceARlSl
         XnYFlJNLSQoy+a7O/CqYaPnmQxpmtTbZYdogKIhDn4YsaT0cOOQ5+Rh3HytPOiUqeR+m
         SLAJb8ZR7y2Iv5jZ8j6t7/pIglLv3Th5ny5smph8LjAdK39hx4C85XVka8pn9kg+Cxvw
         pwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xDOkp1Lj/6RkXiLeExopeEGisiCPpjXDMNcBiNnj1b8=;
        b=W+gnRzYtQ2p4NaoyPEYGahkj7bZzh7wOTgWgt2YCuyPfkzLRMoI51dA1Tx0z6f8vKz
         sI3ckgVkJi9xJUsR+CMKJmFuUu6OINt52QxDlxeEELZOBONPXVGJsF4S+nHOyxkwNrwD
         YWuThyqnUL2U6Pshach0r1hXZGpzIAOEvRsFM30C7gwe+Of9gbRK0tWVAKBcS19lBKbK
         69dvldAl//55ATu5KQ+qqwz+mZOgNwVpYKeCyOrhgGhLKMEutVgZIFsvcNN/PVzknAce
         BOMWELvwFBkyFlv/G5s+/BgpeRpgnuAcSVocA4KNQTLVAmpHYtxuwM/p2cK4cWD60EBy
         rc2A==
X-Gm-Message-State: AOAM533C3QoeHAtsmJSNgKm15CnX7Uf0tVLz/+amguX/KUR22dVw2PHS
        D23qJQVGbKUKxiLDKDxHFjQ=
X-Google-Smtp-Source: ABdhPJylgIKa6DoE8mtBsaKpYpqflZmpWikuiXLC+vm598TmFESNEWOx4mp6BSQvqSqeEmOk/Jt2HA==
X-Received: by 2002:a63:5924:: with SMTP id n36mr799076pgb.9.1611390850348;
        Sat, 23 Jan 2021 00:34:10 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id v11sm11628989pju.40.2021.01.23.00.34.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 00:34:10 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH] torture: replace the function name with %s
Date:   Sat, 23 Jan 2021 16:34:01 +0800
Message-Id: <1611390841-5460-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better to replace the function name with %s.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
 kernel/torture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 01e336f..0a315c3 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -816,9 +816,9 @@ bool torture_init_begin(char *ttype, int v)
 {
 	mutex_lock(&fullstop_mutex);
 	if (torture_type != NULL) {
-		pr_alert("torture_init_begin: Refusing %s init: %s running.\n",
-			 ttype, torture_type);
-		pr_alert("torture_init_begin: One torture test at a time!\n");
+		pr_alert("%s: Refusing %s init: %s running.\n",
+			  __func__, ttype, torture_type);
+		pr_alert("%s: One torture test at a time!\n", __func__);
 		mutex_unlock(&fullstop_mutex);
 		return false;
 	}
-- 
1.8.3.1

