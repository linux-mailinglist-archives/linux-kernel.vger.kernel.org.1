Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB871B7AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgDXP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgDXP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:56:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCDDC09B046;
        Fri, 24 Apr 2020 08:56:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so11467047wrv.10;
        Fri, 24 Apr 2020 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMnKTgYizjQYQHbi1ZpBIx1xnhgktjhs52v4GyB7fLQ=;
        b=HeP/cGfIyufIW9wiSVZASG+H8faBOnYGkZeuuX8lcrLV/RA+Z3hdVabjguxnzE2hH6
         IXVDrqtY22lJnHDNvkns4Ugr8C+8LkFPTVtovjS3HVOkP9GINr5fm2zQDi6nva/3s1kk
         zYY3/PU+Iek3YfHx+J8MiNhBMF74t4w9NV4VBjafsxEW6dVnO73qGQiNTwXWaDk9iVwq
         U/X32BMSa4JKryPjwsBMXqZxQwcgELoPwEzGtjRQ3GBtPXcopt5ysz2Syny0zdiHIkCJ
         rYgp9tZ7TYbhoq+eK/VqcmPchE/TCrrsMlnd9VXJfZSWzYWyxOKrJRv2EjemvCTHv0EQ
         mkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMnKTgYizjQYQHbi1ZpBIx1xnhgktjhs52v4GyB7fLQ=;
        b=dNBtDGoOb8Myed/a0v59Az14sPN1hRhoYEJqHtp5xhdx1WGxve7LUKPvtoztNujLLj
         XOmZV6suA6H8uZZGBC9nHK7g8RLFKUyTOjl2KwCWP5C3B/vKNgn/T/7+ossole5Agv7Z
         QhYU/64Gehd32jFuW6DvS3Ar3UdUKEuPSOribNvZLe+l0/gEg4NGG5JhQH990Bskws/C
         VITd7uQncDNDnRuUOuU+Gw9XoGmPk62XXDYjOBzW1kZi8OL0PbETI3nozKIgX5j2TXPs
         5JFhJq/U8TAyWbzMBca6Duku57r+v7gljXzXIWEKiU/Kk2XOFdc1mreVfIG5+nZF9TM/
         vyxg==
X-Gm-Message-State: AGi0PuYgdbmiat5K0rO/V8p4synvYBe0PpXlOaryky4FaEleRBa9hdYG
        2k6S4DRSf2Y+lN4Lv7b8MNLwCAWr
X-Google-Smtp-Source: APiQypIFGp2HYCo2gcn+YalZiUnrq9m/w4NKwBICcKEBQYFdnMqEa1TYJsHxg0LbWqA6+ptq476qnw==
X-Received: by 2002:adf:f750:: with SMTP id z16mr12537928wrp.115.1587743768929;
        Fri, 24 Apr 2020 08:56:08 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g69sm3554317wmg.17.2020.04.24.08.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:56:08 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: remove #sound-dai-cells from &spdif node of rk3399-hugsun-x99.dts
Date:   Fri, 24 Apr 2020 17:56:00 +0200
Message-Id: <20200424155600.24254-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200424155600.24254-1-jbx6244@gmail.com>
References: <20200424155600.24254-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '#sound-dai-cells' property is already defined in rk3399.dtsi
at the 'spdif' node, so remove it from the '&spdif' node in
'rk3399-hugsun-x99.dts'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index aee484a05..4b4a38e59 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -633,7 +633,6 @@
 &spdif {
 	status = "okay";
 	pinctrl-0 = <&spdif_bus_1>;
-	#sound-dai-cells = <0>;
 };
 
 &spi1 {
-- 
2.11.0

