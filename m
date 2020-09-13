Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1EE2680E9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIMTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 15:05:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F05C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 12:05:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so9174932wmk.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+MxfKNTuc5VaN6NhuE64EHSS6797wnf2U/mP1kKdFwc=;
        b=CAV3/VeHI9C7tBfKwJF+Xb1SxPkVApKxSnGc/3niqF3X3bY1MWyHsvU0kNq/2QSBgp
         t+327+GaFZYInKdrgbiHXyfMOsEbE7wUArcxKlmjR/j6RxTXwO+yHRYmlrUNxMSVTwBq
         jqqWIgecIWiGoUZUgh+IwFd7rOKc8rzmZT8fUglNTadL9dTkoqDeRVO6oQ+o+1bgi8n8
         4ASsTBMh0cD3o94wikrmGlJQZ8WNq0nfXsD9K2vjZLsSEE4MVwF/7dn5AiUmJ5XeDwm7
         tq1QkZU1vlxoRJzFntBehUNxK2kakEKBKpLyMkGZMY/0VtS4qtN8L6TlQCsnMErGfzps
         E4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+MxfKNTuc5VaN6NhuE64EHSS6797wnf2U/mP1kKdFwc=;
        b=G0rpCqtAxU8q/p6WHTbm7K/sexsjjWuhfGe6lPbiXXFNTymtmLDI6n8QHWkYFmruRp
         k64pLUKkhV6jmpaVbws99xWMN2Y3WVY806jnUEiWFRYVhYZs+LtkbcUVpPrRa8z9XNjd
         ax9ty2HPfc1DzZp7fdQNnDWc9o3KhJW29HIfxnHV2mnz8TFKLm2yoioLh6OvSJ9HZa8C
         6yLdfVCQ/5gJ3qhRc8lkCJjgurPyIKf8wo4fqEh0QMc6ah/dV7npPzv8XEztZfUgxbok
         m/2eJa/EosSxNOOcazRL21AInwkoptRK9MA+hvXjDqivfj2YEgC0zfMalPbC9E7BmO83
         vSUA==
X-Gm-Message-State: AOAM531Yj6ve3IEYcUJp/TwWqbFO3IKFpvXBHBpcGbGTmKe5aP+5Jl9U
        mevb08D/fWTLcGFFYuthgaU=
X-Google-Smtp-Source: ABdhPJw1qSOkBvhUTpOm91xMXLIJT5GYg4KVIOwW74nnima+ZYwdCFfu7zwykBnPI6ITyj4C1uWi5g==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr9287528wmc.151.1600023953846;
        Sun, 13 Sep 2020 12:05:53 -0700 (PDT)
Received: from localhost.localdomain (188.147.111.252.nat.umts.dynamic.t-mobile.pl. [188.147.111.252])
        by smtp.gmail.com with ESMTPSA id j14sm17326955wrr.66.2020.09.13.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 12:05:53 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/compaction.c: micro-optimization remove unnecessary branch
Date:   Sun, 13 Sep 2020 21:04:48 +0200
Message-Id: <20200913190448.28649-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

The same code can work both for 'zone->compact_considered > defer_limit'
and 'zone->compact_considered >= defer_limit'. In the latter there is one
branch less which is more effective considering performance.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/compaction.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 176dcded298e..6c63844fc061 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -180,11 +180,10 @@ bool compaction_deferred(struct zone *zone, int order)
 		return false;
 
 	/* Avoid possible overflow */
-	if (++zone->compact_considered > defer_limit)
+	if (++zone->compact_considered >= defer_limit) {
 		zone->compact_considered = defer_limit;
-
-	if (zone->compact_considered >= defer_limit)
 		return false;
+	}
 
 	trace_mm_compaction_deferred(zone, order);
 
-- 
2.20.1

