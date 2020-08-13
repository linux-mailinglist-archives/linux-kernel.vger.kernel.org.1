Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B88243E60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 19:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 13:35:07 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:59965 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgHMRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:35:07 -0400
Received: from localhost.localdomain ([93.22.150.113])
        by mwinf5d58 with ME
        id F5b1230022T2WRZ035b16U; Thu, 13 Aug 2020 19:35:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 13 Aug 2020 19:35:04 +0200
X-ME-IP: 93.22.150.113
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, stephen@brennan.io,
        rohitsarkar5398@gmail.com, pterjan@google.com,
        paulo.miguel.almeida.rodenas@gmail.com, okash.khawaja@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: rtl8192u: Do not use GFP_KERNEL in atomic context
Date:   Thu, 13 Aug 2020 19:34:58 +0200
Message-Id: <20200813173458.758284-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'rtl8192_irq_rx_tasklet()' is a tasklet initialized in
'rtl8192_init_priv_task()'.
From this function it is possible to allocate some memory with the
GFP_KERNEL flag, which is not allowed in the atomic context of a tasklet.

Use GFP_ATOMIC instead.

The call chain is:
  rtl8192_irq_rx_tasklet            (in r8192U_core.c)
    --> rtl8192_rx_nomal            (in r8192U_core.c)
      --> ieee80211_rx              (in ieee80211/ieee80211_rx.c)
        --> RxReorderIndicatePacket (in ieee80211/ieee80211_rx.c)

Fixes: 79a5ccd97209 ("staging: rtl8192u: fix large frame size compiler warning")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 195d963c4fbb..b6fee7230ce0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -597,7 +597,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 
 	prxbIndicateArray = kmalloc_array(REORDER_WIN_SIZE,
 					  sizeof(struct ieee80211_rxb *),
-					  GFP_KERNEL);
+					  GFP_ATOMIC);
 	if (!prxbIndicateArray)
 		return;
 
-- 
2.25.1

