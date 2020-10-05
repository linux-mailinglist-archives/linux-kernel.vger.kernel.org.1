Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE11283CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgJEQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgJEQpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:45:47 -0400
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12F220774;
        Mon,  5 Oct 2020 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601916347;
        bh=VpBd1kTTXINA3OLq2wc2vcg+nxwHuYQjDCcSdS2ckvc=;
        h=From:To:Cc:Subject:Date:From;
        b=BZb4Xa+CiHgq7KwUO+7EC/nd7b4l6Shpjv6DRdz2NySTV4ZTsFv+vusLs15vmTaKP
         U94JRpN4mJs4ASJnaq/FkTzb9/9TEbr7EVfOzCuRIEgpxkCSbkoG3Z41RFkr5hzOT8
         Lwfm+0ohW+VmbO6sQnpxHms7KH/FkRS/yiZy6/bU=
From:   Antoine Tenart <atenart@kernel.org>
To:     akpm@linux-foundation.org
Cc:     Antoine Tenart <atenart@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update my email address
Date:   Mon,  5 Oct 2020 18:45:33 +0200
Message-Id: <20201005164533.16811-1-atenart@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my kernel.org address instead of my bootlin.com one.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index a780211468e4..a11a8b9d1e43 100644
--- a/.mailmap
+++ b/.mailmap
@@ -41,7 +41,8 @@ Andrew Murray <amurray@thegoodpenguin.co.uk> <andrew.murray@arm.com>
 Andrew Vasquez <andrew.vasquez@qlogic.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
 Andy Adamson <andros@citi.umich.edu>
-Antoine Tenart <antoine.tenart@free-electrons.com>
+Antoine Tenart <atenart@kernel.org> <antoine.tenart@bootlin.com>
+Antoine Tenart <atenart@kernel.org> <antoine.tenart@free-electrons.com>
 Antonio Ospite <ao2@ao2.it> <ao2@amarulasolutions.com>
 Archit Taneja <archit@ti.com>
 Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 33b27e62ce19..dc1e29b94958 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1623,7 +1623,7 @@ N:	meson
 
 ARM/Annapurna Labs ALPINE ARCHITECTURE
 M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
-M:	Antoine Tenart <antoine.tenart@bootlin.com>
+M:	Antoine Tenart <atenart@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/alpine*
@@ -8673,7 +8673,7 @@ F:	drivers/input/input-mt.c
 K:	\b(ABS|SYN)_MT_
 
 INSIDE SECURE CRYPTO DRIVER
-M:	Antoine Tenart <antoine.tenart@bootlin.com>
+M:	Antoine Tenart <atenart@kernel.org>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/inside-secure/
-- 
2.26.2

