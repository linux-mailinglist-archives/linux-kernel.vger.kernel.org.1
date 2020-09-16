Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D609826C90E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgIPTC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgIPRsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:35 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14BC061221
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:02:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y2so6459599lfy.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JA4PHlNQaMJ1D5IFW/tpkL4nmImFR/EKeGxTzWjK4EI=;
        b=ODUZML88Dx0iFsSm8FrYDDW66yeAdO8HE2aG/UmGH0c1bKotJoVG+cm6HaJyIk7uwW
         QkW/oHj28CFkcu3AhajMu3oiBxKfntVt39vel8tM4xp9aFPT3D2SXxXTct/f+QqVtuko
         puOEDeIHtDZL5T6vyyIz6TRrpNAusDLKzI8vjfNLlQNmEM58OLSqX+EdsrY6n39Y+iz8
         tl1curU5w3BCKu1xx0bzMdhfUcNstadkqswhgtS1Z3fgFSMZGs/px4HPeAj9Q/oOkpw6
         JhVSGJeWp0+/b5k5IwzdPi9kH2ZnZ4iwaOnVa2tFcBCRI3NpNauXeEx/lRgC5BIMPyYT
         MPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JA4PHlNQaMJ1D5IFW/tpkL4nmImFR/EKeGxTzWjK4EI=;
        b=RUhLyPGaUyJK4smyf5Frwuz7aeDukRQTCanqxXVIEM+dR0BxlabWZVsj4y+1BtAGo6
         LM6I197OI6z5ik9YZF5as3JGv4dixOuOz2csgiqqAeJX/fBZ7eDnuTu0cvEGGFZGYFP9
         doN97S5xocA+6RqeTH6zBOsTGrwRIM9jYW+ljRjsrhY4QFiC0avE1cF9ga8ivaFUM+V4
         9dJ8zCOzFznUR6cN4KcCPqfSbrnbjpe20h3rNp3r02okA0aqhN1ssQDRYRxH1Hh+D/zA
         sOsQEThU0KRiuk19cTGI0whImohhFKqbfSy0xWkB443hmlyMBeV7v2dddgR5wYyyDya4
         u5Nw==
X-Gm-Message-State: AOAM533sRyowFmtFBNjld3usyIgO548hauj0AVqj1DADomLPLZq/Z3KV
        8T37modRzRefaA36vB6jNEs=
X-Google-Smtp-Source: ABdhPJxFfk/ocTjF6hPh2Z4/NvFWvbfmyK1pNp8DIIQwJT2EmJCJq8sPR6c0kOzYbBsGffbVLrKdSA==
X-Received: by 2002:a19:8386:: with SMTP id f128mr6932052lfd.78.1600254122843;
        Wed, 16 Sep 2020 04:02:02 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id 82sm4475792lfk.216.2020.09.16.04.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 04:02:02 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [RFC PATCH] mm/page_alloc.c: clean code by merging two functions
Date:   Wed, 16 Sep 2020 13:01:18 +0200
Message-Id: <20200916110118.6537-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

The 'finalise_ac' function is just 'epilogue' for 'prepare_alloc_pages'.
Therefore there is no need to keep them both so 'finalise_ac' content can
be merged into 'prepare_alloc_pages' code. It would make
'__alloc_pages_nodemask' cleaner when it comes to readability.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/page_alloc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b9bd75cacf02..a094e297c88f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4824,12 +4824,6 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	*alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
 
-	return true;
-}
-
-/* Determine whether to spread dirty pages and what the first usable zone */
-static inline void finalise_ac(gfp_t gfp_mask, struct alloc_context *ac)
-{
 	/* Dirty zone balancing only done in the fast path */
 	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);
 
@@ -4840,6 +4834,8 @@ static inline void finalise_ac(gfp_t gfp_mask, struct alloc_context *ac)
 	 */
 	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx, ac->nodemask);
+
+	return true;
 }
 
 /*
@@ -4868,8 +4864,6 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
 
-	finalise_ac(gfp_mask, &ac);
-
 	/*
 	 * Forbid the first pass from falling back to types that fragment
 	 * memory until all local zones are considered.
-- 
2.20.1

