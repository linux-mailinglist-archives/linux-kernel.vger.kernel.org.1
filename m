Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21282D4FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgLJAot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgLJAol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:44:41 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA61C0619D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:43:52 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id j26so2371941qtq.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UPZkOOUAvu9r4fFw8TJVvFyTq3W2R2uLYiLCZknh/L8=;
        b=gmG1PpUsZr319a18DQnsi5mdG9y7b4t3RB3P2dechoWxY0Pqz2thym4xN5wIfRn1Q4
         Zw9W5/aK+5TRDcVJVOMsS3Z7f6GudDVH/eYCeIsLxu2o7Nz/4p5Jq2Xwp9inOrxmnVbj
         TZ5uXsD53+Jo8U+FDbuIB2tFD7HRqp6p1YLX1q9RSiMRN5Ve4xVGdG1V1CVxDuWmvHAD
         DKVaKsSrifnIeiLiCFQ/h9cVe692qD+IpTCv1Op5j3vHfvwaFgL79HDGLo7U9H3XQBGe
         Jyv8Gp8SjDOE/7SKS3q5y5zA06EMAGJWPiX/hVHPL34ak1030j7gSBQyY5EfC3ZrlbfP
         8M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPZkOOUAvu9r4fFw8TJVvFyTq3W2R2uLYiLCZknh/L8=;
        b=eUw5o52ohz4a5dTc2AlijIoUZXNvzohuvUTIExo8AUfNrcTClDSdFZ0l9FmA761/qe
         iXoJTWh7BsdbqSRHDcXzGW5dshPEFR48rJtzrf84vcyYTR0ymJddclE8WnrnJ8RwtMKJ
         tAg8mY/4e5WiMDAO1ZQDRN9Dm+S3jnTPDj8sPcpc6u01b+fxLIdZEoyahMtdjamYVpav
         IzLFrImQdD+Bbgk7+CmyJadT0DAZoC11BcLtnf/ERqjSHku5X+7BY/EOFi70TtV8dB9K
         M/qeuHMQy3D361xJ2WvTtU31YphE39YZyRyqscrHkLNYaknURDKhEfE1YO1JYZucvppG
         BgBA==
X-Gm-Message-State: AOAM533xeZNrtHstcWGERYK2POZpCu+p6SsBE6Ndl6XAqLxZ2PZB5COi
        1rk677r+MPOIsLAI06O8y6Y1mw==
X-Google-Smtp-Source: ABdhPJyi0mwWQZy/L/JfYf+2tJkJILrpi7wkAfm++gQ2t5NF/5F1UStDpyKxp6YmK/amRq2h1MKphA==
X-Received: by 2002:ac8:7244:: with SMTP id l4mr5870164qtp.203.1607561031637;
        Wed, 09 Dec 2020 16:43:51 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y1sm2538745qky.63.2020.12.09.16.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:43:51 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 8/8] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Wed,  9 Dec 2020 19:43:35 -0500
Message-Id: <20201210004335.64634-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210004335.64634-1-pasha.tatashin@soleen.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the special handling of page pinning when ZONE_MOVABLE present.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/memory-hotplug.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 5c4432c96c4b..c6618f99f765 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -357,6 +357,15 @@ creates ZONE_MOVABLE as following.
    Unfortunately, there is no information to show which memory block belongs
    to ZONE_MOVABLE. This is TBD.
 
+.. note::
+   Techniques that rely on long-term pinnings of memory (especially, RDMA and
+   vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
+   hot remove. Pinned pages cannot reside on ZONE_MOVABLE, to guarantee that
+   memory can still get hot removed - be aware that pinning can fail even if
+   there is plenty of free memory in ZONE_MOVABLE. In addition, using
+   ZONE_MOVABLE might make page pinning more expensive, because pages have to be
+   migrated off that zone first.
+
 .. _memory_hotplug_how_to_offline_memory:
 
 How to offline memory
-- 
2.25.1

