Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B532BB32F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgKTSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgKTSaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:30:46 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2FA2224C;
        Fri, 20 Nov 2020 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897045;
        bh=zI4r+6o2El2c52WevPvITrjA8S7VLEv60gqWdkuKi6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVJBHttpGmlOM3ZW2pe6Gt5JRpB7DTi51FACV3xJArxUF0hhHScuJ3SA830xYWSY9
         qsPi8UHozXs4TEUYJAzt+YDx90cm/6ZwUgrUOJBTTIN4Tw9O7VufVIM4i+fcTVrdur
         gZ36Uo4M5T7jBBt55RKDMBXkWOl+OntoT+M8E7UQ=
Date:   Fri, 20 Nov 2020 12:30:51 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 041/141] mm: Fix fall-through warnings for Clang
Message-ID: <f5756988b8842a3f10008fbc5b0a654f828920a9.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a break statement instead of just letting
the code fall through to the next, and by adding a fallthrough
pseudo-keyword in places where the code is intended to fall through.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 mm/mm_init.c | 1 +
 mm/vmscan.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index b06a30fbedff..8e02e865cc65 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -173,6 +173,7 @@ static int __meminit mm_compute_batch_notifier(struct notifier_block *self,
 	case MEM_ONLINE:
 	case MEM_OFFLINE:
 		mm_compute_batch(sysctl_overcommit_memory);
+		break;
 	default:
 		break;
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b4e31eac2cf..a55c96891549 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1372,6 +1372,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				if (PageDirty(page) || PageWriteback(page))
 					goto keep_locked;
 				mapping = page_mapping(page);
+				fallthrough;
 			case PAGE_CLEAN:
 				; /* try to free the page below */
 			}
-- 
2.27.0

