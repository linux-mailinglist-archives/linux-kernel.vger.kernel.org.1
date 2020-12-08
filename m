Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959BA2D33D5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbgLHUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:07 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35986 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgLHUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:12:50 -0500
Received: by mail-il1-f193.google.com with SMTP id j12so9476564ilk.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FWO1In4k/q/qaAMSnIUejYYiefldFf5ojrS9MJ5ecU=;
        b=ZpExrs/P288Ri219IjA3Hw7BD0R00bOLGSdhmyBCQFJfxiZEIsObGa/IdxlVpG0Vzc
         +TH2MEe7hE3jRo1OojYBZSxRRLgTp3VdfSqh6jAPg6RVv70ewzefSOxV8UlTRoNBwvKM
         yMy/nz8wJDVxTo1rlREHkP9CqLLJMTHzIXcb0jy/aeKbQh1qy7C749Cn5ZEZcUekVPCK
         EU2AVGWeE8oCxjnqZkMduWUA6+JGUqnDQVNo2L2abXX4akXPdM01xEZj/6JMO3BkhYiP
         1vd3TX16ZS/VHMiJDZEQc0H67ZsiDPqUeH5eBQknoqQ6P1qUBgqfXXN5ms11XDsY/btV
         9g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FWO1In4k/q/qaAMSnIUejYYiefldFf5ojrS9MJ5ecU=;
        b=nPRdc5IgxoDMe1weqBTJOO2MlP7yIgg6VejL2VXKRa+QdnT0c9nJNRWPpdD+Pu/qkB
         8MiNhYAB5Nb0FhsxMh2VtKXBncfJeT9PBDGDkWqqI+Rarrb0fB7g+ornP/Z3YuK3zR5n
         bmGvAR6+7r/wDUkXbF3e7TiBveAy5+d5t39P99wReW+7L5HjIWSfoBgFQ9Ty749VfbMz
         Pd3Pc5icumIwu0s4LZJhdHyJB3a7Ec0CeL31FuEKNaDHEd3g7SClEEImDNuReCcpIQOz
         agig21r2agrYlswJndatVdkAxd4FpwGEw6R/0oKnxW31SLQdIhc3j1G+FL5KEfVLi8Lg
         CFHw==
X-Gm-Message-State: AOAM531w5N6U3NdmOpVqhLO8h0X7I6sCuuiiKxcZ1I+bGEBCe+SidKkw
        egNPl99nvRWiKTmNgQ1rtckeHoZtupmI6XPb
X-Google-Smtp-Source: ABdhPJzyIt0qixl+OfzysGNf0MERL4F6J9Hq7NNf8oxQW00m7AqhAW/8BHSsD0+zQQoTmN93P1OyQg==
X-Received: by 2002:a63:f501:: with SMTP id w1mr847244pgh.142.1607456626044;
        Tue, 08 Dec 2020 11:43:46 -0800 (PST)
Received: from localhost.localdomain ([49.207.201.111])
        by smtp.gmail.com with ESMTPSA id x10sm17337654pff.214.2020.12.08.11.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:43:45 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
Subject: [PATCH] fs: quota: fix array-index-out-of-bounds bug by passing correct argument to vfs_cleanup_quota_inode()
Date:   Wed,  9 Dec 2020 01:13:38 +0530
Message-Id: <20201208194338.7064-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dquot_resume() was last updated, the argument that got passed
to vfs_cleanup_quota_inode was incorrectly set.

If type = -1 and dquot_load_quota_sb() returns a negative value,
then vfs_cleanup_quota_inode() gets called with -1 passed as an
argument, and this leads to an array-index-out-of-bounds bug.

Fix this issue by correctly passing the arguments.

Fixes: ae45f07d47cc ("quota: Simplify dquot_resume()")
Reported-by: syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
Tested-by: syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
If type = -1 is passed as an argument to vfs_cleanup_quota_inode(),
it causes an array-index-out-of-bounds error since dqopt->files[-1]
can be potentially attempted to be accessed.
Before the bisected commit introduced this bug, vfs_load_quota_inode()
was being directly called in dquot_resume(), and subsequently 
vfs_cleanup_quota_inode() was called with the cnt value as argument.

 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index bb02989d92b6..4f1373463766 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2455,7 +2455,7 @@ int dquot_resume(struct super_block *sb, int type)
 		ret = dquot_load_quota_sb(sb, cnt, dqopt->info[cnt].dqi_fmt_id,
 					  flags);
 		if (ret < 0)
-			vfs_cleanup_quota_inode(sb, type);
+			vfs_cleanup_quota_inode(sb, cnt);
 	}
 
 	return ret;
-- 
2.25.1

