Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F5A2A198F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgJaS2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 14:28:52 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:55516 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgJaS2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 14:28:48 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 84688C01E4;
        Sat, 31 Oct 2020 19:22:19 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id D68CFC1D75; Sat, 31 Oct 2020 19:22:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE autolearn=no
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (unknown [192.168.1.101])
        by gagarine.paulk.fr (Postfix) with ESMTP id 4B0A3C1D65;
        Sat, 31 Oct 2020 19:21:54 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/9] ARM: sunxi: Add machine match for the Allwinner V3 SoC
Date:   Sat, 31 Oct 2020 19:21:29 +0100
Message-Id: <20201031182137.1879521-2-contact@paulk.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182137.1879521-1-contact@paulk.fr>
References: <20201031182137.1879521-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3 SoC shares the same base as the V3s but comes with
extra pins and features available. As a result, it has its dedicated
compatible string (already used in device trees), which is added here.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/mach-sunxi/sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 06da2747a90b..19635721013d 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -66,6 +66,7 @@ static const char * const sun8i_board_dt_compat[] = {
 	"allwinner,sun8i-h2-plus",
 	"allwinner,sun8i-h3",
 	"allwinner,sun8i-r40",
+	"allwinner,sun8i-v3",
 	"allwinner,sun8i-v3s",
 	NULL,
 };
-- 
2.28.0

