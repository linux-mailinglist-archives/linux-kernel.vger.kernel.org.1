Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A873F233D40
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 04:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgGaCjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 22:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbgGaCji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:39:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00768C061574;
        Thu, 30 Jul 2020 19:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nAwGJbGD9Vb5v2k49cLmhDx+FAbuItffPxLC9vlnAvQ=; b=23JfjDvpxR3paHw+38p8Nl4u7T
        9DomD5RVkmycDvre8pgOpSlp1Hkl1vE4Byxtxs85jwiz3vEjjcahJyz1HsqtdPHW7vVpZmTq9gLoV
        d1BsGTouoKoLFFWfBGSFZWabOjV4Wqv5RsEXgw3y3fVRlj699ZvymgstMkAwDCZDOIDpLplFjQuAG
        KOPbxJkdrSto8DQjjwntsm2RfkkKdRj1h1jFJrI7v9Ik6FisRgHcz8EfQ0bEXSqAXadYA87bBhIZS
        a/8jo04t4hfxvMBHyM2Qn5uNjpFodFYNH/tsP2/oSpG7KBkxdmhTBt/KlgZIJ9k9zke43uVr5+VVy
        cPb24Bug==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1KxL-0001o3-L7; Fri, 31 Jul 2020 02:39:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 3/6] crypto: crc32c_generic: delete and fix duplicated words
Date:   Thu, 30 Jul 2020 19:39:21 -0700
Message-Id: <20200731023924.8829-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731023924.8829-1-rdunlap@infradead.org>
References: <20200731023924.8829-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "the".
Change "at at" to "at a".


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/crc32c_generic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200730.orig/crypto/crc32c_generic.c
+++ linux-next-20200730/crypto/crc32c_generic.c
@@ -15,7 +15,7 @@
  * pages =        {},
  * month =        {June},
  *}
- * Used by the iSCSI driver, possibly others, and derived from the
+ * Used by the iSCSI driver, possibly others, and derived from
  * the iscsi-crc.c module of the linux-iscsi driver at
  * http://linux-iscsi.sourceforge.net.
  *
@@ -50,7 +50,7 @@ struct chksum_desc_ctx {
 };
 
 /*
- * Steps through buffer one byte at at time, calculates reflected
+ * Steps through buffer one byte at a time, calculates reflected
  * crc using table.
  */
 
