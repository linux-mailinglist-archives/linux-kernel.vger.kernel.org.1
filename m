Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBA233D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 04:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgGaCje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 22:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgGaCjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:39:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CBEC061575;
        Thu, 30 Jul 2020 19:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bLNhGelRV1dGxFjBBULp6vMKJECZqGyT7EMALWJ4atg=; b=eHOCE6nacGkcOipLlZauA05XUf
        Utow6SgUolC3TuSQX7kgjLTNRIXQnRqv1IvOzNTj1xZAUrJDBhtgG1YYSI5DdjdP1Q/yHi1S2Uldx
        wtjxe0TUThm4qWZ2tjE/3zDKzhAt05dU891HlpLnZPU6mLpgI2hiK6CknDvUjxvKbrx5jSNcdgjG6
        Qt2yRnqvQ4Tr//+BNHjNrdzrE6IcTYGqIrgsg0uJ9zesqqTWGOTi8Qknu4UuNiXoTYyEyZjpQ8KaT
        gDBoDi5C/Q0+uy4l7kMhFDP8ts9CxlRvEqh6g3GWFQS6dnvGUC7b8rUNeIwkjhHQoB5YeXzDmix96
        CrP9meiw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1KxG-0001o3-VT; Fri, 31 Jul 2020 02:39:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 1/6] crypto: algif_aead: delete duplicated word
Date:   Thu, 30 Jul 2020 19:39:19 -0700
Message-Id: <20200731023924.8829-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731023924.8829-1-rdunlap@infradead.org>
References: <20200731023924.8829-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/algif_aead.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/crypto/algif_aead.c
+++ linux-next-20200730/crypto/algif_aead.c
@@ -120,7 +120,7 @@ static int _aead_recvmsg(struct socket *
 
 	/*
 	 * Make sure sufficient data is present -- note, the same check is
-	 * is also present in sendmsg/sendpage. The checks in sendpage/sendmsg
+	 * also present in sendmsg/sendpage. The checks in sendpage/sendmsg
 	 * shall provide an information to the data sender that something is
 	 * wrong, but they are irrelevant to maintain the kernel integrity.
 	 * We need this check here too in case user space decides to not honor
