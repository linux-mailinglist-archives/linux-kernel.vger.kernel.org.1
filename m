Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7720F8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbgF3Pt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 11:49:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389599AbgF3Pt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:49:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A55FEAD63;
        Tue, 30 Jun 2020 15:49:26 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Michal Suchanek <msuchanek@suse.de>, linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Jakub Staron <jstaron@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dm writecache: reject asynchronous pmem.
Date:   Tue, 30 Jun 2020 17:49:24 +0200
Message-Id: <20200630154924.3283-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <alpine.LRH.2.02.2006301101210.24028@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2006301101210.24028@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 30505d70f423..5358894bb9fd 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2266,6 +2266,12 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 
 	if (WC_MODE_PMEM(wc)) {
+		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
+			r = -EOPNOTSUPP;
+			ti->error = "Asynchronous persistent memory not supported as pmem cache";
+			goto bad;
+		}
+
 		r = persistent_memory_claim(wc);
 		if (r) {
 			ti->error = "Unable to map persistent memory for cache";
-- 
2.26.2

