Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA09214DB4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 17:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgGEPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 11:47:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgGEPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:47:50 -0400
Date:   Sun, 05 Jul 2020 15:46:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593964069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DRB2pMLaXPlhgSpwFzYAKgzL8JjfxqYnPI2LiwmZh3o=;
        b=2nzMMeeQwWUolck/VuCz3OrQ+vhUMTiP6uAhoTkzqf/X60Xgg0DnPObJc5CpaBzhT2lIdW
        y393CYyTKWwVRbgF2/SlC7+quL+O0CCjDZikjd9BSVUnJS2InKuX2hNxyf/FmVJn35xsbu
        VFc1Is06fXMp/Dcb/7jBwVvzed2kLlF1YqWDOtJOWb0fK5ijk0+Zu59FC7UPJJvn5psts3
        K2p3zb0Fzf0vk/DQ5IY/jSdwbm6kwiaRYZYQab1gGHAVVRD8u2Cy+rPI47WensRUxKTZ6e
        AErWdqjKO0G1X9QKzMkdcXAnefsRwBmHmxy45PkDXXXBIB4OYh6fqJKRzXZk+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593964069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DRB2pMLaXPlhgSpwFzYAKgzL8JjfxqYnPI2LiwmZh3o=;
        b=8K3ycUSPIyOgXsGb1OZkFX3RA9zAtf/ahwJPrP3vIYfcsM3OLXLwjPoJqvusbNtvknmOGX
        Pcli7c3c8wbrAEDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for v5.8-rc4
Message-ID: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-07-05

up to:  5fdeefa053df: Merge branch 'urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/urgent

A single fix for a printk format warning in RCU.

Thanks,

	tglx

------------------>
Kefeng Wang (1):
      rcuperf: Fix printk format warning


 kernel/rcu/rcuperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 16dd1e6b7c09..9eb39c20082c 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -723,7 +723,7 @@ kfree_perf_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);

