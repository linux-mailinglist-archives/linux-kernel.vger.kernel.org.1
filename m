Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4E270957
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgISAJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 20:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgISAJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:09:19 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF4322208;
        Sat, 19 Sep 2020 00:09:18 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] MAINTAINERS: TPM DEVICE DRIVER: Update GIT
Date:   Sat, 19 Sep 2020 03:09:11 +0300
Message-Id: <20200919000911.12159-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Git URL to

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

This is done for availability reasons, i.e. better infrastructure.

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
I'm happy to include this to my next PR, if that is fine for you.
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b19ce5..7b083b8f0c3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17593,7 +17593,7 @@ L:	linux-integrity@vger.kernel.org
 S:	Maintained
 W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
 Q:	https://patchwork.kernel.org/project/linux-integrity/list/
-T:	git git://git.infradead.org/users/jjs/linux-tpmdd.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	drivers/char/tpm/
 
 TRACING
-- 
2.25.1

