Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D926326E743
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgIQVTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:19:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B83C061351
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 14:19:43 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d15so3746450lfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axN/EH8Seu2ahO13HO/SqkoEfnWHGFkbfFIVyd8qzAY=;
        b=s8SiQUA4O3KkxvoYBzSjtU72gzf6BKPcYZoQmI/j6hZgnyWRDPaYYUvxoktMMxaOvJ
         SDkrseLi2cl78EXnTlBIL7euysHz0cLMi+UxsKJbWQza7Hq7ltQDsth9r1RWCX7FSIiq
         khVr7fELDaTkOrwSjGeTtAbRsUCdvuSD25pOVTpQ3s38tU9ZK7DodQI0crIU/DlCnfkV
         N6+96GWvyFHjrJoE8e8OtN8LNYGpMW5aQBF/6lODvNKsQAOxWVuDJinJglW4wKaM63zT
         aqL7vzMosGtEC8UHFWRpkrlGIo1SEOjGprO9Dqqu/HngXE8GtkNzsItJL4hl7f93urDK
         fDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axN/EH8Seu2ahO13HO/SqkoEfnWHGFkbfFIVyd8qzAY=;
        b=eH0q7nNGBtk/wJcjOO8CQfQ9ldboX54v5roHJSnxgEG46lapvHiwezwRF11nQJkqz7
         jT4M032bi65t5lAf0ELueW9bQjZD6i2OsIgxv0P9aRvmv2QS7dqZQDctuaPuNitnjcTT
         6EsteFYBvkL17YDxTl4OLIdR/PFaTBwAjbq7+EiU3hESfNc2TALkkbcZ2FfvVjZLMTu0
         fuzNy62NakmLA14UvR6EbhLXnfD0l/GEtsuPXy54RyeCsvh7bIXQqfHbfBZ7Qnd96PjA
         XoCix/ZKSzuucuQAng9a2aXNnmk+vLOZdqaFA1NdRv9oMtQ8etrmVSiAqliSxsSARMpM
         6tiA==
X-Gm-Message-State: AOAM532CfxqnExEK0QgYXQ6bJBrMy5V5soTQ684r43nA1XgMPKDDBGF+
        YhJDXXWDPo8r9hlyCFXy+u8hfK4Tu9HTyg==
X-Google-Smtp-Source: ABdhPJzAvc1idJqWvyBa2Qp0Jqar7jG69zi+EGQJByY+swX689k7JY6xGICvPCWM6her1Li4yk8Glg==
X-Received: by 2002:ac2:4c01:: with SMTP id t1mr10393252lfq.351.1600377582132;
        Thu, 17 Sep 2020 14:19:42 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id u24sm144940lfo.117.2020.09.17.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 14:19:41 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mmzone: clean code by removing unused macro parameter
Date:   Thu, 17 Sep 2020 23:19:06 +0200
Message-Id: <20200917211906.30059-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously 'for_next_zone_zonelist_nodemask' macro parameter 'zlist' was
unused so this patch removes it.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 include/linux/mmzone.h | 2 +-
 mm/page_alloc.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 90721f3156bc..7e0ea3fe95ca 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1120,7 +1120,7 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 		z = next_zones_zonelist(++z, highidx, nodemask),	\
 			zone = zonelist_zone(z))
 
-#define for_next_zone_zonelist_nodemask(zone, z, zlist, highidx, nodemask) \
+#define for_next_zone_zonelist_nodemask(zone, z, highidx, nodemask) \
 	for (zone = z->zone;	\
 		zone;							\
 		z = next_zones_zonelist(++z, highidx, nodemask),	\
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 60a0e94645a6..6b1b4a331792 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3727,8 +3727,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	 */
 	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
 	z = ac->preferred_zoneref;
-	for_next_zone_zonelist_nodemask(zone, z, ac->zonelist,
-					ac->highest_zoneidx, ac->nodemask) {
+	for_next_zone_zonelist_nodemask(zone, z, ac->highest_zoneidx,
+					ac->nodemask) {
 		struct page *page;
 		unsigned long mark;
 
-- 
2.20.1

