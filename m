Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03B127788C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgIXSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgIXSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:36:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A7C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:36:24 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m186so262844qkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=GxPNgGvwsOnFJjhIJe4QrNTcXrcLNVDWnH8/zibnRfA=;
        b=KPsaQFUcWRvjktaPfcIk4WQmXAwqL/XLs0VDnqmwRRTTRggs2Wu0jaT1HwiEnpeDjz
         3oCQ340+q993yTlP30lMWJWLNd38Ko3x6e4X4fWmMMsZ2z2p+d8O+rJlfi3yTBun5thv
         0PXar/A0eHYnqcM5T8PbI469E+SYxgxNQWVaMuz82I4j4NAGglMbXoaQUIZEtCaD020M
         Nv4cjvmoLdov7cMMje7Iw6juaEIEFBTo6C3dTd4Luuot9STTAMvFVt57zG5tsYDFXqCC
         jMMqURqxtakTg/5ItosYAxVuiqvuHKrV/SYdsBICx8vKTsEOka/jVlx+p3fJfmTMWB69
         k1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=GxPNgGvwsOnFJjhIJe4QrNTcXrcLNVDWnH8/zibnRfA=;
        b=SQWNSPFigQ26gXfanBHj6JF1LOaTRcCyK1wDUCjtnIg4R3UyCdXb90m0wB1eJpBoFE
         BxjT5MF5zdo8Jq1OwyF+BLm+AqazHD9G/+0G/2kHB9vFAluij0yx4Vl/9Jx2t/llp9SU
         dnvQ66++YnMkWjmS2uKwiN9r3WteEKAauMEf/PQCaQLN0spAUMi8myGSv3Eka1DEN2rN
         K3z3fH9SegKeJtWmxtt3b+n4RgSwsj57gJ6kANA0ZaYGdNDbuLz4DNdAO1Sd9vHWWcwh
         06fxCqwzoUQm48kIA3Gpti9uXNDU3JV+9yR/vd72tjoxrWLXdcN6wkQe5Sb3z9kU7Uac
         xTIw==
X-Gm-Message-State: AOAM530r6ijpuvxGhiaZBt8BDki5iD0PXOtLqpcc319+dFI9LvjI1BaO
        rx295Ou+X0ctH/6GdKdZzBrsXt8+l3kNng==
X-Google-Smtp-Source: ABdhPJxjuu3/L6QmNYa26NmbH/xV6O7hb+4s68Cp0uXVeSi2WeSvlrWjaYVg9GyRfiKSLxlhMaF7R91S+a/fUA==
Sender: "edumazet via sendgmr" <edumazet@edumazet1.svl.corp.google.com>
X-Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:7220:84ff:fe09:1424])
 (user=edumazet job=sendgmr) by 2002:ad4:4527:: with SMTP id
 l7mr513757qvu.2.1600972583105; Thu, 24 Sep 2020 11:36:23 -0700 (PDT)
Date:   Thu, 24 Sep 2020 11:36:19 -0700
Message-Id: <20200924183619.4176790-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH] quota: clear padding in v2r1_mem2diskdqb()
From:   Eric Dumazet <edumazet@google.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freshly allocated memory contains garbage, better make sure
to init all struct v2r1_disk_dqblk fields to avoid KMSAN report:

