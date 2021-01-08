Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E858A2EEB7D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbhAHCwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhAHCwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:52:47 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B8C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 18:52:06 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g15so6706031pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 18:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQO8vJwSx7HHkUDB54L3o6TvWNWFoO4uiodcnxSDlcQ=;
        b=X/AAyuJPU+5BF0P70BENerkQ7fsoiQwBujnVb/DQLxNbz1PPtMezpk5ReCf/OJKQQy
         f4bPc1u3OHv/y4tYs6HpwW77XZvz3oaL8PpNPggwD9t7QroceJRn6aAT0DlpL3fKmt9m
         Kc2eEwKEnuIJFw8ojiF0UiZqJeFc277BnZZPvWXczvmiW79m1x2MqcGq6I8lWYpS91L8
         s3gZtJOUZD/CET29z2o6rPTikBdhxrk+Z3p2zjjQClk91guj9+5j2Oq7QEGLXsVaIwXK
         uVznU6511s/FXwBle7HhugF3yj6NOEB2U6jJRJV8N4XJqnJW4oR7E/hb/gvJy4gDt+8R
         WXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQO8vJwSx7HHkUDB54L3o6TvWNWFoO4uiodcnxSDlcQ=;
        b=Vg/jsGHSXhhLsVV4J8sTCHT3aIBAOsCAPQ5CjKEZbtkbXo8vv/KSXgQxs3aQa8iOvU
         UIlsCfuyrQYVOAtv9j3RAT/aZw/o8jOIbcn5jHMOaigh3I5jWlFZWe3A4z9aGne+npYN
         yS7tHcjnZnoo4g/OrfWXHHA/0i+qb+tDhgzCm1Bd+o4FFf5/M2KG+1op8LRDniPkIGkL
         MbSSSD/snta2UjGGl5Omfp1jt16XvGK79V6Uk5CL1Voo4ISlZ7SGJlawBgYV+MAUHPbK
         UOqY4yPdJOXcz1cFx+e/H2p2XoViwBX7QFif4GLPZBVtKp9lFeelwfnsCQFFm8fIfCMA
         JL0g==
X-Gm-Message-State: AOAM531nqTXudxt9G50Hw7/N8+TvKM9XlkyD4b37sKLdkhfzZQMAVTkz
        LQvqPt1Sqpqvd3HBkF2pBHhh/A5pLQK10Bbi
X-Google-Smtp-Source: ABdhPJyh26fX5mM3v76uqsyxr5vX4CHgh1u6pP0ycZZyqGqjd0a30WyALlIup4JtQsrUxrFORhFF2g==
X-Received: by 2002:a63:3049:: with SMTP id w70mr4782475pgw.224.1610074326364;
        Thu, 07 Jan 2021 18:52:06 -0800 (PST)
Received: from container-ubuntu.lan ([171.211.28.197])
        by smtp.gmail.com with ESMTPSA id z2sm7641230pgl.49.2021.01.07.18.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:52:05 -0800 (PST)
From:   DENG Qingfang <dqfext@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] staging: mt7621-dts: remove obsolete switch node
Date:   Fri,  8 Jan 2021 10:51:55 +0800
Message-Id: <20210108025155.31556-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was for OpenWrt's swconfig driver, which never made it upstream,
and was also superseded by MT7530 DSA driver.

Signed-off-by: DENG Qingfang <dqfext@gmail.com>
---
 drivers/staging/mt7621-dts/mt7621.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index 5b9d3bf82cb1..42e8ec72c3cd 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -497,13 +497,6 @@ fixed-link {
 		};
 	};
 
-	gsw: gsw@1e110000 {
-		compatible = "mediatek,mt7621-gsw";
-		reg = <0x1e110000 0x8000>;
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_SHARED 23 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
 	pcie: pcie@1e140000 {
 		compatible = "mediatek,mt7621-pci";
 		reg = <0x1e140000 0x100     /* host-pci bridge registers */
-- 
2.25.1
