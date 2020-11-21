Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CBC2BBD6E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 06:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKUFfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 00:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgKUFfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 00:35:40 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D415C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 21:35:39 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id p12so3626514qvj.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 21:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rF9VUghuIEGUVLFdoxlsrpgWNWDg83rTnGzmNMA3U6c=;
        b=fuo6oOxLLey6jiBOax8kmDtm9tKrLXrvy1Gu88ByubEmk0hvKWyCpblFzuxmL5BJWu
         16M2wxFUDAZZen3WQc+c8B8p4SSFdRFRts8+C8aU8/lIRYK3NcqYnkEnufq8TpXLHbhN
         +dZD9hgvh715BDqeYUXcalfRlChVisFuL5EYazXlQ0NN+a2AdeGdqeNrSll9torPgS2p
         T5RxqlHfLXa0DM7u3EaLTWgNnDh1VNrUkhxWtzu/hcGoZXwXA7DnXQY5JwueZaCWKtmN
         hlx3IuJ5PyePTZ8nZRnFBMAi5W6MAsITmZi9grIe8SrFUjFt200SYzXgND1byYnd86vn
         8BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rF9VUghuIEGUVLFdoxlsrpgWNWDg83rTnGzmNMA3U6c=;
        b=HAekhgkH/rIVzYOTU5fKP+Cb/3qIHpOUYIqfnm1n3bvAlPIL67kIxE2GNbfmixcifU
         PDHSsiRufa0GkvJmjUGFvOuwPXtVkgT/JG6eE5T40dXMkcgskMhBntKxJfW5Z4JoSNU6
         fqJS/UEu8CuU1qZUjMVynR/9bnTL6UXomQs5rX2LKDNJvOiN4V6XgZLazGdWGUmxHj96
         Cj4WbhpT56Qomu1TIrF8urGbp1xV0UWgqpJYOxn9XAMlHpD6bOvyCjSt6OcwYD3p0Gq0
         Vc50Yns75gdrDlwMU7rf9BWk+3JGWLATm+TemYx7Bal6WBhqYSFy1/5HHX+hBx8HO8gW
         FtGw==
X-Gm-Message-State: AOAM531SamLu4Y7sF37z+tOpG3hKJaXVh4sujA7ysv3tucOaRjtoNby8
        IUI5MlbSXdmtn5qniBmJSyY=
X-Google-Smtp-Source: ABdhPJwxWk0LkSFwot1w9jEkIE3B67MCo0T0EsqdIY7b/zVUAEv+hKmwZQPB9vUZ4A3GJKOy8qb3dw==
X-Received: by 2002:ad4:5483:: with SMTP id q3mr19211773qvy.24.1605936938174;
        Fri, 20 Nov 2020 21:35:38 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:d86c:639e:b9b5:3fe])
        by smtp.googlemail.com with ESMTPSA id z6sm3323482qti.88.2020.11.20.21.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 21:35:37 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tong Zhang <ztong0001@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1] qnx6: check the sanity of root inode type
Date:   Sat, 21 Nov 2020 00:35:30 -0500
Message-Id: <20201121053531.2720404-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

root inode should be directory type

