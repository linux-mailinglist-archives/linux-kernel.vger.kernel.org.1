Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984682D01AC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgLFI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 03:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgLFI0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:26:52 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F1C061A52
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 00:25:34 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id m9so6370387pgb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 00:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=qoRift2jV1B6a3umkUaVHUC3RdMLwR6ew6g8R0nSrZ9H3e5JTD8paUXgzqNsnFUdDp
         txMAue17NrbbuPrSnxB9L6j5TkpBu8Rbl9SNXsUV2tJ5fzr+oOLIJzvNIkGDsvyUxeOI
         GQXd7P7GEwRyywDQq5EFMjOVhvaaKNy3TCjQDPonI3Y51+fcEmhDuQ6kt4jIzrmKXRJo
         L8vswZbMmPglR6/mpjwShMGHnqmDNaKTHLF9dGdCx4sGHqZa12q6/QhjE5A6tGKjvClv
         d1tO81uQB9xdZhC6XXPffaOAihcqiNvA4glBALCf5nVfKvFN/l+F+L0Moo/th6/AN+DE
         0STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=PQ7qMAWAcuJSQ4LYCrBdo2SH+7mrgJN4ORW/5X7YwdH9+q1BvUnC8Gl7AWAk4CzrIw
         62fPlZJ0VDLVviHN9nbqVH3xCYyN2w6JfR4rg/oHgbGE+mR9VmV54Q7HIp/MaeftlX9d
         VfthEuEcZ135m66F8Wh7jrI4C6s0hwcCUMekcoYl8K5sLgvpZBGOEfIJMxGUFAIZyxDV
         cVwMo2KQHAWZ0gC+4dgv20C1b3GwJbYcLbAo/g52MNJgSmNTQu5w2t22U5Pbp2EQuarm
         0n7/OKlN3l/aaLXE90n5/1YtqNXXPE3En2vy4aLJsgUTj7s9bKXoB31rfSP4tsVMeubg
         iklg==
X-Gm-Message-State: AOAM5317VYFz6NDh/6BPow8T/L6EZH0tmV5xtYAWDiGTjF3XpeZpa6g+
        oJRL98IFwwiYfvPE9nxvFrse1A==
X-Google-Smtp-Source: ABdhPJx/0GwBWm79tEQQwiyYmG8pU+wlAB4R0dnRQOfOcHPETYvxsRxU+GZUlt7jzm2lH1hwsBwhfQ==
X-Received: by 2002:a63:1d5d:: with SMTP id d29mr14382201pgm.328.1607243134106;
        Sun, 06 Dec 2020 00:25:34 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.25.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:25:33 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 01/12] mm: memcontrol: fix NR_ANON_THPS account
Date:   Sun,  6 Dec 2020 16:22:58 +0800
Message-Id: <20201206082318.11532-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082318.11532-1-songmuchun@bytedance.com>
References: <20201206082318.11532-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
by one rather than nr_pages.

Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 22d9bd688d6d..695dedf8687a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5634,10 +5634,8 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
+				__dec_lruvec_state(from_vec, NR_ANON_THPS);
+				__inc_lruvec_state(to_vec, NR_ANON_THPS);
 			}
 
 		}
-- 
2.11.0

