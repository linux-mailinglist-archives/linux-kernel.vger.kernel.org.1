Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0126EF17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgIRCdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgIRCNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:13:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6813C06174A;
        Thu, 17 Sep 2020 19:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MTBEQQc8z+hHIyvPKMuXIo95gbEfyZK1ljgIh8WDqpk=; b=GQMz+Vjns4H0IdjtD9CkVY4+gQ
        gSlkHxnl75OwTD0eFG25bAyc5mK/tqZkP3DtjkhqT4h2iSXH7UkVgHJxuR+9hnNXBiH9XOl4GpVt8
        G+EktKgApInEGWvMz8lliXLqmaHzrFBPincQCAe0rfHKK7t1Ynr18rQc0j+cZa/sUcjVJOLPl4YqI
        T+R274Br3UkTtCyoY1YWObTzx+9M0EVQVJrwUZ1JyonXidNJP+n/PtEf91/far4uFyZ83DHdgo7ZJ
        t0tZeFKo3ddWSvjpYyEpCn1E5CzoPXx88qqzQb71Dsy2lz/4dB0Ts3Hz2piyqEKINTle11Le35+bR
        5BMEgMRA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ5uJ-0001Hf-Ut; Fri, 18 Sep 2020 02:13:52 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 RESEND +TRIVIAL] hexagon: fix punctuation in SMP Kconfig
 help text
Message-ID: <74b18943-7e57-9eae-fec3-d9f83cfb7862@infradead.org>
Date:   Thu, 17 Sep 2020 19:13:49 -0700
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

End a sentence with a period ('.') in SMP help text.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>
---
v2: rebase from JAN-2020 to current.

 arch/hexagon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200917.orig/arch/hexagon/Kconfig
+++ linux-next-20200917/arch/hexagon/Kconfig
@@ -106,7 +106,7 @@ config CMDLINE
 config SMP
 	bool "Multi-Processing support"
 	help
-	  Enables SMP support in the kernel.  If unsure, say "Y"
+	  Enables SMP support in the kernel.  If unsure, say "Y".
 
 config NR_CPUS
 	int "Maximum number of CPUs" if SMP

