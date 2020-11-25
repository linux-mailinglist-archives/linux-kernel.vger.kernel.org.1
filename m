Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3792C4883
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgKYTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgKYTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:37:27 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67968C061A52
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:27 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so3286325ioo.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLPfmI/xJGGGJxd0CmpcCFxQgQrAkx7EEyyWSE1b3PU=;
        b=b8ECt+QnI1AYyGfspPRuFOAbuoZGbcEGUClKgcZik0b07PscmuryYvVcmnvlblN6SN
         nl4agS7v1ajmG5Q3oz7je+sHHEW6IpvF3lFp2lqDnnxAaTu8rNitFkoTS/MoCmnzKr3w
         pJcQiDyuO8x3s3rm3ytST+mcCq6RY2iClincb4SSSCr39ODsH+SroZ47EJD/qRwl8yqk
         bkZSxZ9CUp8OmFeswwoFRAihxulhF/TWeyglOaJD84ZY7t7Lod4VzRJoNXamsPXpopIM
         B1hXCDHQXUSFBr36ls2euoBQpt/aV0rqRNpYDf6g7re3WeEo8YjF1ODDvFLkyaW6kzvy
         nzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLPfmI/xJGGGJxd0CmpcCFxQgQrAkx7EEyyWSE1b3PU=;
        b=iLX+6AJjOtH6DBP/g2s8d3nWMqELy54JNOjYa244g+PRUWHnd+mfkqi4jWCoNANsfd
         zs3dffH/AD09L1xH0V3wCrtaxmzsp2dbDGy/nz8D+vhHxduBdnwwFNSQgPkQ9XGA4oGo
         pEjhqOnYrVoxJcHcmw59b9MVSXcvFxD/dgrq9bi1lOl62qF995yCKoNvnn0UEZOLtedF
         3uXJ0JzL8L2kZ5c3LKD+OpAnfQWJE0G/IWumATeYC0bb0+7RNVnVcRwdGPMUmaqqm925
         dvyNgXkeLvSMbBcz/1JJP/hF2EgK4Leb6owXPxc6TiUag8lDoqhNO5xXXUc3OV7YWTmZ
         q3Og==
X-Gm-Message-State: AOAM533J6sg0Zt1tP/h3uHYqYmdzh4kGoCgyp8r+5BlkwrxsD31Paf8/
        Y5tRQZSDwTZy3l1/In9Acy8=
X-Google-Smtp-Source: ABdhPJxNEvPVBjizk2xNlBVx4Wnkr/1JCC/ssyZuJ7uPIZjKAM49kAbHuL+BrLgWJvcve7oCItgWEg==
X-Received: by 2002:a02:1007:: with SMTP id 7mr3626403jay.73.1606333046791;
        Wed, 25 Nov 2020 11:37:26 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id f8sm1435548ioc.24.2020.11.25.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:37:26 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-mm@kvack.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dyndbg: add locking around zpool-add loop in zpool-init
Date:   Wed, 25 Nov 2020 12:36:25 -0700
Message-Id: <20201125193626.2266995-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201125193626.2266995-1-jim.cromie@gmail.com>
References: <20201125193626.2266995-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit doesnt improve things, last commit was working, next one
still breaks, despite this "fix".  I keep it separate to isolate it
and the reasoning for review, which now stated, will be refuted as
needed. ;-)

Locking review:

ddebug_zpool_init(), like other ddebug_*_init() routines, does no
locking itself.  Unlike them, it runs later, at late_init.  This patch
doesnt fix the kernel panic that HEAD+1 does.

ddebug_callsite_get/put() are called as a pair under mutex-lock for
all 3 callsite users.

2 of them; ddebug_change() and dynamic_emit_prefix(), do their own
ABBA-ish LGPU (Lock-Get-Put-Unlock).

ddebug_proc_show() does the GP part, and is wrapped by
ddebug_proc_start|stop() with LU.

ddebug_add_module() does LU to protect list_add(), HEAD~1 added
ddebug_zpool_add() loop inside that protection.

This commit adds locking to ddebug_zpool_init(), around the loop of
ddebug_zpool_add(), to match the locking in ddebug_add_module().

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 473406b069a7..534d73e45844 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1195,8 +1195,10 @@ static void __init ddebug_zpool_init(void)
 	}
 
 	/* add-module normally does this, but not in time for builtins */
+	mutex_lock(&ddebug_lock);
 	for (iter = __start___dyndbg; iter < __stop___dyndbg; iter++)
 		ddebug_zpool_add(iter);
+	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("total pages: %lu compaction: %lu\n",
 		  zs_get_total_pages(dd_callsite_zpool),
-- 
2.28.0

