Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6C2F45F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbhAMIJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbhAMIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602BC0617BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w5so1043496wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdSvpUQ22Tp2b4P9PrCToSqH5/XqN/5MJ8spBK/xHGk=;
        b=iyC2U/7PLqvpUMuFV0K/A7sh4+GWE1E0MWvP3yVAwIBmSRdUsYYra383w0C6dLFtPa
         ByjZBDTuFMhziP0tk/qFwoorlRRoeuIXhQrgL9RZNR96UNvieT8hled00P7THpiPDdio
         ubFVj368pBisYZtJGn53arWD1851Z9sxcpFGbfnTytCWcBKcjPpZDSIGEgG5rsgaqgpT
         B4/tZ3IbzTgS3ln4xgawoBab0XMjBlozbq9R5ApyhQUSbFt7AmnJInVz2BJ31wp58Oe9
         1J6Bg0SzctkJxx//Hm1PcrDV+xqmQNf0x9g8bbg0rQEUNnp54EIez2vAQq5xeQkpdPIJ
         Vzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdSvpUQ22Tp2b4P9PrCToSqH5/XqN/5MJ8spBK/xHGk=;
        b=b70ZomXhjlFZjKgtx2MbCOvBmecE/g9Kp56f35ZH7DXnQVvAZWGMdGU08sNSpIZd15
         rE8M8veDVOlezqxgpsRBTXiXy93seyFPF1xCvQCaTKQdHzBbAVitL5fHqIBnJf9Ekpb4
         3/yFqsKvtk05vB7u+9tg9nwp54HCLVIj3ecLDQmBLoq1ZkfT5SOHiEuhYioJMymJHdRb
         KSdQN+EVcjvihWFpsqCvpiPJ5H4cNmkDh+X7LQcNTxx6s9VAWC5leKaRRMMfnP7tY8/b
         +KDkl2ujWBz3DmrtFKhE3b+Umptp4sde6ItYxuKUzA+ONiEwDH/sUDloPGQb5liQwUH4
         oJ6Q==
X-Gm-Message-State: AOAM530hpQdwTNMYJZwPzLU32v/Pz6HI/bPt29qG//OGNyScvt0WmGm7
        3Ir6hbvPwnvZIz8FYZU4rS+suA==
X-Google-Smtp-Source: ABdhPJw6j8CQxqzjNIGdSV2lpJ+hX/nupnOJDt+604z9o72dQdF7sf9sZP5aWUMX0/xA4FnIM9fQzg==
X-Received: by 2002:adf:decb:: with SMTP id i11mr1221460wrn.26.1610525295841;
        Wed, 13 Jan 2021 00:08:15 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 16/30] fixup! drm/amd/display/dc/dce60/Makefile: Ignore -Woverride-init warning
Date:   Wed, 13 Jan 2021 08:07:38 +0000
Message-Id: <20210113080752.1003793-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/gpu/drm/amd/display/dc/dce60/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/Makefile b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
index dda596fa1cd76..fee331accc0e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
-CFLAGS_AMDDALPATH)/dc/dce60/dce60_resource.o = $(call cc-disable-warning, override-init)
+CFLAGS_$(AMDDALPATH)/dc/dce60/dce60_resource.o = $(call cc-disable-warning, override-init)
 
 DCE60 = dce60_timing_generator.o dce60_hw_sequencer.o \
 	dce60_resource.o
-- 
2.25.1

