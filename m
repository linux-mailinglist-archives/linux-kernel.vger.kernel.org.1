Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4EF1FC484
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 05:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgFQDMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 23:12:25 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:45032 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQDMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:12:24 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 05H3Bw20000949;
        Wed, 17 Jun 2020 12:11:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 05H3Bw20000949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592363520;
        bh=gK+XsFYZkU4y7SHt2/4a5PTKhsJbY3z5Jtdt+MhtyNs=;
        h=From:To:Cc:Subject:Date:From;
        b=AGWBhNf2ZMwPiSeTcoTfNjzwWnonzQur03c8L5CdDjHAUtwPhoVdyzlnEk1m17kkd
         xmr7HMAPVUMeEs2+I1s1vcJJe/RYy45OGpqJYs6Vjvjl1H3qbtMlCxrVjNiudJMsTM
         AyYXxl0pBlTumkiAQpKkTFLay4alYKkBfPqi6wut4FsaEsR32dQwiDIhqjjf1Vpkqa
         5bmFZUlBm4ZgIKJLK72MIsQLJPBTRlRr1kl1PgZfIGg7gEEVJeI7RYPN/syRN8rZfG
         YA2EblLjey3EF0l7yau84+OCd+WZzFU2lF8CgATDjtkpHF2ELJpTca0l5GfT5YMmYc
         D0G35ppTNsDRA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: use CLEAN_FILES to clean up files
Date:   Wed, 17 Jun 2020 12:11:53 +0900
Message-Id: <20200617031153.85858-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The log of 'make ARCH=m68k clean' does not look nice.

$ make ARCH=m68k clean
  CLEAN   arch/m68k/kernel
  [ snip ]
  CLEAN   usr
rm -f vmlinux.gz vmlinux.bz2
  CLEAN   vmlinux.symvers modules.builtin modules.builtin.modinfo

Use CLEAN_FILES to simplify the code, and beautify the log.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 24072fb99680..4d569c3ab9fd 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -140,8 +140,7 @@ else
 	$(KBZIP2) -1c vmlinux >vmlinux.bz2
 endif
 
-archclean:
-	rm -f vmlinux.gz vmlinux.bz2
+CLEAN_FILES += vmlinux.gz vmlinux.bz2
 
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/m68k/kernel/syscalls all
-- 
2.25.1

