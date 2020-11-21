Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AAC2BBD1B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgKUEzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgKUEzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:55:31 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D806C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:55:31 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q5so11133631qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pl3i26dZKCO4ZlqiTecHj3kWUWBkOrjJfw37hSukKXY=;
        b=gJkFSQ6pB0E5gW9adpZm98U8X0fBKYTf1NPal0K4XCcdN3ITqQ/8YbWNAocj4h4/vC
         8xLH1celr2jep48NmQCTWgYr9PvUe1fiFYGSxIecGNJ3yGOnMQQCivrEQvD+KcoO+g6F
         fObfQpAr3xjM+JHvuVIVaouWwH0koWdWq+4uKAGQZWNYiJL5hTFyYOI7CzTG3/DT3Hha
         IYKBjQNw3Uemgko2blzL76r56/IUK6D4PCOGx2ld+beQKVn3WW5gjwaP9ipd1k37YQZ5
         G01Qw2Z7Y7709i3oeWz9HxJF8V0t6b8tP7lwG7m2CGTvY2UGARqzeR+FDVpBaj95u1fL
         8k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pl3i26dZKCO4ZlqiTecHj3kWUWBkOrjJfw37hSukKXY=;
        b=OFWv3SUIRB4gC+pB7OOkDXuz/NYc9fwaAL/ARCzampaLwWLD4sIbEoKkIeYnegTxdq
         Cirq/f+GEYkRVHvMnSBWye9V0PDrHkAbMCtxntZfuW7gmpfyXP19VzkwFchBE+DrP4Zn
         KanFy57qOaKyDAqdipUc4bxo7x/bzR4PecskfA0yM4pAOWZE+ZiamYq1h408NtHKImly
         jWz2UdHNAB21zapcrpTaUuOEHtQt+PamNvULOtUA8lkpldeAhTIf5/FmtnkOKECcSiwE
         Ck/VyfvQfBPoztWHDtWgxmdQCP4dTB73x7br3alxPvdwzMexBgzHNK1nxFjtvasxykdx
         oxoA==
X-Gm-Message-State: AOAM531qU7d4DleF9wllw9iLx6gMclxcud0dfSx+UWA2Ikid4OzFp1N5
        S0Mp3rshTr+ka2ilRZMjMKHHS6V+g9P0ew==
X-Google-Smtp-Source: ABdhPJyf7ovD+hgMuV9K6xbhsmpemqFHnC1PqWaMETOexqkEGgxNso6aKC/ckH/5blNFFwdZ0EKf3w==
X-Received: by 2002:a37:6cd:: with SMTP id 196mr19633793qkg.228.1605934530324;
        Fri, 20 Nov 2020 20:55:30 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:d86c:639e:b9b5:3fe])
        by smtp.googlemail.com with ESMTPSA id y44sm3905737qtb.50.2020.11.20.20.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 20:55:29 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Tong Zhang <ztong0001@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1] qnx6: avoid double release bh
Date:   Fri, 20 Nov 2020 23:55:16 -0500
Message-Id: <20201121045523.2692410-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set bh to NULL to avoid double release

