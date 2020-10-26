Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE9929909C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783241AbgJZPJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:09:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36638 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404121AbgJZPJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:09:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id r7so8610318qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4YqdmcMPdPqB+YkeBloGCTH3u/zuRKt+tiYUz7C5/o=;
        b=g/zZWuPnS+OmEZYZPeK7x/E1XnpeBd8aHCSmNuplXqKOeHLPvjwfi+12zzHL2Aqi5M
         dDD7RuRYlp2nN9TN+OGkKVwjalglB3HITHl3zRPK+XYLra2XlTiE/RW3IeDxcKtUid+z
         coHhSuM/hG03V986aNh9Br43qw+AYiFR02w9ARm1GX2OQEqCeeuMUd4R5uVZCc0r6OAO
         pRaUCg7DgKJx2T4ErtRy+7sVdeSAzknHXzy9B39/dYML6AyraL/KWUrtswqOZWWXg5Hj
         iQ/+SyJ7p+1jgcbZuChwq+SpohvRepcPU1oMFy7E752CzOH3PINHwoufFzgq6pXgenKQ
         i7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4YqdmcMPdPqB+YkeBloGCTH3u/zuRKt+tiYUz7C5/o=;
        b=JrBjU0XhwxS/OeGZ5rKxqRrpH8z7t9C7n8UvmTcN8zUSTMyBbdPMf4DeQf+EqONonU
         bU+3xVqAVo21R7GNGgp0TSw5CKzpgYOAcyceVfrhEopynL03JQbe6x5txiaoeAfJ4++e
         vyiFmChVI16LDo6Etuo5P9Yz76DVooGGqTonoMLCtGc/NWfXwat8za9RmRdKbYAbXP1f
         8XQcDERc8kgD/IcuxQ4/pZzQQzp3vwnN98oytVW4LMWmmwl8rbQIYrW5GcR+iaS+dgNO
         hUqlZDUwRd9xZUyVyCFvkvk7t4Uo/yDaVyrp6P8RB8uzG1WnXaeTqEdRKupq/OKc4Q5K
         cRpQ==
X-Gm-Message-State: AOAM531IVy3aQElgRwLROAR3uHtPhrG+HQkbloU7DkQlHyMjYN1bOaw9
        tDbC5orZjuZqAfMSej1JNAwPsL9ZoD4=
X-Google-Smtp-Source: ABdhPJzLcidrrwPSEFFtrqPErcXCKl4dl5hkj6tWupcOh6vVE2Bsnr2TtcOBHq6Sbo5rl2MeCO4NVg==
X-Received: by 2002:a05:620a:1014:: with SMTP id z20mr1320367qkj.409.1603724956386;
        Mon, 26 Oct 2020 08:09:16 -0700 (PDT)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id g24sm6518409qka.111.2020.10.26.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:09:15 -0700 (PDT)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, Willem de Bruijn <willemb@google.com>
Subject: [PATCH] x86/resctrl: Fix memory leak on kernfs dir removal
Date:   Mon, 26 Oct 2020 11:09:13 -0400
Message-Id: <20201026150913.2485171-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Resctrl takes an extra kernfs ref on directory entries, to access
the entry on cleanup in rdtgroup_kn_unlock after removing the entire
subtree with kfree_remove.

But the path takes an extra ref both on mkdir and on rmdir.

The kernfs_get on mkdir causes a memleak in the unlikely exit with
error in the same function, as no extra kernfs_put exists and no extra
rdtgroup_kn_unlock occurs.

More importantly, essentially the same happens in the normal path, as
this simple program demonstrates:

    for i in {1..200000}; do
      mkdir /sys/fs/resctrl/task1
      rmdir /sys/fs/resctrl/task1
    done
    slabtop

When taking an extra ref for the duration of kernfs_remove, it is
easiest to reason about when holding this extra ref as short as
possible. For that, the refcnt on error reason and free on umount
(rmdir_all_sub), remove the first kernfs_get on mkdir, leaving the
other on rmdir.

As the caller of rdtgroup_rmdir, kernfs_iop_rmdir, itself takes a
reference on the kernfs object, the extra reference is possibly not
needed at all.

Fixes: 60cf5e101fd4 ("x86/intel_rdt: Add mkdir to resctrl file system")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4d02ec8f371e..115a86bf6bd8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2839,14 +2839,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	}
 	rdtgrp->kn = kn;
 
-	/*
-	 * kernfs_remove() will drop the reference count on "kn" which
-	 * will free it. But we still need it to stick around for the
-	 * rdtgroup_kn_unlock(kn} call below. Take one extra reference
-	 * here, which will be dropped inside rdtgroup_kn_unlock().
-	 */
-	kernfs_get(kn);
-
 	ret = rdtgroup_kn_set_ugid(kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs perm error\n");
-- 
2.29.0.rc1.297.gfa9743e501-goog

