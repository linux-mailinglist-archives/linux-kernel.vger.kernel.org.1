Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C014F2F513E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbhAMRjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbhAMRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:39:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922E3C061795;
        Wed, 13 Jan 2021 09:39:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a6so2357472wmc.2;
        Wed, 13 Jan 2021 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIOSC/i/0EBgHvOloOEK1Z2ZW040Bk9xwSmCAqjjzc0=;
        b=Im8v1gmfxzjnmpvv3eZYYFQ8mo3yL3PbWyEipNeDBdnsQEizMbbg96tT6qkOwl8oN0
         oFiI2/bhrCJW13GeNPauMdveMRy0pSVw6lpdV3CVK4Oym3qhaVGX97vaNCna1hmh27yr
         dsNUn071ZE9LNF3443LafwMcc4exgiwi/aua2mLXW4fIE13zFJ2qM5bqX8+WsaEHqLBo
         1TN6Gl149WtPuS1cEqk7yhRERCMid7IMQSlWqxU6M8jHgXpmIAPqN0U5y8AfVxxBbL4n
         cxYz9Rn8yi9CAyTl7GxAsMP5j3qkb+Rx5UafbgvargIrkZu8JxwBkMouVIkOX05tL+uO
         T9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIOSC/i/0EBgHvOloOEK1Z2ZW040Bk9xwSmCAqjjzc0=;
        b=F9FxP6ZAC1ZDY7vI2VwQuKVl6rPwFUk+piUMWOEN1tOwvIlaiPqwsceY8wHFFs+MEz
         ffLUhVrIemu4jzNd2XEqiy6KLawSUUCJ/xJStXmUv3Gm3UmJ2y8hhAh4w8v7g7WBuvba
         PstBin0+pci19DG/bihvU5sjeVBfGi4qKRDIttKk/JBZKUMuUKfbeg6UP188s2hBnfki
         bv5yk47GyqiWKXfZiT687hkfbw5En0n2CxuWqKbzQaErmshTB9gYTLtmpb/G0xmJVOQM
         uJ8mrUqa52gmoKAhK6mMrrQTtioFCB6j9WIIGX7EfwJUNlVM0PedGnXk10GRl7iu2ky3
         JfEQ==
X-Gm-Message-State: AOAM533GXO6npMlGBFw5/aKmCKhHFfus8QLe41rL6cO8oM+Qj9152V2A
        6eWvLOnfl/sGCZViaFAaZ8o=
X-Google-Smtp-Source: ABdhPJz9h7ypoZGZsWgWMtVtklvLLtHEm5JbM51BlX01HbDDHyNKxX/Pz25FZ3l1m1fCGzPj6kgpdg==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr356552wmi.20.1610559540351;
        Wed, 13 Jan 2021 09:39:00 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id w21sm3743843wmi.45.2021.01.13.09.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:38:59 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 3/3] arm64: defconfig: Enable PF8x00 as builtin
Date:   Wed, 13 Jan 2021 18:38:55 +0100
Message-Id: <20210113173855.1509417-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113173855.1509417-1-adrien.grassein@gmail.com>
References: <20210113173855.1509417-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is mandatory for the nitrogen8m mini board
when booting from the sdcard slot.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ca9d03d5cb3..bd6ac11ad6fc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -603,6 +603,7 @@ CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_PCA9450=y
+CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.25.1

