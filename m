Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1352C2367
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgKXK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732356AbgKXK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606215521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=93iiWXlJJ6IXGgnGTBAqbCv2bSJUjXfqZiq9BMzLTt8=;
        b=U/is7sloglMBZMt3jdw1KgxWeNHZU3N8l+xPagEIp6xVArivT3+R7PlwZXDOSXAnNCkmGB
        NBSPkdZaPqLGS3R4eSru7DP69uQKNdKsqp0DN6XFmk5FIXYkQ5hZuzRh7H+1oBzlhJFffq
        XeWivHlDTIJCJCq0gzmVtQY3c1sjw1k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-yzR7MhEfNU6IMJbUFMW0uQ-1; Tue, 24 Nov 2020 05:58:39 -0500
X-MC-Unique: yzR7MhEfNU6IMJbUFMW0uQ-1
Received: by mail-wm1-f71.google.com with SMTP id y21so737113wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93iiWXlJJ6IXGgnGTBAqbCv2bSJUjXfqZiq9BMzLTt8=;
        b=QdYtlSmuvOlCiyMiMERFf6vATTGhwvyXCVEFePGJj9jgvV71YWaHYExYUW1PFXT29N
         rc9sBUp/W3Bkj9Rgk6GBhFL+B2aImbLL2VbSUpMvXl2z4Zrn8481uADj05lY0vt4hdEn
         5BwM5j1upA8PdoygjCs+GPxGl6crXdDm0DgmXYcJZUmpcUkTObosLm3tfHS3G7vJsjOs
         etaOu60hhvq7f4VpH3GCjawhf2KzD/PC65p+0OMuywa6Bg4Iw+3SyyM6Bl2JLK5XZhMZ
         fhQvfSbGBOCWgvbK/IW2xWOcJ/2iypeiYt4HEchtqegQbAY6RdyBMLtJgYIZars7ZRXZ
         H7+g==
X-Gm-Message-State: AOAM532ns+J1Cty/fBgO3WBa+SIZH/5JYz4fY2ziDLeR9mFKVu3H7e2J
        k+dJfQWjXMcsmz8aAoXuVpvOJT3GjIMc1ulpzuJGkLctLytZAnwxME5fJcxSLxCDJN56lqLyAim
        jnOoTQNERpoHTATj7frlr26zZBHU9pELlbv1lvua6J0ctS9xeaQAoxqoLmJp/w6yTKLVtYkrLZw
        ==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr4473679wre.383.1606215518066;
        Tue, 24 Nov 2020 02:58:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEy0NaSDK6xRfNiQMCFfdk60eQ8DmNfigWwS2jLBAhm8rLw3v70xbgbAFeeO+jjelCbnI1dg==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr4473660wre.383.1606215517859;
        Tue, 24 Nov 2020 02:58:37 -0800 (PST)
Received: from localhost (cpc111767-lutn13-2-0-cust344.9-3.cable.virginm.net. [86.5.41.89])
        by smtp.gmail.com with ESMTPSA id p4sm25611598wrm.51.2020.11.24.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:58:37 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] memcg: add support to generate the total count of children from root
Date:   Tue, 24 Nov 2020 10:58:36 +0000
Message-Id: <20201124105836.713371-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each memory-controlled cgroup is assigned a unique ID and the total
number of memory cgroups is limited to MEM_CGROUP_ID_MAX.

This patch provides the ability to determine the number of
memory cgroups from the root memory cgroup, only.
A value of 1 (i.e. self count) is returned if there are no children.
For example, the number of memory cgroups can be established by
reading the /sys/fs/cgroup/memory/memory.total_cnt file.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/memcontrol.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29459a6ce1c7..a4f7cb40e233 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4535,6 +4535,19 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+static int mem_cgroup_total_count_read(struct cgroup_subsys_state *css,
+				      struct cftype *cft)
+{
+	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(css);
+	int num = 0;
+
+	for_each_mem_cgroup_tree(iter, memcg)
+		num++;
+
+	/* Returns 1 (i.e. self count) if no children. */
+	return num;
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 #include <trace/events/writeback.h>
@@ -5050,6 +5063,11 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write_u64 = mem_cgroup_oom_control_write,
 		.private = MEMFILE_PRIVATE(_OOM_TYPE, OOM_CONTROL),
 	},
+	{
+		.name = "total_cnt",
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.read_u64 = mem_cgroup_total_count_read,
+	},
 	{
 		.name = "pressure_level",
 	},
-- 
2.26.2