[   38.848384] qnx6: superblock #1 active
[   38.855489] attempt to access beyond end of device
[   38.855489] sdb: rw=0, want=6359988796, limit=200000
[   38.855852] Buffer I/O error on dev sdb, logical block 3179994397, async page read
[   38.856327] attempt to access beyond end of device
[   38.856327] sdb: rw=0, want=1390132904, limit=200000
[   38.856513] Buffer I/O error on dev sdb, logical block 695066451, async page read
[   38.856800] attempt to access beyond end of device
[   38.856800] sdb: rw=0, want=1646095356, limit=200000
[   38.857059] Buffer I/O error on dev sdb, logical block 823047677, async page read
[   38.857339] attempt to access beyond end of device
[   38.857339] sdb: rw=0, want=2511434484, limit=200000
[   38.857504] Buffer I/O error on dev sdb, logical block 1255717241, async page read
[   38.857911] qnx6: major problem: unable to read inode from dev sdb
[   38.858318] qnx6: get inode failed
[   38.866847] ------------[ cut here ]------------
[   38.866992] VFS: brelse: Trying to free free buffer
[   38.867406] WARNING: CPU: 0 PID: 159 at fs/buffer.c:1177 __brelse+0x31/0x50
[   38.867576] Modules linked in:
[   38.867933] CPU: 0 PID: 159 Comm: mount Not tainted 5.10.0-rc4+ #97
[   38.868068] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-48-gd9c812d4
[   38.868408] RIP: 0010:__brelse+0x31/0x50
[   38.868562] Code: 00 00 00 53 48 89 fb 48 89 ef e8 ea 89 f8 ff 48 89 ef e8 c2 a6 f8 ff 8b 40
[   38.868877] RSP: 0018:ffff8880042a7b90 EFLAGS: 00000082
[   38.869119] RAX: 0000000000000000 RBX: ffff888002eeaa80 RCX: 0000000000000000
[   38.869286] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffed1000854f64
[   38.869419] RBP: ffff888002eeaae0 R08: 0000000000000000 R09: ffffed1000854f03
[   38.869553] R10: ffff8880042a7817 R11: ffffed1000854f02 R12: ffffffffa8b71460
[   38.869687] R13: 0000000000000000 R14: ffffffffa8b70a10 R15: 0000000000000000
[   38.869854] FS:  00007f2e41c2a6a0(0000) GS:ffff888016200000(0000) knlGS:0000000000000000
[   38.869996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.870103] CR2: 00000000004ad288 CR3: 00000000027ca000 CR4: 00000000000006f0
[   38.870281] Call Trace:
[   38.870572]  invalidate_bh_lru+0x2d/0x50
[   38.870702]  on_each_cpu_cond_mask+0x64/0x80
[   38.870808]  kill_bdev.isra.0+0x36/0x50
[   38.870904]  __blkdev_put+0x10d/0x370
[   38.871030]  ? freeze_bdev+0xf0/0xf0
[   38.871123]  ? _raw_read_lock_irq+0x30/0x30
[   38.871224]  ? mutex_unlock+0x18/0x40
[   38.871320]  deactivate_locked_super+0x50/0x90
[   38.871420]  mount_bdev+0x20f/0x220
[   38.871513]  ? qnx6_iget+0x460/0x460
[   38.871603]  ? qnx6_readpage+0x10/0x10
[   38.871694]  legacy_get_tree+0x6b/0xa0
[   38.871791]  vfs_get_tree+0x41/0x110
[   38.871887]  path_mount+0x3b3/0xd50
[   38.871984]  ? finish_automount+0x2b0/0x2b0
[   38.872085]  ? getname_flags+0x100/0x2a0
[   38.872182]  do_mount+0xc5/0xe0
[   38.872272]  ? path_mount+0xd50/0xd50
[   38.872366]  ? memdup_user+0x3c/0x80
[   38.872458]  __x64_sys_mount+0xb9/0xf0
[   38.872555]  do_syscall_64+0x33/0x40
[   38.872649]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   38.872823] RIP: 0033:0x7f2e41ba8515
[   38.873013] Code: b8 b0 00 00 00 0f 05 48 3d 00 f0 ff ff 76 10 48 8b 15 5f 79 06 00 f7 d8 63
[   38.873257] RSP: 002b:00007ffd2d0eaaf8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
[   38.873420] RAX: ffffffffffffffda RBX: 0000000000008001 RCX: 00007f2e41ba8515
[   38.873537] RDX: 00007ffd2d0ecf62 RSI: 00007ffd2d0ecf54 RDI: 00007ffd2d0ecf4b
[   38.873652] RBP: 00007ffd2d0eac80 R08: 0000000000000000 R09: 00007f2e41bf1480
[   38.873766] R10: 0000000000008001 R11: 0000000000000202 R12: 0000000000000000
[   38.873882] R13: 00007f2e41c2a690 R14: 0000000000000000 R15: 0000000000000000
[   38.874049] ---[ end trace cc983a0044562d15 ]---

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 fs/qnx6/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 61191f7bdf62..9fbe2b29bd9b 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -404,12 +404,14 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 		sbi->sb_buf = bh1;
 		sbi->sb = (struct qnx6_super_block *)bh1->b_data;
 		brelse(bh2);
+		bh2 = NULL;
 		pr_info("superblock #1 active\n");
 	} else {
 		/* superblock #2 active */
 		sbi->sb_buf = bh2;
 		sbi->sb = (struct qnx6_super_block *)bh2->b_data;
 		brelse(bh1);
+		bh1 = NULL;
 		pr_info("superblock #2 active\n");
 	}
 mmi_success:
-- 
2.25.1

