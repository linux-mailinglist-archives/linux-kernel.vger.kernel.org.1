Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E6D27975C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 08:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgIZGya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 02:54:30 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:19855 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 02:54:30 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 5B87B4E12DB;
        Sat, 26 Sep 2020 14:54:27 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] nvdimm: Use kobj_to_dev() API
Date:   Sat, 26 Sep 2020 14:54:17 +0800
Message-Id: <1601103260-10249-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0gaSktMGEofTEwfVkpNS0pKS0hJTUxNQ0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nk06HDo5ND8hCgEuS0kiGAIZ
        DQgaCzlVSlVKTUtKSktISU1DS0NLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJTkJCNwY+
X-HM-Tid: 0a74c93107179376kuws5b87b4e12db
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/nvdimm/namespace_devs.c | 2 +-
 drivers/nvdimm/region_devs.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 6da67f4..1d11ca7
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1623,7 +1623,7 @@ static struct attribute *nd_namespace_attributes[] = {
 static umode_t namespace_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 
 	if (a == &dev_attr_resource.attr && is_namespace_blk(dev))
 		return 0;
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119..92adfaf
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -644,7 +644,7 @@ static struct attribute *nd_region_attributes[] = {
 
 static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nd_region *nd_region = to_nd_region(dev);
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 	int type = nd_region_to_nstype(nd_region);
@@ -759,7 +759,7 @@ REGION_MAPPING(31);
 
 static umode_t mapping_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (n < nd_region->ndr_mappings)
-- 
2.7.4

