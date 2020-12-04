Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243002CF29A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbgLDRF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbgLDRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:05:26 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA380C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:04:24 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfFM5VFHz8shq;
        Fri,  4 Dec 2020 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101463;
        bh=kvzBsH3Xpl7b8xgX8SGrBkieorIiMIG1baA8viuZhDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9+/dCUDR9K4HnTdV8GeKq5Oth3qwoJtratv/XxCi7TwxkITR+Hzp3v4rLmrEnlYP
         vnH/kufSF82RrOvkxSB7ULnvUWyWaaYM/E9y0Zwvt3MTr0uFxw8kmOmWB1QHrWnoe7
         fM60XKJCReep7YUY2ukvbMZ+8YX5zIWmFqTLBJaE=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfFM0n5Sz8sfb;
        Fri,  4 Dec 2020 17:04:22 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 04/12] device-mapper: Replace strstarts() by str_has_prefix().
Date:   Fri,  4 Dec 2020 18:03:10 +0100
Message-Id: <20201204170319.20383-5-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The two functions indicates if a string begins with a given prefix.
The only difference is that strstarts() returns a bool while str_has_prefix()
returns the length of the prefix if the string begins with it or 0 otherwise.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 drivers/md/dm-crypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 392337f16ecf..b6f31b662d93 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2659,7 +2659,7 @@ static int crypt_ctr_auth_cipher(struct crypt_config *cc, char *cipher_api)
 	char *start, *end, *mac_alg = NULL;
 	struct crypto_ahash *mac;
 
-	if (!strstarts(cipher_api, "authenc("))
+	if (!str_has_prefix(cipher_api, "authenc("))
 		return 0;
 
 	start = strchr(cipher_api, '(');
@@ -2858,7 +2858,7 @@ static int crypt_ctr_cipher(struct dm_target *ti, char *cipher_in, char *key)
 		return -ENOMEM;
 	}
 
-	if (strstarts(cipher_in, "capi:"))
+	if (str_has_prefix(cipher_in, "capi:"))
 		ret = crypt_ctr_cipher_new(ti, cipher_in, key, &ivmode, &ivopts);
 	else
 		ret = crypt_ctr_cipher_old(ti, cipher_in, key, &ivmode, &ivopts);
-- 
2.20.1

