Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B72271CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgIUIDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgIUIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:03:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B3C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:03:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gf14so6714648pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQ9zzgzZmaH7SVE72fu66K8V5NhJkHfIKNhfWRZkT70=;
        b=v4QQxqar9/gUAXuiOZ1QrCEiXJN++eMu4eslr0jnEjDgUQudhSX7PzLs1mguRYwEpD
         6nkSdkiD7br/G4EQ6WhJUlm1untmUXqZKp7Z+IW4wA4DcjThUG6nDSGQW5GCYsOKpdM6
         nyMrYP/Bmmcbm8dKzQ5Tdhf0HBdA+ZAG3QzTyMwSAttZZPkei/hd+/dqxACc4zUrAhUt
         1m1tdlhySvfBll7Cm8W0n1sayUPNVPERUYYlH+phSYii1EBT3u+mmQPonDxSC23sML3t
         DpuBxNMDBx0DT4Bdheea6pVTfRYo0Y9XBuid0omy8AHz2W/Pi9KrumKsLcVedd9Kl484
         m0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQ9zzgzZmaH7SVE72fu66K8V5NhJkHfIKNhfWRZkT70=;
        b=aA/0cc6GE/8940H85oLb19Q4JiivziaaEmJu3M6VbwEne0mSlnsCIsdZ9N4Nnbg9nL
         QJlFssG4otBUTQS8IXdIhiXvBHSw4TLbDOSRWefYXLu9ZdROWeaQvMs0kdLbr0NkJ3FK
         Y87xGr2t4Bj1N/PFVSEd3WKARWl+4m5Mbb6L9Y5Io3ZHIXu+OvgjoNHQ5p40kIYi0lap
         xfbD8hyKNEl9Vfli8gb2U5DTz0+IopiwAzwtPmNQTmi0My2AIoPgxMFEgV6FGDs9Xk7Y
         L2LvQcDfFGBQKoLMladVXisqsfm/exNXiuGBWaxX066wbJnRwyPuV0bWysG5F7ATKI2L
         7McA==
X-Gm-Message-State: AOAM530NSAf6CTIOubfJLsIIswejIuXnq8r1rMcLe7tDrmGEHi1hwdi4
        Nh5JwibgyqXgo9qBWH03wtTC4Q==
X-Google-Smtp-Source: ABdhPJykdY9XaYIuHd3HipxwMdwfsSeHmOqtcFUJirp24BFcbIXt+ifViiOUeeAn3CsKn35Wjkb3Ug==
X-Received: by 2002:a17:90a:d152:: with SMTP id t18mr22628479pjw.27.1600675387607;
        Mon, 21 Sep 2020 01:03:07 -0700 (PDT)
Received: from Zs-MacBook-Pro.local.net ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id s24sm9741972pjp.53.2020.09.21.01.02.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 01:03:06 -0700 (PDT)
From:   zangchunxin@bytedance.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, tj@kernel.org, lizefan@huawei.com,
        corbet@lwn.net
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Chunxin Zang <zangchunxin@bytedance.com>
Subject: [PATCH] mm/memcontrol: Add the drop_cache interface for cgroup v2
Date:   Mon, 21 Sep 2020 16:02:55 +0800
Message-Id: <20200921080255.15505-1-zangchunxin@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunxin Zang <zangchunxin@bytedance.com>

In the cgroup v1, we have 'force_mepty' interface. This is very
useful for userspace to actively release memory. But the cgroup
v2 does not.

This patch reuse cgroup v1's function, but have a new name for
the interface. Because I think 'drop_cache' may be is easier to
understand :)

Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 11 +++++++++++
 mm/memcontrol.c                         |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index ce3e05e41724..fbff959c8116 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1181,6 +1181,17 @@ PAGE_SIZE multiple when read back.
 	high limit is used and monitored properly, this limit's
 	utility is limited to providing the final safety net.
 
+  memory.drop_cache
+    A write-only single value file which exists on non-root
+    cgroups.
+
+    Provide a mechanism for users to actively trigger memory
+    reclaim. The cgroup will be reclaimed and as many pages
+    reclaimed as possible.
+
+    It will broke low boundary. Because it tries to reclaim the
+    memory many times, until the memory drops to a certain level.
+
   memory.oom.group
 	A read-write single value file which exists on non-root
 	cgroups.  The default value is "0".
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b38b6ad547d..98646484efff 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6226,6 +6226,11 @@ static struct cftype memory_files[] = {
 		.write = memory_max_write,
 	},
 	{
+		.name = "drop_cache",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.write = mem_cgroup_force_empty_write,
+	},
+	{
 		.name = "events",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.file_offset = offsetof(struct mem_cgroup, events_file),
-- 
2.11.0