mount /dev/sdb /mnt
[   18.799875] qnx6: superblock #1 active
[   18.810693] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   18.810885] #PF: supervisor instruction fetch in kernel mode
[   18.810999] #PF: error_code(0x0010) - not-present page
[   18.811170] PGD 3b4c067 P4D 3b4c067 PUD 4213067 PMD 0
[   18.811522] Oops: 0010 [#1] SMP KASAN NOPTI
[   18.811754] CPU: 0 PID: 159 Comm: mount Not tainted 5.10.0-rc4+ #100
[   18.811880] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-48-gd9c812d4
[   18.812167] RIP: 0010:0x0
[   18.812354] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[   18.812491] RSP: 0018:ffff8880040afa28 EFLAGS: 00000246
[   18.812639] RAX: 0000000000000000 RBX: ffffffff838b78a0 RCX: ffffffff81a4d485
[   18.812777] RDX: dffffc0000000000 RSI: ffffea0000524900 RDI: 0000000000000000
[   18.812913] RBP: ffff8880040afcf0 R08: 0000000000000001 R09: fffff940000a4921
[   18.813050] R10: ffffea0000524907 R11: fffff940000a4920 R12: ffff888002fa87d0
[   18.813186] R13: ffff888003e4ff00 R14: ffff888002fa8668 R15: ffffea0000524900
[   18.813352] FS:  00007f2e4163f6a0(0000) GS:ffff88801aa00000(0000) knlGS:0000000000000000
[   18.813496] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.813606] CR2: ffffffffffffffd6 CR3: 0000000003e20000 CR4: 00000000000006f0
[   18.813798] Call Trace:
[   18.814090]  do_read_cache_page+0x856/0xb50
[   18.814234]  ? generic_file_read_iter+0x220/0x220
[   18.814343]  ? _raw_spin_lock+0x75/0xd0
[   18.814438]  ? _raw_read_lock_irq+0x30/0x30
[   18.814537]  ? _raw_spin_lock+0x75/0xd0
[   18.814636]  ? d_flags_for_inode+0x56/0xf0
[   18.814735]  ? __d_instantiate+0x169/0x190
[   18.814839]  qnx6_fill_super+0x369/0x630
[   18.814941]  ? qnx6_iget+0x460/0x460
[   18.815035]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[   18.815147]  ? sb_set_blocksize+0x3d/0x70
[   18.815259]  ? __asan_load1+0x70/0x70
[   18.815354]  mount_bdev+0x1d9/0x220
[   18.815448]  ? qnx6_iget+0x460/0x460
[   18.815541]  ? qnx6_readpage+0x10/0x10
[   18.815635]  legacy_get_tree+0x6b/0xa0
[   18.815739]  vfs_get_tree+0x41/0x110
[   18.815838]  path_mount+0x3b3/0xd50
[   18.815937]  ? finish_automount+0x2b0/0x2b0
[   18.816039]  ? getname_flags+0x100/0x2a0
[   18.816138]  do_mount+0xc5/0xe0
[   18.816226]  ? path_mount+0xd50/0xd50
[   18.816319]  ? memdup_user+0x3c/0x80
[   18.816413]  __x64_sys_mount+0xb9/0xf0
[   18.816511]  do_syscall_64+0x33/0x40
[   18.816607]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   18.816747] RIP: 0033:0x7f2e415bd515
[   18.816950] Code: b8 b0 00 00 00 0f 05 48 3d 00 f0 ff ff 76 10 48 8b 15 5f 79 06 00 f7 d8 63
[   18.817203] RSP: 002b:00007ffffb70a928 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[   18.817360] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 00007f2e415bd515
[   18.817478] RDX: 0000000000a0d690 RSI: 00007ffffb70bf62 RDI: 00007ffffb70bf59
[   18.817597] RBP: 00007ffffb70aab0 R08: 0000000000000000 R09: 0000000000000000
[   18.817715] R10: 0000000000008000 R11: 0000000000000206 R12: 0000000000000000
[   18.817831] R13: 00007f2e4163f690 R14: 00000000ffffffff R15: 0000000000a0d6f0
[   18.817998] Modules linked in:
[   18.818164] CR2: 0000000000000000
[   18.818738] ---[ end trace 254672b93198cc87 ]---
[   18.818866] RIP: 0010:0x0
[   18.818946] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[   18.819063] RSP: 0018:ffff8880040afa28 EFLAGS: 00000246
[   18.819180] RAX: 0000000000000000 RBX: ffffffff838b78a0 RCX: ffffffff81a4d485
[   18.819299] RDX: dffffc0000000000 RSI: ffffea0000524900 RDI: 0000000000000000
[   18.819418] RBP: ffff8880040afcf0 R08: 0000000000000001 R09: fffff940000a4921
[   18.819536] R10: ffffea0000524907 R11: fffff940000a4920 R12: ffff888002fa87d0
[   18.819768] R13: ffff888003e4ff00 R14: ffff888002fa8668 R15: ffffea0000524900
[   18.819895] FS:  00007f2e4163f6a0(0000) GS:ffff88801aa00000(0000) knlGS:0000000000000000
[   18.820024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.820125] CR2: ffffffffffffffd6 CR3: 0000000003e20000 CR4: 00000000000006f0
Killed

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 fs/qnx6/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 61191f7bdf62..26e0187ddfad 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -447,6 +447,11 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 		ret = PTR_ERR(root);
 		goto out2;
 	}
+	if (!S_ISDIR(root->i_mode)) {
+		pr_err("wrong root inode type\n");
+		ret = -EINVAL;
+		goto out2;
+	}
 
 	ret = -ENOMEM;
 	s->s_root = d_make_root(root);
-- 
2.25.1

