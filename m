Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F300275BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgIWPg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:36:57 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:44181 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600875416; x=1632411416;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=d7cW78cRcUoe0lcVnraOQZxIvx7qYL7x5nzIJpwTCig=;
  b=UNXkKr0DWHpL2A3cZMbwTMVF5VPXGriQLBNdBNeoUVlCrvDshrcEfmPc
   AnrHPMiw6WcXZYhnTsx2rLmvCcsc9hmbxNvDr+3ft5ZwvwquCu8ienC28
   JsxTks8lPELyCRdcGLMzGSLw4dmFnjpn6uR3jREkAeLvyNGS0jLJc88Xv
   U=;
X-IronPort-AV: E=Sophos;i="5.77,293,1596499200"; 
   d="scan'208";a="57257477"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Sep 2020 15:36:54 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 2682BA1C8A;
        Wed, 23 Sep 2020 15:36:53 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 23 Sep 2020 15:36:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <shakeelb@google.com>,
        <vdavydov@parallels.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] mm/page_idle: Avoid interferences from concurrent users
Date:   Wed, 23 Sep 2020 17:36:33 +0200
Message-ID: <20200923153633.21258-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D42UWB004.ant.amazon.com (10.43.161.99) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

The flexible interface of Idle Page Tracking can allow concurrent users
interfere each other.  They could implement their own use user space
synchronization, but applications developed by different users would not
know how to synchronize with other application.  To help this situation,
this commit introduces a centralized synchronization infrastructure for
Idle Page Tracking.

In detail, this commit introduces a mutex for Idle Page Tracking, which
exposed to user space via a new sysfs file, 'lock'.  By writing to and
reading from the file, users can acquire/release and read status of the
mutex.  While reads of the Idle Page Tracking 'bitmap' file can be done
regardless of the mutex status, writes to the file fails if the lock is
not held.

Note that users could still interfere each other if they do not respect
the locking rule.  Nevertheless, this will help them noticing the rule.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/page_idle.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 144fb4ed961d..0aa45f848570 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -16,6 +16,8 @@
 #define BITMAP_CHUNK_SIZE	sizeof(u64)
 #define BITMAP_CHUNK_BITS	(BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
 
+static DEFINE_MUTEX(page_idle_lock);
+
 /*
  * Idle page tracking only considers user memory pages, for other types of
  * pages the idle flag is always unset and an attempt to set it is silently
@@ -169,6 +171,9 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	unsigned long pfn, end_pfn;
 	int bit;
 
+	if (!mutex_is_locked(&page_idle_lock))
+		return -EPERM;
+
 	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
 		return -EINVAL;
 
@@ -197,17 +202,52 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	return (char *)in - buf;
 }
 
+static ssize_t page_idle_lock_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", mutex_is_locked(&page_idle_lock));
+}
+
+static ssize_t page_idle_lock_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	bool do_lock;
+	int ret;
+
+	ret = kstrtobool(buf, &do_lock);
+	if (ret < 0)
+		return ret;
+
+	if (do_lock) {
+		if (!mutex_trylock(&page_idle_lock))
+			return -EBUSY;
+	} else {
+		mutex_unlock(&page_idle_lock);
+	}
+
+	return count;
+}
+
 static struct bin_attribute page_idle_bitmap_attr =
 		__BIN_ATTR(bitmap, 0600,
 			   page_idle_bitmap_read, page_idle_bitmap_write, 0);
 
+static struct kobj_attribute page_idle_lock_attr =
+		__ATTR(lock, 0600, page_idle_lock_show, page_idle_lock_store);
+
 static struct bin_attribute *page_idle_bin_attrs[] = {
 	&page_idle_bitmap_attr,
 	NULL,
 };
 
+static struct attribute *page_idle_lock_attrs[] = {
+	&page_idle_lock_attr.attr,
+	NULL,
+};
+
 static const struct attribute_group page_idle_attr_group = {
 	.bin_attrs = page_idle_bin_attrs,
+	.attrs = page_idle_lock_attrs,
 	.name = "page_idle",
 };
 
-- 
2.17.1

