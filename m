Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFD2B392A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 21:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgKOUe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 15:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKOUe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 15:34:56 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D3C0613CF;
        Sun, 15 Nov 2020 12:34:56 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w142so22137119lff.8;
        Sun, 15 Nov 2020 12:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0jHWOCcW63JFVrVVWaeUh4dEjp7zVb8ymSRWG+wbUY=;
        b=ZKHiJb7bC1PX8PHE6DLijEe9UWieZwh9O8AWdslFXJEjjN2vRiizr4gW2uMwufG3g8
         NATumqLRCocFZpqK/ASuLr1nrZhhTTwNnCn8S8Cz999UyczpZrbNy+4Tpwm7m54reH26
         9eS0lFLiiVnHfQMA9fOjWaY3amyrngfGE4DMRBgitHobnBx2bFQCsQW4Bg2IcAc/psl7
         C6K49VV5oynqJfHhoishih+zsFOTRzLswTY6RQI/XwxWIcUDWM170/J4mpcDXnqWOwRy
         XGEzRTyRKdABaABHsPlttWY12Ea0XokMU4pv9NYoq/uDouSRB1xrpXrrxU6FrwssJ7KK
         gzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0jHWOCcW63JFVrVVWaeUh4dEjp7zVb8ymSRWG+wbUY=;
        b=hv7SFy5pEqeidITBHSwKTxK2LUddhsM1QteY+HpS8YYxYUK0a2YPUXyY6kjBDvEKPx
         azw+NME/kQ8aA4WP3K1Hh/vSOEWnjl8nCtV7OMYzTq1Wcj//xqqBd1xFQQQSi7Y2G4uZ
         RBo7hbjL9fygm58IIHhg6SYzxmuE1qPfbeRkCPfMc97z2kcAQnOV0FSqethask8+ULqX
         PwBNy6oMfrcEIQ0YA6S/lMbGnn6Xt8dn4+3MTTEdeNVAmwYHz98eautU5dJBakQed06D
         mRku6FHmqtjrGAo+nEvjtf6h+l7NYJTCao3qf+7AO+bhCb3cPJrj7ZdsAqqOAuUrRZVr
         /HVQ==
X-Gm-Message-State: AOAM530Yg5yjjtsTW2mzuRkXXeTAFQ5LhuEzjGuuDEkL05yR0A2c7Cfz
        g6NBvtAvo8j1xOCyuPMyhx0x5lCE/eU=
X-Google-Smtp-Source: ABdhPJyz7BK+TgLm29aE5fUyarpBH/H7FGoP5XcvAvunUFVO+Qjt5qinuGlcihKoyz188FmlIr9/yA==
X-Received: by 2002:a05:6512:210b:: with SMTP id q11mr4030575lfr.238.1605472494181;
        Sun, 15 Nov 2020 12:34:54 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id f191sm2391886lfd.63.2020.11.15.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 12:34:53 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: Add hardware-enable column to clk summary
Date:   Sun, 15 Nov 2020 23:34:32 +0300
Message-Id: <20201115203432.13934-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "hardware enable" column to the clk summary in order to show actual
hardware enable-state of all clocks. The possible states are "Y/N/?",
where question mark means that state is unknown, i.e. clock isn't a
mux and clk-driver doesn't support is_enabled() callback for this clock.

In conjunction with clk_ignore_unused, this tells us what unused clocks
are left enabled after bootloader. This is also useful a useful aid for
debugging interactions with firmware which changes clock states without
notifying kernel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Renamed "enable state" column to "hardware enable" and changed
      reported values to Y/N/?

    - Improved commit message.

 drivers/clk/clk.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f83dac54ed85..c2cbf3618680 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2931,7 +2931,14 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 	else
 		seq_puts(s, "-----");
 
-	seq_printf(s, " %6d\n", clk_core_get_scaled_duty_cycle(c, 100000));
+	seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
+
+	if (c->ops->is_enabled)
+		seq_printf(s, " %9c\n", clk_core_is_enabled(c) ? 'Y' : 'N');
+	else if (!c->ops->enable)
+		seq_printf(s, " %9c\n", 'Y');
+	else
+		seq_printf(s, " %9c\n", '?');
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -2950,9 +2957,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                                duty\n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle\n");
-	seq_puts(s, "---------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
+	seq_puts(s, "-------------------------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
-- 
2.29.2

