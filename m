Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1429CC90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 00:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832907AbgJ0XGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 19:06:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45968 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832900AbgJ0XGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:06:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id m14so2320963qtc.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fyU3C0X3B3KixfhP3mE1hMwWy/q9ZulBRC+CMOazduI=;
        b=GgfkUTqJJoieNk9qWTBAM0blC+R1lUzFN7I4MCj2vaNy3IBHsDUN7xN9FKmFG6dPX0
         4eu7jRvgxtmrtRkqIJdK8RW3WxGYCQiSJUhQDqWexX62TMs+bq7RkAoiwKVdVbTM/9u4
         rkGs/aPayZnh/4swueK1nKqwG7YErATmc7Fz3VZHW2/piPJ+Ewi0k0ALtZz0bcbxFxQ0
         vOEOldtmuvfZ20lpKiGAsDzpcPr6Z2+R7MxTnGtwMDQNJXn6T1QRStdV+Da7mkc5eWRw
         BuO0aWIuTQGluH0IP3im7pobXt7uw6BO4n6QLgkXnQkhx/zoaieFVTpEUmANP78P9Vvi
         41Jw==
X-Gm-Message-State: AOAM530qf3oREFYEwAnLX1Ra27iYB4x3cD+vsQ60q8Ri2LAZDqGXRL83
        DVwNmhqdTWV50qVX3sLqHRYR554KT9v/CA==
X-Google-Smtp-Source: ABdhPJxu8wpLyJM986mljnRJYDy46fnUG1mGatGs9tNgKfBaBnVq95cyg8CKVJjzoxPh4qN3OhWZ5Q==
X-Received: by 2002:ac8:519a:: with SMTP id c26mr4347157qtn.270.1603840009608;
        Tue, 27 Oct 2020 16:06:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k4sm1710236qkj.46.2020.10.27.16.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 16:06:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm/ident_map: Check for errors from ident_pud_init()
Date:   Tue, 27 Oct 2020 19:06:48 -0400
Message-Id: <20201027230648.1885111-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit
  ea3b5e60ce80 ("x86/mm/ident_map: Add 5-level paging support")
added ident_p4d_init() to support 5-level paging, but this function
doesn't check and return errors from ident_pud_init().

For example, the decompressor stub uses this code to create an identity
mapping. If it runs out of pages while trying to allocate a PMD
pagetable, the error will be currently ignored.

Fix this to propagate errors.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Fixes: ea3b5e60ce80 ("x86/mm/ident_map: Add 5-level paging support")
---
 arch/x86/mm/ident_map.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index fe7a12599d8e..5ecb0883cc88 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -62,6 +62,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 			  unsigned long addr, unsigned long end)
 {
 	unsigned long next;
+	int result;
 
 	for (; addr < end; addr = next) {
 		p4d_t *p4d = p4d_page + p4d_index(addr);
@@ -73,13 +74,17 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, 0);
-			ident_pud_init(info, pud, addr, next);
+			result = ident_pud_init(info, pud, addr, next);
+			if (result)
+				return result;
 			continue;
 		}
 		pud = (pud_t *)info->alloc_pgt_page(info->context);
 		if (!pud)
 			return -ENOMEM;
-		ident_pud_init(info, pud, addr, next);
+		result = ident_pud_init(info, pud, addr, next);
+		if (result)
+			return result;
 		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
 	}
 
-- 
2.26.2

