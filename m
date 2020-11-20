Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4BC2BB840
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgKTVV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgKTVV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:21:27 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:21:27 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id l2so10391307qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jV6GL0Q5YRUAwzjPbGXYfFacZG8+1GCXNpjb7n5NcnY=;
        b=rNubP2BrxqlSe54C2d64q8xXgnsf5PRaEUIqT2SE3cN4oFfUkiYHPiiNhxJcTXEFxc
         CR5M8jXZ13zkbeFJmizi5rKqi7XOIPJC0bDJce/iPctmpjxVlOV0VwjeGNSuAwEE/32i
         AvXrl7gnFWgCmFQ0qXy59FqrHKrhwcGXmSmno2uon+R7ueStTU3FidoneLIEL3VdhdwR
         QgZvlWPX066I4CbV6sOLuqlwyBwGQ7VN5ZRfChH00ddqf9qJnsIw17PFpv3nV7LuL8tj
         A5aefh++p9knRPeT37hinyFowKGSxH4YiBJldA44FasWbd7M0HsVS1bf6efqoOYu07dz
         PX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jV6GL0Q5YRUAwzjPbGXYfFacZG8+1GCXNpjb7n5NcnY=;
        b=PJ5mDJurR99Ic+gneY9BgmOgJoOv/3L53Y6Os1m1nNMPkXxhlghHkP5iVxZuSAxVav
         wZcs5B26ljEfTfCKW7RfulGr874A7sTxyhiRYkv5qAxx/8pUhGSJqJQn5+u/2tFoedRC
         IyLMtKssrIABC/M8elFj7i7pCSllbLFIRffpTr+vGsiWrO/gEStsqCxzfBKOpyS1xLe1
         4j+zWZfYRZEtypPqIc45QoBL4J6mV1TbTg5d0SbKbWzKTV9XFDuWimupEAPhjg6iREqN
         6q1K3j7/Vw9qURHKAmdhNkLPYaygLok/9K2hi3DtOHUH8yFgWMeOt78j5QdtwYxB2dnC
         Ijyg==
X-Gm-Message-State: AOAM531/2ozmlXWDsteemd5xu+R/eDO4qbknqC8kRI+C756TpcrEld77
        vfZ1UnNNYuphmKXsR/6Qef6YW64hGPntww==
X-Google-Smtp-Source: ABdhPJzblAGFYHOWlQVd5BmEKVMX0l6E/MUu5mdr0aV07Rc6q/ebrM2Lx9SQmfxZsrMRjRfKEKIxXg==
X-Received: by 2002:a37:77c5:: with SMTP id s188mr19249059qkc.266.1605907285648;
        Fri, 20 Nov 2020 13:21:25 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:7d5d:36ba:87f1:dd85])
        by smtp.googlemail.com with ESMTPSA id 82sm2936014qke.76.2020.11.20.13.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:21:25 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH v1] qnx4_match: do not over run the buffer
Date:   Fri, 20 Nov 2020 16:21:20 -0500
Message-Id: <20201120212120.2502522-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the di_fname may not terminated by '\0', use strnlen to prevent buffer
overrun

[  513.248784] qnx4_readdir: bread failed (3718095557)
[  513.250880] ==================================================================
[  513.251109] BUG: KASAN: use-after-free in strlen+0x1f/0x40
[  513.251268] Read of size 1 at addr ffff888002700000 by task find/230
[  513.251419]
[  513.251677] CPU: 0 PID: 230 Comm: find Not tainted 5.10.0-rc4+ #64
[  513.251805] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-48-gd84
[  513.252069] Call Trace:
[  513.252310]  dump_stack+0x7d/0xa3
[  513.252443]  print_address_description.constprop.0+0x1e/0x220
[  513.252572]  ? _raw_spin_lock_irqsave+0x7b/0xd0
[  513.252681]  ? _raw_write_lock_irqsave+0xd0/0xd0
[  513.252785]  ? strlen+0x1f/0x40
[  513.252869]  ? strlen+0x1f/0x40
[  513.252955]  kasan_report.cold+0x37/0x7c
[  513.253059]  ? qnx4_block_map+0x130/0x1d0
[  513.253152]  ? strlen+0x1f/0x40
[  513.253237]  strlen+0x1f/0x40
[  513.253329]  qnx4_lookup+0xab/0x220
[  513.253431]  __lookup_slow+0x103/0x220
[  513.253531]  ? vfs_unlink+0x2e0/0x2e0
[  513.253626]  ? down_read+0xd8/0x190
[  513.253721]  ? down_write_killable+0x110/0x110
[  513.253823]  ? generic_permission+0x4c/0x240
[  513.253929]  walk_component+0x214/0x2c0
[  513.254035]  ? handle_dots.part.0+0x760/0x760
[  513.254137]  ? walk_component+0x2c0/0x2c0
[  513.254233]  ? path_init+0x546/0x6b0
[  513.254327]  ? __kernel_text_address+0x9/0x30
[  513.254430]  ? unwind_get_return_address+0x2a/0x40
[  513.254538]  ? create_prof_cpu_mask+0x20/0x20
[  513.254637]  ? arch_stack_walk+0x99/0xf0
[  513.254736]  path_lookupat.isra.0+0xb0/0x240
[  513.254840]  filename_lookup+0x128/0x250
[  513.254939]  ? may_linkat+0xb0/0xb0
[  513.255033]  ? __fput+0x199/0x3c0
[  513.255127]  ? kasan_save_stack+0x32/0x40
[  513.255224]  ? kasan_save_stack+0x1b/0x40
[  513.255323]  ? kasan_unpoison_shadow+0x33/0x40
[  513.255426]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
[  513.255538]  ? getname_flags+0x100/0x2a0
[  513.255635]  vfs_statx+0xd8/0x1d0
[  513.255728]  ? vfs_getattr+0x40/0x40
[  513.255821]  ? lockref_put_return+0xb2/0x120
[  513.255922]  __do_sys_newfstatat+0x7d/0xd0
[  513.256022]  ? __ia32_sys_newlstat+0x30/0x30
[  513.256122]  ? __kasan_slab_free+0x121/0x150
[  513.256222]  ? rcu_segcblist_enqueue+0x72/0x80
[  513.256333]  ? fpregs_assert_state_consistent+0x4d/0x60
[  513.256446]  ? exit_to_user_mode_prepare+0x2d/0xf0
[  513.256551]  ? __x64_sys_newfstatat+0x39/0x60
[  513.256651]  do_syscall_64+0x33/0x40
[  513.256750]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
---
 fs/qnx4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..c0e79094f578 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -40,7 +40,7 @@ static int qnx4_match(int len, const char *name,
 	} else {
 		namelen = QNX4_SHORT_NAME_MAX;
 	}
-	thislen = strlen( de->di_fname );
+	thislen = strnlen( de->di_fname, QNX4_SHORT_NAME_MAX );
 	if ( thislen > namelen )
 		thislen = namelen;
 	if (len != thislen) {
-- 
2.25.1

