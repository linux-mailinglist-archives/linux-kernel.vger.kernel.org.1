Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7AB1ED3E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 18:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFCQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 12:03:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57469 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCQDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:03:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jgVqw-0006Bm-JU; Wed, 03 Jun 2020 16:02:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dm zoned: fix memory leak of newly allocated zone on xa_insert failure
Date:   Wed,  3 Jun 2020 17:02:54 +0100
Message-Id: <20200603160254.142222-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if an xa_insert fails then there is a memory lead of the
recently allocated zone object. Fix this by kfree'ing zone before
returning on the error return path.

Addresses-Coverity: ("Resource leak")
Fixes: 1a311efa3916 ("dm zoned: convert to xarray")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/dm-zoned-metadata.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index b23ff090c056..130b5a6d9f12 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -313,8 +313,10 @@ static struct dm_zone *dmz_insert(struct dmz_metadata *zmd,
 	if (!zone)
 		return ERR_PTR(-ENOMEM);
 
-	if (xa_insert(&zmd->zones, zone_id, zone, GFP_KERNEL))
+	if (xa_insert(&zmd->zones, zone_id, zone, GFP_KERNEL)) {
+		kfree(zone);
 		return ERR_PTR(-EBUSY);
+	}
 
 	INIT_LIST_HEAD(&zone->link);
 	atomic_set(&zone->refcount, 0);
-- 
2.25.1

