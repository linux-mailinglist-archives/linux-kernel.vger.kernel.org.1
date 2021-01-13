Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9272F4C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbhAMNla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbhAMNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:41:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9CAC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:40:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so1650948wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFzodEjW4sHgpqzrfFhyl8i1bcr7U3hZwXGAiwujPcs=;
        b=leDlFmHJl3DrcJDqdemz/ITGhb8jeil1B2sae+wLzm9LRoAV03upDzuG9eCIfT+O3W
         FofGQukBW4w91Bu086sO4dUU3W4HV2e3yxBlrV0hqObiqrApPfOBlbr4Js3SWGecLZtg
         PkDPPEFqOgM85h9NJzligj9e8uxWr10eUSwJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFzodEjW4sHgpqzrfFhyl8i1bcr7U3hZwXGAiwujPcs=;
        b=WsCQxTeKe+b+BIMNn/FiP1yD0HARe2sUzx2CmpEM9cFgsSJSlFG70FfpXDU0pKk9on
         b/rteZyDAWUjhL8os1KYXLCN0AeztgB9ipwvxd/iKcFUlEF3GzgO2KOHHK5yFzK2WWBP
         89hSH3sNdSDZYJXPdjhim+wMPCRy+tZz1vmYYZEK/0Xj/KxPnRB2fGKkqZUDfguobpNj
         lKhjy+2j49/K9h0UAQz7RF1QpeuJx4+1ASBKRF1nqygpYzPH0UrD3r1eh9e/nFIzERZf
         WyTeBG6oESJHQ3U+fvqYpiXhHN9c9uhzHgcD6fC1VVlLvc/H9QshCcZgrSaa0aMmhA7E
         KkCA==
X-Gm-Message-State: AOAM531cwpjoqPJW7gKaD4s3K5U6JEEseMOj+ZnwajZ73cw+bN/EGhVK
        UsfZ47qYVhRwK4Gpbux52st4TuaYqgL66ezI
X-Google-Smtp-Source: ABdhPJwRIRVFwJp0Hh/9snpfjpdMVRAI69gyiVYlhrbBJjMJRUG3bx18cabm50BvhrWxYr0nCYnHxg==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr2240920wmd.20.1610545247845;
        Wed, 13 Jan 2021 05:40:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g5sm3741054wro.60.2021.01.13.05.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 05:40:47 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 1/2] mm/dmapool: Use might_alloc()
Date:   Wed, 13 Jan 2021 14:40:32 +0100
Message-Id: <20210113134033.3569683-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that my little helper has landed, use it more. On top of the
existing check this also uses lockdep through the fs_reclaim
annotations.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index a97c97232337..d89c6966548d 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -319,7 +319,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	size_t offset;
 	void *retval;
 
-	might_sleep_if(gfpflags_allow_blocking(mem_flags));
+	might_alloc(mem_flags);
 
 	spin_lock_irqsave(&pool->lock, flags);
 	list_for_each_entry(page, &pool->page_list, page_list) {
-- 
2.29.2

