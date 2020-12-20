Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09DC2DF6EB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 22:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgLTVkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 16:40:14 -0500
Received: from casper.infradead.org ([90.155.50.34]:36434 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgLTVkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 16:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=uEe14I67YY4WiKXf+Vv9Ka5L+pRt+5C3knvLfa48ujk=; b=RvnkEbjCvQg4j0ZNpjnOzSykCY
        WwDxO5+lk7Zd++qtIEaWZoHrRvXYQh9k3zhLmtIcjDtBgNDefG105D5Gi1IzKbHtUENAFvUv3kF/R
        zErks05mFQhibhns2MKZRt1Q4LzQL9lHxdPPtdB/6kPbHgy8Ocj3l5Hjg5vWTR+re7UpnLuLm+6ID
        MBYYiYNS/LgLXt//ZAieJyXTWwgcA3AXTCS9LHNKT09F0/TV+dhM6MJkQaxrFmHRACF1538cmuXNh
        JBfaUHw/WdEQXOK/4FZadzqyw5q5B0xgjV5qL+TxpQR+GjcrLcwYGEL8NOq1lvmsjeIdRwr7qi6Df
        JohS7Dcg==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kr5yV-0005CC-Qc; Sun, 20 Dec 2020 21:10:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>,
        linux-mm@kvack.org
Subject: [RFC PATCH 1/2] log2: handle LARGE input to __roundup_pow_of_two()
Date:   Sun, 20 Dec 2020 13:10:37 -0800
Message-Id: <20201220211037.1354-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN detected a 64-bit shift in log2.h:__roundup_pow_of_two():
  UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
  shift exponent 64 is too large for 64-bit type 'long unsigned int'

This is during a call from mm/readahead.c:ondemand_readahead(),
get_init_ra_size(), where the 'size' parameter must have been
extremely large (or "negative").

fls() can legitimately return 32 or 64 when the MSbit is set in
a 32-bit or 64-bit unsigned long. For these values, doing
"1UL << shiftcout" is invalid or undefined, so catch when this
happens.

When the MSbit is 32 or 64, we cannot roundup to the next power of 2,
so just return n (the input value), which is >= 0x8000...0000 and
probably not a power of 2 (unless it is exactly 0x8000...0000).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Toralf Förster <toralf.foerster@gmx.de>
Cc: linux-mm@kvack.org
---
 include/linux/log2.h |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- linux-5.10.1.orig/include/linux/log2.h
+++ linux-5.10.1/include/linux/log2.h
@@ -54,7 +54,17 @@ bool is_power_of_2(unsigned long n)
 static inline __attribute__((const))
 unsigned long __roundup_pow_of_two(unsigned long n)
 {
-	return 1UL << fls_long(n - 1);
+	unsigned int lastset = fls_long(n - 1); /* this can be 64 or 32 */
+
+	/*
+	 * for high bit set (64 or 32), we can neither round up nor
+	 * make it a power or 2
+	 */
+	if ((sizeof(n) == 4 && lastset == 32) ||
+	    (sizeof(n) == 8 && lastset == 64))
+		return n;
+
+	return 1UL << lastset;
 }
 
 /**
