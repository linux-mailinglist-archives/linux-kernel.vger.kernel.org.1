Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2813D26EEF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgIRCcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgIRCOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:14:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E0C06174A;
        Thu, 17 Sep 2020 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2zygmWVZoej39+C7l35XnbHqOEaCkXczwN4GbAnVcXY=; b=p4wWAcycwYnfum1OoWGuS54bKN
        RUBksBagsiyc6QSsORgx0ljgcWDx5gQ4pbDnJM8wJs/51+bgMPj+CMB6OLgqbZIBbUuGwDIL4+2lP
        Wjq1610pX9gTout1u75QwKszBqYHoROAhFGcXSfWC9UVpdJmud4/wrx4Wuhy96Pp8wQBfaNg+Rxdo
        A6l8dltODV9iRbZa+2t5UxpdQa95wIhTDqLEoig8wdZqyi7ztgDHhZ/mUSlm0VcuvDgSHyH4Oa1fV
        XwrCaOkhS2SGz/Y6qTceKa3K/yWSa7g+dpLYsZm0ruimYhyrI1wTzewpLvJCCwk+u2zX+gC/Q9Olp
        OecYfHug==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ5uZ-0001Ja-FG; Fri, 18 Sep 2020 02:14:07 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 RESEND +TRIVIAL] arch/sh: hyphenate Non-Uniform in Kconfig
 prompt
Message-ID: <93d98bab-01dd-5530-9fdb-76faf8dcdd41@infradead.org>
Date:   Thu, 17 Sep 2020 19:14:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Hyphenate Non-Uniform in the NUMA kconfig prompt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>
---
v2: rebase from JAN-2020 to current.

 arch/sh/mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200917.orig/arch/sh/mm/Kconfig
+++ linux-next-20200917/arch/sh/mm/Kconfig
@@ -105,7 +105,7 @@ config VSYSCALL
 	  (the default value) say Y.
 
 config NUMA
-	bool "Non Uniform Memory Access (NUMA) Support"
+	bool "Non-Uniform Memory Access (NUMA) Support"
 	depends on MMU && SYS_SUPPORTS_NUMA
 	select ARCH_WANT_NUMA_VARIABLE_LOCALITY
 	default n

