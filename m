Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE323C283
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 02:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgHEALW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 20:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbgHEAKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B2922CF6;
        Wed,  5 Aug 2020 00:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586251;
        bh=2xIrVg64kndWbqniUMgYzth4/meHGaDYEbL6L9UyYO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQ7kVXK+TQYlwHTzyyFT2TurCPbvbzY4ohwEkjlu9xAr3luzSui9Apx9Q38Sia/t5
         E0mIUP3WIBxRQ586b+3KnrvIbYXgEpURbIZtg/iCi6dYjg1BF3Lw+LVK6WwGjB3HpR
         VUIclImyJNnLF2PIm7NywikLcPlyDdVJOo4fONXM=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 06/14] tools bitmap: add bitmap_clear definition
Date:   Tue,  4 Aug 2020 20:10:35 -0400
Message-Id: <20200805001043.3331907-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed as a result of de4643a77356 ("locking/lockdep: Reuse lock
chains that have been freed").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bitmap.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index b6bc037623fc1..873176c501e43 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -101,3 +101,23 @@ int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 			BITMAP_LAST_WORD_MASK(bits));
 	return result != 0;
 }
+
+void bitmap_clear(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
-- 
2.25.1

