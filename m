Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3344273261
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgIUTEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIUTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:04:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:04:42 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t76so18170966oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j73dTewopm2qVlcHvK6lTzprKxPw3SgYPU6S+3OiUQs=;
        b=Z03LAU889fW/HfmvaxGCPlYjOatXJR6fDosKvB1fbAduw7TzNf29nUFoV68mZJhbzX
         A05uBO+quOPKDL67bdwo7392gV3rkRPM48Jv4y3Oxk1Bed7i4rp1AB7VXKq9dv4RZ8mB
         Y+ECgxmBS3kYpv4RkXpncDuvfeq0cyTpKOXwLiaKcnmI8pCFMz/5bY5jj7Tf7yY7WFQi
         l43vTHSyEGT2xIbucm3iJHMafDBybJEdBuIwZE/WySPaU4mK/Dip5ZBKo07mkj1uRbZ0
         aX6GuiMnqddxIVYZqObJaGwT6Mgw5rkOcXdiE1UF9l02zqXY0kAOGPMdTubw5KWoSnIM
         rE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j73dTewopm2qVlcHvK6lTzprKxPw3SgYPU6S+3OiUQs=;
        b=CufTXUuG+IeSmE/l0J43ZNB6VP9Uw7l9ggSzTsP8BHnnjpiGJG8clxy89Gle4Mx7eV
         r/pDO7VTtRujL/cJ1s7BLwUBudswrXhZb82w+eN+N0rAbkXpWPtng3iA8W5f49El1fzg
         CAa366DAZQgy7V/HhpL1LD6v+jwM+0G8dWFJCvcLuiMqljwU/g6rRAOvkWT+5iZxUmQT
         x1U4Ld/5vsgXE4z3K4MD1cjmGoLlATh6WMVTwP/u1o5E5MW4ufeejIq4KmMdIW9j+5en
         /3JOQyHgIIq+vqLjBOSsj2L0kXsz8B1NDEQi9T1iMP8oPwL1mBbahjHZVuLRMje3XdCE
         4jWQ==
X-Gm-Message-State: AOAM532hmj8ZBkP4I1o8fZcpo3lM+zfv2t/u9z3XpW8NLEMLdom2xWDe
        8HStwHTJ5nT142fXTKkOJhc=
X-Google-Smtp-Source: ABdhPJzbhC8JdNKM96enUNblalrsOWPlfaHtWfRqZwOzrzlNuik9o3SHw3s55WHux1Se4jwi9cqynw==
X-Received: by 2002:aca:1716:: with SMTP id j22mr540197oii.44.1600715082318;
        Mon, 21 Sep 2020 12:04:42 -0700 (PDT)
Received: from frodo.comcast.net ([2601:284:8203:5970::2931])
        by smtp.googlemail.com with ESMTPSA id f1sm7426493ooq.12.2020.09.21.12.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 12:04:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] dyndbg: dont panic over bad input
Date:   Mon, 21 Sep 2020 13:04:32 -0600
Message-Id: <20200921190433.1149521-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921190433.1149521-1-jim.cromie@gmail.com>
References: <20200921190433.1149521-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This BUG_ON, from 2009, caught the impossible case of a word-char both
starting and ending a string (loosely speaking).  A bad (reverted)
patch finally hit this case, but even "impossibly bad input" is no
reason to panic the kernel.  Instead pr_err and return -EINVAL.

Reported-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2d4dfd44b0fa5..90ddf07ce34fe 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -259,7 +259,10 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		} else {
 			for (end = buf; *end && !isspace(*end); end++)
 				;
-			BUG_ON(end == buf);
+			if (end == buf) {
+				pr_err("expected non-empty bareword");
+				return -EINVAL;
+			}
 		}
 
 		/* `buf' is start of word, `end' is one past its end */
-- 
2.26.2

