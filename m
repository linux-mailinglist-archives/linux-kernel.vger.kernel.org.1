Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF4F25B136
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgIBQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 12:16:45 -0400
Received: from mx3.wp.pl ([212.77.101.10]:17861 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgIBQQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:16:40 -0400
Received: (wp-smtpd smtp.wp.pl 628 invoked from network); 2 Sep 2020 18:16:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1599063396; bh=fCRMYNQmfFvrAJR8Oni60wZOyAz0/8t7DxsWGn6A+RU=;
          h=From:To:Cc:Subject;
          b=l/NCsyz62EM4EDtcZZXnEXJt+wOYXEZRm40mwglleSzpJGKSpos8xbj6g1hi7ZnAS
           1BL5g0Vn2XguZjdaqj0T9h216rUDA0pV16KKYKaVPQE5V3egVHE9ppzq2cjGS6DHoh
           H2J5bbmL3WUecKqFxndvtEFk4e+W4vjbYNuMo5WQ=
Received: from 188.146.102.178.nat.umts.dynamic.t-mobile.pl (HELO localhost) (antoni.przybylik@wp.pl@[188.146.102.178])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gregkh@linuxfoundation.org>; 2 Sep 2020 18:16:36 +0200
From:   Antoni Przybylik <antoni.przybylik@wp.pl>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Antoni Przybylik <antoni.przybylik@wp.pl>
Subject: [PATCH v2 2/2] staging: gdm724x: gdm_tty: replaced macro with a function
Date:   Wed,  2 Sep 2020 18:16:27 +0200
Message-Id: <20200902161627.64686-1-antoni.przybylik@wp.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: bd263fd383ace842bc314464e6a3863f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [UTGx]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed return type to bool and removed inline specifier. Also added
 static specifier.

Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
---
 drivers/staging/gdm724x/gdm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 34a13d98c029..179fc9b9400b 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -34,7 +34,7 @@ static DEFINE_MUTEX(gdm_table_lock);
 static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
 static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
 
-inline int gdm_tty_ready(struct gdm *gdm)
+static bool gdm_tty_ready(struct gdm *gdm)
 {
 	return (gdm && gdm->tty_dev && gdm->port.count);
 }
-- 
2.28.0

