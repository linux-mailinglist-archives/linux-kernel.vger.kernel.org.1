Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128032AC19F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgKIRAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbgKIRAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:00:14 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 692ED20789;
        Mon,  9 Nov 2020 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604941214;
        bh=e1fR8c3/u8ILpeETIXysn5Lg1umCymg7KmWhq+/rSak=;
        h=From:To:Cc:Subject:Date:From;
        b=kP5DkISnxV6x/qbDaYiMpCPbZTtX1cYBuTloAuAHYN0cKWH+492W5UCRq8ENlkNr3
         49ktkkiX8+QvRgbRi8zIBpxEJ+NAfzdFZA9BgT6zpzeVwRyyKk7vFi+8Wq7jzk3N22
         iHN7yeslNZv0kO/6KHWWyFgtWbChLvIEe7te+jdo=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Light Hsieh <Light.Hsieh@mediatek.com>
Subject: [PATCH] f2fs: avoid race condition for shinker count
Date:   Mon,  9 Nov 2020 09:00:12 -0800
Message-Id: <20201109170012.2129411-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
wrong do_shinker work. Basically the two counts should not happen like that.

So, I suspect this race condtion where:
- f2fs_try_to_free_nats            __flush_nat_entry_set
 nat_cnt=2, dirty_nat_cnt=2
                                   __clear_nat_cache_dirty
                                    spin_lock(nat_list_lock)
                                    list_move()
                                    spin_unlock(nat_list_lock)
 spin_lock(nat_list_lock)
 list_del()
 spin_unlock(nat_list_lock)
 nat_cnt=1, dirty_nat_cnt=2
                                   nat_cnt=1, dirty_nat_cnt=1

Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 42394de6c7eb..e8ec65e40f06 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -269,11 +269,10 @@ static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 {
 	spin_lock(&nm_i->nat_list_lock);
 	list_move_tail(&ne->list, &nm_i->nat_entries);
-	spin_unlock(&nm_i->nat_list_lock);
-
 	set_nat_flag(ne, IS_DIRTY, false);
 	set->entry_cnt--;
 	nm_i->dirty_nat_cnt--;
+	spin_unlock(&nm_i->nat_list_lock);
 }
 
 static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
-- 
2.29.2.222.g5d2a92d10f8-goog

