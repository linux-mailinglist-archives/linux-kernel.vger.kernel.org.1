Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969CB275816
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgIWMj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgIWMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:39:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2248C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 05:39:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so27491129ejl.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ca8MpxtYSTi9fxnkIDOgsCaEJvwuUcIlAKj0sgOzoGg=;
        b=oIDf+FbMIJg0nkmo9OaMEYe7LWTRMMKcnV5j/JRJZt7wh1t59i2pDpCbU8a/Vf8ST0
         uOVDsSWIaTpDjCA9Btosu1kikktm98gaWopExkcmr18eERz0R2wh/D5STOUKttv4TypR
         vvfVmj0bgJxCBIM3ChmRqLzp0fL2CJqayF8FZKcry1J1B2iKskZQ9KwPFSpb6odoJSt4
         diGq0Q9An1oRKPVMe9/xngPIpPa1EkR58273X5zEATTYIDr2zhd+QoIAlokvNZ2NWUf7
         m/HAJ5cNXtyQFst1zorjJH66KzKr7B9+wyNrUh7eyAocpf9WqLxn8IFRgRSRjPC99zt+
         FEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ca8MpxtYSTi9fxnkIDOgsCaEJvwuUcIlAKj0sgOzoGg=;
        b=XepWI0tE2RRSQiD7bsunwTtaglr2hoWFTBVd/yo+5WWLSuOoKDh1Rlt3dYvmUOPo/H
         ODrhMnd4G2oGh3REHMOHZhAI37uxHT67lW49PiiPoFwHSpmvU4Cimsrv29YaVxhQox4r
         n7Fvn2hFfBxEgkMHESmIEuHwSrambhns6GhMhPssUEObWnsJn19Yj1y7M4aenkidqbi9
         WAHsd1tQsQBWP+Pd0r/clkQjjMxC+oSWYA5Lj2g1Vzf30/nATiKjTa59FAFeCtM4ng/6
         Ily/yzCaelUE/KN9dEat/2aB7EmM/NEpY+ZqTWx72tcP0PoPUH6uY2y6I/7QkXFFFgrQ
         8/Ag==
X-Gm-Message-State: AOAM532VrB2BULZ5BXhNMaNlfUD33XkxsbDFRG0s6mtvpjMtUzazrXJi
        ql6h0jfAMTkT9sLbyOlKVcLyQg==
X-Google-Smtp-Source: ABdhPJx5Cvk/hYChiUl93W6xD/qDLkGJ7fQ7DDElz9ONKimcxGUuCe2Al0cDNTEtuG8CuqOq6pw0nQ==
X-Received: by 2002:a17:906:2712:: with SMTP id z18mr10331457ejc.380.1600864765418;
        Wed, 23 Sep 2020 05:39:25 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id k21sm7015003edv.31.2020.09.23.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 05:39:24 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: [PATCH] mailbox: cancel timer before starting it
Date:   Wed, 23 Sep 2020 14:39:16 +0200
Message-Id: <20200923123916.1115962-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the txdone is done by polling, it is possible for msg_submit() to start
the timer while txdone_hrtimer() callback is running. If the timer needs
recheduling, it could already be enqueued by the time hrtimer_forward_now()
is called, leading hrtimer to loudly complain.

WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
Hardware name: Libre Computer AML-S805X-AC (DT)
Workqueue: events_freezable_power_ thermal_zone_device_check
pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
pc : hrtimer_forward+0xc4/0x110
lr : txdone_hrtimer+0xf8/0x118
[...]

Canceling the timer before starting it ensure that the timer callback is
not running when the timer is started, solving this race condition.

Fixes: 0cc67945ea59 ("mailbox: switch to hrtimer for tx_complete polling")
Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mailbox/mailbox.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0b821a5b2db8..34f9ab01caef 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
 exit:
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
-		/* kick start the timer immediately to avoid delays */
+	if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
+		/* Disable the timer if already active ... */
+		hrtimer_cancel(&chan->mbox->poll_hrt);
+
+		/* ... and kick start it immediately to avoid delays */
 		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+	}
 }
 
 static void tx_tick(struct mbox_chan *chan, int r)
-- 
2.25.4

