Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3F2AB22B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgKIIHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgKIIHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:07:02 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08776C0613CF;
        Mon,  9 Nov 2020 00:07:02 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id h6so6477747pgk.4;
        Mon, 09 Nov 2020 00:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tdJdOvUDP6y6X9SlPMAqs3qJ1Y16ycODxrmLOvFtfbo=;
        b=johfybRxzOKso37oy4MEZ3SUY12hPQjBv5T/yRYoiy1QYgFrkptXd78rFmmAS1AU8K
         8p5YcLdbxJpd/mgPcRbfarMFZqY6mMe24P7ZJR9Zn3S5ubkjr6vfj/oscdB+3wP72r7N
         SPLVxYxFDXXUqQRLhEwyeWLTibfk9wXGafHJ5kkPi/KQZQNu+1rik2RXmMFxCNKDy4H4
         Pm+3sfVaO+LrjF3F9flUOIXUqcivvSmM1c70riulGNJQx28oP18tzg+dBe39mkYiPxrI
         PK12a+XCh44a2sGfOOkYW9ygoWkD0itL9l4+0FNM+N0/Kcgd1L1cYb4qqb0tevMiu+P2
         x6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tdJdOvUDP6y6X9SlPMAqs3qJ1Y16ycODxrmLOvFtfbo=;
        b=ImfixwmnF/V90Jq148uujca64Rp07vMZufbCd0poZ1exVmQb9vmP4pVHHrGoHtNJUA
         wNzXFhaWITwBfQ8qDHBpB+zuAeqRyY3sU9FnsRLk5jRI6M6seXC7MED5K+1uQp2Kl/AC
         Zjrhu3gBTV1WUa2+FZHzADQWBgV4A1cgeCEeTkQxV7YoVQhq6Ag7nGHnfqx3psfLKhWc
         7DcsLnOnjxIda0UCYSK8or2Pz8YEfqJKF6aKZx+VphRYWT3Ch7X55ULqeMGCpTnBd/L6
         m6PhisuAZR+FL1ukUTPRp7tj8WWh18e4+5xjr1iT45fa8/ODPGw0d7OhGLUqy4zG6dDM
         9Wmw==
X-Gm-Message-State: AOAM533VEkppnYRMUrXzEa5k9uqyv7WsRPtFnnpJSWYxRifNpK/DcPth
        uELPk0KJa/UTeZtBoyp8lQ==
X-Google-Smtp-Source: ABdhPJyoYoL0Vm+aqhGo9MTk6wLVKwPVDQYJQqI25+85Zv6YuKGNudFyH1WyhbxX6Xx4bD8McDgq6A==
X-Received: by 2002:a63:6386:: with SMTP id x128mr11713012pgb.148.1604909221650;
        Mon, 09 Nov 2020 00:07:01 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id gb17sm7522311pjb.21.2020.11.09.00.07.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 00:07:01 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] sparc32: Fix comparing pointer to 0 coccicheck warning
Date:   Mon,  9 Nov 2020 16:06:56 +0800
Message-Id: <1604909216-16572-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fixes coccicheck warning:

/arch/sparc/mm/srmmu.c:354:42-43: WARNING comparing pointer to 0

Avoid pointer type value compared to 0.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 arch/sparc/mm/srmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 0070f8b9a753..26d444223ab1 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -351,7 +351,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	pte_t *ptep;
 	struct page *page;
 
-	if ((ptep = pte_alloc_one_kernel(mm)) == 0)
+	if (!(ptep = pte_alloc_one_kernel(mm)))
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-- 
2.20.0

