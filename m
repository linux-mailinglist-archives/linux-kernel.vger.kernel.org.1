Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5826B2E90AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhADHBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbhADHBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:01:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C531FC061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:01:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f14so9458833pju.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 23:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfWnBt9oMWkYekWPdC8T/NbKzeZ/tVaqKYGZLAFF0lk=;
        b=XnrcvtLGW3NnmKsqgZ99vjzAVDjrRuk7oMv+sz+YCA19t+irHF982MYUr3KSKp3/Cd
         KgZnj0IAKDQnVPHC2tiQHJGHTadqblujYH4Q5KMhq6meBiKVCfod9fKE/j2BaXZ9Vaj0
         r0/lFIln/I+0uRa2SUhr2oN692OsEe3ElgM6thaJQGJk8SjC44XCHr1lWbCi0P1mOLm+
         bdjP74QFrbcxTJoA60I4BaMYZBs7y83siX8r/7OO5XMEdUmFm6WmaYx7T9gr793fV3aO
         wZFKORYiFB5oGansXHiLmsourUDqryOD3eeB4ZFszlN3U1lzBwnNSs8aWmr/VCPCrDin
         DNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfWnBt9oMWkYekWPdC8T/NbKzeZ/tVaqKYGZLAFF0lk=;
        b=nB9+sLvijv1bkKXoASJJ2OIug2FDvRFOHTxBfEZG6NMIQ2oh1hU1Ix7TW8vjeVeAdL
         kQRE+rAMcoWNXEPAFQkHRrNjc/QZWmUCGU2tbPtykuMeqRoEcj+a+qTlSosEYg6XmvJ9
         n4YF+b8AizJvYRF44dC4TqRvyQZPyMJw14+V6wJngtEUMdj7rgAj3nLWUXaL0wHdeJMk
         t7B4kBxP7suCRFzQ4KS0vFmdrwPn9Cn9D1icuq00Jomjnu3qrrXo2pjOsjD5VdDNqyRL
         9r3IkXwnqlHhsGnNJa2k9ZFWsz2RmexughnMbqwEdTW13fptTzhHD15P9Re1Hab98IMy
         1F1Q==
X-Gm-Message-State: AOAM53294Yb0vQIdwnX84b+7i6pu//oZG62wC0s4yqzUWYKcV5uZD+7b
        AtLh51XcNPM1vcFrB19o7rvnLQ==
X-Google-Smtp-Source: ABdhPJwefBRpU311LeHDKfh1oqafHOF8ar7PhHcu5bep1BOfGProsLsWyVlvDYGkE6kgdWnVTM/1jA==
X-Received: by 2002:a17:90b:2317:: with SMTP id mt23mr28669952pjb.2.1609743673362;
        Sun, 03 Jan 2021 23:01:13 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::6])
        by smtp.gmail.com with ESMTPSA id v1sm36306648pga.63.2021.01.03.23.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:01:12 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/6] mm: migrate: do not migrate HugeTLB page whose refcount is one
Date:   Mon,  4 Jan 2021 14:58:38 +0800
Message-Id: <20210104065843.5658-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the refcount is one when it is migrated, it means that the page
was freed from under us. So we are done and do not need to migrate.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/migrate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4385f2fb5d18..a6631c4eb6a6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		return -ENOSYS;
 	}
 
+	if (page_count(hpage) == 1) {
+		/* page was freed from under us. So we are done. */
+		putback_active_hugepage(hpage);
+		return MIGRATEPAGE_SUCCESS;
+	}
+
 	new_hpage = get_new_page(hpage, private);
 	if (!new_hpage)
 		return -ENOMEM;
-- 
2.11.0

