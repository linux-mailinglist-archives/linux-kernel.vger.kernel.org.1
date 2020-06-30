Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E620F7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbgF3Oxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 10:53:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389121AbgF3Oxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:53:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1713AAAC7;
        Tue, 30 Jun 2020 14:53:38 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Jakub Staron <jstaron@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dm writecache: reject asynchronous pmem.
Date:   Tue, 30 Jun 2020 16:53:35 +0200
Message-Id: <20200630145335.1185-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630133546.GA20439@redhat.com>
References: <20200630133546.GA20439@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The writecache driver does not handle asynchronous pmem. Reject it when
supplied as cache.

Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.com/
Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/md/dm-writecache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 30505d70f423..1e4f37249e28 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2271,6 +2271,12 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 			ti->error = "Unable to map persistent memory for cache";
 			goto bad;
 		}
+
+		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
+			r = -EOPNOTSUPP;
+			ti->error = "Asynchronous persistent memory not supported as pmem cache";
+			goto bad;
+		}
 	} else {
 		size_t n_blocks, n_metadata_blocks;
 		uint64_t n_bitmap_bits;
-- 
2.26.2

