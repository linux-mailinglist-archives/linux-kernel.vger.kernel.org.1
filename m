Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1181A2CA394
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgLANSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:18:31 -0500
Received: from nautica.notk.org ([91.121.71.147]:33764 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgLANSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:18:30 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 08008C01B; Tue,  1 Dec 2020 14:17:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1606828669; bh=O5J2LaBS/B6Qc/kO9fyndSOGTTNP9IO7bp/boMw+3Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlWjGD6Psl1SfsHUD7Xj9QTgTwIXkxOAnP8eFudDsHmBmOdoqCUUDNd+8VQRIZely
         9xFuxggNqn+Qm/mVipTrDytMQp6IbQNEty30qqaheyerHIg3uk4nYPC9celMWLdZS0
         KwDmCZOv8r2kZdlTM7Y8LJWqSB1IDi0zhVQr/BHO2ULjXuQ+SlMlgSLqS66B6vUvm3
         pI6EyL8cgDY4oKkW8rSYlossFbg84Iv/mOIcJfYD5ffBF1pwAoQymp+eIMkcNIIg3w
         ynIGK8ChwsA86e4PCnl1YE7fWfbiZHkbM9He28twNGJmppM6OAY400dnV9LnltwBgA
         6fh8jazelFVFA==
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/2] kbuild: don't hardcode depmod path
Date:   Tue,  1 Dec 2020 14:17:30 +0100
Message-Id: <1606828650-29841-2-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1606828650-29841-1-git-send-email-asmadeus@codewreck.org>
References: <1606828650-29841-1-git-send-email-asmadeus@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

depmod is not guaranteed to be in /sbin, just let make look for
it in the path like all the other invoked programs

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9e7fd6a065a7..d7bd114836a9 100644
--- a/Makefile
+++ b/Makefile
@@ -452,7 +452,7 @@ LEX		= flex
 YACC		= bison
 AWK		= awk
 INSTALLKERNEL  := installkernel
-DEPMOD		= /sbin/depmod
+DEPMOD		= depmod
 PERL		= perl
 PYTHON		= python
 PYTHON3		= python3
-- 
2.28.0

