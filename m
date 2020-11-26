Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33FB2C51CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgKZKI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgKZKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606385335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1fw29BUC+iOD9ysD5cv7mr3mRRM27lwYqqofhsgmaRQ=;
        b=Bwy2dcKLtVcHccO5w8ErknzA9ZQ3oUXpNrLPZJx6SVZZFdjam2tLvtgipBrJesPYi2iBq1
        CvgbotdMEi4YgSYRy5HW9GI1it5hpQ3s5ol393/uqRdHsybgiuWVdqhAmHVvXrv4Jj5RHy
        +ljk6UPzGF9sk93SmPeYwmGg3e+P2T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-MPO8cTv_Pk2hTmNnQS1dow-1; Thu, 26 Nov 2020 05:08:53 -0500
X-MC-Unique: MPO8cTv_Pk2hTmNnQS1dow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E62948145E1;
        Thu, 26 Nov 2020 10:08:51 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-112-167.ams2.redhat.com [10.36.112.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92B985D9CA;
        Thu, 26 Nov 2020 10:08:50 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     christian.brauner@ubuntu.com, serge@hallyn.com,
        ebiederm@xmission.com
Subject: [PATCH] kernel: automatically split user namespace extent
Date:   Thu, 26 Nov 2020 11:08:39 +0100
Message-Id: <20201126100839.381415-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 kernel/user_namespace.c | 62 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 87804e0371fe..b5542be2bd0a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -706,6 +706,41 @@ const struct seq_operations proc_projid_seq_operations = {
 	.show = projid_m_show,
 };
 
+static void split_overlapping_mappings(struct uid_gid_map *parent_map,
+				       struct uid_gid_extent *extent,
+				       struct uid_gid_extent *overflow_extent)
+{
+	unsigned int idx;
+
+	overflow_extent->first = (u32) -1;
+
+	/* Split extent if it not fully contained in an extent from parent_map.  */
+	for (idx = 0; idx < parent_map->nr_extents; idx++) {
+		struct uid_gid_extent *prev;
+		u32 first, last, prev_last, size;
+
+		if (parent_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
+			prev = &parent_map->extent[idx];
+		else
+			prev = &parent_map->forward[idx];
+
+		first = extent->lower_first;
+		last = extent->lower_first + extent->count - 1;
+		prev_last = prev->first + prev->count - 1;
+
+		if ((first <= prev_last) && (last > prev_last)) {
+			size = prev_last - first + 1;
+
+			overflow_extent->first = extent->first + size;
+			overflow_extent->lower_first = extent->lower_first + size;
+			overflow_extent->count = extent->count - size;
+
+			extent->count = size;
+			return;
+		}
+	}
+}
+
 static bool mappings_overlap(struct uid_gid_map *new_map,
 			     struct uid_gid_extent *extent)
 {
@@ -852,6 +887,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	struct uid_gid_map new_map;
 	unsigned idx;
 	struct uid_gid_extent extent;
+	struct uid_gid_extent overflow_extent;
 	char *kbuf = NULL, *pos, *next_line;
 	ssize_t ret;
 
@@ -946,18 +982,24 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 		     extent.lower_first)
 			goto out;
 
-		/* Do the ranges in extent overlap any previous extents? */
-		if (mappings_overlap(&new_map, &extent))
-			goto out;
+		do {
+			/* Do the ranges in extent overlap any previous extents? */
+			if (mappings_overlap(&new_map, &extent))
+				goto out;
 
-		if ((new_map.nr_extents + 1) == UID_GID_MAP_MAX_EXTENTS &&
-		    (next_line != NULL))
-			goto out;
+			if ((new_map.nr_extents + 1) == UID_GID_MAP_MAX_EXTENTS &&
+			    (next_line != NULL))
+				goto out;
 
-		ret = insert_extent(&new_map, &extent);
-		if (ret < 0)
-			goto out;
-		ret = -EINVAL;
+			split_overlapping_mappings(parent_map, &extent, &overflow_extent);
+
+			ret = insert_extent(&new_map, &extent);
+			if (ret < 0)
+				goto out;
+			ret = -EINVAL;
+
+			extent = overflow_extent;
+		} while (overflow_extent.first != (u32) -1);
 	}
 	/* Be very certaint the new map actually exists */
 	if (new_map.nr_extents == 0)
-- 
2.28.0

