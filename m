Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAA2FD223
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbhATN5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:57:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:54443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389875AbhATN3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149255;
        bh=T1WG2JWWyN/JFswUzhY+tG/U0WsnmyQs61DhHnQ1d3U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HSgjImhnrR1ec3+zvvAOKfNPrVgwaIBl0pWks4bvC/ucqWQrUS8CeBwePu8tgzOAz
         YkS4eX5GqZqJim7t+/jEjhsgXrHtGRx+gcjirZVHE12N18u+aYZbs9l8iVtH67VMX6
         f/9hCN6rPHSvbdLAVh/0AdkJxPJzdlRPTV8JhPmI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.204.192.78]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MIdiZ-1lGlj02bB7-00EaVW; Wed, 20 Jan 2021 14:27:35 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Subject: [RFC PATCH 5/7] arm64/Kconfig: Add Apple Silicon SoC platform
Date:   Wed, 20 Jan 2021 14:27:15 +0100
Message-Id: <20210120132717.395873-6-mohamed.mediouni@caramail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ig0OHEXnh4oqRZsZcOlPiTax0KhIOrYFEjmGGv5RQOOns/VYDxC
 CHvwEfHmdO9qKB/qOo/v+oI0Y3vT8puVXPsMd/TqcYYvPNWn7Qn1w73xdosDXnfGgbSEUqc
 igW9KWId7DcQP/9Birx5c279TcW2T9P53k44G9s0uDnCI+zvIa6bmT+x+1W+Jn0CqMkhLS3
 XcxMY2YwVSTIHWfz/SrUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wf4+WytWYtE=:RyEY2KxTqw2oDLvRHDWi6c
 YL/y4oAieJ4+hSL63FwvaCwjXhnx5xD8t44rvaa+TqDvNFNC473O6vFjgnjSOCYZL3831xUNx
 iklrhw6aeGbmZ6jxStA0+J6zdoY0ZcWreCuDnshK1Tvo0po2wzPNwlpQk9d63VaFSroH+rJhe
 Ev1zPOaO/OvArSGXUDIxFqOAgoys3ySbNbN07jUPek8XhthADGJrsoaliYYLvs8Z1x8kg13vM
 zOSdU2LeHjmGwuSVllwLx/aEumMkbxIW7egoslOZsdr4Mbo+CZjex7a1xEQ8PYu4mzUMeFoHg
 kTEJ1vL6GQxWtEhHJO+On8kTWo9Fw2m1OONTt2fmylTNen7Mdy1J2UEyGM5CW9GHqHMPoZEr0
 BqyGhzKWPaTqHQZMhdROKPGQUiEpgBoAm7aw1GX8PhI2NoKYny+BQ0/cOX2lgGQeHwUKn5p/E
 B9aNX9r9lQdR+4b7/Jd00D2NYOCAoF8Q2P7zNcrkpNK9T3tQA/3fVPxxG6RijLNdnqlJltjKK
 RyS/G8sWxswanOs7WnrOEym2APlkYUqI/eb3Yqa1Ghd21fA0FCTlOYbTrq2Cj4rkucEWy5igb
 UG9aguSVUpDGDyD+3ljwvJ5tNpT7/uGos+hi5Z/zMn8dK7sTZb3dLWSb6C3jSe3zQVrzwlP+k
 GxH+nmJKf31/s6WDrWC/jh26MlHfN0/rxps2EDDIe62CtPjgGhsd0Lcd4Dxt8hCvkFaAbH1HM
 gs4+lY0tCkG8ycNzywuYeDiZs/5KiRfL1SqqKNKURfALuf8cPkC7BqTz7BtGWXhIxHnK8NZpS
 +rZKB0eD0ZM6WMxw7T4rYKs9TGMMMT8zFdxYAdx4YC66NSFN0WSZWVleh04MtgZnmN8oc/z79
 1ZX5MLbrOgXEKwLS+X4Kzb5LRUY5wIyA1tevKhFr0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stan Skowronek <stan@corellium.com>

Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
=2D--
 arch/arm64/Kconfig.platforms | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6eecdef538bd..cc52519d4f67 100644
=2D-- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -328,4 +328,11 @@ config ARCH_ZYNQMP
 	help
 	  This enables support for Xilinx ZynqMP Family

+config ARCH_APPLE
+	bool "Apple Silicon SoC Family"
+	select APPLE_AIC
+	help
+	  This enables support for Apple processors present
+	  on Mac computers.
+
 endmenu
=2D-
2.29.2

