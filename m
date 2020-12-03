Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0FE2CD9C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbgLCPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387805AbgLCPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607007781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RMS24ZSS/X4LUxQFLWvQDNdo1y66WXc1l+McJVMCTIU=;
        b=BvA97Orc9w5wSe6Iiqf3rtaE02lvGWEFNd+WOCLhSucBRTE4y3Crs627nqiXUT0Eoa1g2K
        JlRCPOGN9tJBWA1pQ2K3tG3CPwvSaFYLxiclcexlgcEl+JVR9YLw86kIigqXc+h/3kvlA7
        mD/NJgtxcu3eE82Iy5/J1YPrisRADxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-T5NeAKMTN0m2p9iyhtBKNQ-1; Thu, 03 Dec 2020 10:03:00 -0500
X-MC-Unique: T5NeAKMTN0m2p9iyhtBKNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6CCC817B92;
        Thu,  3 Dec 2020 15:02:58 +0000 (UTC)
Received: from lithium.homenet.telecomitalia.it (ovpn-112-189.ams2.redhat.com [10.36.112.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A6896064B;
        Thu,  3 Dec 2020 15:02:57 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, christian.brauner@ubuntu.com,
        serge@hallyn.com
Subject: [PATCH v2] userns: automatically split user namespace extent
Date:   Thu,  3 Dec 2020 16:02:52 +0100
Message-Id: <20201203150252.1229077-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

writing to the id map fails when an extent overlaps multiple mappings
in the parent user namespace, e.g.:

$ cat /proc/self/uid_map
         0       1000          1
         1     100000      65536
$ unshare -U sleep 100 &
[1] 1029703
$ printf "0 0 100\n" | tee /proc/$!/uid_map
0 0 100
tee: /proc/1029703/uid_map: Operation not permitted

To prevent it from happening, automatically split an extent so that
each portion fits in one extent in the parent user namespace.

$ cat /proc/self/uid_map
         0       1000          1
         1     110000      65536
$ unshare -U sleep 100 &
[1] 1552
$ printf "0 0 100\n" | tee /proc/$!/uid_map
0 0 100
$ cat /proc/$!/uid_map
         0          0          1
         1          1         99

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
v2:
- move the split logic when the extent are mapped to the parent map to
  reduce lookup complexity.

v1: https://lkml.kernel.org/lkml/20201126100839.381415-1-gscrivan@redhat.com

 kernel/user_namespace.c | 79 +++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 87804e0371fe..550612c6e794 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -312,6 +312,55 @@ static u32 map_id_down(struct uid_gid_map *map, u32 id)
 	return map_id_range_down(map, id, 1);
 }
 
+/**
+ * find_and_split_extent_down - Find lower_first for the target extent
+ * using the specified map.
+ * If the extent doesn't fit in a single lower extent, split target and
+ * write the remaining IDs (first and count) to the overflow extent.
+ * If no overflow happens, overflow->count is set to 0.
+ */
+static int find_and_split_extent_down(struct uid_gid_map *map,
+				       struct uid_gid_extent *target,
+				       struct uid_gid_extent *overflow)
+{
+	unsigned int extents = map->nr_extents;
+	u32 lower_first = target->lower_first;
+	struct uid_gid_extent *extent;
+	u32 off, available;
+
+	overflow->count = 0;
+
+	/* Find the lower extent that includes the first ID.  */
+	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
+		extent = map_id_range_down_base(extents, map, lower_first, 1);
+	else
+		extent = map_id_range_down_max(extents, map, lower_first, 1);
+
+	/* Could not map the first ID in the extent.  */
+	if (extent == NULL)
+		return -EPERM;
+
+	/* Offset of lower_first in the lower extent.  */
+	off = target->lower_first - extent->first;
+
+	/* How many IDs are available in the lower extent?  */
+	available = extent->count - off;
+
+	/* Requesting more IDs than available in the lower extent.  */
+	if (target->count > available) {
+		/* Move the remaining IDs to the overflow extent.  */
+		overflow->first = target->first + available;
+		overflow->lower_first = target->lower_first + available;
+		overflow->count = target->count - available;
+
+		/* Shrink the initial extent to what is available.  */
+		target->count = available;
+	}
+
+	target->lower_first = extent->lower_first + off;
+	return 0;
+}
+
 /**
  * map_id_up_base - Find idmap via binary search in static extent array.
  * Can only be called if number of mappings is equal or less than
@@ -749,6 +798,7 @@ static bool mappings_overlap(struct uid_gid_map *new_map,
  * insert_extent - Safely insert a new idmap extent into struct uid_gid_map.
  * Takes care to allocate a 4K block of memory if the number of mappings exceeds
  * UID_GID_MAP_MAX_BASE_EXTENTS.
+ * The extent is appended at the position map->nr_extents.
  */
 static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
 {
@@ -968,30 +1018,37 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	if (!new_idmap_permitted(file, ns, cap_setid, &new_map))
 		goto out;
 
-	ret = -EPERM;
 	/* Map the lower ids from the parent user namespace to the
 	 * kernel global id space.
 	 */
 	for (idx = 0; idx < new_map.nr_extents; idx++) {
+		struct uid_gid_extent overflow;
 		struct uid_gid_extent *e;
-		u32 lower_first;
 
 		if (new_map.nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
 			e = &new_map.extent[idx];
 		else
 			e = &new_map.forward[idx];
 
-		lower_first = map_id_range_down(parent_map,
-						e->lower_first,
-						e->count);
-
-		/* Fail if we can not map the specified extent to
-		 * the kernel global id space.
-		 */
-		if (lower_first == (u32) -1)
+		ret = find_and_split_extent_down(parent_map, e, &overflow);
+		if (ret < 0)
 			goto out;
 
-		e->lower_first = lower_first;
+		/* If the extent doesn't fit in a single lower extent,
+		 * move what could not be mapped to a new extent.
+		 * The new extent is appended to the existing ones in
+		 * new_map, it will be checked again and if necessary it
+		 * is split further.
+		 */
+		if (overflow.count > 0) {
+			if (new_map.nr_extents == UID_GID_MAP_MAX_EXTENTS) {
+				ret = -EINVAL;
+				goto out;
+			}
+			ret = insert_extent(&new_map, &overflow);
+			if (ret < 0)
+				goto out;
+		}
 	}
 
 	/*
-- 
2.28.0

