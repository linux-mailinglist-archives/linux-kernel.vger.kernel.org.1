Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88B248245
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHRJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgHRJvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:51:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D82C061389;
        Tue, 18 Aug 2020 02:51:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q19so8987018pll.0;
        Tue, 18 Aug 2020 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=otPLqEhEC4NADyAIXZYXJ4OVE7liq3XA4AadgS4L4Qs=;
        b=K6X8c2obreQMmDBXJBce/QrrUC4LvAtZCEjoW72ViHmyEwfK25HYVIMeXfPHRQjbkt
         kkaYH2BYpt4tsOvly7k+fvB0g2Y3f3bqvUHoTM7j/nQv4Qyo0F25eoanhVK1rw78yzAR
         j4gAMjwSfJSsAuSIMUox4Uge77H9WTrOwSPXRmBY0jWSPDF569OwrBTVSvMnCHdIIqGB
         MZoD0STMGLRlu/J48XYaHHzO3jt1wTkQOyGHV+k4mjvwJ1DFcGlZR1gQ6vm1RitD3OpF
         qW7B+43xXZ26Vhp/2up73BHFRDN9OYKDMiaHgpiBIW9bC2+FlQ3RopMqVtJPsJqjuXt/
         eW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=otPLqEhEC4NADyAIXZYXJ4OVE7liq3XA4AadgS4L4Qs=;
        b=TpgUfFXUIKrR75BhItBpDJN7YEbXyU90w3nLlGIEQVjS7gtoHn/vjj2sAANB8uCxRv
         DdE7MXjMTllG4r6C2QbXS8jxI4UtQrh9LLiszuEIOvVOGXF7qQajxPc6GNzASm832mUm
         kHZaDjgAzJ966SeoUEbpJ/cj0CHSdHO8qyxDXi74QzR04ZZdDC4n0HX7lD8xAGq5+BvT
         BHL5EUIk6HPSCW1sy2MNnbD7I18y2ChUZ5ZSoJ30focXypLpdGIWNznqW3p0zt4tmx3N
         7QSEp8VUdsjFIOPHB3wCtNdBjq0H4i3t97M9EM6ACvPO2sR/j7eZCfbB+JKULaPzptpr
         Ao9w==
X-Gm-Message-State: AOAM533ozmdlb2KRbGAhEAe1wUKk5FghnJTaHAZ/fb3qW+XRG2CEfcks
        aFU0KGnDH0UwWIiBgGOXONg=
X-Google-Smtp-Source: ABdhPJwnNk2lQZ3z5+asMMkYEGaMJutHg8icaDoeozt9/e8QiJmOV5Z68JCD3NPb8sAYuqsFX1DKeA==
X-Received: by 2002:a17:902:b594:: with SMTP id a20mr14586605pls.339.1597744298525;
        Tue, 18 Aug 2020 02:51:38 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z1sm20940125pjn.34.2020.08.18.02.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:51:38 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com
Cc:     krzk@kernel.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] memory: tegra: Correct shift value of apew
Date:   Tue, 18 Aug 2020 02:51:21 -0700
Message-Id: <20200818095121.13645-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Tegra X1 (Tegra210) TRM, the APEW field is between
[23:16] so the shift bit for apew should be 16 accordingly.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/memory/tegra/tegra210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index eab4bc01c8bc..51b537cfa5a7 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -842,7 +842,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 		},
 		.la = {
 			.reg = 0x3dc,
-			.shift = 0,
+			.shift = 16,
 			.mask = 0xff,
 			.def = 0x80,
 		},
-- 
2.17.1