BUG: KMSAN: uninit-value in qtree_entry_unused+0x137/0x1b0 fs/quota/quota_tree.c:218
CPU: 0 PID: 23373 Comm: syz-executor.1 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
 qtree_entry_unused+0x137/0x1b0 fs/quota/quota_tree.c:218
 v2r1_mem2diskdqb+0x43d/0x710 fs/quota/quota_v2.c:285
 qtree_write_dquot+0x226/0x870 fs/quota/quota_tree.c:394
 v2_write_dquot+0x1ad/0x280 fs/quota/quota_v2.c:333
 dquot_commit+0x4af/0x600 fs/quota/dquot.c:482
 ext4_write_dquot fs/ext4/super.c:5934 [inline]
 ext4_mark_dquot_dirty+0x4d8/0x6a0 fs/ext4/super.c:5985
 mark_dquot_dirty fs/quota/dquot.c:347 [inline]
 mark_all_dquot_dirty fs/quota/dquot.c:385 [inline]
 dquot_alloc_inode+0xc05/0x12b0 fs/quota/dquot.c:1755
 __ext4_new_inode+0x8204/0x9d70 fs/ext4/ialloc.c:1155
 ext4_tmpfile+0x41a/0x850 fs/ext4/namei.c:2686
 vfs_tmpfile+0x2a2/0x570 fs/namei.c:3283
 do_tmpfile fs/namei.c:3316 [inline]
 path_openat+0x4035/0x6a90 fs/namei.c:3359
 do_filp_open+0x2b8/0x710 fs/namei.c:3395
 do_sys_openat2+0xa88/0x1140 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_compat_sys_openat fs/open.c:1242 [inline]
 __se_compat_sys_openat+0x2a4/0x310 fs/open.c:1240
 __ia32_compat_sys_openat+0x56/0x70 fs/open.c:1240
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7ff4549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f55cd0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000020000000
RDX: 0000000000410481 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:143 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:126
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2907 [inline]
 slab_alloc mm/slub.c:2916 [inline]
 __kmalloc+0x2bb/0x4b0 mm/slub.c:3982
 kmalloc include/linux/slab.h:559 [inline]
 getdqbuf+0x56/0x150 fs/quota/quota_tree.c:52
 qtree_write_dquot+0xf2/0x870 fs/quota/quota_tree.c:378
 v2_write_dquot+0x1ad/0x280 fs/quota/quota_v2.c:333
 dquot_commit+0x4af/0x600 fs/quota/dquot.c:482
 ext4_write_dquot fs/ext4/super.c:5934 [inline]
 ext4_mark_dquot_dirty+0x4d8/0x6a0 fs/ext4/super.c:5985
 mark_dquot_dirty fs/quota/dquot.c:347 [inline]
 mark_all_dquot_dirty fs/quota/dquot.c:385 [inline]
 dquot_alloc_inode+0xc05/0x12b0 fs/quota/dquot.c:1755
 __ext4_new_inode+0x8204/0x9d70 fs/ext4/ialloc.c:1155
 ext4_tmpfile+0x41a/0x850 fs/ext4/namei.c:2686
 vfs_tmpfile+0x2a2/0x570 fs/namei.c:3283
 do_tmpfile fs/namei.c:3316 [inline]
 path_openat+0x4035/0x6a90 fs/namei.c:3359
 do_filp_open+0x2b8/0x710 fs/namei.c:3395
 do_sys_openat2+0xa88/0x1140 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_compat_sys_openat fs/open.c:1242 [inline]
 __se_compat_sys_openat+0x2a4/0x310 fs/open.c:1240
 __ia32_compat_sys_openat+0x56/0x70 fs/open.c:1240
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Fixes: 498c60153ebb ("quota: Implement quota format with 64-bit space and inode limits")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jan Kara <jack@suse.com>
---
 fs/quota/quota_v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index 58fc2a7c7fd19f0be265e8189e476782571cbcfe..e69a2bfdd81c050c1ff2653528f803bd402fb399 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -282,6 +282,7 @@ static void v2r1_mem2diskdqb(void *dp, struct dquot *dquot)
 	d->dqb_curspace = cpu_to_le64(m->dqb_curspace);
 	d->dqb_btime = cpu_to_le64(m->dqb_btime);
 	d->dqb_id = cpu_to_le32(from_kqid(&init_user_ns, dquot->dq_id));
+	d->dqb_pad = 0;
 	if (qtree_entry_unused(info, dp))
 		d->dqb_itime = cpu_to_le64(1);
 }
-- 
2.28.0.681.g6f77f65b4e-goog

