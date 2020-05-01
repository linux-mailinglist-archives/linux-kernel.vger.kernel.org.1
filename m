Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2179E1C0BD6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 03:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEABxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 21:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:53:17 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB07C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:53:17 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g16so6223814eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmO2teDKNVVM1SwTPbEO3I1g0qYZy8+bZ8T5vEIKOEA=;
        b=IklgJ3X+Nn1j2h4folWHbFv3GAF2mbpLt8qjUfZ6kM5BtiPNTD7swT8UthYE09my8B
         IdfjfoxhHKiu9+Hj9cHuEep5hOAV5j0d8z3oM1FctJ8QcLiZLU2QyHIc7hOd8/6Ffsma
         4DxurCOjIu31jMBHVXUVvU5/qHn3RlY3PAoduJ/YHDI7lltf1EakLiHEjuSlh41JZfDy
         Ed0JaQ6FhIj7sIRGAHGop49RLpmKu/Za8gJ52ssiQPcb5XV+VU66G9x/E0XqanK5ztVq
         kbY3nBP0kcDPQ61ajaMGdy+Uk+kKanjsfYQDCAdMz5d4s8TznqGeZe7nsvymw6lX+Plo
         KulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmO2teDKNVVM1SwTPbEO3I1g0qYZy8+bZ8T5vEIKOEA=;
        b=ROvX4SJaRzj/yTrCctQPUohM+skTDk0pj+dg8c1OEhd29M2F+w1HIgOBosFrjJ57Bu
         Tv9zik2sbeaOOJsGm/1P47GsNIl38uyHVM0MEoYxQUXtwaV5u0jz+l3vWhVzxpRXiABa
         BOr89/W7K9KeGscjBHuc7DuvlXbuoIOEzAeJAGBXI6YqlOW3XXhAbG5pYI/0Y87isIdX
         QdIU+at7/CeyI92P5DoK8P9Tt+Oj0Ouvs2fJouD6s7+1KbZqxT7G31EMf3SlGd8tEutd
         QCWBW3HgKiH8NTRIaD01zgaAua6V4EKSStU6o8biMrDYdKo3xq8IE4a6WCDxmOYRqU7R
         jDaw==
X-Gm-Message-State: AGi0PubKOO2RQnk6YeJ1n9rnVqgWzyj1zN9wbhusiprQaam9xRruj/ln
        CkBFGkYr95lSG2nCC+dkpTDhJ/8xDoY=
X-Google-Smtp-Source: APiQypIq9ryOlak/rz39kcVg8Q7gUgSUakpIFnzLSrGRze3GlvQuw8lQICCABQYv3QaFwSjh/f3KvA==
X-Received: by 2002:aa7:d9d8:: with SMTP id v24mr1605224eds.27.1588297995873;
        Thu, 30 Apr 2020 18:53:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id n17sm165098eja.9.2020.04.30.18.53.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 18:53:15 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/3] mm/swapfile.c: __swap_entry_free() always free 1 entry
Date:   Fri,  1 May 2020 01:52:58 +0000
Message-Id: <20200501015259.32237-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200501015259.32237-1-richard.weiyang@gmail.com>
References: <20200501015259.32237-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__swap_entry_free() always free 1 entry, let's remove the usage.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index f73e0c11fab9..1a877d1d40e3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1251,13 +1251,14 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 }
 
 static unsigned char __swap_entry_free(struct swap_info_struct *p,
-				       swp_entry_t entry, unsigned char usage)
+				       swp_entry_t entry)
 {
 	struct swap_cluster_info *ci;
 	unsigned long offset = swp_offset(entry);
+	unsigned char usage;
 
 	ci = lock_cluster_or_swap_info(p, offset);
-	usage = __swap_entry_free_locked(p, offset, usage);
+	usage = __swap_entry_free_locked(p, offset, 1);
 	unlock_cluster_or_swap_info(p, ci);
 	if (!usage)
 		free_swap_slot(entry);
@@ -1292,7 +1293,7 @@ void swap_free(swp_entry_t entry)
 
 	p = _swap_info_get(entry);
 	if (p)
-		__swap_entry_free(p, entry, 1);
+		__swap_entry_free(p, entry);
 }
 
 /*
@@ -1715,7 +1716,7 @@ int free_swap_and_cache(swp_entry_t entry)
 
 	p = _swap_info_get(entry);
 	if (p) {
-		count = __swap_entry_free(p, entry, 1);
+		count = __swap_entry_free(p, entry);
 		if (count == SWAP_HAS_CACHE &&
 		    !swap_page_trans_huge_swapped(p, entry))
 			__try_to_reclaim_swap(p, swp_offset(entry),
-- 
2.23.0

