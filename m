Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9951E24EB13
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 06:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgHWEEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 00:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:04:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14776C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1olioFzGdUtgwx/AEkNmvln3FA8UqG1H17ON1QJoaHY=; b=s+SZsXea+DRpz4KTiLtvRWi4wi
        mROEN3YOlWYxL9S2sOHIojFB3yaGxncy0z4rZZTTuvtBnRw5VrJos5lnGHPme+GbQWIpTKusx7C4P
        htSjQHf4z9cyFroQcURUWA/IkZ5paSPRuVFkqcgKiuGlrWg5UoA4a4PHXVdmvIt62oSAYgv4Vbten
        zQRITs0N0c9nHVLo7IMcSGxf0X+RFpHQ5E5JYqyK/GFc5Gb6z14wF9kb3gPMkJYm6EsVsFnkK9KL4
        STofdsW0+lWhqn2vLToXjkgqF4M2vt6clejbSLApQWJqx7bi/M6s1uzjvovfYR4TTIsvHR/ctbELG
        /P27x7Ag==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hF6-0004oA-Bc; Sun, 23 Aug 2020 04:04:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib: bitmap: delete duplicated words
Date:   Sat, 22 Aug 2020 21:04:24 -0700
Message-Id: <20200823040424.25760-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "an".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/bitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/bitmap.c
+++ linux-next-20200730/lib/bitmap.c
@@ -23,7 +23,7 @@
 /**
  * DOC: bitmap introduction
  *
- * bitmaps provide an array of bits, implemented using an an
+ * bitmaps provide an array of bits, implemented using an
  * array of unsigned longs.  The number of valid bits in a
  * given bitmap does _not_ need to be an exact multiple of
  * BITS_PER_LONG.
