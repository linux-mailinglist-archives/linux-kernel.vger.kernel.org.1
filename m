Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039BC2DBFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgLPLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:48:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43412 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLPLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:48:43 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpVHg-0004jh-0T; Wed, 16 Dec 2020 11:47:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: fix spelling mistake in Kconfig "privleges" -> "privileges"
Date:   Wed, 16 Dec 2020 11:47:55 +0000
Message-Id: <20201216114755.12461-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/um/drivers/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 2e7b8e0e7194..58e3ffc17b7d 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -323,7 +323,7 @@ config UML_NET_SLIRP
 	  frames.  In general, slirp allows the UML the same IP connectivity
 	  to the outside world that the host user is permitted, and unlike
 	  other transports, SLiRP works without the need of root level
-	  privleges, setuid binaries, or SLIP devices on the host.  This
+	  privileges, setuid binaries, or SLIP devices on the host.  This
 	  also means not every type of connection is possible, but most
 	  situations can be accommodated with carefully crafted slirp
 	  commands that can be passed along as part of the network device's
-- 
2.29.2

