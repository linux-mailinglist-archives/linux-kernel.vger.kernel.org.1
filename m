Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C132EABD7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbhAENYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:24:41 -0500
Received: from mail-m964.mail.126.com ([123.126.96.4]:35110 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbhAENYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=T+42eSMeQ3OnSshI7/
        Fx8CEe5Izt6Qd68TedrfZ4bjo=; b=Tjualv3bJZrImwxvX+zFzSGA2MJajt/BLN
        EJYS8AtnK4ric4gP31uoSMEXEmyduAuwX2nduSyszzzh4JaIVdbcd0UpqfkGK/aS
        C8kKJqoXH98DGlmbm30/NgIwI8/m3/hf1xwrV0/5TmERHZLCu+tAMGek0uwgD2hI
        czrbTBXsA=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp9 (Coremail) with SMTP id NeRpCgDXnn45aPRfSqJAQg--.24935S2;
        Tue, 05 Jan 2021 21:23:06 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.or, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH v3] fs/btrfs: avoid null pointer dereference if reloc control has not been initialized
Date:   Tue,  5 Jan 2021 21:22:58 +0800
Message-Id: <1609852978-2463334-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NeRpCgDXnn45aPRfSqJAQg--.24935S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3Xr1xXrW8Jr4rXF1UWrg_yoW8Gw45pr
        43u3WFgF4kJw17Gr4Fka1kCry3Wa1qgryxJwsIvw4xAw1fAF1Sq3yjkF48urW7AFZ8Kw47
        Xr4Dt3yUA3WUAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMKZZUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbi6xoR11pD9edIFwAAsj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commmit<389305b2aa68>("btrfs: relocation: Only remove reloc rb_trees if
reloc control has been initialized"). It turns out that fs_info::reloc_ctl can be NULL
in btrfs_recover_relocation(), as we allocate relocation control after all reloc roots
have been verified,so there should be a check for rc to prevent null pointer dereference.

......
Signed-off-by: Defang Bo <bodefang@126.com>
---
Changes since v2:
- Resend this patch with manual reformatted.

Changes singe v1:
- More accurate description for this patch to describe how the NULL can get there.
---
......
---
 fs/btrfs/relocation.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3602806d71bd..ca035712e08b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -626,6 +626,9 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 	struct mapping_node *node;
 	struct reloc_control *rc = fs_info->reloc_ctl;
 
+	if (!rc)
+		return 0;
+
 	node = kmalloc(sizeof(*node), GFP_NOFS);
 	if (!node)
 		return -ENOMEM;
@@ -703,6 +706,9 @@ static int __update_reloc_root(struct btrfs_root *root)
 	struct rb_node *rb_node;
 	struct mapping_node *node = NULL;
 	struct reloc_control *rc = fs_info->reloc_ctl;
+
+	if (!rc)
+		return 0;
 
 	spin_lock(&rc->reloc_root_tree.lock);
 	rb_node = rb_simple_search(&rc->reloc_root_tree.rb_root,
-- 
2.7.4

