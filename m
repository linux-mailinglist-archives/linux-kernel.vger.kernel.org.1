Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF35A2DD8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgLQSyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731125AbgLQSyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:54:50 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB670C0619D5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 10:52:58 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z20so20838415qtq.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UPZkOOUAvu9r4fFw8TJVvFyTq3W2R2uLYiLCZknh/L8=;
        b=KOOeZ9F311HelPB+dQ5Jxny5X6SxXyAGd3KKlieuI07e2hBrEt3RVU31ycAHwlVbHk
         9xDQU/VkPBTvCiEIEwXb/bWvF/65bTrSG6bJ8OLDPC7HOLFiw2Zxhgxh1lQUOZstjQr5
         nRUsykwhnsyiNEFIUNNRo7b7/kpMfRm7u0PmxNIPeHyL3cIYKFOq6O1LUn+U1qjvzFWv
         X5iFlzbIPzQ0QqGcu5+7fx6GsqYERnYEyi6OW2FLKNTSVDyW7ZVZTxK7klRDMMSvU/21
         WRjhR/LtC6mtC0LKxI6t+b7bj0RvXcGvxCWK6d07QTYlzYVsAZs6bXx1yzp2DtAcp+N9
         dzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPZkOOUAvu9r4fFw8TJVvFyTq3W2R2uLYiLCZknh/L8=;
        b=SOMMXEMX7+uuwbMrv33/KudrSHQjBNDzMQwSpbAtoryLGHTHdE2TLfWrh0fizSVn+m
         wUfymJZE92eB4q6xO6PRiSnGiLUFaCvn0VVQI2kIXVuJV368TMtEpCVRqZ91Lj1mRM7V
         Q72kLxsTJv2m/Eu85cUovnkViPbMuFSXjYOzrToIEskU741thQ0MVLN1GGm2CueoVXbX
         M4webMlOKAbcwdry2fM/deDWTz3p8PK2afSEy+4L5j8yn0vVK4xVvODjWbWs0OkY98fj
         rvVuHP8a8Vn1oyB/BlD3RaXMylubzrTsFfmDPsLYe9z2KrWrH8RFiRJqzrAfVPx/KVEP
         J0kA==
X-Gm-Message-State: AOAM533QaWTgPuQp0AyWHtPmLjo0yZ9y/2Qh7qGQvD6RC1pGEClK5Km0
        9CtSuaWlbxh6NRJsESto9xWJBQ==
X-Google-Smtp-Source: ABdhPJyEyx1AuPMr4F/EQqqkrPpGXKufuGMVlxL61qVfUQnEvSqm6U4FlnMLVskQ6cx1G2kJJGaoEQ==
X-Received: by 2002:ac8:108c:: with SMTP id a12mr121263qtj.275.1608231178215;
        Thu, 17 Dec 2020 10:52:58 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m8sm4127434qkn.41.2020.12.17.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 10:52:57 -0800 (PST)
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
Subject: [PATCH v4 06/10] memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
Date:   Thu, 17 Dec 2020 13:52:39 -0500
Message-Id: <20201217185243.3288048-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
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

