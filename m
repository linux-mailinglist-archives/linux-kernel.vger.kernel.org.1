Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1631E24EB14
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 06:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgHWEEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 00:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:04:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA15C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BnEHbU6mClTRnHCxdhX/Tw3LGr5ckbFPxQR96RcI8Ds=; b=Z9vn3dPpWD2mSnHHBQLJO+VpvQ
        bDSU2I7doCmWOSI34T3nCnJBCEE/LNDyDXO1vBewk2HPS/uV2/3tdXkYhAJO9Jec0P1efrS2f9prh
        mAwaFjDMZ9rkk9Zo0kcHbf4WcnQ4yKngzWkwbUX8+qS5wc3vqHFnTj/aAU4ocBogOayV8xrZnxwWw
        Zhv7PCGvzpEMjSIhmWI4ymVYtFEXu3bZGADB0o/KbSqw0x8i+VgwKbaOhnnhRw6dAEzSbVUasDdfZ
        s3o0mAxMUJQYa0BcbOiOvAgIMJLMGJUKVEFCYk6nfFQ6bW6QMDACJTTTBh0Z46/LNNrJJnYRhCwfp
        aVO8zLiw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hFC-0004oR-Ne; Sun, 23 Aug 2020 04:04:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Clay Haapala <chaapala@cisco.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] lib: libcrc32c: delete duplicated words
Date:   Sat, 22 Aug 2020 21:04:30 -0700
Message-Id: <20200823040430.25807-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Clay Haapala <chaapala@cisco.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 lib/libcrc32c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/libcrc32c.c
+++ linux-next-20200730/lib/libcrc32c.c
@@ -12,7 +12,7 @@
  * pages =        {},
  * month =        {June},
  *}
- * Used by the iSCSI driver, possibly others, and derived from the
+ * Used by the iSCSI driver, possibly others, and derived from
  * the iscsi-crc.c module of the linux-iscsi driver at
  * http://linux-iscsi.sourceforge.net.
  *
