Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469092E3213
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgL0RTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgL0RTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:19:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA85C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/+c9pOaV0/kDhj+PvJMnlw5NkCnX1ZZEc2bZWQnlqLg=; b=OEUJacxzMj+ZTnclz7hsPrxnD2
        AwcxGMIHe8wyonENWv7KM9dInTYz4eIMlol5xWGQXXepLOngjIMHwSMTV7gkF1zWOSSHvTF7yBJCj
        HHzxY2u340Gs3MTuYCTN/um2za96SU5Vb5iaqXRQOM0PUsnDIVZA0I6nZm83crQBxko74VbqXU1KY
        hEKyF4l9xpfl7JFzhNCnatCR2FSfX1o2gwVRTq0CNxNLCfbKOAxg3JDfzj1iEh+MUAzcV2FCAKM3/
        2QhpcO/VS87Vl92SdwxFtAo7n2UaON1sRtypIomu4aav40t/pmz1O29Fk8NhfGZgak+PFI0RUI5J5
        Qc2xFsaQ==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktZgs-0000yj-Ep; Sun, 27 Dec 2020 17:18:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Zaslonko Mikhail <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH -mmotm] lib/zlib: dfltcc: remove dfltcc_syms.o from Makefile
Date:   Sun, 27 Dec 2020 09:18:37 -0800
Message-Id: <20201227171837.15492-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, missed removing this deleted file from the Makefile.

make[3]: *** No rule to make target 'lib/zlib_dfltcc/dfltcc_syms.o', needed by 'lib/zlib_dfltcc/built-in.a'.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
Andrew, please fold into
zlib-move-export_symbol-and-module_license-out-of-dfltcc_symsc.patch.

 lib/zlib_dfltcc/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201218.orig/lib/zlib_dfltcc/Makefile
+++ linux-next-20201218/lib/zlib_dfltcc/Makefile
@@ -8,4 +8,4 @@
 
 obj-$(CONFIG_ZLIB_DFLTCC) += zlib_dfltcc.o
 
-zlib_dfltcc-objs := dfltcc.o dfltcc_deflate.o dfltcc_inflate.o dfltcc_syms.o
+zlib_dfltcc-objs := dfltcc.o dfltcc_deflate.o dfltcc_inflate.o
