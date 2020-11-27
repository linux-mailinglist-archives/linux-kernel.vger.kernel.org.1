Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182132C6BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgK0Tb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730084AbgK0TFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606503919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=P4J8EBWPnBVFoHBHwgQRXiVw93w2If7dqdzr9ZCw24E=;
        b=GagEkA9rSJUY+3Kk0NLoDk6fGvYMhc2QV78uZlpYFqu72+prMISH7hclQFyAyziHOwOANW
        sgCwtqvoqfbBPdT4ekzKjMIBZAd8kv96PkQGRXveuqRvEGwSoZBgTpmmk7DBOLVbt/LSJK
        00AoW7LeGp3gA1i/kvlcVFzXZNASaLM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-EKYH7Uk3MrC-XRBFMwEeJQ-1; Fri, 27 Nov 2020 14:05:17 -0500
X-MC-Unique: EKYH7Uk3MrC-XRBFMwEeJQ-1
Received: by mail-qv1-f70.google.com with SMTP id n5so3532689qvt.14
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P4J8EBWPnBVFoHBHwgQRXiVw93w2If7dqdzr9ZCw24E=;
        b=g0O+fQxiWsJwe6keIXmmjVqDFvIiZO2wsFe1yj7idCVwTDCSBHtZXGRE7D4TUc9o5I
         7kejhfafXoMku+S9Ltefsnx0Sqf9XGsfBda4B5xYLrg3CiQlq86/K7woyiq0UFhVDC62
         9GnGgZSonkdetKqxUcHnFy8EpozQR2WWNjtJnUMGJpoYXIGoR2uTIgPw2VTPrqJ4zw6e
         UOMvGqNCM/L4Js5eh64yNm2krMUOhaxjBMuK8q4RMZbwkSU+A8W176h1lDkvgerKVm5j
         03Nrh38W22hTx754qb4a1V100M+nT+PDE5yHcG6pEdT1WBORGB4rBcyooVDZ7vBJuLh7
         EokA==
X-Gm-Message-State: AOAM532+LPd50CPaG8bhk2YY8MW5CgY92M9IvYl4zTrh9Vt1cytdeD/Z
        0C1zQp4YUmsJhNyxm82m82pCB21lnJTTeYBrbyrpMeJenHoGsKnSUylIhF3Xly/Yd9MPtoJzExY
        lY79ZNV3cbsoq718Elhdk1w6f
X-Received: by 2002:a05:620a:22eb:: with SMTP id p11mr10254695qki.224.1606503916860;
        Fri, 27 Nov 2020 11:05:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlHMd5iGgdFcDE7TXlKessUY1X4ETN8EOl5uRxiIteKlzhnCF61nP8e6tAtR4EIGlPYbb+vw==
X-Received: by 2002:a05:620a:22eb:: with SMTP id p11mr10254684qki.224.1606503916681;
        Fri, 27 Nov 2020 11:05:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k128sm6806898qkd.48.2020.11.27.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:05:16 -0800 (PST)
From:   trix@redhat.com
To:     b.zolnierkie@samsung.com, pakki001@umn.edu
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] omapfb: fbcon: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:05:08 -0800
Message-Id: <20201127190508.2842786-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
index 3417618310ff..cc2ad787d493 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
@@ -75,7 +75,7 @@ static void dispc_dump_irqs(struct seq_file *s)
 
 	seq_printf(s, "irqs %d\n", stats.irq_count);
 #define PIS(x) \
-	seq_printf(s, "%-20s %10d\n", #x, stats.irqs[ffs(DISPC_IRQ_##x)-1]);
+	seq_printf(s, "%-20s %10d\n", #x, stats.irqs[ffs(DISPC_IRQ_##x)-1])
 
 	PIS(FRAMEDONE);
 	PIS(VSYNC);
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 6f9c25fec994..101fa66f9b58 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -1554,7 +1554,7 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
 
 	seq_printf(s, "irqs %d\n", stats.irq_count);
 #define PIS(x) \
-	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1]);
+	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1])
 
 	seq_printf(s, "-- DSI%d interrupts --\n", dsi->module_id + 1);
 	PIS(VC0);
-- 
2.18.4

