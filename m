Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BCB2E2C48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgLYUV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgLYUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:39 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB9C06179B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:25 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 81so4512509ioc.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwVcF8sEuPjEGsEv5BDYtdefCLQp/sk8MhkppBLUIMQ=;
        b=ss6UroHbJXfkNpxzPetNJzyyycgqEzYYERH1m53E24XGFxKATTleUwMV1SYyNsAHjD
         tzpXw5FukAVzvjVCcOB4BHivBrio+gg8SqVI8syyaPmfHEKqASDe2NP4VQ/HMjbnrI/P
         fsztL80BjlWWFx0+rj5SBeYI58WzokejdivGorm0972Ze7wf6j5IAeujxaraDqdptEQ1
         ejdSNfUmT/RhAwjliD27fjO+E8kjrVIBzt0NkIi4QlUMDdITGHErKBTKsO53HokED7KO
         be248OXCRZ9CubljuXkmPN9USehmiF9RRaY/+DS/CkXd1FC7RHgVGcPo9nSq/CDC9JnI
         Sw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwVcF8sEuPjEGsEv5BDYtdefCLQp/sk8MhkppBLUIMQ=;
        b=ELnd0vupcPiAm5DF/X8Nbya7NcNdpFuPuQ72oEVsOYHjbNsJw9DwCnxBkhYh3BnUn5
         FXkxjSUtLbK3ihOCUpMWdW5OpCuUrrbokUi6WzQRqncQ5xx1SD4Du7QQzNehnQEmNF2e
         xCETX3/lVHMaUctGAlW7OXbwUO4vfgl2GKT1t+RW0CshHajxqqcM3qt/EycPCSDa++wu
         FpwSZAFHTtbdjxTBboCssNA9IGrc/H07pEcf9Q51wejunQKjDidLsySOqDUf45Wo0URi
         r2WQrEZ4B4rtcyaanT/hTh+kZMIvjYBxJ6SOnc8tRYjGyCECSFqr7sBI0kyYZN8BChDs
         wMUw==
X-Gm-Message-State: AOAM532/+jiFpSpDuhd+F0fn2mAIyqm3TvEiqrOrKlu8349eNBQ9VLrH
        flk6pRR6DJ01BZPhsryIV0o=
X-Google-Smtp-Source: ABdhPJyShYlEd6PE2j/ROX4EY+RbY7rbY9oXLY02Y8v9QioFUJZGXt37I4FR/jt0Umv6X5ZrEf2wPg==
X-Received: by 2002:a5d:824b:: with SMTP id n11mr28751176ioo.27.1608927625085;
        Fri, 25 Dec 2020 12:20:25 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:24 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 11/19] dyndbg: refactor ddebug_alter_site out of ddebug_change
Date:   Fri, 25 Dec 2020 13:19:36 -0700
Message-Id: <20201225201944.3701590-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the JUMP_LABEL/static-key code to a separate inline function.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index daded73c8575..6203a6ad1706 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -188,6 +188,18 @@ static int ddebug_match_site(const struct ddebug_query *query,
 	return true;
 }
 
+static inline void ddebug_alter_site(struct _ddebug *dp,
+				     struct flag_settings *modifiers)
+{
+#ifdef CONFIG_JUMP_LABEL
+	if (dp->flags & _DPRINTK_FLAGS_PRINT) {
+		if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
+			static_branch_disable(&dp->key.dd_key_true);
+	} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
+		static_branch_enable(&dp->key.dd_key_true);
+#endif
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -224,13 +236,9 @@ static int ddebug_change(const struct ddebug_query *query,
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
 				continue;
-#ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
-					static_branch_disable(&dp->key.dd_key_true);
-			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
-				static_branch_enable(&dp->key.dd_key_true);
-#endif
+
+			ddebug_alter_site(dp, modifiers);
+
 			dp->flags = newflags;
 
 			if (dc)
-- 
2.29.2

