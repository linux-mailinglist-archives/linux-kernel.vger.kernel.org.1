Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B390F2423B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 03:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLBbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 21:31:38 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:22833 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgHLBbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:31:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BRBxf5HDxzL3;
        Wed, 12 Aug 2020 03:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597195894; bh=YXclyeSyXLSdf6lNZ+oLoeuAB1KLtKvoSXv0uKeOs4U=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Ps4gwAPh/rdn+LjBqBnE5LRq3z9zSpFNnkb2XLGQHOe8pJnNucSwLZsG3ZmkisZs3
         xhVEr0mzYs4oZpOyT/fB7yp4jfUZlmJM5bcywzJA+RuqdqKKLLJf0c37j1uLc8VRSc
         rWrIiomuPlQg7vK8bXHwrq66ielvnsHgVMdfWfHplU3xl3APO4Dj9lHDg6R5cyQ3g9
         KzCvSYJZuka1Ta/aZT8opUmpPaF+GvdXGWZ9iTZZqX72YRvFn+Dxa47ROK2z6CQwT0
         C8FxEAcm2HwnPDPK/DE/4gMTLmsiivz3zIDI4RYaBGf6Gb1QGjm8s6+yMea11cXnzS
         +KQ8R1S91fWiA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 12 Aug 2020 03:31:34 +0200
Message-Id: <1a889cf7f61c6429c9e6b34ddcdde99be77a26b6.1597195321.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/7] regulator: push allocation in
 regulator_init_coupling() outside of lock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating memory with regulator_list_mutex held makes lockdep unhappy
when memory pressure makes the system do fs_reclaim on eg. eMMC using
a regulator. Push the lock inside regulator_init_coupling() after the
allocation.

======================================================
WARNING: possible circular locking dependency detected
5.7.13+ #533 Not tainted
------------------------------------------------------
kswapd0/383 is trying to acquire lock:
cca78ca4 (&sbi->write_io[i][j].io_rwsem){++++}-{3:3}, at: __submit_merged_write_cond+0x104/0x154
but task is already holding lock:
c0e38518 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x50
which lock already depends on the new lock.
the existing dependency chain (in reverse order) is:
-> #2 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire.part.11+0x40/0x50
       fs_reclaim_acquire+0x24/0x28
       __kmalloc+0x54/0x218
       regulator_register+0x860/0x1584
       dummy_regulator_probe+0x60/0xa8
[...]
other info that might help us debug this:

Chain exists of:
  &sbi->write_io[i][j].io_rwsem --> regulator_list_mutex --> fs_reclaim

Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(regulator_list_mutex);
                               lock(fs_reclaim);
  lock(&sbi->write_io[i][j].io_rwsem);
 *** DEADLOCK ***

1 lock held by kswapd0/383:
 #0: c0e38518 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x50
[...]

Cc: stable@vger.kernel.org
Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0a32c3da0e26..510d234f6c46 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5010,7 +5010,10 @@ static int regulator_init_coupling(struct regulator_dev *rdev)
 	if (!of_check_coupling_data(rdev))
 		return -EPERM;
 
+	mutex_lock(&regulator_list_mutex);
 	rdev->coupling_desc.coupler = regulator_find_coupler(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
 	if (IS_ERR(rdev->coupling_desc.coupler)) {
 		err = PTR_ERR(rdev->coupling_desc.coupler);
 		rdev_err(rdev, "failed to get coupler: %d\n", err);
@@ -5218,9 +5221,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
-	mutex_lock(&regulator_list_mutex);
 	ret = regulator_init_coupling(rdev);
-	mutex_unlock(&regulator_list_mutex);
 	if (ret < 0)
 		goto wash;
 
-- 
2.20.1

