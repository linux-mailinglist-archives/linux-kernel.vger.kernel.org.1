Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FCE2F1040
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbhAKKkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbhAKKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:40:41 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7374C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:40:00 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id FNfy2400e4C55Sk06NfyTn; Mon, 11 Jan 2021 11:39:58 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kyucA-002o7L-08; Mon, 11 Jan 2021 11:39:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kyuc9-001DYH-DI; Mon, 11 Jan 2021 11:39:57 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ntp: Fix RTC synchronization on 32-bit platforms
Date:   Mon, 11 Jan 2021 11:39:56 +0100
Message-Id: <20210111103956.290378-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to an integer overflow, RTC synchronization now happens every 2s
instead of the intended 11 minutes.  Fix this by forcing 64-bit
arithmetic for the sync period calculation.

Fixes: c9e6189fb03123a7 ("ntp: Make the RTC synchronization more reliable")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 7404d38315276a96..54d52fab201d283e 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -498,7 +498,7 @@ int second_overflow(time64_t secs)
 static void sync_hw_clock(struct work_struct *work);
 static DECLARE_WORK(sync_work, sync_hw_clock);
 static struct hrtimer sync_hrtimer;
-#define SYNC_PERIOD_NS (11UL * 60 * NSEC_PER_SEC)
+#define SYNC_PERIOD_NS (11ULL * 60 * NSEC_PER_SEC)
 
 static enum hrtimer_restart sync_timer_callback(struct hrtimer *timer)
 {
-- 
2.25.1

