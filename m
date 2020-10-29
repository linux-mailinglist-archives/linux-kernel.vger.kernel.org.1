Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C749129E28A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbgJ2CUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbgJ2CUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:20:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDE8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n18so1106032wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7PoWxpHj9lcsas0MzwlL/XlGlfDoWtZtj4l25S2IlU=;
        b=UXoF46Gkv7ej+iTwFVP77OBd19qKe9sJOheKVV2aVEaBSBnhO4T4L3LryRrL92N04k
         MkyzTmM24VIdGB1rXmOTc0ay8c37VhCJEDp2BGsA6h2AT3l7FqPxdOjiYx13ix2SAzDC
         rIgzM3FDXDBEIF/NZWqwJVoC9dXRJqSirEH4H0RCN3whDN/PUwjppdpotM5ODNZWzieW
         MvB4r0EfRsN4m9DKS5MbE3yMoP16zTm8Yqbz8to0pTC8OyzhxqeZuNeabkGluw421163
         vmmqzIjAJ4ZbdEXdNN9vJVq0HzqcVDAyb4r5XXnOMlB7z6sKStlirQc5qidsC5yv/9SB
         pC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7PoWxpHj9lcsas0MzwlL/XlGlfDoWtZtj4l25S2IlU=;
        b=LRtdC8QKkGCI1VSlqmxNgV38HSxtYa1QpaTYtIN/Vf618+GYDcuNynRsKU3KRUl/zU
         XkYjf26u3v6W9JPCtvGHj8AS6h9Hc2QomvJoTZoXkXjhvYlBj5p/OxZZXQE22Gj9hkXo
         pZTmTWJm4k+lgDG5Tf0O+rESHf8pP39KtMwznV7GW5OO843iux055C86GzLUSUO8YxY1
         kKbamMe0hfv/z6khjdYcWpH3+C7JJ+lD0nkaOv+OrAnw+P5rDGUlrE4CmWP/xMsQvxq3
         JVSW8Fw4s0cO/0YvvUp+6rAq/0Gl7GVUsVnm5vFO9ljlLYYKlN+pBqscj04jdXvXZ6b9
         zZXQ==
X-Gm-Message-State: AOAM531qM/JOxuOeTbzs4xP2ndCMneQZRmZv0qVhkZLXIZgzK9j0N+2y
        RMIgN2ViUPoIBliXL067Zlc=
X-Google-Smtp-Source: ABdhPJwNa+iNJex9oacB2NdVXTl6xjPjJmbT47oXTsdzBL5SfU6Z3y2sqwysbUB1S4D8BHkFlD6m/A==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr2474202wrs.131.1603938030155;
        Wed, 28 Oct 2020 19:20:30 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id m4sm2138937wrr.47.2020.10.28.19.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:20:29 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH 2/5] ARM: dts: sun8i: V3/S3: Add UART1 pin definitions to the V3/S3 dtsi
Date:   Thu, 29 Oct 2020 02:19:57 +0000
Message-Id: <20201029022000.601913-3-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3 and S3 can use PG6/7 as RX/TX for UART1. Since no other
functions are assigned to those pins, they are a convenient choice for
a debugging or application UART.
This is specific to V3/S3 as the V3s's non-BGA package did not have
those pins.

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 arch/arm/boot/dts/sun8i-v3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
index ca4672ed2e02..c279e13583ba 100644
--- a/arch/arm/boot/dts/sun8i-v3.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3.dtsi
@@ -24,4 +24,9 @@
 
 &pio {
 	compatible = "allwinner,sun8i-v3-pinctrl";
+
+	uart1_pg_pins: uart1-pg-pins {
+		pins = "PG6", "PG7";
+		function = "uart1";
+	};
 };
-- 
2.20.1

