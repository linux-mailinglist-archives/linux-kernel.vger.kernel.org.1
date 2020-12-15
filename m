Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3972DB0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgLOQGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:06:48 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbgLOQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:06:15 -0500
Received: from orion.localdomain ([95.118.67.37]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNbxN-1kRjhP0DLH-00P1jl; Tue, 15 Dec 2020 17:03:16 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: [PATCH] arch: x86: entry: vdso: fix type conversion on printf() call
Date:   Tue, 15 Dec 2020 17:03:14 +0100
Message-Id: <20201215160314.18773-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:JzHbgCr4Qa+PNcENezKA19H1/mt3NmTPFDxabwQbhnvxw3NZeQQ
 8rJ1t3ixoKo7Jq4CyADtrEdZVePFRLDya6L0dccTLKZC3cbw98TmdNMAsl8nNiEKilec9KV
 +o9DDDrQcUcrGkXJuhxC5pp1ifkT1w4rVwfNhDD7gmw4TOUzzK3s0aePPyfNJsmNoiSUv7u
 SPpu7fzTUi/2/CF6xktwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MA2YWpZ1KQo=:n6Zi2ZQtLjfKo1FzIfMFXX
 qdZYFoe9WNg9XHosa45RshPPi+0xkzPyP+BDYCSecNSI//JAFzkope5WP2CaGMuoakZ1Hw6Jp
 B487THCYlWudRAxde8jWj/QwXZF7PjPJ3sKrAgyYidsXtnbrx05hkrn3eod9uNU56qQU9Q6+t
 ze0a0beU5C4cqDneDz+9THDDXYj0WaEWuXPrDlj5lCEcE1Mvismc6bLdOH76IEgyka3KwC3F8
 OERG2Hdy3vBmoK5Yr6mua20qjQF5091GhlRsVA6kH/coeHJKmnNJj1EUvj7c9Rb3cll7PlnS4
 LNtmujj58+JEfNkgLulRMEcmt7wCrUICY4LsBy6Ix1LQbq/qptCw322LzAaRS3puxGjqKctcc
 GGVZs3ZLPng8DPERX9qow3aLJXi+XbvG4bvO+L/85W+H40Inr0KYDezi35KO6
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
 arch/x86/entry/vdso/vdso2c.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 1c7cfac7e64a..5c6a4bbc63f9 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -35,7 +35,8 @@ static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
 	if (offset + len > data_len)
 		fail("section to extract overruns input data");
 
-	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
+	fprintf(outfile, "static const unsigned char %s[%lu] = {", name,
+		(unsigned long)len);
 	BITSFUNC(copy)(outfile, data + offset, len);
 	fprintf(outfile, "\n};\n\n");
 }
-- 
2.11.0

