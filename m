Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C724A2A6F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgKDUyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:54:38 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A030C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 12:54:36 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id i15so11176319qti.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 12:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1vvOIzzfmOs0O6boLgQK9QNpOZbt5lBlooJwBHQhT2U=;
        b=bvF6fIPUbNIKp5s4CtTfORtAp5l1OKNI4nKmWbsX6aWHKS6Yax7ujaaXtsdlJpo3Jf
         aqfy7yTTW5RAseOqz2BQr09o51I3eJzNB3gjQR6DBkxo+6a6l+A8+cf+/iRn0dcg18uG
         SiBUUVb60h8yvRCGiHgt3wce3p4SCvvpRITyCWnlklQ+MUvhvwoPcxpVXYZk/YiO5oHE
         4gmMrMJ/OXDyjsc4av62Onm9qD0hB3GjRn6F3ret02NwDHUbUR/1q5aunjP0R3V4RCOE
         MdzOdVlekLshx3xAbFSRlYzdKhNd5SMVy60PERKPxPa5+kA+9VBh0gq2xxPDn5kjpGGV
         M7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1vvOIzzfmOs0O6boLgQK9QNpOZbt5lBlooJwBHQhT2U=;
        b=kX6ZX9+aVPU4KTCDEkB2l+Zghh9hxX3dbEZWDU9G4hAg1ZvuCih2vGcLveTcgkACOa
         KRu2MyZzYFPy9Gr07Ue6ROqrIn47Kje07kxHQaIaaRMhkv+xfkOlVnTFoO5+Vsdb05j8
         RT4hAbzoHi3COCKJP6QlQkxttZHAtiOHANWmq633e4tzwurtdNcC3mRxJcqrfKvQevHl
         P/sdTiXKTzRveCdrzhnux2aqqGGI1IpyuhQdMzpWUaBKSRmuAUfQmxGuBTFqMoqQKiwy
         m49rj1/cBrDXRd0KMz1GFkYRlX+DGYOseB+KcJC95GsotSONdf9ak3gD6VWPofI1fi3g
         6VYQ==
X-Gm-Message-State: AOAM533cOgv1/kcRo0kn97tUSNfl+/MeHZN2y8az5pzEdW2n4yVlVcFG
        fKOWrfIr462fJtmGZGan3DF+3t013AaNrjY=
X-Google-Smtp-Source: ABdhPJymkmTSF+HbRfB0kB1CFQgNV32Z56346vaDarmeDSDCTjhVagDmiPFft1q3oP266O0KB74jlyQAQdzga40=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:9c47:: with SMTP id
 w7mr34820545qve.59.1604523275590; Wed, 04 Nov 2020 12:54:35 -0800 (PST)
Date:   Wed,  4 Nov 2020 12:54:30 -0800
Message-Id: <20201104205431.3795207-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 1/2] driver core: Fix lockdep warning on wfs_lock
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Cheng-Jui.Wang@mediatek.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a potential deadlock with the following cycle:
wfs_lock --> device_links_lock --> kn->count

Fix this by simply dropping the lock around a list_empty() check that's
just exported to a sysfs file. The sysfs file output is an instantaneous
check anyway and the lock doesn't really add any protection.

Lockdep log:

