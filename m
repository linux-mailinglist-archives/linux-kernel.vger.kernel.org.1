Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1635277E92
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIYDbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:31:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D5EC0613CE;
        Thu, 24 Sep 2020 20:31:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn7so1059612pjb.5;
        Thu, 24 Sep 2020 20:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPwFVdpf+MdTNEthESQ/J9yBHAB6tEJrYpBaLIPPi+Q=;
        b=H/22bnESxomM76v2BwCXz7N+da/sTud1kn+GW1pPFf2/J5258QaSJf+7vsLyU0xiUc
         re4fQomy0KZfz/+oWy3ZJurJ1IoHFxbDffGBoxf+MsR3D+POC64LCPfSMVm0pcvN6dNU
         2yZ5Lu3LmvYCSXvyC665PhHHfzwtjNNMQ/45cmKTRr8HhsiV2ofe1IUlYJRN09cG5V/V
         9k1syL1VxuBHtDEifSN+0NTHWXmEFXd1W/JdP+5r6ESLmZ0UP1/z3OUA72waXP/I8dzB
         b0qKzf8KxOfKZ/wuCdQVw5YN8MCyg2Vo7DsubJFipqhe6H3hX/Kparv9Olz1Y4l6Sw10
         vzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPwFVdpf+MdTNEthESQ/J9yBHAB6tEJrYpBaLIPPi+Q=;
        b=frHsPw6g2y6NjzpxZhlvP/o1wHoYqGLrtpZX/zEPyBwx5ATgNEJwbdgI3r1B3dj0hG
         aeTLEs6WE+kK9/WZrZ+LTIZ074FWV53/BQLnwXc5Qc1RQg7D+6q5jpEebnYpK76SnZkc
         +xglxHVwr6gM5fDr1KzTkXdqzsh1+VqSWdQNYVXe8dNygiepxbcX3BokRMH6ugtK29p6
         l4jT5RcU6MyIlSj9CPRosiA5RElUCzKYn1/8P4GCnrI7EMmi2gfe+MjQ19glylaQlAP4
         36G3khDzTByCfrUsOyiWkxMh1bz57PWi+hIr2bJjiJJGQ/H1hBden5V9yK4Yo2xofQ+0
         /4kA==
X-Gm-Message-State: AOAM5333IXHL/FuBxIp/C8rADOWYNTLnv4PMtnFc1G92xRZPHGScOl9A
        EFRiboZnpjw9X0WEF5lSdjg=
X-Google-Smtp-Source: ABdhPJxtPRDPvaV3cgsV2pw22ZeYgKOcVkejOQJf9j0SAVHWLndno+CFpuzU/bu7wTZKoeh3u228Yw==
X-Received: by 2002:a17:90a:d515:: with SMTP id t21mr686001pju.149.1601004666336;
        Thu, 24 Sep 2020 20:31:06 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:31:05 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 4/8] arm64: dts: meson: remove fixed memory size for Khadas VIM3/VIM3L meson-khadas-vim3
Date:   Fri, 25 Sep 2020 11:30:13 +0800
Message-Id: <20200925033017.1790973-5-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925033017.1790973-1-art@khadas.com>
References: <20200925033017.1790973-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no need force setup memory size!
VIM3 boards have 2Gb and 4Gb variants
memory size will be automatically defined

mainline uboot works properly in any case
but old vendor uboot works not properly for 4Gb variants

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 7e137399257..3111bf35c0f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -20,10 +20,15 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+/*      no need force setup memory size!
+        VIM3 boards have 2Gb and 4Gb variants
+        memory size will be automatically defined
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+*/
 
 	adc-keys {
 		compatible = "adc-keys";
-- 
2.25.1

