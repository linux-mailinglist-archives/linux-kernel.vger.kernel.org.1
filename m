Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10B26A1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgIOJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:12:08 -0400
Received: from sender4-pp-o92.zoho.com ([136.143.188.92]:25292 "EHLO
        sender4-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgIOJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:11:42 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2020 05:11:42 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1600160190; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eMbO2pHjtI2jdc3IgYfnlHBqeuY4BZXAIWULCYsX4Nm8Cd7TEjLFyAnbWdMGQ1aMOo9bCn90l+VZbpqiHq9r3JCKzqWZhbYlHKtp9981QcUYYqxtFuhLqxOwjjSapR05lzSiB/akhpWQklg1uPXebZJBlQSsMNYYMUcK4YmBdi4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1600160190; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=3A2E2L+s1qnKc7TfNg24hR6nLEiTzDfH/1rT4r/XVXk=; 
        b=Pf48RcKwlq8Sk8YyFd76/c9zSfc3lVm1ohL0fltZaV5+pUDQvKoRmjMuQK2+gxoFQTpAczaOAIceUO4Whx9AdS+zIvDnzeOluAm3u0g/7sPClgcL+Kh6RRiJEAcfmoU2nvx/Dst5o+G46wHm26QnU5EBFWUL5qlGSs5PWM7yfJU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=DvdrCa2LwGY4Hi7SqqGeqrpgUEhl0KpS+MRLlHqcdfTYtZl6IEwCGvuFR1PGw3xFEUF0ukUTwDb5
    XgANupyT7OMG2MwRxgQmaCJesfVcXjIBQJ5fraQPhGbbVUV2XSip  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1600160190;
        s=zm2020; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=3A2E2L+s1qnKc7TfNg24hR6nLEiTzDfH/1rT4r/XVXk=;
        b=oiUQAJ9q6p68bKTZY9BfTad3+MQvg5ELGy/jqKOHScobHWHg/3s1RoQZMmJKio3n
        ZM1r1bCQQ8WbFwTa8g0zqAlRbmeBMBgjyd2cwZsDFNzIF5QzIaGAtpRCwsofjRyCxOX
        nxNpm0LrPYdr/vcFp9Gn0Zc0U063G1Uc+DnlYK2w=
Received: from YEHS1XPF1D05WL.lenovo.com (60.247.104.78 [60.247.104.78]) by mx.zohomail.com
        with SMTPS id 1600160188862947.0236886693741; Tue, 15 Sep 2020 01:56:28 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     snitzer@redhat.com, agk@redhat.com
Cc:     tyu1@lenovo.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm thin metadata: Remove unused local variable when create thin and snap
Date:   Tue, 15 Sep 2020 16:56:08 +0800
Message-Id: <20200915085608.13776-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The local variable disk details is not used during the creating of thin & snap
devices. Remove them from dm-thin-metadata, and add pointer validity check for
pointer value in btree_lookup_raw. Skip memory copy when the caller doesn't need
the value.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-thin-metadata.c         | 6 ++----
 drivers/md/persistent-data/dm-btree.c | 3 ++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index b461836..6ebb212 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1051,12 +1051,11 @@ static int __create_thin(struct dm_pool_metadata *pmd,
 	int r;
 	dm_block_t dev_root;
 	uint64_t key = dev;
-	struct disk_device_details details_le;
 	struct dm_thin_device *td;
 	__le64 value;
 
 	r = dm_btree_lookup(&pmd->details_info, pmd->details_root,
-			    &key, &details_le);
+			    &key, NULL);
 	if (!r)
 		return -EEXIST;
 
@@ -1129,12 +1128,11 @@ static int __create_snap(struct dm_pool_metadata *pmd,
 	dm_block_t origin_root;
 	uint64_t key = origin, dev_key = dev;
 	struct dm_thin_device *td;
-	struct disk_device_details details_le;
 	__le64 value;
 
 	/* check this device is unused */
 	r = dm_btree_lookup(&pmd->details_info, pmd->details_root,
-			    &dev_key, &details_le);
+			    &dev_key, NULL);
 	if (!r)
 		return -EEXIST;
 
diff --git a/drivers/md/persistent-data/dm-btree.c b/drivers/md/persistent-data/dm-btree.c
index 8aae062..ef6e78d 100644
--- a/drivers/md/persistent-data/dm-btree.c
+++ b/drivers/md/persistent-data/dm-btree.c
@@ -366,7 +366,8 @@ static int btree_lookup_raw(struct ro_spine *s, dm_block_t block, uint64_t key,
 	} while (!(flags & LEAF_NODE));
 
 	*result_key = le64_to_cpu(ro_node(s)->keys[i]);
-	memcpy(v, value_ptr(ro_node(s), i), value_size);
+	if (v)
+		memcpy(v, value_ptr(ro_node(s), i), value_size);
 
 	return 0;
 }
-- 
1.8.3.1

