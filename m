Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F49F2CF294
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbgLDRE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388372AbgLDRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:04:57 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E36DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:04:17 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfF92VWCz8shq;
        Fri,  4 Dec 2020 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101453;
        bh=pcx4bdCqtYoyasDxerbHaMW2oPefW6LT9MYTykBA8mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wr45lBTRh4bvZhOB7dp1t/o7dOVBjjyB9m6x7lWGS1TekHfVLA0zDOjvPE1646o1q
         1NXOJRIHJFRiCDC8/4lTqfX+kd7D/mdi1/YPhcsXtjhDV3IlwDEPCxFNCmKDYNh8EM
         fl4kQOY4IR2J/pW1UWGV1r2vffChfZN+Vfo7W/Sw=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfF86X8Qz8sfb;
        Fri,  4 Dec 2020 17:04:12 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     Russell King <linux@armlinux.org.uk>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 01/12] arm: Replace strstarts() by str_has_prefix().
Date:   Fri,  4 Dec 2020 18:03:07 +0100
Message-Id: <20201204170319.20383-2-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The two functions indicates if a string begins with a given prefix.
The only difference is that strstarts() returns a bool while str_has_prefix()
returns the length of the prefix if the string begins with it or 0 otherwise.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 arch/arm/kernel/module.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index e15444b25ca0..a8cbd040bcfc 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -56,16 +56,16 @@ void *module_alloc(unsigned long size)
 
 bool module_init_section(const char *name)
 {
-	return strstarts(name, ".init") ||
-		strstarts(name, ".ARM.extab.init") ||
-		strstarts(name, ".ARM.exidx.init");
+	return str_has_prefix(name, ".init") ||
+		str_has_prefix(name, ".ARM.extab.init") ||
+		str_has_prefix(name, ".ARM.exidx.init");
 }
 
 bool module_exit_section(const char *name)
 {
-	return strstarts(name, ".exit") ||
-		strstarts(name, ".ARM.extab.exit") ||
-		strstarts(name, ".ARM.exidx.exit");
+	return str_has_prefix(name, ".exit") ||
+		str_has_prefix(name, ".ARM.extab.exit") ||
+		str_has_prefix(name, ".ARM.exidx.exit");
 }
 
 int
-- 
2.20.1

