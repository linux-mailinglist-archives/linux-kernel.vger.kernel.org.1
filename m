Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1E2E7444
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL2V1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgL2V1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:27:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BC5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hoh1jwuAHk2NhOLKPgomsC/sBn0dqjmZHnGGGkw8rew=; b=NViHlHQ6d5fbryvIeLA8Q/Pdue
        D7bxqSN0B9/eGKjXupDSSWvEfW3xHzkpQ3b+KJaVjk2H8SqzE2Lhe5/Q52JMfPlm5oXIeMtRfNVL4
        f9SobVXHtIbe7Z5jRPtbYZ3PDnJGxrsX4Uj4YHrOfZ67Qyy1AUzzzRUvR18vireLEl6VEasYh5h/n
        HM7PdBx0Bh+VykINOkknGsc9xpLpZaTp76vR51wIkkkohMmgjPHUhgvF+MmiPOiytmNcC8TPzevZ/
        FpNCIkf8MFGX39FLvmZvhBLReBbsxfslFv3qV3BIM3ACciO7s/hLt+LVVOgkn5w5HRIohxcVbNa38
        ZDSHuUew==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kuMVr-0004Dx-UL; Tue, 29 Dec 2020 21:26:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH -mm] mm: readahead: apply a default readahead size
Date:   Tue, 29 Dec 2020 13:26:34 -0800
Message-Id: <20201229212634.31307-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN reports an invalid shift size:

mr-fox kernel: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
mr-fox kernel: shift exponent 64 is too large for 64-bit type 'long unsigned int'

Original report:
https://lore.kernel.org/lkml/c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de/

Follow-up report:
https://lore.kernel.org/lkml/0c283ea9-b446-0e40-6dc8-e9585ae171b4@gmx.de/T/#m9b604660925f9e8a544f7453130c31d083c1e5bb


Willy suggested that get_init_ra_size() was being called with a size of 0,
which would cause this (instead of some Huge value), so add a check in
that function for size == 0, and if 0, default it to 32 (pages).

Reported-by: Toralf Förster <toralf.foerster@gmx.de>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org
---
 mm/readahead.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-5.10.1.orig/mm/readahead.c
+++ linux-5.10.1/mm/readahead.c
@@ -310,7 +310,11 @@ void force_page_cache_ra(struct readahea
  */
 static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
 {
-	unsigned long newsize = roundup_pow_of_two(size);
+	unsigned long newsize;
+
+	if (!size)
+		size = 32;
+	newsize = roundup_pow_of_two(size);
 
 	if (newsize <= max / 32)
 		newsize = newsize * 4;
