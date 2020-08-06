Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5918423DEA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgHFR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgHFRBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD6C002155;
        Thu,  6 Aug 2020 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PU1hlLez9HFKz8CgpPifAYdDLprH2RocDtgwJsP85LM=; b=ENkwSSGdx2LSzvUABPwjqYOANd
        ifvY1+CepdfnVajnqH2AmfP+rB2fZ6b/+WA0FyQ8S9+OZr6VgE6eGl4xtBMnUgUYjl7PLnnipj8Jj
        dTicEmLevbaF4cuFnoN4NRsGcW86qejMLYeam2g361KaPGDENhuUGyJ+cWoSaNR/rjHiUtyRt5+9u
        OWl7vp/34l3r30hEeaCBO4LdjhvXagbEA463Bg+uhKeUbDFZb2HdChZCDeh9gJUja7sP/+KOIqXPZ
        SpcopnbWpaYzw9LcT/3vpWI9NIj2UjiEs9lyyYK8gRiFSU1lZcNS08ujpsXS/b7YVU9UItJ9evCBR
        vyg5J9hA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3iEG-0000lo-4y; Thu, 06 Aug 2020 15:54:53 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Cc:     Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] crypto: sa2ul: add Kconfig selects to fix build error
Message-ID: <6e04b405-7369-ff04-a2dd-aa7c561e13d6@infradead.org>
Date:   Thu, 6 Aug 2020 08:54:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

sa2ul.c uses sha{1,256,512}_zero_message_hash, so select the
Kconfig symbols that provide those, like other crypto drivers do.

Fixes this build error:

ld: drivers/crypto/sa2ul.o: in function `sa_sha_digest':
sa2ul.c:(.text+0x2b25): undefined reference to `sha512_zero_message_hash'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org> # 2020-07-29
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
---
 drivers/crypto/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20200806.orig/drivers/crypto/Kconfig
+++ linux-next-20200806/drivers/crypto/Kconfig
@@ -873,6 +873,9 @@ config CRYPTO_DEV_SA2UL
 	select CRYPTO_AES
 	select CRYPTO_AES_ARM64
 	select CRYPTO_ALGAPI
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 	select HW_RANDOM
 	select SG_SPLIT
 	help

