Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFF7253E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgH0Go4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 02:44:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46838 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0Goy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:44:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id h19so5137136ljg.13;
        Wed, 26 Aug 2020 23:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/nPRgHC0iGFykXQ1veAuL/EAakIUq9/Zg/UORe3DVo=;
        b=KplhNYR/Q7PpC8q3Dd+2RjcTfCDWnusVGHzwlYkOjxB3pJv2RAKyrOjIhaXq5PIARC
         6+Ock68WsYxgNgaD/crEy+mwc/72EU+f8Opnhei7Th0qlxehZhHzH+aql+NpWZqmsWrw
         M3yBLqm70qBRd7YsLEl9aXMMTziNj6EB6m5Fwy+1sEED88In8tKBtgaRHhWjZLLACRHI
         l5w1kLuQb0eoarwGhSbMV0cyzLkEZbVWQjRfPdt3BYYt3X/6C/rCr1IcMMoFEzQEI+Zu
         4svy+qVzg+s/tAsAe0ZwLZA/c8cjTkZHcjBaipWF6qp5Td86OJrcjtvKYmWHJ1ik0RUg
         4aQw==
X-Gm-Message-State: AOAM533bkU0r1FpnmhiCiWN2Py8MJX+0Tznq9PJ0uIdQYcPAXaMzEgn7
        Iy7oqNqnyP/GhivLMe6o34MQdxpUFxE=
X-Google-Smtp-Source: ABdhPJz+PdSPsiaJMGDnJnGpAH3k5yyMkhsoQ8EYD5eusfK2iGv6+RkA691Am5KjrG43htjux6RP7Q==
X-Received: by 2002:a2e:558:: with SMTP id 85mr1670859ljf.293.1598510692176;
        Wed, 26 Aug 2020 23:44:52 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id j17sm282159lfr.32.2020.08.26.23.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 23:44:51 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-crypto@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] crypto: inside-secure - use kfree_sensitive()
Date:   Thu, 27 Aug 2020 09:43:59 +0300
Message-Id: <20200827064402.7130-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827064402.7130-1-efremov@linux.com>
References: <20200827064402.7130-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfree_sensitive() instead of open-coding it.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/crypto/inside-secure/safexcel_hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 16a467969d8e..5ffdc1cd5847 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -1082,8 +1082,7 @@ static int safexcel_hmac_init_pad(struct ahash_request *areq,
 		}
 
 		/* Avoid leaking */
-		memzero_explicit(keydup, keylen);
-		kfree(keydup);
+		kfree_sensitive(keydup);
 
 		if (ret)
 			return ret;
-- 
2.26.2

