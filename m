Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A61DD655
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 20:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgEUSwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 14:52:33 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:53788 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgEUSwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:52:32 -0400
Received: from belgarion.home ([86.210.245.36])
        by mwinf5d28 with ME
        id hWsG220030nqnCN03WsWKT; Thu, 21 May 2020 20:52:31 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 21 May 2020 20:52:31 +0200
X-ME-IP: 86.210.245.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 2/3] MAINTAINERS: pxa: remove Compulab arm/pxa support
Date:   Thu, 21 May 2020 20:51:38 +0200
Message-Id: <20200521185140.27276-2-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521185140.27276-1-robert.jarzmik@free.fr>
References: <20200521185140.27276-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These boards support is removed from the kernel, so remove the
MAINTAINERS entry for them.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Mike Rapoport <rppt@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 091ec22c1a23..ad58388fa822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1684,11 +1684,6 @@ S:	Maintained
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git clkdev
 F:	drivers/clk/clkdev.c
 
-ARM/COMPULAB CM-X270/EM-X270 and CM-X300 MACHINE SUPPORT
-M:	Mike Rapoport <mike@compulab.co.il>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/CONEXANT DIGICOLOR MACHINE SUPPORT
 M:	Baruch Siach <baruch@tkos.co.il>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.26.2