[   48.808132]
[   48.808132] the existing dependency chain (in reverse order) is:
[   48.809069]
[   48.809069] -> #2 (kn->count){++++}:
[   48.809707]        __kernfs_remove.llvm.7860393000964815146+0x2d4/0x460
[   48.810537]        kernfs_remove_by_name_ns+0x54/0x9c
[   48.811171]        sysfs_remove_file_ns+0x18/0x24
[   48.811762]        device_del+0x2b8/0x5a8
[   48.812269]        __device_link_del+0x98/0xb8
[   48.812829]        device_links_driver_bound+0x210/0x2d8
[   48.813496]        driver_bound+0x44/0xf8
[   48.814000]        really_probe+0x340/0x6e0
[   48.814526]        driver_probe_device+0xb8/0x100
[   48.815117]        device_driver_attach+0x78/0xb8
[   48.815708]        __driver_attach+0xe0/0x194
[   48.816255]        bus_for_each_dev+0xa8/0x11c
[   48.816816]        driver_attach+0x24/0x30
[   48.817331]        bus_add_driver+0x100/0x1e0
[   48.817880]        driver_register+0x78/0x114
[   48.818427]        __platform_driver_register+0x44/0x50
[   48.819089]        0xffffffdbb3227038
[   48.819551]        do_one_initcall+0xd8/0x1e0
[   48.820099]        do_init_module+0xd8/0x298
[   48.820636]        load_module+0x3afc/0x44c8
[   48.821173]        __arm64_sys_finit_module+0xbc/0xf0
[   48.821807]        el0_svc_common+0xbc/0x1d0
[   48.822344]        el0_svc_handler+0x74/0x98
[   48.822882]        el0_svc+0x8/0xc
[   48.823310]
[   48.823310] -> #1 (device_links_lock){+.+.}:
[   48.824036]        __mutex_lock_common+0xe0/0xe44
[   48.824626]        mutex_lock_nested+0x28/0x34
[   48.825185]        device_link_add+0xd4/0x4ec
[   48.825734]        of_link_to_suppliers+0x158/0x204
[   48.826347]        of_fwnode_add_links+0x50/0x64
[   48.826928]        device_link_add_missing_supplier_links+0x90/0x11c
[   48.827725]        fw_devlink_resume+0x58/0x130
[   48.828296]        of_platform_default_populate_init+0xb4/0xd0
[   48.829030]        do_one_initcall+0xd8/0x1e0
[   48.829578]        do_initcall_level+0xb8/0xcc
[   48.830137]        do_basic_setup+0x60/0x7c
[   48.830662]        kernel_init_freeable+0x128/0x1ac
[   48.831275]        kernel_init+0x18/0x29c
[   48.831781]        ret_from_fork+0x10/0x18
[   48.832297]
[   48.832297] -> #0 (wfs_lock){+.+.}:
[   48.832922]        __lock_acquire+0xe04/0x2e20
[   48.833480]        lock_acquire+0xbc/0xec
[   48.833984]        __mutex_lock_common+0xe0/0xe44
[   48.834577]        mutex_lock_nested+0x28/0x34
[   48.835136]        waiting_for_supplier_show+0x3c/0x98
[   48.835781]        dev_attr_show+0x48/0xb4
[   48.836295]        sysfs_kf_seq_show+0xe8/0x184
[   48.836864]        kernfs_seq_show+0x48/0x8c
[   48.837401]        seq_read+0x1c8/0x600
[   48.837884]        kernfs_fop_read+0x68/0x204
[   48.838431]        __vfs_read+0x60/0x214
[   48.838925]        vfs_read+0xbc/0x15c
[   48.839397]        ksys_read+0x78/0xe4
[   48.839869]        __arm64_sys_read+0x1c/0x28
[   48.840416]        el0_svc_common+0xbc/0x1d0
[   48.840953]        el0_svc_handler+0x74/0x98
[   48.841490]        el0_svc+0x8/0xc
[   48.841917]
[   48.841917] other info that might help us debug this:
[   48.841917]
[   48.842920] Chain exists of:
[   48.842920]   wfs_lock --> device_links_lock --> kn->count
[   48.842920]
[   48.844152]  Possible unsafe locking scenario:
[   48.844152]
[   48.844895]        CPU0                    CPU1
[   48.845463]        ----                    ----
[   48.846032]   lock(kn->count);
[   48.846417]                                lock(device_links_lock);
[   48.847203]                                lock(kn->count);
[   48.847902]   lock(wfs_lock);
[   48.848276]
[   48.848276]  *** DEADLOCK ***

Reported-by: Cheng-Jui.Wang@mediatek.com
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 78114ddac755..df35b3206286 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1064,10 +1064,8 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 	bool val;
 
 	device_lock(dev);
-	mutex_lock(&wfs_lock);
 	val = !list_empty(&dev->links.needs_suppliers)
 	      && dev->links.need_for_probe;
-	mutex_unlock(&wfs_lock);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
-- 
2.29.1.341.ge80a0c044ae-goog

