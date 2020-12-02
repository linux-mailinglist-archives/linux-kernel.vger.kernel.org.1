Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F062CB47D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgLBFYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgLBFYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:24:17 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A35BC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:23:37 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id o8so692006ioh.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=trxUS4hTsq7Vgn0OaEdGU2Oamf0jSdRBNQtCZpSo+v4=;
        b=dpF7Ja/wYE+ogPzGSNyV+WbT29ucR4KcbNWmSptBcV9kXTAN4dVUUACorYiyR+EX33
         6J9k9N+pATTjMFVtECRNH8htHRIQFTIH7WA3hKIS+jCvV59iC6M+5cj0c6YPGnaiL0XL
         7OjRq6g4vcsQFkJjtku5SlbDIMF08JSxkvPagRMv6EpnGPuN6wBWjt/8YtwzGWscTlSn
         HzW88rVcNP54tJxXahg8pJ2ujf/Htag82Qohw0RkcLxKCNMCc1jBLC6Tvg7LDnk1P3CL
         piWlohaWnneDLnt8R1fXI0iNc0N2RRoxQW5DGW055OZ/P540ruDVY0+6ehybpETzlXmV
         clVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trxUS4hTsq7Vgn0OaEdGU2Oamf0jSdRBNQtCZpSo+v4=;
        b=haHNdxbToAEby3S06xS5WEE9uZSPx5/bf6twsAaAIFDwZvRrC8cBwhylcQix28fUMb
         zm7nRHw2maQiF1Ge9YJO/fa+eNJe62v3JWo4nUhqHqRCjGSY13mjRPSx5BkePD0L0sQU
         jYahjtUzRik7jKqoW1ZvoIKfTWpHtsTwmyNb6cQKaB9QATV5iF7d9dB+cKpPSXFZ4WBF
         Yk/c9h7kRFx7z/SVWxiDikhFxUbKiHXEbGfBa2nwKGngkNiwlsO6l4HP8BEMqsCs+kZa
         HjklSLJw4ef1fLap7XDis8mnV90JhAoXe30l0oFanflY+mUiub9r7zFhI21yGXm6EFgG
         Z69Q==
X-Gm-Message-State: AOAM533HUMzDiziyrJXydafPkHoSWatyFJbGWiwP1g5rojY4a9gzVgqR
        AXhhh+/AgfflIxyot1TLVQG0Ug==
X-Google-Smtp-Source: ABdhPJyiNldo5SwgJL3dxm7RfCbXMwfB+m64ZQwFTAvl7q0/UDnGvqjF07LmaClRp7jSh3OZF4a7rg==
X-Received: by 2002:a6b:760e:: with SMTP id g14mr628341iom.136.1606886616474;
        Tue, 01 Dec 2020 21:23:36 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m19sm295938ila.81.2020.12.01.21.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:23:35 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: [PATCH 1/6] mm/gup: perform check_dax_vmas only when FS_DAX is enabled
Date:   Wed,  2 Dec 2020 00:23:25 -0500
Message-Id: <20201202052330.474592-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202052330.474592-1-pasha.tatashin@soleen.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to check_dax_vmas() and run through the npage loop of
pinned pages if FS_DAX is not enabled.

Add a stub check_dax_vmas() function for no-FS_DAX case.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 98eb8e6d2609..cdb8b9eeb016 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1568,6 +1568,7 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
+#ifdef CONFIG_FS_DAX
 static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 {
 	long i;
@@ -1586,6 +1587,12 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 	}
 	return false;
 }
+#else
+static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
+{
+	return false;
+}
+#endif
 
 #ifdef CONFIG_CMA
 static long check_and_migrate_cma_pages(struct mm_struct *mm,
-- 
2.25.1

