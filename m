Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7E2F4C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbhAMNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbhAMNlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:41:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726F0C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:40:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n16so3658249wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AReF/Pb/hU+fqwaRLVxdlFX6l/fsbGy8vg+o0T0tRKo=;
        b=klqjwJEgVbZYwDtZ6ngZzhrQcr8l5xzwaNa/jRMYreFd07PheGQNQ7ZA8SqjikfyRI
         sWqBmOVzF3NiyE5aFiYxlF4hPzAVKC6sjr9W26Z6q8fn7rGAQr6jsh4ldZ3+8N5iUs9/
         GGFKxtfao8oxLbeXjVV09YFcnuOehljiJxbF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AReF/Pb/hU+fqwaRLVxdlFX6l/fsbGy8vg+o0T0tRKo=;
        b=dSnADDbC+CxXAmUELHTIlVP5o/BKjQl38TKl6CplTR17zMIHelNKYQenIHndfneOUH
         4I57u+XV6qzSaBReNgb+WVFY6i7sfj1MVyEhu5/WpSG10QK1ZuXknihgOqZL7+DHODad
         kMvp0U+mcpflScqpmiaoJ3goLmkGrRuRrSz0xkmAmchYiwDrl0qBZAfo46YUI4HbMsgt
         5YkMW7fsev/yTe2K6KS8GfSScdZr1BaHPe8eR+OIsok0G+VUAeb3o718CZOFj00aq1SD
         W3O1/XP8zk5Q3DQkFTNeFjVWdSeWv+iNvua4N7jjZhxZVy6wZ2KTX2wuGsAm7JLH0+cN
         R/bw==
X-Gm-Message-State: AOAM530hF9PZmu5t7Mf2DRUnkThvB4eVC6avsbgOHQRZIMsWrJnh7cvD
        NS5MhAToxTTyrUZvve2MX3bX5u2Tulhtzp7+
X-Google-Smtp-Source: ABdhPJxKhyEG2xgFW59hdUdQb6YwumM+sVsWxxlQL5P5k2uIl8u2Bi8Oo09LvqU9dWUR7v+9Ii2rpQ==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr2242755wmc.10.1610545248987;
        Wed, 13 Jan 2021 05:40:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g5sm3741054wro.60.2021.01.13.05.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 05:40:48 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 2/2] bdi: Use might_alloc()
Date:   Wed, 13 Jan 2021 14:40:33 +0100
Message-Id: <20210113134033.3569683-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113134033.3569683-1-daniel.vetter@ffwll.ch>
References: <20210113134033.3569683-1-daniel.vetter@ffwll.ch>
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
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e33797579338..3bb7807c2f0c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -580,7 +580,7 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 {
 	struct bdi_writeback *wb;
 
-	might_sleep_if(gfpflags_allow_blocking(gfp));
+	might_alloc(mem_flags);
 
 	if (!memcg_css->parent)
 		return &bdi->wb;
-- 
2.29.2

