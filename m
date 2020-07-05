Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C1215038
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGEWnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 18:43:55 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:60111 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgGEWnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 18:43:55 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 59d44869;
        Sun, 5 Jul 2020 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=htjyrCkmjghoXfq++loj40046Sw=; b=wQLXmw0AmLtdIlcQrqud
        gbVyMYW8xG/yirFRgfh4a2dHY+NGcJOZJ0MZkRpBNyfBeGY4haAErS9W0s/8cUpC
        i6/nNHoETmgnEQ5I2mm+vlJtVLaKOZD67W/IE5+83ceBrbBIrpRqNFPL5awqrvct
        kZh1gqS0Iz52ktyysfl4WvQWsbbsMz6nFsDyQDM1B2eFn6yBsmNYM7RzVQyffPu/
        AgPsu7T7qIigMXJX+KZW9kdC/CGzbtOsg27VH2XgC8PuShe4cXZ519F1nTT8WQfs
        NBDYln6jUcdXHwcGDlrji3gb+5OcKNLkwkjS07Je1skzSPyzC1m0ujAEffwxSptN
        Uw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d5744d36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 5 Jul 2020 22:23:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] fscache: replace open-coded pr_warn_once() with actual call
Date:   Sun,  5 Jul 2020 16:43:24 -0600
Message-Id: <20200705224324.16090-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to open code this here, so instead replace it with
pr_warn_once, which amounts to exactly the same thing.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/fscache/page.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 26af6fdf1538..dc8dce79fa8d 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -1173,14 +1173,9 @@ void fscache_mark_page_cached(struct fscache_retrieval *op, struct page *page)
 	trace_fscache_page(cookie, page, fscache_page_cached);
 
 	_debug("- mark %p{%lx}", page, page->index);
-	if (TestSetPageFsCache(page)) {
-		static bool once_only;
-		if (!once_only) {
-			once_only = true;
-			pr_warn("Cookie type %s marked page %lx multiple times\n",
-				cookie->def->name, page->index);
-		}
-	}
+	if (TestSetPageFsCache(page))
+		pr_warn_once("Cookie type %s marked page %lx multiple times\n",
+			     cookie->def->name, page->index);
 
 	if (cookie->def->mark_page_cached)
 		cookie->def->mark_page_cached(cookie->netfs_data,
-- 
2.27.0

