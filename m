Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32944233D45
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 04:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgGaCjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 22:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731217AbgGaCjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:39:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BECBC061574;
        Thu, 30 Jul 2020 19:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=f900H8c+KYErATjznBpwypz8SH4NznsR3P2MZwYyTNw=; b=ogZPYgFddo0tjP88JCxC0Jb07a
        JFK74msUHAiuz3h5xqFgX04Oj1m7XZT3hECBNSVY9MYb1/QQugtmWTtVhz/e60OlZwCimPg3UWg8o
        xrF7yh+k02bKKmPmeYNsyxAwRwMeWG5enHkDKVzmTpTys6jigCY+a8YiyHOPzSmGvYJnV3DEWtzmo
        AvPMZd0DWBcf5u4e/zXosm/6jisHJXKRZSK305OWSMJI/8ASbmdgG200npBGfdo8Y58io/nRQuaBk
        iex9LQietkg0bos7Bo+dr6aEMtgOytzGzLiehJFT98CmjL6Gpu2Y9Ig0rZkQNW9dcWSh6zq8Gwnf4
        /hdX/4Tw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1KxN-0001o3-Vs; Fri, 31 Jul 2020 02:39:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 4/6] crypto: crct10dif_generic: fix duplicated words
Date:   Thu, 30 Jul 2020 19:39:22 -0700
Message-Id: <20200731023924.8829-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731023924.8829-1-rdunlap@infradead.org>
References: <20200731023924.8829-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the doubled word "at" to "at a".


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/crct10dif_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/crypto/crct10dif_generic.c
+++ linux-next-20200730/crypto/crct10dif_generic.c
@@ -35,7 +35,7 @@ struct chksum_desc_ctx {
 };
 
 /*
- * Steps through buffer one byte at at time, calculates reflected
+ * Steps through buffer one byte at a time, calculates reflected
  * crc using table.
  */
 
