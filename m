Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE362F2B30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392583AbhALJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:22:27 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:21771 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390850AbhALJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:22:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610443324; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=tmJ6Ka/918qUhfkQLgwGKMtGbWVEy2Qyn9+9KS0ZyOc=; b=Pxb1PuDAKa7EqgzgaizkT3ci6Q0/4F0kWR3Pc3fkRubKVqxx+Q1KSlKGhmfHPB/oRnkpppy8
 AY8P7J4Ld3InZ64emtMimWbkMK1nHTts3rdrXI33iQzMtM0d/fbYObAvrQVyJ305kdlyjE8V
 NM2eFwnIGi/SYXFXPjtkU3ohiGQ=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ffd6a22d84bad35475745cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Jan 2021 09:21:38
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3444EC433ED; Tue, 12 Jan 2021 09:21:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4451C433CA;
        Tue, 12 Jan 2021 09:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4451C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH] mm: slub: Convert sys slab alloc_calls, free_calls to bin attribute
Date:   Tue, 12 Jan 2021 14:51:27 +0530
Message-Id: <1610443287-23933-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the sys slab alloc_calls, free_calls returns the available object
owners, but the size of this file is limited to PAGE_SIZE
because of the limitation of sysfs attributes, it is returning the
partial owner info, which is not sufficient to debug/account the slab
memory and alloc_calls output is not matching with /proc/slabinfo.

To remove the PAGE_SIZE limitation converted the sys slab
alloc_calls, free_calls to bin attribute.

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
 mm/slub.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b52384e..8744e5ec 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4710,13 +4710,14 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 }
 
 static int list_locations(struct kmem_cache *s, char *buf,
-					enum track_item alloc)
+			loff_t offset, enum track_item alloc)
 {
 	int len = 0;
 	unsigned long i;
 	struct loc_track t = { 0, 0, NULL };
 	int node;
 	struct kmem_cache_node *n;
+	static unsigned int previous_read_count;
 	unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
 
 	if (!map || !alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
@@ -4742,11 +4743,9 @@ static int list_locations(struct kmem_cache *s, char *buf,
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
 
-	for (i = 0; i < t.count; i++) {
+	for (i = previous_read_count; i < t.count; i++) {
 		struct location *l = &t.loc[i];
 
-		if (len > PAGE_SIZE - KSYM_SYMBOL_LEN - 100)
-			break;
 		len += sprintf(buf + len, "%7ld ", l->count);
 
 		if (l->addr)
@@ -4784,12 +4783,20 @@ static int list_locations(struct kmem_cache *s, char *buf,
 					 nodemask_pr_args(&l->nodes));
 
 		len += sprintf(buf + len, "\n");
+
+		if (len > PAGE_SIZE - KSYM_SYMBOL_LEN - 100) {
+			previous_read_count = i + 1;
+			break;
+		}
 	}
 
+	if ((offset != 0) && ((i >= t.count) || (previous_read_count > t.count))) {
+		previous_read_count = 0;
+		len = 0;
+	} else if (!t.count)
+		len += sprintf(buf, "No data\n");
 	free_loc_track(&t);
 	bitmap_free(map);
-	if (!t.count)
-		len += sprintf(buf, "No data\n");
 	return len;
 }
 
@@ -5180,6 +5187,7 @@ static int any_slab_objects(struct kmem_cache *s)
 
 struct slab_attribute {
 	struct attribute attr;
+	struct bin_attribute bin_attr;
 	ssize_t (*show)(struct kmem_cache *s, char *buf);
 	ssize_t (*store)(struct kmem_cache *s, const char *x, size_t count);
 };
@@ -5192,6 +5200,12 @@ struct slab_attribute {
 	static struct slab_attribute _name##_attr =  \
 	__ATTR(_name, 0600, _name##_show, _name##_store)
 
+#define SLAB_BIN_ATTR_RO(_name) \
+	static struct slab_attribute _name##_attr = { \
+	.bin_attr = \
+	__BIN_ATTR_RO(_name, 0) \
+	} \
+
 static ssize_t slab_size_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%u\n", s->size);
@@ -5535,21 +5549,33 @@ static ssize_t validate_store(struct kmem_cache *s,
 }
 SLAB_ATTR(validate);
 
-static ssize_t alloc_calls_show(struct kmem_cache *s, char *buf)
+static ssize_t alloc_calls_read(struct file *filp, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *buf,
+					loff_t offset, size_t count)
 {
+	struct kmem_cache *s;
+
+	s = to_slab(kobj);
 	if (!(s->flags & SLAB_STORE_USER))
 		return -ENOSYS;
-	return list_locations(s, buf, TRACK_ALLOC);
+
+	return list_locations(s, buf, offset, TRACK_ALLOC);
 }
-SLAB_ATTR_RO(alloc_calls);
+SLAB_BIN_ATTR_RO(alloc_calls);
 
-static ssize_t free_calls_show(struct kmem_cache *s, char *buf)
+static ssize_t free_calls_read(struct file *filp, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *buf,
+					loff_t offset, size_t count)
 {
+	struct kmem_cache *s;
+
+	s = to_slab(kobj);
 	if (!(s->flags & SLAB_STORE_USER))
 		return -ENOSYS;
-	return list_locations(s, buf, TRACK_FREE);
+
+	return list_locations(s, buf, offset, TRACK_FREE);
 }
-SLAB_ATTR_RO(free_calls);
+SLAB_BIN_ATTR_RO(free_calls);
 #endif /* CONFIG_SLUB_DEBUG */
 
 #ifdef CONFIG_FAILSLAB
@@ -5694,6 +5720,14 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
 STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
 #endif	/* CONFIG_SLUB_STATS */
 
+
+static struct bin_attribute *slab_bin_attrs[] = {
+#ifdef CONFIG_SLUB_DEBUG
+	&alloc_calls_attr.bin_attr,
+	&free_calls_attr.bin_attr,
+#endif
+};
+
 static struct attribute *slab_attrs[] = {
 	&slab_size_attr.attr,
 	&object_size_attr.attr,
@@ -5722,8 +5756,6 @@ static struct attribute *slab_attrs[] = {
 	&poison_attr.attr,
 	&store_user_attr.attr,
 	&validate_attr.attr,
-	&alloc_calls_attr.attr,
-	&free_calls_attr.attr,
 #endif
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
@@ -5769,6 +5801,7 @@ static struct attribute *slab_attrs[] = {
 
 static const struct attribute_group slab_attr_group = {
 	.attrs = slab_attrs,
+	.bin_attrs = slab_bin_attrs,
 };
 
 static ssize_t slab_attr_show(struct kobject *kobj,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

