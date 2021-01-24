Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5A301C9F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 15:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbhAXONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 09:13:06 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:23624 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhAXOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 09:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611497405;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=Y189rnv2QfUxhT1OemVIrE8/eQASWIoiVDAuFGKd78c=;
        b=MKMxeVGgO3urtqs8LI6KYUBu0BHXm7rR/QmnGYlEedG3chM+TEM+tquFR7rkMbFQIc
        2IRfEQhrT9BwYrybAumYQPwHvUrN1vuQy/6/566pwWSs0ar3Ok/U/BLvbOasxBCwl3tq
        Om4G341vIDXPizW9IzhOIoygHK/+UZXzs6Fk7GIGcXDEl8FkTLZmPzcB3+nyWa5DlY2w
        tmbVWpkg5hfMJn4+Tgdrn0lO0QN6Tq0BTSoZV6A9ylec3mTohGiZc7LgrduXN7Z3ym+T
        k0bjKJGjcdtBmWBRIJ86wp2AZ59/MqTTW52Ib679qZteQ0ltPxu+i8J90eN4pY+bcvfA
        k0jA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZI/ScIzb9"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id Z04c46x0OE6feiU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 24 Jan 2021 15:06:41 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     herbert@gondor.apana.org.au
Cc:     ebiggers@kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        mathew.j.martineau@linux.intel.com, dhowells@redhat.com,
        linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        simo@redhat.com
Subject: [PATCH v2 7/7] fs: HKDF - remove duplicate memory clearing
Date:   Sun, 24 Jan 2021 15:04:50 +0100
Message-ID: <8714658.CDJkKcVGEf@positron.chronox.de>
In-Reply-To: <1772794.tdWV9SEqCh@positron.chronox.de>
References: <1772794.tdWV9SEqCh@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clearing of the OKM memory buffer in case of an error is already
performed by the HKDF implementation crypto_hkdf_expand. Thus, the
code clearing is not needed any more in the file system code base.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 fs/crypto/hkdf.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
index ae236b42b1f0..c48dd8ca3a46 100644
--- a/fs/crypto/hkdf.c
+++ b/fs/crypto/hkdf.c
@@ -102,13 +102,10 @@ int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 		.iov_base = (u8 *)info,
 		.iov_len = infolen,
 	} };
-	int err = crypto_hkdf_expand(hkdf->hmac_tfm,
-				     info_iov, ARRAY_SIZE(info_iov),
-				     okm, okmlen);
 
-	if (unlikely(err))
-		memzero_explicit(okm, okmlen); /* so caller doesn't need to */
-	return err;
+	return crypto_hkdf_expand(hkdf->hmac_tfm,
+				  info_iov, ARRAY_SIZE(info_iov),
+				  okm, okmlen);
 }
 
 void fscrypt_destroy_hkdf(struct fscrypt_hkdf *hkdf)
-- 
2.26.2




