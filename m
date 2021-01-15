Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32D2F852B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbhAOTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbhAOTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:12:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0493C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=97EbPmBOmEAiBPBdi5v4C1/U9Nu8MZDKrWuawwATbk4=; b=NylniFpYzdRNq7XYSg5yfbUrUr
        smVYQAcX0LAfJ+WE0dfbDYvsBUKZwhUrXlYlJqIpiNSkZMHiFGmSe7V+StdyGMQCCrjKKUnCELEDf
        NBw/AshIaCAtGJMVp1LBlg/2U2FOX6t2pD41hYK4a+S3wWUuWnTcFV8su8qNLdYlPsDrcgQGQNAMc
        oZ0KoVvo3F5T16SnGcpGEAN0BdmgDnMnHzdp3hXkBZveVXUuw8p1aJ1fKqbJQ+FJ3bdEYNtZb8p5g
        7dRPH7Rad3RLAsdSF3N4Ko1HmifTcJc/ai2gIBM9g4/Zw+ujMbx7Zfqzk16tZlq9vK++W/B2Y+XN7
        vta/TSlQ==;
Received: from [2601:1c0:6280:3f0::9abc] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0UVP-0007kz-Jb; Fri, 15 Jan 2021 19:11:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH -next] x86/xen: fix 'nopvspin' build error
Date:   Fri, 15 Jan 2021 11:11:23 -0800
Message-Id: <20210115191123.27572-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error in x86/xen/ when PARAVIRT_SPINLOCKS is not enabled.

Fixes this build error:

../arch/x86/xen/smp_hvm.c: In function ‘xen_hvm_smp_init’:
../arch/x86/xen/smp_hvm.c:77:3: error: ‘nopvspin’ undeclared (first use in this function)
   nopvspin = true;

Fixes: 3d7746bea925 ("x86/xen: Fix xen_hvm_smp_init() when vector callback not available")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Juergen Gross <jgross@suse.com>
---
I tried to use IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) on the if line
and on the nopvspin assignment line but both of those failed for me--
using gcc 7.5.0.

 arch/x86/xen/smp_hvm.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20210115.orig/arch/x86/xen/smp_hvm.c
+++ linux-next-20210115/arch/x86/xen/smp_hvm.c
@@ -74,7 +74,9 @@ void __init xen_hvm_smp_init(void)
 	smp_ops.cpu_die = xen_hvm_cpu_die;
 
 	if (!xen_have_vector_callback) {
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 		nopvspin = true;
+#endif
 		return;
 	}
 
