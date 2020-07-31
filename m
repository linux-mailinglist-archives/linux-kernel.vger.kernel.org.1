Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0194233D44
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 04:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgGaCjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 22:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbgGaCjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:39:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51CDC061575;
        Thu, 30 Jul 2020 19:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pRNigv260ELJzr9cVfV7kXPz0ZMF4kIMpo59K/BD26M=; b=WWILb9yZ7X3XMNp7OqRBJ9zLdW
        HAREMXybA4yIIFBpBuqxQySidC35+hpfyRDF4fqJCUWB1sktBgMIhk/Z844wFpU2u2gF4iD23+5no
        PfHhDq1vTyjRU0ZvuplnKgxdi5OCnSm7BRIiSHMjvlA1OfhbbZfPArwJhtKbMF4LgLkelq1GiikgG
        lV3qMSzUjBmZL0grDyim5DCv2b6i3Z7DpCnXPKxaGrz3Sk05zomaN+qpIBeKaaDwKEFj2GxslDxl9
        sUbHjkxYR09TP508fMkLPiVGUGaEoVG/6Pc9LBLQiqANeXAN0V8aWPuYFcbnKjJOS2jkvuev3Lnie
        2b/gVoyQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1KxQ-0001o3-8u; Fri, 31 Jul 2020 02:39:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 5/6] crypto: crypto_engine: delete duplicated word
Date:   Thu, 30 Jul 2020 19:39:23 -0700
Message-Id: <20200731023924.8829-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731023924.8829-1-rdunlap@infradead.org>
References: <20200731023924.8829-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "a".


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/crypto_engine.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/crypto/crypto_engine.c
+++ linux-next-20200730/crypto/crypto_engine.c
@@ -465,7 +465,7 @@ EXPORT_SYMBOL_GPL(crypto_engine_stop);
  * crypto-engine queue.
  * @dev: the device attached with one hardware engine
  * @retry_support: whether hardware has support for retry mechanism
- * @cbk_do_batch: pointer to a callback function to be invoked when executing a
+ * @cbk_do_batch: pointer to a callback function to be invoked when executing
  *                a batch of requests.
  *                This has the form:
  *                callback(struct crypto_engine *engine)
