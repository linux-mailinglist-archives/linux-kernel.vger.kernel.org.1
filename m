Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B442AF14C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKKMzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:55:40 -0500
Received: from mx4.veeam.com ([104.41.138.86]:58290 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgKKMzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:55:39 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 1CA0992315;
        Wed, 11 Nov 2020 15:55:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1605099338; bh=yna0rBXA2H68/sU/8V5f7XYoZF8lEVzpFwICy49wNcY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=X2XlsmtiXjZftJZi1T+GYbBOmFE0b0WjTjMU+D6rNRhE9UON0TtRJc9ytQGZXiicP
         Yws58UjsyDzjg0luuzOjPIxUG13TCC8ZC2Z9XH4dbIQCn+8mIcAyQFYvw2oRbP/rSF
         Oqp7WkPAcW57lU7kfq6V2Eu/vKKebAUEpeNqVjdE=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 11 Nov 2020 13:55:36 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 1/1] Fix bug with RCU locking in dm_blk_report_zones().
Date:   Wed, 11 Nov 2020 15:55:46 +0300
Message-ID: <1605099346-3199-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605099346-3199-1-git-send-email-sergei.shtepa@veeam.com>
References: <1605099346-3199-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A617667
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dm_get_live_table() function makes RCU read lock and
dm_put_live_table() should call even when dm_table map was not found.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c18fc2548518..98866e725f25 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -476,8 +476,10 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 		return -EAGAIN;
 
 	map = dm_get_live_table(md, &srcu_idx);
-	if (!map)
-		return -EIO;
+	if (!map) {
+		ret = -EIO;
+		goto out;
+	}
 
 	do {
 		struct dm_target *tgt;
-- 
2.20.1

