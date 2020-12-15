Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BEB2DB429
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbgLOS7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:59:47 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:52995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbgLOS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:59:40 -0500
Received: from orion.localdomain ([95.118.67.37]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MaIGB-1kczXG16QP-00WIGY; Tue, 15 Dec 2020 19:56:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: [PATCH] arch: x86: entry: vdso: fix type conversion on printf() call
Date:   Tue, 15 Dec 2020 19:56:37 +0100
Message-Id: <20201215185637.12928-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:ldlnzBukqABl0LEGw2DuGZcn/Cht+bBczJb0Rn9EYWZ0ddzfJ0H
 9dewibVQ/xc7bgtoV68FiDwwzG4FBvT9gHzypbgaZjImrwdii7czweVns4UtNXNuTlxRy4F
 mzAHfkYUeb2yOFPWm3wAOU1ivxNgIOLQBHy8LlOf7jXZtonSxDvvZMRoFHAuwhVX+YICIpx
 Dxi+mnylh7Cx4GypTH4jQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nny5agXxo8I=:IYtQO8XoB96ur7vLHEvl8N
 CA47hPyU86H+sT6gS5XcEP+4yo+Ph4gZ4oxIPNMP89wnH7E4T8qcqlEGbPMDu52ZEbCg9j6gb
 ORWeyqFz45ZiBET1N4IY2D6CvEg+rLYvSCMxF3mN3pYhdGUGaI2P0cwh3FTASADdyiLVrq+5U
 +CeWonN2KPHiuFi0Af4leMgb3SLa7ApeK6T8FjgvH9u+EgUdxq1CtDt/38Qmhv6Pfc0m6HWG3
 CNX1DKNdqcKuWA0az7vRbjs+25EZqaDU7kSM0ZoHaZ9jOfrqLm7vZinSqQ8PmQgZFVsfvB0lY
 X/RZczJbTCTZuF8kNYE/6gldDtexd5978SB98/tLo/DjJ6FkbRur7Y4CLOCJRfn0BOtmQqm1z
 aACuVVHDQygBmEWK1vStcY88GvVV9ouvlo2aqxsxIOslKulAs/dzALO16+Ib1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing the following compiler warning by explicit conversion to long:

In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:162:0:
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
  fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
                                                    ^
  CC      mm/filemap.o
In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:166:0:
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
  fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

---

changes v2: using %zu instead of %lu, which is the preferred conversion
            for size_t - the line break isn't needed anymore
---
 arch/x86/entry/vdso/vdso2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 1c7cfac7e64a..5264daa8859f 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -35,7 +35,7 @@ static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
 	if (offset + len > data_len)
 		fail("section to extract overruns input data");
 
-	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
+	fprintf(outfile, "static const unsigned char %s[%zu] = {", name, len);
 	BITSFUNC(copy)(outfile, data + offset, len);
 	fprintf(outfile, "\n};\n\n");
 }
-- 
2.11.0

