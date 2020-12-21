Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7936A2DF839
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgLUE3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgLUE3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:29:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2ECC0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RtEAlOpEBEbxdKJENf0X8/PxK1k1dkBAwswBPT8os68=; b=ZwHVTJld6G4brrf9x0h75RubyF
        kDs8i0fpPe8VtVlqC7LJ10KwKicGqJy7hYvTG6IW2dSBCGYGC9dswQY8mFdvBfcp8mXekdONTOsSm
        TDjgHvN4I2wSsvGCIl7Y1OwN838pqfUPmot/CSQX+nk0eL/+KXT82mR1HAqliBvszwaYV8T291HI0
        W58Hrbz23+azbYCGd3j+XW9+iuFnP5Xv4a8acd6q7Yy8aJH2+8S5zSQEssaLrzaQVOjqobRM6wDvJ
        82bS63VqLMd0TbdL3HGO8bk6f049Y3kVNRXMxyTVzwa1ur4yXdxYc0iT69SiUZ9nZYe3K2KIl6tra
        dc4cnadg==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krCoY-0002Rc-4o; Mon, 21 Dec 2020 04:28:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Weijie Yang <weijie.yang@samsung.com>,
        Seth Jennings <sjennings@variantweb.net>,
        Seth Jennings <sjenning@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org
Subject: [PATCH] mm: zswap: clean up confusing comment
Date:   Sun, 20 Dec 2020 20:28:48 -0800
Message-Id: <20201221042848.13980-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct wording and change one duplicated word (it) to "it is".

Fixes: 0ab0abcf5115 ("mm/zswap: refactor the get/put routines")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Weijie Yang <weijie.yang@samsung.com>
Cc: Seth Jennings <sjennings@variantweb.net>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: linux-mm@kvack.org
---
 mm/zswap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20201218.orig/mm/zswap.c
+++ linux-next-20201218/mm/zswap.c
@@ -1022,10 +1022,10 @@ static int zswap_writeback_entry(struct
 
 	/*
 	* if we get here due to ZSWAP_SWAPCACHE_EXIST
-	* a load may happening concurrently
-	* it is safe and okay to not free the entry
+	* a load may be happening concurrently.
+	* it is safe and okay to not free the entry.
 	* if we free the entry in the following put
-	* it it either okay to return !0
+	* it is also okay to return !0
 	*/
 fail:
 	spin_lock(&tree->lock);
