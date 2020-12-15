Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5542DB42D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbgLOTBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:01:14 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:47655 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbgLOTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:00:56 -0500
Received: from orion.localdomain ([95.118.67.37]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Md6hP-1kGSfL2vJL-00aC59; Tue, 15 Dec 2020 19:57:52 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: [PATCH v2] arch: x86: entry: vdso: fix type conversion on printf() call
Date:   Tue, 15 Dec 2020 19:57:51 +0100
Message-Id: <20201215185751.14384-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:G3CmrqdUmfEWhtR0G/ykp2FC0koTsURzyQESHLIoxvEkL0lYkPE
 x9b9E9xa5vWYhlkw2mJKBapIgSoC2or6atWZ3K3Fut9bzVSKKkCNum7i/2zNZ2djq3F2GPe
 wNpb9/QQXJ29enuiqPnAx1ID6mfbVSILqrGeUBF1zd6678mEgqmNTXEKveiVEUwfap2ZoP7
 L9VKq3UNpZYY+tnxtoXWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:avHAVr0/hXw=:zUGnc41SOQQp+wiU2gyTUY
 E1r1xJjVV2OLwmU4424tPkRzr/D2QnjAktV5LoGJnMut/+SnNq0C7TikmEUh16xotLoM/AjN4
 TcMR71rosg5Zy8hkBRhIdSVCsCQlpB+2ApgB9w7OYWkWgBtg0xQMGfUomJMzYLpF9tv4fuLAu
 B4xTEBwuFw01WA8AkBAukBBmPpULo/UqMIsewhi8L393PjqJKkyvF3sSl7+KBstyXQH8C2rvd
 6mQ8k3gwoqVqLla5S4VcwbCurjmHx+xtYVgSY6G2TULGWTUaVWyazpTTEtlJB28R/+xpPR4pP
 KG7FB+GSm5syA//MEOvor92q1NFzGBJV5bKEhZuGQEhpmZ7wu5z6zNINssDstIM/KomLNIrq5
 2rWNB4VoU+ixC/dzBFHoWCqEQs3hLGVrxLhwS6GJw5BaK0az5JuwxeIz2qkyM
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

