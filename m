Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB41F3601
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgFIIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgFIIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:17:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31304C05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 01:17:46 -0700 (PDT)
Received: from p5b06d650.dip0.t-ipconnect.de ([91.6.214.80] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1jiZS3-0005EE-78; Tue, 09 Jun 2020 10:17:43 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH] timekeeping: Fix typo
Date:   Tue,  9 Jun 2020 10:17:26 +0200
Message-Id: <20200609081726.5657-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in comment for cross timestamping structure:

 syncronized -> synchronized.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 include/linux/timekeeping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b27e2ffa96c1..17a1a2b6be40 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -241,7 +241,7 @@ struct system_time_snapshot {
 
 /*
  * struct system_device_crosststamp - system/device cross-timestamp
- *	(syncronized capture)
+ *	(synchronized capture)
  * @device:		Device time
  * @sys_realtime:	Realtime simultaneous with device time
  * @sys_monoraw:	Monotonic raw simultaneous with device time
-- 
2.20.1

