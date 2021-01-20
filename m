Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964CC2FC72B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbhATBvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbhATBpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:45:31 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8040C0617BA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:43:52 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v5so15256153qtv.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=gtVV1RLA5pkMbs++lHYpXZ0/PDfEh7VnUfVKJcuY5Dhl5mSDXi4Y/mxZu9Y6hIhRJR
         6Ybt86scbNYwwi3KA9d0ujGb/2fRBo47rQP9Or00+srU2Lu5QmszZ2kOPmhoWcilnBfb
         KsNTtszCGK0wiZtDmiKb2kPQ1ztDwlU5WCBvGDPnpHmkTvi/h/ZeVj1TqxO2Qqtx6pnl
         hEmrqRqWPssiqbaV7RmmTp3kdE+jwVFL5gTfce47L5g+exIDhDJ++UCG9zTaD0eAz91U
         1C3p/SVD+VDDzUtmHf6ZL21ZVgw+etdvlgR48m5PiPeo2bGABW7vIoAUJP13XOXCQAqU
         Ie9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/iYHqVeCyWybAIwBASO/JRh5H6y4Wucaqn9XTIErdQ=;
        b=aIK/DtdXXGWXBs5PEZx8wS7Q9jTQU/SWqZdaZEjluSqkeT7yw5cIaqV+WnoLbVIAdE
         j/3cGdRuNytp1Jk0wjWlmBw/f9DqJIds6S8NesI2rOZy2+48mnzOUVgmjOh3K3I4u4DB
         opWa/7Hb5++DztbWQCbVa9WJPUracP4/vp2vsjtMIOZUbfoejKkKntOIjm0ArHjvzaWy
         iHLhTvmTV6WTZsV8PaH89rfPbLhHUMOPUpbOrmPcDj3Ha32ZjLcNBJ3Dk0GfHcYOJKDu
         aaTJVms9Stq0CTO5cuFd5SCZoyUDx0bJ6erMtrZ7+JK0UFR+7yAyc6BSjVATVr5tYcha
         g9EQ==
X-Gm-Message-State: AOAM532IUe9QvfS5TOynkLGottvAWz1IcXc1tdQDdPkHgnqX3/7JrUfc
        v+czZZfx8HzucAJsa/KSwPyr2Q==
X-Google-Smtp-Source: ABdhPJzZoj3kkb+0feMhS+Hy1p3TpCOsiJFH3TDyFeIe5U5x7wcScsQQrNMqjlM8A6ac43ALMO7nJA==
X-Received: by 2002:ac8:6b86:: with SMTP id z6mr7075854qts.26.1611107032150;
        Tue, 19 Jan 2021 17:43:52 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id a9sm391871qkk.39.2021.01.19.17.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:43:51 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 10/14] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Tue, 19 Jan 2021 20:43:29 -0500
Message-Id: <20210120014333.222547-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120014333.222547-1-pasha.tatashin@soleen.com>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the special handling of page pinning when ZONE_MOVABLE present.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
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

