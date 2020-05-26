Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808BB1C5783
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgEENym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 09:54:42 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgEENym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:54:42 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8nnU-1j2qMm3NRe-015q6x; Tue, 05 May 2020 15:54:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] crypto: blake2b - Fix clang optimization for ARMv7-M
Date:   Tue,  5 May 2020 15:53:45 +0200
Message-Id: <20200505135402.29356-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Jcy6N4TaUxzCTLGwDtoilz/VHBm8v5Cw2d3wSP9VaYY8DkkSDHc
 IjwbOhFL9N5vR7J3y8bL/HUgEQnv+/SEY1R6u5YlCOKSjKCeyDhZKQbc7NIMiMLvgLL9X0M
 ss0Dt2APwE1Lac9XpGyvrEmmt3SkvzgIZ/aqUw7TCW6ToUqhFuq0wwYhBIdXnNsP3ZbzwWV
 MVb8xIdXIzPH3B8jw2rpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FPPapW6OwyU=:sEXclkv4xPKGjOnt9Uta2g
 hkqp13EKC3+UOv0CEpd3Yxb8ku6UzK4m/CBCOryA8h19RJPscvHigxY6u5s5trj+X6OTpBzLa
 cP8nvCiII6HHi0fqR1tmrDAakapg24SczjInVPUkWOfxrq7ZU0Yjg81RcahSuenhO3KcF3U24
 RZ1NIKhkiRTxshPT8cfU2ILWholcmBtT6T5BDpgyyojL1hEsXgNpMGqR8vqnRwNDIUMucnN+h
 UG75soVBhGog7nkc3POBjgMMoJAFQGxcANnsv5GQcfZDied5/ov7luD5kLiXinGakUi+SnXK8
 CXKhlNDmNUktwMj2ezTPm/iQbfEtXGDqK8sW7ugqUaNl7hXZSp8tNq651fyewNk3HWpsnOgUm
 C27a/IyGBQPFe/lLgnPoX9kGhjENlTLLbESf+ebr2K0XgLzNWVttSPSd4qsoZtJsSivrrWfkG
 UAuoQBzqlWibuGEXAtw8LhI0l63m5vMK+H9EF5eSeEKJDkI3pWMKdbigaeHJOeFBddyLfxmbZ
 Wlz7q2qXPuFk9xBv2mUJNoW5MBehuyGwWv34y89Qqm1aKVPHOqX8olmTVGoE+sotqmwxYDayE
 SEvRyDZiepoEOehh078W3aoVC5KuTJuxUJSyjOdbQDnihCDCXN2pmSoDXA/gq11JjURDzDZCn
 gAk9emAk/PGP+pV2hPQ0mq2kel2UmqjsB3Gssfa6YjWyIZas/gy9PsqjCuys6bStZLbzOyiuL
 sFxp2GRdvXm60XuBgRprUAFyWZ2L7+2ujJSYBl4W/AY7uqSrl7jsj76o+DM/KV9HedOjLoARp
 zB0ISZaI95xb6BoxaptJWDjFl03AaYhkaWDVOezyZF5/FLzwWg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building for ARMv7-M, clang-9 or higher tries to unroll some loops,
which ends up confusing the register allocator to the point of generating
rather bad code and using more than the warning limit for stack frames:

warning: stack frame size of 1200 bytes in function 'blake2b_compress' [-Wframe-larger-than=]

Forcing it to not unroll the final loop avoids this problem.

Fixes: 91d689337fe8 ("crypto: blake2b - add blake2b generic implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/blake2b_generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
index 1d262374fa4e..0ffd8d92e308 100644
--- a/crypto/blake2b_generic.c
+++ b/crypto/blake2b_generic.c
@@ -129,7 +129,9 @@ static void blake2b_compress(struct blake2b_state *S,
 	ROUND(9);
 	ROUND(10);
 	ROUND(11);
-
+#ifdef CONFIG_CC_IS_CLANG
+#pragma nounroll /* https://bugs.llvm.org/show_bug.cgi?id=45803 */
+#endif
 	for (i = 0; i < 8; ++i)
 		S->h[i] = S->h[i] ^ v[i] ^ v[i + 8];
 }
-- 
2.26.0

