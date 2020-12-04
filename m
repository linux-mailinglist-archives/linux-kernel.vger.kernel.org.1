Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7862CF2A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbgLDRFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388471AbgLDRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:05:37 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F42FC08C5F2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:04:42 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfFj1fQrz8sj3;
        Fri,  4 Dec 2020 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101481;
        bh=d4QCZegIOf+Vy1A4PMIzIYogd0Y22GwmWmem0sTfec0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhHcNpzXoqW05GpgdY0vhV6+NGeAmP4c2/2KXsNYvqMbTANB0m9pnXJZzNciGHIqg
         vvk9HvXmYPJIfReW57cMDMVxJgMm0ruuqz43WMpjMc9nQ0NemTn5hoQMbdw9hKAAmK
         cUG8glOZi3uWy3i0T6voO0zr06H34q16jmPXiNyM=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfFh6LpJz8sj2;
        Fri,  4 Dec 2020 17:04:40 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 10/12] module: Replace strstarts() by str_has_prefix().
Date:   Fri,  4 Dec 2020 18:03:16 +0100
Message-Id: <20201204170319.20383-11-laniel_francis@privacyrequired.com>
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
 kernel/module.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index a4fa44a652a7..d01466f1d2a6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2675,7 +2675,7 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
 		else
 			return 'b';
 	}
-	if (strstarts(info->secstrings + sechdrs[sym->st_shndx].sh_name,
+	if (str_has_prefix(info->secstrings + sechdrs[sym->st_shndx].sh_name,
 		      ".debug")) {
 		return 'n';
 	}
@@ -2842,12 +2842,12 @@ void * __weak module_alloc(unsigned long size)
 
 bool __weak module_init_section(const char *name)
 {
-	return strstarts(name, ".init");
+	return str_has_prefix(name, ".init");
 }
 
 bool __weak module_exit_section(const char *name)
 {
-	return strstarts(name, ".exit");
+	return str_has_prefix(name, ".exit");
 }
 
 #ifdef CONFIG_DEBUG_KMEMLEAK
-- 
2.20.1

