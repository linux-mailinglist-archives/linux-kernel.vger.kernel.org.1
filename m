Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B934C2D3936
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 04:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgLIDWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 22:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgLIDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 22:22:44 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81212C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 19:22:04 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so92335pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 19:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kE2FmGi+NBcEH+7fTQb+PyvwhRcfzZ3tL3pXgj3lp0U=;
        b=Jy3vrUApDBhHvZJBn57K8e/d2idV4VgedPdQrlFVN8/gHofHQRCSUS+EyLsLWN23kW
         iUM/EzG1GlZOza3lgi258SgApobYZzbtgkDMrh5X+P6Dtg0wFiRSnm4LY/LvIKrS9Mg2
         hSJzzHUTuvM6MNY7peOqsOG3g54lGtivoXq9prMyTHFR9yAaWfdPX8+c7dXRsbuAu2FX
         qwXAMlXCAy2gKgVbD19TkixdU6BiBA/C8bQdN3Ka6fBa3Pl71bCbtheUT7Uck2dN5ySq
         I/vz3wsg5ZlvuhpiPYbAsa9l22m4P/cuRzvPt+Ok2EQhqPl32lmspRkLpmv4BNX5rHGI
         2Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kE2FmGi+NBcEH+7fTQb+PyvwhRcfzZ3tL3pXgj3lp0U=;
        b=fGf7eRNrgstMI7MBoMb35X9ERSRAVdA+MLl+v7/p3iMho/74lPUMQE3ayOD6szGjBA
         aFVirtMN3Nzm2N2FVtY0LaKNuHd5Zaolzo/8xsTfp4Pgn3OyEViOwekWVOprKnR/y3Sv
         5mrRFvQZVgjgMn39A2/TH46PCcVBPF+UTAiz1FEfqzCSvBqM5Z7YkJlfnHU/CKJCk7Ax
         97cblul7W9qBu50pMeLtjjGAijGUPsWD3sUd8hhipum2SAdfwTvPk7wgfuXZ1fdT3PO7
         DvnOFpQN8F9XCOfoe8TLVOHT1x5mupahmnK0r9So4BesZ09DtVfRTsJGDc3Equp4bvsB
         aRFg==
X-Gm-Message-State: AOAM532VI+G1zvhAY3JeO1szQMCUvCj76RscexmU81B3OXCulv5EJId/
        XfYmi1gm7RdRKniXz6Ndo+Q=
X-Google-Smtp-Source: ABdhPJzaDkDWI6XXJwPVjvBCKV1E4lYeZm47ZQvRlyCxaueRb7Cz8XT18kQkF76HsVXx+cVLeJA8gw==
X-Received: by 2002:a63:471f:: with SMTP id u31mr153252pga.74.1607484123975;
        Tue, 08 Dec 2020 19:22:03 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id 10sm216009pjt.35.2020.12.08.19.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 19:22:02 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        jannh@google.com, mhocko@suse.com, shakeelb@google.com,
        surenb@google.com, christian@brauner.io, rientjes@google.com,
        bgeffon@google.com, vbabka@suse.cz,
        Minchan Kim <minchan@kernel.org>, security@kernel.org
Subject: [PATCH] mm/madvise: remove racy mm ownership check
Date:   Tue,  8 Dec 2020 19:21:55 -0800
Message-Id: <20201209032155.564991-1-minchan@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann spotted the security hole due to race of mm ownership check.
If the task is sharing the mm_struct but goes through execve()
before mm_access(), it could skip process_madvise_behavior_valid
check. That makes *any advice hint* to reach into the remote process.

This patch removes the mm ownership check. With it, it will lose
the ability that local process could give *any* advice hint with
vector interface for some reason(e.g., performance).
Since there is no concrete example in upstream yet, it would be
better to remove the abiliity at this moment and need to review
when such new advice comes up.

Cc: security@kernel.org
Fixes: ecb8ac8b1f14 ("mm/madvise: introduce process_madvise() syscall: an external memory hinting API")
Reported-by: Jann Horn <jannh@google.com>
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index a8d8d48a57fe..13f5677b9322 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1204,8 +1204,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto put_pid;
 	}
 
-	if (task->mm != current->mm &&
-			!process_madvise_behavior_valid(behavior)) {
+	if (!process_madvise_behavior_valid(behavior)) {
 		ret = -EINVAL;
 		goto release_task;
 	}
-- 
2.29.2.576.ga3fc446d84-goog

