Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6F2246FB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgGQXfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 19:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:35:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BA5C0619D2;
        Fri, 17 Jul 2020 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Z7TBJKFnVGuhAJ2WG8B7U3qxpp2rKfvH5HNF64NHvEc=; b=FXAKhV1lolu4quCoNAvz2SSVgX
        fyAZq1uPzNhRrQr9Bsi9oBdmnLTHCLqD1GKeXXO7jTbyvcZMOxSmgU2t0EbTgMzxrz6HtqvVXwh1a
        CAGoPq7cnRAmk3AbINWvtZBqESxljwGIXX1HyHy0mMTpIWDzx1JT1HM5wgst638NnggHVbTUrB1Ud
        eireeBicficue9Kdf1uZRxBKkcpFQqKkcs8xrxw2oFjyGrZ/yo7zwphliidtp6vRwZgQ3PrtEr83m
        6yp0vAVjwGjs7sixsn2TLZHxy4amxXLnh5ZSiomMSG9ze6jYvSh3UqF/AO8N5/FupXFnWHqvnmxxU
        LMPrPy/g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZtB-0006T3-28; Fri, 17 Jul 2020 23:35:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] crypto: hash.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-ID: <83bdec97-38ef-f339-02ad-9066219b32c1@infradead.org>
Date:   Fri, 17 Jul 2020 16:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "in" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 include/crypto/hash.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/crypto/hash.h
+++ linux-next-20200714/include/crypto/hash.h
@@ -687,7 +687,7 @@ static inline void ahash_request_set_cry
  * The message digest API is able to maintain state information for the
  * caller.
  *
- * The synchronous message digest API can store user-related context in in its
+ * The synchronous message digest API can store user-related context in its
  * shash_desc request data structure.
  */
 

