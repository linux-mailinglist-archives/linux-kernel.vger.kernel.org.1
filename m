Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83F26F574
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIRFrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIRFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:47:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19FBC06174A;
        Thu, 17 Sep 2020 22:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qor3phhqiufDpB9uGvz5vGgi3ZV5sdxcbDSrWuLPMOY=; b=grcu/lU5Q9nRTbUWG/3hm+UHcB
        ZZIbJWHNkz0myCgix+YfA1XZ9R49wjnw8T9FjVJQL37Hf3b98NR8SpVsGAhlUMCGQf/MZ5Fca+d5i
        xR5EAwuyMLOMrXYfZRosPSAqdLPUEpDOCMuGd9BjoYIw4H6rXUk0qHAY3/pJruMv010MIrAYJi3PT
        Mu8wzcQA8rMO7Ii+sadD/URCCZRQSFVbiUiLeMHIKPHJwOeNgpjD/nCCsJdXdeJ+dYjJL8sXKhPtL
        dGg8GCuqxar9Sf0u60JwLHsWZMpwDG/y+uUhMs87EIz6yqtd23B5NyCFRmU1boju7tOaqErnJzDoK
        yd/oTLzg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ9F3-00026d-GD; Fri, 18 Sep 2020 05:47:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/admin-guide: kernel-parameters: capitalize Korina
Date:   Thu, 17 Sep 2020 22:47:22 -0700
Message-Id: <20200918054722.28713-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo, capitalize Korina proper noun.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200917.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20200917/Documentation/admin-guide/kernel-parameters.txt
@@ -2194,7 +2194,7 @@
 	kgdbwait	[KGDB] Stop kernel execution and enter the
 			kernel debugger at the earliest opportunity.
 
-	kmac=		[MIPS] korina ethernet MAC address.
+	kmac=		[MIPS] Korina ethernet MAC address.
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
 
