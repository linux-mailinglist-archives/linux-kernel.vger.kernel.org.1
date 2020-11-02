Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5107A2A33E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKBTR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgKBTR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:17:58 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8ADF22275;
        Mon,  2 Nov 2020 19:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604344677;
        bh=CV/MEWL8ozo0FuvkrB3dObtRHfnp2DhBkwF++l1QR2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=FMLAu8W894/Y8ejUIb62AO+GzoYiRDNKxJ8NRtfVPLnMTKWJw9qDn9Y8QruMvnf30
         lialV9Ot20Z5BqMidRxi4iSp0IkNGPShSThbKE+G4pcapnO9IexSkCgjUzaiu5J30z
         hqCAh3GoTCS3uyW+6CJ9ORjJXJutjWeTloXbYyxg=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] MAINTAINERS: update email, git repo of habanalabs driver
Date:   Mon,  2 Nov 2020 21:17:53 +0200
Message-Id: <20201102191753.13809-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the email to my kernel.org email address and update the git
repository address to the git.kernel.org

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b516bb34a8d5..c3f3704acd64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7697,9 +7697,9 @@ F:	drivers/clocksource/h8300_*.c
 F:	drivers/irqchip/irq-renesas-h8*.c
 
 HABANALABS PCI DRIVER
-M:	Oded Gabbay <oded.gabbay@gmail.com>
+M:	Oded Gabbay <ogabbay@kernel.org>
 S:	Supported
-T:	git https://github.com/HabanaAI/linux.git
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
 F:	Documentation/ABI/testing/debugfs-driver-habanalabs
 F:	Documentation/ABI/testing/sysfs-driver-habanalabs
 F:	drivers/misc/habanalabs/
-- 
2.17.1

