Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13CC2D7FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392273AbgLKUYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394336AbgLKUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:23:07 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA2AC061257
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:21:53 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id d11so4811586qvo.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UPZkOOUAvu9r4fFw8TJVvFyTq3W2R2uLYiLCZknh/L8=;
        b=hVQRD1LlUsoJuOAc051CXjk2/dVUpiNlMuxbw4uUGEPOPZ3HmFNU0C98MsLBWna3fM
         p2zQdMiimm2nS4zvqoYJbPMy3rDxOJTx+XQe+y6m6d4mTjkKSUZjQirRZOm4isp54fjB
         X6CTaymXFF+7Ab3fjNVul9yMWMIr6kRN1WcvxhcDpRFriU2mnSogEiO/p7rHtb8o1e0Z
         L7tevjlfqdvtjcRWrrp6QhbaEbwsiOoN0WTHrj8A/pAGwo4Y1Q7ppmtkQ8u6+vB3antE
         r/eK9monwWuehW5yDmeo3LUI2/qDhI+A97EIyXjbpi78G47yubvPzdmnhSdSRYH6MhL7
         KBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPZkOOUAvu9r4fFw8TJVvFyTq3W2R2uLYiLCZknh/L8=;
        b=epTLdfILbpyV5Kocc/SkJXgvaI526iZ/yyeASqc2KGSDbsu6iCGzgH80k4ftmbYydx
         N78wH/Y5JOfToybuVdlSl0qZryo9T8MvK9q9MBuGEdR5Miu05CrkSThoYEI6KxLlLYmc
         kRegS4SAaGUHd2OUmL7OuCfodiKdTuJx+fmQXi4vH9z09wT05lD3khk/s1qsA/l7mhar
         uYiO//V+AtOIWPj75sGzR+ly5x5jXVnA6ktZRDxIVEzwrZDlgwfRjd4T57e5sB9WVqSm
         kAY2BYP/CqbDnPPPL6AK6+YoENB6J4CNWYTzF6rO3/IvRb30cbK0e9yS2OMwKAca+hJS
         7krg==
X-Gm-Message-State: AOAM53163TRapcuVK/43UUK6QuMO3VGcR5NV2QPjQ3vjk48K/77um1Lv
        bTmSX7j3Oq7w5ub4dxmCXeeQKw==
X-Google-Smtp-Source: ABdhPJzzBA0IO1zEvNvTSi56jO8MgXCjXqx/kMRSbq6P0sQl3EDuH9tzpjNq07vwblX5aH/exG15Yg==
X-Received: by 2002:a0c:f005:: with SMTP id z5mr18789770qvk.9.1607718112802;
        Fri, 11 Dec 2020 12:21:52 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y192sm8514455qkb.12.2020.12.11.12.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:21:52 -0800 (PST)
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
Subject: [PATCH v3 6/6] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Fri, 11 Dec 2020 15:21:40 -0500
Message-Id: <20201211202140.396852-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211202140.396852-1-pasha.tatashin@soleen.com>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
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

