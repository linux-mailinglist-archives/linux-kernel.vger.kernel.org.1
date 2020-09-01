Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70175258D04
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgIAKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 06:50:15 -0400
Received: from mx4.wp.pl ([212.77.101.11]:10711 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAKuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:50:12 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 06:50:11 EDT
Received: (wp-smtpd smtp.wp.pl 1278 invoked from network); 1 Sep 2020 12:43:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1598957009; bh=hJLVzwJxQjp6xNbh/PRsnQBA0RhTN8F3VaKPJKZHWJI=;
          h=From:To:Cc:Subject;
          b=pNzrpKUhsmvR9HVI306H4velU08K/Awdo4R0V2b9N0uNo4zMx7vNIo3Z63N6YtNVm
           LKkSRFWKPw5O8YrQbHGQ66R7NZRwEN8s9IemxLcYigh117QRmvJz+yntJMuv5lRPVh
           a7hSoa9XGyCt2Vld84088H/ncwI37zUjlSR6K4xU=
Received: from 188.146.234.2.nat.umts.dynamic.t-mobile.pl (HELO localhost) (antoni.przybylik@wp.pl@[188.146.234.2])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gregkh@linuxfoundation.org>; 1 Sep 2020 12:43:29 +0200
From:   antoniprzybylik <antoni.przybylik@wp.pl>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        antoniprzybylik <antoni.przybylik@wp.pl>
Subject: [PATCH] staging: gdm724x: gdm_tty: corrected macro by adding brackets
Date:   Tue,  1 Sep 2020 12:43:11 +0200
Message-Id: <20200901104311.17270-1-antoni.przybylik@wp.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: 489ef85a83f588acd1f26eadb7be658c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [0YFx]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such macros are dangerous. Consider following example:
	#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
	GDM_TTY_READY(a + b)
This macro will be expanded in such a way:
	(a + b && a + b->tty_dev && a + b->port.count)
And it will lead to errors.

Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
---
 drivers/staging/gdm724x/gdm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 6e813693a766..eab5c75ee5b1 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -27,7 +27,7 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
+#define GDM_TTY_READY(gdm) ((gdm) && (gdm)->tty_dev && (gdm)->port.count)
 
 static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
 static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
-- 
2.28.0

