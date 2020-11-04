Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672902A6B25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbgKDQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbgKDQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:56:48 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5958C0613D3;
        Wed,  4 Nov 2020 08:56:47 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p15so23768398ljj.8;
        Wed, 04 Nov 2020 08:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LnlAk4TtiapRWMl4c7vg5fVKoKzSDAr8iHiDbX7Y88=;
        b=dJK1CPsyuIty4pd3AuhjDA4C8RETI1jNrGskRndl0vCEx5S7d/EDunIZy/E0ZhJTl6
         Zp7QGs2wbOQyicP2QARA1+IO4T+Xd/Q6YUGm1X7gvZqI1xFsNDsARTtFo7ftPdqpkZXP
         pcMIJfiOHT4sK2dMyuf31UZFN1zkmlZDy3+OBXSNqYnr4ohS9QDXJoXToToiOGX3ygmf
         QTO+vyLxzXP2s2VZeV4NaKG3hIPFA9KivH+lqQxKDy7+mIwqVNbvOPuVhBA0QLQj/nsX
         KU4yiop7p+HnxJfzapc92fogh7IX6REQl/MYFiEUUnVNCTLJGuPV+3KvPlSlMxEdnEib
         nNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LnlAk4TtiapRWMl4c7vg5fVKoKzSDAr8iHiDbX7Y88=;
        b=Anpv+RJgk/RoSExmAR+Ld89U5s9tgRvmhr78L235djE73k2e9k4NoR4SV/L1vdMOng
         AhvRk0sAcschvj4xnnO3QhBIgfIznSlXw8Xa/QPvZ0LPuyex1xmDJE1onCKXfD7Hytd+
         9K1ATx/+ekRWTD57sLJLuUJD24KufOeaioFcxUzXTk3lnT1oTSrOOaP7d4Shsrij8OIK
         O+TrqCBv5C1QZoRPTgzszd0deM0QvIq3p3ZObvigBV+Rhu4uPPigLpzE+M8cu/73Ogce
         /iRUpmhvuG+PJu84iDeA/sl+zeuzFUm90jrp1UGHYaYVGi4COReNei1S56Ek9tzthlt+
         PbQg==
X-Gm-Message-State: AOAM531e7NKoPpOYcse4xijsFkKbuVlGy97P3NojJK6GZZRTi9S9T2h3
        sW0pZ+4tT9I71oQx70+c+zNnwGZREws=
X-Google-Smtp-Source: ABdhPJzyq/b8lJ5Pk2ox7yzOJOHV1SXiraW//HF0GBaHsIg7fvg3qASfnEzfk44inTe2e6x+da4jXw==
X-Received: by 2002:a2e:9189:: with SMTP id f9mr10432630ljg.295.1604509006393;
        Wed, 04 Nov 2020 08:56:46 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id n24sm569223ljg.99.2020.11.04.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:56:45 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: Add enable-state column to clk summary
Date:   Wed,  4 Nov 2020 19:56:31 +0300
Message-Id: <20201104165631.22295-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "enable state" column to the clk summary. It's handy to know actual
hardware state of all clocks for debugging purposes. In conjunction with
clk_ignore_unused, this tells us what unused clocks are left on after
bootloader without disabling the clocks. It's also s useful debugging
information for cases where firmware touches clocks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/clk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f83dac54ed85..07fbdea488bc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2931,7 +2931,8 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 	else
 		seq_puts(s, "-----");
 
-	seq_printf(s, " %6d\n", clk_core_get_scaled_duty_cycle(c, 100000));
+	seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
+	seq_printf(s, " %7d\n", clk_core_is_enabled(c));
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -2950,9 +2951,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                                duty\n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle\n");
-	seq_puts(s, "---------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty  enable\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle   state\n");
+	seq_puts(s, "-----------------------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
-- 
2.27.0

